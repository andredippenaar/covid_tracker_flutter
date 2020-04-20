import 'dart:convert';

import 'package:covidtrackerflutter/datasource.dart';
import 'package:covidtrackerflutter/pages/countrypage.dart';
import 'package:covidtrackerflutter/panels/infopanel.dart';
import 'package:covidtrackerflutter/panels/mostaffectedcountries.dart';
import 'package:covidtrackerflutter/panels/worldwidepanel.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String worldUrl = 'https://corona.lmao.ninja/v2/all';
  String countryUrl = 'https://corona.lmao.ninja/v2/countries?sort=cases';

  Map worldData;
  fetchWorldWideData() async {
    http.Response response = await http.get(worldUrl);
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countryData;
  fetchCountryData() async {
    http.Response response = await http.get(countryUrl);
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  Future fetchData() async {
    fetchWorldWideData();
    fetchCountryData();
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('COVID-19 TRACKER'),
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 100,
                alignment: Alignment.center,
                padding: EdgeInsets.all(10.0),
                color: Colors.orange[100],
                child: Text(
                  DataSource.quote2,
                  style: TextStyle(
                      color: Colors.orange[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Worldwide',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CountryPage()));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: primaryBlack,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Text(
                          'Regional',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              worldData == null
//                ? CircularProgressIndicator()
                  ? Container(
                      child: SpinKitFadingCube(
                        color: primaryBlack,
                        size: 75.0,
                      ),
                      padding: EdgeInsets.only(bottom: 30.0, top: 20.0),
                    )
                  : WorldwidePanel(
                      worldData: worldData,
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Most Affected Countries',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              countryData == null
                  ? Container()
                  : MostAffectedPanel(
                      countryData: countryData,
                    ),
              InfoPanel(),
              SizedBox(height: 20.0),
              Center(
                child: Text(
                  DataSource.footer,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}
