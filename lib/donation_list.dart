/*import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'components/card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';

class DonationList extends StatefulWidget {
  @override
  _DonationListState createState() => _DonationListState();
}

class _DonationListState extends State<DonationList> {
  final _pageController = PageController(
    viewportFraction: 0.3,
  );
  double filterdistance = 1000.0, lati, longi;
  List<String> _address = [];
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  getlocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      lati = position.latitude;
      longi = position.longitude;
      populateClients();
    });
  }

  getaddress(GeoPoint loc) async {
    List<Placemark> p =
        await geolocator.placemarkFromCoordinates(loc.latitude, loc.longitude);
    Placemark place = p[0];
    setState(() {
      _address.add("${place.name}");
    });
  }

  populateClients() async {
    await Firebase.initializeApp();
    var s = FirebaseFirestore.instance.collection('Donation').snapshots();
    s.toList();
    setState(() {
      _creditCards.clear();
    });
    s.forEach((element) {
      element.docs.forEach((element) {
        var elt = element.data();
        GeoPoint loc = elt['Itemloc'];
        print(_address);
        Geolocator()
            .distanceBetween(lati, longi, loc.latitude, loc.longitude)
            .then((dist) {
          if (dist / 1000 <= filterdistance) {
            print(elt);
            setState(() {
              _creditCards.add(CreditCard(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                ),
                image: 'assets/g.png',
                name: (dist / 1000).round().toString() + 'KM Away',
                number: elt['Itemcontact'],
                company: Text(
                  elt['Itemname'],
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ));
            });
          }
        });
      });
    });
  }

  void _showoptions() {
    TextEditingController distance = new TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              width: MediaQuery.of(context).size.width / 1.3,
              height: MediaQuery.of(context).size.height / 5,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: distance,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.black),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                        hintText: 'in kms',
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: 'Distance',
                        labelStyle: TextStyle(color: Colors.black)),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.white,
                    child: MaterialButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        setState(() {
                          filterdistance = double.parse(distance.text);
                        });
                        getlocation();
                        print(filterdistance);
                      },
                      padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                      child: Text(
                        'Apply',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  List<CreditCard> _creditCards = [];

  @override
  void initState() {
    super.initState();
    _creditCards = [
      CreditCard(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
        ),
        image: 'assets/g.png',
        name: 'ANDREW MITCHELL',
        number: '1234',
        company: Text(
          'AMERICAN \nEXPRESS',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
      ),
      CreditCard(
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.4),
        ),
        image: 'assets/g.png',
        name: 'ANDREW MITCHELL',
        number: '2434',
        company: Image.asset(
          'assets/g.png',
          height: 50,
        ),
      ),
      CreditCard(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.blue, Colors.purple],
            stops: [0.3, 0.95],
          ),
        ),
        image: 'assets/g.png',
        name: 'ANDREW MITCHELL',
        number: '4567',
        company: Text(
          'AMERICAN \nEXPRESS',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
      ),
      CreditCard(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
        ),
        image: 'assets/g.png',
        name: 'ANDREW MITCHELL',
        number: '1234',
        company: Text(
          'AMERICAN \nEXPRESS',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
      ),
      CreditCard(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
        ),
        image: 'assets/g.png',
        name: 'ANDREW MITCHELL',
        number: '1234',
        company: Text(
          'AMERICAN \nEXPRESS',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
      ),
      CreditCard(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
        ),
        image: 'assets/g.png',
        name: 'ANDREW MITCHELL',
        number: '1234',
        company: Text(
          'AMERICAN \nEXPRESS',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giveaway'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Datasearch());
              },
              icon: Icon(FontAwesomeIcons.search)),
          IconButton(onPressed: _showoptions, icon: Icon(Icons.filter_list))
        ],
      ),
      body: Center(
        child: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          itemCount: _creditCards.length,
          itemBuilder: (context, index) => _builder(index),
        ),
      ),
    );
  }

  _builder(int index) {
    CreditCard _card = _creditCards[index];
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 1.0;

        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;

          if (value >= 0) {
            double _lowerLimit = 0;
            double _upperLimit = 3.14 / 2;

            value = (_upperLimit - (value.abs() * (_upperLimit - _lowerLimit)))
                .clamp(_lowerLimit, _upperLimit);
            value = _upperLimit - value;
            value *= -1;
          }
        } else {
          if (index == 0) {
            value = 0;
          } else if (index == 1) {
            value = -1;
          }
        }

        return Center(
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(value),
            alignment: Alignment.center,
            child: child,
          ),
        );
      },
      child: _card,
    );
  }
}

class Card extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.red,
      ),
      child: Center(
          child: Text(
        'Card',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      )),
    );
  }
}

class Datasearch extends SearchDelegate {
  final cities = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm'
  ];
  final recentcities = ['a', 'b', 'c', 'd'];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
    // TODO: implement buildActions
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    /*return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );*/
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Center(
      child: Container(
        width: 100,
        height: 80,
        child: ListTile(
          title: Text(query),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final suggestionlist = query.isEmpty
        ? recentcities
        : cities.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(FontAwesomeIcons.city),
        title: RichText(
          text: TextSpan(
              text: suggestionlist[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionlist[index].substring(query.length),
                    style: TextStyle(color: Colors.black))
              ]),
        ),
      ),
      itemCount: suggestionlist.length,
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:giveaway/widgets/BestDonationWidget.dart';

import 'package:giveaway/widgets/PopularDonation.dart';
import 'package:giveaway/widgets/SearchWidget.dart';
import 'package:giveaway/widgets/TopMenus.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFAFAFA),
        elevation: 0,
        title: Text(
          "What you need?",
          style: TextStyle(
              color: Color(0xFF3a3737),
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        brightness: Brightness.light,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SearchWidget(),
            TopMenus(),
            PopularDonationsWidget(),
            BestDonationWidget(),
          ],
        ),
      ),
    );
  }
}
