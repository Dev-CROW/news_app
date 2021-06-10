import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search_screen.dart';
import 'package:news_app/shared/components/components.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';


class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return  Scaffold(
          appBar: AppBar(title: Text("News App"),
          actions: [
            IconButton(icon: Icon(Icons.search), onPressed: (){navigateTo(context, SearchScreen());}),
            IconButton(icon: Icon(Icons.brightness_4_outlined), onPressed: (){
              cubit.changeAppMode();
            }),
          ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeNavBarIndex(index);
            },
            items: cubit.bottombaritems,
          ),
        );
      },
    );
  }
}
