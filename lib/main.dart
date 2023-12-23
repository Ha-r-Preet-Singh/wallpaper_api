import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_api_intro_46/api/api_helper.dart';
import 'package:wallpaper_api_intro_46/bloc/wallpaper_bloc.dart';
import 'package:wallpaper_api_intro_46/model/data_wallpaper_model.dart';

void main() {
  runApp(BlocProvider(create: (context) => WallpaperBloc(apiHelper: ApiHelper()),
    child:  MyApp(),
  ));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<WallpaperBloc>().add(GetTrendingWallpaper());
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WallpaperBloc,WallpaperState>(

      builder: (context, state) {
        if(state is WallpaperLoadingState){
          return Center(child: CircularProgressIndicator(),);
        }else if(state is WallpaperErrorState){
          return Center(
            child: Text(state.errorMsg),
          );
        }else{
          if(state is WallpaperLoadedState){
            return GridView.builder(
                  itemCount: state.mData.photos!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 9/16,
                    ),
                    itemBuilder: (_, index) {
                    return  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21),
                        image: DecorationImage(
                          image: NetworkImage(state.mData.photos![index].src!.portrait!),fit: BoxFit.cover,
                        ),
                      ),
                    );

                    },
                );


            }
          return Container();
          }

        }

    );
  }
}























// }
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   late Future<DataWallPaperModel> wallpaper;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//    wallpaper =  getWallPaper();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Wallcano"),
//       ),
//       body: FutureBuilder<DataWallPaperModel>(
//         future: wallpaper,
//         builder: (_, snapshot) {
//           if(snapshot.connectionState==ConnectionState.waiting){
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }else if (snapshot.hasError){
//             return Center(
//               child: Text("WallPaper is not available"),
//             );
//
//           }else{
//             if(snapshot.hasData){
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: GridView.builder(
//                   itemCount: snapshot.data!.photos!.length,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       mainAxisSpacing: 10,
//                       crossAxisSpacing: 10,
//                       childAspectRatio: 9/16,
//                     ),
//                     itemBuilder: (_, index) {
//                     return  Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(21),
//                         image: DecorationImage(
//                           image: NetworkImage(snapshot.data!.photos![index].src!.portrait!),fit: BoxFit.cover,
//                         ),
//                       ),
//                     );
//
//                     },
//                 ),
//               );
//             }
//           }
//           return Container();
//
//         },
//
//
//       ),
//     );
//   }
//
//  Future<DataWallPaperModel> getWallPaper()async{
//     String url = "https://api.pexels.com/v1/search?query=nature&per_page=10";
//    var res = await  http.get(Uri.parse(url),headers: {"Authorization":"ccEI7ea5vTWvcypWjTBtmnSVnyGSW9pUpX910XJEbYsJI0We4U08zfRt"});
//   if (res.statusCode==200){
//     var mData = jsonDecode(res.body);
//   return  DataWallPaperModel.fromJson(mData);
//   }else{
//     return DataWallPaperModel();
//   }
//
//   }
//
//
//
// }
