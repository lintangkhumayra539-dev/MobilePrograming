import 'package:tugas_control_flow/tugas_control_flow.dart' as tugas_control_flow;

void main(List<String> arguments) {
  final hari = arguments.isEmpty ? 'Senin' : arguments.first;
  print(tugas_control_flow.getSeragamHari(hari));
}
