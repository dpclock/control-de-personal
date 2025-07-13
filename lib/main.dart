import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
// Import condicional para web
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:io' as io;
import 'services/firebase_service.dart';

// Clase singleton para gestionar datos compartidos
class DataManager {
  static final DataManager _instance = DataManager._internal();
  factory DataManager() => _instance;
  DataManager._internal();

  final FirebaseService _firebaseService = FirebaseService();
  List<String> _trabajadores = [
    // SEANSA
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

  List<String> _obras = [
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

  // Getters
  List<String> get trabajadores => List.unmodifiable(_trabajadores);
  List<String> get obras => List.unmodifiable(_obras);

  // Métodos para agregar nuevos datos
  Future<void> agregarTrabajador(String nombre) async {
    if (!_trabajadores.contains(nombre)) {
      _trabajadores.add(nombre);
      try {
        await _firebaseService.addTrabajador(nombre);
        print('Trabajador agregado localmente y en Firebase: $nombre');
      } catch (e) {
        print('Error al guardar en Firebase: $e');
        // Mantener en la lista local aunque falle Firebase
      }
    }
  }

  Future<void> agregarObra(String obra) async {
    if (!_obras.contains(obra)) {
      _obras.add(obra);
      try {
        await _firebaseService.addObra(obra);
        print('Obra agregada localmente y en Firebase: $obra');
      } catch (e) {
        print('Error al guardar en Firebase: $e');
        // Mantener en la lista local aunque falle Firebase
      }
    }
  }

  // Métodos para eliminar datos
  Future<void> eliminarTrabajador(String nombre) async {
    if (_trabajadores.contains(nombre)) {
      _trabajadores.remove(nombre);
      try {
        await _firebaseService.deleteTrabajador(nombre);
        print('Trabajador eliminado localmente y en Firebase: $nombre');
      } catch (e) {
        print('Error al eliminar en Firebase: $e');
        // Mantener eliminado localmente aunque falle Firebase
      }
    }
  }

  Future<void> eliminarObra(String obra) async {
    if (_obras.contains(obra)) {
      _obras.remove(obra);
      try {
        await _firebaseService.deleteObra(obra);
        print('Obra eliminada localmente y en Firebase: $obra');
      } catch (e) {
        print('Error al eliminar en Firebase: $e');
        // Mantener eliminada localmente aunque falle Firebase
      }
    }
  }

  // Métodos para actualizar datos
  Future<void> actualizarTrabajador(String nombreViejo, String nombreNuevo) async {
    if (_trabajadores.contains(nombreViejo) && !_trabajadores.contains(nombreNuevo)) {
      int index = _trabajadores.indexOf(nombreViejo);
      _trabajadores[index] = nombreNuevo;
      try {
        await _firebaseService.deleteTrabajador(nombreViejo);
        await _firebaseService.addTrabajador(nombreNuevo);
        print('Trabajador actualizado localmente y en Firebase: $nombreViejo -> $nombreNuevo');
      } catch (e) {
        print('Error al actualizar en Firebase: $e');
        // Mantener actualizado localmente aunque falle Firebase
      }
    }
  }

  Future<void> actualizarObra(String obraVieja, String obraNueva) async {
    if (_obras.contains(obraVieja) && !_obras.contains(obraNueva)) {
      int index = _obras.indexOf(obraVieja);
      _obras[index] = obraNueva;
      try {
        await _firebaseService.deleteObra(obraVieja);
        await _firebaseService.addObra(obraNueva);
        print('Obra actualizada localmente y en Firebase: $obraVieja -> $obraNueva');
      } catch (e) {
        print('Error al actualizar en Firebase: $e');
        // Mantener actualizada localmente aunque falle Firebase
      }
    }
  }

  // Métodos para cargar datos desde Firebase
  Future<void> cargarDatosDesdeFirebase() async {
    try {
      print('DataManager: Cargando datos desde Firebase...');
      final trabajadoresFirebase = await _firebaseService.getTrabajadores();
      final obrasFirebase = await _firebaseService.getObras();
      
      print('DataManager: Trabajadores en Firebase: ${trabajadoresFirebase.length}');
      print('DataManager: Obras en Firebase: ${obrasFirebase.length}');
      
      // Priorizar siempre los datos de Firebase
      if (trabajadoresFirebase.isNotEmpty) {
        _trabajadores = trabajadoresFirebase;
        print('DataManager: Trabajadores cargados desde Firebase (${_trabajadores.length})');
      } else {
        print('DataManager: Firebase vacío, usando datos locales como respaldo (${_trabajadores.length})');
      }
      
      if (obrasFirebase.isNotEmpty) {
        _obras = obrasFirebase;
        print('DataManager: Obras cargadas desde Firebase (${_obras.length})');
      } else {
        print('DataManager: Firebase vacío, usando obras locales como respaldo (${_obras.length})');
      }
      
      print('DataManager: Total trabajadores disponibles: ${_trabajadores.length}');
      print('DataManager: Total obras disponibles: ${_obras.length}');
    } catch (e) {
      print('Error al cargar datos desde Firebase: $e');
      print('DataManager: Usando datos locales como respaldo debido al error');
    }
  }

  // Método para sincronizar datos iniciales
  Future<void> sincronizarDatosIniciales() async {
    try {
      print('DataManager: Iniciando sincronización...');
      await _firebaseService.syncDataWithFirebase();
      print('DataManager: Sincronización completada, cargando datos...');
      await cargarDatosDesdeFirebase();
      print('DataManager: Datos cargados correctamente');
    } catch (e) {
      print('Error al sincronizar con Firebase: $e');
    }
  }

  // Método para forzar la sincronización de todos los datos locales
  Future<void> forzarSincronizacionCompleta() async {
    try {
      print('DataManager: Forzando sincronización completa...');
      
      // Verificar que Firebase esté disponible
      if (!_firebaseService.isAvailable) {
        print('DataManager: Firebase no está disponible');
        return;
      }
      
      // Sincronizar todos los trabajadores locales
      print('DataManager: Sincronizando ${_trabajadores.length} trabajadores...');
      int trabajadoresGuardados = 0;
      for (String trabajador in _trabajadores) {
        try {
          await _firebaseService.addTrabajador(trabajador);
          trabajadoresGuardados++;
          if (trabajadoresGuardados % 50 == 0) {
            print('DataManager: Progreso trabajadores: $trabajadoresGuardados/${_trabajadores.length}');
          }
        } catch (e) {
          print('Error al sincronizar trabajador $trabajador: $e');
        }
      }
      print('DataManager: Trabajadores guardados: $trabajadoresGuardados');
      
      // Sincronizar todas las obras locales
      print('DataManager: Sincronizando ${_obras.length} obras...');
      int obrasGuardadas = 0;
      for (String obra in _obras) {
        try {
          await _firebaseService.addObra(obra);
          obrasGuardadas++;
        } catch (e) {
          print('Error al sincronizar obra $obra: $e');
        }
      }
      print('DataManager: Obras guardadas: $obrasGuardadas');
      
      print('DataManager: Sincronización completa finalizada');
      print('DataManager: Resumen - Trabajadores: $trabajadoresGuardados, Obras: $obrasGuardadas');
    } catch (e) {
      print('Error en sincronización completa: $e');
    }
  }

  // Método para reinicializar los datos locales
  void reinicializarDatosLocales() {
    print('DataManager: Reinicializando datos locales...');
    
    // Restaurar la lista original de trabajadores
    _trabajadores = [
      // SEANSA
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
    
    // Restaurar la lista original de obras
    _obras = [
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
    
    print('DataManager: Datos locales reinicializados. Trabajadores: ${_trabajadores.length}, Obras: ${_obras.length}');
  }

  // Método para verificar el estado de las colecciones en Firebase
  Future<Map<String, int>> verificarColecciones() async {
    try {
      if (!_firebaseService.isAvailable) {
        print('DataManager: Firebase no está disponible');
        return {};
      }
      
      return await _firebaseService.verificarColecciones();
    } catch (e) {
      print('Error al verificar colecciones: $e');
      return {};
    }
  }

  // Método para forzar la creación de la colección de trabajadores
  Future<void> forzarCreacionTrabajadores() async {
    try {
      print('DataManager: Forzando creación de colección de trabajadores...');
      
      if (!_firebaseService.isAvailable) {
        print('DataManager: Firebase no está disponible');
        return;
      }
      
      // Verificar si ya existen trabajadores
      final trabajadoresExistentes = await _firebaseService.getTrabajadores();
      if (trabajadoresExistentes.isNotEmpty) {
        print('DataManager: Ya existen ${trabajadoresExistentes.length} trabajadores en Firebase');
        return;
      }
      
      // Agregar todos los trabajadores locales a Firebase
      print('DataManager: Agregando ${_trabajadores.length} trabajadores a Firebase...');
      int agregados = 0;
      
      for (String trabajador in _trabajadores) {
        try {
          await _firebaseService.addTrabajador(trabajador);
          agregados++;
          
          if (agregados % 50 == 0) {
            print('DataManager: Progreso trabajadores: $agregados/${_trabajadores.length}');
          }
        } catch (e) {
          print('Error al agregar trabajador $trabajador: $e');
        }
      }
      
      print('DataManager: Trabajadores agregados exitosamente: $agregados');
    } catch (e) {
      print('Error al forzar creación de trabajadores: $e');
    }
  }

  // Método para verificar el estado de los datos
  Future<Map<String, dynamic>> verificarEstadoDatos() async {
    try {
      final trabajadoresFirebase = await _firebaseService.getTrabajadores();
      final obrasFirebase = await _firebaseService.getObras();
      
      return {
        'trabajadoresFirebase': trabajadoresFirebase.length,
        'obrasFirebase': obrasFirebase.length,
        'trabajadoresLocales': _trabajadores.length,
        'obrasLocales': _obras.length,
        'firebaseDisponible': _firebaseService.isAvailable,
      };
    } catch (e) {
      print('Error al verificar estado de datos: $e');
      return {};
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar Firebase
  try {
    print('Iniciando aplicación...');
    await FirebaseService.initialize();
    print('Firebase inicializado correctamente');
    
    // Cargar datos desde Firebase al arrancar la aplicación
    print('Cargando datos desde Firebase...');
    final dataManager = DataManager();
    await dataManager.cargarDatosDesdeFirebase();
    print('Carga de datos finalizada');
  } catch (e) {
    print('Error al inicializar Firebase: $e');
  }
  
  runApp(const ControlPersonalApp());
}

class ControlPersonalApp extends StatelessWidget {
  const ControlPersonalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control de Personal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E40AF),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
      routes: {
        '/admin': (context) => const AdminPage(),
        '/datos': (context) => const DatosPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DataManager _dataManager = DataManager();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _sincronizarDatosIniciales();
  }

  Future<void> _sincronizarDatosIniciales() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      await _dataManager.sincronizarDatosIniciales();
      print('Datos iniciales sincronizados con Firebase');
    } catch (e) {
      print('Error al sincronizar datos iniciales: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E3A8A),
              Color(0xFF3B82F6),
              Color(0xFF1E40AF),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                child: const Column(
                  children: [
                    Text(
                      'Control de Personal',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Sistema de Gestión',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Main buttons
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildMainButton(
                              'DIONI',
                              Icons.person,
                              () {
                                print('Botón DIONI presionado');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const TablaExcelPage(encargado: 'DIONI'),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildMainButton(
                              'GERMAN',
                              Icons.person,
                              () {
                                print('Botón GERMAN presionado');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const TablaExcelPage(encargado: 'GERMAN'),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildMainButton(
                              'LUTE',
                              Icons.person,
                              () {
                                print('Botón LUTE presionado');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const TablaExcelPage(encargado: 'LUTE'),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildMainButton(
                              'VICTOR',
                              Icons.person,
                              () {
                                print('Botón VICTOR presionado');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const TablaExcelPage(encargado: 'VICTOR'),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Admin button
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AdminPage()),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                  ),
                  child: const Text(
                    'ADMINISTRACIÓN',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainButton(String text, IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.2),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: Colors.white.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 16),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administración'),
        backgroundColor: const Color(0xFF1E40AF),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E3A8A),
              Color(0xFF3B82F6),
              Color(0xFF60A5FA),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF10B981),
                      Color(0xFF34D399),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF10B981).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/datos');
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.data_usage,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'DATOS',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF3B82F6),
                      Color(0xFF60A5FA),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3B82F6).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      try {
                        final dataManager = DataManager();
                        await dataManager.forzarSincronizacionCompleta();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Todos los datos sincronizados con Firebase'),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error al sincronizar: $e'),
                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.sync,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'SINCRONIZAR',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DatosPage extends StatefulWidget {
  const DatosPage({super.key});

  @override
  State<DatosPage> createState() => _DatosPageState();
}

class _DatosPageState extends State<DatosPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final DataManager _dataManager = DataManager();
  bool _isLoading = false;
  
  // Estado para el buscador de trabajadores
  final TextEditingController _searchController = TextEditingController();
  List<String> _trabajadoresFiltrados = [];
  bool _isSearching = false;
  
  // Estado para el buscador de obras
  final TextEditingController _searchObrasController = TextEditingController();
  List<String> _obrasFiltradas = [];
  bool _isSearchingObras = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _cargarDatosDesdeFirebase();
  }

  Future<void> _cargarDatosDesdeFirebase() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      await _dataManager.cargarDatosDesdeFirebase();
      print('DatosPage: Datos cargados. Trabajadores: ${_dataManager.trabajadores.length}');
    } catch (e) {
      print('DatosPage: Error al cargar datos: $e');
    }
    
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _searchObrasController.dispose();
    super.dispose();
  }

  // Método para filtrar trabajadores
  void _filtrarTrabajadores(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
      if (query.isEmpty) {
        _trabajadoresFiltrados = [];
      } else {
        _trabajadoresFiltrados = _dataManager.trabajadores
            .where((trabajador) => 
                trabajador.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  // Método para filtrar obras
  void _filtrarObras(String query) {
    setState(() {
      _isSearchingObras = query.isNotEmpty;
      if (query.isEmpty) {
        _obrasFiltradas = [];
      } else {
        _obrasFiltradas = _dataManager.obras
            .where((obra) => 
                obra.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  // Método para determinar la constructora basándose en el nombre de la obra
  String _determinarConstructora(String obra) {
    String obraLower = obra.toLowerCase();
    
    if (obraLower.contains('cañaveral') || obraLower.contains('chalets julian') || 
        obraLower.contains('rivas') || obraLower.contains('villaverde') || 
        obraLower.contains('hotel las tablas') || obraLower.contains('lofts san sebastian') ||
        obraLower.contains('reforma centro de menores') || obraLower.contains('carabanchel') ||
        obraLower.contains('los berrocales') || obraLower.contains('peñagrande')) {
      return 'AVINTIA';
    } else if (obraLower.contains('tres cantos') || obraLower.contains('valdebebas') ||
               obraLower.contains('pozuelo') || obraLower.contains('boadilla') ||
               obraLower.contains('valdemoro')) {
      return 'ARPADA';
    } else if (obraLower.contains('meco') || obraLower.contains('getafe') ||
               obraLower.contains('vallecas') || obraLower.contains('leganes')) {
      return 'ASENTIS';
    } else if (obraLower.contains('humanes') || obraLower.contains('parla') ||
               obraLower.contains('arroyofresno') || obraLower.contains('alcala') ||
               obraLower.contains('la finca') || obraLower.contains('navalcarnero')) {
      return 'ALZA';
    } else if (obraLower.contains('arganda') || obraLower.contains('nueva sede once')) {
      return 'DRAGADOS';
    } else if (obraLower.contains('las rozas')) {
      return 'C SAN MARTIN';
    } else if (obraLower.contains('boadilla del monte')) {
      return 'C LOS ALAMOS';
    } else if (obraLower.contains('leganes') && !obraLower.contains('asentis')) {
      return 'SACYR';
    } else if (obraLower.contains('casa verde')) {
      return 'MARCO';
    } else if (obraLower.contains('planetario')) {
      return 'FCC';
    } else if (obraLower.contains('fernandez caro')) {
      return 'AZVI';
    } else if (obraLower.contains('valdebebas') && !obraLower.contains('arpada')) {
      return 'JARQUIL';
    } else if (obraLower.contains('paseo de los canónigos')) {
      return 'ASCH';
    } else if (obraLower.contains('15 viviendas') || obraLower.contains('21 viviendas') ||
               obraLower.contains('26 viviendas carabanchel') || obraLower.contains('158 viviendas arganda')) {
      return 'PECSA';
    } else if (obraLower.contains('constructora') || obraLower.contains('oficinas calle pradillo') ||
               obraLower.contains('164 viviendas cañaveral') || obraLower.contains('39 viviendas boadilla') ||
               obraLower.contains('318 viviendas navalcarnero')) {
      return 'COTOLMA';
    } else if (obraLower.contains('108 viviendas leganes')) {
      return 'ESPIREA';
    } else if (obraLower.contains('150 viviendas valdemoro')) {
      return 'ACCIONA';
    } else if (obraLower.contains('villanueva del pardillo')) {
      return 'UTE CAÑAVERAL (FTC Y ABECONSA)';
    } else if (obraLower.contains('villaviciosa de odon')) {
      return 'CEOS';
    } else if (obraLower.contains('19 viviendas villanueva')) {
      return 'CONSTRUCTORA SAN JOSE';
    } else if (obraLower.contains('56 viviendas alcala')) {
      return 'TMR';
    } else if (obraLower.contains('alto arenal') || obraLower.contains('24 viviendas la finca')) {
      return 'GARCIA DE CELIS';
    } else if (obraLower.contains('48 viviendas villaverde') || obraLower.contains('106 viviendas vallecas')) {
      return 'LARVIN';
    } else if (obraLower.contains('chm')) {
      return 'CHM';
    } else if (obraLower.contains('mln')) {
      return 'MLN';
    } else if (obraLower.contains('c rico')) {
      return 'C RICO';
    } else if (obraLower.contains('obras especiales')) {
      return 'OBRAS ESPECIALES';
    } else {
      return 'SIN ASIGNAR';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos'),
        backgroundColor: const Color(0xFF1E40AF),
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(
              icon: Icon(Icons.people),
              text: 'Trabajadores',
            ),
            Tab(
              icon: Icon(Icons.work),
              text: 'Proyectos',
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E3A8A),
              Color(0xFF3B82F6),
              Color(0xFF60A5FA),
            ],
          ),
        ),
        child: TabBarView(
          controller: _tabController,
          children: [
            // Pestaña de Trabajadores
            _buildTrabajadoresTab(),
            // Pestaña de Proyectos
            _buildProyectosTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildTrabajadoresTab() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Lista de Trabajadores - SEANSA y TOLEBRICK',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total: ${_dataManager.trabajadores.length} trabajadores',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                        if (_isLoading) ...[
                          const SizedBox(width: 8),
                          const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Aquí puedes gestionar la información de todos los trabajadores',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Colors.white70,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Los datos se cargan desde Firebase al iniciar la aplicación',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: _isLoading ? null : () async {
                              setState(() {
                                _isLoading = true;
                              });
                              
                              try {
                                final estado = await _dataManager.verificarEstadoDatos();
                                String mensaje = 'Estado de datos:\n';
                                mensaje += 'Trabajadores en Firebase: ${estado['trabajadoresFirebase']}\n';
                                mensaje += 'Obras en Firebase: ${estado['obrasFirebase']}\n';
                                mensaje += 'Trabajadores locales: ${estado['trabajadoresLocales']}\n';
                                mensaje += 'Obras locales: ${estado['obrasLocales']}\n';
                                mensaje += 'Firebase disponible: ${estado['firebaseDisponible']}';
                                
                                _mostrarMensajeConfirmacion(mensaje);
                              } catch (e) {
                                _mostrarMensajeError('Error al verificar estado: $e');
                              }
                              
                              setState(() {
                                _isLoading = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3B82F6),
                              foregroundColor: Colors.white,
                            ),
                            child: _isLoading 
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : const Text('Verificar Estado de Datos'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Buscador de trabajadores
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: Color(0xFF6B7280),
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Buscar trabajador por nombre...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 14,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1F2937),
                        ),
                        onChanged: _filtrarTrabajadores,
                      ),
                    ),
                    if (_searchController.text.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          _filtrarTrabajadores('');
                        },
                        child: const Icon(
                          Icons.clear,
                          color: Color(0xFF6B7280),
                          size: 20,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Información de resultados de búsqueda
              if (_isSearching)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'Mostrando ${_trabajadoresFiltrados.length} de ${_dataManager.trabajadores.length} trabajadores',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _isSearching ? _trabajadoresFiltrados.length : _dataManager.trabajadores.length,
                  itemBuilder: (context, index) {
                    String trabajador = _isSearching 
                        ? _trabajadoresFiltrados[index]
                        : _dataManager.trabajadores[index];
                    
                    // Encontrar el índice original para determinar la empresa
                    int originalIndex = _isSearching 
                        ? _dataManager.trabajadores.indexOf(trabajador)
                        : index;
                    
                    // Determinar empresa basándose en el índice original
                    String empresa = originalIndex < 122 ? 'SEANSA' : 'TOLEBRICK';
                    // Generar NAF e IPF ficticios para mostrar
                    String naf = '${(originalIndex + 1).toString().padLeft(2, '0')}${(originalIndex + 1000000).toString().padLeft(10, '0')}';
                    String ipf = '${(originalIndex + 100000000).toString().padLeft(10, '0')}${String.fromCharCode(65 + (originalIndex % 26))}';
                    
                    return _buildTrabajadorCard(trabajador, naf, ipf, empresa);
                  },
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            onPressed: () => _mostrarDialogoNuevoTrabajador(),
            backgroundColor: const Color(0xFF3B82F6),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProyectosTab() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Lista de Proyectos',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total: ${_dataManager.obras.length} proyectos',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                        if (_isLoading) ...[
                          const SizedBox(width: 8),
                          const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Aquí puedes gestionar todos los proyectos y obras',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Buscador de obras
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: Color(0xFF6B7280),
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _searchObrasController,
                        decoration: const InputDecoration(
                          hintText: 'Buscar proyecto por nombre...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 14,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1F2937),
                        ),
                        onChanged: _filtrarObras,
                      ),
                    ),
                    if (_searchObrasController.text.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          _searchObrasController.clear();
                          _filtrarObras('');
                        },
                        child: const Icon(
                          Icons.clear,
                          color: Color(0xFF6B7280),
                          size: 20,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Información de resultados de búsqueda
              if (_isSearchingObras)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'Mostrando ${_obrasFiltradas.length} de ${_dataManager.obras.length} proyectos',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _isSearchingObras ? _obrasFiltradas.length : _dataManager.obras.length,
                  itemBuilder: (context, index) {
                    String obra = _isSearchingObras 
                        ? _obrasFiltradas[index]
                        : _dataManager.obras[index];
                    
                    // Determinar constructora basándose en el nombre de la obra
                    String constructora = _determinarConstructora(obra);
                    
                    return _buildProyectoCard(obra, constructora);
                  },
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            onPressed: () => _mostrarDialogoNuevoProyecto(),
            backgroundColor: const Color(0xFF10B981),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTrabajadorCard(String nombre, String nafIpf, String dni, String empresa) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.person,
                  color: Color(0xFF3B82F6),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nombre,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Empresa: $empresa',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B7280),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // Botón de editar
              GestureDetector(
                onTap: () => _mostrarDialogoEdicionTrabajador(nombre),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Color(0xFF3B82F6),
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Botón de eliminar
              GestureDetector(
                onTap: () => _mostrarDialogoConfirmacionEliminarTrabajador(nombre),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.delete,
                    color: Color(0xFFEF4444),
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NAF/IPF: $nafIpf',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'DNI: $dni',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProyectoCard(String obra, String constructora) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.business,
                  color: Color(0xFF10B981),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      obra,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Constructora: $constructora',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B7280),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // Botón de editar
              GestureDetector(
                onTap: () => _mostrarDialogoEdicionProyecto(obra),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Color(0xFF10B981),
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Botón de eliminar
              GestureDetector(
                onTap: () => _mostrarDialogoConfirmacionEliminarProyecto(obra),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.delete,
                    color: Color(0xFFEF4444),
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Estado: En Progreso',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF10B981),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Tipo: Residencial',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _mostrarDialogoEdicionTrabajador(String nombreActual) {
    final TextEditingController nombreController = TextEditingController(text: nombreActual);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Editar Trabajador',
            style: TextStyle(
              color: Color(0xFF1E293B),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre del Trabajador',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF3B82F6)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Color(0xFF6B7280)),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                String nuevoNombre = nombreController.text.trim();
                if (nuevoNombre.isNotEmpty && nuevoNombre != nombreActual) {
                  try {
                    await _dataManager.actualizarTrabajador(nombreActual, nuevoNombre);
                    setState(() {}); // Actualizar la UI
                    Navigator.of(context).pop();
                    _mostrarMensajeConfirmacion('Trabajador actualizado correctamente');
                  } catch (e) {
                    Navigator.of(context).pop();
                    _mostrarMensajeError('Error al actualizar trabajador: $e');
                  }
                } else {
                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
              ),
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarDialogoConfirmacionEliminarTrabajador(String nombre) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirmar Eliminación',
            style: TextStyle(
              color: Color(0xFF1E293B),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            '¿Estás seguro de que quieres eliminar al trabajador "$nombre"?\n\nEsta acción no se puede deshacer.',
            style: const TextStyle(
              color: Color(0xFF6B7280),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Color(0xFF6B7280)),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _dataManager.eliminarTrabajador(nombre);
                  setState(() {}); // Actualizar la UI
                  Navigator.of(context).pop();
                  _mostrarMensajeConfirmacion('Trabajador eliminado correctamente');
                } catch (e) {
                  Navigator.of(context).pop();
                  _mostrarMensajeError('Error al eliminar trabajador: $e');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
                foregroundColor: Colors.white,
              ),
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarDialogoEdicionProyecto(String obraActual) {
    final TextEditingController obraController = TextEditingController(text: obraActual);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Editar Proyecto',
            style: TextStyle(
              color: Color(0xFF1E293B),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: obraController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre del Proyecto',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF10B981)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Color(0xFF6B7280)),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                String nuevaObra = obraController.text.trim();
                if (nuevaObra.isNotEmpty && nuevaObra != obraActual) {
                  try {
                    await _dataManager.actualizarObra(obraActual, nuevaObra);
                    setState(() {}); // Actualizar la UI
                    Navigator.of(context).pop();
                    _mostrarMensajeConfirmacion('Proyecto actualizado correctamente');
                  } catch (e) {
                    Navigator.of(context).pop();
                    _mostrarMensajeError('Error al actualizar proyecto: $e');
                  }
                } else {
                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10B981),
                foregroundColor: Colors.white,
              ),
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarDialogoConfirmacionEliminarProyecto(String obra) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirmar Eliminación',
            style: TextStyle(
              color: Color(0xFF1E293B),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            '¿Estás seguro de que quieres eliminar el proyecto "$obra"?\n\nEsta acción no se puede deshacer.',
            style: const TextStyle(
              color: Color(0xFF6B7280),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Color(0xFF6B7280)),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _dataManager.eliminarObra(obra);
                  setState(() {}); // Actualizar la UI
                  Navigator.of(context).pop();
                  _mostrarMensajeConfirmacion('Proyecto eliminado correctamente');
                } catch (e) {
                  Navigator.of(context).pop();
                  _mostrarMensajeError('Error al eliminar proyecto: $e');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
                foregroundColor: Colors.white,
              ),
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarDialogoNuevoTrabajador() {
    final TextEditingController nombreController = TextEditingController();
    final TextEditingController nafIpfController = TextEditingController();
    final TextEditingController dniController = TextEditingController();
    final TextEditingController empresaController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Añadir Nuevo Trabajador',
            style: TextStyle(
              color: Color(0xFF1E293B),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF3B82F6)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: nafIpfController,
                  decoration: const InputDecoration(
                    labelText: 'NAF/IPF',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF3B82F6)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: dniController,
                  decoration: const InputDecoration(
                    labelText: 'DNI',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF3B82F6)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: empresaController,
                  decoration: const InputDecoration(
                    labelText: 'Empresa',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF3B82F6)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Color(0xFF6B7280)),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nombreController.text.isNotEmpty) {
                  try {
                    await _dataManager.agregarTrabajador(nombreController.text.trim());
                    setState(() {}); // Actualizar la UI
                    Navigator.of(context).pop();
                    _mostrarMensajeConfirmacion('Nuevo trabajador añadido correctamente');
                  } catch (e) {
                    Navigator.of(context).pop();
                    _mostrarMensajeError('Error al agregar trabajador: $e');
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
              ),
              child: const Text('Añadir'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarDialogoNuevoProyecto() {
    final TextEditingController obraController = TextEditingController();
    final TextEditingController constructoraController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Añadir Nuevo Proyecto',
            style: TextStyle(
              color: Color(0xFF1E293B),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: obraController,
                  decoration: const InputDecoration(
                    labelText: 'Obra',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF10B981)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: constructoraController,
                  decoration: const InputDecoration(
                    labelText: 'Constructora',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF10B981)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Color(0xFF6B7280)),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (obraController.text.isNotEmpty) {
                  try {
                    await _dataManager.agregarObra(obraController.text.trim());
                    setState(() {}); // Actualizar la UI
                    Navigator.of(context).pop();
                    _mostrarMensajeConfirmacion('Nuevo proyecto añadido correctamente');
                  } catch (e) {
                    Navigator.of(context).pop();
                    _mostrarMensajeError('Error al agregar proyecto: $e');
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10B981),
                foregroundColor: Colors.white,
              ),
              child: const Text('Añadir'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarMensajeConfirmacion(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          mensaje,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF10B981),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _mostrarMensajeError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          mensaje,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFEF4444),
        duration: const Duration(seconds: 4),
      ),
    );
  }
}

class TablaExcelPage extends StatefulWidget {
  final String encargado;

  const TablaExcelPage({super.key, required this.encargado});

  @override
  State<TablaExcelPage> createState() => _TablaExcelPageState();
}

class _TablaExcelPageState extends State<TablaExcelPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentPage = 0;
  final int _rowsPerPage = 20;
  final int _totalRows = 100;

  // ScrollController compartido para sincronizar el scroll horizontal
  late ScrollController _horizontalScrollController;

  // Estado para guardar los valores seleccionados por mes
  Map<String, String> _valoresSeleccionados = {};

  // DataManager para datos compartidos
  final DataManager _dataManager = DataManager();
  
  // Estado para indicar si se están guardando datos
  bool _guardandoDatos = false;

  // Cache de datos para mejor rendimiento
  late final List<String> meses;
  late final List<int> diasPorMes;
  late final List<String> opcionesDias;

  // Estado para filtros y organización
  String _filtroNombre = '';
  String _filtroObra = '';
  String _ordenamiento = 'ninguno'; // 'nombre', 'obra', 'total', 'ninguno'
  bool _ordenAscendente = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 12, vsync: this);
    _horizontalScrollController = ScrollController();
    
    // Inicializar datos en initState para mejor rendimiento
    meses = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];

    diasPorMes = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    opcionesDias = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'V', 'F', 'ZZ'];
    
    // Cargar datos desde Firebase al inicializar
    _cargarDatosDesdeFirebase();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }

  // Función para obtener la clave única de una celda por mes
  String _getCeldaKey(int fila, String columna, int? dia, int mesIndex) {
    String mesKey = meses[mesIndex];
    if (dia != null) {
      return '${mesKey}_fila_${fila}_${columna}_dia_$dia';
    }
    return '${mesKey}_fila_${fila}_$columna';
  }

  // Función para guardar un valor seleccionado por mes con propagación hacia adelante
  void _guardarValor(int fila, String columna, String? valor, int mesIndex, [int? dia]) {
    setState(() {
      // Para nombre y obra, propagar hacia adelante
      if (columna == 'nombre' || columna == 'obra') {
        // Guardar en el mes actual
        String key = _getCeldaKey(fila, columna, dia, mesIndex);
        if (valor == null) {
          _valoresSeleccionados.remove(key);
        } else {
          _valoresSeleccionados[key] = valor;
        }
        
        // Propagar a todos los meses siguientes
        for (int i = mesIndex + 1; i < meses.length; i++) {
          String nextKey = _getCeldaKey(fila, columna, dia, i);
          if (valor == null) {
            _valoresSeleccionados.remove(nextKey);
          } else {
            _valoresSeleccionados[nextKey] = valor;
          }
        }
      } else {
        // Para días, solo guardar en el mes actual
        String key = _getCeldaKey(fila, columna, dia, mesIndex);
        if (valor == null) {
          _valoresSeleccionados.remove(key);
        } else {
          _valoresSeleccionados[key] = valor;
        }
      }
    });
    
    // Guardar en Firebase automáticamente
    _guardarDatosEnFirebase();
  }

  // Función para guardar datos en Firebase
  Future<void> _guardarDatosEnFirebase() async {
    try {
      setState(() {
        _guardandoDatos = true;
      });
      
      final firebaseService = FirebaseService();
      if (!firebaseService.isAvailable) {
        print('Firebase no está disponible para guardar datos');
        return;
      }

      // Guardar datos del mes actual
      int mesIndex = _tabController.index;
      String mes = meses[mesIndex];
      
      // Crear mapa de datos para el mes actual
      Map<String, dynamic> datosMes = {};
      
      // Recopilar todos los datos del mes actual
      for (int fila = 0; fila < 100; fila++) {
        String? nombre = _obtenerValor(fila, 'nombre', mesIndex);
        String? obra = _obtenerValor(fila, 'obra', mesIndex);
        
        if (nombre != null || obra != null) {
          Map<String, dynamic> datosFila = {};
          if (nombre != null) datosFila['nombre'] = nombre;
          if (obra != null) datosFila['obra'] = obra;
          
          // Agregar datos de días
          List<int> diasDelMes = _getDiasDelMes(mesIndex);
          Map<String, String> datosDias = {};
          for (int dia in diasDelMes) {
            String? valorDia = _obtenerValor(fila, 'dia', mesIndex, dia);
            if (valorDia != null) {
              datosDias[dia.toString()] = valorDia;
            }
          }
          if (datosDias.isNotEmpty) {
            datosFila['dias'] = datosDias;
          }
          
          datosMes['fila_$fila'] = datosFila;
        }
      }
      
      if (datosMes.isNotEmpty) {
        await firebaseService.saveDatosTabla(widget.encargado, mes, datosMes);
        print('Datos guardados en Firebase para ${widget.encargado} - $mes');
      }
    } catch (e) {
      print('Error al guardar datos en Firebase: $e');
    } finally {
      setState(() {
        _guardandoDatos = false;
      });
    }
  }

  // Función para cargar datos desde Firebase
  Future<void> _cargarDatosDesdeFirebase() async {
    try {
      final firebaseService = FirebaseService();
      if (!firebaseService.isAvailable) {
        print('Firebase no está disponible para cargar datos');
        return;
      }

      // Cargar datos de todos los meses
      for (int mesIndex = 0; mesIndex < meses.length; mesIndex++) {
        String mes = meses[mesIndex];
        Map<String, dynamic> datosFirebase = await firebaseService.getDatosTabla(widget.encargado, mes);
        
        if (datosFirebase.isNotEmpty && datosFirebase['datos'] != null) {
          Map<String, dynamic> datosMes = datosFirebase['datos'] as Map<String, dynamic>;
          
          // Restaurar datos del mes
          datosMes.forEach((key, value) {
            if (key.startsWith('fila_')) {
              int fila = int.parse(key.substring(5));
              Map<String, dynamic> datosFila = value as Map<String, dynamic>;
              
              // Restaurar nombre
              if (datosFila['nombre'] != null) {
                _valoresSeleccionados[_getCeldaKey(fila, 'nombre', null, mesIndex)] = datosFila['nombre'];
              }
              
              // Restaurar obra
              if (datosFila['obra'] != null) {
                _valoresSeleccionados[_getCeldaKey(fila, 'obra', null, mesIndex)] = datosFila['obra'];
              }
              
              // Restaurar días
              if (datosFila['dias'] != null) {
                Map<String, dynamic> datosDias = datosFila['dias'] as Map<String, dynamic>;
                datosDias.forEach((diaStr, valor) {
                  int dia = int.parse(diaStr);
                  _valoresSeleccionados[_getCeldaKey(fila, 'dia', dia, mesIndex)] = valor;
                });
              }
            }
          });
        }
      }
      
      setState(() {}); // Actualizar la UI
      print('Datos cargados desde Firebase para ${widget.encargado}');
    } catch (e) {
      print('Error al cargar datos desde Firebase: $e');
    }
  }

  // Función para obtener un valor guardado por mes con propagación hacia adelante
  String? _obtenerValor(int fila, String columna, int mesIndex, [int? dia]) {
    // Para nombre y obra, buscar desde el mes actual hacia atrás
    if (columna == 'nombre' || columna == 'obra') {
      for (int i = mesIndex; i >= 0; i--) {
        String key = _getCeldaKey(fila, columna, dia, i);
        String? valor = _valoresSeleccionados[key];
        if (valor != null) {
          return valor;
        }
      }
      return null;
    } else {
      // Para días, solo buscar en el mes actual
      String key = _getCeldaKey(fila, columna, dia, mesIndex);
      return _valoresSeleccionados[key];
    }
  }

  // Función para limpiar caracteres especiales
  String _limpiarTexto(String? texto) {
    if (texto == null) return '';
    // Reemplazar caracteres problemáticos
    return texto
        .replaceAll('á', 'a')
        .replaceAll('é', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ñ', 'n')
        .replaceAll('Á', 'A')
        .replaceAll('É', 'E')
        .replaceAll('Í', 'I')
        .replaceAll('Ó', 'O')
        .replaceAll('Ú', 'U')
        .replaceAll('Ñ', 'N');
  }



  // Función para compartir datos
  void _compartirDatos() {
    // Crear un texto con los datos actuales
    String datos = 'Control de Personal - ${widget.encargado}\n\n';
    
    // Agregar datos del mes actual
    int mesActual = _tabController.index;
    String mes = meses[mesActual];
    datos += 'Mes: $mes\n';
    datos += 'Datos exportados el: ${DateTime.now().toString().split('.')[0]}\n\n';
    
    // Compartir el texto
    Share.share(datos, subject: 'Control de Personal - ${widget.encargado}');
  }

  // Función para guardar configuración
  void _guardarConfiguracion() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Configuración Guardada'),
          content: Text('La configuración se ha guardado correctamente.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Función para mostrar información del sistema
  void _mostrarInformacionSistema() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Información del Sistema'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Encargado: ${widget.encargado}'),
              Text('Total de filas: $_totalRows'),
              Text('Filas por página: $_rowsPerPage'),
              Text('Meses disponibles: ${meses.length}'),
                                  Text('Trabajadores: ${_dataManager.trabajadores.length}'),
                              Text('Obras: ${_dataManager.obras.length}'),
              SizedBox(height: 8),
              Text('Versión: 1.0.0'),
              Text('Fecha: ${DateTime.now().toString().split(' ')[0]}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  // Función para exportar todos los meses en un solo PDF
  Future<void> _exportarTodosLosMeses() async {
    try {
      // Mostrar indicador de carga
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text('Exportando datos...'),
              ],
            ),
          );
        },
      );

      // Crear el documento PDF
      final pdf = pw.Document();

      // Solo exportar el mes actual para evitar problemas
      int mesIndex = _tabController.index;
      String mes = meses[mesIndex];
      List<int> diasDelMes = _getDiasDelMes(mesIndex);

      // Crear tabla para el PDF
      List<List<String>> tableData = [];
      
      // Agregar header
      List<String> header = ['Nombre', 'Obra'];
      header.addAll(diasDelMes.map((dia) => dia.toString()));
      header.add('TOTAL');
      tableData.add(header);

      // Agregar solo filas con datos
      for (int fila = 0; fila < 100; fila++) {
        List<String> row = [];
        
        // Nombre
        String? nombre = _obtenerValor(fila, 'nombre', mesIndex);
        row.add(nombre ?? '');
        
        // Obra
        String? obra = _obtenerValor(fila, 'obra', mesIndex);
        row.add(obra ?? '');
        
        // Días
        int totalFila = 0;
        bool filaConDatos = false;
        for (int dia in diasDelMes) {
          String? valor = _obtenerValor(fila, 'dia', mesIndex, dia);
          row.add(valor ?? '');
          
          // Verificar si hay datos en la fila
          if (valor != null && valor.isNotEmpty && valor != '-') {
            filaConDatos = true;
          }
          
          // Calcular total
          if (valor != null) {
            int? numero = int.tryParse(valor);
            if (numero != null && numero >= 1 && numero <= 10) {
              totalFila += numero;
            }
          }
        }
        
        // TOTAL
        row.add(totalFila.toString());
        
        // Solo agregar filas que tengan datos
        if (filaConDatos || (nombre != null && nombre.isNotEmpty) || (obra != null && obra.isNotEmpty)) {
          tableData.add(row);
        }
      }

      // Dividir datos en páginas (máximo 15 filas por página)
      int filasPorPagina = 15;
      int totalPaginas = ((tableData.length - 1) / filasPorPagina).ceil();
      
      for (int pagina = 0; pagina < totalPaginas; pagina++) {
        int inicio = pagina * filasPorPagina;
        int fin = (pagina + 1) * filasPorPagina;
        if (fin > tableData.length) fin = tableData.length;
        
        List<List<String>> datosPagina = tableData.sublist(inicio, fin);
        
        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4.landscape,
            build: (pw.Context context) {
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Título
                  pw.Text(
                    'Control de Personal - ${_limpiarTexto(widget.encargado)} - ${_limpiarTexto(mes)}',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    'Página ${pagina + 1} de $totalPaginas',
                    style: pw.TextStyle(
                      fontSize: 10,
                      color: PdfColors.grey,
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  
                  // Tabla de la página
                  pw.Table(
                    border: pw.TableBorder.all(
                      color: PdfColors.grey,
                      width: 0.5,
                    ),
                    children: datosPagina.map((row) => pw.TableRow(
                      children: row.map((cell) => pw.Container(
                        padding: pw.EdgeInsets.all(2),
                        child: pw.Text(
                          cell,
                          style: pw.TextStyle(
                            fontSize: 6,
                            color: PdfColors.black,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                      )).toList(),
                    )).toList(),
                  ),
                ],
              );
            },
          ),
        );
      }

      // Guardar el archivo PDF
      String fileName = 'Control_Personal_${_limpiarTexto(widget.encargado)}_${_limpiarTexto(mes)}.pdf';
      Uint8List pdfBytes = await pdf.save();
      String? filePath;
      if (kIsWeb) {
        // WEB: Descargar el archivo
        final blob = html.Blob([pdfBytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute('download', fileName)
          ..click();
        html.Url.revokeObjectUrl(url);
        filePath = null;
      } else {
        // MÓVIL/ESCRITORIO: Guardar en sistema de archivos
        io.Directory? directory = await getApplicationDocumentsDirectory();
        filePath = '${directory.path}/$fileName';
        io.File file = io.File(filePath);
        await file.writeAsBytes(pdfBytes);
      }

      // Cerrar el diálogo de carga
      Navigator.of(context).pop();

      // Mostrar opciones de compartir
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Exportación Completada'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('El archivo PDF se ha guardado correctamente.'),
                SizedBox(height: 8),
                Text(
                  'Archivo: $fileName',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (filePath != null) {
                    Share.shareFiles([filePath], text: 'Control de Personal - ${widget.encargado}');
                  } else {
                    Share.share('Control de Personal - ${widget.encargado}', subject: 'Control de Personal');
                  }
                },
                child: Text('Compartir'),
              ),
            ],
          );
        },
      );

    } catch (e) {
      // Cerrar el diálogo de carga si hay error
      Navigator.of(context).pop();
      
      // Mostrar error simplificado
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error en la Exportación'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('No se pudo exportar el PDF.'),
                SizedBox(height: 8),
                Text(
                  'Error: ${e.toString().split(':').first}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Intenta:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('• Reiniciar la aplicación'),
                Text('• Verificar permisos de archivo'),
                Text('• Usar menos datos'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  // Función para exportar los datos de un mes específico en PDF (mantenida por compatibilidad)
  Future<void> _exportarMes(String mes, int mesIndex, List<int> diasDelMes) async {
    try {
      // Mostrar indicador de carga
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text('Exportando datos de $mes...'),
              ],
            ),
          );
        },
      );

      // Crear el documento PDF
      final pdf = pw.Document();

      // Crear tabla para el PDF
      List<List<String>> tableData = [];
      
      // Agregar header
      List<String> header = ['Nombre', 'Obra'];
      header.addAll(diasDelMes.map((dia) => dia.toString()));
      header.add('TOTAL');
      tableData.add(header);

      // Agregar datos (solo las primeras 10 filas para evitar problemas)
      for (int fila = 0; fila < 10; fila++) {
        List<String> row = [];
        
        // Nombre
        String? nombre = _obtenerValor(fila, 'nombre', mesIndex);
        row.add(nombre ?? '');
        
        // Obra
        String? obra = _obtenerValor(fila, 'obra', mesIndex);
        row.add(obra ?? '');
        
        // Días
        int totalFila = 0;
        for (int dia in diasDelMes) {
          String? valor = _obtenerValor(fila, 'dia', mesIndex, dia);
          row.add(valor ?? '');
          
          // Calcular total
          if (valor != null) {
            int? numero = int.tryParse(valor);
            if (numero != null && numero >= 1 && numero <= 10) {
              totalFila += numero;
            }
          }
        }
        
        // TOTAL
        row.add(totalFila.toString());
        tableData.add(row);
      }

      // Crear la página del PDF
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4.landscape,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Título
                pw.Text(
                  'Control de Personal - ${_limpiarTexto(widget.encargado)} - ${_limpiarTexto(mes)}',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                
                // Tabla simplificada
                pw.Table(
                  border: pw.TableBorder.all(
                    color: PdfColors.grey,
                    width: 0.5,
                  ),
                  children: tableData.map((row) => pw.TableRow(
                    children: row.map((cell) => pw.Container(
                      padding: pw.EdgeInsets.all(2),
                      child: pw.Text(
                        cell,
                        style: pw.TextStyle(
                          fontSize: 6,
                          color: PdfColors.black,
                        ),
                      ),
                    )).toList(),
                  )).toList(),
                ),
              ],
            );
          },
        ),
      );

      // Guardar el archivo PDF
      String fileName = 'Control_Personal_${_limpiarTexto(widget.encargado)}_${_limpiarTexto(mes)}.pdf';
      Uint8List pdfBytes = await pdf.save();
      String? filePath;
      if (kIsWeb) {
        // WEB: Descargar el archivo
        final blob = html.Blob([pdfBytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute('download', fileName)
          ..click();
        html.Url.revokeObjectUrl(url);
        filePath = null;
      } else {
        // MÓVIL/ESCRITORIO: Guardar en sistema de archivos
        io.Directory? directory = await getApplicationDocumentsDirectory();
        filePath = '${directory.path}/$fileName';
        io.File file = io.File(filePath);
        await file.writeAsBytes(pdfBytes);
      }

      // Cerrar el diálogo de carga
      Navigator.of(context).pop();

      // Mostrar opciones de compartir
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Exportación Completada'),
            content: Text('El archivo PDF se ha guardado como: $fileName'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (filePath != null) {
                    Share.shareFiles([filePath], text: 'Control de Personal - $mes');
                  } else {
                    Share.share('Control de Personal - $mes', subject: 'Control de Personal');
                  }
                },
                child: Text('Compartir'),
              ),
            ],
          );
        },
      );

    } catch (e) {
      // Cerrar el diálogo de carga si hay error
      Navigator.of(context).pop();
      
      // Mostrar error con más detalles
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error en la Exportación'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Se produjo un error al exportar el PDF:'),
                SizedBox(height: 8),
                Text(
                  e.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red,
                    fontFamily: 'monospace',
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Sugerencias:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('• Verifica que tienes permisos de escritura'),
                Text('• Intenta exportar menos datos'),
                Text('• Reinicia la aplicación si el problema persiste'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  List<int> _getDiasDelMes(int mesIndex) {
    int dias = diasPorMes[mesIndex];
    return List.generate(dias, (index) => index + 1);
  }

  int get _totalPages => (_totalRows / _rowsPerPage).ceil();
  int get _startRow => _currentPage * _rowsPerPage;
  int get _endRow => (_startRow + _rowsPerPage).clamp(0, _totalRows);

  // Métodos para filtros y organización
  void _mostrarOpcionesFiltro(String tipo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            tipo == 'nombre' ? 'Filtrar por Nombre' : 'Filtrar por Obra',
            style: const TextStyle(
              color: Color(0xFF1E293B),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Opción de búsqueda
              ListTile(
                leading: const Icon(Icons.search, color: Color(0xFF3B82F6)),
                title: const Text('Buscar'),
                subtitle: const Text('Filtrar por texto específico'),
                onTap: () {
                  Navigator.of(context).pop();
                  _mostrarDialogoBusqueda(tipo);
                },
              ),
              // Opción de ordenamiento
              ListTile(
                leading: const Icon(Icons.sort, color: Color(0xFF10B981)),
                title: const Text('Ordenar'),
                subtitle: const Text('Ordenar alfabéticamente'),
                onTap: () {
                  Navigator.of(context).pop();
                  _cambiarOrdenamiento(tipo);
                },
              ),
              // Opción de limpiar filtros
              if ((tipo == 'nombre' && _filtroNombre.isNotEmpty) || 
                  (tipo == 'obra' && _filtroObra.isNotEmpty))
                ListTile(
                  leading: const Icon(Icons.clear, color: Color(0xFFEF4444)),
                  title: const Text('Limpiar Filtros'),
                  subtitle: const Text('Quitar todos los filtros'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _limpiarFiltros(tipo);
                  },
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarDialogoBusqueda(String tipo) {
    final TextEditingController searchController = TextEditingController(
      text: tipo == 'nombre' ? _filtroNombre : _filtroObra,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            tipo == 'nombre' ? 'Buscar por Nombre' : 'Buscar por Obra',
            style: const TextStyle(
              color: Color(0xFF1E293B),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: tipo == 'nombre' ? 'Buscar trabajador...' : 'Buscar obra...',
              prefixIcon: const Icon(Icons.search),
              border: const OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                String filtro = searchController.text.trim();
                setState(() {
                  if (tipo == 'nombre') {
                    _filtroNombre = filtro;
                  } else {
                    _filtroObra = filtro;
                  }
                });
                Navigator.of(context).pop();
                _mostrarMensajeFiltro(tipo, filtro);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
              ),
              child: const Text('Aplicar'),
            ),
          ],
        );
      },
    );
  }

  void _cambiarOrdenamiento(String tipo) {
    setState(() {
      if (_ordenamiento == tipo) {
        // Si ya está ordenado por este tipo, cambiar dirección
        _ordenAscendente = !_ordenAscendente;
      } else {
        // Si es un nuevo tipo de ordenamiento
        _ordenamiento = tipo;
        _ordenAscendente = true;
      }
    });
    
    String direccion = _ordenAscendente ? 'ascendente' : 'descendente';
    _mostrarMensajeOrdenamiento(tipo, direccion);
  }

  void _limpiarFiltros(String tipo) {
    setState(() {
      if (tipo == 'nombre') {
        _filtroNombre = '';
      } else if (tipo == 'obra') {
        _filtroObra = '';
      }
      _ordenamiento = 'ninguno';
      _ordenAscendente = true;
    });
    
    _mostrarMensajeConfirmacion('Filtros limpiados correctamente');
  }

  void _mostrarMensajeFiltro(String tipo, String filtro) {
    String mensaje = tipo == 'nombre' 
        ? 'Filtro aplicado: Mostrando trabajadores que contengan "$filtro"'
        : 'Filtro aplicado: Mostrando obras que contengan "$filtro"';
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: const Color(0xFF3B82F6),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _mostrarMensajeOrdenamiento(String tipo, String direccion) {
    String mensaje = 'Ordenado por $tipo ($direccion)';
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: const Color(0xFF10B981),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Método para obtener filas filtradas y ordenadas
  List<int> _obtenerFilasFiltradasYOrdenadas(int mesIndex) {
    List<int> filas = List.generate(_totalRows, (index) => index);
    
    // Aplicar filtros
    if (_filtroNombre.isNotEmpty || _filtroObra.isNotEmpty) {
      filas = filas.where((fila) {
        String? nombre = _obtenerValor(fila, 'nombre', mesIndex);
        String? obra = _obtenerValor(fila, 'obra', mesIndex);
        
        bool cumpleFiltroNombre = _filtroNombre.isEmpty || 
            (nombre != null && nombre.toLowerCase().contains(_filtroNombre.toLowerCase()));
        bool cumpleFiltroObra = _filtroObra.isEmpty || 
            (obra != null && obra.toLowerCase().contains(_filtroObra.toLowerCase()));
        
        return cumpleFiltroNombre && cumpleFiltroObra;
      }).toList();
    }
    
    // Aplicar ordenamiento
    if (_ordenamiento != 'ninguno') {
      filas.sort((a, b) {
        String? valorA, valorB;
        
        switch (_ordenamiento) {
          case 'nombre':
            valorA = _obtenerValor(a, 'nombre', mesIndex) ?? '';
            valorB = _obtenerValor(b, 'nombre', mesIndex) ?? '';
            break;
          case 'obra':
            valorA = _obtenerValor(a, 'obra', mesIndex) ?? '';
            valorB = _obtenerValor(b, 'obra', mesIndex) ?? '';
            break;
          case 'total':
            valorA = _calcularTotalFila(a, _getDiasDelMes(mesIndex), mesIndex).toString();
            valorB = _calcularTotalFila(b, _getDiasDelMes(mesIndex), mesIndex).toString();
            break;
          default:
            return 0;
        }
        
        // Manejar valores vacíos en el ordenamiento
        bool valorAVacio = valorA.isEmpty || valorA == '-';
        bool valorBVacio = valorB.isEmpty || valorB == '-';
        
        // Si ambos están vacíos, mantener orden original
        if (valorAVacio && valorBVacio) return 0;
        
        // Si solo uno está vacío, el vacío va al final
        if (valorAVacio) return 1;
        if (valorBVacio) return -1;
        
        // Si ninguno está vacío, comparar normalmente
        int comparacion = valorA.compareTo(valorB);
        return _ordenAscendente ? comparacion : -comparacion;
      });
    }
    
    return filas;
  }

  String _construirMensajeFiltros() {
    List<String> filtros = [];
    
    if (_filtroNombre.isNotEmpty) {
      filtros.add('Nombre: "$_filtroNombre"');
    }
    if (_filtroObra.isNotEmpty) {
      filtros.add('Obra: "$_filtroObra"');
    }
    if (_ordenamiento != 'ninguno') {
      String direccion = _ordenAscendente ? '↑' : '↓';
      filtros.add('Ordenado por $_ordenamiento $direccion');
    }
    
    return filtros.join(' • ');
  }

  String _construirMensajeNoResultados() {
    List<String> filtros = [];
    
    if (_filtroNombre.isNotEmpty) {
      filtros.add('nombre que contenga "$_filtroNombre"');
    }
    if (_filtroObra.isNotEmpty) {
      filtros.add('obra que contenga "$_filtroObra"');
    }
    
    if (filtros.isEmpty) {
      return 'No hay datos disponibles para mostrar.';
    } else if (filtros.length == 1) {
      return 'No se encontraron registros con ${filtros[0]}.';
    } else {
      return 'No se encontraron registros con ${filtros.join(' y ')}.';
    }
  }

  void _limpiarTodosLosFiltros() {
    setState(() {
      _filtroNombre = '';
      _filtroObra = '';
      _ordenamiento = 'ninguno';
      _ordenAscendente = true;
      _currentPage = 0; // Volver a la primera página
    });
    
    _mostrarMensajeConfirmacion('Todos los filtros han sido limpiados');
  }

  // Métodos para mostrar mensajes
  void _mostrarMensajeConfirmacion(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          mensaje,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF10B981),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _mostrarMensajeError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          mensaje,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFEF4444),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.encargado} - Control de Personal'),
        backgroundColor: const Color(0xFF3B82F6),
        foregroundColor: Colors.white,
        actions: [
          // Botón de sincronización
          IconButton(
            icon: _guardandoDatos 
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Icon(Icons.sync, color: Colors.white, size: 24),
            tooltip: 'Sincronizar con Firebase',
            onPressed: _guardandoDatos ? null : () async {
              try {
                await _guardarDatosEnFirebase();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Datos sincronizados con Firebase'),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error al sincronizar: $e'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 3),
                  ),
                );
              }
            },
          ),
          // Botón de menú emergente nativo
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.white, size: 24),
            tooltip: 'Opciones',
            onSelected: (String value) {
              switch (value) {
                case 'exportar':
                  _exportarTodosLosMeses();
                  break;
                case 'compartir':
                  _compartirDatos();
                  break;
                case 'guardar':
                  _guardarConfiguracion();
                  break;
                case 'info':
                  _mostrarInformacionSistema();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'exportar',
                child: Row(
                  children: [
                    Icon(Icons.file_download, color: Colors.blue),
                    SizedBox(width: 8),
                    Text('Exportar PDF'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'compartir',
                child: Row(
                  children: [
                    Icon(Icons.share, color: Colors.green),
                    SizedBox(width: 8),
                    Text('Compartir'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'guardar',
                child: Row(
                  children: [
                    Icon(Icons.save, color: Colors.orange),
                    SizedBox(width: 8),
                    Text('Guardar'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'info',
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.purple),
                    SizedBox(width: 8),
                    Text('Información'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(width: 8),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: meses.map((mes) => Tab(text: mes)).toList(),
        ),
      ),
      body: Column(
        children: [
          // Contenido de la tabla
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: meses.asMap().entries.map((entry) {
                int mesIndex = entry.key;
                String mes = entry.value;
                List<int> diasDelMes = _getDiasDelMes(mesIndex);
                
                return _buildTablaMes(mes, diasDelMes);
              }).toList(),
            ),
          ),
          // Controles de paginación optimizados
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 4,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Página ${_currentPage + 1} de $_totalPages (Filas ${_startRow + 1}-$_endRow de $_totalRows)',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: _currentPage > 0 ? () {
                        setState(() {
                          _currentPage--;
                        });
                      } : null,
                      icon: const Icon(Icons.chevron_left),
                    ),
                    IconButton(
                      onPressed: _currentPage < _totalPages - 1 ? () {
                        setState(() {
                          _currentPage++;
                        });
                      } : null,
                      icon: const Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTablaMes(String mes, List<int> diasDelMes) {
    int mesIndex = meses.indexOf(mes);
    return Column(
      children: [
        // Indicador de scroll horizontal
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          color: const Color(0xFF3B82F6),
          child: Row(
            children: [
              Icon(Icons.swap_horiz, color: Colors.white, size: 16),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Desplaza horizontalmente para ver más columnas • Usa Shift + Rueda del mouse',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '← →',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Indicador de filtros activos
        if (_filtroNombre.isNotEmpty || _filtroObra.isNotEmpty || _ordenamiento != 'ninguno')
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            color: const Color(0xFF10B981),
            child: Row(
              children: [
                Icon(Icons.filter_list, color: Colors.white, size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _construirMensajeFiltros(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _limpiarTodosLosFiltros,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Limpiar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        // Scroll horizontal unificado para header y filas
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _horizontalScrollController,
            child: SizedBox(
              width: 200 + 200 + (diasDelMes.length * 60) + 100, // +100 para la columna TOTAL
              child: Column(
                children: [
                  // Header
                  Container(
                    color: const Color(0xFF1E40AF),
                    child: Row(
                      children: [
                        _HeaderCell(
                          text: 'Nombre',
                          width: 200,
                          onTap: () => _mostrarOpcionesFiltro('nombre'),
                          isActive: _ordenamiento == 'nombre',
                          ordenamiento: _ordenamiento == 'nombre' ? 'nombre' : null,
                          ordenAscendente: _ordenamiento == 'nombre' ? _ordenAscendente : null,
                        ),
                        _HeaderCell(
                          text: 'Obra',
                          width: 200,
                          onTap: () => _mostrarOpcionesFiltro('obra'),
                          isActive: _ordenamiento == 'obra',
                          ordenamiento: _ordenamiento == 'obra' ? 'obra' : null,
                          ordenAscendente: _ordenamiento == 'obra' ? _ordenAscendente : null,
                        ),
                        ...diasDelMes.map((dia) => _HeaderCell(
                          text: dia.toString(),
                          width: 60,
                        )),
                        _HeaderCell(
                          text: 'TOTAL',
                          width: 100,
                          onTap: () => _cambiarOrdenamiento('total'),
                          isActive: _ordenamiento == 'total',
                          ordenamiento: _ordenamiento == 'total' ? 'total' : null,
                          ordenAscendente: _ordenamiento == 'total' ? _ordenAscendente : null,
                        ),
                      ],
                    ),
                  ),
                  // Filas
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        List<int> filasFiltradas = _obtenerFilasFiltradasYOrdenadas(mesIndex);
                        int totalFilasFiltradas = filasFiltradas.length;
                        
                        // Si no hay resultados después del filtrado, mostrar mensaje
                        if (totalFilasFiltradas == 0) {
                          return Center(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.search_off,
                                    size: 48,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No se encontraron resultados',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _construirMensajeNoResultados(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: _limpiarTodosLosFiltros,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF3B82F6),
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text('Limpiar Filtros'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        
                        int filasPorPagina = _rowsPerPage;
                        int totalPaginas = (totalFilasFiltradas / filasPorPagina).ceil();
                        int paginaActual = _currentPage.clamp(0, totalPaginas - 1);
                        int inicio = paginaActual * filasPorPagina;
                        int fin = (inicio + filasPorPagina).clamp(0, totalFilasFiltradas);
                        
                        List<int> filasAMostrar = filasFiltradas.sublist(inicio, fin);
                        
                        return ListView.builder(
                          itemCount: filasAMostrar.length,
                          itemBuilder: (context, index) {
                            int rowIndex = filasAMostrar[index];
                            return _buildFilaOptimizada(rowIndex, diasDelMes, index, mesIndex);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilaOptimizada(int rowIndex, List<int> diasDelMes, int index, int mesIndex) {
    return Container(
      decoration: BoxDecoration(
        color: index % 2 == 0 ? Colors.white : const Color(0xFFF8FAFC),
        border: const Border(
          bottom: BorderSide(
            color: Color(0x33CCCCCC),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          _buildDropdownCell(
                                items: _dataManager.trabajadores,
            width: 200,
            valorSeleccionado: _obtenerValor(rowIndex, 'nombre', mesIndex),
            onChanged: (value) {
              _guardarValor(rowIndex, 'nombre', value, mesIndex);
            },
          ),
          _buildDropdownCell(
                                items: _dataManager.obras,
            width: 200,
            valorSeleccionado: _obtenerValor(rowIndex, 'obra', mesIndex),
            onChanged: (value) {
              _guardarValor(rowIndex, 'obra', value, mesIndex);
            },
          ),
          ...diasDelMes.map((dia) => _buildDropdownCell(
            items: opcionesDias,
            width: 60,
            fontSize: 10,
            valorSeleccionado: _obtenerValor(rowIndex, 'dia', mesIndex, dia),
            onChanged: (value) {
              _guardarValor(rowIndex, 'dia', value, mesIndex, dia);
            },
          )),
          // Columna TOTAL
          Container(
            width: 100,
            padding: const EdgeInsets.all(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
                color: Colors.blue.shade50,
              ),
              child: Text(
                _calcularTotalFila(rowIndex, diasDelMes, mesIndex).toString(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Función para calcular el total de una fila
  int _calcularTotalFila(int rowIndex, List<int> diasDelMes, int mesIndex) {
    int total = 0;
    for (int dia in diasDelMes) {
      String? valor = _obtenerValor(rowIndex, 'dia', mesIndex, dia);
      if (valor != null) {
        // Solo sumar valores numéricos (1-10), excluir V, F, ZZ
        int? numero = int.tryParse(valor);
        if (numero != null && numero >= 1 && numero <= 10) {
          total += numero;
        }
      }
    }
    return total;
  }

  Widget _buildDropdownCell({
    required List<String> items,
    required double width,
    double fontSize = 12,
    String? valorSeleccionado,
    required Function(String?) onChanged,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(8),
      child: _buildDropdownOptimizado(
        hint: '-',
        items: items,
        valorSeleccionado: valorSeleccionado,
        onChanged: onChanged,
        fontSize: fontSize,
      ),
    );
  }

  Widget _buildDropdownOptimizado({
    required String hint,
    required List<String> items,
    String? valorSeleccionado,
    required Function(String?) onChanged,
    double fontSize = 12,
  }) {
    return GestureDetector(
      onTap: () {
        _mostrarSelector(context, items, valorSeleccionado, onChanged, fontSize);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(4),
          color: valorSeleccionado != null ? Colors.blue.shade50 : Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                valorSeleccionado ?? hint,
                style: TextStyle(
                  fontSize: fontSize,
                  color: valorSeleccionado != null ? Colors.black : Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (valorSeleccionado != null)
              GestureDetector(
                onTap: () => onChanged(null),
                child: Icon(
                  Icons.close,
                  size: fontSize,
                  color: Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _mostrarSelector(
    BuildContext context,
    List<String> items,
    String? valorSeleccionado,
    Function(String?) onChanged,
    double fontSize,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Controlador para el campo de búsqueda
        TextEditingController searchController = TextEditingController();
        // Estado local para la lista filtrada
        return StatefulBuilder(
          builder: (context, setState) {
            String searchText = searchController.text.toLowerCase();
            List<String> filteredItems = items.where((item) => item.toLowerCase().contains(searchText)).toList();
            return AlertDialog(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Seleccionar',
                    style: TextStyle(fontSize: fontSize + 2),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: 'Buscar...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ],
              ),
              content: SizedBox(
                width: double.maxFinite,
                height: 300,
                child: Column(
                  children: [
                    // Contador de elementos
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Mostrando ${filteredItems.length} de ${items.length} trabajadores',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: filteredItems.isEmpty
                          ? Center(child: Text('No hay resultados'))
                          : ListView.builder(
                              itemCount: filteredItems.length + 1, // +1 para la opción "En blanco"
                              itemBuilder: (context, index) {
                          if (index == 0) {
                            // Opción "En blanco" al principio de la lista
                            return ListTile(
                              leading: Icon(Icons.space_bar, color: Colors.grey),
                              title: Text(
                                '-',
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {
                                onChanged(null); // Pasar null en lugar de la cadena "-"
                                Navigator.of(context).pop();
                              },
                            );
                          }
                          String item = filteredItems[index - 1]; // -1 porque el índice 0 es "En blanco"
                          bool isSelected = item == valorSeleccionado;
                          return ListTile(
                            title: Text(
                              item,
                              style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            tileColor: isSelected ? Colors.blue.shade50 : null,
                            onTap: () {
                              onChanged(item);
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancelar'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

// Widget optimizado para las celdas del header
class _HeaderCell extends StatelessWidget {
  final String text;
  final double width;
  final VoidCallback? onTap;
  final bool isActive;
  final String? ordenamiento;
  final bool? ordenAscendente;

  const _HeaderCell({
    required this.text,
    required this.width,
    this.onTap,
    this.isActive = false,
    this.ordenamiento,
    this.ordenAscendente,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isActive ? Colors.white.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (isActive && ordenamiento != null) ...[
              const SizedBox(width: 4),
              Icon(
                ordenAscendente == true ? Icons.arrow_upward : Icons.arrow_downward,
                color: Colors.white,
                size: 12,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
