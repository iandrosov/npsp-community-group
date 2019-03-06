import { LightningElement, api, track, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
const fields = [
	'CLC_Community_Group__c.Name',
	'CLC_Community_Group__c.BillingStreet__c',
	'CLC_Community_Group__c.BillingCity__c',
	'CLC_Community_Group__c.BillingState__c',
	'CLC_Community_Group__c.Latitude__c',
	'CLC_Community_Group__c.Longitude__c'
];

export default class GroupLocation extends LightningElement {
	@api recordId;
	@track name;
	@track mapMarkers = [];
	@wire(getRecord, { recordId: '$recordId', fields })
	loadBear({ error, data }) {
		if (error) {
			// TODO: handle error
		} else if (data) {
			// Get Bear data
			this.name = data.fields.Name.value;
			const street = data.fields.BillingStreet__c.value;
			const city = data.fields.BillingCity__c.value;
			const state = data.fields.BillingState__c.value;
			const Latitude = data.fields.Latitude__c.value;
			const Longitude = data.fields.Longitude__c.value;
			// Transform bear data into map markers
			this.mapMarkers = [{
				location: { Latitude, Longitude },
				title: this.name,
				description: `${street}, ${city} ${state}`
			}];
		}
	}
	get cardTitle() {
		return (this.name) ? `${this.name}'s location` : 'Group location';
	}
}