import UIKit

var photo: [String]?
photo = []
let a = 0

if a != 0 {
  print("a==0")
}
else {
  if let photo = photo {
    if photo.isEmpty {
      print("photo?.isEmpty == true")
    }
    else {
      print("photo?.isEmpty == false")
    }
  }
  else {
    print("nothing")
  }
  
}
