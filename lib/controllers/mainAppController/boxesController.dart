import 'package:clicker/MyApp.dart';
import 'package:clicker/models/BoxesModel.dart';
import 'package:provider/provider.dart';

final boxesController = ChangeNotifierProvider(
  builder: (context) => BoxesModel(),
  child: MyApp(),
);
