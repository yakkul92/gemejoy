document.addEventListener('DOMContentLoaded', function() {
  var captionText = document.getElementById('captionText');
  // console.log(captionText);
  var showMoreBtn = document.getElementById('showMoreBtn');
  var maxLines = 10; // 表示する最大行数

  function getNumberOfLines(element) {
    var lineHeight = parseInt(window.getComputedStyle(element).lineHeight, 10);
    var containerHeight = element.clientHeight;
    return Math.round(containerHeight / lineHeight);
  }

  var currentLines = getNumberOfLines(captionText);
  if (currentLines > maxLines) {
    captionText.style.maxHeight = (maxLines * parseInt(window.getComputedStyle(captionText).lineHeight, 10)) + 'px';
    showMoreBtn.style.display = 'block';
  }

  showMoreBtn.addEventListener('click', function() {
    captionText.style.maxHeight = 'none';
    showMoreBtn.style.display = 'none';
  });
});