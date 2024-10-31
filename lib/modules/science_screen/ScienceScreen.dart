import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/Components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';


class ScienceScreen extends StatelessWidget {
  const ScienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var list = AppCubit.get(context).science;
              return customListBuilder(list, context);
            }));
  }
}
