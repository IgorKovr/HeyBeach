import XCTest
@testable import HeyBeach

final class BeachesListPresenterTest: XCTestCase {
  
  private var repository: BeachesListRepositoryMock!
  private var view: BeachesListViewMock!
  private var presenter: BeachesListPresenter!
  
  override func setUp() {
    super.setUp()
    
    view = BeachesListViewMock()
    repository = BeachesListRepositoryMock()
    presenter = BeachesListPresenter(with: view, repository: repository)
  }
  
  func testOnViewDidLoad() {
    presenter.onViewDidLoad()
    
    XCTAssertEqual(repository.callHistory, [.loadImages])
    XCTAssertEqual(view.callHistory, [.configureForUserLoggedIn,
                                      .showImagesList])
  }
  
  func testOnScrolledCloseToEnd() {
    presenter.onScrolledCloseToEnd()
    
    XCTAssertEqual(repository.callHistory, [.loadImages])
    XCTAssertEqual(view.callHistory, [.showImagesList])
  }

  func testOnScrolledCloseToEndEmptyResponse() {
    repository.mockResponse = []

    presenter.onScrolledCloseToEnd()

    XCTAssertEqual(repository.callHistory, [.loadImages])
    XCTAssertEqual(view.callHistory, [])
  }
  
  func testOnErrorResponse() {
    repository.shouldFail = true
    
    presenter.onScrolledCloseToEnd()
    
    XCTAssertEqual(repository.callHistory, [.loadImages])
    XCTAssertEqual(view.callHistory, [.showError])
  }
  
  func testOnLogin() {
    presenter.onLoginDialogEndedWith(email: "", password: "")
    
    XCTAssertEqual(repository.callHistory, [.login])
    XCTAssertEqual(view.callHistory, [.configureForUserLoggedIn])
  }
  
  func testOnRegister() {
    presenter.onRegisterDialogEndedWith(email: "", password: "")
    
    XCTAssertEqual(repository.callHistory, [.register])
    XCTAssertEqual(view.callHistory, [.configureForUserLoggedIn])
  }
  
  func testOnLogout() {
    presenter.onLogoutTap()
    
    XCTAssertEqual(repository.callHistory, [.logout])
    XCTAssertEqual(view.callHistory, [.configureForUserLoggedIn])
  }
}
