import 'package:flutter/material.dart';
import 'package:poke_app/modules/network/services_network.dart';

import 'package:provider/provider.dart';

abstract class IDetailRepository {
  Future getDescription(int id);
}

class DetailRepository implements IDetailRepository {
  BuildContext context;

  DetailRepository(this.context);

  @override
  Future getDescription(int id) async {
    return await Provider.of<Network>(context, listen: false)
        .getPokemonDescription(id);
  }
}
