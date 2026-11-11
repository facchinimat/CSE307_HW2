# Part II: Type Equivalence and Coercion (Python)

# Problem 2.1 - Structural Equivalence

class Type:
    pass
class IntType(Type):
    pass
class FloatType(Type):
    pass
class ArrayType(Type):
    def __init__(self, base_type, size):
        self.base_type = base_type
        self.size = size

class RecordType(Type):
    def __init__(self, fields):
        self.fields = fields

def is_structurally_equivalent(t1: Type, t2: Type ) -> bool:
    if isinstance(t1, IntType) and isinstance(t2, IntType):
        return True
    if isinstance(t1, FloatType) and isinstance(t2, FloatType):
        return True
    if isinstance(t1, ArrayType) and isinstance(t2, ArrayType):
        return ( t1.size == t2.size and is_structurally_equivalent(t1.base_type, t2.base_type))
    if isinstance(t1, RecordType) and isinstance(t2, RecordType):
        if t1.fields.keys() != t2.fields.keys():
            return False

        return all(is_structurally_equivalent(t1.fields[key], t2.fields[key]) for key in t1.fields)
    return False



# Problem 2.2 - Type Coercion and Subtyping

def can_coerce(t_from: Type, t_to: Type) -> bool:
    
    if is_structurally_equivalent(t_from, t_to):
        return True
    
    if isinstance(t_from, IntType) and isinstance(t_to, FloatType):
        return True

    if isinstance(t_from, ArrayType) and isinstance(t_to, ArrayType):
        return (
            t_from.size == t_to.size
            and can_coerce(t_from.base_type, t_to.base_type)
        )
   
    if isinstance(t_from, RecordType) and isinstance(t_to, RecordType):
        return all(
            field in t_from.fields
            and can_coerce(t_from.fields[field], t_to.fields[field])
            for field in t_to.fields
        )

    return False

