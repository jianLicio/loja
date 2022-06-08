import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loja/models/carrinho.dart';
import 'package:loja/models/produto_lista.dart';
import 'package:loja/pages/carrinho_pagina.dart';
import 'package:loja/pages/produto_detalhe_pagina.dart';
import 'package:loja/pages/produtos_overview.page.dart';
import 'package:loja/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProdutoLista(),
        ),
        ChangeNotifierProvider(
          create: (_) => Carrinho(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.purple,
          ).copyWith(
            secondary: Colors.deepOrange,
          ),
          textTheme: GoogleFonts.acmeTextTheme(),
          primaryTextTheme: GoogleFonts.oleoScriptSwashCapsTextTheme(),
        ),
        home: const ProdutosOverviewPage(),
        routes: {
          AppRoutes.produtoDetail: ((context) => const ProdutoDetalhePagina()),
          AppRoutes.carrinho: ((context) => const CarrinhoPagina()),
        },
      ),
    );
  }
}
