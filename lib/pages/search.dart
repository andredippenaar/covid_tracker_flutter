import 'package:covidtrackerflutter/datasource.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = new NumberFormat("#,###");

class Search extends SearchDelegate {
  final List countryList;

  Search(this.countryList);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        primaryColor: primaryBlack,
        brightness: Brightness.dark,
        inputDecorationTheme: InputDecorationTheme(
          hintStyle:
              Theme.of(context).textTheme.title.copyWith(color: Colors.white),
        ));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestionList = query.isEmpty
        ? countryList
        : countryList
            .where(
              (element) =>
                  element['country'].toString().toLowerCase().startsWith(query),
            )
            .toList();
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return Card(
            child: Container(
              height: 130.0,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              decoration: BoxDecoration(color: Colors.grey[300], boxShadow: [
                BoxShadow(
                    color: Colors.grey[200],
                    blurRadius: 10.0,
                    offset: Offset(0, 10))
              ]),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          suggestionList[index]['country'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Image.network(
                          suggestionList[index]['countryInfo']['flag'],
                          height: 100.0,
                          width: 130.0,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'CONFIRMED: ' +
                                formatter
                                    .format(suggestionList[index]['cases']),
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "[+${suggestionList[index]['todayCases']}]",
                            style: TextStyle(color: Colors.red),
                          ),
                          Text(
                            'ACTIVE: ' +
                                formatter
                                    .format(suggestionList[index]['active']),
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'RECOVERED: ' +
                                formatter
                                    .format(suggestionList[index]['recovered']),
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'DEATHS: ' +
                                formatter
                                    .format(suggestionList[index]['deaths']),
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "[+${suggestionList[index]['todayDeaths']}]",
                            style: TextStyle(color: Colors.grey[800]),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? countryList
        : countryList
            .where(
              (element) =>
                  element['country'].toString().toLowerCase().startsWith(query),
            )
            .toList();
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return Card(
            child: Container(
              height: 130.0,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              decoration: BoxDecoration(color: Colors.grey[300], boxShadow: [
                BoxShadow(
                    color: Colors.grey[200],
                    blurRadius: 10.0,
                    offset: Offset(0, 10))
              ]),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          suggestionList[index]['country'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Image.network(
                          suggestionList[index]['countryInfo']['flag'],
                          height: 100.0,
                          width: 130.0,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'CONFIRMED: ' +
                                formatter
                                    .format(suggestionList[index]['cases']),
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "[+${suggestionList[index]['todayCases']}]",
                            style: TextStyle(color: Colors.red),
                          ),
                          Text(
                            'ACTIVE: ' +
                                formatter
                                    .format(suggestionList[index]['active']),
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'RECOVERED: ' +
                                formatter
                                    .format(suggestionList[index]['recovered']),
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'DEATHS: ' +
                                formatter
                                    .format(suggestionList[index]['deaths']),
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "[+${suggestionList[index]['todayDeaths']}]",
                            style: TextStyle(color: Colors.grey[800]),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
