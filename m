Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EE22C3757;
	Thu, 24 Sep 2026 01:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790212444; cv=none; b=hHbjsuAL/HmjC3K4FCYsWV56pnugFIa4L9QBiiuQ0bXqGCajZbJo1VjWjdcDaJ9QzMP0edKBlzJEAi/9prOxosLxmepq+OJM9Iy3kFe3u1C9M59fiFPCK+foHnZRqorlEnQsJC2hDTDCBmAfE7yzoFpOMbtXgmooK4nsnrWx7Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790212444; c=relaxed/simple;
	bh=5EVw7m7WVHNJVeZScbIxpaBKjYf8CSz5jNF5kQDb2X0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PTUy+MQn35DzLRh+o3UPUU3VmxlNqctmeWZYPrY4xZ/buzAXMxDHPOO60a1EwkMNsylSwcg09dZ52kxp4AbeAbhdIX1OPINGkWC4y5y76Qb5e98VNIzOfA76fhDBKb/zWwd8ieysoH6jeACjEAOeLRDx7giaz/revf95DNG5WcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUTGRzUC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUTGRzUC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977D31F00899;
	Thu, 24 Sep 2026 01:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790212443;
	bh=/ddXJYlXBnPMAYtNTVd/KpD+ANNHYIVltbsR6nngMcE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VUTGRzUCX35o81b5gaZeUytBJ5JZZ9dEyHV24H/fDuix102VaJJOl6Byn1M82SuYP
	 eiH/rp2H5FKM3Btem4oQsdyhUddSTBcM60C/XFbK86NDvcfNQBHz0YSzvBFATFTqd7
	 9BQohH5gLe/mT8DQ+hShO4B+kpoe3iAIlFbH49Jh7mjE0n9J+AZX3/1hwvtNdRrl/A
	 IfSWV9r6W/xlNnUrgNZQD/O9fP6t05l+5iebfopLZO84vLCGH+HqWQXFWnfDHIzh7c
	 IutGxCHrk+hYB8VSRwB67FNGPxQyeOJON1egzjdhR4bL/U0F9zAMW+iTseEZR9FUSA
	 IFQg8woXUjEPg==
Date: Wed, 23 Sep 2026 18:14:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH net-next v2 2/6] tools: ynl: convert enum selector to
 string for sub-message parsing
Message-ID: <20260923181401.41d836e2@kernel.org>
In-Reply-To: <20260920-ynl_rt_encap-v2-2-c664a3e726f6@kylinos.cn>
References: <20260920-ynl_rt_encap-v2-0-c664a3e726f6@kylinos.cn>
	<20260920-ynl_rt_encap-v2-2-c664a3e726f6@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Sep 2026 18:06:37 +0800 Hangbin Liu wrote:
> 	const char *encap_type_str;
> 	encap_type_str = rt_route_encap_type_str(dst->encap_type);
> 	if (!encap_type_str)
> 		return ynl_submsg_failed(yarg, "encap", "encap-type");
> 	if (rt_route_encap_data_parse(&parg, encap_type_str, attr))
> 		return YNL_PARSE_CB_ERROR;

Please squash this in:

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 785e747e5865..3b95e5d31638 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -954,14 +954,13 @@ from lib import SpecSubMessage
 
         parse_sel = sel_var
         get_lines = []
-        if not self.selector.is_external() and self.selector.attr and \
-           "enum" in self.selector.attr.attr:
-            enum_name = self.selector.attr.attr["enum"]
-            str_fn = c_lower(self.family.ident_name + "-" + enum_name) + "_str"
-            sel_str_var = f"{sel}_str"
-            get_lines += [f'const char *{sel_str_var};',
-                          f'{sel_str_var} = {str_fn}({sel_var});']
-            parse_sel = sel_str_var
+        local_vars = None
+
+        if self.selector.is_enum_val():
+            parse_sel = f"{sel}_str"
+            local_vars = [f'const char *{parse_sel};']
+            enum = self.family.consts[self.selector.get_enum_name()]
+            get_lines += [f'{parse_sel} = {enum.render_name}_str({sel_var});']
 
         get_lines += [f'if (!{parse_sel})',
                       f'return ynl_submsg_failed(yarg, "{self.name}", "{selector}");',
@@ -969,7 +968,7 @@ from lib import SpecSubMessage
                       "return YNL_PARSE_CB_ERROR;"]
         init_lines = [f"parg.rsp_policy = &{self.nested_render_name}_nest;",
                       f"parg.data = &{var}->{self.c_name};"]
-        return get_lines, init_lines, None
+        return get_lines, init_lines, local_vars
 
 
 class Selector:
@@ -991,6 +990,12 @@ from lib import SpecSubMessage
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
