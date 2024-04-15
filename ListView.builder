 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 80,
              child: Image.asset('assets/rdplogo.png'),
            ),
            Text('Daily Planner',
                style: TextStyle(
                  fontFamily: 'Caveat',
                  fontSize: 32,
                )),
          ],
        ),
      ),
      body: Container(
        color: Colors.grey[200], // Change the background color
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              color: Colors.white, // Change the background color
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: TableCalendar(
                    calendarFormat: _calendarFormat,
                    headerVisible: false,
                    focusedDay: _focusedDay,
                    firstDay: DateTime(2022),
                    lastDay: DateTime(2030),
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay; // Update the focused day
                      });
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment(0.00, 0.9999),
                    end: Alignment(0.00, 0.22),
                    colors: <Color>[
                      Colors.white.withOpacity(0.9),
                      Colors.transparent,
                    ],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstOut,
                child: ListView.builder(
                  padding: const EdgeInsets.all(1),
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: checkboxes[index]
                            ? Colors.green.withOpacity(0.7)
                            : Colors.blue.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: EdgeInsets.all(2),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Row(
                                children: [
                                  Icon(
                                    !checkboxes[index]
                                        ? Icons.manage_history
                                        : Icons.playlist_add_check_circle,
                                    color: !checkboxes[index]
                                        ? Colors.white
                                        : Colors.white,
                                    size: 32,
                                  ),
                                  SizedBox(width: 18),
                                  Text(
                                    '${tasks[index]}',
                                    style: checkboxes[index]
                                        ? TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: 20,
                                            color:
                                                Colors.black.withOpacity(0.5),
                                          )
                                        : TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Checkbox(
                            value: checkboxes[index],
                            onChanged: (newValue) {
                              setState(() {
                                checkboxes[index] = newValue!;
                              });
                              updateTaskCompletionStatus(
                                  tasks[index], newValue!);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              removeItem(index);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12, left: 25, right: 25),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: TextField(
                        controller: nameController,
                        focusNode: _textFieldFocusNode,
                        maxLength: 20,
                        style: TextStyle(fontSize: 18), // Set the text style
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(
                              16), // Add padding to the input area
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Customize border radius
                          ),
                          labelText: 'Add To-Do List Item',
                          labelStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.blue), // Customize label style
                          hintText: 'Enter your task here', // Placeholder text
                          hintStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.grey), // Placeholder style
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue,
                                width: 2), // Custom focused border
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: clearTextField,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: Text('Add To-Do Item'),
                onPressed: () {
                  _textFieldFocusNode.unfocus();
                  addItemToList();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
