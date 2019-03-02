import { NavigationMixin, CurrentPageReference } from 'lightning/navigation';
import { fireEvent } from 'c/pubsub';
import { loadStyle } from 'lightning/platformResourceLoader';
import ursusResources from '@salesforce/resourceUrl/ursus_park';
import { LightningElement, track, wire } from 'lwc';
/** NPSP_CommunityGroupController.searchGroups(searchTerm) Apex method */
import searchGroups from '@salesforce/apex/NPSP_CommunityGroupController.searchGroups';
export default class CgList extends NavigationMixin(LightningElement) {
	@track searchTerm = '';
	@track communityGroups;
	@wire(CurrentPageReference) pageRef;
	@wire(searchGroups, {searchTerm: '$searchTerm'})
	loadBears(result) {
		this.bears = result;
		if (result.data) {
			fireEvent(this.pageRef, 'bearListUpdate', result.data);
		}
	}
	connectedCallback() {
		loadStyle(this, ursusResources + '/style.css');
	}
	handleSearchTermChange(event) {
		// Debouncing this method: do not update the reactive property as
		// long as this function is being called within a delay of 300 ms.
		// This is to avoid a very large number of Apex method calls.
		window.clearTimeout(this.delayTimeout);
		const searchTerm = event.target.value;
		// eslint-disable-next-line @lwc/lwc/no-async-operation
		this.delayTimeout = setTimeout(() => {
			this.searchTerm = searchTerm;
		}, 300);
	}
	get hasResults() {
		return (this.communityGroups.data.length > 0);
	}
	handleCommunityGroupView(event) {
		// Navigate to communityGroup record page
		this[NavigationMixin.Navigate]({
			type: 'standard__recordPage',
			attributes: {
				recordId: event.target.bear.Id,
				objectApiName: 'Account',
				actionName: 'view',
			},
		});
	}
}