import 'package:flutter/material.dart';
import 'package:prj_wisatacandi_si51/widgets/profile_info_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // TODO: 1.Deklarasi kan variabel yang dibutuhkan
  bool isSignedIn = true;
  String fullName = '';
  String userName = '';
  int favoriteCandiCount = 0;

  // TODO: 5. Implementasi fungsi Sign In
  void signIn() {
    setState(() {
      isSignedIn = !isSignedIn;
    });
  }

  // TODO: 6. Implementasi fungsi Sign out
  void signOut() {
    setState(() {
      isSignedIn = !isSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.deepPurple,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // TODO: 2. Buat Bagian Profile Header yang berisi gambar profil
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 200 - 50),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.deepPurple, width: 2),
                            shape: BoxShape.circle,
                          ),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('images/placeholder_image.png'),
                          ),
                        ),
                        if (isSignedIn)
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.deepPurple[50],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                // TODO: 3. Buat bagian profile info yang berisi info profil
                const SizedBox(height: 20),
                Divider(color: Colors.deepPurple[100]),
                const SizedBox(height: 4),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Row(
                        children: [
                          ProfileInfoItem(
                            icon: Icons.lock,
                            label: 'Pengguna',
                            value: userName,
                            iconColor: Colors.amber,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Divider(color: Colors.deepPurple[100]),
                    const SizedBox(height: 4),
                    ProfileInfoItem(
                      icon: Icons.person,
                      label: 'Nama',
                      value: fullName,
                      showEditIcon: isSignedIn,
                      onEditPressed: () {
                        debugPrint('Icon edit ditekan....');
                      },
                      iconColor: Colors.blue,
                    ),
                    const SizedBox(height: 4),
                    Divider(color: Colors.deepPurple[100]),
                    const SizedBox(height: 4),
                    ProfileInfoItem(
                      icon: Icons.favorite,
                      label: 'Favorit',
                      value:
                          favoriteCandiCount > 0 ? '$favoriteCandiCount' : '',
                      iconColor: Colors.red,
                    ),
                  ],
                ),
                // TODO: 4. Buat profile Actions yang berisi Textbutton sign in/out
                const SizedBox(height: 4),
                Divider(color: Colors.deepPurple[100]),
                const SizedBox(height: 20),
                isSignedIn
                    ? TextButton(
                        onPressed: signOut, child: const Text('Sign Out'))
                    : TextButton(
                        onPressed: signIn, child: const Text('Sign In')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//                 Row(
//                   children: [
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width / 3,
//                       child: const Row(
//                         children: [
//                           Icon(
//                             Icons.lock,
//                             color: Colors.amber,
//                           ),
//                           SizedBox(
//                             width: 8,
//                           ),
//                           Text(
//                             "Pengguna",
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold),
//                           )
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                         child: Text(
//                       ': $userName',
//                       style: const TextStyle(fontSize: 18),
//                     )),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const Divider(
//                   color: Colors.deepPurple,
//                 ),
//                 const SizedBox(
//                   height: 4,
//                 ),
//                 Row(
//                   children: [
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width / 3,
//                       child: const Row(
//                         children: [
//                           Icon(
//                             Icons.person,
//                             color: Colors.amber,
//                           ),
//                           SizedBox(
//                             width: 8,
//                           ),
//                           Text(
//                             "Nama",
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold),
//                           )
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                         child: Text(
//                       ': $fullName',
//                       style: const TextStyle(fontSize: 18),
//                     )),
//                     if (isSignedIn) const Icon(Icons.edit),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const Divider(
//                   color: Colors.deepPurple,
//                 ),
//                 const SizedBox(
//                   height: 4,
//                 ),
//                 Row(
//                   children: [
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width / 3,
//                       child: const Row(
//                         children: [
//                           Icon(
//                             Icons.favorite,
//                             color: Colors.red,
//                           ),
//                           SizedBox(
//                             width: 8,
//                           ),
//                           Text(
//                             "Favorit",
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold),
//                           )
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                         child: Text(
//                       ': $favoriteCandiCount',
//                       style: const TextStyle(fontSize: 18),
//                     )),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 4,
//                 ),
//                 const Divider(
//                   color: Colors.deepPurple,
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
