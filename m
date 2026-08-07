Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B965C35C188
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 03:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786072860; cv=none; b=qoAAlfyErlN4C0gWCVu3acGxHsJHpu2vweSaNJ9EMoA52LEwbuNiXT7D3KA5W7BG0DfTlbAm3nOsyEf0CZlUFDWJMnpoVpxr2iY26XCnLrCqLYpcK0ulFfNNWKPEZ/fyg63wDjzb/dJOYeIn+n5irxQpJ5acI6BJh3fGbmahzOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786072860; c=relaxed/simple;
	bh=qXVLm8yAsUlMUE4OSDGV0aR/sgIAFLBOwp8ZJfB8mQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMwepSoQTU5MwcpE2QGvIWwaQPIGD2Xv6Nq9yrW50mgu6uuDkBGt02AtJ0370Qh3ufGEr+qbc1kZa4KajYO8n/w2z3gn+t7mZBJ7Rhe4YLjM5X8G+eyVdpuV4bo0+vctq7nMwNlM8bZl2v+0wplcJwezdAwIWhVIT7We0t2oM8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=St6K3uGZ; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="St6K3uGZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786072856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LaUlPXjtysFiB/JKKQAbsR1Uzp0UPB/O1VLAon7URwo=;
	b=St6K3uGZm7aa6m7NrEhdwLW7OYx87OEm5jj1tdhH5Uh09hxRtnJxV9HzbsGbI8ejJ4Q2zm
	1r5FeWu4oe5HsZWkErPaRiFXBH0oWCWGrJOreo+1t4E3XKi8x1Kjxt7BW3qWbyDP0epTd0
	DXV6r7hOrK4LUeWQw5KnzMcLLClbxmA=
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
Subject: [PATCH bpf-next v3 2/6] resolve_btfids: Process KF_ARENA_* flags in resolve_btfids
Date: Thu,  6 Aug 2026 20:20:25 -0700
Message-ID: <20260807032029.78092-3-ihor.solodrai@linux.dev>
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

For kfuncs flagged with KF_ARENA_RET, KF_ARENA_ARG1 or KF_ARENA_ARG2,
the address_space(1) attribute (a type tag with kflag=1) must be
emitted for the corresponding type in BTF. This was previously done by
pahole via the "attributes" BTF feature [1].

Implement the emission of the arena attributes in resolve_btfids: for
flagged kfuncs create a new function prototype with updated BTF types.
The original proto may be shared with sibling FUNCs, so it is not
modified in place.

Emission is unconditional: kbuild controls the pahole flags, so the
input BTF is expected to not have these attributes. Invalid
declarations are reported as errors.

Drop the "attributes" pahole feature from scripts/Makefile.btf
resolve_btfids now emits them for all supported pahole versions.

[1] https://lore.kernel.org/dwarves/20250228194654.1022535-1-ihor.solodrai@linux.dev/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 scripts/Makefile.btf            |   2 -
 tools/bpf/resolve_btfids/main.c | 139 ++++++++++++++++++++++++++++++--
 2 files changed, 134 insertions(+), 7 deletions(-)

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index e66e13e79653..8f73c093d27a 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -16,8 +16,6 @@ else
 # Switch to using --btf_features for v1.26 and later.
 pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j$(JOBS) --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
 
-pahole-flags-$(call test-ge, $(pahole-ver), 130) += --btf_features=attributes
-
 pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=layout
 
 endif
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 5d168c2a5ff5..53d9045ed5c8 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -161,8 +161,12 @@ struct object {
 	u32 addr_syms_cap;
 };
 
+#define KF_ARENA_RET	(1 << 13)
+#define KF_ARENA_ARG1	(1 << 14)
+#define KF_ARENA_ARG2	(1 << 15)
 #define KF_IMPLICIT_ARGS (1 << 16)
 #define KF_IMPL_SUFFIX "_impl"
+#define TYPE_ATTR_ARENA "address_space(1)"
 
 struct kfunc {
 	struct rb_node rb_node;
@@ -1280,6 +1284,126 @@ static int process_kfunc_with_implicit_args(struct btf2btf_context *ctx, struct
 	return 0;
 }
 
+static bool is_arena_arg(struct kfunc *kfunc, u32 idx)
+{
+	switch (idx) {
+	case 0:
+		return kfunc->flags & KF_ARENA_ARG1;
+	case 1:
+		return kfunc->flags & KF_ARENA_ARG2;
+	default:
+		return false;
+	}
+}
+
+static s32 arena_tag_ptr(struct btf *btf, u32 ptr_id, struct kfunc *kfunc)
+{
+	const struct btf_type *ptr = btf__type_by_id(btf, ptr_id);
+	s32 tag_id, new_ptr_id;
+
+	if (!btf_is_ptr(ptr)) {
+		pr_err("ERROR: resolve_btfids: kfunc %s: arena type is not a pointer\n",
+		       kfunc->name);
+		return -EINVAL;
+	}
+
+	tag_id = btf__add_type_attr(btf, TYPE_ATTR_ARENA, ptr->type);
+	if (tag_id < 0) {
+		pr_err("ERROR: resolve_btfids: kfunc %s: failed to add a type attr to BTF: %d\n",
+		       kfunc->name, tag_id);
+		return tag_id;
+	}
+
+	new_ptr_id = btf__add_ptr(btf, tag_id);
+	if (new_ptr_id < 0) {
+		pr_err("ERROR: resolve_btfids: kfunc %s: failed to add a pointer to BTF: %d\n",
+		       kfunc->name, new_ptr_id);
+	}
+
+	return new_ptr_id;
+}
+
+/*
+ * Add a FUNC_PROTO for @kfunc with each relevant pointer tagged with
+ * an "address_space(1)" attribute. The original proto may be shared
+ * with other FUNCs, so it is never modified in place.
+ */
+static s32 add_arena_tagged_proto(struct btf *btf, struct kfunc *kfunc)
+{
+	const struct btf_type *func = btf__type_by_id(btf, kfunc->btf_id);
+	u32 proto_id = func->type;
+	const struct btf_type *proto = btf__type_by_id(btf, proto_id);
+	u32 nr_params = btf_vlen(proto);
+	s32 ret_type_id = proto->type;
+	const struct btf_type *t;
+	struct btf_param *params;
+	s32 new_proto_id, id;
+	const char *name;
+	int err, i;
+
+	if (kfunc->flags & KF_ARENA_RET) {
+		ret_type_id = arena_tag_ptr(btf, ret_type_id, kfunc);
+		if (ret_type_id < 0)
+			return ret_type_id;
+	}
+
+	new_proto_id = btf__add_func_proto(btf, ret_type_id);
+	if (new_proto_id < 0) {
+		pr_err("ERROR: resolve_btfids: kfunc %s: failed to add a func proto to BTF: %d\n",
+		       kfunc->name, new_proto_id);
+		return new_proto_id;
+	}
+
+	for (i = 0; i < nr_params; i++) {
+		/* btf__add_func_param() below may move the proto, re-fetch */
+		proto = btf__type_by_id(btf, proto_id);
+		name = btf__name_by_offset(btf, btf_params(proto)[i].name_off);
+
+		err = btf__add_func_param(btf, name ?: "", btf_params(proto)[i].type);
+		if (err < 0) {
+			pr_err("ERROR: resolve_btfids: kfunc %s: failed to add a proto param to BTF: %d\n",
+			       kfunc->name, err);
+			return err;
+		}
+	}
+
+	for (i = 0; i < nr_params; i++) {
+		if (!is_arena_arg(kfunc, i))
+			continue;
+
+		t = btf__type_by_id(btf, new_proto_id);
+		params = btf_params(t);
+
+		id = arena_tag_ptr(btf, params[i].type, kfunc);
+		if (id < 0)
+			return id;
+
+		t = btf__type_by_id(btf, new_proto_id);
+		params = btf_params(t);
+		params[i].type = id;
+	}
+
+	pr_debug("added arena-tagged proto for kfunc %s: %d\n", kfunc->name, new_proto_id);
+
+	return new_proto_id;
+}
+
+static int process_kfunc_with_arena_flags(struct btf2btf_context *ctx,
+					  struct kfunc *kfunc)
+{
+	struct btf_type *t;
+	s32 proto_id;
+
+	proto_id = add_arena_tagged_proto(ctx->btf, kfunc);
+	if (proto_id < 0)
+		return proto_id;
+
+	t = (struct btf_type *)btf__type_by_id(ctx->btf, kfunc->btf_id);
+	t->type = proto_id;
+
+	return 0;
+}
+
 static int btf2btf(struct object *obj)
 {
 	struct btf2btf_context ctx = {};
@@ -1293,12 +1417,17 @@ static int btf2btf(struct object *obj)
 	for (next = rb_first(&ctx.kfuncs); next; next = rb_next(next)) {
 		struct kfunc *kfunc = rb_entry(next, struct kfunc, rb_node);
 
-		if (!(kfunc->flags & KF_IMPLICIT_ARGS))
-			continue;
+		if (kfunc->flags & KF_IMPLICIT_ARGS) {
+			err = process_kfunc_with_implicit_args(&ctx, kfunc);
+			if (err)
+				goto out;
+		}
 
-		err = process_kfunc_with_implicit_args(&ctx, kfunc);
-		if (err)
-			goto out;
+		if (kfunc->flags & (KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2)) {
+			err = process_kfunc_with_arena_flags(&ctx, kfunc);
+			if (err)
+				goto out;
+		}
 	}
 
 	err = 0;
-- 
2.55.0

