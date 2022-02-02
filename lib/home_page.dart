// import 'package:flutter/material.dart';

// forma de animaçoes implicitas

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   var isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     // final size = 100.0;

//     return Scaffold(
//       body: Center(
//         // animação implicitas, para qualquer animacao usar a palavara animated
//         // nao tem muito controller , mas da pra fazer muita coisa vai da imaginacao
//         child: GestureDetector(
//           onTap: () {
//             setState(
//               () {
//                 isLoading = !isLoading;
//               },
//             );
//           },
//           child: AnimatedContainer(
//             curve: Curves.easeOut,
//             duration: const Duration(milliseconds: 800),
//             height: 80,
//             width: isLoading ? 80 : 400,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(
//                 isLoading ? 40 : 8,
//               ),
//               color: Colors.red,
//             ),
//             alignment: Alignment.center,
//             child: AnimatedCrossFade(
//               firstChild: const Padding(
//                 padding: EdgeInsets.all(
//                   20,
//                 ),
//                 child: CircularProgressIndicator(
//                   color: Colors.white,
//                 ),
//               ),
//               secondChild: const Text(
//                 'ENTRAR',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               crossFadeState: isLoading
//                   ? CrossFadeState.showFirst
//                   : CrossFadeState.showSecond,
//               duration: Duration(
//                 milliseconds: 500,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// forma de animaçoes controladas

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // tenho certeza que vai ser inicializada por causa do late,posteiromente, entao tenho que instancia o controller
  late final AnimationController controller;
  // aqui posso definir o tipo que eu quero, double,colors,text...
  late final Animation<double> squadSize;

  @override
  void initState() {
    super.initState();

    /// Esta classe precisa de uma classe TickerProvider passando o argumento vsync no construtor. O vsync impede animações off-screen de consumir recursos desnecessários.
    /// O objeto padrão AnimationController varia de 0,0 a 1,0, mas se você precisar de um intervalo diferente,e ele faz o calculo do fps automatico
    // você pode usar a classe Animation (usando Tween) para aceitar um tipo diferente de dados.
    // aqui foi instanciado por causa do late
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    );
    // no tween posso colocar um valor inicial e final
    squadSize = Tween<double>(begin: 100, end: 400).animate(controller);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            // tenho uma animacao automatica assim , repetidno animacao e dando o reverse true para voltar
            //controller.repeat(reverse: true);
            // aqui tenho uma condiçãp controlada no click
            if (controller.value > 0) {
              controller.reverse();
            } else {
              controller.forward();
            }
          },
          child: AnimatedBuilder(
            animation: squadSize,
            builder: (context, widget) {
              return Container(
                // aqui vai de 0 a 1 , entao quando ele for 0.1 ele vai fazer o calculo que seria 0.1 *100 =10
                // aqui eu passo meu squadSize que é mnha animacao e nao preciso fazer nenhum calculo pois definino no tween o inicio e o final pegando o animate e passando o controller
                height: squadSize.value,
                width: squadSize.value,
                color: Colors.red,
              );
            },
          ),
        ),
      ),
    );
  }
}
