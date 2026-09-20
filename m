Received: from mta1.migadu.com (out-120.mta1.migadu.com [95.215.58.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF583E51D4
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789898821; cv=none; b=dkaclXSxYGJNniMJHDPXAnOx4aBZ+8sImgJ8tsMEqbjesDvme+ZSPgDsjVLIx+z1vUWVUfh1MAnxgEdhv3rdFOlDhUBMu8hxCeMgkY89Yua5Cc1EGdnHzlBXyflqj3p88Y/VxalkbcMTv/1TfYVxuiC7UksmY069TriNNhany8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789898821; c=relaxed/simple;
	bh=lkTu2I078JvJUNkX2Uv9XPGxBD6YKQ6TgYU1kWq2k7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gPG6V+3MufQCqUv8PsUvjTyNmwFnrMZX7TVXbNHdYzWcot9fskWpwXLtQY4ZUKVrphjVGSkTu7rCJYXG39iuyQTbOcm7/PMVyy0Z2TTilsnimo/0Okrv2ZHVFSoQvveF6P8BH9wJKFCbDnv6qkSXaFDjTyzjqURjw9HDSM1CzXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IB1KdGD2; arc=none smtp.client-ip=95.215.58.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IB1KdGD2"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lkTu2I078JvJUNkX2Uv9XPGxBD6YKQ6TgYU1kWq2k7Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789898818; v=1; x=1790503618;
 b=IB1KdGD24a0gFa757xcK49/fzdjd139vQG95N1AeFrSp+ChQb34gH0kfjyQna9F1iHfp7fcV
 SWs4o8Weagf/bbS4pRMuwfd0oVmlditnlFG/mS0JB3ztoIw5zwFgR+HpE/zgOfBLUMy9n8TyA9p
 AOa0WxvXY1megbdeHCdQtmqs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 70a898477898b523;
	Sun, 20 Sep 2026 10:06:58 +0000
X-Mizu-Trace-ID: 70a898477898b523
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Sun, 20 Sep 2026 18:06:37 +0800
Subject: [PATCH net-next v2 2/6] tools: ynl: convert enum selector to
 string for sub-message parsing
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-ynl_rt_encap-v2-2-c664a3e726f6@kylinos.cn>
References: <20260920-ynl_rt_encap-v2-0-c664a3e726f6@kylinos.cn>
In-Reply-To: <20260920-ynl_rt_encap-v2-0-c664a3e726f6@kylinos.cn>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.14.3

From: Hangbin Liu <liuhangbin@kylinos.cn>

YNL sub-message parsing expects a string selector for strcmp(). So for
non-external enum selectors, convert the integer value to its string form
via the family's {enum}_str() helper. This enables correct decoding of
sub-messages keyed by enum values.

After change, the new generated code looks like

	const char *encap_type_str;
	encap_type_str = rt_route_encap_type_str(dst->encap_type);
	if (!encap_type_str)
		return ynl_submsg_failed(yarg, "encap", "encap-type");
	if (rt_route_encap_data_parse(&parg, encap_type_str, attr))
		return YNL_PARSE_CB_ERROR;

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 2b3483db1b60..785e747e5865 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -951,10 +951,22 @@ class TypeSubMessage(TypeNest):
             sel_var = f"_sel_{sel}"
         else:
             sel_var = f"{var}->{sel}"
-        get_lines = [f'if (!{sel_var})',
-                     f'return ynl_submsg_failed(yarg, "{self.name}", "{selector}");',
-                     f"if ({self.nested_render_name}_parse(&parg, {sel_var}, attr))",
-                     "return YNL_PARSE_CB_ERROR;"]
+
+        parse_sel = sel_var
+        get_lines = []
+        if not self.selector.is_external() and self.selector.attr and \
+           "enum" in self.selector.attr.attr:
+            enum_name = self.selector.attr.attr["enum"]
+            str_fn = c_lower(self.family.ident_name + "-" + enum_name) + "_str"
+            sel_str_var = f"{sel}_str"
+            get_lines += [f'const char *{sel_str_var};',
+                          f'{sel_str_var} = {str_fn}({sel_var});']
+            parse_sel = sel_str_var
+
+        get_lines += [f'if (!{parse_sel})',
+                      f'return ynl_submsg_failed(yarg, "{self.name}", "{selector}");',
+                      f"if ({self.nested_render_name}_parse(&parg, {parse_sel}, attr))",
+                      "return YNL_PARSE_CB_ERROR;"]
         init_lines = [f"parg.rsp_policy = &{self.nested_render_name}_nest;",
                       f"parg.data = &{var}->{self.c_name};"]
         return get_lines, init_lines, None

-- 
2.55.0

