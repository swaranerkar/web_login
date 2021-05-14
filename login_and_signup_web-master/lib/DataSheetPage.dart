import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/constants.dart';
import 'package:flutter/widgets.dart';
import 'Model/ArrivalInfo.dart';
import 'Model/BunkerInfo.dart';
import 'Model/DepartureInfo.dart';
import 'Model/UserDetails.dart';

// ignore: must_be_immutable
class ArrivalInfoWidget extends StatefulWidget {
  UserDetails userDetails;

  int custQuoteMasterID;
  ArrivalInfoWidget(UserDetails userDetails, int custQuoteMasterID) {
    this.userDetails = userDetails;
    this.custQuoteMasterID = custQuoteMasterID;
  }
  @override
  State<StatefulWidget> createState() {
    return _ArrivalInfoWidgetState();
  }
}

class _ArrivalInfoWidgetState extends State<ArrivalInfoWidget> {
  ArrivalInfo arrivalInfo;
  bool _isEnabled = false;
  final hfoController = TextEditingController();
  final mdoController = TextEditingController();
  final lubController = TextEditingController();
  final gasOilController = TextEditingController();
  final fwrobController = TextEditingController();

  // hfoController.text = '123';
  // mdoController.text = '456';
  //lubController.text = '789';
  //gasOilController.text = '1011';
  //fwrobController.text = '1213';
  void initState() {
    super.initState();

    setState(() {
      // now = new DateTime.now();
      // date = new DateTime(now.year, now.month, now.day);
      if (widget.custQuoteMasterID != null)
        getArrivalInfo(widget.custQuoteMasterID);
    });
  }

  void getArrivalInfo(int custQuoteMasterID) async {
    try {
      var result = await http.get(Uri.parse(
          'https://192.168.1.106:45455/api/ArrivalInfoes/Arrival/$custQuoteMasterID'));
      if (result.statusCode == 200) {
        setState(() {
          this.arrivalInfo = ArrivalInfo.fromJson(jsonDecode(result.body));
          hfoController.text = this.arrivalInfo.hforob.toString();
          mdoController.text = this.arrivalInfo.mdorob.toString();
          lubController.text = this.arrivalInfo.lubROB.toString();
          gasOilController.text = this.arrivalInfo.gasOilROB.toString();
          fwrobController.text = this.arrivalInfo.hforob.toString();
        });
      } else {
        /*Fluttertoast.showToast(
              msg: "Failed to fetch arrival info!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color(0xffD09FA6),
              textColor: Colors.white,
              fontSize: 16.0);*/
        throw Exception('Failed to fetch arrival information!');
      }
    } catch (Exception) {
      print(Exception.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            (widget.custQuoteMasterID == null)
                ? Container(
                    margin: EdgeInsets.all(10),
                    child:Text(
                          "NO VOYAGE FILE SELECTED. PLEASE SELECT A FILE TO VIEW DETAILS.",
                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),textAlign: TextAlign.center))
                : Container(),
            Card(
              color: kPrimaryColor1,
              margin: EdgeInsets.all(10),
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              child: Container(
                width: 2000,
                child: Text(
                  "ARRIVAL INFORMATION",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    margin: EdgeInsets.all(10),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    color: Colors.white,
                    // margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          //color: kPrimaryColor5,
                          padding: EdgeInsets.only(top: 10),
                          margin:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'H.F.O',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                       Row(children: [ Expanded( child:
                         Container(
                          //height: 50,
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          child: TextField(
                            controller: hfoController,
                            enabled: false,
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none),
                            style: TextStyle(
                                // overflow: TextOverflow.ellipsis,
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                             
                                fontSize: 16),
                          ),
                         )
                        ),
                          Expanded( child:Container(
                            margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                            child: 
                             (widget.custQuoteMasterID == null)
              ?Container():Text(
                               
                            'MT',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                           
              ),
                          ))
                          ]),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    margin: EdgeInsets.all(10),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          margin:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'M.D.O',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                       Row(children:[ Expanded(child: Container(
                          height: 50,
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          child: TextField(
                            controller: mdoController,
                            enabled: _isEnabled,
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 16),
                          ),)
                        ),
                         Expanded( child:Container(
                            child: 
                           (widget.custQuoteMasterID == null)
              ?Container(): Text(
                            'MT',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                       
                          ),
                          ))])
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: Card(
                  margin: EdgeInsets.all(10),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        margin:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'LUB OIL',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Row(children:[ Expanded(child:
                      Container(
                        height: 50,
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        child: TextField(
                          controller: lubController,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none),
                          enabled: false,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                           
                              fontSize: 16),
                        ),
                      )),
                       Expanded( child:Container(
                            child: 
                           (widget.custQuoteMasterID == null)
              ?Container(): Text(
                            'Litres',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                            textAlign: TextAlign.left,
                          ),
                          ))])
                    ],
                  ),
                )),
                Expanded(
                  child: Card(
                    margin: EdgeInsets.all(10),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          margin:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'GAS OIL',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Row(children:[Expanded(child:Container(
                          height: 50,
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          child: TextField(
                            controller: gasOilController,
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none),
                            enabled: false,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                             
                                fontSize: 16),
                          ),
                        )),
                         Expanded( child:Container(
                            child: 
                           (widget.custQuoteMasterID == null)
              ?Container(): Text(
                            'MT',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                            textAlign: TextAlign.left,
                          ),
                          ))])
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    margin: EdgeInsets.all(10),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          margin:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'FW ROB',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Row(children:[Expanded(child:Container(
                          height: 50,
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          child: TextField(
                            controller: fwrobController,
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none),
                            enabled: false,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              
                                fontSize: 16),
                          ),
                        )),
                         Expanded( child:Container(
                            child: 
                           (widget.custQuoteMasterID == null)
              ?Container(): Text(
                            'MT',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                            textAlign: TextAlign.left,
                          ),
                          ))])
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}

// ignore: must_be_immutable
class DepartureInfoWidget extends StatefulWidget {
  UserDetails userDetails;
  int custQuoteMasterID;
  DepartureInfoWidget(UserDetails userDetails, int custQuoteMasterID) {
    this.userDetails = userDetails;
    this.custQuoteMasterID = custQuoteMasterID;
  }
  @override
  State<StatefulWidget> createState() {
    return _DepartureInfoWidgetState();
  }
}

class _DepartureInfoWidgetState extends State<DepartureInfoWidget> {
  DepartureInfo departureInfo;
  bool _isEnabled = false;
  final hfoController = TextEditingController();
  final mdoController = TextEditingController();
  final lubController = TextEditingController();
  final gasOilController = TextEditingController();
  final fwrobController = TextEditingController();
  DateTime now;
  DateTime date;

  void initState() {
    super.initState();

    setState(() {
      now = new DateTime.now();
      date = new DateTime(now.year, now.month, now.day);
      if (widget.custQuoteMasterID != null)
        getDepartureInfo(widget.custQuoteMasterID);
    });
  }

  void getDepartureInfo(int custQuoteMasterID) async {
    try {
      var result = await http.get(Uri.parse(
          'https://192.168.1.106:45455/api/ArrivalInfoes/Departure/$custQuoteMasterID'));
      if (result.statusCode == 200) {
        setState(() {
          this.departureInfo = DepartureInfo.fromJson(jsonDecode(result.body));
          hfoController.text = this.departureInfo.hforob.toString();
          mdoController.text = this.departureInfo.mdorob.toString();
          lubController.text = this.departureInfo.lubROB.toString();
          gasOilController.text = this.departureInfo.gasOilROB.toString();
          fwrobController.text = this.departureInfo.hforob.toString();
        });
      } else {
        /* Fluttertoast.showToast(
            msg: "Failed to fetch departure info!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color(0xffD09FA6),
            textColor: Colors.white,
            fontSize: 16.0);*/
        throw Exception('Failed to fetch departure information!');
      }
    } catch (Exception) {
      print(Exception.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(10),
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              color: kPrimaryColor1,
              child: Container(
                width: 2000,
                child: Text(
                  "DEPARTURE INFORMATION",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    margin: EdgeInsets.all(10),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          margin:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'H.F.O',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Row(children:[Expanded(child:Container(
                          height: 50,
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          child: TextField(
                            controller: hfoController,
                            enabled: _isEnabled,
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                             
                                fontSize: 16),
                          ),
                        )),
                         Expanded( child:Container(
                            child: 
                           (widget.custQuoteMasterID == null)
              ?Container(): Text(
                            'MT',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                            textAlign: TextAlign.left,
                          ),
                          ))])
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    margin: EdgeInsets.all(10),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          margin:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'M.D.O',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Row(children:[Expanded(child:Container(
                          height: 50,
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          child: TextField(
                            controller: mdoController,
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none),
                            enabled: _isEnabled,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              
                                fontSize: 16),
                          ),)
                        ),
                         Expanded( child:Container(
                            child: 
                           (widget.custQuoteMasterID == null)
              ?Container(): Text(
                            'MT',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                            textAlign: TextAlign.left,
                          ),
                          ))])
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: Card(
                  margin: EdgeInsets.all(10),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        margin:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'LUB OIL',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Row(children:[Expanded(child:Container(
                        height: 50,
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        child: TextField(
                          controller: lubController,
                          enabled: _isEnabled,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                           
                              fontSize: 16),
                        ),)

                      ), Expanded( child:Container(
                            child: 
                           (widget.custQuoteMasterID == null)
              ?Container(): Text(
                            'Litres',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                            textAlign: TextAlign.left,
                          ),
                          ))])
                    ],
                  ),
                )),
                Expanded(
                  child: Card(
                    margin: EdgeInsets.all(10),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          margin:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'GAS OIL',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Row(children:[Expanded(child:Container(
                          height: 50,
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          child: TextField(
                            controller: gasOilController,
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none),
                            enabled: _isEnabled,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                               
                                fontSize: 16),
                          ),)
                        ),
                         Expanded( child:Container(
                            child: 
                           (widget.custQuoteMasterID == null)
              ?Container(): Text(
                            'MT',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                            textAlign: TextAlign.left,
                          ),
                          ))])
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    margin: EdgeInsets.all(10),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          margin:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'FW ROB',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Row(children:[Expanded(child:Container(
                          height: 50,
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          child: TextField(
                            controller: fwrobController,
                            enabled: _isEnabled,
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                           
                                fontSize: 16),
                          ),)
                        ),
                         Expanded( child:Container(
                            child: 
                           (widget.custQuoteMasterID == null)
              ?Container(): Text(
                            'MT',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                            textAlign: TextAlign.left,
                          ),
                          ))])
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }
}

// ignore: must_be_immutable
class BunkerInfoWidget extends StatefulWidget {
  UserDetails userDetails;

  int custQuoteMasterID;
  BunkerInfoWidget(UserDetails userDetails, int custQuoteMasterID) {
    this.userDetails = userDetails;
    this.custQuoteMasterID = custQuoteMasterID;
  }
  @override
  State<StatefulWidget> createState() {
    return _BunkerInfoWidgetState();
  }
}

class _BunkerInfoWidgetState extends State<BunkerInfoWidget> {
  bool _isEnabled = false;
  BunkerInfo bunkerInfo;
  final hforecdController = TextEditingController();
  final mdorecdController = TextEditingController();
  final gasOilRecdController = TextEditingController();
  final fwrecdController = TextEditingController();

  void initState() {
    super.initState();

    setState(() {
      // now = new DateTime.now();
      // date = new DateTime(now.year, now.month, now.day);
      if (widget.custQuoteMasterID != null)
        getBunkerInfo(widget.custQuoteMasterID);
    });
  }

  void getBunkerInfo(int custQuoteMasterID) async {
    try {
      var result = await http.get(Uri.parse(
          'https://192.168.1.106:45455/api/BunkerInfo/$custQuoteMasterID'));
      if (result.statusCode == 200) {
        setState(() {
          this.bunkerInfo = BunkerInfo.fromJson(jsonDecode(result.body));
          hforecdController.text = bunkerInfo.hforecd.toString();
          mdorecdController.text = bunkerInfo.mdorecd.toString();
          gasOilRecdController.text = bunkerInfo.gasOilRecd.toString();
          fwrecdController.text = bunkerInfo.fwrecd.toString();
        });
      } else {
        /*  Fluttertoast.showToast(
            msg: "Failed to fetch bunker info!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color(0xffD09FA6),
            textColor: Colors.white,
            fontSize: 16.0);*/
        throw Exception('Failed to fetch bunker information!');
      }
    } catch (Exception) {
      print(Exception.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(10),
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              color: kPrimaryColor1,
              child: Container(
                width: 2000,
                child: Text(
                  "BUNKER INFORMATION",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    margin: EdgeInsets.all(10),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          margin:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'H.F.O',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Row(children:[Expanded(child:Container(
                          height: 50,
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          child: TextField(
                            controller: hforecdController,
                            enabled: _isEnabled,
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none),
                            // maxLengthEnforced: true,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              
                                fontSize: 16),
                          ),)
                        ),
                         Expanded( child:Container(
                            child: 
                           (widget.custQuoteMasterID == null)
              ?Container(): Text(
                            'MT',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                            textAlign: TextAlign.left,
                          ),
                          ))])
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    margin: EdgeInsets.all(10),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          margin:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'M.D.O',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Row(children:[Expanded(child:Container(
                          height: 50,
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          child: TextField(
                            controller: mdorecdController,
                            enabled: _isEnabled,
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                             
                                fontSize: 16),
                          ),)
                        ),
                         Expanded( child:Container(
                            child: 
                           (widget.custQuoteMasterID == null)
              ?Container(): Text(
                            'MT',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                            textAlign: TextAlign.left,
                          ),
                          ))])
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    margin: EdgeInsets.all(10),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          margin:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'GAS OIL',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Row(children:[Expanded(child:Container(
                          height: 50,
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          child: TextField(
                            controller: gasOilRecdController,
                            enabled: _isEnabled,
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              
                                fontSize: 16),
                          ),)
                        ), Expanded( child:Container(
                            child: 
                           (widget.custQuoteMasterID == null)
              ?Container(): Text(
                            'MT',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                            textAlign: TextAlign.left,
                          ),
                          ))])
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    margin: EdgeInsets.all(10),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          margin:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'FW',
                            //overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Row(children:[Expanded(child:Container(
                          height: 50,
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          child: TextField(
                            controller: fwrecdController,
                            enabled: _isEnabled,
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              
                                fontSize: 16),
                          ),)
                        ),
                         Expanded( child:Container(
                            child: 
                           (widget.custQuoteMasterID == null)
              ?Container(): Text(
                            'MT',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                            textAlign: TextAlign.left,
                          ),
                          ))])
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}

// ignore: must_be_immutable
class DataSheetPageWidget extends StatefulWidget {
  UserDetails userDetails;

  int custQuoteMasterID;
  DataSheetPageWidget(UserDetails userDetails, int custQuoteMasterID) {
    this.userDetails = userDetails;
    this.custQuoteMasterID = custQuoteMasterID;
  }
  @override
  _DataSheetPageWidgetState createState() => _DataSheetPageWidgetState();
}

class _DataSheetPageWidgetState extends State<DataSheetPageWidget> {
  @override
  Widget build(BuildContext context) {
    // return SingleChildScrollView(
    //   child: Container(
    //     color: Colors.white,
    //     height: 200,
    //     width: 200,
    //     // child: SingleChildScrollView(

    //     child:
    return Container(
        color: Colors.grey[200],
        child: ListView(
          // (children: [],Column(
          children: [
            //Flexible(
            //child:
            ArrivalInfoWidget(widget.userDetails, widget.custQuoteMasterID),
            // ),
            //Flexible(
            // child:
            BunkerInfoWidget(widget.userDetails, widget.custQuoteMasterID)
            //),
            ,
            //  Flexible(
            //child:
            DepartureInfoWidget(widget.userDetails, widget.custQuoteMasterID)
            //),
          ],

          //)
        ));
  }
}
