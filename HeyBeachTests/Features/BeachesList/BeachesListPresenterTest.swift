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
    XCTAssertEqual(view.callHistory, [.showImagesList])
  }
  
  func testOnScrolledCloseToEnd() {
    presenter.onScrolledCloseToEnd()
    
    XCTAssertEqual(repository.callHistory, [.loadImages])
    XCTAssertEqual(view.callHistory, [.showImagesList])
  }
  
  func testOnErrorResponse() {
    repository.shouldFail = true
    
    presenter.onViewDidLoad()
    
    XCTAssertEqual(repository.callHistory, [.loadImages])
    XCTAssertEqual(view.callHistory, [.showError])
  }
}
