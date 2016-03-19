# Read and write ReferenceState_t Nodes

#int cg_state_read(char **StateDescription);
#@checked
def state_read():
    cdef char *StateDescription_p
    err = cg_state_read(&StateDescription_p)
    if not err:
        StateDescription = str(StateDescription_p)
        cg_free(StateDescription_p)
    else:
        StateDescription = ''
    return err, StateDescription

#int cg_state_write(const char * StateDescription);
@checked
def state_write(const char * StateDescription):
    return cg_state_write(StateDescription)

# Read and write FlowEquationSet_t Nodes

#int cg_equationset_read(int *EquationDimension,
    #int *GoverningEquationsFlag, int *GasModelFlag,
    #int *ViscosityModelFlag,     int *ThermalConductivityModelFlag,
    #int *TurbulenceClosureFlag,  int *TurbulenceModelFlag);
@checked
def equationset_read():
    cdef int EquationDimension, GoverningEquationsFlag, GasModelFlag
    cdef int ViscosityModelFlag, ThermalConductivityModelFlag,
    cdef int TurbulenceClosureFlag,  TurbulenceModelFlag
    return (cg_equationset_read(&EquationDimension, &GoverningEquationsFlag, &GasModelFlag,
                                  &ViscosityModelFlag, &ThermalConductivityModelFlag,
                                  &TurbulenceClosureFlag, &TurbulenceModelFlag),
                    EquationDimension, GoverningEquationsFlag, GasModelFlag, ViscosityModelFlag, ThermalConductivityModelFlag,
                                  TurbulenceClosureFlag, TurbulenceModelFlag)

#int cg_equationset_chemistry_read(int *ThermalRelaxationFlag,
    #int *ChemicalKineticsFlag);
@checked
def equationset_chemistry_read():
    cdef int ThermalRelaxationFlag, ChemicalKineticsFlag
    return cg_equationset_chemistry_read(&ThermalRelaxationFlag, &ChemicalKineticsFlag), ThermalRelaxationFlag, ChemicalKineticsFlag

#int cg_equationset_elecmagn_read(int *ElecFldModelFlag,
    #int *MagnFldModelFlag, int *ConductivityModelFlag);
@checked
def equationset_elecmagn_read():
    cdef int ElecFldModelFlag, MagnFldModelFlag, ConductivityModelFlag
    return (cg_equationset_elecmagn_read(&ElecFldModelFlag, &MagnFldModelFlag, &ConductivityModelFlag),
                ElecFldModelFlag, MagnFldModelFlag, ConductivityModelFlag)

#int cg_equationset_write(int EquationDimension);
@checked
def equationset_write(int EquationDimension):
    cg_equationset_write(EquationDimension)

# Read and write GoverningEquations_t Nodes

#int cg_governing_read(GoverningEquationsType_t *EquationsType);
@checked
def governing_read():
    cdef GoverningEquationsType EquationsType
    return cg_governing_read(&EquationsType), EquationsType

#int cg_governing_write(GoverningEquationsType_t Equationstype);
@checked
def governing_write(GoverningEquationsType EquationsType):
    return cg_governing_write(EquationsType)

# Read and write Diffusion Model Nodes

#int cg_diffusion_read(int *diffusion_model);
@checked
def diffusion_read():
    cdef int diffusion_model
    diffusion_model = np.zeros(6, dtype=np.int32, order='F')
    diffusion_model_ptr = <int *>np.PyArray_DATA(diffusion_model)
    return cg_diffusion_read(diffusion_model_ptr), diffusion_model

#int cg_diffusion_write(const int * diffusion_model);
@checked
def diffusion_write(diffusion_model):
    cdef np.ndarray dm = np.asarray(diffusion_model, dtype=np.int32, order='F')

    return cg_diffusion_write(<int *>dm.data)

# Read and write GasModel_t, ViscosityModel_t,
# ThermalConductivityModel_t, TurbulenceClosure_t,
# TurbulenceModel_t, ThermalRelaxationModel_t,
# ChemicalKineticsModel_t, EMElectricFieldModel_t,
# EMMagneticFieldModel_t Nodes

#int cg_model_read(const char *ModelLabel, ModelType_t *ModelType);
@checked
def model_read(const char *ModelLabel):
    cdef ModelType ModelType
    return cg_model_read(ModelLabel, &ModelType), ModelType

#int cg_model_write(const char * ModelLabel, ModelType_t ModelType);
@checked
def model_write(const char * ModelLabel, ModelType ModelType):
    return cg_model_write(ModelLabel, ModelType)