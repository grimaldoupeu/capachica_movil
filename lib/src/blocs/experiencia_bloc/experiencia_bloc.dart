import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/experiencia/experiencia_model.dart';
import '../../../models/experiencia/reserva_experiencia_model.dart';
import '../../../models/reserva/reserva_model.dart' show EstadoReserva; // For mock state
import '../../../services/experiencia_service/experiencia_service.dart'; // Placeholder

part 'experiencia_event.dart';
part 'experiencia_state.dart';

class ExperienciaBloc extends Bloc<ExperienciaEvent, ExperienciaState> {
  final ExperienciaService _experienciaService;

  ExperienciaBloc(this._experienciaService) : super(ExperienciasInitial()) {
    on<LoadExperiencias>(_onLoadExperiencias);
    on<LoadExperienciaDetails>(_onLoadExperienciaDetails);
    on<CreateReservaExperiencia>(_onCreateReservaExperiencia);
    on<CreateExperiencia>(_onCreateExperiencia);
    on<UpdateExperiencia>(_onUpdateExperiencia);
    on<DeleteExperiencia>(_onDeleteExperiencia);
    on<LoadUserReservasExperiencia>(_onLoadUserReservasExperiencia);
  }

  Future<void> _onLoadExperiencias(LoadExperiencias event, Emitter<ExperienciaState> emit) async {
    emit(ExperienciasLoading());
    try {
      // final experiencias = await _experienciaService.getExperiencias(categoria: event.categoria);
      await Future.delayed(const Duration(seconds: 1)); // Simulate
      var mockExperiencias = _getMockExperiencias();
      if (event.categoria != null) {
        mockExperiencias = mockExperiencias.where((exp) => exp.categoria == event.categoria).toList();
      }
      emit(ExperienciasLoaded(experiencias: mockExperiencias));
    } catch (e) {
      emit(ExperienciasError(message: e.toString()));
    }
  }

  Future<void> _onLoadExperienciaDetails(LoadExperienciaDetails event, Emitter<ExperienciaState> emit) async {
    emit(ExperienciaDetailsLoading());
    try {
      // final experiencia = await _experienciaService.getExperienciaDetails(event.experienciaId);
      await Future.delayed(const Duration(seconds: 1)); // Simulate
      final mockExperiencia = _getMockExperiencias().firstWhere((exp) => exp.id == event.experienciaId, orElse: () => _getMockExperiencias().first);
      emit(ExperienciaDetailsLoaded(experiencia: mockExperiencia));
    } catch (e) {
      emit(ExperienciasError(message: e.toString()));
    }
  }

  Future<void> _onCreateReservaExperiencia(CreateReservaExperiencia event, Emitter<ExperienciaState> emit) async {
    emit(ReservaExperienciaInProgress());
    try {
      // final nuevaReserva = await _experienciaService.createReservaExperiencia(...event details...);
      await Future.delayed(const Duration(seconds: 1));
      final nuevaReserva = ReservaExperiencia(
        id: 'res_exp_${DateTime.now().millisecondsSinceEpoch}',
        experienciaId: event.experienciaId,
        usuarioId: event.usuarioId,
        fechaHoraExperiencia: event.fechaHoraExperiencia,
        numeroPersonas: event.numeroPersonas,
        costoTotalReserva: event.costoTotalReserva,
        estado: EstadoReserva.confirmada, // Mock
        fechaCreacionReserva: DateTime.now(),
        notasAdicionales: event.notasAdicionales,
      );
      emit(ReservaExperienciaSuccess(reservaExperiencia: nuevaReserva));
    } catch (e) {
      emit(ReservaExperienciaFailure(message: e.toString()));
    }
  }

  Future<void> _onLoadUserReservasExperiencia(LoadUserReservasExperiencia event, Emitter<ExperienciaState> emit) async {
    emit(UserReservasExperienciaLoading());
    try {
      // final reservas = await _experienciaService.getUserReservasExperiencia(event.usuarioId);
      await Future.delayed(const Duration(seconds: 1));
      final mockReservas = _getMockUserReservasExperiencia(event.usuarioId);
      emit(UserReservasExperienciaLoaded(reservas: mockReservas));
    } catch (e) {
      emit(ExperienciasError(message: 'Error cargando reservas de experiencias: ${e.toString()}'));
    }
  }

  // Admin methods
  Future<void> _onCreateExperiencia(CreateExperiencia event, Emitter<ExperienciaState> emit) async {
    emit(ExperienciasLoading()); // Could be specific AdminOperationLoading state
    try {
      // final nuevaExperiencia = await _experienciaService.createExperiencia(event.experienciaData);
      await Future.delayed(const Duration(seconds: 1));
      // For mock, we assume event.experienciaData already has an ID or service generates one
      emit(ExperienciaOperationSuccess(message: 'Experiencia creada con éxito', experiencia: event.experienciaData));
      add(const LoadExperiencias()); // Refresh list
    } catch (e) {
      emit(ExperienciaOperationFailure(message: e.toString()));
    }
  }

  Future<void> _onUpdateExperiencia(UpdateExperiencia event, Emitter<ExperienciaState> emit) async {
    emit(ExperienciasLoading());
    try {
      // final actualizadaExperiencia = await _experienciaService.updateExperiencia(event.experienciaData);
      await Future.delayed(const Duration(seconds: 1));
      emit(ExperienciaOperationSuccess(message: 'Experiencia actualizada con éxito', experiencia: event.experienciaData));
      add(const LoadExperiencias()); // Refresh list
    } catch (e) {
      emit(ExperienciaOperationFailure(message: e.toString()));
    }
  }

  Future<void> _onDeleteExperiencia(DeleteExperiencia event, Emitter<ExperienciaState> emit) async {
    emit(ExperienciasLoading());
    try {
      // await _experienciaService.deleteExperiencia(event.experienciaId);
      await Future.delayed(const Duration(seconds: 1));
      emit(const ExperienciaOperationSuccess(message: 'Experiencia eliminada con éxito'));
      add(const LoadExperiencias()); // Refresh list
    } catch (e) {
      emit(ExperienciaOperationFailure(message: e.toString()));
    }
  }

  List<Experiencia> _getMockExperiencias() {
    return [
      Experiencia(id: 'exp1', nombre: 'Tour en Kayak por Uros', descripcion: 'Explora las islas flotantes de los Uros en kayak.', lugarEncuentro: 'Muelle de Puno', duracionEstimadaHoras: 3, precioPorPersona: 80.0, anfitrionId: 'comunidad_uros', categoria: CategoriaExperiencia.tourGuiado, capacidadMaximaPersonas: 10, incluye: ['Kayak', 'Guía', 'Chaleco Salvavidas'], fotos: [const FotoExperiencia(id:'fexp1', url: 'https://via.placeholder.com/300x200.png?text=Kayak+Uros')]),
      Experiencia(id: 'exp2', nombre: 'Taller de Textiles en Taquile', descripcion: 'Aprende técnicas ancestrales de tejido con artesanos locales.', lugarEncuentro: 'Plaza de Taquile', duracionEstimadaHoras: 4, precioPorPersona: 120.0, anfitrionId: 'cooperativa_taquile', categoria: CategoriaExperiencia.tallerCultural, capacidadMaximaPersonas: 8, incluye: ['Materiales', 'Instructor'], calificacionPromedio: 4.8, fotos: [const FotoExperiencia(id:'fexp2', url: 'https://via.placeholder.com/300x200.png?text=Textiles+Taquile')]),
      Experiencia(id: 'exp3', nombre: 'Pachamanca Tradicional', descripcion: 'Participa y degusta una auténtica Pachamanca.', lugarEncuentro: 'Comunidad de Llachón', duracionEstimadaHoras: 5, precioPorPersona: 150.0, anfitrionId: 'familia_mamani', categoria: CategoriaExperiencia.gastronomia, capacidadMaximaPersonas: 15, incluye: ['Comida Completa', 'Bebidas Naturales'], calificacionPromedio: 4.9, fotos: [const FotoExperiencia(id:'fexp3', url: 'https://via.placeholder.com/300x200.png?text=Pachamanca')]),
    ];
  }

  List<ReservaExperiencia> _getMockUserReservasExperiencia(String usuarioId) {
    return [
      ReservaExperiencia(id: 'resexp1', experienciaId: 'exp1', usuarioId: usuarioId, fechaHoraExperiencia: DateTime.now().add(const Duration(days: 7, hours: 10)), numeroPersonas: 2, costoTotalReserva: 160.0, estado: EstadoReserva.confirmada, fechaCreacionReserva: DateTime.now().subtract(const Duration(days:1))),
      ReservaExperiencia(id: 'resexp2', experienciaId: 'exp3', usuarioId: usuarioId, fechaHoraExperiencia: DateTime.now().subtract(const Duration(days: 3, hours: 12)), numeroPersonas: 4, costoTotalReserva: 600.0, estado: EstadoReserva.completada, fechaCreacionReserva: DateTime.now().subtract(const Duration(days:5))),
    ];
  }
}
