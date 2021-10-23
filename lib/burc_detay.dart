import 'package:flutter/material.dart';
import 'package:flutter_burclar/model/burc.dart';
import 'package:palette_generator/palette_generator.dart';

class BurcDetay extends StatefulWidget {
  final Burc secilenBurc;
  const BurcDetay({required this.secilenBurc, Key? key}) : super(key: key);

  @override
  State<BurcDetay> createState() => _BurcDetayState();
}

class _BurcDetayState extends State<BurcDetay> {
  Color appbarRengi = Colors.transparent;
  late PaletteGenerator _generator;

  @override
  void initState() {
    super.initState();
    print("init state çalıştı");
    WidgetsBinding.instance!.addPostFrameCallback((_) => appbarRenginiBul());
  }

  @override
  Widget build(BuildContext context) {
    print("build çalıştı");
    return Scaffold(
      primary: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: appbarRengi,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset('images/' + widget.secilenBurc.burcBuyukResim, fit: BoxFit.cover),
              title: Text(widget.secilenBurc.burcAdi + " Burcu ve Özellikleri"),
              centerTitle: true,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(5),
              child: SingleChildScrollView(
                child: Text(widget.secilenBurc.burcDetay, style: Theme.of(context).textTheme.subtitle1),
              ),
            ),
          )
        ],
      ),
    );
  }

  void appbarRenginiBul() async {
    print("build bitti baskın renk bulunacak");
    _generator = await PaletteGenerator.fromImageProvider(AssetImage('images/' + widget.secilenBurc.burcBuyukResim));

    appbarRengi = _generator.dominantColor!.color;
    print("baskın renk bulundu");

    setState(() {});
  }
}
