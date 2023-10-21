import 'package:flutter/material.dart';
import 'package:prj_wisatacandi_si51/models/candi.dart';

class DetailScreen extends StatelessWidget {
  final Candi candi;

  const DetailScreen({super.key, required this.candi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    candi.imageAsset,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.purpleAccent.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      candi.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.place,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const SizedBox(
                      width: 78,
                      child: Text(
                        'Lokasi',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      ': ${candi.location}',
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const SizedBox(
                      width: 78,
                      child: Text(
                        'Dibangun',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      ': ${candi.built}',
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.house,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const SizedBox(
                      width: 78,
                      child: Text(
                        'Tipe',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      ': ${candi.type}',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Divider(
                  color: Colors.deepPurple.shade100,
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  color: Colors.deepPurple.shade100,
                ),
                const Text(
                  'Galeri',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: candi.imageUrls.length,
                    itemBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.only(right: 8),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  'Tap untuk memperbesar',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
