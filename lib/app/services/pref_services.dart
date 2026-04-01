import 'package:shared_preferences/shared_preferences.dart';

class ThemeService{ 
  static const String themekey='isDarkMode';
  static const String userIdKey='userIdKey';
  static const String onboardingKey='onboardingKey';

  Future<void> setDark(bool isDark)async{ 
    final pref=await SharedPreferences.getInstance();
    pref.setBool(themekey, isDark);
  }
  Future<bool> isDarkMode()async{ 
    final pref=await SharedPreferences.getInstance();
   return pref.getBool(themekey)??false;
  }
   Future<void> setUserId(int userId)async{ 
    final pref=await SharedPreferences.getInstance();
     await pref.setInt(userIdKey, userId);
  }
 Future<int?> getUserId()async{ 
     final pref=await SharedPreferences.getInstance();
     return pref.getInt(userIdKey);
    
  }
   Future<void> setOnBoardingSeen(bool seen)async{ 
    final pref=await SharedPreferences.getInstance();
    await pref.setBool(onboardingKey, seen);
  }
   Future<bool> getOnBoardingSeen()async{ 
    final pref=await SharedPreferences.getInstance();
    return pref.getBool(onboardingKey)?? false;
  }
}