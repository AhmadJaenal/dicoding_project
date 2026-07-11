import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:serialtv/data/models/serial_table.dart';
import 'package:serialtv/data/models/serial_tv_model.dart';
import 'package:serialtv/domain/entities/serial_tv.dart';

final tMovieModel = MovieModel(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final tMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final tMovieModelList = <MovieModel>[tMovieModel];
final tMovieList = <Movie>[tMovie];

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
  isMovie: 1,
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
  isMovie: 1,
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'isMovie': 1,
};

final tSerialTVModel = SerialTVModel(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalName: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    name: 'Spider-Man',
    firstAirDate: DateTime(2002 - 05 - 12),
    voteAverage: 7.2,
    voteCount: 13507,
    originCountry: ['US'],
    originalLanguage: 'EN',
    softcore: false);

final tSerialTV = SerialTV(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalName: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    name: 'Spider-Man',
    firstAirDate: DateTime(2002 - 05 - 12),
    voteAverage: 7.2,
    voteCount: 13507,
    originCountry: ['US'],
    originalLanguage: 'EN',
    softcore: false);

final tSerialTVWatchlist = SerialTV.watchlist(
  isMovie: 0,
  id: 232,
  name: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
);

final tSerialModelList = [tSerialTVModel];
final tSerialTVList = [tSerialTV];

final testSerial = SerialTV(
  adult: false,
  backdropPath: '/backdrop.jpg',
  genreIds: [10765, 18],
  id: 1399,
  originCountry: ['US'],
  originalLanguage: 'en',
  originalName: 'Game of Thrones',
  overview: 'Overview',
  popularity: 369.594,
  posterPath: '/poster.jpg',
  firstAirDate: DateTime(2011 - 04 - 17),
  name: 'Game of Thrones',
  voteAverage: 8.4,
  voteCount: 11504,
);

const testWatchlistSerial = SerialTV.watchlist(
  id: 1399,
  name: 'Game of Thrones',
  posterPath: '/poster.jpg',
  overview: 'Overview',
  isMovie: 0,
);

const testSerialTable = SerialTable(
  id: 232,
  title: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  isMovie: 0,
);

final testSerialMap = {
  'id': 1399,
  'title': 'Game of Thrones',
  'posterPath': '/poster.jpg',
  'overview': 'Overview',
  'isMovie': 0,
};

final testSerialList = <SerialTV>[
  testSerial,
];

final testWatchlistSerialList = <SerialTV>[
  testWatchlistSerial,
];

final testSerialTableList = <SerialTable>[
  testSerialTable,
];

final testSerialMapList = <Map<String, dynamic>>[
  testSerialMap,
];
