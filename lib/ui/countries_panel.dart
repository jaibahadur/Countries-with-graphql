import 'package:countriescode/modal.dart/country.dart';
import 'package:countriescode/utils/Internet_check.dart';
import 'package:countriescode/utils/countries_gql.dart';
import 'package:countriescode/widgets/alert_widget.dart';
import 'package:countriescode/widgets/country_tile.dart';
import 'package:countriescode/widgets/search_box.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CountriesPanel extends StatefulWidget {
  const CountriesPanel({Key? key}) : super(key: key);

  @override
  _CountriesPanelState createState() => _CountriesPanelState();
}

class _CountriesPanelState extends State<CountriesPanel> {
  List<Map<String, dynamic>> allCountries = [];
  List<Country> countriesArrayList = [];
  List<Country> showingCountriesArrayList = [];
  bool readyUI = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {});
    checkInternet();
  }

  checkInternet() async {
    if (await internetCheck() == false) {
      showAlertMsg(context,
          msg: "Internet connection not found",
          rightbtnTitle: "Retry", callBack: () {
        checkInternet();
        readyUI = false;
        setState(() {});
      });
    } else {
      readyUI = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: countriesGraphQL.client,
      child: CacheProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: const Text("Countries List"),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              body: readyUI ? bodyView(context) : Container()),
        ),
      ),
    );
  }

  bodyView(cxt) {
    return Query(
      options: QueryOptions(
        document: gql(countriesGraphQL.countriesQuery),
        pollInterval: Duration(seconds: 10),
      ),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) {
          return Container();
        }
        print("result ${result.source}");
        if (result.isLoading) {
          return const Center(child: Text('Loading...'));
        }

        // it can be either Map or List

        allCountries = (result.data!['countries'] as List<dynamic>)
            .cast<Map<String, dynamic>>();

        if (countriesArrayList.length == 0) {
          countriesArrayList =
              allCountries.map((element) => Country.fromMap(element)).toList();
          countriesArrayList.sort(
              (firstObj, secondObj) => firstObj.name.compareTo(secondObj.name));
          showingCountriesArrayList.addAll(countriesArrayList);
        }

        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              searchField(),
              countriesList(),
            ],
          ),
        );
      },
    );
  }

  Widget info({String? text}) {
    return Center(
      child: Container(
        height: 30,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Icon(icon, size: 60, color: color),
            // SizedBox(height: 5),
            Text(text!, style: TextStyle(color: Colors.grey))
          ],
        ),
      ),
    );
  }

  Widget searchField() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: double.infinity,
        height: 50,
        child: SearchBox(textChanged: onSearchTextChanged),
      ),
    );
  }

  void onSearchTextChanged(String text) {
    setState(() {
      if (text.isNotEmpty) {
        showingCountriesArrayList = countriesArrayList
            .where((element) =>
                element.code.toLowerCase().contains(text.toLowerCase()))
            .toList();
        countriesArrayList.sort(
            (firstObj, secondObj) => firstObj.name.compareTo(secondObj.name));
      } else {
        showingCountriesArrayList = countriesArrayList;
      }
    });
  }

  Widget countriesList() {
    return showingCountriesArrayList.length == 0
        ? Center(
            child: info(
                text: "No countries found. Please enter correct country code"))
        : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: showingCountriesArrayList.length,
            itemBuilder: (_, int index) {
              Country country = showingCountriesArrayList[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: CountryTile(country: country),
              );
            },
          );
  }
}
