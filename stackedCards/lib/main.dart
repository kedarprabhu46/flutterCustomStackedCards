import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

  
}
var cardAspectRatio=12.0/16.0;
  var widgetAspectRatio=cardAspectRatio*1.2;

 var images = [
    "img/Photo.jpg",
    "img/Photo.jpg",
    "img/Photo.jpg",
    "img/Photo.jpg"
  ];

class _MyHomePageState extends State<MyHomePage> {
  

  var currentPage = images.length - 1.0;

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: images.length - 1);

    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Stack(children: [
                CardScrollWidget(currentPage),
                Positioned.fill(child: PageView.builder(
                  itemCount: images.length,
                  controller: controller,
                  reverse: true,
                  itemBuilder: (context,index){
                    return Container();
                  },
                ))
              ],),
            )
          ],
        )),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



class CardScrollWidget extends StatelessWidget {

  var currentPage;
  var padding=20.0;
var verticalInset=20.0;
  CardScrollWidget(this.currentPage);
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context,constraints){
        var width=constraints.maxWidth;
        var height=constraints.maxHeight;
        var safeWidth=width-2*padding;
        var safeHeight=height-2*padding;

        var heightOfPrimaryCard=safeHeight;
        var widthOfPrimaryCard=heightOfPrimaryCard*cardAspectRatio;

        var primaryCardLeft=safeWidth-widthOfPrimaryCard;
        var horizontalInset=primaryCardLeft/2;
List<Widget> cardList=new List();
        for(var i=0; i<images.length;i++){
          var delta= i-currentPage;
          bool isOnRight=delta>0;
          var start=padding+max(primaryCardLeft-horizontalInset*-delta*(isOnRight?15:1),0.0);
          var cardItem=Positioned.directional(top:padding+verticalInset*max(-delta,0.0), 
          bottom: padding+verticalInset*max(-delta,0.0),
          start:start,
          textDirection: TextDirection.rtl,
          child: Container(
            child: AspectRatio(aspectRatio: cardAspectRatio,
            child: Stack(
              fit:StackFit.expand,
              children: [Image.asset(images[i],fit: BoxFit.cover,)],
            ),),
          ),);
          cardList.add(cardItem);
        }
        return Stack(children:cardList);
      }),
    );
  }
}