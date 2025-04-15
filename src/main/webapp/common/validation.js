// 3. Validate số điện thoại: 090xxxxxxx, 091xxxxxxx, (84)+90xxxxxxx, (84)+91xxxxxxx
function validatePhoneNumber(phone) {
    const phoneRegex = /^(090|091|\(84\)\+90|\(84\)\+91)\d{7}$/;
    return phoneRegex.test(phone);
}

// 4. Validate số CMND: 9 hoặc 12 chữ số
function validateIdNumber(idNumber) {
    const idNumberRegex = /^\d{9}$|^\d{12}$/;
    return idNumberRegex.test(idNumber);
}

// 5. Validate địa chỉ email
function validateEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

// 6. Validate ngày (định dạng DD/MM/YYYY)
function validateDate(dateStr) {
    const dateRegex = /^(0[1-9]|[12]\d|3[01])\/(0[1-9]|1[0-2])\/\d{4}$/;
    if (!dateRegex.test(dateStr)) return false;

    // Kiểm tra ngày hợp lệ
    const [day, month, year] = dateStr.split('/').map(Number);
    const date = new Date(year, month - 1, day);
    return date.getDate() === day && date.getMonth() + 1 === month && date.getFullYear() === year;
}

// Validate ngày sinh (phải trước ngày hiện tại)
function validateDateOfBirth(dateStr) {
    if (!validateDate(dateStr)) return false;
    const [day, month, year] = dateStr.split('/').map(Number);
    const dob = new Date(year, month - 1, day);
    const today = new Date();
    return dob < today;
}

// Validate ngày làm hợp đồng và ngày kết thúc (ngày kết thúc phải sau ngày làm hợp đồng)
function validateContractDates(startDateStr, endDateStr) {
    if (!validateDate(startDateStr) || !validateDate(endDateStr)) return false;

    const [startDay, startMonth, startYear] = startDateStr.split('/').map(Number);
    const [endDay, endMonth, endYear] = endDateStr.split('/').map(Number);
    const startDate = new Date(startYear, startMonth - 1, startDay);
    const endDate = new Date(endYear, endMonth - 1, endDay);

    return startDate < endDate;
}

// 7. Validate số lượng, số tầng (số nguyên dương)
function validatePositiveInteger(value) {
    const num = parseInt(value);
    return Number.isInteger(num) && num > 0;
}

// 8. Validate lương, giá, tiền đặt cọc, tổng tiền (số dương)
function validatePositiveNumber(value) {
    const num = parseFloat(value);
    return !isNaN(num) && num > 0;
}

// Hàm hiển thị thông báo lỗi
function showError(elementId, message) {
    const errorElement = document.getElementById(elementId);
    if (errorElement) {
        errorElement.textContent = message;
        errorElement.style.color = 'red';
    }
}

// Hàm xóa thông báo lỗi
function clearError(elementId) {
    const errorElement = document.getElementById(elementId);
    if (errorElement) {
        errorElement.textContent = '';
    }
}