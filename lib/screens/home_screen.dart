import 'package:flutter/material.dart';
import 'package:prj_wisatacandi_si51/data/candi_data.dart';
import 'package:prj_wisatacandi_si51/models/candi.dart';
import 'package:prj_wisatacandi_si51/widgets/item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO : 1. buat appbar dengan judul wisata candi
      appBar: AppBar(
        title: const Text('Wisata Candi'),
      ),
      // TODO : 2. buat body dengan Gridview.builder
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        padding: const EdgeInsets.all(8),
        itemCount: candiList.length,
        itemBuilder: (context, index) {
          Candi candi = candiList[index];
          return ItemCard(candi: candi);
        },
      ),
      // TODO : 3. buat itemcard sebagai return value dari Gridview.builder
    );
  }
}
