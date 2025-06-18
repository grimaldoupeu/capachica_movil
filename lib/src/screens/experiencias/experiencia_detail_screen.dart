import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../blocs/experiencia_bloc/experiencia_bloc.dart';
// import '../../models/experiencia/experiencia_model.dart';

class ExperienciaDetailScreen extends StatefulWidget {
  final String experienciaId;

  const ExperienciaDetailScreen({super.key, required this.experienciaId});

  @override
  State<ExperienciaDetailScreen> createState() => _ExperienciaDetailScreenState();
}

class _ExperienciaDetailScreenState extends State<ExperienciaDetailScreen> {
  DateTime? _selectedDate;
  int _numeroPersonas = 1;

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<ExperienciaBloc>(context).add(LoadExperienciaDetails(experienciaId: widget.experienciaId));
    print('ExperienciaDetailScreen: Loading details for ID ${widget.experienciaId}');
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 180)), // Experiences usually booked sooner
    );
    if (picked != null && picked != _selectedDate) {
      // Could also add TimePicker if experiences are time-specific
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _bookExperience(Map<String, dynamic> experienciaData) {
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Por favor, selecciona una fecha.')));
      return;
    }
    // String currentUserId = context.read<AuthBloc>().state.user.id; // Example
    String currentUserId = 'mock_user_id_exp_booking';
    double costoTotal = (_numeroPersonas * (experienciaData['precioPorPersona'] as double? ?? 0.0));

    // BlocProvider.of<ExperienciaBloc>(context).add(CreateReservaExperiencia(
    //   experienciaId: widget.experienciaId,
    //   usuarioId: currentUserId,
    //   fechaHoraExperiencia: _selectedDate!, // Add time if needed
    //   numeroPersonas: _numeroPersonas,
    //   costoTotalReserva: costoTotal,
    // ));
    print('Book Experience: ID ${widget.experienciaId}, User: $currentUserId, Date: $_selectedDate, Personas: $_numeroPersonas, Costo: $costoTotal');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reserva de experiencia enviada (placeholder).')));
  }


  @override
  Widget build(BuildContext context) {
    // Placeholder data for an Experiencia
    final mockExperiencia = {
      'id': widget.experienciaId,
      'nombre': 'Tour en Kayak por Uros (Detalle)',
      'descripcion': 'Una aventura inolvidable remando por las tradicionales islas flotantes de los Uros. Aprende sobre su cultura y forma de vida mientras disfrutas del paisaje del Lago Titicaca. Incluye guía local experto y todo el equipo necesario. Duración aproximada de 3 horas.',
      'precioPorPersona': 80.0,
      'anfitrion': {'nombre': 'Comunidad Uros Kayak', 'avatarUrl': 'https://via.placeholder.com/50x50.png?text=HostExp'},
      'lugarEncuentro': 'Muelle principal de Puno (coordinar recogida)',
      'duracionEstimadaHoras': 3.0,
      'categoria': 'Tour Guiado',
      'fotos': [
        {'url': 'https://via.placeholder.com/400x250.png?text=Kayak+Detalle+1'},
        {'url': 'https://via.placeholder.com/400x250.png?text=Kayak+Detalle+2'},
      ],
      'incluye': ['Guía profesional', 'Equipo de kayak (kayak, remo, chaleco)', 'Charla introductoria'],
      'requisitos': 'Saber nadar (básico), protector solar, sombrero.',
      'calificacionPromedio': 4.7,
      'numeroDeResenas': 15,
    };

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(mockExperiencia['nombre'] as String, style: TextStyle(shadows: [Shadow(blurRadius: 2.0)])),
              background: PageView.builder(
                itemCount: (mockExperiencia['fotos'] as List).length,
                itemBuilder: (context, index) {
                  return Image.network(
                    (mockExperiencia['fotos'] as List)[index]['url'] as String,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
             actions: [
              IconButton(icon: Icon(Icons.favorite_border), onPressed: (){ /* Add to favorites */ })
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(mockExperiencia['nombre'] as String, style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Text(' ${mockExperiencia['calificacionPromedio']} (${mockExperiencia['numeroDeResenas']} reseñas) · ${mockExperiencia['categoria']}', style: textTheme.bodyLarge),
                    ]),
                    const Divider(height: 32),
                    Text('Organizado por: ${(mockExperiencia['anfitrion'] as Map)['nombre']}', style: textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text(mockExperiencia['descripcion'] as String, style: textTheme.bodyMedium),
                    const Divider(height: 32),
                    Text('Qué harás', style: textTheme.titleLarge),
                    Text('Duración: ${mockExperiencia['duracionEstimadaHoras']} horas aprox.', style: textTheme.bodyMedium),
                    Text('Lugar de encuentro: ${mockExperiencia['lugarEncuentro']}', style: textTheme.bodyMedium),
                    const SizedBox(height: 8),
                    Text('Incluye:', style: textTheme.titleSmall),
                    for (String item in mockExperiencia['incluye'] as List<String>) ListTile(leading: Icon(Icons.check_circle_outline, color: Colors.green), title: Text(item), dense: true),
                    if ((mockExperiencia['requisitos'] as String?)?.isNotEmpty ?? false) ...[
                        const SizedBox(height: 8),
                        Text('Requisitos:', style: textTheme.titleSmall),
                        Text(mockExperiencia['requisitos'] as String, style: textTheme.bodyMedium),
                    ],
                    const Divider(height: 32),
                    Text('Selecciona Fecha y Participantes', style: textTheme.titleLarge),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                        icon: const Icon(Icons.calendar_today),
                        label: Text(_selectedDate == null ? 'Seleccionar Fecha' : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'),
                        onPressed: () => _selectDate(context),
                    ),
                    Row(
                      children: [
                        const Text('Personas: '),
                        IconButton(icon: const Icon(Icons.remove_circle_outline), onPressed: _numeroPersonas > 1 ? () => setState(() => _numeroPersonas--) : null),
                        Text('$_numeroPersonas'),
                        IconButton(icon: const Icon(Icons.add_circle_outline), onPressed: () => setState(() => _numeroPersonas++)),
                      ],
                    ),
                    const SizedBox(height: 80), // Space for bottom bar
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('\$${(mockExperiencia['precioPorPersona'] as double).toStringAsFixed(2)} PEN', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  Text('por persona', style: textTheme.bodySmall),
                ],
              ),
              ElevatedButton(
                onPressed: () => _bookExperience(mockExperiencia),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
                child: const Text('Reservar Experiencia', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
