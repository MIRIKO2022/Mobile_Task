import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker imagePicker = ImagePicker();
  File? selectedImage;

  Future<void> imageSelector(ImageSource src) async {
    final xfile = await imagePicker.pickImage(source: src);
    if (xfile != null && mounted) {
      setState(() => selectedImage = File(xfile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Column(
        children: [
          SizedBox(height: 24),
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey.shade200,
                  child: selectedImage == null
                      ? Icon(Icons.person, size: 80)
                      : ClipOval(
                    child: Image.file(
                      selectedImage!,
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 25,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt, size: 28, color: Colors.grey),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) => _buildImageOptions(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageOptions() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 12),
        Text("Choose Photo", style: TextStyle(fontSize: 18)),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _OptionButton(
              icon: Icons.camera_alt,
              label: "Camera",
              onTap: () {
                Navigator.pop(context);
                imageSelector(ImageSource.camera);
              },
            ),
            _OptionButton(
              icon: Icons.image,
              label: "Gallery",
              onTap: () {
                Navigator.pop(context);
                imageSelector(ImageSource.gallery);
              },
            ),
            if (selectedImage != null)
              _OptionButton(
                icon: Icons.delete,
                label: "Delete",
                color: Colors.red,
                onTap: () {
                  Navigator.pop(context);
                  setState(() => selectedImage = null);
                },
              ),
          ],
        ),
        SizedBox(height: 12),
      ],
    );
  }
}

class _OptionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback onTap;
  const _OptionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: color ?? Colors.grey),
          onPressed: onTap,
        ),
        Text(label),
      ],
    );
  }
}
