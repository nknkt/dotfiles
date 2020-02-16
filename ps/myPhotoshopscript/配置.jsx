
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
66
67
68
69
70
71
72
73
74
75
76
77
78
79
80
81
82
83
84
85
86
87
88
89
90
91
92
93
94
95
96
97
98
99
100
101
102
103
104
105
106
107
108
109
110
111
112
113
114
115
116
117
118
119
120
121
122
123
124
125
126
127
128
129
130
131
132
133
134
135
136
137
138
139
140
141
142
143
144
145
146
147
148
149
150
151
152
153
154
155
156
157
158
159
160
161
162
163
164
165
166
167
168
169
170
171
172
173
174
175
176
177
178
179
180
181
182
183
184
185
186
187
188
189
190
191
192
193
194
195
196
197
198
199
200
201
202
203
204
205
206
207
208
209
210
211
212
213
214
215
216
217
218
219
220
221
222
223
224
225
226
227
228
229
230
231
232
233
234
235
236
237
238
239
240
241
242
243
244
245
246
247
248
249
250
251
252
253
254
255
256
257
258
259
260
261
262
263
264
265
266
267
268
269
270
271
272
273
274
275
276
277
278
279
280
281
282
283
284
285
286
287
288
289
290
291
292
293
var savedState = activeDocument.activeHistoryState,
	firstRun = true;
 
function getSelectedLayersIdx() {
	var selectedLayers = [];
	var ref = new ActionReference();
	ref.putEnumerated(charIDToTypeID("Dcmn"), charIDToTypeID("Ordn"), charIDToTypeID("Trgt"));
	var desc = executeActionGet(ref);
	if (desc.hasKey(stringIDToTypeID('targetLayers'))) {
		desc = desc.getList(stringIDToTypeID('targetLayers'));
		var c = desc.count
		var selectedLayers = new Array();
		for (var i = 0; i < c; i++) {
			try {
				activeDocument.backgroundLayer;
				selectedLayers.push(desc.getReference(i).getIndex());
			} catch (e) {
				selectedLayers.push(desc.getReference(i).getIndex() + 1);
			}
		}
	} else {
		var ref = new ActionReference();
		ref.putProperty(charIDToTypeID("Prpr"), charIDToTypeID("ItmI"));
		ref.putEnumerated(charIDToTypeID("Lyr"), charIDToTypeID("Ordn"), charIDToTypeID("Trgt"));
		try {
			activeDocument.backgroundLayer;
			selectedLayers.push(executeActionGet(ref).getInteger(charIDToTypeID("ItmI")) - 1);
		} catch (e) {
			selectedLayers.push(executeActionGet(ref).getInteger(charIDToTypeID("ItmI")));
		}
	}
	return selectedLayers;
}
 
function makeActiveByIndex(idx, visible) {
	for (var i = 0; i < idx.length; i++) {
		var desc = new ActionDescriptor();
		var ref = new ActionReference();
		ref.putIndex(charIDToTypeID("Lyr "), idx[i])
		desc.putReference(charIDToTypeID("null"), ref);
		if (i > 0) {
			var idselectionModifier = stringIDToTypeID("selectionModifier");
			var idselectionModifierType = stringIDToTypeID("selectionModifierType");
			var idaddToSelection = stringIDToTypeID("addToSelection");
			desc.putEnumerated(idselectionModifier, idselectionModifierType, idaddToSelection);
		}
		desc.putBoolean(charIDToTypeID("MkVs"), visible);
		executeAction(charIDToTypeID("slct"), desc, DialogModes.NO);
	}
}
 
function getSelectedLayers() {
	var sl = getSelectedLayersIdx();
	var sLayers = new Array();
	for (var i = 0; i < sl.length; i++) {
		makeActiveByIndex([sl[i]], false);
		sLayers.push(activeDocument.activeLayer);
	}
	makeActiveByIndex(sl, false);
	return sLayers;
}
 
function eachLayer(fn) {
	var sl = getSelectedLayersIdx();
	for (var i = 0; i < sl.length; i++) {
		makeActiveByIndex([sl[i]], false);
		fn.apply(activeDocument.activeLayer, [i]);
	}
	makeActiveByIndex(sl, false);
}
 
function getSize(layer) {
	var height = parseInt(layer.bounds[3]) - parseInt(layer.bounds[1]);
	var width = parseInt(layer.bounds[2]) - parseInt(layer.bounds[0]);
	return {
		height: height,
		width: width
	};
}
 
function getPosition(layer) {
	var left = parseInt(layer.bounds[0]);
	var top = parseInt(layer.bounds[1]);
	return {
		left: left,
		top: top
	};
}
 
function MyLayer(layer) {
	var size = getSize(layer),
		position = getPosition(layer);
	this.layer = layer;
	this.width = size.width;
	this.height = size.height;
	this.left = position.left;
	this.top = position.top;
}
MyLayer.prototype.translate = function (x, y) {
	this.layer.translate(x - this.left, y - this.top);
}
 
function margin(gap) {
	var startPos = {};
	eachLayer(function (index) {
		var currentLayer = new MyLayer(this);
		if (index == 0) {
			startPos.x = gap.x == 0 ? currentLayer.left : currentLayer.left + currentLayer.width + gap.x;
			startPos.y = gap.y == 0 ? currentLayer.top : currentLayer.top + currentLayer.height + gap.y;
			return;
		}
		currentLayer.translate(startPos.x, startPos.y);
		if (gap.x != 0) {
			startPos.x += currentLayer.width + gap.x;
		}
		if (gap.y != 0) {
			startPos.y += currentLayer.height + gap.y;
		}
	});
	refresh();
}
 
function marginright(gap) {
	var startPos = {};
	eachLayer(function (index) {
		var currentLayer = new MyLayer(this);
		if (index == 0) {
			startPos.x = currentLayer.left + currentLayer.width + gap.x;
			startPos.y = gap.y == 0 ? currentLayer.top : currentLayer.top + currentLayer.height + gap.y;
			return;
		}
		currentLayer.translate(startPos.x, startPos.y);
		if (gap.x >= 0) {
			startPos.x += currentLayer.width + gap.x;
		}
		if (gap.y != 0) {
			startPos.y += currentLayer.height + gap.y;
		}
	});
	refresh();
}
 
function margintop(gap) {
	var startPos = {};
	eachLayer(function (index) {
		var currentLayer = new MyLayer(this);
		if (index == 0) {
			startPos.x = gap.x == 0 ? currentLayer.left : currentLayer.left + currentLayer.width + gap.x;
			startPos.y = currentLayer.top + currentLayer.height + gap.y;
			return;
		}
		currentLayer.translate(startPos.x, startPos.y);
		if (gap.x != 0) {
			startPos.x += currentLayer.width + gap.x;
		}
		if (gap.y >= 0) {
			startPos.y += currentLayer.height + gap.y;
		}
	});
	refresh();
}
 
var win = new Window("dialog", "margin");
win.bounds = {
	x: 600,
	y: 400,
	width: 300,
	height: 200
};
 
win.text_mr = win.add("statictext", {
	width: 180,
	height: 20,
	x: 10,
	y: 10
}, "margin-right (max-500)");
win.etext_mr = win.add("edittext", {
	width: 80,
	height: 20,
	x: 210,
	y: 10
}, "0");
win.slider_mr = win.add("slider", {
	width: 280,
	height: 10,
	x: 10,
	y: 40
}, 0, 0, 500);
win.text_mt = win.add("statictext", {
	width: 180,
	height: 20,
	x: 10,
	y: 60
}, "margin-top (max-500)");
win.etext_mt = win.add("edittext", {
	width: 80,
	height: 20,
	x: 210,
	y: 60
}, "0");
win.slider_mt = win.add("slider", {
	width: 280,
	height: 10,
	x: 10,
	y: 90
}, 0, 0, 500);
win.rBtn1 = win.add("button", {
	width: 130,
	height: 25,
	x: 10,
	y: 120
}, "Apply-top");
win.rBtn2 = win.add("button", {
	width: 130,
	height: 25,
	x: 160,
	y: 120
}, "Apply-right");
win.okbtn = win.add("button", {
	width: 80,
	height: 25,
	x: 10,
	y: 160
}, "OK", {
	name: "ok"
});
win.apbtn = win.add("button", {
	width: 80,
	height: 25,
	x: 110,
	y: 160
}, "Apply");
win.cnbtn = win.add("button", {
	width: 80,
	height: 25,
	x: 210,
	y: 160
}, "Cancel", {
	name: "cancel"
});
win.slider_mr.onChanging = function () {
	win.etext_mr.text = parseInt(win.slider_mr.value);
};
win.etext_mr.onChanging = function () {
	win.slider_mr.value = parseInt(win.etext_mr.text);
};
win.slider_mt.onChanging = function () {
	win.etext_mt.text = parseInt(win.slider_mt.value);
};
win.etext_mt.onChanging = function () {
	win.slider_mt.value = parseInt(win.etext_mt.text);
};
win.apbtn.onClick = function () {
	firstRun = false;
	var gap = {
		x: win.slider_mr.value,
		y: win.slider_mt.value
	};
	activeDocument.suspendHistory('margin', 'margin(gap)');
};
win.rBtn1.onClick = function () {
	firstRun = false;
	var gap = {
		x: win.slider_mr.value,
		y: win.slider_mt.value
	};
	activeDocument.suspendHistory('margin', 'margintop(gap)');
};
win.rBtn2.onClick = function () {
	firstRun = false;
	var gap = {
		x: win.slider_mr.value,
		y: win.slider_mt.value
	};
	activeDocument.suspendHistory('margin', 'marginright(gap)');
};
win.okbtn.onClick = function () {
	if (firstRun) {
		var gap = {
			x: win.slider_mr.value,
			y: win.slider_mt.value
		};
		activeDocument.suspendHistory('margin', 'margin(gap)');
		win.close();
	} else {
		win.close();
	}
}
win.cnbtn.onClick = function () {
	activeDocument.activeHistoryState = savedState;
	win.close();
};
win.show();