// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lms_student/core/widgets/custom_loading.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'widgets/folders_screen.dart';

class DownloadVeiw extends StatefulWidget {
  const DownloadVeiw({super.key});

  @override
  State<DownloadVeiw> createState() => _DownloadVeiwState();
}

Future<List<Directory>> getCategories() async {
  final dir = await getApplicationDocumentsDirectory();
  return dir
      .listSync()
      .whereType<Directory>()
      .where((directory) {
        return (p.basename(directory.path) != 'flutter_assets') &&
            (p.basename(directory.path) != 'hydrated_bloc');
      })
      .cast<Directory>()
      .toList();
}
//final authorizeCubit = getIt<AuthorizeCubit>();

num persentage = 0;

class _DownloadVeiwState extends State<DownloadVeiw> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('التحميلات'),
      ),
      body: Column(
        children: [
          Expanded(
            child:
                // authorizeCubit.state==false?
                //    Center(child: Text('سجل الدخول لتتمكن من الوصول للتحميلات'));
                FutureBuilder<List<Directory>>(
              future: getCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CustomLoading();
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.data!.isEmpty) {
                    return const Center(child: Text('لا يوجد تحميلات'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            //  elevation: 10,
                            child: ListTile(
                              leading: const Icon(Icons.folder_copy_rounded),
                              title:
                                  Text(p.basename(snapshot.data![index].path)),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FoldersScreen(
                                        directory: snapshot.data![index]),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          )
        ],
      ),
    ));
  }
}
