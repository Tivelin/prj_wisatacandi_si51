class ProfileInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool showEditIcon;
  final VoidCallback? onEditPressed;
  final Color iconColor;

  const ProfileInfoItem({super.key, 
  required this.icon,
  required this.label,
  required this.value,
  this.showEditIcon = false,
  this.onEditPressed,
  required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ()
  }
}