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