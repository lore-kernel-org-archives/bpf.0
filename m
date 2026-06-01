Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD8B3403E8
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 22:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780352349; cv=none; b=r7/ZrED4ls6goVCKv7azwQNau3qIPZy3Epv2uLjKzifkP1HhroIu2X9c8+w+ARTVIqZfLa9K+uVDpBk0gWsPZsiQv65PXU0GOgUNKiKQl5JRWGRz8LajPUmYmpIFLAOnNTP0nrPiOpxNNsBhf9SpIch8aZ7hABOR+7ZU5LIC0a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780352349; c=relaxed/simple;
	bh=C64AbZSx9PTRhhKL55bbeOj/X0Q9XVlqLonW+yYNU7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0p7LNwN62mAHx6LleB00XYwIP8Exr/Bu+fYhCifKmlGDgSdOFEWUBhRBZqU+y693j32NYT6s7KBU1HpxUsMn4ZiY8LhniC45zVckLFmQTLho5X8vJXMWlU/PQh6iv/TuWM+7vQzVuT1aiKXIUzvhC/t6BiT0IziQVlzZoPysBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hQ3Be0/T; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hQ3Be0/T"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780352346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=24QUti9p8crQ1fq2MIgb7AmdF0Tk09WIhO6J+YRmMLA=;
	b=hQ3Be0/TvuvuHipL1H/7T2hvgEqN8DsW8Atqs1QFj4W4Y/F9DqNywzS7bpFiwPZbedjfyG
	xs7Sh+ryuF/KkfHVoAh6EA7wQBPRZMRSAeKhkFvGIG+9+S1yRjc1NCUbeaDAaG0czjUo8Z
	UfPm90pwbdIuXNqLeVJJmpHmEA4dISo=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: [PATCH bpf-next v1 07/14] resolve_btfids: Emit bpf_kfunc BTF decl tag for discovered kfuncs
Date: Mon,  1 Jun 2026 15:17:58 -0700
Message-ID: <20260601221805.821394-8-ihor.solodrai@linux.dev>
In-Reply-To: <20260601221805.821394-1-ihor.solodrai@linux.dev>
References: <20260601221805.821394-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Now that collect_kfuncs() discovers kfuncs from BTF_SET8_KFUNCS sets,
resolve_btfids can also be the source of truth for the bpf_kfunc decl
tag in BTF.

Today pahole emits it under --btf_features=decl_tag_kfuncs; moving the
emission in-tree lets that flag be dropped from the kernel build once
the rest of the kfunc annotations follow.

The implementation in resolve_btfids is idempotent: if a decl_tag
exists in the input BTF, no new tag will be emitted. This allows to be
more independent of pahole's version and runtime flags used to
generate the BTF.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/resolve_btfids/main.c | 49 ++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index d35a7b2460e8..30a07ec4ebb6 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -1255,6 +1255,44 @@ static int process_kfunc_with_implicit_args(struct btf2btf_context *ctx, struct
 	return 0;
 }
 
+static bool btf_has_decl_tag(struct btf2btf_context *ctx, const char *tag_name,
+			     u32 target_btf_id, int component_idx)
+{
+	const struct btf_type *t;
+	const char *name;
+
+	for (u32 i = 0; i < ctx->nr_decl_tags; i++) {
+		t = btf__type_by_id(ctx->btf, ctx->decl_tags[i]);
+		if (t->type != target_btf_id)
+			continue;
+		if (btf_decl_tag(t)->component_idx != component_idx)
+			continue;
+		name = btf__name_by_offset(ctx->btf, t->name_off);
+		if (name && strcmp(name, tag_name) == 0)
+			return true;
+	}
+	return false;
+}
+
+/* Add a decl tag if an identical one is not already present. */
+static int ensure_decl_tag(struct btf2btf_context *ctx, const char *tag_name,
+			   u32 target_btf_id, int component_idx)
+{
+	int new_id;
+
+	if (btf_has_decl_tag(ctx, tag_name, target_btf_id, component_idx))
+		return 0;
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
@@ -1267,12 +1305,15 @@ static int btf2btf(struct object *obj)
 	for (u32 i = 0; i < ctx.nr_kfuncs; i++) {
 		struct kfunc *kfunc = &ctx.kfuncs[i];
 
-		if (!(kfunc->flags & KF_IMPLICIT_ARGS))
-			continue;
-
-		err = process_kfunc_with_implicit_args(&ctx, kfunc);
+		err = ensure_decl_tag(&ctx, "bpf_kfunc", kfunc->btf_id, -1);
 		if (err)
 			goto out;
+
+		if (kfunc->flags & KF_IMPLICIT_ARGS) {
+			err = process_kfunc_with_implicit_args(&ctx, kfunc);
+			if (err)
+				goto out;
+		}
 	}
 
 	err = 0;
-- 
2.54.0

