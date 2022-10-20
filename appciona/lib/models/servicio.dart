class Mensajeria {
  String? id;
  String? chatDe;
  String? ultimoMensaje;
  String? ultimoRemitente;
  DateTime? ts;
  String? Ciudad;

  Mensajeria({
    this.id,
    this.chatDe,
    this.ultimoMensaje,
    this.ultimoRemitente,
    this.ts,
    this.Ciudad,
  });
}

class Chats {
  String? mensaje;
  String? remitente;
  DateTime? ts;

  Chats({
    this.mensaje,
    this.remitente,
    this.ts,
  });
}

class Servicio {
  String? titulo;
  String? descripcion;
  String? archivo;
  Map<String, String>? ubicacion;
  bool? revisado;
  String? uid;
  String? Ciudad;

  Servicio({
    this.titulo,
    this.descripcion,
    this.archivo,
    this.ubicacion,
    this.revisado,
    this.uid,
    this.Ciudad,
  });
}
