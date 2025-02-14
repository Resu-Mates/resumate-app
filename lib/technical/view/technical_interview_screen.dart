import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

final selectedFileProvider = StateProvider<File?>((ref) => null);

class TechnicalScreen extends ConsumerStatefulWidget {
  static String get routeName => 'technical';

  const TechnicalScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TechnicalScreenState();
}

class _TechnicalScreenState extends ConsumerState<TechnicalScreen> {
  Future<void> _pickFile() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? result = await picker.pickMedia();

      if (result != null) {
        File file = File(result.path);
        ref.read(selectedFileProvider.notifier).state = file;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('파일 선택 중 오류가 발생했습니다: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedFile = ref.watch(selectedFileProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'PDF파일을 첨부해 주세요!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(height: 24),
                GestureDetector(
                  onTap: _pickFile,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange, width: 2),
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.orange.withOpacity(0.05),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.file_copy, size: 72, color: Colors.orange),
                        SizedBox(height: 16),
                        Text(
                          selectedFile != null
                              ? selectedFile.path.split('/').last
                              : '파일을 추가해 주세요',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: selectedFile != null ? () {
                    // TODO: 파일이 선택되었을 때 AI 면접 시작 로직 구현
                  } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'AI면접 시작하기',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}