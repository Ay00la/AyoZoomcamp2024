if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    data.columns = (data.columns
                    .str.replace(' ', '_')
                    .str.lower()
                    .str.replace('id', '_id')
                    )
    return data

@test
def test_output(output, *args) -> None:

    assert output.columns[0] == 'vendor_id', 'There is no vendor_id column'