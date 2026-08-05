Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A249741DEE2
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 23:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785971248; cv=none; b=ib7bG7tvbwfIXMQ3hBGVTNtCwU+0Dc/TPogxXkKwOtuvFebQEhssIcfgraGpE0enKeGNQP3UJQzUKEQQq7CBpgyuVRGDYINtkMhTq1hbn3JmV/ZmPnquQVbyskaDOLgLyBEhKo78LbqiGbskq08rVsxNOqxJncHjbUyJjwBFeVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785971248; c=relaxed/simple;
	bh=mWllYfB15jrMImNxPezt4e7z2Y5K86tbfVyVu2GP9GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRXlQT+8qda7c7bWagt98+/uOTkXaSsBiYJe8zwjv1GyaA6Y2JuRWjUw57c2bIwBX90AjmtwBBDnKxL7rB7FoooS3nJcewSysqWZpbKgkS9ks2wVQHzDgg1Py2WJuHbmZzmjhFLvJAlf8FzYoCKT5W6WunzKccVginEpRzeJHZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d/04D3tE; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d/04D3tE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785971244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6gxCG3eUrPwj4WMcACmnudpUnMGSNB3co37O4QOgOsk=;
	b=d/04D3tEXNW39HP4kzKaaBLmI2GsOhs7EkmEQhobv8Yd3fFACczj9n+rZ1fo+M+DCB0n1X
	glbVQs6BTsuqS75Cp0mgCrRCowQXBvuZdvz0RM+tU2jGsRdIZJ6dbuc8KrDibCIla0qkNO
	gFcIveHFVCrgaqZWXfBaACs+CdOVAZI=
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
Subject: [PATCH bpf-next v2 4/6] resolve_btfids: Emit bpf_kfunc and bpf_fastcall decl tags
Date: Wed,  5 Aug 2026 16:06:46 -0700
Message-ID: <20260805230648.2354989-5-ihor.solodrai@linux.dev>
In-Reply-To: <20260805230648.2354989-1-ihor.solodrai@linux.dev>
References: <20260805230648.2354989-1-ihor.solodrai@linux.dev>
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
index 30c7f95aa3b1..ea25ca34aa00 100644
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
@@ -1411,6 +1415,21 @@ static int process_kfunc_with_arena_flags(struct btf2btf_context *ctx,
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
@@ -1424,6 +1443,16 @@ static int btf2btf(struct object *obj)
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

