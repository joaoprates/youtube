import 'package:flutter/material.dart';
import 'package:youtube/Api.dart';
import 'package:youtube/model/Video.dart';

class Inicio extends StatefulWidget {

  String search;
  Inicio( this.search );

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  _listVideos( String search ){

    Api api = Api();
    return api.search( search );

  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Video>>(
      future: _listVideos( widget.search ),
      // ignore: missing_return
      builder: ( context, snapshot ) {

        switch( snapshot.connectionState ) {

          case ConnectionState.none :
          case ConnectionState.waiting :
            return Center(
              child: CircularProgressIndicator(),
              );
            break;
          case ConnectionState.active :

          case ConnectionState.done :
            if( snapshot.hasData ){
              return ListView.separated(
                itemBuilder: (context, index){

                  List<Video> videos = snapshot.data;
                  Video video = videos[ index ];

                  return Column(
                    children: <Widget>[
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage( video.image )
                          )
                        ),
                      ),
                      ListTile(
                        title: Text( video.title ),
                        subtitle: Text( video.channel ),
                      )
                    ],
                  );

                },
                separatorBuilder: (context, index) => Divider(
                  height: 3,
                  color: Colors.red,
              ),
                itemCount: snapshot.data.length
              );
            }else{

              return Center(
                child: Text("Sorry! No data to show."),
                );
            }
            break;
        // ignore: missing_return
        }
      },
    );
  }
}
