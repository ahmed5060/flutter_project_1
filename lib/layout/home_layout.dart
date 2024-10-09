import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_1/components/components.dart';
import 'package:flutter_project_1/cubit/app_cubit.dart';
import 'package:flutter_project_1/cubit/app_states.dart';

class HomeLayout extends StatefulWidget {
  final AppCubit cubb;

  const HomeLayout({super.key, required this.cubb});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> with WidgetsBindingObserver {
  final String userId = "22010237";

  // bool isMe = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Set the user as online when the app starts
    widget.cubb.setUserOnline(userId);

    // Handle the disconnection case
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Mark user as offline when the app goes to background
      widget.cubb.setUserOffline(userId);
    } else if (state == AppLifecycleState.resumed) {
      // Mark user as online when the app is resumed
      widget.cubb.setUserOnline(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: const Text("ChatApp"),
          actions: [
            IconButton(
                onPressed: () {
                  widget.cubb.changeScreen(3);
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 75,
                height: double.infinity,
                padding: const EdgeInsetsDirectional.only(end: 20, start: 5),
                decoration: const BoxDecoration(
                    // border: BorderDirectional(
                    //     end: BorderSide(
                    //         style: BorderStyle.none, color: Colors.black)
                    //         )

                    ),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    SideNavigationBarItem(
                      fun: () {
                        widget.cubb.changeScreen(0);
                      },
                      icon: Icons.chat,
                      label: "Chats",
                      isSelected: widget.cubb.selectedIndex == 0,
                    ),
                    const SizedBox(height: 15),
                    SideNavigationBarItem(
                      fun: () {
                        widget.cubb.changeScreen(1);
                      },
                      icon: Icons.person,
                      label: "Users",
                      isSelected: widget.cubb.selectedIndex == 1,
                    ),
                    const SizedBox(height: 15),
                    SideNavigationBarItem(
                      fun: () {
                        widget.cubb.changeScreen(2);
                      },
                      icon: Icons.update,
                      label: "Stories",
                      isSelected: widget.cubb.selectedIndex == 2,
                    ),
                    const SizedBox(height: 15),
                    // IconButton(
                    //     onPressed: () {
                    //       setState(() {
                    //         userId = isMe ? "22010237" : "22010289";
                    //         isMe = !isMe;
                    //         print(userId);
                    //       });
                    //     },
                    //     icon: const Icon(Icons.swap_calls))
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 9, // Expands the shadow
                        blurRadius: 2, // Smoothens the shadow
                        offset: const Offset(
                            5, 6), // Controls the shadow's position
                      )
                    ],
                    border: Border.all(color: Colors.yellow.shade900, width: 3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: widget.cubb.pages[widget.cubb.selectedIndex],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
