import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_app/cubits/albums/album_cubit.dart';
import 'package:gallery_app/cubits/auth/auth_cubit.dart';
import 'package:gallery_app/data/repositories/album_repository.dart';
import 'package:gallery_app/data/repositories/auth_repository.dart';
import 'data/models/user.dart';
import 'presentation/homeScreen/home_screen.dart';
import 'presentation/AuthScreen/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(AuthRepository())),
        BlocProvider(
            create: (context) => AlbumCubit(
                AlbumRepository(), context.read<AuthCubit>().state.token)
              ..getAlbum()),
      ],
      child: const _MyApp(),
    );
  }
}

class _MyApp extends StatefulWidget {
  const _MyApp();

  @override
  State<_MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<_MyApp> {
  String _savedtoken = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: _savedtoken.isEmpty
          ? const LogInScreen()
          : HomeScreen(
              user: User(),
            ),
    );
  }
}
