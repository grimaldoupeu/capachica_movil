import 'package:equatable/equatable.dart';

class DashboardStats extends Equatable {
  final int totalUsuarios;
  final int totalAlojamientos;
  final int totalExperiencias;
  final int totalReservasActivas; // Confirmadas o pendientes
  final int totalReservasCompletadas;
  final double ingresosEsteMes; // Simulated

  const DashboardStats({
    required this.totalUsuarios,
    required this.totalAlojamientos,
    required this.totalExperiencias,
    required this.totalReservasActivas,
    required this.totalReservasCompletadas,
    required this.ingresosEsteMes,
  });

  @override
  List<Object?> get props => [
        totalUsuarios,
        totalAlojamientos,
        totalExperiencias,
        totalReservasActivas,
        totalReservasCompletadas,
        ingresosEsteMes,
      ];
}
