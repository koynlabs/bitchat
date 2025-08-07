import XCTest
@testable import bitchat

final class AutocorrectTests: XCTestCase {
    
    var viewModel: ChatViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ChatViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testAutocorrectEnabledByDefault() {
        XCTAssertTrue(viewModel.autocorrectEnabled)
    }
    
    func testAutocorrectToggle() {
        // Test toggle functionality
        viewModel.toggleAutocorrect()
        XCTAssertFalse(viewModel.autocorrectEnabled)
        
        viewModel.toggleAutocorrect()
        XCTAssertTrue(viewModel.autocorrectEnabled)
    }
    
    func testAutocorrectDisabled() {
        viewModel.autocorrectEnabled = false
        viewModel.updateAutocorrect(for: "helllo", cursorPosition: 6)
        
        // Should not show autocorrect when disabled
        XCTAssertFalse(viewModel.showAutocorrect)
        XCTAssertTrue(viewModel.autocorrectSuggestions.isEmpty)
    }
    
    func testSpellCheckSuggestions() {
        viewModel.autocorrectEnabled = true
        
        // Test with a misspelled word
        let suggestions = viewModel.getSpellCheckSuggestions(for: "helllo")
        
        // Should return suggestions for "hello"
        XCTAssertFalse(suggestions.isEmpty)
        XCTAssertTrue(suggestions.contains("hello"))
    }
    
    func testSimilarityCalculation() {
        // Test exact match
        XCTAssertEqual(viewModel.calculateSimilarity("hello", "hello"), 1.0)
        
        // Test similar words
        let similarity = viewModel.calculateSimilarity("helllo", "hello")
        XCTAssertGreaterThan(similarity, 0.6)
        
        // Test very different words
        let lowSimilarity = viewModel.calculateSimilarity("hello", "world")
        XCTAssertLessThan(lowSimilarity, 0.6)
    }
    
    func testApplyAutocorrect() {
        var text = "helllo world"
        let cursorPosition = viewModel.applyAutocorrect("hello", in: &text)
        
        XCTAssertEqual(text, "hello world")
        XCTAssertEqual(cursorPosition, 5) // After "hello"
    }
    
    func testHideAutocorrect() {
        viewModel.showAutocorrect = true
        viewModel.autocorrectSuggestions = ["hello"]
        viewModel.autocorrectRange = NSRange(location: 0, length: 5)
        
        viewModel.hideAutocorrect()
        
        XCTAssertFalse(viewModel.showAutocorrect)
        XCTAssertTrue(viewModel.autocorrectSuggestions.isEmpty)
        XCTAssertNil(viewModel.autocorrectRange)
    }
}
