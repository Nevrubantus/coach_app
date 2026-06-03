import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_config.dart';

const userImageKey = 'user_image';
const userImageScaleKey = 'user_image_scale';
const userImageOffsetXKey = 'user_image_offset_x';
const userImageOffsetYKey = 'user_image_offset_y';
const profileAvatarFrameRadius = 55.0;

class AvatarFrame {
  final double scale;
  final double offsetX;
  final double offsetY;

  const AvatarFrame({
    required this.scale,
    required this.offsetX,
    required this.offsetY,
  });
}

class EditableProfileAvatar extends StatefulWidget {
  final double radius;
  final Color cameraColor;
  final VoidCallback? onChanged;
  final ValueChanged<bool>? onDraggingChanged;
  final Future<String?> Function(String fileName, String base64Data)?
  onImagePicked;
  final Future<void> Function()? onImageRemoved;

  const EditableProfileAvatar({
    super.key,
    this.radius = 55,
    this.cameraColor = const Color(0xFF3D76E4),
    this.onChanged,
    this.onDraggingChanged,
    this.onImagePicked,
    this.onImageRemoved,
  });

  @override
  State<EditableProfileAvatar> createState() => EditableProfileAvatarState();
}

class EditableProfileAvatarState extends State<EditableProfileAvatar> {
  String? _imagePath;
  double _scale = 1;
  double _offsetX = 0;
  double _offsetY = 0;
  double _gestureStartScale = 1;
  double _pinchStartDistance = 1;
  bool _isEditing = false;
  bool _isDragging = false;
  final Map<int, Offset> _pointers = {};

  @override
  void initState() {
    super.initState();
    _loadAvatar();
  }

  void finishEditing() {
    if (mounted) setState(() => _isEditing = false);
  }

  bool get hasImage => _imagePath != null;

  AvatarFrame get frame => AvatarFrame(
    scale: _scale,
    offsetX: _offsetX,
    offsetY: _offsetY,
  );

  Future<void> _loadAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;

    setState(() {
      _imagePath = prefs.getString(userImageKey);
      _scale = (prefs.getDouble(userImageScaleKey) ?? 1)
          .clamp(0.5, 4.0)
          .toDouble();
      _offsetX = prefs.getDouble(userImageOffsetXKey) ?? 0;
      _offsetY = prefs.getDouble(userImageOffsetYKey) ?? 0;
    });
  }

  Future<void> _saveAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = _imagePath;

    if (imagePath == null) {
      await prefs.remove(userImageKey);
      await prefs.remove(userImageScaleKey);
      await prefs.remove(userImageOffsetXKey);
      await prefs.remove(userImageOffsetYKey);
      return;
    }

    await prefs.setString(userImageKey, imagePath);
    await prefs.setDouble(userImageScaleKey, _scale);
    await prefs.setDouble(userImageOffsetXKey, _offsetX);
    await prefs.setDouble(userImageOffsetYKey, _offsetY);
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile == null) return;

    setState(() {
      _imagePath = pickedFile.path;
      _scale = 1;
      _offsetX = 0;
      _offsetY = 0;
      _isEditing = true;
    });
    widget.onChanged?.call();
    await _saveAvatar();

    final upload = widget.onImagePicked;
    if (upload == null) return;

    final remotePath = await upload(
      pickedFile.name,
      base64Encode(await pickedFile.readAsBytes()),
    );
    if (!mounted || remotePath == null || remotePath.trim().isEmpty) return;

    setState(() => _imagePath = remotePath.trim());
    await _saveAvatar();
  }

  Future<void> _removeAvatar() async {
    setState(() {
      _imagePath = null;
      _scale = 1;
      _offsetX = 0;
      _offsetY = 0;
      _isEditing = false;
    });
    widget.onChanged?.call();
    await _saveAvatar();
    await widget.onImageRemoved?.call();
  }

  Future<void> _showImageActions() async {
    final action = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_rounded),
              title: const Text('Выбрать другое фото'),
              onTap: () => Navigator.of(context).pop('pick'),
            ),
            ListTile(
              leading: const Icon(
                Icons.delete_outline_rounded,
                color: Colors.redAccent,
              ),
              title: const Text(
                'Удалить фото',
                style: TextStyle(color: Colors.redAccent),
              ),
              onTap: () => Navigator.of(context).pop('delete'),
            ),
          ],
        ),
      ),
    );

    if (action == 'pick') {
      await _pickImage();
    } else if (action == 'delete') {
      await _removeAvatar();
    }
  }

  void _startEditing() {
    if (_imagePath != null) setState(() => _isEditing = true);
  }

  void _setDragging(bool value) {
    if (_isDragging == value) return;
    widget.onDraggingChanged?.call(value);
    setState(() => _isDragging = value);
  }

  void _onPointerDown(PointerDownEvent event) {
    if (_imagePath == null) return;

    _pointers[event.pointer] = event.localPosition;
    if (_pointers.length == 2) {
      _gestureStartScale = _scale;
      _pinchStartDistance = _firstTwoPointerDistance();
    }
    _setDragging(true);
    setState(() => _isEditing = true);
  }

  void _onPointerMove(PointerMoveEvent event) {
    if (!_pointers.containsKey(event.pointer)) return;

    _pointers[event.pointer] = event.localPosition;
    if (_pointers.length >= 2) {
      final distance = _firstTwoPointerDistance();
      setState(() {
        _scale = (_gestureStartScale * distance / _pinchStartDistance)
            .clamp(0.5, 4.0)
            .toDouble();
      });
      widget.onChanged?.call();
      return;
    }

    final nextOffset = Offset(_offsetX, _offsetY) + event.delta;
    setState(() {
      _offsetX = nextOffset.dx;
      _offsetY = nextOffset.dy;
    });
    widget.onChanged?.call();
  }

  void _onPointerEnd(PointerEvent event) {
    _pointers.remove(event.pointer);
    if (_pointers.length < 2) {
      _gestureStartScale = _scale;
      _pinchStartDistance = 1;
    }
    if (_pointers.isEmpty) {
      _setDragging(false);
      _saveAvatar();
    }
  }

  double _firstTwoPointerDistance() {
    final positions = _pointers.values.take(2).toList();
    if (positions.length < 2) return 1;
    return (positions[0] - positions[1]).distance
        .clamp(1.0, double.infinity)
        .toDouble();
  }

  void _setScale(double scale) {
    setState(() {
      _scale = scale.clamp(0.5, 4.0).toDouble();
      _isEditing = true;
    });
    widget.onChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = _imagePath != null;

    return Column(
      children: [
        Stack(
          children: [
            Listener(
              onPointerDown: hasImage ? _onPointerDown : null,
              onPointerMove: hasImage ? _onPointerMove : null,
              onPointerUp: hasImage ? _onPointerEnd : null,
              onPointerCancel: hasImage ? _onPointerEnd : null,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: hasImage ? _startEditing : _pickImage,
                child: AvatarPreview(
                  imagePath: _imagePath,
                  radius: widget.radius,
                  frameRadius: widget.radius,
                  scale: _scale,
                  offsetX: _offsetX,
                  offsetY: _offsetY,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: hasImage ? _showImageActions : _pickImage,
                child: CircleAvatar(
                  backgroundColor: widget.cameraColor,
                  radius: 18,
                  child: const Icon(
                    Icons.camera_alt,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (hasImage && _isEditing) ...[
          const SizedBox(height: 14),
          SizedBox(
            width: 230,
            child: Slider(
              value: _scale,
              min: 0.5,
              max: 4,
              onChanged: _setScale,
              onChangeEnd: (_) => _saveAvatar(),
            ),
          ),
        ],
      ],
    );
  }
}

class AvatarPreview extends StatelessWidget {
  final String? imagePath;
  final double radius;
  final double scale;
  final double offsetX;
  final double offsetY;
  final double frameRadius;
  final String? fallbackText;

  const AvatarPreview({
    super.key,
    required this.imagePath,
    required this.radius,
    required this.scale,
    required this.offsetX,
    required this.offsetY,
    this.frameRadius = profileAvatarFrameRadius,
    this.fallbackText,
  });

  @override
  Widget build(BuildContext context) {
    final path = imagePath;
    final size = radius * 2;
    final offsetFactor = frameRadius <= 0 ? 1.0 : radius / frameRadius;

    if (path == null || path.trim().isEmpty) return _fallback();

    return ClipOval(
      child: Container(
        width: size,
        height: size,
        color: Colors.blue.shade50,
        child: Transform.translate(
          offset: Offset(offsetX * offsetFactor, offsetY * offsetFactor),
          child: Transform.scale(
            scale: scale,
            child: _imageFor(path, size),
          ),
        ),
      ),
    );
  }

  Widget _imageFor(String path, double size) {
    final file = File(path);
    if (file.existsSync()) {
      return Image.file(
        file,
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => _fallback(),
      );
    }

    if (_isFullUrl(path)) {
      return _networkImage(path, size);
    }

    return FutureBuilder<String>(
      future: resolveWebServerUrl(),
      builder: (context, snapshot) {
        final baseUrl = snapshot.data;
        if (baseUrl == null) return _fallback();

        final imageUrl = Uri.parse(baseUrl).resolve(path).toString();
        return _networkImage(imageUrl, size);
      },
    );
  }

  Widget _networkImage(String url, double size) {
    return Image.network(
      url,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => _fallback(),
    );
  }

  Widget _fallback() {
    final text = fallbackText?.trim();
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.blue.shade50,
      child: text == null || text.isEmpty
          ? Icon(
              Icons.person,
              size: radius,
              color: const Color(0xFF3D76E4),
            )
          : Text(
              text,
              style: TextStyle(
                color: const Color(0xFF3D76E4),
                fontSize: radius * 0.52,
                fontWeight: FontWeight.w800,
              ),
            ),
    );
  }

  bool _isFullUrl(String path) {
    return path.startsWith('http://') || path.startsWith('https://');
  }
}
