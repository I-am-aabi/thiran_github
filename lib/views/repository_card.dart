import 'package:flutter/material.dart';
import 'package:thiran/models/Gitrepo_model.dart';

class RepoCard extends StatelessWidget {
  const RepoCard({super.key, required this.git});
  final Item git;
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: double.maxFinite,
      height: 150,
      child: Card(
        elevation: 3,
        color: Colors.blue.shade100,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(git.owner.avatarUrl)),),
                    const SizedBox(width: 8,),
                  Expanded(
                    child: Text(git.name,style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400
                    ),),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(git.stargazersCount.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                      const Icon(Icons.star,color: Colors.yellow,size: 30,)
                    ],
                  )
                ],
              ),
              
              Expanded(child: Text(git.description ?? 'NO description found'))
            ],
          ),
        ),
      ),
    );
  }
}
