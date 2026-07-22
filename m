Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFC9459AE7
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 23:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784763365; cv=none; b=knuU9ZMT/0sVk+UQINbOJ0FQqgYz8eGAWU5XVGbDWthFaXrIKR2FZKYP9/9XQhIWTGk0ziyluUtYaI8pGpPgmgV2sWxld0J5iJ/yAMvegTuetFzXHOrU4mthIK9Kx2Fy7n0+UBdw1Oty8OTjyXMTTKK40X5qaS/5uk2ijEnlv7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784763365; c=relaxed/simple;
	bh=GamW1VwKvhKJeT/6CK2u8DdO2/TMjN3bJls3oHrWt/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCNH5V9v2dW/c1ljaJGGhbQIjxQYf0C4y8yoEirrZqFnxuMoY972+mMul2G+vmbNAw+NWe7p6qWLfqfEzPwEDf3eciVSqtezuN7aQNlrZ6C9IO13w8L29y16aqHAGR9Syp61PkCKIPWj3JdMYpCait81ISEzlroQXZsFVJquD5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TeXRZVl6; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TeXRZVl6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784763361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WTfkRdtMdkcOuL/IvPO/EoGmDNTqaSXpsalOp4NmLbs=;
	b=TeXRZVl6WmqHLCDF/CYf6nJzSLRQXgIfIBSB5IGXNXfqvGwloPMynXjwCDzXhZkSI3Ntc4
	U0Wo1cuJSs0APCB2QTiSVHJFybnh5bIl9N6ElKBEjBNcwEqSnxoWtBjZNKQShsMzMuca7u
	BxBXXM3ZtiWjk2OcdAqVO3z/G/IAABQ=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-input@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 5/8] resolve_btfids: Fix the _impl lookup for module BTF
Date: Wed, 22 Jul 2026 16:35:15 -0700
Message-ID: <20260722233518.778854-6-ihor.solodrai@linux.dev>
In-Reply-To: <20260722233518.778854-1-ihor.solodrai@linux.dev>
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

process_kfunc_with_implicit_args() skips generating <name>_impl
function when one already exists for backwards compatibility.

It uses btf__find_by_name_kind(), which searches the base BTF before
the split BTF. When resolve_btfids processes a module, a same-named
_impl in vmlinux would be found and the module's own counterpart would
not be created.

Fix by using btf__find_by_name_kind_own() for the lookup.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/resolve_btfids/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index de4986e1bc3d..ab3ab3045592 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -1232,7 +1232,7 @@ static int process_kfunc_with_implicit_args(struct btf2btf_context *ctx, struct
 		return -E2BIG;
 	}
 
-	if (btf__find_by_name_kind(btf, tmp_name, BTF_KIND_FUNC) > 0) {
+	if (btf__find_by_name_kind_own(btf, tmp_name, BTF_KIND_FUNC) > 0) {
 		pr_debug("resolve_btfids: function %s already exists in BTF\n", tmp_name);
 		goto add_new_proto;
 	}
-- 
2.55.0

