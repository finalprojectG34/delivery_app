import 'package:graphql_flutter/graphql_flutter.dart';

import '../../src/models/models.dart';

class CategoryRepository {
  final GraphQLClient gqlClient;

  CategoryRepository({required this.gqlClient});

  Future<List<Category>> getCategory() async {
    final response = await gqlClient.query(
      QueryOptions(
        document: gql(r'''
            query GetAllCategories {
                getAllCategories {
                  id
                  slug
                  name
                  image {
                    images
                    bgImage
                    imagePath
                    imageCover
                    suffix
                  }
                  poster
                  description
                  path
                  parentId
                  attributes {
                    name
                    slug
                    categoryIds
                  }
                  count
                  subCategories {
                    id
                    slug
                    name
                    image {
                      imagePath
                      suffix
                      imageCover
                      bgImage
                      images
                    }
                    description
                    poster
                    path
                    parentId
                    count
                    attributes {
                      name
                      categoryIds
                      slug
                    }
                  }
                }
              }
      '''),
      ),
    );
    if (response.hasException) {
      print(response.exception);
      throw Exception("Error Happened");
    }
    print(response);
    return (response.data!['getAllCategories'] as List)
        .map((e) => Category.fromJson(e))
        .toList();
  }
}
