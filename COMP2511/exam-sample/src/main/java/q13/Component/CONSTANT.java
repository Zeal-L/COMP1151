package q13.Component;

import java.util.Map;

import org.json.JSONObject;

public class CONSTANT implements Component {

    private Integer value;
    
    public CONSTANT(Integer Value) {
        this.value = Value;
    }
    
    public Object evaluate(Map<String, Object> values) {
        return value;
    }

    public void updateBaseline(Integer factor) {
        value = value * factor;
    }

    public JSONObject toJSON(Integer factor) {
        updateBaseline(factor);
        JSONObject json = new JSONObject();
        json.put("Operator", "CONSTANT");
        json.put("Arg", value);
        return json;
    }
}
