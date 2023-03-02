import BookDrivingSlot from "./TimeSlot";
function BookSlot(){
    return(
        <div class="modal fade" id="slot" tabindex="-1" aria-labelledby="slotLabel" aria-hidden="true" >
            <div class="modal-dialog modal-lg ">
                <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="slotLabel">Book Appointment</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                     <BookDrivingSlot />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save Data</button>
                </div>
                </div>
            </div>
        </div>
    );

}
 export default BookSlot;