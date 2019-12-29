import 'package:bookhouse2/screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OnBoardingPage();
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key key}) : super(key: key);

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => Home()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.only(top: 5),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('مقدمة'),
      ),
      body: SafeArea(
        
        child: Container(
          margin: EdgeInsets.only(top: 50),
          child: IntroductionScreen(
            
            pages: [
              PageViewModel(
                title: "مكتبة دار الكتب",
                body: "أول مكتبة تستخدم برنامج مكتبيتي للتصفح والبحث",
                image: Image.asset('assets/m1.png'),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "البحث",
                body:
                    "يمكنك الأن البحث بين ألاف الكتب عن طريق كتابة اسم عنوان الكتاب",
                image: Image.asset('assets/m2.png'),
                /* footer: RaisedButton(
                  onPressed: () {/* Nothing */},
                  child: const Text(
                    'FooButton',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ), */

                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "التصفح",
                body: "الأن يمكنك تصفح جميع الكتب بطرق مختلفة",
                image: Image.asset('assets/m3.png'),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "مشاهدة",
                body: "الكتب الاكثر مبيعا, العروض المختلفة وجميع الاقسام المكتبة",
                image: Image.asset('assets/m3.png'),
                footer: RaisedButton(
                  onPressed: () {/* Nothing */},
                  child: const Text(
                    'FooButton',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "Title of last page",
                bodyWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Click on ", style: bodyStyle),
                    Icon(Icons.edit),
                    Text(" to edit a post", style: bodyStyle),
                  ],
                ),
                //  image: _buildImage('img1'),
                decoration: pageDecoration,
              ),
            ],
            onDone: () => _onIntroEnd(context),
            //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
            showSkipButton: true,
            skipFlex: 0,
            nextFlex: 0,
            skip: const Text('تخطي'),
            next: const Icon(Icons.arrow_forward),
            done: const Text('تم', style: TextStyle(fontWeight: FontWeight.w600)),
            dotsDecorator: const DotsDecorator(
              size: Size(10.0, 10.0),
              color: Color(0xFFBDBDBD),
              activeSize: Size(22.0, 10.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
