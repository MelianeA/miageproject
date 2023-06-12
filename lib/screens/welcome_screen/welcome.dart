// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, avoid_print

import 'package:clothing/screens/navigation_screens/cart.dart';
import 'package:clothing/screens/navigation_screens/profil.dart';
import 'package:clothing/screens/navigation_screens/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// Initialize a Firestore instance
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final Stream<QuerySnapshot> _categoriesStream =
    FirebaseFirestore.instance.collection('Categories').snapshots();
final Stream<QuerySnapshot> _dressesStream =
    FirebaseFirestore.instance.collection('Dresses').snapshots();
final Stream<QuerySnapshot> _accessoriesStream =
    FirebaseFirestore.instance.collection('Accessories').snapshots();
final Stream<QuerySnapshot> _topsblousesStream =
    FirebaseFirestore.instance.collection('Tops&Blouses').snapshots();


class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  int pageIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      pageIndex = index;

      if (index == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Welcome()));
      }
      if (index == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Search()));
      }
      if (index == 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Cart()));
      }
      if (index == 3) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Profil()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: _categoriesStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Card(
                    clipBehavior: Clip.hardEdge,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: InkWell(
                        child: ListTile(
                      
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromRGBO(177, 63, 181, 1),
                            size: 15,
                          ),
                          leading: FaIcon(FontAwesomeIcons.shirt),
                          title: Text(data['name']),
                        ),
                        onTap: () {
                          if (data['name'] == 'haut') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DressesPage(data: data)));
                          }
                          if (data['name'] == 'bas') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AccessoriesPage(data: data)));
                          }
                          if (data['name'] == 'robe') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TopsBlousesPage(data: data)));
                          }
                          
                        }),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: GNav(
        color: Colors.grey,
        activeColor: Color.fromRGBO(177, 63, 181, 1),
        gap: 8,
        tabs: [
          GButton(
              icon: Icons.home,
              text: 'Home',
              onPressed: () {
                _onItemTapped(0);
              }),
          GButton(
              icon: Icons.search,
              text: 'Search',
              onPressed: () {
                _onItemTapped(1);
              }),
          GButton(
            icon: Icons.shopping_cart,
            text: 'Cart',
            onPressed: () {
              _onItemTapped(2);
            },
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
            onPressed: () {
              _onItemTapped(3);
            },
          ),
        ],
      ),
    );
  }
}
//haut
class DressesPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const DressesPage({Key? key, required this.data}) : super(key: key);

  @override
  State<DressesPage> createState() => _DressesPageState();
}

class _DressesPageState extends State<DressesPage> {
  int pageIndex = 2;
  void _onItemTapped(int index) {
    setState(() {
      pageIndex = index;

      if (index == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Welcome()));
      }
      if (index == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Search()));
      }
      if (index == 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Cart()));
      }
      if (index == 3) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Profil()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(177, 63, 181, 1),
        title: Text(widget.data['name']),
      ),
      body: Container(
        child: Row(
          children: [
            Expanded(
                child: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: _dressesStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    shrinkWrap: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> dresse =
                          document.data()! as Map<String, dynamic>;
                      return Card(
                        clipBehavior: Clip.hardEdge,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                        ),
                        child: InkWell(
                            child: ListTile(
                              
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: Color.fromRGBO(177, 63, 181, 1),
                                size: 15,
                              ),
                              title: Text(dresse['name']),
                              subtitle: Text(dresse['price']),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                    
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailsProduct(data: dresse)));
                            }),
                      );
                    }).toList(),
                  );
                },
              ),
            ))
          ],
        ),
      ),
      bottomNavigationBar: GNav(
        color: Colors.grey,
        activeColor: Color.fromRGBO(177, 63, 181, 1),
        gap: 8,
        tabs: [
          GButton(
              icon: Icons.home,
              text: 'Home',
              onPressed: () {
                _onItemTapped(0);
              }),
          GButton(
              icon: Icons.search,
              text: 'Search',
              onPressed: () {
                _onItemTapped(1);
              }),
          GButton(
            icon: Icons.shopping_cart,
            text: 'Cart',
            onPressed: () {
              _onItemTapped(2);
            },
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
            onPressed: () {
              _onItemTapped(3);
            },
          ),
        ],
      ),
    );
  }
}
//bas
class AccessoriesPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const AccessoriesPage({Key? key, required this.data}) : super(key: key);

  @override
  State<AccessoriesPage> createState() => _AccessoriesPageState();
}

class _AccessoriesPageState extends State<AccessoriesPage> {
  int pageIndex = 2;
  void _onItemTapped(int index) {
    setState(() {
      pageIndex = index;

      if (index == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Welcome()));
      }
      if (index == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Search()));
      }
      if (index == 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Cart()));
      }
      if (index == 3) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Profil()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(177, 63, 181, 1),
        title: Text(widget.data['name']),
      ),
      body: Container(
        child: Row(
          children: [
            Expanded(
                child: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: _accessoriesStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    shrinkWrap: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> acc =
                          document.data()! as Map<String, dynamic>;
                      return Card(
                        clipBehavior: Clip.hardEdge,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                        ),
                        child: InkWell(
                            child: ListTile(
                              
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: Color.fromRGBO(177, 63, 181, 1),
                                size: 15,
                              ),
                              title: Text(acc['name']),
                              subtitle: Text(acc['price']),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailsProduct(data: acc)));
                            }),
                      );
                    }).toList(),
                  );
                },
              ),
            ))
          ],
        ),
      ),
      bottomNavigationBar: GNav(
        color: Colors.grey,
        activeColor: Color.fromRGBO(177, 63, 181, 1),
        gap: 8,
        tabs: [
          GButton(
              icon: Icons.home,
              text: 'Home',
              onPressed: () {
                _onItemTapped(0);
              }),
          GButton(
              icon: Icons.search,
              text: 'Search',
              onPressed: () {
                _onItemTapped(1);
              }),
          GButton(
            icon: Icons.shopping_cart,
            text: 'Cart',
            onPressed: () {
              _onItemTapped(2);
            },
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
            onPressed: () {
              _onItemTapped(3);
            },
          ),
        ],
      ),
    );
  }
}
//robe
class TopsBlousesPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const TopsBlousesPage({Key? key, required this.data}) : super(key: key);

  @override
  State<TopsBlousesPage> createState() => _TopsBlousesPageState();
}

class _TopsBlousesPageState extends State<TopsBlousesPage> {
  int pageIndex = 2;
  void _onItemTapped(int index) {
    setState(() {
      pageIndex = index;

      if (index == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Welcome()));
      }
      if (index == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Search()));
      }
      if (index == 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Cart()));
      }
      if (index == 3) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Profil()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(177, 63, 181, 1),
        title: Text(widget.data['name']),
      ),
      body: Container(
        child: Row(
          children: [
            Expanded(
                child: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: _topsblousesStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    shrinkWrap: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> top =
                          document.data()! as Map<String, dynamic>;
                      return Card(
                        clipBehavior: Clip.hardEdge,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                        ),
                        child: InkWell(
                            child: ListTile(
                              title: Text(top['name']),
                              subtitle: Text(top['price']),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailsProduct(data: top)));
                            }),
                      );
                    }).toList(),
                  );
                },
              ),
            ))
          ],
        ),
      ),
      bottomNavigationBar: GNav(
        color: Colors.grey,
        activeColor: Color.fromRGBO(177, 63, 181, 1),
        gap: 8,
        tabs: [
          GButton(
              icon: Icons.home,
              text: 'Home',
              onPressed: () {
                _onItemTapped(0);
              }),
          GButton(
              icon: Icons.search,
              text: 'Search',
              onPressed: () {
                _onItemTapped(1);
              }),
          GButton(
            icon: Icons.shopping_cart,
            text: 'Cart',
            onPressed: () {
              _onItemTapped(2);
            },
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
            onPressed: () {
              _onItemTapped(3);
            },
          ),
        ],
      ),
    );
  }
}

class DetailsProduct extends StatefulWidget {
  final Map<String, dynamic> data;

  const DetailsProduct({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailsProduct> createState() => _DetailsProductState();
}

class _DetailsProductState extends State<DetailsProduct> {
  int pageIndex = 2;
  void _onItemTapped(int index) {
    setState(() {
      pageIndex = index;

      if (index == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Welcome()));
      }
      if (index == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Search()));
      }
      if (index == 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Cart()));
      }
      if (index == 3) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Profil()));
      }
    });
  }

  Future addToCart() async {
   // Get a reference to the current user
    User user = _auth.currentUser!;

    // Get the user's unique identifier
    String uid = user.uid;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("Cart");
    return _collectionRef.doc(uid).collection("items").doc().set({
      "name": widget.data["name"],
      "price": widget.data["price"],
      "brand": widget.data["brand"],
      "size":widget.data['size'],
    }).then((value) => print("ajouter au panier"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(177, 63, 181, 1),
        title: Text(widget.data['name']),
      ),
      body: Center(
        child: Card(
          child: ListView(
            children: <Widget>[
              InkWell(
                onTap: addToCart,
                
              ),
              Center(
                child: Column(
                  children: [
                    Text(widget.data['name']),
                    Text(widget.data['price']),
                    Text(widget.data['brand']),
                    Text(widget.data['size']),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GNav(
        color: Colors.grey,
        activeColor: Color.fromRGBO(177, 63, 181, 1),
        gap: 8,
        tabs: [
          GButton(
              icon: Icons.home,
              text: 'Home',
              onPressed: () {
                _onItemTapped(0);
              }),
          GButton(
              icon: Icons.search,
              text: 'Search',
              onPressed: () {
                _onItemTapped(1);
              }),
          GButton(
            icon: Icons.shopping_cart,
            text: 'Cart',
            onPressed: () {
              _onItemTapped(2);
            },
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
            onPressed: () {
              _onItemTapped(3);
            },
          ),
        ],
      ),
    );
  }
}
