Received: from mta0.migadu.com (out-205.mta0.migadu.com [91.218.175.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36A443933F
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 06:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789626981; cv=none; b=q37xx6s86lPIL1SC38lZDzpY6sI3rxgXgyzxxa4PMpedhCh26TPnMCODikP1tLsPqa4gj6crohHVK6GAyD+EkMpF94knZjCE0bQLKg6vGJOVu84C8Y1/ji1mMj6dzgcqzxZPZ32ogzHDHCh6asRLf/j4iReuNNFYu8F+XSnMVr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789626981; c=relaxed/simple;
	bh=J4MLi0w09Di2aBki03cBZ/n1uOIgq0MonD+TEv4n5bE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pml5qRBB7CGB2l1GGlu/P2pgjYbzYfwBJOkU8AYgBrZluuStwrnd+6RFMFWBCrR98hKRsvbzdngbWrwT4t3ZTSSCiqH5qlUs6Kx2PHDmXxXrvtTX5vW3PNLeQo/3/hgTZHObd4qYATZmqrq8i83Vw44pjXzrDGpnNZB/I8V9Hrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NTvftYxz; arc=none smtp.client-ip=91.218.175.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NTvftYxz"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=J4MLi0w09Di2aBki03cBZ/n1uOIgq0MonD+TEv4n5bE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789626977; v=1; x=1790231777;
 b=NTvftYxzilNzXr3/z3QMVjSV0QbFs7wuAXxfRzmgkcBvw75Kyh+FOad7/rY1vSetMMeblc5G
 DE+FD+mnXTpfme953NUbJPQuKEXi99PUfNRSoQgopaDUOq1g4xgz4Nswj03KYtdCcx9s0mGAJOT
 euYnT21PQnDIZo43wAaPIcvU=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 41156bba5621bac1;
	Thu, 17 Sep 2026 06:36:16 +0000
X-Mizu-Trace-ID: 41156bba5621bac1
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Thu, 17 Sep 2026 14:35:34 +0800
Subject: [PATCH net-next 2/6] tools: ynl: convert enum selector to string
 for sub-message parsing
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-ynl_rt_encap-v1-2-fbbe6e680571@kylinos.cn>
References: <20260917-ynl_rt_encap-v1-0-fbbe6e680571@kylinos.cn>
In-Reply-To: <20260917-ynl_rt_encap-v1-0-fbbe6e680571@kylinos.cn>
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

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 2b3483db1b60..45bd7bc834b4 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -951,9 +951,17 @@ class TypeSubMessage(TypeNest):
             sel_var = f"_sel_{sel}"
         else:
             sel_var = f"{var}->{sel}"
+
+        parse_sel = sel_var
+        if not self.selector.is_external() and self.selector.attr and \
+           "enum" in self.selector.attr.attr:
+            enum_name = self.selector.attr.attr["enum"]
+            str_fn = c_lower(self.family.ident_name + "-" + enum_name) + "_str"
+            parse_sel = f"{str_fn}({sel_var})"
+
         get_lines = [f'if (!{sel_var})',
                      f'return ynl_submsg_failed(yarg, "{self.name}", "{selector}");',
-                     f"if ({self.nested_render_name}_parse(&parg, {sel_var}, attr))",
+                     f"if ({self.nested_render_name}_parse(&parg, {parse_sel}, attr))",
                      "return YNL_PARSE_CB_ERROR;"]
         init_lines = [f"parg.rsp_policy = &{self.nested_render_name}_nest;",
                       f"parg.data = &{var}->{self.c_name};"]

-- 
2.55.0

