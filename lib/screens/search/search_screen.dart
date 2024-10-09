import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_1/cubit/app_cubit.dart';
import 'package:flutter_project_1/cubit/app_states.dart';

class SearchPage extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Users'),
      ),
      body: BlocProvider(
        create: (context) => AppCubit(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: (value){
                  context.read<AppCubit>().searchUsersByName(value);
                },
                decoration: const InputDecoration(
                  labelText: 'Enter name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<AppCubit, AppStates>(
                builder: (context, state) {
                  if (state is UserSearchLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is UserSearchSuccessState) {
                    return ListView.builder(
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        final user = state.users[index];
                        return ListTile(
                          title: Text(user.name),
                          subtitle: Text('Email: ${user.userId}'),
                        );
                      },
                    );
                  } else if (state is UserSearchFailedState) {
                    return Center(
                      child: Text('Error: ${state.error}'),
                    );
                  } else {
                    return const Center(child: Text('No results'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}