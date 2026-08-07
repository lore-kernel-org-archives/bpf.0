Received: from out-171.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD064B04B7
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 03:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786072864; cv=none; b=BHEysqsZqIqaZvJgnkB0rec6YOiWeIHBRgV9IqUw1n8XM3izRxaemCj8aLJiEJWudfRcg20FKjUEZfbxHgJXqcPACveUK5bO8lBCZBP/Z4Ufy0ex35a5ZAI2uYIAvBBTBrAnYxI4gSHElwN71PtoNrZ2JhxDUbAfyCacjBci/JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786072864; c=relaxed/simple;
	bh=IRtB36qcwYw/Xhv/B6HYMJraK2GE91TEz0DQz7PuUM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NfAsD3aCTphCT1d6sqmBYjw3nyTbIKvJJpcX7uLyWrqDBCEiwH1p2Fr+LY0kkoORpAHGmLvALlFilu4c1R0/jELrrpYab29F4nd5HYHic1J2otqZtRzjdgJSxt7II2qOCVXW52p4IJrtDict884gVurGr6fOGuHMT6g3Q+Ale1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sg5u36pD; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sg5u36pD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786072861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/rMO2btVhqrYXFoudHT/Ea63KdEADsFZMpGNzLh+SI=;
	b=sg5u36pDw6horyhzKiosRjXJWxPfGqXMuRsWlvSNXaFolkD+a7CqdQZAQreg5La188XfGX
	wgIgm+IoGy0ToGUeeN5NWrGYpQ+ZpPI81MrFwtUva5vk+f2Ir40uuicq3L9D8Q4R+vr/F9
	EEmO3XurUdWJhzqzttFT7molbb1XQbo=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 4/6] resolve_btfids: Emit bpf_kfunc and bpf_fastcall decl tags
Date: Thu,  6 Aug 2026 20:20:27 -0700
Message-ID: <20260807032029.78092-5-ihor.solodrai@linux.dev>
In-Reply-To: <20260807032029.78092-1-ihor.solodrai@linux.dev>
References: <20260807032029.78092-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Emit the bpf_kfunc decl tag for every discovered kfunc, and bpf_fastcall
for kfuncs flagged KF_FASTCALL. These were previously produced by pahole
under --btf_features=decl_tag_kfuncs.

resolve_btfids now discovers kfuncs from the BTF ID sets [1] and
becomes the source of truth for their annotations.

Drop decl_tag_kfuncs pahole feature flag from scripts/Makefile.btf

[1] https://lore.kernel.org/all/20260722233518.778854-1-ihor.solodrai@linux.dev/

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 scripts/Makefile.btf            |  2 +-
 tools/bpf/resolve_btfids/main.c | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index 8f73c093d27a..a1812985a61a 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -14,7 +14,7 @@ pahole-flags-$(call test-ge, $(pahole-ver), 125)	+= --skip_encoding_btf_inconsis
 else
 
 # Switch to using --btf_features for v1.26 and later.
-pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j$(JOBS) --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
+pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j$(JOBS) --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func
 
 pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=layout
 
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 53d9045ed5c8..a1b921e86ef0 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -161,6 +161,10 @@ struct object {
 	u32 addr_syms_cap;
 };
 
+#define DECL_TAG_FASTCALL "bpf_fastcall"
+#define DECL_TAG_KFUNC "bpf_kfunc"
+
+#define KF_FASTCALL	(1 << 12)
 #define KF_ARENA_RET	(1 << 13)
 #define KF_ARENA_ARG1	(1 << 14)
 #define KF_ARENA_ARG2	(1 << 15)
@@ -1233,7 +1237,7 @@ static int process_kfunc_with_implicit_args(struct btf2btf_context *ctx, struct
 			continue;
 
 		tag_name = btf__name_by_offset(btf, t->name_off);
-		if (strcmp(tag_name, "bpf_kfunc") == 0)
+		if (strcmp(tag_name, DECL_TAG_KFUNC) == 0)
 			continue;
 
 		idx = btf_decl_tag(t)->component_idx;
@@ -1404,6 +1408,21 @@ static int process_kfunc_with_arena_flags(struct btf2btf_context *ctx,
 	return 0;
 }
 
+static int add_decl_tag(struct btf2btf_context *ctx, const char *tag_name,
+			u32 target_btf_id, int component_idx)
+{
+	s32 new_id;
+
+	new_id = btf__add_decl_tag(ctx->btf, tag_name, target_btf_id, component_idx);
+	if (new_id < 0) {
+		pr_err("ERROR: resolve_btfids: failed to add '%s' decl tag for BTF id %u: %d\n",
+		       tag_name, target_btf_id, new_id);
+		return new_id;
+	}
+
+	return push_decl_tag_id(ctx, new_id);
+}
+
 static int btf2btf(struct object *obj)
 {
 	struct btf2btf_context ctx = {};
@@ -1417,6 +1436,16 @@ static int btf2btf(struct object *obj)
 	for (next = rb_first(&ctx.kfuncs); next; next = rb_next(next)) {
 		struct kfunc *kfunc = rb_entry(next, struct kfunc, rb_node);
 
+		err = add_decl_tag(&ctx, DECL_TAG_KFUNC, kfunc->btf_id, -1);
+		if (err)
+			goto out;
+
+		if (kfunc->flags & KF_FASTCALL) {
+			err = add_decl_tag(&ctx, DECL_TAG_FASTCALL, kfunc->btf_id, -1);
+			if (err)
+				goto out;
+		}
+
 		if (kfunc->flags & KF_IMPLICIT_ARGS) {
 			err = process_kfunc_with_implicit_args(&ctx, kfunc);
 			if (err)
-- 
2.55.0

