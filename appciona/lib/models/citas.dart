
class Cita {
  String? uid;
  String? UsuarioId;
  String? Titulo;
  String? Descripcion;
  String? Estado;
  String? Tipo;
  String? Ciudad;
  String? Gobernante;
  DateTime Fecha;

  Cita(
      {this.uid,
        this.UsuarioId,
        this.Titulo,
        this.Descripcion,
        this.Estado,
        this.Tipo,
        this.Ciudad,
        this.Gobernante,
        required this.Fecha});
}
