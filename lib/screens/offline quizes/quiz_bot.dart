import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';


class WebBot extends StatefulWidget {
  const WebBot({super.key});

  @override
  State<WebBot> createState() => _WebBotState();
}

class _WebBotState extends State<WebBot> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

     Timer(Duration(seconds: 2), () async{
       final url = Uri.parse('https://mediafiles.botpress.cloud/0acb875b-230e-4424-a348-769d3b0e48a5/webchat/bot.html');
       if (await canLaunchUrl(url)) {
       await launchUrl(url);
       } else {
       // Handle the case where the phone app cannot be launched
       print('Could not launch $url');
       Fluttertoast.showToast(msg: 'Could not launch phone dialer');
       }
     });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(child: Text('Quiz Bot',style: TextStyle(color: Colors.grey,fontSize:50),)),
    );
  }
}


class QuizBot extends StatefulWidget {

  const QuizBot({super.key,});

  @override
  State<QuizBot> createState() => _QuizBotState();
}

class _QuizBotState extends State<QuizBot> {
  double _progress = 0;
  late InAppWebViewController  inAppWebViewController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{

        var isLastPage = await inAppWebViewController.canGoBack();

        if(isLastPage){
          inAppWebViewController.goBack();
          return false;
        }

        return true;
      },
      child: Scaffold(


        body:

        Stack(
          children: [

            InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri.uri(Uri.parse('https://mediafiles.botpress.cloud/0acb875b-230e-4424-a348-769d3b0e48a5/webchat/bot.html')),
              ),
              onWebViewCreated: (InAppWebViewController controller){
                inAppWebViewController = controller;
              },
              onProgressChanged: (InAppWebViewController controller , int progress){
                setState(() {
                  _progress = progress / 100;
                });
              },
              initialOptions: InAppWebViewGroupOptions(
                android: AndroidInAppWebViewOptions(
                  disableDefaultErrorPage: false,
                  // useHybridComposition: true,
                  supportMultipleWindows: false,
                  cacheMode: AndroidCacheMode.LOAD_DEFAULT,
                ),
                crossPlatform: InAppWebViewOptions(
                  javaScriptEnabled: true,
                  mediaPlaybackRequiresUserGesture: false,
                  // debuggingEnabled: true,
                ),
              ),

            ),

            _progress < 1 ? Container(
              child: LinearProgressIndicator(
                value: _progress,
              ),
            ):SizedBox()
          ],
        ),
      ),
    );
  }
}