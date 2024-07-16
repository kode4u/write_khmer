
import 'package:svg_generate/svg_util.dart';

void main()async{
  final filename = 'ខ.svg';

  Util u = Util();
  String text1 = await u.getPath('input/$filename', 'text1');
  String path1 =await u.getPath('input/$filename', 'path1');
  u.singleStroke(path: text1, clip: path1, filename: 'processed/$filename');
}