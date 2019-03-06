import { LightningElement, track, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { registerListener, unregisterAllListeners } from 'c/pubsub';

export default class GroupMap extends LightningElement {
	@track mapMarkers = [];
	@wire(CurrentPageReference) pageRef; // Required by pubsub
	connectedCallback() {
		// subscribe to bearListUpdate event
		registerListener('bearListUpdate', this.handleBearListUpdate, this);
	}
	disconnectedCallback() {
		// unsubscribe from bearListUpdate event
		unregisterAllListeners(this);
	}
	handleBearListUpdate(groups) {
		this.mapMarkers = groups.map(group => {
			const Latitude = group.Latitude__c;
			const Longitude = group.Longitude__c;
			const Street = group.BillingStreet__c;
			const City = group.BillingCity__c;
			const State = group.BillingState__c;
			return {
				location: { Latitude, Longitude },
				title: group.Name,
				description: `Location: ${Street}, ${City}, ${State}`,
				icon: 'action:new_group'
			};
		});
	}
}