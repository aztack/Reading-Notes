```pegjs
{
function builidShadowList(first,rest) {
	res = [first];
	for(var i = 0; i < rest.length; ++i) {
		res.push(rest[0][1]);
	}
	return res;
}
}


start = first:textShadow rest:("," textShadow)* { return builidShadowList(first, rest); }


textShadow
  = _ x:px __ y:px blur:(__ px)? __ color:rgba _ {
    var props = {
      color:color,
      x:x,
      y:y
    };
    if(blur) props.blur = blur[1]
    return props;
  }

  / _ color:rgba _ x:px __ y:px blur:(__ px)? _ {
    var props = {
      color:  color,
      x:      x,
      y:      y
    };
    if(blur) props.blur = blur[1]
    return props;
  }

rgba
  = "rgb" "a"? "(" elements:elements ")" {
    var res = {
        r: elements[0],
        g: elements[1],
        b: elements[2]
    }
    if (elements[3]) res.a = elements[3];
    return res;
  }

 
// Utilities

elements
  = _ head:value _ tail:("," _ value _)* {
      var result = [head];
      for (var i = 0; i < tail.length; i++) {
        result.push(tail[i][2]);
      }
      return result;
    }

value
  = number

number
  = float
  / integer

integer
  = digits:[0-9]+ {
      return parseInt(digits.join(""), 10);
    }

float
  = before:[0-9]* "." after:[0-9]+ {
      return parseFloat(before.join("") + "." + after.join(""));
    }

px
  = number:number "px" { return number; }


hex
  = [0-9a-fA-F]

_ "whitespace"
  = whitespace*

__ "required whitespace"
  = whitespace+

whitespace
  = [ \t\n\r]
```
