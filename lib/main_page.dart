import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikachu_jump/main_game_cubit.dart';
import 'package:pikachu_jump/pokemon.dart';
import 'package:pikachu_jump/stone.dart';

///
/// The main page of the application
///
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late MainGameCubit gameBloc;
  GlobalKey<PokemonState> pokemonState = GlobalKey();
  @override
  void initState() {
    super.initState();
    gameBloc = MainGameCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pikachu Jump"),
      ),
      body: BlocProvider(
        create: (_) => gameBloc,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BlocBuilder<MainGameCubit, MainGameState>(
                builder: (_, state) => Text(
                  "Score ${state.score} , High Score ${state.highScore}",
                ),
              ),
              Pokemon(key: pokemonState),
              const StoneWidget(),
              ElevatedButton(
                onPressed: () {
                  gameBloc.score++;
                  pokemonState.currentState?.jump();
                },
                child: const Text("Jump!"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
