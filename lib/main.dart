import 'package:flutter/material.dart';
import 'dart:async'; // For Timer functionality
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_cube/flutter_cube.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  State<SplashScreen> createState() => _SplashScreenState();
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
                    color: Color.fromARGB(255, 0, 20, 199),
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
                  color: Color.fromARGB(255, 0, 20, 199),
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
  State<NavigationMainPage> createState() => _NavigationMainPageState();
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
                title: const Text('Chatbot', style: TextStyle(color: Color.fromARGB(255, 0, 20, 199))),
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
        backgroundColor: Color.fromARGB(255, 0, 20, 199),
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
        backgroundColor:  Color.fromARGB(255, 0, 20, 199),
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
        backgroundColor: Color.fromARGB(255, 0, 20, 199),
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

class LocalizationService {
  static final Map<String, Map<String, String>> _localizedStrings = {
    'English': {
      'welcome': 'Welcome',
      'namaste': 'Namaste',
      'select_station': 'Select Station',
      'start_navigation': 'Start Navigation',
      'navigation_started': 'Navigation Started',
      'view_3d_model': 'View 3D Model',
      'welcome_message': 'Welcome to Railway Navigation App. Select your station to start.',
    },
    'हिंदी (Hindi)': {
      'welcome': 'स्वागत है',
      'namaste': 'नमस्ते',
      'select_station': 'स्टेशन चुनें',
      'start_navigation': 'नेविगेशन शुरू करें',
      'navigation_started': 'नेविगेशन शुरू हुआ',
      'view_3d_model': '3D मॉडल देखें',
      'welcome_message': 'रेलवे नेविगेशन ऐप में आपका स्वागत है। शुरू करने के लिए अपना स्टेशन चुनें।',
    },
    'मराठी (Marathi)': {
  'welcome': 'स्वागत आहे',
  'namaste': 'नमस्कार',
  'select_station': 'स्टेशन निवडा',
  'start_navigation': 'नेव्हिगेशन सुरू करा',
  'navigation_started': 'नेव्हिगेशन सुरू झाले',
  'view_3d_model': '3D मॉडेल पहा',
  'welcome_message': 'रेल्वे नेव्हिगेशन अॅपमध्ये तुमचे स्वागत आहे. सुरू करण्यासाठी तुमचे स्टेशन निवडा.',
},
'தமிழ் (Tamil)': {
  'welcome': 'வரவேற்கிறோம்',
  'namaste': 'வணக்கம்',
  'select_station': 'நிலையத்தைத் தேர்ந்தெடுக்கவும்',
  'start_navigation': 'வழிகாட்டியை தொடங்கவும்',
  'navigation_started': 'வழிகாட்டி தொடங்கப்பட்டது',
  'view_3d_model': '3D மாதிரியை காண்க',
  'welcome_message': 'ரயில் வழிகாட்டு செயலியில் உங்களை வரவேற்கிறோம். தொடங்க உங்கள் நிலையத்தைத் தேர்ந்தெடுக்கவும்.',
},
'తెలుగు (Telugu)': {
  'welcome': 'స్వాగతం',
  'namaste': 'నమస్తే',
  'select_station': 'స్టేషన్‌ను ఎంచుకోండి',
  'start_navigation': 'నావిగేషన్‌ను ప్రారంభించండి',
  'navigation_started': 'నావిగేషన్ ప్రారంభమైంది',
  'view_3d_model': '3D మోడల్ చూడండి',
  'welcome_message': 'రైల్వే నావిగేషన్ యాప్‌కి స్వాగతం. ప్రారంభించడానికి మీ స్టేషన్‌ను ఎంచుకోండి.',
},
'বাংলা (Bengali)': {
  'welcome': 'স্বাগত',
  'namaste': 'নমস্তে',
  'select_station': 'স্টেশন নির্বাচন করুন',
  'start_navigation': 'নেভিগেশন শুরু করুন',
  'navigation_started': 'নেভিগেশন শুরু হয়েছে',
  'view_3d_model': '3D মডেল দেখুন',
  'welcome_message': 'রেলওয়ে নেভিগেশন অ্যাপে আপনাকে স্বাগত। শুরু করতে আপনার স্টেশন নির্বাচন করুন।',
},
'ગુજરાતી (Gujarati)': {
  'welcome': 'સ્વાગત છે',
  'namaste': 'નમસ્તે',
  'select_station': 'સ્ટેશન પસંદ કરો',
  'start_navigation': 'નેવિગેશન શરૂ કરો',
  'navigation_started': 'નેવિગેશન શરૂ થયું',
  'view_3d_model': '3D મોડલ જુઓ',
  'welcome_message': 'રેલવે નેવિગેશન એપમાં તમારું સ્વાગત છે. શરૂ કરવા માટે તમારું સ્ટેશન પસંદ કરો.',
},
'ਪੰਜਾਬੀ (Punjabi)': {
  'welcome': 'ਸਵਾਗਤ ਹੈ',
  'namaste': 'ਨਮਸਤੇ',
  'select_station': 'ਸਟੇਸ਼ਨ ਚੁਣੋ',
  'start_navigation': 'ਨੇਵੀਗੇਸ਼ਨ ਸ਼ੁਰੂ ਕਰੋ',
  'navigation_started': 'ਨੇਵੀਗੇਸ਼ਨ ਸ਼ੁਰੂ ਹੋ ਗਿਆ ਹੈ',
  'view_3d_model': '3D ਮਾਡਲ ਵੇਖੋ',
  'welcome_message': 'ਰੇਲਵੇ ਨੇਵੀਗੇਸ਼ਨ ਐਪ ਵਿੱਚ ਤੁਹਾਡਾ ਸਵਾਗਤ ਹੈ। ਸ਼ੁਰੂ ਕਰਨ ਲਈ ਆਪਣਾ ਸਟੇਸ਼ਨ ਚੁਣੋ।',
},
'ಕನ್ನಡ (Kannada)': {
  'welcome': 'ಸ್ವಾಗತ',
  'namaste': 'ನಮಸ್ಕಾರ',
  'select_station': 'ನಿಲ್ದಾಣವನ್ನು ಆಯ್ಕೆಮಾಡಿ',
  'start_navigation': 'ನಾವಿಗೇಶನ್ ಪ್ರಾರಂಭಿಸಿ',
  'navigation_started': 'ನಾವಿಗೇಶನ್ ಪ್ರಾರಂಭವಾಯಿತು',
  'view_3d_model': '3D ಮಾದರಿಯನ್ನು ವೀಕ್ಷಿಸಿ',
  'welcome_message': 'ರೈಲು ನಾವಿಗೇಶನ್ ಅಪ್ಲಿಕೇಶನ್‌ಗೆ ಸ್ವಾಗತ. ಪ್ರಾರಂಭಿಸಲು ನಿಮ್ಮ ನಿಲ್ದಾಣವನ್ನು ಆಯ್ಕೆಮಾಡಿ.',
},
'മലയാളം (Malayalam)': {
  'welcome': 'സ്വാഗതം',
  'namaste': 'നമസ്കാരം',
  'select_station': 'സ്റ്റേഷൻ തിരഞ്ഞെടുക്കുക',
  'start_navigation': 'നാവിഗേഷൻ ആരംഭിക്കുക',
  'navigation_started': 'നാവിഗേഷൻ ആരംഭിച്ചു',
  'view_3d_model': '3D മോഡൽ കാണുക',
  'welcome_message': 'റെയിൽവേ നാവിഗേഷൻ ആപ്പിലേക്ക് സ്വാഗതം. ആരംഭിക്കാൻ നിങ്ങളുടെ സ്റ്റേഷൻ തിരഞ്ഞെടുക്കുക.',
},
'ଓଡ଼ିଆ (Odia)': {
  'welcome': 'ସ୍ୱାଗତ',
  'namaste': 'ନମସ୍କାର',
  'select_station': 'ସ୍ଟେସନ୍ ବାଛନ୍ତୁ',
  'start_navigation': 'ନେଭିଗେସନ୍ ଆରମ୍ଭ କରନ୍ତୁ',
  'navigation_started': 'ନେଭିଗେସନ୍ ଆରମ୍ଭ ହେଲା',
  'view_3d_model': '3D ମୋଡେଲ୍ ଦେଖନ୍ତୁ',
  'welcome_message': 'ରେଲୱେ ନେଭିଗେସନ୍ ଆପ୍ରେ ଆପଣଙ୍କୁ ସ୍ୱାଗତ। ଆରମ୍ଭ କରିବାକୁ ଆପଣଙ୍କର ସ୍ଟେସନ୍ ବାଛନ୍ତୁ।',
},

    // Add more languages here
  };

  static String _currentLanguage = 'English';

  static Future<void> loadLanguagePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _currentLanguage = prefs.getString('selected_language') ?? 'English';
  }

  static Future<void> setLanguage(String language) async {
    _currentLanguage = language;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', language);
  }

  static String translate(String key) {
    return _localizedStrings[_currentLanguage]?[key] ?? key;
  }

  static String get currentLanguage => _currentLanguage;
}

// Welcome Page
// Welcome Page
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final FlutterTts _flutterTts = FlutterTts();
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _isListening = false;
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    LocalizationService.loadLanguagePreference().then((_) => setState(() {}));
    _setTtsLanguage();
  }

  void _setTtsLanguage() async {
    String ttsLanguage = _getTtsLanguage();
    await _flutterTts.setLanguage(ttsLanguage);
  }

  String _getTtsLanguage() {
    switch (LocalizationService.currentLanguage) {
  case 'हिंदी (Hindi)':
    return 'hi-IN';
  case 'मराठी (Marathi)':
    return 'mr-IN';
  case 'தமிழ் (Tamil)':
    return 'ta-IN';
  case 'తెలుగు (Telugu)':
    return 'te-IN';
  case 'বাংলা (Bengali)':
    return 'bn-IN';
  case 'ગુજરાતી (Gujarati)':
    return 'gu-IN';
  case 'ਪੰਜਾਬੀ (Punjabi)':
    return 'pa-IN';
  case 'ಕನ್ನಡ (Kannada)':
    return 'kn-IN';
  case 'മലയാളം (Malayalam)':
    return 'ml-IN';
  case 'ଓଡ଼ିଆ (Odia)':
    return 'or-IN';
  default:
    return 'en-US';
}

  }

  void _readAloud(String key) async {
    _setTtsLanguage();
    await _flutterTts.speak(LocalizationService.translate(key));
  }

  void _startListening() async {
    if (!_isListening && await _speechToText.initialize()) {
      setState(() => _isListening = true);
      _speechToText.listen(onResult: (result) {
        setState(() => _searchText = result.recognizedWords);
      });
    }
  }

  void _stopListening() {
    setState(() => _isListening = false);
    _speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          LocalizationService.translate('welcome'),
          style: const TextStyle(fontFamily: 'CourierPrime'),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language, color: Colors.white),
            onSelected: (value) {
              setState(() {
                LocalizationService.setLanguage(value);
                _setTtsLanguage();
              });
            },
            itemBuilder: (context) {
              return LocalizationService._localizedStrings.keys
                  .map((lang) => PopupMenuItem(value: lang, child: Text(lang)))
                  .toList();
            },
          ),
          IconButton(
            icon: const Icon(Icons.volume_up, color: Colors.white),
            onPressed: () {
              _readAloud('welcome_message');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocalizationService.translate('welcome'),
              style: const TextStyle(
                color: Color.fromARGB(255, 0, 20, 199),
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'CourierPrime',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              LocalizationService.translate('namaste'),
              style: const TextStyle(
                color: Color.fromARGB(255, 0, 20, 199),
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'CourierPrime',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(text: _searchText),
                      decoration: InputDecoration(
                        labelText: LocalizationService.translate('select_station'),
                        labelStyle: const TextStyle(color: Color.fromARGB(255, 0, 20, 199)),
                        prefixIcon: const Icon(Icons.train, color: Color.fromARGB(255, 0, 20, 199)),
                        suffixIcon: const Icon(Icons.search, color: Color.fromARGB(255, 0, 20, 199)),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 0, 20, 199)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 0, 20, 199)),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _isListening ? Icons.mic : Icons.mic_none,
                      color: const Color.fromARGB(255, 0, 20, 199),
                    ),
                    onPressed: _isListening ? _stopListening : _startListening,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 70, 3, 255),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                _readAloud('navigation_started');
              },
              child: Text(
                LocalizationService.translate('start_navigation'),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'CourierPrime',
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.view_in_ar),
              label: Text(LocalizationService.translate('view_3d_model')),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 70, 3, 255),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ModelViewerScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ModelViewerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('3D Model Viewer'),
      ),
      body: Container(
        color: Colors.white, // Set the background color to white
        child: Center(
          child: Cube(
            onSceneCreated: (Scene scene) {
              final object = Object(fileName: 'assets/models/model.obj');
              object.scale.setValues(100.0, 100.0, 100.0);
              scene.world.add(object);
            },
          ),
        ),
      ),
    );
  }
}

// Search Page with Clickable Options
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
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
//         backgroundcolor: Color.fromARGB(255, 0, 20, 199),
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
                  color: Color.fromARGB(255, 0, 20, 199),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'CourierPrime',
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email, color: Color.fromARGB(255, 0, 20, 199)),
                ),
              ),
              const SizedBox(height: 15),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock, color: Color.fromARGB(255, 0, 20, 199)),
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
                  prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 0, 20, 199)),
                ),
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email, color: Color.fromARGB(255, 0, 20, 199)),
                ),
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  prefixIcon: Icon(Icons.phone, color: Color.fromARGB(255, 0, 20, 199)),
                ),
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock, color: Color.fromARGB(255, 0, 20, 199)),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock, color: Color.fromARGB(255, 0, 20, 199)),
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


