import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../blocs/experiencia_bloc/experiencia_bloc.dart';
// import '../../models/experiencia/reserva_experiencia_model.dart';

class UserExperienciasReservadasScreen extends StatefulWidget {
  const UserExperienciasReservadasScreen({super.key});

  @override
  State<UserExperienciasReservadasScreen> createState() => _UserExperienciasReservadasScreenState();
}

class _UserExperienciasReservadasScreenState extends State<UserExperienciasReservadasScreen> {
  @override
  void initState() {
    super.initState();
    // final userId = context.read<AuthBloc>().state.user?.id;
    // if (userId != null) {
    //   BlocProvider.of<ExperienciaBloc>(context).add(LoadUserReservasExperiencia(usuarioId: userId));
    // }
    print('UserExperienciasReservadasScreen: InitState - Placeholder for loading user experience bookings.');
  }

  @override
  Widget build(BuildContext context) {
    final mockReservasExp = [
      {'id': 'resexp1', 'experienciaNombre': 'Tour en Kayak por Uros', 'fechaHora': '2024-04-10 10:00', 'estado': 'Confirmada', 'costoTotal': 160.0, 'numeroPersonas': 2},
      {'id': 'resexp2', 'experienciaNombre': 'Pachamanca Tradicional', 'fechaHora': '2024-03-20 13:00', 'estado': 'Completada', 'costoTotal': 300.0, 'numeroPersonas': 2},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Mis Experiencias Reservadas')),
      // body: BlocBuilder<ExperienciaBloc, ExperienciaState>(
      //   builder: (context, state) {
      //     if (state is UserReservasExperienciaLoading) {
      //       return const Center(child: CircularProgressIndicator());
      //     } else if (state is UserReservasExperienciaLoaded) {
      //       if (state.reservas.isEmpty) {
      //         return const Center(child: Text('No has reservado ninguna experiencia aún.'));
      //       }
      //       return ListView.builder(
      //         itemCount: state.reservas.length,
      //         itemBuilder: (context, index) {
      //           final reserva = state.reservas[index];
      //           // You'd need Experiencia details (name) here, or denormalize
      //           final experienciaNombre = 'Experiencia ID: ${reserva.experienciaId}';
      //           return Card(
      //             margin: const EdgeInsets.all(8.0),
      //             child: ListTile(
      //               title: Text('Reserva para $experienciaNombre'),
      //               subtitle: Text('Fecha: ${reserva.fechaHoraExperiencia.toLocal().toString()}\nPersonas: ${reserva.numeroPersonas}\nEstado: ${reserva.estado.name}'),
      //               trailing: Text('\$${reserva.costoTotalReserva.toStringAsFixed(2)}'),
      //               onTap: () { /* Navigate to ExperienciaDetailScreen(experienciaId: reserva.experienciaId) */ },
      //             ),
      //           );
      //         },
      //       );
      //     } else if (state is ExperienciasError) { // Assuming generic error state
      //       return Center(child: Text('Error: ${state.message}'));
      //     }
      //     return const Center(child: Text('Cargando tus experiencias reservadas...'));
      //   },
      // ),
      body: ListView.builder(
        itemCount: mockReservasExp.length,
        itemBuilder: (context, index) {
          final reserva = mockReservasExp[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(reserva['experienciaNombre'] as String, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text('Fecha y Hora: ${reserva['fechaHora']}', style: Theme.of(context).textTheme.bodyMedium),
                  Text('Personas: ${reserva['numeroPersonas']}', style: Theme.of(context).textTheme.bodyMedium),
                  Text('Estado: ${reserva['estado']}', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                  Text('Costo Total: \$${(reserva['costoTotal'] as double).toStringAsFixed(2)} PEN', style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(onPressed: () {
                        print('View Experiencia details for ${reserva['experienciaNombre']}');
                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Placeholder: Ver detalles de la experiencia')));
                    }, child: const Text('Ver Experiencia')),
                  )
                ],
              ),
            ),
          );
        },
      )
    );
  }
}
