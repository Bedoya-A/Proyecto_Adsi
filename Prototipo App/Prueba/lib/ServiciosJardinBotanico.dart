import 'package:flutter/material.dart';
import 'package:prueba2/ServicioDetalle.dart';

class ServiciosJardinBotanico extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Servicios del Jardín Botánico',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
              ),
            ),
            SizedBox(height: 10),
            _buildServiceItem(
                context,
                'Observación de aves',
                'assets/aves.jpg',
                'assets/observacionaves_detalle.jpg',
                'Se destaca la importancia del Jardín Botánico como destino aviturístico, y nuestros visitantes pueden observarlas con guianzas diurnas o nocturnas, dirigida a todo tipo de público, particularmente a las personas interesadas en avistamiento y fotografía de aves. \n'
                    '\n'
                    'El Jardín cuenta con un inventario de 211 especies en ambiente natural, cada una con su respectiva ficha técnica que puede ser consultada en la Guía de Aves del Jardín Botánico San Jorge (2016), y lista de chequeo para facilitar su identificación.'),
            _buildServiceItem(
                context,
                'Senderismo',
                'assets/senderismo.jpg',
                'assets/senderismo_detalle.jpg',
                'El jardín botánico cuenta con una infraestructura de 7 km de senderos, organizados en tres circuitos, cada uno de los cuales tiene diferentes niveles de dificultad y conduce a miradores, desde los que se observa la ciudad de Ibagué y el plan del Tolima: \n'
                    '\n'
                    ''
                    '• Sendero del Lago (Mirador Sindamanoy) \n'
                    '• Sendero Las Palmas (Mirador Arrayanes)\n '
                    '• Sendero Las Quinas (Mirador Fiques)'),
            _buildServiceItem(
                context,
                'Guianzas especializadas',
                'assets/guianzas.jpg',
                'assets/guianzas_detalle.jpg',
                'El Jardín Botánico San Jorge ofrece recorridos temáticos con guía docente especializado, con  10 personas por guía, en los cuales se puede desarrollar, entre otros, uno de los siguientes temas: \n'
                    '\n'
                    'Cultivo y uso de plantas medicinales: dirigida a todo tipo de público, particularmente a las personas interesadas en el manejo y aprovechamiento de plantas aromáticas y medicinales. El Jardín cuenta con un jardín de medicinales con más de 30 especies cada una con su respectiva ficha técnica para facilitar su identificación y su manejo. \n'
                    '\n'
                    'Sistemática vegetal: guianza diurna, dirigida a público universitario, interesado en profundizar conocimientos en botánica general y sistemática vegetal. El Jardín cuenta con un inventario de 657 especies de plantas organizadas en 12 colecciones incluida colección in-situ.'),
            _buildServiceItem(
                context,
                'Eventos familiares y corporativos',
                'assets/eventos.jpg',
                'assets/eventosDetalle.jpg',
                'Como un aporte al mejoramiento del clima organizacional de las empresas y entidades gubernamentales, en el Jardín Botánico San Jorge se desarrollan actividades que motivan e incentivan el sentido de cooperación, ingenio, recursividad y trabajo en equipo que los participantes deberán demostrar en el desarrollo de diferentes pruebas y retos, para el beneficio común de todo el grupo, fortaleciendo a su vez los valores de solidaridad, respeto, honestidad, perseverancia, entre otros, según el tema de interés de los participantes. La actividad es coordinada por guías docentes capacitados en la ejecución de este tipo de pruebas. \n'
                    '\n'
                    'Adicionalmente con el objetivo de crear pertenencia con el Jardín Botánico, se ha adecuado el espacio para realizar actividades de integración familiar y desarrollo personal, como celebración de cumpleaños infantiles, matrimonios, terapias de relajación, yoga, picnic, entre otras.'
                    '\n'),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem(BuildContext context, String title,
      String thumbnailImage, String detailImage, String description) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServicioDetalle(
                title: title, image: detailImage, description: description),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.asset(
                thumbnailImage,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
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
