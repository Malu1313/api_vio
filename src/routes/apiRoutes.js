const router = require("express").Router();
const veriyfyJWT = require("../services/verifyJWT");
const userController = require("../controllers/userController");
const organizadorController = require("../controllers/organizadorController");
const eventoController = require("../controllers/eventoController");
const ingressoController = require("../controllers/ingressoController");
const compraController = require("../controllers/compraController");
const upload = require("../services/upload");

router.post("/user", userController.createUser);
router.get("/user", veriyfyJWT, userController.getAllUsers);
router.get("/user", userController.getAllUsers);
router.put("/user", userController.updateUser);
router.delete("/user/:id", userController.deleteUser);
router.post("/login", userController.loginUser);



router.post("/organizador", organizadorController.createOrganizador);
router.get("/organizador", organizadorController.getAllOrganizadores);
router.put("/organizador", organizadorController.updateOrganizador);
router.delete("/organizador/:id", organizadorController.deleteOrganizador);


//rotas eventoController
router.post("/evento", upload.single("imagem"), eventoController.createEvento);
router.get("/evento", veriyfyJWT, eventoController.getAllEventos);
router.put("/evento", eventoController.updateEvento);
router.delete("/evento/:id", eventoController.deleteEvento);
router.get("/evento/data", veriyfyJWT, eventoController.getEventosPorData);
router.get("/evento/proximo", veriyfyJWT, eventoController.getEventosdia);

//rotas ingressoController
router.post("/ingresso", ingressoController.createIngresso);
router.get("/ingresso", ingressoController.getAllIngressos);
router.put("/ingresso", ingressoController.updateIngresso);
router.delete("/ingresso/:id", ingressoController.deleteIngresso);
router.get("/ingresso/evento/:id", ingressoController.getByIdEvento);

// compraController
router.post("/comprasimples", compraController.registrarCompraSimples);
router.post("/compra", compraController.registrarCompra);

module.exports = router;
