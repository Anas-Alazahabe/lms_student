import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/features/home/presentation/manager/bookmark_cubit/fetch_mark_cubit.dart';
import 'package:lms_student/features/subject_data/data/models/units_model/unit.dart';
import 'package:lms_student/features/subject_data/presentation/views/widgets/unit_list_view_item.dart';

class UnitsListView extends StatefulWidget {
  final String subjectId;
  final Unitt units;
  final String subjectName;
  const UnitsListView({
    super.key,
    required this.units,
    required this.subjectName,
    required this.subjectId,
  });

  @override
  State<UnitsListView> createState() => _UnitsListViewState();
}

class _UnitsListViewState extends State<UnitsListView> {
  @override
  void initState() {
    super.initState();
    // BlocProvider.of<FetchBookMarkCubit>(context).get();
  }

  @override
  Widget build(BuildContext context) {
    return widget.units.data!.isEmpty
        ? const Text('لا يوجد وحدات')
        : ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.units.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return UnitListViewItem(
                unit: widget.units.data![index],
                subjectName: widget.subjectName, subjectId: widget.subjectId,
                // subjectName: subjectName,
                // subjectId: subjectId,
              );
            },
          );
  }
}
