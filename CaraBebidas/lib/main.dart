import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'providers/bebida_provider.dart';
import 'ui/screens/bebida_list_screen.dart';
import 'ui/screens/bebida_form_screen.dart';
import 'models/bebida.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => BebidaProvider()..fetchBebidas(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const BebidaListScreen(),
        ),
        GoRoute(
          path: '/form',
          builder: (context, state) =>
              BebidaFormScreen(bebidaParaEdicao: state.extra as Bebida?),
        ),
      ],
    );

    return MaterialApp.router(
      routerConfig: _router,
      title: 'Repositório de Bebidas',
      theme: ThemeData(primarySwatch: Colors.amber),
    );
  }
}
