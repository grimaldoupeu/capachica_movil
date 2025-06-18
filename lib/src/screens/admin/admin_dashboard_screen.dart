import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../blocs/admin_bloc/admin_bloc.dart';
// import '../../models/reporte/dashboard_stats_model.dart';
// Import other admin screens
import './manage_usuarios_screen.dart';
import './manage_alojamientos_screen.dart'; // Should exist
import './manage_categorias_alojamiento_screen.dart';
import './manage_servicios_screen.dart'; // Should exist
import './manage_experiencias_screen.dart'; // Should exist
import './view_all_reservas_screen.dart';
import './view_all_pagos_screen.dart';
import './system_reports_screen.dart';


class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  @override
  void initState() {
    super.initState();
    // BlocProvider.of<AdminBloc>(context).add(LoadDashboardStats());
    print('AdminDashboardScreen: Loading dashboard stats (placeholder)');
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                Icon(icon, color: color, size: 28),
              ],
            ),
            const SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildManagementButton(BuildContext context, String title, IconData icon, Widget screen) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 20),
      label: Text(title),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48), // full width
        alignment: Alignment.centerLeft,
        textStyle: const TextStyle(fontSize: 16)
      ),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Mock stats
    const mockStats = {
      'totalUsuarios': 150, 'totalAlojamientos': 35, 'totalExperiencias': 15,
      'totalReservasActivas': 22, 'totalReservasCompletadas': 180, 'ingresosEsteMes': 12550.75
    };
    // final String currentAdminName = context.read<AuthBloc>().state.user?.nombre ?? 'Admin'; // Example

    return Scaffold(
      appBar: AppBar(title: const Text('Panel de Administración')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text('Bienvenido, $currentAdminName!', style: Theme.of(context).textTheme.headlineSmall),
            // const SizedBox(height: 16),
            // Text('Estadísticas Rápidas', style: Theme.of(context).textTheme.titleLarge),
            // const SizedBox(height: 8),
            // BlocBuilder<AdminBloc, AdminState>(
            //   builder: (context, state) {
            //     if (state is AdminLoading && state.message == 'Cargando estadísticas...') {
            //       return const Center(child: CircularProgressIndicator());
            //     } else if (state is DashboardStatsLoaded) {
            //       return GridView.count(
            //         crossAxisCount: 2,
            //         shrinkWrap: true,
            //         physics: const NeverScrollableScrollPhysics(),
            //         crossAxisSpacing: 10,
            //         mainAxisSpacing: 10,
            //         childAspectRatio: 1.8,
            //         children: [
            //           _buildStatCard('Usuarios Totales', state.stats.totalUsuarios.toString(), Icons.people, Colors.blue),
            //           _buildStatCard('Alojamientos', state.stats.totalAlojamientos.toString(), Icons.hotel, Colors.green),
            //           _buildStatCard('Experiencias', state.stats.totalExperiencias.toString(), Icons.celebration, Colors.orange),
            //           _buildStatCard('Reservas Activas', state.stats.totalReservasActivas.toString(), Icons.event_available, Colors.purple),
            //           _buildStatCard('Reservas Completadas', state.stats.totalReservasCompletadas.toString(), Icons.event_busy, Colors.teal),
            //           _buildStatCard('Ingresos Mes', '\$${state.stats.ingresosEsteMes.toStringAsFixed(2)}', Icons.attach_money, Colors.red),
            //         ],
            //       );
            //     } else if (state is AdminError) {
            //       return Text('Error: ${state.message}');
            //     }
            //     return const Text('Cargando estadísticas...');
            //   },
            // ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.0, // Adjust for better card appearance
              children: [
                _buildStatCard('Usuarios Totales', mockStats['totalUsuarios'].toString(), Icons.people_alt_outlined, Colors.blue.shade700),
                _buildStatCard('Alojamientos', mockStats['totalAlojamientos'].toString(), Icons.holiday_village_outlined, Colors.green.shade700),
                _buildStatCard('Experiencias', mockStats['totalExperiencias'].toString(), Icons.emoji_events_outlined, Colors.orange.shade700),
                _buildStatCard('Reservas Activas', mockStats['totalReservasActivas'].toString(), Icons.bookmark_added_outlined, Colors.purple.shade700),
                // _buildStatCard('Reservas Completadas', mockStats['totalReservasCompletadas'].toString(), Icons.history_toggle_off_outlined, Colors.teal.shade700),
                // _buildStatCard('Ingresos Mes', '\$${(mockStats['ingresosEsteMes'] as double).toStringAsFixed(2)}', Icons.monetization_on_outlined, Colors.red.shade700),
              ],
            ),
            const SizedBox(height: 24),
            Text('Gestión del Sistema', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            _buildManagementButton(context, 'Gestionar Usuarios', Icons.manage_accounts_outlined, const ManageUsuariosScreen()),
            const SizedBox(height: 8),
            _buildManagementButton(context, 'Gestionar Alojamientos', Icons.maps_home_work_outlined, const ManageAlojamientosScreen()),
            const SizedBox(height: 8),
            _buildManagementButton(context, 'Gestionar Categorías Alojam.', Icons.category_outlined, const ManageCategoriasAlojamientoScreen()),
            const SizedBox(height: 8),
            _buildManagementButton(context, 'Gestionar Servicios Maestros', Icons.room_service_outlined, const ManageServiciosScreen()),
            const SizedBox(height: 8),
            _buildManagementButton(context, 'Gestionar Experiencias', Icons.explore_outlined, const ManageExperienciasScreen()),
            const SizedBox(height: 8),
            _buildManagementButton(context, 'Ver Todas las Reservas', Icons.event_note_outlined, const ViewAllReservasScreen()),
            const SizedBox(height: 8),
            _buildManagementButton(context, 'Ver Todos los Pagos', Icons.payment_outlined, const ViewAllPagosScreen()),
             const SizedBox(height: 8),
            _buildManagementButton(context, 'Reportes del Sistema', Icons.bar_chart_outlined, const SystemReportsScreen()),
          ],
        ),
      ),
    );
  }
}
