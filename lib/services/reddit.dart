import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:draw/draw.dart';

@lazySingleton
class RedditService {
  @factoryMethod
  static Future<RedditService> create() async {
    var service = RedditService();
    service._reddit = await Reddit.createReadOnlyInstance(
      clientId: utf8.decode(base64.decode(
        'Y2piVHRSazFtb3k0NXc=', // To hide real clientId from Git
      )),
      clientSecret: utf8.decode(base64.decode(
        'WDdHb2pvd3Z2Rkh6d25aR08wbWcyZ2tKbzR3', // To hide real clientSecret from Git
      )),
      userAgent: 'itis.team.reddit.client',
    );
    return service;
  }

  Reddit _reddit;
  Reddit get reddit => _reddit;
}
