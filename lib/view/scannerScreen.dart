
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hinergi_kwh/model/setting.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:hinergi_kwh/view/MyTextFormField.dart';
import 'package:validators/validators.dart' as validator;

class scannerScreen extends StatefulWidget {
  scannerScreen();
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<scannerScreen> {
  final GlobalKey qrKey = GlobalKey();
  String chanelId = "";
  String apiKey = "";
  String barcode = "";
  Setting setting = Setting();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: 
        // Scaffold(
        // appBar: AppBar(
        //   title: Text('Scanner'),
        // ),
        // body: Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
              
              // Expanded(
              //   child: QRView(
              //     key: qrKey,
              //     onQRViewCreated: (controller) {
              //       controller.scannedDataStream.listen((value) {
              //         setState(() {
              //           if(chanelId.isEmpty && apiKey.isEmpty){
              //             chanelId = value;
              //           }else if(chanelId.isEmpty && apiKey.isNotEmpty){
              //             chanelId = value;
              //           }else if(chanelId.isNotEmpty && apiKey.isEmpty){
              //             apiKey = value;
              //           }else if(chanelId.isNotEmpty && apiKey.isNotEmpty){
              //              chanelId = value;
              //              apiKey = "";
              //           }
                        
              //         });
              //       });
              //     },
              //   ),
              // ),
            
              SingleChildScrollView(
                child: Center(
                  // child: Text('Result: $barcode'),
                   child : Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                              AppBar(
                                    title: Text('SCANNER'),
                              ),
                                Text(
                                  '$barcode',
                                  textAlign: TextAlign.center,
                                ),
                              MyTextFormField(
                                hintText: 'Masukkan Channel Id anda',
                                labelText: 'Channel Id',
                                value: chanelId,
                                isEmail: false,
                                icon: Icon(Icons.verified_user),
                                validator: (String value) {
                                  if (validator.isNull(value)) {
                                    return 'Please enter a channel id';
                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                  setting.channelId = value;
                                },
                              ),
                              MyTextFormField(
                                hintText: 'Masukkan API Key anda',
                                labelText: 'API Key',
                                value: apiKey,
                                isEmail: false,
                                icon: Icon(Icons.vpn_key_sharp),
                                validator: (String value) {
                                  if (validator.isNull(value)) {
                                    return 'Please enter a api key';
                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                  setting.apiKey = value;
                                },
                              ),
                              RaisedButton(
                                color: Colors.blueAccent,
                                shape: StadiumBorder(),
                                child: Text('SCAN',
                                  style: TextStyle(
                                  color: Colors.white,
                                  ),
                                ),
                                onPressed: () async {
                                  try {
                                    String barcode = await BarcodeScanner.scan();
                                    setState(() {
                                      // this.barcode = barcode;
                                       chanelId = barcode.substring( 0, barcode.indexOf(","));
                                       apiKey = barcode.substring(barcode.indexOf(",")+1, barcode.length);
                                      // if(chanelId.isEmpty && apiKey.isEmpty){
                                      //     chanelId = barcode;
                                      //   }else if(chanelId.isEmpty && apiKey.isNotEmpty){
                                      //     chanelId = barcode;
                                      //   }else if(chanelId.isNotEmpty && apiKey.isEmpty){
                                      //     apiKey = barcode;
                                      //   }else if(chanelId.isNotEmpty && apiKey.isNotEmpty){
                                      //     chanelId = barcode;
                                      //     apiKey = "";
                                      //   }
                                    });
                                  } on PlatformException catch (error) {
                                    if (error.code == BarcodeScanner.CameraAccessDenied) {
                                      setState(() {
                                        this.barcode = 'Izin kamera tidak diizinkan oleh si pengguna';
                                      });
                                    } else {
                                      setState(() {
                                        this.barcode = 'Error: $error';
                                      });
                                    }
                                  }
                                },
                              ),
                              RaisedButton(
                                color: Colors.blueAccent,
                                shape: StadiumBorder(),
                                onPressed: () {

                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                                                    
                                    setting.setApiChannel(setting);
                                                            
                                    }
                                },
                                child: Text(
                                    'SIMPAN',
                                  style: TextStyle(
                                  color: Colors.white,
                                  ),
                                ),
                              )
                  
                        ]
                      )
                    ),

                ),
              ),
             
          
              
              
        //     ],
        //   ),
        // ),
      // ),
    );
  }
}