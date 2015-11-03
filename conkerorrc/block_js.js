require("content-policy.js");

function block_js (content_type, content_location) {
    return content_location.spec.match(/js\/bg\/)? content_policy_accept
                                                 : content_policy_reject;
}
//content_policy_bytype_table.object = block_js;
//add_hook("content_policy_hook", content_policy_bytype);
