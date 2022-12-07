import 'package:flutter/material.dart';
import 'data_source.dart';
import 'detail_matches_model.dart';

class DetailPage extends StatefulWidget {
  final String id;
  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Flexible(
            child: Text("Match ID : ${widget.id}",
                style: TextStyle(
                  color: Colors.white,
                ))),
      ),
      body:
      Container(
        decoration: BoxDecoration(
        color: const Color(0xffc7daef),
        image: DecorationImage(
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
        image: AssetImage("img/qtr.jpg"),
            )
        ),
        child: ListView(
          children: [
            Column(
              children: [
                FutureBuilder(
                  future: DetailListMatchesSource.instance.loadDetailMatches(widget.id),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasError) {
                      return _buildErrorSection();
                    }
                    if (snapshot.hasData) {
                      DetailMatchesModel detailModels = DetailMatchesModel.fromJson(snapshot.data);
                      return _buildSuccessSection(detailModels);
                    }
                    return _buildLoadingSection();
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection (DetailMatchesModel data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network("https://countryflagsapi.com/png/${data.homeTeam?.name}", width: 190, height: 150,),
            SizedBox(width: 10,),
            Text("${data.homeTeam?.goals}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(width: 10,),
            Text(" - ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(width: 10,),
            Text("${data.awayTeam?.goals}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(width: 10,),
            Image.network("https://countryflagsapi.com/png/${data.awayTeam?.name}", width: 190, height: 150,),
          ],
        ),
        SizedBox(height: 5,),
        Text("${data.homeTeam?.name}                                                           ${data.awayTeam?.name}"),
        SizedBox(height: 10,),
        Text("Stadium : ", style: TextStyle(fontSize: 17)),
        Text("${data.venue}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        SizedBox(height: 5,),
        Text("Location : ", style: TextStyle(fontSize: 17)),
        Text(" ${data.location} ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),

        SizedBox(height: 10,),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(0)
          ),
          padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
          margin: EdgeInsets.all(5),
          width: double.infinity,
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Statistics", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 15,),
              Text("${data.homeTeam?.statistics?.ballPossession}          Ball Possession          ${data.awayTeam?.statistics?.ballPossession}"),
              SizedBox(height: 5,),
              Text("${data.homeTeam?.statistics?.attemptsOnGoal}                           Shot                           ${data.awayTeam?.statistics?.attemptsOnGoal}"),
              SizedBox(height: 5,),
              Text("${data.homeTeam?.statistics?.kicksOnTarget}                    Shot On Goal                    ${data.awayTeam?.statistics?.kicksOnTarget}"),
              SizedBox(height: 5,),
              Text("${data.homeTeam?.statistics?.corners}                        Corners                         ${data.awayTeam?.statistics?.corners}"),
              SizedBox(height: 5,),
              Text("${data.homeTeam?.statistics?.offsides}                         Offside                         ${data.awayTeam?.statistics?.offsides}"),
              SizedBox(height: 5,),
              Text("${data.homeTeam?.statistics?.foulsReceived}                          Fouls                         ${data.awayTeam?.statistics?.foulsReceived}"),
              SizedBox(height: 5,),
              Text("${data.homeTeam?.statistics?.passesCompleted}              Passes Completed               ${data.awayTeam?.statistics?.passesCompleted}"),
              SizedBox(height: 10,)
            ],
          ),
        ),
        SizedBox(height: 5,),
        Text("Referees : ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 125,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.officials?.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(0)
                  ),
                  margin: EdgeInsets.all(5),
                  width: 100,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("FIFA", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
                      SizedBox(width: 5,),
                      Flexible(
                        child: Text("${data.officials?[index].name}", maxLines: 1,),
                      ),
                      SizedBox(width: 5,),
                      Flexible(
                        child: Text("${data.officials?[index].role}", maxLines: 1,),
                      ),
                    ],
                  ),
                );
              }
          ),
        ),
      ],
    );
  }
}