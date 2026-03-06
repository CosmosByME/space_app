import 'package:flutter/material.dart';
import 'package:space_app/data/services/img_picker_service.dart';
import 'package:space_app/presentation/components/icons.dart';
import 'package:space_app/presentation/theme/colors.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({super.key});

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  int selectedTab = 0;

  @override
  void dispose() {
    nameController.dispose();
    userNameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Sub-tab bar: General / Account / Logout
        Container(
          padding: EdgeInsets.symmetric(vertical: 4),
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSubTab("General", 0),
              _buildSubTab("Account", 1),
              _buildSubTab("Logout", 2),
            ],
          ),
        ),

        // Tab content
        if (selectedTab == 0) _buildGeneralTab(),
        if (selectedTab == 1) _buildAccountTab(),
        if (selectedTab == 2) _buildLogoutTab(),
      ],
    );
  }

  Widget _buildSubTab(String label, int index) {
    final isSelected = selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => selectedTab = index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryB100 : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isSelected ? AppColors.primaryB900 : AppColors.neutralB500,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildGeneralTab() {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Avatar upload
          GestureDetector(
            onTap: () => ImgPickerService.pickImage(),
            child: Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: AppColors.primaryB100,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.neutralW400, width: 1),
              ),
              child: Row(
                children: [
                  AppIcons.uploadIcon,
                  SizedBox(width: 12),
                  Text(
                    "Choose an image for avatar",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.neutralB500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Full name
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.neutralW400),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.neutralW400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primaryB900),
              ),
              labelText: "Full name",
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
          SizedBox(height: 16),
          // Username
          TextField(
            controller: userNameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.neutralW400),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.neutralW400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primaryB900),
              ),
              labelText: "Username",
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
          SizedBox(height: 16),
          // Bio
          TextField(
            controller: bioController,
            maxLines: 4,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.neutralW400),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.neutralW400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primaryB900),
              ),
              labelText: "Bio",
              alignLabelWithHint: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
          SizedBox(height: 24),
          // Update button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.semanticG800,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {},
            child: Text("Update Profile"),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountTab() {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _buildAccountOption(
            Icons.email_outlined,
            "Email",
            "robert@example.com",
          ),
          Divider(color: AppColors.neutralW400),
          _buildAccountOption(
            Icons.lock_outline,
            "Password",
            "Change password",
          ),
          Divider(color: AppColors.neutralW400),
          _buildAccountOption(
            Icons.notifications_outlined,
            "Notifications",
            "Manage",
          ),
          Divider(color: AppColors.neutralW400),
          _buildAccountOption(Icons.privacy_tip_outlined, "Privacy", "Manage"),
        ],
      ),
    );
  }

  Widget _buildAccountOption(IconData icon, String title, String subtitle) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppColors.neutralB500, size: 22),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 2),
                Text(
                  subtitle,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.neutralB300),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: AppColors.neutralB300),
        ],
      ),
    );
  }

  Widget _buildLogoutTab() {
    return Container(
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(Icons.logout_rounded, size: 48, color: AppColors.semanticR900),
          SizedBox(height: 16),
          Text(
            "Are you sure you want to log out?",
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.neutralB500),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.semanticR900,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {},
              child: Text("Log Out"),
            ),
          ),
        ],
      ),
    );
  }
}
