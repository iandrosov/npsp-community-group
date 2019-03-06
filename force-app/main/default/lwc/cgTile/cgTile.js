import { LightningElement, api } from 'lwc';
import ursusResources from '@salesforce/resourceUrl/ursus_park';
export default class CGTile extends LightningElement {
	@api cg;
	appResources = {
        bearSilhouette: ursusResources +'/img/standing-bear-silhouette.png',
        groupImage: ursusResources +'/img/user_120.png',
    };
    handleOpenRecordClick() {
        const selectEvent = new CustomEvent('cgview', {
            bubbles: true
        });
        this.dispatchEvent(selectEvent);
    }    
}