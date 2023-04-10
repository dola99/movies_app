class Contsant {
  var baseUrl = 'api.themoviedb.org';
  var apiKey = 'afe9691e8afa0ebc9c6296062d75f53b';
  var imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const notFoundImage =
      'https://img.freepik.com/free-vector/page-found-concept-illustration_114360-1869.jpg?w=1380&t=st=1681163327~exp=1681163927~hmac=3080cc346354f560f2accec252981ade924feef325473d9b84586141bfa8110e';
  var headers = {'Accept-Encoding': 'gzip, deflate, br', 'Accept': '*/*'};
  var upComingMoviesEndPoint = '/3/movie/upcoming';
  var topRatedEndPoint = '/3/movie/top_rated';
  var latestMoviesEndPoint = '/3/movie/now_playing';
  var searchMoviesEndPoint = '/3/search/movie';
}
