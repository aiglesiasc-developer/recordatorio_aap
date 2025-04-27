import 'package:flutter/material.dart';
import 'package:recordatorio_aap/components/nav_botton_component.dart';
import 'package:recordatorio_aap/data/models/opcion_orden_detail.dart';
import 'package:recordatorio_aap/styles/colors/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? _selectedOrder = 1;
  final List<OpcionOrdenDetail> _orders = [
    OpcionOrdenDetail(id: 1, nombre: 'Este día'),
    OpcionOrdenDetail(id: 2, nombre: 'Esta semana'),
    OpcionOrdenDetail(id: 3, nombre: 'Este mes'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calendario",
          style: TextStyle(color: AppColors.background),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: DropdownButtonFormField<int>(
                      value: _selectedOrder,
                      decoration: InputDecoration(
                        labelText: 'Mostrar registro',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      items:
                          _orders.map((OpcionOrdenDetail opcion) {
                            return DropdownMenuItem<int>(
                              value: opcion.id,
                              child: Text(opcion.nombre),
                            );
                          }).toList(),
                      onChanged: (int? newValue) {
                        setState(() {
                          _selectedOrder = newValue;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          NavBottonComponent()
        ],
      ),
    );
  }
}
