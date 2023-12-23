import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wallpaper_api_intro_46/api/api_helper.dart';
import 'package:wallpaper_api_intro_46/api/urls.dart';
import 'package:wallpaper_api_intro_46/model/data_wallpaper_model.dart';

part 'wallpaper_event.dart';
part 'wallpaper_state.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  ApiHelper apiHelper;
  WallpaperBloc({required this.apiHelper}) : super(WallpaperInitialState()) {
    on<GetTrendingWallpaper>((event, emit) async{
      // TODO: implement event handler
      emit(WallpaperLoadingState());


      try {
        var res = await apiHelper.getApi("${Urls.trendingUrl}?per_page=20");
        emit(WallpaperLoadedState(mData: DataWallPaperModel.fromJson(res)));
      }catch(e){
        emit(WallpaperErrorState(errorMsg: e.toString()));
      }

      //
      // if(res!=null){
      //   emit(WallpaperLoadedState(mData: DataWallPaperModel.fromJson(res)));
      // }else{
      //   emit(WallpaperErrorState(errorMsg: "Internet Error"));
      // }
      //

    });

    on<GetSearchWallpaper>((event, emit)async {
      emit(WallpaperLoadingState());
      var res = await apiHelper.getApi("${Urls.searchUrl}?query=${event.query}&per_page=20");

      if(res!=null){
        emit(WallpaperLoadedState(mData: DataWallPaperModel.fromJson(res)));
      }else{
        emit(WallpaperErrorState(errorMsg: "Internet Error"));
      }


    });

  }
}
