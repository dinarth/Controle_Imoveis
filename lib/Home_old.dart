import 'package:controle_lote/login_screen.dart';
import 'package:controle_lote/model/Usuario.dart';
import 'package:controle_lote/widget/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:controle_lote/PrimeiraPagina.dart';
import 'package:controle_lote/SegundaPagina.dart';

import 'package:scoped_model/scoped_model.dart';

import 'model/Terreno.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final _pageController = PageController();
  Usuario usuario = new Usuario();
  TabController _tabController;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<Usuario>(
      builder: (context, child, model) {
        if (model.isLoading)
          return Center(
            child: CircularProgressIndicator(),
          );
        return Scaffold(

          appBar: AppBar(
            centerTitle: true,
            title: Text("Controle de Terrenos"),
            bottom: TabBar(
              controller: _tabController,

              tabs: <Widget>[
                Tab(
                  text: "Listar",
                  icon: Icon(Icons.list),
                ),
                Tab(
                  text: "Cadastrar",
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[SegundaPagina(), PrimeiraPagina()],
          ),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: FloatingActionButton(
            onPressed: _sair,
          ),
        );
        },

    );
  }

  void _sair() {
    Usuario usuario = new Usuario();
    usuario.signOut();

    Future.delayed(Duration(milliseconds: 0)).then((_) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }
}
