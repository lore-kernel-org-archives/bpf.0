Received: from mta0.migadu.com (out-162.mta0.migadu.com [91.218.175.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B6A46A600
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 08:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447866; cv=none; b=lXvZJgS1cV+1DfSWUvdvss9ubCu1Rp5vVsBwUbOMuP6OOBFwWuxziJwGA+NNynCjrKokbc0TEnDC1+q+fVW5ZLTM5iSrYyRz2SBqf/SjSS1nH3XejH2dOoiJ02l3bwPFyeUYggFJfh10jxL3oWCEb63VxgK9Sz9U2Ia/4qXFSg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447866; c=relaxed/simple;
	bh=ElAGVQu8HTnftSvAWHnNCFH9IJc4OyG0lDlK5Xphsl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tx3OK0Jzs0Jf6ua9eTBdgRk/Fun8sYyUumneI7gcgndXe1YQmv2NSA0gJcywgiq7mZUFDqnHH87dOjTaereLEVRik+3WyFzCXy/wwNUqneP+wbLiFOx5jlRrqdzuSGc0ISXVq1pgBFokULwTKiW4cAW8VqEK0T7rm1kXBqBuGYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c1nCUkSx; arc=none smtp.client-ip=91.218.175.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c1nCUkSx"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ElAGVQu8HTnftSvAWHnNCFH9IJc4OyG0lDlK5Xphsl8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791447863; v=1; x=1792052663;
 b=c1nCUkSxC1grHucRS0uVoUjPAYD04bdyLXi5F8fhmydLJyvW6GV9Ww2c0jZQOk1SWPRCpxoP
 aex/kZX9a23w5VJa3hPt3ZN2dxQOSaljJhUEFc1VRljWu9K0n3DPU3fmu3lG+jW1Mcqalh5QcfZ
 5oXjOCa6HHFJlYGi6RCej1rI=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 4034c6b1c72ba104;
	Thu, 08 Oct 2026 08:24:23 +0000
X-Mizu-Trace-ID: 4034c6b1c72ba104
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Thu, 08 Oct 2026 16:24:02 +0800
Subject: [PATCH net-next v4 2/6] tools: ynl: convert enum selector to
 string for sub-message parsing
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-ynl_rt_encap-v4-2-4ed2ccf7f949@kylinos.cn>
References: <20261008-ynl_rt_encap-v4-0-4ed2ccf7f949@kylinos.cn>
In-Reply-To: <20261008-ynl_rt_encap-v4-0-4ed2ccf7f949@kylinos.cn>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@kernel.org>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.14.3

From: Hangbin Liu <liuhangbin@kylinos.cn>

YNL sub-message parsing expects a string selector for strcmp(). So for
non-external enum selectors, convert the integer value to its string form
via the family's {enum}_str() helper. This enables correct decoding of
sub-messages keyed by enum values.

After the change, if there is no encap_type (e.g. previous ordering on
older kernels), or a new encap_type is missing from the spec file in
future kernel, the code will report "Sub-message key not set", the same
with string lookup fails. With the subsequent rt-route encap spec update,
the newly generated code will look like:

	if (!dst->_present.encap_type)
		return ynl_submsg_failed(yarg, "encap", "encap-type");
	encap_type_str = rt_route_encap_type_str(dst->encap_type);
	if (!encap_type_str)
		return ynl_submsg_failed(yarg, "encap", "enum-lookup-failed");
	if (rt_route_encap_data_parse(&parg, encap_type_str, attr))
		return YNL_PARSE_CB_ERROR;

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---

For sashiko:

1. For the extack error-walking path in ynl.c that doesn't handle
   enum-keyed selectors. This series doesn't modify ynl.c, it changes
   the code generator to emit the _str() conversion in generated parsing
   code. The run time error-walking path is a separate concern.

   Since rt-route encap is the first enum-keyed sub-message in the YNL
   specs, this is a new limitation rather than a regression in existing
   functionality. It can be addressed as a follow-up patch to ynl.c.

2. For the selector byte-order issue. This doesn't affect the current
   series. The encap-type selector is type: u16 with no byte-order
   specified (native order), so the raw value passed to _str() is already
   host-order. nftables is in GENS_UNSUP today, so no in-tree generated
   family hits this yet. We address this as a follow-up.
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 15c79849c609..4aca51396a9e 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -951,13 +951,31 @@ class TypeSubMessage(TypeNest):
             sel_var = f"_sel_{sel}"
         else:
             sel_var = f"{var}->{sel}"
-        get_lines = [f'if (!{sel_var})',
-                     f'return ynl_submsg_failed(yarg, "{self.name}", "{selector}");',
-                     f"if ({self.nested_render_name}_parse(&parg, {sel_var}, attr))",
-                     "return YNL_PARSE_CB_ERROR;"]
+
+        local_vars = None
+
+        if self.selector.is_enum_val() and not self.selector.is_external():
+            enum = self.family.consts[self.selector.get_enum_name()]
+            pres_var = f"{var}->_present.{sel}"
+            parse_sel = f"{sel}_str"
+            local_vars = [f'const char *{parse_sel};']
+
+            get_lines = [
+                f'if (!{pres_var})',
+                f'return ynl_submsg_failed(yarg, "{self.name}", "{selector}");',
+                f'{parse_sel} = {enum.render_name}_str({sel_var});',
+                f'if (!{parse_sel})',
+                f'return ynl_submsg_failed(yarg, "{self.name}", "enum-lookup-failed");']
+        else:
+            parse_sel = sel_var
+            get_lines = [f'if (!{parse_sel})',
+                         f'return ynl_submsg_failed(yarg, "{self.name}", "{selector}");']
+
+        get_lines += [f"if ({self.nested_render_name}_parse(&parg, {parse_sel}, attr))",
+                      "return YNL_PARSE_CB_ERROR;"]
         init_lines = [f"parg.rsp_policy = &{self.nested_render_name}_nest;",
                       f"parg.data = &{var}->{self.c_name};"]
-        return get_lines, init_lines, None
+        return get_lines, init_lines, local_vars
 
 
 class Selector:
@@ -979,6 +997,12 @@ class Selector:
     def is_external(self):
         return self._external
 
+    def is_enum_val(self):
+        return self.get_enum_name() is not None
+
+    def get_enum_name(self):
+        return self.attr and self.attr.attr.get("enum")
+
 
 class Struct:
     def __init__(self, family, space_name, type_list=None, fixed_header=None,

-- 
2.55.0

