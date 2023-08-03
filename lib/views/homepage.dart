import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thiran/controllers/gitrepo_data_controller.dart';
import 'package:thiran/models/Gitrepo_model.dart';
import 'package:thiran/views/appbar.dart';
import 'package:thiran/views/repository_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: GitAppBar()),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10),
        child: Consumer<Gitcontrolller>(
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
                    return RepoCard(
                      git: repository,
                    );
                  } else {
                    if (!githubRepo.hasReachedEnd) {
                      githubRepo.fetchRepositories();
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      githubRepo.fetchRepositories();
                      return const Center(
                          child: Text('No more repositories to load.'));
                    }
                  }
                },
              );
            } else {
              githubRepo.fetchRepositories();
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
