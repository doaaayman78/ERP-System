import 'package:material_ui/material_ui.dart';
import 'core/config/env_config.dart';

void main(){
  runApp(const ERPApp());
}

class ERPApp extends StatelessWidget{
  const ERPApp({super.key});

  @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'ERP System (Dev)',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blueGrey,
          ),
          useMaterial3: true,
        ),

        home: Scaffold(
          appBar: AppBar(
            title: const Text('ERP Development - ${EnvConfig.flavor}'),
          ),
          body: Center(
            child: Text('Connected to Backend: ${EnvConfig.apiBaseUrl}'),
          ),
        ),
      );
    }
}