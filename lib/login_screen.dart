// import 'package:flutter/material.dart';
// import 'package:adaptive_theme/adaptive_theme.dart';
// import 'package:loop_lab/Widgets/app_colors.dart';
// import 'package:loop_lab/Widgets/navigation_provider.dart';
// import 'package:loop_lab/widgets/navigation_provider.dart'; // Corrected import path

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   String? _selectedRole;
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   void _login() {
//     // Implement your login logic here
//     // For now, just navigate to the dashboard
//     if (_selectedRole != null && _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => NavigationProviderWrapper(userRole: _selectedRole!), // Navigate to NavigationProviderWrapper
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please select a role and enter credentials.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
//     final textColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
//     final secondaryTextColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
//     final inputFillColor = isDark ? AppColors.darkCardBackground : Colors.grey[100];

//     return Scaffold(
//       backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Logo or App Title
//               Icon(
//                 Icons.school_outlined,
//                 size: 100,
//                 color: AppColors.primaryBlue,
//               ),
//               const SizedBox(height: 24),
//               Text(
//                 'Welcome to LoopLab',
//                 style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                   color: textColor,
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 'Sign in to continue',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: secondaryTextColor,
//                 ),
//               ),
//               const SizedBox(height: 40),

//               // Role Selection
//               Text(
//                 'Select Your Role',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: textColor,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _buildRoleButton('Student', Icons.person_outline, isDark, textColor, secondaryTextColor),
//                   _buildRoleButton('Teacher', Icons.school_outlined, isDark, textColor, secondaryTextColor),
//                   _buildRoleButton('Admin', Icons.admin_panel_settings_outlined, isDark, textColor, secondaryTextColor),
//                 ],
//               ),
//               const SizedBox(height: 32),

//               // Email Input
//               TextField(
//                 controller: _emailController,
//                 keyboardType: TextInputType.emailAddress,
//                 style: TextStyle(color: textColor),
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   labelStyle: TextStyle(color: secondaryTextColor),
//                   hintText: 'Enter your email',
//                   hintStyle: TextStyle(color: secondaryTextColor.withOpacity(0.7)),
//                   prefixIcon: Icon(Icons.email_outlined, color: secondaryTextColor),
//                   filled: true,
//                   fillColor: inputFillColor,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide(color: AppColors.primaryBlue, width: 2),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Password Input
//               TextField(
//                 controller: _passwordController,
//                 obscureText: true,
//                 style: TextStyle(color: textColor),
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   labelStyle: TextStyle(color: secondaryTextColor),
//                   hintText: 'Enter your password',
//                   hintStyle: TextStyle(color: secondaryTextColor.withOpacity(0.7)),
//                   prefixIcon: Icon(Icons.lock_outline, color: secondaryTextColor),
//                   filled: true,
//                   fillColor: inputFillColor,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide(color: AppColors.primaryBlue, width: 2),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton(
//                   onPressed: () {
//                     // Handle forgot password
//                   },
//                   child: Text(
//                     'Forgot Password?',
//                     style: TextStyle(color: AppColors.primaryBlue),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 32),

//               // Login Button
//               SizedBox(
//                 width: double.infinity,
//                 height: 56,
//                 child: ElevatedButton(
//                   onPressed: _login,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primaryBlue,
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     elevation: 0,
//                   ),
//                   child: const Text(
//                     'Login',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),

//               // Social Login Options
//               Text(
//                 'Or continue with',
//                 style: TextStyle(color: secondaryTextColor),
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _buildSocialButton(Icons.g_mobiledata, 'Google', isDark, textColor),
//                   const SizedBox(width: 20),
//                   _buildSocialButton(Icons.apple, 'Apple', isDark, textColor),
//                 ],
//               ),
//               const SizedBox(height: 24),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Don\'t have an account?',
//                     style: TextStyle(color: secondaryTextColor),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       // Navigate to signup screen
//                     },
//                     child: Text(
//                       'Sign Up',
//                       style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ]
//                 ),
//               ],
//             ),
//           ),
//         ),
//     );
//   }

//   Widget _buildRoleButton(String role, IconData icon, bool isDark, Color textColor, Color secondaryTextColor) {
//     final isSelected = _selectedRole == role;
//     final buttonColor = isSelected
//         ? AppColors.primaryBlue
//         : (isDark ? AppColors.darkCardBackground : Colors.white);
//     final iconColor = isSelected ? Colors.white : AppColors.primaryBlue;
//     final buttonTextColor = isSelected ? Colors.white : textColor;
//     final borderColor = isSelected
//         ? AppColors.primaryBlue
//         : (isDark ? AppColors.darkBorder : AppColors.lightBorder);

//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedRole = role;
//         });
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         decoration: BoxDecoration(
//           color: buttonColor,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: borderColor, width: 1.5),
//           boxShadow: [
//             if (isSelected)
//               BoxShadow(
//                 color: AppColors.primaryBlue.withOpacity(0.3),
//                 blurRadius: 8,
//                 offset: const Offset(0, 4),
//               ),
//           ],
//         ),
//         child: Column(
//           children: [
//             Icon(icon, size: 30, color: iconColor),
//             const SizedBox(height: 8),
//             Text(
//               role,
//               style: TextStyle(
//                 color: buttonTextColor,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSocialButton(IconData icon, String text, bool isDark, Color textColor) {
//     return OutlinedButton.icon(
//       onPressed: () {
//         // Handle social login
//       },
//       style: OutlinedButton.styleFrom(
//         side: BorderSide(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//       ),
//       icon: Icon(icon, color: textColor),
//       label: Text(
//         text,
//         style: TextStyle(color: textColor, fontSize: 16),
//       ),
//     );
//   }
// }
