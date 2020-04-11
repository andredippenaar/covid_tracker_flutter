import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:covidtrackerflutter/datasource.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

final formatter = new NumberFormat("#,###");

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  String countryUrl = 'https://corona.lmao.ninja/countries?sort=cases';

  List countryData;
  fetchCountryData() async {
    http.Response response = await http.get(countryUrl);
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country Stats'),
      ),
      body: countryData == null
          ? SpinKitFadingCube(
              color: primaryBlack,
              size: 75.0,
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  height: 130.0,
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      boxShadow: [
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
                              countryData[index]['country'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Image.network(
                              countryData[index]['countryInfo']['flag'],
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
                                        .format(countryData[index]['cases']),
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "[+${countryData[index]['todayCases']}]",
                                style: TextStyle(color: Colors.red),
                              ),
                              Text(
                                'ACTIVE: ' +
                                    formatter
                                        .format(countryData[index]['active']),
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'RECOVERED: ' +
                                    formatter.format(
                                        countryData[index]['recovered']),
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'DEATHS: ' +
                                    formatter
                                        .format(countryData[index]['deaths']),
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "[+${countryData[index]['todayDeaths']}]",
                                style: TextStyle(color: Colors.grey[800]),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: countryData == null ? 0 : countryData.length,
            ),
    );
  }
}
