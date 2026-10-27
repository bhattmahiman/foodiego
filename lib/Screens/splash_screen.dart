import 'package:flutter/material.dart';
import 'package:foodiego/Screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Image.asset("assets/images/logo.png",width: 150,height: 150,),
                Text("Good Food  •  Better Mood",style: TextStyle(fontSize: 16,color: Colors.black54,fontWeight: FontWeight.bold),),
              ],
            ),
            Image.asset("assets/images/splash_screen_burger.png",width: 400,height: 350,),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30
              ),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF95721),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 55),
                  ),
                  child: Text("Get Started  >",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),)),
            ),
          ],
        ),
      ),
    );
  }
}
