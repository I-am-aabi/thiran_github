import 'dart:convert';

Gitrepo gitrepoFromJson(String str) => Gitrepo.fromJson(json.decode(str));

class Gitrepo {
  int totalCount;
  bool incompleteResults;
  List<Item> items;

  Gitrepo({
    required this.totalCount,
    required this.incompleteResults,
    required this.items,
  });

  factory Gitrepo.fromJson(Map<String, dynamic> json) => Gitrepo(
        totalCount: json["total_count"],
        incompleteResults: json["incomplete_results"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );
}

class Item {
  int id;
  String name;
  String fullName;
  bool private;
  Owner owner;
  String htmlUrl;
  String? description;
  int size;
  int stargazersCount;

  Item({
    required this.id,
    required this.name,
    required this.fullName,
    required this.private,
    required this.owner,
    required this.htmlUrl,
    this.description,
    required this.size,
    required this.stargazersCount,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        fullName: json["full_name"],
        private: json["private"],
        owner: Owner.fromJson(json["owner"]),
        htmlUrl: json["html_url"],
        description: json["description"],
        size: json["size"],
        stargazersCount: json["stargazers_count"],
      );
}

class Owner {
  String login;
  int id;
  String nodeId;
  String avatarUrl;
  String url;
  String starredUrl;

  Owner({
    required this.login,
    required this.id,
    required this.nodeId,
    required this.avatarUrl,
    required this.url,
    required this.starredUrl,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        login: json["login"],
        id: json["id"],
        nodeId: json["node_id"],
        avatarUrl: json["avatar_url"],
        url: json["url"],
        starredUrl: json["starred_url"],
      );
}
