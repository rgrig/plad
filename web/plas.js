function toggleShow(e) {
  var txt = document.getElementById(e);
  if (txt.style.display != "block") {
    txt.style.display="block";
    txt.style.webkitAnimationName="appear";
  } else {
    txt.style.display="none";
    //txt.style.webkitAnimationName="disappear";
  }
  return false
}
window.MathJax = {
    tex2jax: {
      inlineMath: [ ['$','$'], ["\\(","\\)"] ],
      processEscapes: true
    }
  };

