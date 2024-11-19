import 'package:flutter/material.dart';
import 'dart:async'; // For Timer functionality

void main() {
  runApp(const RailwayNavigationApp());
}

class RailwayNavigationApp extends StatelessWidget {
  const RailwayNavigationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Railway Navigation',
      theme: ThemeData(
        brightness: Brightness.dark,
        cardColor: const Color.fromARGB(255, 70, 3, 255),
        fontFamily: 'CourierPrime',
      ),
      home: const SplashScreen(), // Set SplashScreen as the home
    );
  }
}


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const NavigationMainPage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/welcome_background.jpg'), // Add your image path here
            fit: BoxFit.cover, // Ensures the image covers the entire screen
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _animation,
                child: const Text(
                  'PRAVAAH',
                  style: TextStyle(
                    color: Color.fromARGB(255, 70, 3, 255),
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'CourierPrime',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Welcome to Railway Navigator',
                style: TextStyle(
                  color: Color.fromARGB(255, 70, 3, 255),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'CourierPrime',
                ),
              ),
              const SizedBox(height: 30),
              const CircularProgressIndicator(
                color: Color.fromARGB(255, 70, 3, 255),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Main Page with Navigation Bar
class NavigationMainPage extends StatefulWidget {
  const NavigationMainPage({super.key});

  @override
  _NavigationMainPageState createState() => _NavigationMainPageState();
}

class _NavigationMainPageState extends State<NavigationMainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const WelcomePage(),
    const SearchPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Railway Navigator", style: TextStyle(fontFamily: 'CourierPrime')),
        backgroundColor: const Color.fromARGB(255, 0, 20, 199),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(color:  Color.fromARGB(255, 0, 20, 199)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'CourierPrime',
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.chat, color: Color.fromARGB(255, 0, 20, 199)),
                title: const Text('Chatbot', style: TextStyle(color: Colors.deepPurpleAccent)),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChatbotPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.contacts, color: Color.fromARGB(255, 0, 20, 199)),
                title: const Text('Emergency Contacts', style: TextStyle(color: Colors.deepPurpleAccent)),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EmergencyContactsPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.email, color:  Color.fromARGB(255, 0, 20, 199)),
                title: const Text('Emergency Emails', style: TextStyle(color: Colors.deepPurpleAccent)),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EmergencyEmailsPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Add the rest of your pages such as ChatbotPage, EmergencyContactsPage, EmergencyEmailsPage, 
// WelcomePage, SearchPage, ProfilePage, LoginPage, and SignUpPage below.

class ChatbotPage extends StatelessWidget {
  const ChatbotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chatbot", style: TextStyle(fontFamily: 'CourierPrime')),
        backgroundColor:  const Color.fromARGB(255, 70, 3, 255),
      ),
      body: const Center(
        child: Text(
          'Chatbot functionality here!',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}

class EmergencyContactsPage extends StatelessWidget {
  const EmergencyContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency Contacts", style: TextStyle(fontFamily: 'CourierPrime')),
        backgroundColor: const Color.fromARGB(255, 70, 3, 255),
      ),
      body: const Center(
        child: Text(
          'Emergency contacts will be displayed here.',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}


class EmergencyEmailsPage extends StatelessWidget {
  const EmergencyEmailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency Emails", style: TextStyle(fontFamily: 'CourierPrime')),
        backgroundColor: const Color.fromARGB(255, 70, 3, 255),
      ),
      body: const Center(
        child: Text(
          'Emergency email addresses will be displayed here.',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}



// Welcome Page
// Welcome Page
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '',
              style: TextStyle(
                color: Color.fromARGB(255, 70, 3, 255),
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'CourierPrime',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'नमस्ते',
              style: TextStyle(
                color: Color.fromARGB(255, 70, 3, 255),
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'CourierPrime',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Updated Select Station input field
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Select Station',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 70, 3, 255)),
                  prefixIcon: Icon(Icons.train, color: Color.fromARGB(255, 70, 3, 255)),
                  suffixIcon: Icon(Icons.search, color: Color.fromARGB(255, 70, 3, 255)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 70, 3, 255)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 70, 3, 255)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 70, 3, 255),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: () {
                // Implement start navigation functionality
              },
              child: const Text(
                'Start Navigation',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'CourierPrime',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Search Page with Clickable Options
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _options = [
    {"icon": Icons.hotel, "label": "Hotels", "color": Colors.blueGrey},
    {"icon": Icons.nature_people, "label": "Picnic Spots", "color": Colors.teal},
    {"icon": Icons.shopping_cart, "label": "Shopping", "color": Colors.purple},
    {"icon": Icons.restaurant, "label": "Restaurants", "color": Colors.redAccent},
  ];

  late final AnimationController _controller;
  final List<int> _visibleItems = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _startAnimation();
  }

  void _startAnimation() async {
    for (int i = 0; i < _options.length; i++) {
      await Future.delayed(const Duration(milliseconds: 300));
      setState(() {
        _visibleItems.add(i);
      });
    }
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Search Nearby",
          style: TextStyle(fontFamily: 'CourierPrime'),
        ),
        backgroundColor: const Color.fromARGB(255, 70, 3, 255),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _options.length,
        itemBuilder: (context, index) {
          return _visibleItems.contains(index)
              ? _buildAnimatedOption(index, _options[index])
              : const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildAnimatedOption(int index, Map<String, dynamic> option) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0), // Start from off-screen (left)
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(index * 0.1, 1.0, curve: Curves.easeOut),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchResultPage(option["label"])),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: option["color"]?.withOpacity(0.8),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                option["label"],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'CourierPrime',
                ),
              ),
              Icon(option["icon"], size: 40, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchResultPage extends StatelessWidget {
  final String label;

  const SearchResultPage(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(label),
        backgroundColor: const Color.fromARGB(255, 70, 3, 255),
      ),
      body: Center(
        child: Text(
          'Results for $label',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// Placeholder Page for Search Results
// class SearchResultPage extends StatelessWidget {
//   final String label;
//   const SearchResultPage(this.label, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text("$label Results", style: const TextStyle(fontFamily: 'CourierPrime')),
//         backgroundColor: Color.fromARGB(255, 70, 3, 255),
//       ),
//       body: Center(
//         child: Text(
//           'Results for $label',
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'CourierPrime',
//           ),
//         ),
//       ),
//     );
//   }
// }

// Profile Page
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(fontFamily: 'CourierPrime')),
        backgroundColor:  const Color.fromARGB(255, 70, 3, 255),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 70, 3, 255),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text(
                'Sign In',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'CourierPrime',
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 70, 3, 255),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'CourierPrime',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Login Page
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Login', style: TextStyle(fontFamily: 'CourierPrime')),
        backgroundColor: const Color.fromARGB(255, 70, 3, 255),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign in to your account',
                style: TextStyle(
                  color: Color.fromARGB(255, 70, 3, 255),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'CourierPrime',
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email, color: Color.fromARGB(255, 70, 3, 255)),
                ),
              ),
              const SizedBox(height: 15),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock, color: Color.fromARGB(255, 70, 3, 255)),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 70, 3, 255),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                onPressed: () {},
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Forgot Password?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Sign Up Page
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Sign Up', style: TextStyle(fontFamily: 'CourierPrime')),
        backgroundColor:  const Color.fromARGB(255, 70, 3, 255),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 70, 3, 255)),
                ),
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email, color: Color.fromARGB(255, 70, 3, 255)),
                ),
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  prefixIcon: Icon(Icons.phone, color: Color.fromARGB(255, 70, 3, 255)),
                ),
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock, color: Color.fromARGB(255, 70, 3, 255)),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock, color: Color.fromARGB(255, 70, 3, 255)),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:  const Color.fromARGB(255, 70, 3, 255),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                onPressed: () {},
                child: const Text('Confirm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


