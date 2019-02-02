import XCTest
@testable import HeyBeach

final class BeachCellPresenterTest: XCTestCase {
  
  private var repository: BeachCellRepositoryMock!
  private var view: BeachCellViewMock!
  private var presenter: BeachCellPresenter!
  
  override func setUp() {
    super.setUp()
    
    view = BeachCellViewMock()
    repository = BeachCellRepositoryMock()
    presenter = BeachCellPresenter(with: view, repository: repository)
  }
  
  func testOnPrepareForReuse() {
    presenter.onPrepareForReuse()
    
    XCTAssertEqual(repository.callHistory, [.stopLoading])
    XCTAssertEqual(view.callHistory, [.configureForLoading])
  }
  
  func testOnConfigure() {
    repository.mockResponse = UIImage()
    
    presenter.onConfigure(with: "", name: "")
    
    XCTAssertEqual(repository.callHistory, [.loadImage])
    XCTAssertEqual(view.callHistory, [.showImage])
  }
}
