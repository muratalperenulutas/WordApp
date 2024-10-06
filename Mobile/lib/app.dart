import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:word_app/my_app_body.dart';
import 'package:word_app/side_menu_panel.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
      

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: Get.find<AppController>().isDarkTheme.value?ThemeData.dark():ThemeData.light(),

      
      home:Scaffold(backgroundColor: Colors.grey[600],appBar: AppBar(title: Text("Word App",) ,toolbarHeight:screenHeight*0.06,
      leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
    
      
      ),
    drawer: SideMenuPanel(),
      body: MyAppBody(),
    )
    );
  }
}


