import 'package:flutter/material.dart';
import 'package:latihan_modul7/api_data_source.dart';
import 'package:latihan_modul7/user_model.dart';

class PageListUsers extends StatefulWidget {
  const PageListUsers({super.key});

  @override
  State<PageListUsers> createState() => _PageListUsersState();
}

class _PageListUsersState extends State<PageListUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Users Dari API"),
      ),
      body: _buildListUsersBody(),
    );
  }

  Widget _buildListUsersBody() {
    return Container(
      child: FutureBuilder(
          future: ApiDataSource.instance.loadUsers(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return _buildErrorSection();
            }
            if (snapshot.hasData) {
              UsersModel usersModel = UsersModel.fromJson(snapshot.data);
              return _buildSuccessSection(usersModel);
            }
            return _buildLoadingSection();
          }),
    );
  }

  Widget _buildErrorSection() {
    return Center(
      child: Text("Error"),
    );
  }

  Widget _buildSuccessSection(UsersModel data) {
    return ListView.builder(
        itemCount: data.data!.length,
        itemBuilder: (BuildContext context, int index) {
          return _BuildItemUsers(data.data![index]);
        });
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _BuildItemUsers(Data UsersModel) {
    return InkWell(
      onTap: () => null,
      //Navigator.push(context,
      //MaterialPageroute(builder: (context) => PageDetailUsers(UsersModel: UsersModel))
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 100,
              child: Image.network(UsersModel.avatar!),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(UsersModel.firstName! + " " + UsersModel.lastName!),
                Text(UsersModel.email!),
              ],
            )
          ],
        ),
      ),
    );
  }
}