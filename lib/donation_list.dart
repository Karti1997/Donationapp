import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'components/card.dart';

class DonationList extends StatefulWidget {
  @override
  _DonationListState createState() => _DonationListState();
}

class _DonationListState extends State<DonationList> {
  final _pageController = PageController(
    viewportFraction: 0.3,
  );

  List<CreditCard> _creditCards = [];
  /*
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
  */
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
              icon: Icon(FontAwesomeIcons.search))
        ],
      ),
      drawer: Drawer(),
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
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
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
    throw UnimplementedError();
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
    throw UnimplementedError();
  }
}
