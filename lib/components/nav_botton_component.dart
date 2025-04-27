import 'package:flutter/material.dart';
import 'package:recordatorio_aap/styles/colors/app_colors.dart';

class NavBottonComponent extends StatefulWidget {
  const NavBottonComponent({super.key});

  @override
  State<NavBottonComponent> createState() => _NavBottonComponentState();
}

class _NavBottonComponentState extends State<NavBottonComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary, // Fondo azul
      width: double.infinity, // Ocupar todo el ancho
      padding: const EdgeInsets.only(top: 16, left: 30, right: 30, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FilledButton( //add
            onPressed: () {},
            style: FilledButton.styleFrom(
              foregroundColor: AppColors.background,
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: AppColors.background, width: 2),
              ),
            ),
            child: Icon(Icons.add, color: Colors.white),
          ),
          FilledButton( //home
            onPressed: () {},
            style: FilledButton.styleFrom(
              foregroundColor: AppColors.background,
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: AppColors.background, width: 2),
              ),
            ),
            child: Icon(Icons.house, color: Colors.white),
          ),
          FilledButton( //options
            onPressed: () {},
            style: FilledButton.styleFrom(
              foregroundColor: AppColors.background,
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: AppColors.background, width: 2),
              ),
            ),
            child: Icon(Icons.settings, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
