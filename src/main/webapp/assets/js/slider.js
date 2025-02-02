/**
 * 
 */
let slideIndex = 0;
const slides = document.querySelectorAll(".slide");

function showSlide(index) {
    if (index >= slides.length) slideIndex = 0;
    if (index < 0) slideIndex = slides.length - 1;
    
    document.querySelector(".slider").style.transform = `translateX(${-slideIndex * 100}%)`;
}

function nextSlide() {
    slideIndex++;
    showSlide(slideIndex);
}

function prevSlide() {
    slideIndex--;
    showSlide(slideIndex);
}

setInterval(nextSlide, 3000); // Auto-slide every 3 seconds
