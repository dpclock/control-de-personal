import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../firebase_options.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  factory FirebaseService() => _instance;
  FirebaseService._internal();

  FirebaseFirestore? _firestore;
  bool _isInitialized = false;

  // Inicializar Firebase
  static Future<void> initialize() async {
    try {
      print('Iniciando inicialización de Firebase...');
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      print('Firebase inicializado correctamente');
    } catch (e) {
      print('Error al inicializar Firebase: $e');
      throw Exception('No se pudo inicializar Firebase: $e');
    }
  }

  // Obtener instancia de Firestore de forma segura
  FirebaseFirestore? get _firestoreInstance {
    if (_firestore == null) {
      try {
        print('Obteniendo instancia de Firestore...');
        _firestore = FirebaseFirestore.instance;
        _isInitialized = true;
        print('Firestore inicializado correctamente');
      } catch (e) {
        print('Error al obtener instancia de Firestore: $e');
        return null;
      }
    }
    return _firestore;
  }

  // Verificar si Firebase está disponible
  bool get isAvailable {
    try {
      return _firestoreInstance != null && _isInitialized;
    } catch (e) {
      print('Firebase no está disponible: $e');
      return false;
    }
  }

  // Métodos para trabajadores
  Future<List<String>> getTrabajadores() async {
    try {
      print('Intentando obtener trabajadores de Firebase...');
      if (!isAvailable) {
        print('Firebase no está disponible');
        return [];
      }
      
      final firestore = _firestoreInstance;
      if (firestore == null) {
        print('Firestore no está disponible');
        return [];
      }
      
      final snapshot = await firestore.collection('trabajadores').get();
      final trabajadores = snapshot.docs.map((doc) => doc.data()['nombre'] as String).toList();
      print('Trabajadores obtenidos de Firebase: ${trabajadores.length}');
      return trabajadores;
    } catch (e) {
      print('Error al obtener trabajadores: $e');
      return [];
    }
  }

  Future<void> addTrabajador(String nombre) async {
    try {
      print('Intentando agregar trabajador: $nombre');
      if (!isAvailable) {
        print('Firebase no está disponible para agregar trabajador');
        return;
      }
      
      final firestore = _firestoreInstance;
      if (firestore == null) {
        print('Firestore no está disponible');
        return;
      }
      
      // Verificar si ya existe
      final existing = await firestore
          .collection('trabajadores')
          .where('nombre', isEqualTo: nombre)
          .get();
      
      if (existing.docs.isEmpty) {
        print('Agregando trabajador a Firestore: $nombre');
        final docRef = await firestore.collection('trabajadores').add({
          'nombre': nombre,
          'fechaCreacion': FieldValue.serverTimestamp(),
        });
        print('Trabajador agregado exitosamente con ID: ${docRef.id}');
      } else {
        print('Trabajador ya existe en Firebase: $nombre');
      }
    } catch (e) {
      print('Error al agregar trabajador: $e');
      throw Exception('No se pudo agregar el trabajador: $e');
    }
  }

  Future<void> deleteTrabajador(String nombre) async {
    try {
      if (!isAvailable) {
        print('Firebase no está disponible para eliminar trabajador');
        return;
      }
      
      final firestore = _firestoreInstance;
      if (firestore == null) {
        print('Firestore no está disponible');
        return;
      }
      
      final snapshot = await firestore
          .collection('trabajadores')
          .where('nombre', isEqualTo: nombre)
          .get();
      
      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
      print('Trabajador eliminado de Firebase: $nombre');
    } catch (e) {
      print('Error al eliminar trabajador: $e');
      throw Exception('No se pudo eliminar el trabajador: $e');
    }
  }

  // Métodos para obras
  Future<List<String>> getObras() async {
    try {
      print('Intentando obtener obras de Firebase...');
      if (!isAvailable) {
        print('Firebase no está disponible');
        return [];
      }
      
      final firestore = _firestoreInstance;
      if (firestore == null) {
        print('Firestore no está disponible');
        return [];
      }
      
      final snapshot = await firestore.collection('obras').get();
      final obras = snapshot.docs.map((doc) => doc.data()['nombre'] as String).toList();
      print('Obras obtenidas de Firebase: ${obras.length}');
      return obras;
    } catch (e) {
      print('Error al obtener obras: $e');
      return [];
    }
  }

  Future<void> addObra(String nombre) async {
    try {
      print('Intentando agregar obra: $nombre');
      if (!isAvailable) {
        print('Firebase no está disponible para agregar obra');
        return;
      }
      
      final firestore = _firestoreInstance;
      if (firestore == null) {
        print('Firestore no está disponible');
        return;
      }
      
      // Verificar si ya existe
      final existing = await firestore
          .collection('obras')
          .where('nombre', isEqualTo: nombre)
          .get();
      
      if (existing.docs.isEmpty) {
        print('Agregando obra a Firestore: $nombre');
        final docRef = await firestore.collection('obras').add({
          'nombre': nombre,
          'fechaCreacion': FieldValue.serverTimestamp(),
        });
        print('Obra agregada exitosamente con ID: ${docRef.id}');
      } else {
        print('Obra ya existe en Firebase: $nombre');
      }
    } catch (e) {
      print('Error al agregar obra: $e');
      throw Exception('No se pudo agregar la obra: $e');
    }
  }

  Future<void> deleteObra(String nombre) async {
    try {
      if (!isAvailable) {
        print('Firebase no está disponible para eliminar obra');
        return;
      }
      
      final firestore = _firestoreInstance;
      if (firestore == null) {
        print('Firestore no está disponible');
        return;
      }
      
      final snapshot = await firestore
          .collection('obras')
          .where('nombre', isEqualTo: nombre)
          .get();
      
      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
      print('Obra eliminada de Firebase: $nombre');
    } catch (e) {
      print('Error al eliminar obra: $e');
      throw Exception('No se pudo eliminar la obra: $e');
    }
  }

  // Métodos para datos de la tabla
  Future<Map<String, dynamic>> getDatosTabla(String encargado, String mes) async {
    try {
      if (!isAvailable) {
        print('Firebase no está disponible');
        return {};
      }
      
      final firestore = _firestoreInstance;
      if (firestore == null) {
        print('Firestore no está disponible');
        return {};
      }
      
      final snapshot = await firestore
          .collection('datos_tabla')
          .where('encargado', isEqualTo: encargado)
          .where('mes', isEqualTo: mes)
          .get();
      
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.data();
      }
      return {};
    } catch (e) {
      print('Error al obtener datos de tabla: $e');
      return {};
    }
  }

  Future<void> saveDatosTabla(String encargado, String mes, Map<String, dynamic> datos) async {
    try {
      if (!isAvailable) {
        print('Firebase no está disponible para guardar datos de tabla');
        return;
      }
      
      final firestore = _firestoreInstance;
      if (firestore == null) {
        print('Firestore no está disponible');
        return;
      }
      
      // Buscar si ya existe un documento para este encargado y mes
      final existingSnapshot = await firestore
          .collection('datos_tabla')
          .where('encargado', isEqualTo: encargado)
          .where('mes', isEqualTo: mes)
          .get();
      
      if (existingSnapshot.docs.isNotEmpty) {
        // Actualizar documento existente
        final docRef = existingSnapshot.docs.first.reference;
        await docRef.update({
          'datos': datos,
          'fechaActualizacion': FieldValue.serverTimestamp(),
        });
        print('Datos de tabla actualizados en Firebase: $encargado - $mes');
      } else {
        // Crear nuevo documento
        await firestore.collection('datos_tabla').add({
          'encargado': encargado,
          'mes': mes,
          'datos': datos,
          'fechaCreacion': FieldValue.serverTimestamp(),
          'fechaActualizacion': FieldValue.serverTimestamp(),
        });
        print('Datos de tabla guardados en Firebase: $encargado - $mes');
      }
    } catch (e) {
      print('Error al guardar datos de tabla: $e');
      throw Exception('No se pudieron guardar los datos de tabla: $e');
    }
  }

  // Método para sincronizar datos locales con Firebase
  Future<void> syncDataWithFirebase() async {
    try {
      if (!isAvailable) {
        print('Firebase no está disponible para sincronización');
        return;
      }
      
      print('Iniciando sincronización con Firebase...');
      
      // Sincronizar trabajadores
      final trabajadoresFirebase = await getTrabajadores();
      if (trabajadoresFirebase.isEmpty) {
        print('Agregando trabajadores iniciales a Firebase...');
        // Si no hay datos en Firebase, agregar los datos iniciales
        final trabajadoresIniciales = [
          'AMAJOU OULD EL ALMI AKKAOUI', 'ENRIQUE GARCIA RODRIGUEZ', 'MOHAMED OHAJJI MOULAY',
          'MOHAMED ANIYA EL MOKADE', 'PEDRO GARCIA MORENO GARCIA MIGUEL', 'FRANCISCO JOSE PIÑERO LAGOS',
          'DIONISIO MADRIDEJOS ALAMO', 'JUAN MARTINEZ CARDOZO', 'MARIO ALBERTO MARTINEZ CARDOZO',
          'PEDRO MONTERO MORENO', 'MIGUEL ANGEL PEREZ NAVAS', 'PEDRO JAVIER FLORES PORTANOVA',
          'ANTONIO PARRA VALLEJO', 'JONAEL DIAZ VARGAS', 'DIEGO HERNANDO PIZARRO DELGADO',
          'JESUS VERBO GALAN', 'AGAPITO PINA SIERRA', 'JUAN JOSE SAMPEDRO MALDONADO',
          'FRANCISCO FERNANDEZ PARRA', 'JOSE RAMON SAGRA MENDOZA', 'VICTOR MANUEL ROMERAL PERULERO',
          'JULIO JOSE BRIEGAS MARQUEZ', 'JORGE CERRO LOPEZ', 'ANTONIO ROMAN PEÑA',
          'DAVID HERNANDEZ LOPEZ', 'DANIEL ARTURO SALVATIERRA ROMAN', 'JUAN MARTINEZ DUEÑAS',
          'JUAN CARLOS ENCARNACION PINEDA', 'MIGUEL ANTONIO MATOS VILLA', 'SERGIO MORENO ARANDA',
          'MHAMED EL BOUAZZATI', 'MANUEL EDGAR BARZALLO NIVELO', 'JACINTO IVAN DUTAN COLT',
          'FERNAN ALONSO GOMEZ VANEGAS', 'DAVID ROMERAL PERULERO', 'SERGIO FILIBERTO TITE GUATO',
          'JOSE JONATHAN MORA GUIJARRO', 'EPIDARO ENCARNACION PINEDA', 'JOSE DE LEON GERALDO',
          'OSCAR ALEJANDRO SILVA YANES', 'JOVANY HERNANDEZ SANCHEZ', 'ABRAHAN AGUILAR SANMARTIN',
          'MILTON MENDEZ MELENDEZ', 'DAVID GARCIA PEÑA', 'DARWIN RICARDO BEDOYA BONE',
          'CRISTIAN RAUL MOSQUERA GALEANO', 'FAVIO VARGAS RIVERA', 'SIDIKI TRAORE',
          'WINSOR ALFREDO VARGAS LEDEZMA', 'MOHAMED BENALI', 'SAYON DIALLO',
          'RENE VARGAS RIVERA', 'VICTOR MANUEL CRIOLLO TONATO', 'YOBANNY LEBRON LEBRON',
          'JESUS QUIROGA SANCHEZ', 'EDWIN BERNARDO FLORES CAMACHO', 'JOSE MARCOS HEREDIA GARCIA',
          'MARIO CESPEDES', 'WILSON LEDEZMA TRUJILLO', 'CRISTIAN JOSE PINEDA CARVAJAL',
          'ABRAHAM MORA GUIJARRO', 'ABDELHAMID BENABDELLAH', 'MIHAEL ANTONIO ABREU JAVIER',
          'JORGE HUMBERTO LIBERIO CARRANZA', 'ROMOLUT STELICA MARILA', 'SEFERINO MARIA ABREU DOMINGUEZ',
          'LUCIO SOLIS ZAMBRANA', 'STERLING BERNARDO ALCANTARA REYES', 'MOHAMED BOUSSTTA',
          'CONSTANTIN ALEXANDRU DOMINTE', 'ROBERT BELTRE SEGURA', 'ABRAHAN AGUILAR ROBLES',
          'HECTOR JULIO REYES MENDEZ', 'RICHARD FREIRE TRONCOSO', 'MIGUEL ANGEL SAUCEDO VILLEGAS',
          'YOSMEL MARTI MORALES', 'CRISTIAN ANDRES TERAN ORELLANA', 'OSSAMA FAHIM',
          'RAMON YVAN CARRERO', 'JONNAR ALBERTO GARCIA ALCEDO', 'VITELO SANCHEZ ROA',
          'ESTHEFANO FELIZ MENDEZ', 'RICHARD JOSE RAMIREZ MORILLO', 'MIGUEL ANGEL SILVA',
          'ORLANDO ISAAC ROA ZAMBRANO', 'LUIS FERNANDO MOSQUERA ARARAT', 'NEFER LEANDRO MONTILVA ROA',
          'JEAN CARLOS PEREZ RAMIREZ', 'YILBER FARLEY CARRERO CARRERO', 'FABIAN EDUARDO TORRES GAONA',
          'CRUZ NOVILLO DIAZ', 'JUAN IGNACIO MONTERO RODRIGUEZ', 'ANGEL FUENTES LOZANO',
          'ANTONIO ALAMO CASAS', 'VICENTE TAPETADO FERNANDEZ', 'EMILIANO MORENO GOMEZ',
          'JUAN CARLOS MORENO FERNANDEZ', 'GERMAN DIAZ TENDE GOMEZ', 'DOMINGO MORA MORALES',
          'ISIDORO MORENO GUTIERREZ', 'BERNARDO CAMUÑAS MORALES', 'MELCHOR DIAZ GOMEZ',
          'JOSE MANUEL GARCIA RODRIGUEZ', 'ANGEL MIGUEL RODRIGUEZ GALAN', 'FRANCISCO SANTIAGO GARCIA',
          'FERNANDO HERNANDEZ SONSECA SANTIAGO', 'JESUS CASAS ALCAZAR', 'IVAN MARTINEZ DUEÑAS',
          'DAVID GUTIERREZ GALLEGO', 'JOSE LUIS GUTIERREZ GALLEGO', 'DAVID BRAZAL PEÑA',
          'ANGEL GALLEGO GONZALEZ', 'JUAN MANUEL GALLEGO GONZALEZ', 'SERGIO FERNANDEZ ROMERO',
          'ANGEL GALLEGO DE LA CRUZ', 'CONSTANTIN DOMINTE', 'RODRIGO PEREZ NAVAS',
          'ABOU EL KACEM HASSANI', 'AHMED OUENNANI', 'JESUS DEL CERRO TAVIRA',
          'MOHAMED ALI DAHOURI', 'XAVIER ARGENIS HERNADEZ LINARES',
          // TOLEBRIK
          'MOHAMED AGHARRAD', 'OSWALDO DANIEL VACA PAREDES', 'IVAN FABIAN INTRIAGO RONQUILLO',
          'RICHARD ALFREDO ROMAN CASTILLO', 'MIGUEL ANGEL REIMUNDO OÑA', 'TEODOR IVANOV VELIKOV',
          'JOSE ANTONIO SIMBAÑA SALTO', 'EMILIO CEJAS GUARDIA', 'MAIKOL YORDI SEJAS BARBA',
          'ALFONSO RODRIGO CUSCO ESQUIVEL', 'DANYER MARTIN ARIAS TRONCOSO', 'AHMED EL AYADI',
          'ZIAN EL AZOUZI', 'WILLIAMS ULICES CACERES GARCIA', 'MARCO ROLANDO PABON DEL SALTO',
          'MOHAMED EL AYADI', 'MILTON BOLIVAR VALAREZO VELEZ', 'CRISTOBAL ALFREDO CASTILLO CASTILLO',
          'OMAR JAIME RODRIGUEZ DURAND', 'ROGELIO FERNANDO PINEDA ALVAREZ', 'MARIO EDUARDO CONDOR PLACENCIA',
          'JUAN ERMITE SENA FLORIAN', 'VERGINEL PATRU', 'AHMED GOUMAIRI', 'MYKOLA KUCHURYAN',
          'PLACIDO MUÑOZ ZAPATA', 'JOSE ANTONIO ESTEVEZ GUZMAN', 'MOHAMED BENAICHI', 'FAUSTINO CHOQUE ROJAS',
          'VENTSISLAV IVANOV VELIKOV', 'FELIX VALLEJOS HEREDIA', 'FRANCISCO JAVIER BRITO BELTRE',
          'PAULA ISABEL GARCIA RODRIGO', 'RIMY COLQUE PANOZO', 'ILIE LEORDEAN', 'RONALDT CONDORI VARGAS',
          'IVAN ARIEL COPA PINTO', 'MARINICA VALER FURDUI', 'ANDREY EMILOV UZUNOV', 'NOURDINE EZZIR',
          'AHMED AGHARRAD', 'ESTEFANIA AGUADO GARCIA SILVESTRE', 'ANGEL DAVID VIQUE VIQUE',
          'AHMED EZZIR', 'ABDELLAH AGHARRAD', 'LUIS GEOVANNY LALANGUI AMAY', 'KEVIN PATRICIO CUSCO ZAMBRANO',
          'FABIAN ALONSO RODRIGUEZ MEZA', 'JAIME MARTINEZ RUBIO', 'PASQUALE TUNDO', 'YERBY PINEDA AGRAMONTE',
          'DANIEL MANGUILLA GONZALEZ', 'FREDY JOSE ARAUJO RANGEL', 'FRANCIS JULIO REYES MENDEZ',
          'ROBERT ANTONIO BELTRE VARGAS', 'EDDY MAIKOL MALDONADO GUTIERREZ', 'ALEX JONATAN VALLEJOS AGUAYO',
          'LISMAR MALDONADO GUTIERREZ', 'FRANK ROMAN FLORES DUGARTE', 'EDWIN PEREZ AGUILAR',
          'HEBER ALEXIS RAMIREZ ARDILA', 'JOSE MANUEL GONZALEZ HERRERA', 'JOSUE MACHACA BARON',
          'ELIEZER BELTRE FIGUEREO', 'ESMAILYN ELIAS BELTRE MENDEZ', 'DARIO ALBERTO HERRERA RODRIGUEZ',
          'IVAN CAMARA SEJAS', 'GEBER ALFONSO BELANDRIA MENDEZ', 'HENDERSON DAVID SUAREZ PEREZ',
          'RUBEN FIGUEREO BELTRE', 'ALEX MARCELO CHOQUE ROMERO', 'OLINTO DANIEL PABON MOLINA',
          'ELBHER JESUS RAMIREZ PERNIA', 'JOSE ALEXIS ROA PEREZ', 'LUIS MANUEL FERNANDEZ FIGUEREO',
          'LUIS FERNANDO HERRERA RODRIGUEZ', 'ENDER LEONEL ANDRADE PEREZ', 'JULIO HEREDIA RODRIGUEZ',
          'FABIAN SISA BELTRE', 'JESUS DANIEL SUAREZ PEREZ', 'ELIAS ALBERTO SEVERINO MONTILLA',
          'ANOUAR AYADI', 'ESIO DE JESUS DAVILA RAMIREZ', 'KEIBER JESUS MEDINA PEREZ',
          'ANGEL ALIRIO RAMIREZ', 'ELIECER LEODAN CASTRO OTERO', 'ANGEL JESUS RAMIREZ PEREZ',
          'CARLOS JULIO REYES FELIZ', 'ALBERTO ANDUJAR BELTRE', 'DEILIN REYES BELTRE',
          'LUIS ALFONSO GUIRIGAY CONTRERAS', 'WALTER XAVIER ROA CEGARRA', 'RAYLE RUBEN RAMIREZ ROMERO',
          'FRANYER JOSUE CONTRERAS MONTILVA', 'KEVIN VALLEJOS AGUADO', 'RICARDO ALBERTO ROA PABON',
          'JESUS ALIRIO ROA REY', 'FREDY JOSE HERNANDEZ PEREIRA', 'DANIEL ANTONIO GARCIA GARCIA',
          'JHON ALEXANDER PABON BUSTAMANTE', 'EDGAR DAVID ROMERO CONTRERAS', 'ISABELO DIAZ TENDERO APARICIO',
          'RAMON L TAPETADO FERNANDEZ', 'ANTONIO FERNANDEZ MORA', 'CIRILO PALOMINO ROMERO',
          'GONZALO GUTIERREZ PALOMINO', 'JOSE ANGEL LOPEZ ALAMO', 'ELEUTERIO GOMEZ MORENO',
          'JOSE ANTONIO CAMPAYA TABACO', 'JULIO FRANCISCO DOMENECH INFANTES', 'JAMAL BENAICHI',
          'MILOUD ZEHRAOUI OUMOUSA', 'CARLOS LINARES MIGUEL', 'SERGIO CASANOVA FERNANDEZ PEINADO',
          'HENDER IVAN SUAREZ RAMIREZ', 'IBRAHIM BOUBEKEUR HAMICI', 'SEGUNDO NELSON VALLADOLID LANCHE',
          'CIRO IGNACIO HERNANDEZ GONZALEZ'
        ];
        
        for (String trabajador in trabajadoresIniciales) {
          await addTrabajador(trabajador);
        }
        print('Trabajadores iniciales agregados a Firebase');
      }

      // Sincronizar obras
      final obrasFirebase = await getObras();
      if (obrasFirebase.isEmpty) {
        print('Agregando obras iniciales a Firebase...');
        // Si no hay datos en Firebase, agregar los datos iniciales
        final obrasIniciales = [
          '210 viviendas Cañaveral', '39 Chalets Julian Camarillo', '45 viviendas Rivas',
          '130 viviendas Villaverde', 'Hotel Las Tablas', '96 viviendas Cañaveral',
          '192 Lofts San Sebastian', '90 viviendas Villaverde', 'Reforma centro de menores',
          '143 viviendas Carabanchel', '106 viviendas Los Berrocales', '36 viviendas Peñagrande',
          '261 Tres Cantos', '65 viviendas Valdebebas', '176 viviendas Pozuelo',
          '134 viviendas Los Berrocales', '8 viviendas Boadilla', '14 viviendas Boadilla',
          '38 viviendas Tres Cantos', '53 viviendas Valdemoro', '160 viviendas Meco',
          '39 viviendas Getafe', '104 viviendas Vallecas', '57 viviendas Leganes',
          '61 viviendas Humanes', '124 viviendas Parla', '80 viviendas Arroyofresno',
          '42 viviendas Arroyofresno', '143 viviendas Alcala', '96 viviendas La Finca',
          '73 viviendas Navalcarnero', '113 viviendas Arganda', '84 viviendas Cañaveral',
          'Nueva sede ONCE', '40 viviendas Las Rozas', '18 viviendas Boadilla del Monte',
          '134 viviendas Leganes', 'Residencia Casa verde', '88 viviendas Planetario',
          '107 viviendas Fernandez Caro', '92 viviendas Valdebebas', '22 viviendas paseo de los Canónigos',
          '15 viviendas', '21 viviendas', '26 viviendas Carabanchel', '158 viviendas Arganda',
          'CONSTRUCTORA', 'Oficinas calle Pradillo', '164 viviendas Cañaveral', '39 viviendas Boadilla',
          '318 viviendas Navalcarnero', '108 viviendas Leganes', '150 viviendas Valdemoro',
          '60 viviendas Villanueva del Pardillo', '48 viviendas Villaviciosa de Odon',
          '19 viviendas Villanueva del Pardillo', '56 viviendas Alcala', '106 viviendas Alto Arenal',
          '24 viviendas La Finca', '48 viviendas Villaverde', '106 viviendas Vallecas',
          'CHM', 'MLN', 'C RICO', 'OBRAS ESPECIALES'
        ];
        
        for (String obra in obrasIniciales) {
          await addObra(obra);
        }
        print('Obras iniciales agregadas a Firebase');
      }
      
      print('Sincronización con Firebase completada');
    } catch (e) {
      print('Error al sincronizar datos: $e');
      throw Exception('Error en la sincronización: $e');
    }
  }

  // Método para verificar el estado de las colecciones en Firebase
  Future<Map<String, int>> verificarColecciones() async {
    try {
      if (!isAvailable) {
        print('Firebase no está disponible para verificar colecciones');
        return {};
      }
      
      final firestore = _firestoreInstance;
      if (firestore == null) {
        print('Firestore no está disponible');
        return {};
      }
      
      // Verificar colección de trabajadores
      final trabajadoresSnapshot = await firestore.collection('trabajadores').get();
      final trabajadoresCount = trabajadoresSnapshot.docs.length;
      
      // Verificar colección de obras
      final obrasSnapshot = await firestore.collection('obras').get();
      final obrasCount = obrasSnapshot.docs.length;
      
      print('Estado de colecciones: Trabajadores: $trabajadoresCount, Obras: $obrasCount');
      
      return {
        'trabajadores': trabajadoresCount,
        'obras': obrasCount,
      };
    } catch (e) {
      print('Error al verificar colecciones: $e');
      return {};
    }
  }

  // Nuevos métodos para manejar trabajadores completos
  Future<List<Map<String, dynamic>>> getTrabajadoresCompletos() async {
    try {
      print('Intentando obtener trabajadores completos de Firebase...');
      if (!isAvailable) {
        print('Firebase no está disponible');
        return [];
      }
      
      final firestore = _firestoreInstance;
      if (firestore == null) {
        print('Firestore no está disponible');
        return [];
      }
      
      final snapshot = await firestore.collection('trabajadores').get();
      final trabajadores = snapshot.docs.map((doc) => doc.data()).toList();
      print('Trabajadores completos obtenidos de Firebase: ${trabajadores.length}');
      return trabajadores;
    } catch (e) {
      print('Error al obtener trabajadores completos: $e');
      return [];
    }
  }

  Future<void> updateTrabajadorCompleto(String nombreOriginal, Map<String, dynamic> datosTrabajador) async {
    try {
      print('Intentando actualizar trabajador completo: $nombreOriginal');
      if (!isAvailable) {
        print('Firebase no está disponible para actualizar trabajador');
        return;
      }
      
      final firestore = _firestoreInstance;
      if (firestore == null) {
        print('Firestore no está disponible');
        return;
      }
      
      // Buscar el documento por nombre original
      final snapshot = await firestore
          .collection('trabajadores')
          .where('nombre', isEqualTo: nombreOriginal)
          .get();
      
      if (snapshot.docs.isNotEmpty) {
        // Actualizar el documento existente
        await snapshot.docs.first.reference.update({
          'nombre': datosTrabajador['nombre'],
          'empresa': datosTrabajador['empresa'],
          'nafIpf': datosTrabajador['nafIpf'],
          'dni': datosTrabajador['dni'],
          'fechaActualizacion': FieldValue.serverTimestamp(),
        });
        print('Trabajador actualizado exitosamente: $nombreOriginal');
      } else {
        // Si no existe, crear uno nuevo
        await firestore.collection('trabajadores').add({
          'nombre': datosTrabajador['nombre'],
          'empresa': datosTrabajador['empresa'],
          'nafIpf': datosTrabajador['nafIpf'],
          'dni': datosTrabajador['dni'],
          'fechaCreacion': FieldValue.serverTimestamp(),
        });
        print('Trabajador creado exitosamente: ${datosTrabajador['nombre']}');
      }
    } catch (e) {
      print('Error al actualizar trabajador completo: $e');
      throw Exception('No se pudo actualizar el trabajador: $e');
    }
  }

  // Nuevos métodos para manejar obras completas
  Future<List<Map<String, dynamic>>> getObrasCompletas() async {
    try {
      print('Intentando obtener obras completas de Firebase...');
      if (!isAvailable) {
        print('Firebase no está disponible');
        return [];
      }
      
      final firestore = _firestoreInstance;
      if (firestore == null) {
        print('Firestore no está disponible');
        return [];
      }
      
      final snapshot = await firestore.collection('obras').get();
      final obras = snapshot.docs.map((doc) => doc.data()).toList();
      print('Obras completas obtenidas de Firebase: ${obras.length}');
      return obras;
    } catch (e) {
      print('Error al obtener obras completas: $e');
      return [];
    }
  }

  Future<void> updateObraCompleta(String obraOriginal, Map<String, dynamic> datosObra) async {
    try {
      print('Intentando actualizar obra completa: $obraOriginal');
      if (!isAvailable) {
        print('Firebase no está disponible para actualizar obra');
        return;
      }
      
      final firestore = _firestoreInstance;
      if (firestore == null) {
        print('Firestore no está disponible');
        return;
      }
      
      // Buscar el documento por nombre original
      final snapshot = await firestore
          .collection('obras')
          .where('nombre', isEqualTo: obraOriginal)
          .get();
      
      if (snapshot.docs.isNotEmpty) {
        // Actualizar el documento existente
        await snapshot.docs.first.reference.update({
          'nombre': datosObra['obra'],
          'constructora': datosObra['constructora'],
          'estado': datosObra['estado'],
          'tipo': datosObra['tipo'],
          'fechaActualizacion': FieldValue.serverTimestamp(),
        });
        print('Obra actualizada exitosamente: $obraOriginal');
      } else {
        // Si no existe, crear uno nuevo
        await firestore.collection('obras').add({
          'nombre': datosObra['obra'],
          'constructora': datosObra['constructora'],
          'estado': datosObra['estado'],
          'tipo': datosObra['tipo'],
          'fechaCreacion': FieldValue.serverTimestamp(),
        });
        print('Obra creada exitosamente: ${datosObra['obra']}');
      }
    } catch (e) {
      print('Error al actualizar obra completa: $e');
      throw Exception('No se pudo actualizar la obra: $e');
    }
  }
} 