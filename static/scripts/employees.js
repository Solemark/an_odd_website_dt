/**
 * @typedef Employee
 * @type {object}
 * @property {number} id - employee id
 * @property {string} first_name - employee first name
 * @property {string} last_name - employee last name
 * @property {string} email_address - employee email address
 * @property {boolean} visible - is the employee visible
 */

/**
 * On load function
 * @returns {void}
 */
const getEmployees = () => {
    fetch("/data/employees")
        .then(async (res) => {
            /** @type {Employee[]} */
            const data = await res.json()
            updateTable(data)
        })
        .catch((err) => {
            console.log(err)
        })
}

/**
 * find employee id for edit and remove employee
 * @param {number} id - the employee id
 * @param {string} option - the dialog that is being set
 */
const displayDialog = (id, option) => {
    document.getElementById(`${option}-id`).value = id
    if (option == "remove") {
        removeEmployee.showModal()
    }
    if (option == "edit") {
        editEmployee.showModal()
    }
}

/**
 * Updates the employee table
 * @param {Employee[]} data - array of employee data
 * @returns {void}
 */
const updateTable = (data) => {
    let tbody = document.getElementById("employee-table")
    let index = 1
    data.forEach(employee => {
        let row = document.createElement("tr")
        let id = document.createElement("td")
        let fn = document.createElement("td")
        let ln = document.createElement("td")
        let ea = document.createElement("td")
        let bc = document.createElement("td")

        let eb = document.createElement("button")
        eb.setAttribute("type", "button")
        eb.setAttribute("class", "yellowButton")
        eb.setAttribute("onclick", `displayDialog(${index}, "edit")`)

        let rb = document.createElement("button")
        rb.setAttribute("type", "button")
        rb.setAttribute("class", "redButton")
        rb.setAttribute("onclick", `displayDialog(${index}, "remove")`)

        id.innerHTML = employee.id
        fn.innerHTML = employee.first_name
        ln.innerHTML = employee.last_name
        ea.innerHTML = employee.email_address
        eb.innerHTML = "Edit"
        rb.innerHTML = "Remove"
        bc.append(eb, rb)
        row.append(id, fn, ln, ea, bc)
        tbody.append(row)
        index++
    })
}

/**
 * Clear the modal inputs
 * @returns {void}
 */
const clearModal = () => {
    newEmployee.close()
    removeEmployee.close()
    editEmployee.close()
    document.getElementById("new-fn").value = ""
    document.getElementById("new-ln").value = ""
    document.getElementById("new-ea").value = ""
    document.getElementById("edit-id").value = ""
    document.getElementById("edit-fn").value = ""
    document.getElementById("edit-ln").value = ""
    document.getElementById("edit-ea").value = ""
    document.getElementById("remove-id").value = ""
}
