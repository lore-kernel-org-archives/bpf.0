Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F04415F39
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 23:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785971243; cv=none; b=Xt6bf/P8ttMPYxjf4FDLVyPsGqV7/BcWZM1+IKaDbSu7Og2rlXq/ysZ2dUPYdpFBbMLOCXkW+SymaF7yzh+V+ePPPNrWsyPX2NTZVx2yMDpKU3bhwHQhgTRgB5x30E4KEBrHeF9bHzOxjL9C5+Zpa0JGSOyEfHF4V+2IPPyrk8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785971243; c=relaxed/simple;
	bh=p6zjcetYGqi5hvA1Vw5XFz497To1EA7+82XGTIkd8rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ygkgll0XqEcIFm5KkSZDa5kQoCUFIzqZ6auD8ZiRMElUZRYb0h2Q19yZ9AvGZgU2KU8BpaYEphLrMIhiQ6l8g4VnzAEWDcGAcQMLNkBLeb6g1l0y9b+nYsepJM06TELSxnpcwYl11R+gRReihi/i1GFa624IgLJQZRDY2avCOHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B1KpBe6p; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B1KpBe6p"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785971239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v++4QwMZhu2UvN9MArLrGCWJJUtmgoHZT8UqhGflkAM=;
	b=B1KpBe6poeTkbFwlX2VzfNeJvGwdXJgi1s3g856YOtzZ7NgA4Xlw5FTnpHVVf5XsAtwvKW
	s1U/lp70ApMArZbFBbN/gfGdW93Uw38IicbGYPoD19OL2VHmG7gFmvFJdisSuv05ZagdQW
	zop9n+rkdyhwiIQSVvjpdVgGcb18B4k=
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
Subject: [PATCH bpf-next v2 2/6] resolve_btfids: Process KF_ARENA_* flags in resolve_btfids
Date: Wed,  5 Aug 2026 16:06:44 -0700
Message-ID: <20260805230648.2354989-3-ihor.solodrai@linux.dev>
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
 tools/bpf/resolve_btfids/main.c | 146 ++++++++++++++++++++++++++++++--
 2 files changed, 141 insertions(+), 7 deletions(-)

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
index 5d168c2a5ff5..30c7f95aa3b1 100644
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
@@ -1280,6 +1284,133 @@ static int process_kfunc_with_implicit_args(struct btf2btf_context *ctx, struct
 	return 0;
 }
 
+static s32 arena_tag_ptr(struct btf *btf, u32 ptr_id)
+{
+	const struct btf_type *ptr = btf__type_by_id(btf, ptr_id);
+	s32 tag_id;
+
+	if (!btf_is_ptr(ptr))
+		return -EINVAL;
+
+	tag_id = btf__add_type_attr(btf, TYPE_ATTR_ARENA, ptr->type);
+	if (tag_id < 0)
+		return tag_id;
+
+	return btf__add_ptr(btf, tag_id);
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
+	const struct btf_param *params = btf_params(proto);
+	u32 nr_params = btf_vlen(proto);
+	s32 arg0_type_id = nr_params > 0 ? (s32)params[0].type : -1;
+	s32 arg1_type_id = nr_params > 1 ? (s32)params[1].type : -1;
+	s32 new_proto_id, id, param_type_id;
+	s32 ret_type_id = proto->type;
+	const char *name;
+	int err;
+
+	if (kfunc->flags & KF_ARENA_RET) {
+		id = arena_tag_ptr(btf, ret_type_id);
+		if (id < 0) {
+			pr_err("ERROR: resolve_btfids: kfunc %s: KF_ARENA_RET but return type is not a pointer\n",
+			       kfunc->name);
+			return id;
+		}
+		ret_type_id = id;
+	}
+
+	if (kfunc->flags & KF_ARENA_ARG1) {
+		if (nr_params < 1) {
+			pr_err("ERROR: resolve_btfids: kfunc %s: KF_ARENA_ARG1 but it has no argument 1\n",
+			       kfunc->name);
+			return -EINVAL;
+		}
+		id = arena_tag_ptr(btf, arg0_type_id);
+		if (id < 0) {
+			pr_err("ERROR: resolve_btfids: kfunc %s: KF_ARENA_ARG1 but argument 1 is not a pointer\n",
+			       kfunc->name);
+			return id;
+		}
+		arg0_type_id = id;
+	}
+
+	if (kfunc->flags & KF_ARENA_ARG2) {
+		if (nr_params < 2) {
+			pr_err("ERROR: resolve_btfids: kfunc %s: KF_ARENA_ARG2 but it has no argument 2\n",
+			       kfunc->name);
+			return -EINVAL;
+		}
+		id = arena_tag_ptr(btf, arg1_type_id);
+		if (id < 0) {
+			pr_err("ERROR: resolve_btfids: kfunc %s: KF_ARENA_ARG2 but argument 2 is not a pointer\n",
+			       kfunc->name);
+			return id;
+		}
+		arg1_type_id = id;
+	}
+
+	new_proto_id = btf__add_func_proto(btf, ret_type_id);
+	if (new_proto_id < 0) {
+		pr_err("ERROR: resolve_btfids: kfunc %s: failed to add a func proto to BTF\n",
+		       kfunc->name);
+		return new_proto_id;
+	}
+
+	for (u32 i = 0; i < nr_params; i++) {
+		proto = btf__type_by_id(btf, proto_id);
+		params = btf_params(proto);
+		name = btf__name_by_offset(btf, params[i].name_off);
+
+		switch (i) {
+		case 0:
+			param_type_id = arg0_type_id;
+			break;
+		case 1:
+			param_type_id = arg1_type_id;
+			break;
+		default:
+			param_type_id = params[i].type;
+			break;
+		}
+
+		err = btf__add_func_param(btf, name ?: "", param_type_id);
+		if (err < 0) {
+			pr_err("ERROR: resolve_btfids: kfunc %s: failed to add a proto param to BTF\n",
+			       kfunc->name);
+			return err;
+		}
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
@@ -1293,12 +1424,17 @@ static int btf2btf(struct object *obj)
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

