import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sipao/view/etc/welcome_page.dart';

class OnboardingScreen extends StatelessWidget {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Selamat Datang di SIPAO",
          body:
              "Temukan kenyamanan dalam penyewaan arena olahraga secara cepat dan mudah dengan [Nama Aplikasi]. Temukan tempat ideal untuk aktivitas olahraga Anda dan kelola reservasi dengan lancar",
          image: Image.asset("assets/images/on/1.png"),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Sora',
            ),
            bodyTextStyle: TextStyle(
              fontSize: 16,
              fontFamily: 'Sora',
            ),
            imagePadding: EdgeInsets.symmetric(
              horizontal: 80,
              vertical: 80,
            ),
          ),
        ),
        PageViewModel(
          title: "Jelajahi Arena Olahraga Terbaik",
          body:
              "Temukan berbagai arena olahraga berkualitas tinggi di sekitar Anda. Dari lapangan futsal modern hingga lapangan tenis yang nyaman, SIPAO membawa pengalaman penyewaan yang tak terlupakan untuk setiap jenis olahraga.",
          image: Image.asset("assets/images/on/2.png"),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Sora',
            ),
            bodyTextStyle: TextStyle(
              fontSize: 16,
              fontFamily: 'Sora',
            ),
            imagePadding: EdgeInsets.symmetric(
              horizontal: 80,
              vertical: 80,
            ),
          ),
        ),
        PageViewModel(
          title: "Pesan Sekarang, Mainkan Sebentar Lagi",
          body:
              "Dengan SIPAO, Anda dapat dengan mudah memesan arena olahraga favorit Anda. Nikmati fleksibilitas dalam jadwal dan lihat secara langsung ketersediaan tempat. Mulai petualangan olahraga Anda sekarang!",
          image: Image.asset("assets/images/on/3.png"),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Sora',
            ),
            bodyTextStyle: TextStyle(
              fontSize: 16,
              fontFamily: 'Sora',
            ),
            imagePadding: EdgeInsets.symmetric(
              horizontal: 80,
              vertical: 80,
            ),
          ),
        ),
      ],
      onDone: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const WelcomePage()),
            (route) => false);
      },
      onSkip: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const WelcomePage()),
            (route) => false);
      },
      showSkipButton: true,
      skip: const Text(
        "Lewati",
        style: TextStyle(fontFamily: 'Sora', color: Colors.grey),
      ),
      next: const Icon(
        EvaIcons.arrowForwardOutline,
        color: Color(0xFF141E46),
      ),
      done: const Text(
        "Selesai",
        style: TextStyle(
          fontFamily: 'Sora',
          fontWeight: FontWeight.bold,
          color: Color(0xFF141E46),
        ),
      ),
      dotsDecorator: const DotsDecorator(
        activeColor: Color(0xFF141E46),
      ),
    );
  }
}
