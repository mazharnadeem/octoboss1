// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:octo_boss/api/data_event.dart';
// import 'package:octo_boss/api/settings_api.dart';
// import 'package:octo_boss/screens/user/Customer/home/customer_home_screen_state.dart';

// class HomeScreenBloc extends Cubit<HomeScreenState> {
//   WebServices webServices = WebServices.instance();
//   int c =0;

//   HomeScreenBloc() : super(HomeScreenState.initial()) {
//     c++;
//     print('aaaaa');
//     print(c);
//     homeBannersApi();
//     homeServicesApi();
//   }

//   Future homeBannersApi() async {
//     try {
//       emit(state.copyWith(bannerDataEvent: Loading()));
//       final response = await webServices.homeBanners();
//       emit(state.copyWith(bannerDataEvent: ResponseData(data: response)));
//     } catch (e) {}
//   }

//   Future homeServicesApi() async {
//     try {
//       emit(state.copyWith(serviceDataEvent: Loading()));
//       final response = await webServices.services();
//       emit(state.copyWith(serviceDataEvent: ResponseData(data: response)));
//     } catch (e) {}
//   }
// }
