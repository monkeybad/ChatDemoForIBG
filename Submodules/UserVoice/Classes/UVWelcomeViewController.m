//
//  UVWelcomeViewController.m
//  UserVoice
//
//  Created by UserVoice on 12/15/09.
//  Copyright 2009 UserVoice Inc. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UVWelcomeViewController.h"
#import "UVStyleSheet.h"
#import "UVSession.h"
#import "UVForum.h"
#import "UVClientConfig.h"
#import "UVSubdomain.h"
#import "UVContactViewController.h"
#import "UVSuggestionListViewController.h"
#import "UVSuggestion.h"
#import "UVArticle.h"
#import "UVSuggestionDetailsViewController.h"
#import "UVArticleViewController.h"
#import "UVHelpTopic.h"
#import "UVHelpTopicViewController.h"
#import "UVConfig.h"
#import "UVPostIdeaViewController.h"
#import "UVBabayaga.h"
#import "UVUtils.h"

@implementation UVWelcomeViewController {
    NSInteger _filter;
}

- (BOOL)showArticles {
    return [UVSession currentSession].config.topicId || [[UVSession currentSession].topics count] == 0;
}

#pragma mark ===== table cells =====

- (void)initCellForContact:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = NSLocalizedStringFromTableInBundle(@"Send us a message", @"UserVoice", [UserVoice bundle], nil);
    if (IOS7) {
        cell.textLabel.textColor = cell.textLabel.tintColor;
    }
}

- (void)initCellForForum:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = NSLocalizedStringFromTableInBundle(@"Feedback Forum", @"UserVoice", [UserVoice bundle], nil);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString *detail;
    if ([UVSession currentSession].forum.suggestionsCount == 1) {
        detail = NSLocalizedStringFromTableInBundle(@"1 idea", @"UserVoice", [UserVoice bundle], nil);
    } else {
        detail = [NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"%@ ideas", @"UserVoice", [UserVoice bundle], nil), [UVUtils formatInteger:[UVSession currentSession].forum.suggestionsCount]];
    }
    cell.detailTextLabel.text = detail;
}

- (void)customizeCellForTopic:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.row == [[UVSession currentSession].topics count]) {
        cell.textLabel.text = NSLocalizedStringFromTableInBundle(@"All Articles", @"UserVoice", [UserVoice bundle], nil);
        cell.detailTextLabel.text = nil;
    } else {
        UVHelpTopic *topic = [[UVSession currentSession].topics objectAtIndex:indexPath.row];
        cell.textLabel.text = topic.name;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", (int)topic.articleCount];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)customizeCellForArticle:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor whiteColor];
    UVArticle *article = [[UVSession currentSession].articles objectAtIndex:indexPath.row];
    cell.textLabel.text = article.question;
    cell.imageView.image = [UVUtils imageNamed:@"uv_article.png"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:13.0];
}

- (void)initCellForFlash:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = NSLocalizedStringFromTableInBundle(@"View idea", @"UserVoice", [UserVoice bundle], nil);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)initCellForArticleResult:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    [_instantAnswerManager initCellForArticle:cell finalCondition:indexPath == nil];
}

- (void)customizeCellForArticleResult:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    id model = [self.searchResults objectAtIndex:indexPath.row];
    [_instantAnswerManager customizeCell:cell forArticle:(UVArticle *)model];
}

- (void)initCellForSuggestionResult:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    [_instantAnswerManager initCellForSuggestion:cell finalCondition:indexPath == nil];
}

- (void)customizeCellForSuggestionResult:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    id model = [self.searchResults objectAtIndex:indexPath.row];
    [_instantAnswerManager customizeCell:cell forSuggestion:(UVSuggestion *)model];
}

#pragma mark ===== UITableViewDataSource Methods =====

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"";
    NSInteger style = UITableViewCellStyleValue1;
    if (theTableView == _searchController.searchResultsTableView) {
        id model = [self.searchResults objectAtIndex:indexPath.row];
        if ([model isMemberOfClass:[UVArticle class]]) {
            identifier = @"ArticleResult";
        } else {
            identifier = @"SuggestionResult";
        }
        style = UITableViewCellStyleDefault;
    } else {
        if (indexPath.section == 0 && indexPath.row == 0 && [UVSession currentSession].config.showContactUs)
            identifier = @"Contact";
        else if (indexPath.section == 0 && [UVSession currentSession].config.showForum)
            identifier = @"Forum";
        else if ([self showArticles])
            identifier = @"Article";
        else
            identifier = @"Topic";
    }

    return [self createCellForIdentifier:identifier tableView:theTableView indexPath:indexPath style:style selectable:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _searchController.searchResultsTableView) {
        NSString *identifier;
        id model = [self.searchResults objectAtIndex:indexPath.row];
        if ([model isMemberOfClass:[UVArticle class]]) {
            identifier = @"ArticleResult";
        } else {
            identifier = @"SuggestionResult";
        }
        return [self heightForDynamicRowWithReuseIdentifier:identifier indexPath:indexPath];
    } else {
        return 44;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView {
    if (theTableView == _searchController.searchResultsTableView) {
        return 1;
    } else {
        int sections = 0;

        if ([UVSession currentSession].config.showKnowledgeBase && ([[UVSession currentSession].topics count] > 0 || [[UVSession currentSession].articles count] > 0))
            sections++;
        
        if ([UVSession currentSession].config.showForum || [UVSession currentSession].config.showContactUs)
            sections++;

        return sections;
    }
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section {
    if (theTableView == _searchController.searchResultsTableView) {
        return self.searchResults.count;
    } else {
        if (section == 0 && ([UVSession currentSession].config.showForum || [UVSession currentSession].config.showContactUs))
            return ([UVSession currentSession].config.showForum && [UVSession currentSession].config.showContactUs) ? 2 : 1;
        else if ([self showArticles])
            return [[UVSession currentSession].articles count];
        else
            return [[UVSession currentSession].topics count] + 1;
    }
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (theTableView == _searchController.searchResultsTableView) {
        [_instantAnswerManager pushViewFor:[self.searchResults objectAtIndex:indexPath.row] parent:self];
    } else {
        if (indexPath.section == 0 && indexPath.row == 0 && [UVSession currentSession].config.showContactUs) {
            [self presentModalViewController:[UVContactViewController new]];
        } else if (indexPath.section == 0 && [UVSession currentSession].config.showForum) {
            UVSuggestionListViewController *next = [UVSuggestionListViewController new];
            [self.navigationController pushViewController:next animated:YES];
        } else if ([self showArticles]) {
            UVArticle *article = (UVArticle *)[[UVSession currentSession].articles objectAtIndex:indexPath.row];
            UVArticleViewController *next = [UVArticleViewController new];
            next.article = article;
            [self.navigationController pushViewController:next animated:YES];
        } else {
            UVHelpTopic *topic = nil;
            if (indexPath.row < [[UVSession currentSession].topics count])
                topic = (UVHelpTopic *)[[UVSession currentSession].topics objectAtIndex:indexPath.row];
            UVHelpTopicViewController *next = [[UVHelpTopicViewController alloc] initWithTopic:topic];
            [self.navigationController pushViewController:next animated:YES];
        }
    }
    [theTableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)theTableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0 && [UVSession currentSession].config.showForum)
        return nil;
    else if ([UVSession currentSession].config.topicId)
        return [((UVHelpTopic *)[[UVSession currentSession].topics objectAtIndex:0]) name];
    else
        return NSLocalizedStringFromTableInBundle(@"Knowledge Base", @"UserVoice", [UserVoice bundle], nil);
}

- (CGFloat)tableView:(UITableView *)theTableView heightForHeaderInSection:(NSInteger)section {
    return theTableView == _searchController.searchResultsTableView ? 0 : 30;
}

- (void)logoTapped {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.uservoice.com/ios"]];
}

#pragma mark ===== UISearchBarDelegate Methods =====

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [_searchController setActive:YES animated:YES];
    _searchController.searchResultsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [searchBar setShowsCancelButton:YES animated:YES];
    _filter = IA_FILTER_ALL;
    searchBar.showsScopeBar = YES;
    searchBar.selectedScopeButtonIndex = 0;
    return YES;
}

- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller {
    controller.searchBar.showsScopeBar = NO;
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    _filter = searchBar.selectedScopeButtonIndex;
    [_searchController.searchResultsTableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    _instantAnswerManager.searchText = searchBar.text;
    [_instantAnswerManager search];
}

- (void)didUpdateInstantAnswers {
    if (_searchController.active)
        [_searchController.searchResultsTableView reloadData];
}

- (NSArray *)searchResults {
    switch (_filter) {
        case IA_FILTER_ALL:
            return _instantAnswerManager.instantAnswers;
        case IA_FILTER_ARTICLES:
            return _instantAnswerManager.articles;
        case IA_FILTER_IDEAS:
            return _instantAnswerManager.ideas;
        default:
            return nil;
    }
}

#pragma mark ===== Basic View Methods =====

- (void)loadView {
    [super loadView];
    [UVBabayaga track:VIEW_KB];
    _instantAnswerManager = [UVInstantAnswerManager new];
    _instantAnswerManager.delegate = self;
    self.navigationItem.title = NSLocalizedStringFromTableInBundle(@"Feedback & Support", @"UserVoice", [UserVoice bundle], nil);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTableInBundle(@"Close", @"UserVoice", [UserVoice bundle], nil)
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(dismiss)];

    [self setupGroupedTableView];

    if ([UVSession currentSession].config.showKnowledgeBase) {
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
        searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        searchBar.placeholder = NSLocalizedStringFromTableInBundle(@"Search", @"UserVoice", [UserVoice bundle], nil);
        searchBar.delegate = self;
        searchBar.showsScopeBar = NO;
        if ([UVSession currentSession].config.showForum) {
            searchBar.scopeButtonTitles = @[NSLocalizedStringFromTableInBundle(@"All", @"UserVoice", [UserVoice bundle], nil), NSLocalizedStringFromTableInBundle(@"Articles", @"UserVoice", [UserVoice bundle], nil), NSLocalizedStringFromTableInBundle(@"Ideas", @"UserVoice", [UserVoice bundle], nil)];
        }
        _tableView.tableHeaderView = searchBar;

        _searchController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
        _searchController.delegate = self;
        _searchController.searchResultsDelegate = self;
        _searchController.searchResultsDataSource = self;
    }

    if (![UVSession currentSession].clientConfig.whiteLabel) {
        _tableView.tableFooterView = self.poweredByView;
    }

    [_tableView reloadData];
}

@end
