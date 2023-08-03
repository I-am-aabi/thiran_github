import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thiran/controllers/gitrepo_data_controller.dart';
import 'package:thiran/models/Gitrepo_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Repositories'),
      ),
      body: Consumer<Gitcontrolller>(
        builder: (context, githubRepo, _) {
          final repositories = githubRepo.repositories;
          if (repositories == null) {
            return const Text('NO data found');
          }
          if (repositories.isNotEmpty) {
            return ListView.builder(
              itemCount: repositories.length + 1,
              itemBuilder: (context, index) {
                if (index < repositories.length) {
                  final Item repository = repositories[index];
                  return ListTile(
                    title: Text(repository.name),
                    subtitle:
                        Text(repository.description ?? 'No description'),
                  );
                } else {
                  if (!githubRepo.hasReachedEnd) {
                    githubRepo.fetchRepositories();
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    githubRepo.fetchRepositories();
                    return const Center(child: Text('No more repositories to load.'));
                  }
                }
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
