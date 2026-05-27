from app import get_fact


def test_fact():
    fact = get_fact()

    assert isinstance(fact, str)
    assert len(fact) > 0
