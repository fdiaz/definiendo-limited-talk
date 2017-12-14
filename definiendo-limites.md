# DEFINIENDO **LIMITES**

---
# [fit] Francisco Díaz

![fit inline](img/airbnb.png)

# _**franciscodiaz.cl**_

---

![100%](img/vanhacks.png)

^ El año pasado...
^ Dividimos el trabajo

---

#[fit] **3**
#### desarrolladores iOS 
#[fit] **28** 
#### horas
#[fit] **1**
#### projecto

---

> EVA BC programs provide vital support to anti-violence programs and communities across BC.
-- Ending Violence Association ONG

---

![inline 100%](img/Use case.png)

---


# Features:
- Botón de pánico
- Today widget
- Knock

^ A first approach to the app would have been to divide each feature and assign it to one of us.

---

# Botón de pánico:
Al presionar el botón → Reportar

![inline fit](img/eva-panic-button.png)

---

# Today widget:
Al presionar el botón → Reportar

![inline fit](img/eva-extension.PNG)


---

# Knock

Al golpear el teléfono → Reportar

---

# División de trabajo

---

# Por feature

- **1 Dev**: Pantalla con botón en iOS app
- **1 Dev**: Today widget
- **1 Dev**: Knock

---

![120%](img/Componentes.png)

---

![120%](img/Componentes-2.png)

^ Estas dos capas son reutilizadas
^ Como estas dos capas no existen, solo sabremos que hemos cometido un error al finalizar la integración.

---

![120%](img/Componentes-3.png)

^ En vez de dividir por feature, podemos dividir por concerns

---

❌ Una persona por "feature"
✅ Una persona por "capa"

---

![120%](img/Componentes-2.1.png)

^ No sabremos que algo falló hasta que la integración esté completa

---

# Dependencias

![inline fit](img/NODI_Componentes.png)

---

# Dependency inversion

![inline fit](img/DI_Componentes.png)

^ We can fix this by using the dependency inversion principle.
^ We add a boundary in the middle.

---

![inline fit](img/DI_Componentes-2.png)

---

```swift
protocol ReportCreator {
  func createReport() throws -> Report
}
```

---

```swift
class SuccessReportCreator: ReportCreator {
  func createReport() throws -> Report {
    return Report(id: "1", date: Date())
  }
}

class ErrorReportCreator: ReportCreator {
  func createReport() throws -> Report {
    throw ReportCreationError.fakeError
  }
}
```

---

```swift
class BigPanicButtonViewController: UIViewController {
  private let reportCreator: ReportCreator

  init(reportCreator: ReportCreator) {
    self.reportCreator = reportCreator
  }

  func didTapBigPanicButton() {
    do {
      // Handle Report
      let report = try reportCreator.createReport()
    } catch {
      // Handle error
    }
  }
}
```

---

```swift
class BigPanicButtonViewController: UIViewController {
  init(reportCreator: ReportCreator = SuccessReport()) {
    ...
  }
}
```

^ Y asi podemos ver si la integración está correcta, aún cuando no tengamos una forma de crear un reporte "real"

---

![inline fit](img/DI_Componentes-3.png)

^ Ahora, como implementamos lo mismo en la capa de Business Logic?

---

# ¿Si el usuario **no tiene** internet?

---

![inline 100%](img/Use case no internet.png)

---

![inline 100%](img/Use case no internet2.png)

---

![inline 100%](img/Use case no internet-3.png)

---

```swift
protocol APIRequester {
  func createReport() throws -> JSON
}

protocol SMSHandler {
  func sendSMS() throws -> SMS
}

protocol ConnectivityListener {
  var isConnected: Bool { get }
}
```

---

## Nada existe aún,
## **pero podemos probar si funciona**

---

# Recap
- Movernos independientemente
- Reducir conflictos
- No hay necesidad de esperar por integración

---

# [fit] ¿Preguntas?
