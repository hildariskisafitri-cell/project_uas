import 'package:flutter/material.dart';
import 'package:edu_quiz/core/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 60, bottom: 40),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
                ),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 60, color: AppTheme.primaryColor),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Student User",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "student@example.com",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Level 5 - Pro Learner",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Learning Statistics",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildStatCard("Total Quiz", "24", Icons.quiz_outlined, Colors.blue),
                      const SizedBox(width: 16),
                      _buildStatCard("Avg Score", "85%", Icons.trending_up_rounded, Colors.green),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildStatCard("Achievements", "12", Icons.emoji_events_outlined, Colors.amber),
                      const SizedBox(width: 16),
                      _buildStatCard("Global Rank", "#15", Icons.public_rounded, Colors.purple),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    "Account Settings",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildSettingTile(Icons.person_outline, "Edit Profile"),
                  _buildSettingTile(Icons.notifications_none_rounded, "Notifications"),
                  _buildSettingTile(Icons.dark_mode_outlined, "Dark Mode", isToggle: true),
                  _buildSettingTile(Icons.help_outline_rounded, "Help & Support"),
                  const SizedBox(height: 16),
                  _buildSettingTile(Icons.logout_rounded, "Logout", isDestructive: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 12),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile(IconData icon, String label, {bool isToggle = false, bool isDestructive = false}) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? Colors.red : Colors.black87),
      title: Text(
        label,
        style: TextStyle(color: isDestructive ? Colors.red : Colors.black87),
      ),
      trailing: isToggle 
        ? Switch(value: false, onChanged: (v) {}) 
        : const Icon(Icons.chevron_right_rounded),
      contentPadding: EdgeInsets.zero,
      onTap: () {},
    );
  }
}
