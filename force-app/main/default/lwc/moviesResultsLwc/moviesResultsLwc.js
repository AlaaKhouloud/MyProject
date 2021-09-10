import { LightningElement, api, track, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class MoviesResultsLwc extends NavigationMixin(LightningElement) {
    @api movieitem;
    @track recordId;
    @track openModal;

    handleModalClosed() {
        this.openModal = false;
        this.dispatchEvent(new CustomEvent('close'));
    }

    handlePreview(evt){
        this.recordId = this.movieitem.Id;
        this.openModal = true;
    }
}