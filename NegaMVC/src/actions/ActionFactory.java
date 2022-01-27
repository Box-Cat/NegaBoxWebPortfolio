package actions;


public class ActionFactory {
	private static ActionFactory instance = new ActionFactory();
	private ActionFactory() {}
	
	static ActionFactory getInstance() {
		return instance;
	}
	
	Action getAction(String command) {
		System.out.println("ActionFactory getAction()에서, command=" + command);
		Action action = null;

		switch(command) {
			case "main": action = new MainAction(); break;
			case "loginCheck": action = new LoginCheckAction(); break;
			case "fastRev": action = new FastRevAction(); break;
			case "movieTimeList": action = new MovieTimeListAction(); break;
			case "theaterTimeList": action = new TheaterTimeListAction(); break;
			case "allMovie": action = new AllMovieAction(); break;
			case "heartCalc": action = new HeartCalcAction(); break;
			case "movieInfo": action = new MovieInfoAction(); break;
			case "writeReview": action = new WriteReviewAction(); break;
			case "quickSeatsRev": action = new QuickSeatsRevAction(); break;
			case "insertSeats": action = new InsertSeatsAction(); break;
			case "sendEmail": action = new SendEmailAction(); break;
			case "checkEmailNumber": action = new CheckEmailNumberAction(); break;
			case "idCheck": action = new IdCheckAction(); break;
			case "register": action = new RegisterAction(); break;
		}
		
		return action;
	}
}
