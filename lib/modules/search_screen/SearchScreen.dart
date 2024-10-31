import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/Components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = AppCubit.get(context).search;
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  customSearchBar(
                    hint: 'Search',
                    controller: searchController,
                    onChange: (value) {
                      AppCubit.get(context).getSearch(query: value);
                    },
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Search Field must not be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10,),
                  Expanded(child: customListBuilder(list, context,isSearch: true))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
