// ad-blocker.js

// Select and remove common ad elements
document.querySelectorAll('div[class*="ad"], div[id*="ad"], div[class*="ads"], div[id*="ads"], [class*="ads"], [id*="ads"], [class*="ad"], [id*="ad"], [class*="sponsor"], [id*="sponsor"], [class*="marketing"], [id*="marketing"], [class*="promotion"], [id*="promotion"], [class*="promo"], [id*="promo"], [class*="affiliate"], [id*="affiliate"], [class*="banner"], [id*="banner"], [class*="leaderboard"], [id*="leaderboard"], [class*="skyscraper"], [id*="skyscraper"], [class*="sidebar"], [id*="sidebar"], [class*="pop"], [id*="pop"], [class*="overlay"], [id*="overlay"], [class*="float"], [id*="float"], [class*="modal"], [id*="modal"], [class*="interstitial"], [id*="interstitial"], [class*="hide"], [id*="hide"], [class*="block"], [id*="block"], [class*="remove"], [id*="remove"], [class*="ignore"], [id*="ignore"], [class*="close"], [id*="close"], [class*="x"], [id*="x"], [class*="adblock"], [id*="adblock"]').forEach(function(element) {
    element.remove();
  });
  
  // Remove iframe elements with certain class or src attribute
  document.querySelectorAll('iframe[class*="ad"], iframe[src*="doubleclick"], iframe[src*="ads."], iframe[src*="googlesyndication"], iframe[src*="adserver."], iframe[src*="banners."], iframe[src*="popups."], iframe[src*="popunders."], iframe[src*="tracking."], iframe[src*="yieldmanager"], iframe[src*="advertising."]').forEach(function(element) {
    element.remove();
  });
  
  // Remove img elements with certain src attribute
  document.querySelectorAll('src*="ad-delivery.net"').forEach(function(element) {
    element.remove();
  });
// Remove any image elements with a src containing 'ad.doubleclick.net'
document.querySelectorAll('src*="ad.doubleclick.net"').forEach(function(element) {
    element.remove();
    });  