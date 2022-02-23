Container(
width:(MediaQuery.of(context).size.width),
height: 20,
padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
child: Row(
crossAxisAlignment: CrossAxisAlignment.center,
children: [
Expanded(child: TextField(
style: TextStyle(color: Colors.white),
decoration: InputDecoration(fillColor: gradientColors1[0], filled: true, labelText: 'Particle1'),
),
),
Expanded(child: TextField(
style: TextStyle(color: Colors.white),
decoration: InputDecoration(fillColor: gradientColors2[0], filled: true, labelText: 'Particle10'),
),
),
Expanded(child: TextField(
style: TextStyle(color: Colors.white),
decoration: InputDecoration(fillColor: gradientColors3[0], filled: true, labelText: 'Particle20'),
),
),
],
),
),