Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83C7379C58
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786563529; cv=none; b=kF9X7PKR9t6bhy91V2r0JuxzqniyAyhKrEcdxchMQYoe5pu2IlBvUfy6VTV9O++cSxVq+kN65+W80K05u3DjeflJk5Bt9n2nIFQ7fcwbmBYx2xmY+WTU5F5Gkd1lJeqXaYR08X/bJa+xGE9OH/Uot+fMC3/aL8B8fTT9Ay78Jgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786563529; c=relaxed/simple;
	bh=NUGDxQXxalzUA7ntNFGiOAemseDGOVRh2jPiOmJNN0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDIi743ywLz6xMi7L9LmuLg5Q0jLBt7M6ahKCq64EOvsml0BCEic/2Oh7PonVMht7bAZfLJavRU2rv/pCgMsuCX4bqkrl5y6z+cOgMcC2WtFu/9O8fuTfBgbpxtJHNB/gHfGuVNPJdT6kIDYfg64VwXpf/Of7hPIjmwXiLiIJ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8QHS5AX; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8QHS5AX"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47fcb9d4b33so532868f8f.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 12:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786563525; x=1787168325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WadPnwolNyRFroAmudRsyXPUZWdE+S8znjxvFb0DnSY=;
        b=l8QHS5AXzP+kGYr/dhFb6hDY9AfrBNYVqENaoxbs2HQoI4zmoM3JKIRY7J3GBmUXrr
         otGjZGEZi3lJ3W1DwACXeYAplVTaDRYSoPRjIRpba5ytmRWt/sNKSm/Y0HoExwpBJrqY
         gWCtcnaIPb1YtSkxUehxLcHqiy2QvCc9i3/6Kk8JDGi9yrcWE21Xj90lW1UDpdihCLNt
         0+ng+h3noL0qdyQhPFpmOBBFkpupgHZW2RmvmV9+PNQJMzKZcYudYl77ORhHZXdpMFLc
         59T9/NmW3jr7CQOPX0kFJxCLEWJY1W79QrHWS/3+a0/8zGNH36tUPGg9ll8xPGCrNJ/D
         XEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786563525; x=1787168325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WadPnwolNyRFroAmudRsyXPUZWdE+S8znjxvFb0DnSY=;
        b=j/DByodQeu/8AjtO5Ah0pT7UHOuHwHkgz06Y8Ko6PtMHXcUZdvBD7rQ/wkg9B06a5+
         e0QT8Ejtm8IfyV3p3wFGBdtTUNHZZB8XEa7mUo3M34k3yed/29iOZU3kBsCx7fM63RaI
         8mOof6YYL6E1pPUnHbFhLzBiNUPWxYL0BnB5G4PslRk3JwINwJ89X/v20YT7ZK5zyVol
         rvYWW51Y1lO7nhz0YOJ2eaw+ldJXviuwJ2Yxw7dpTdEJfTAMtjI9IWz1FhU+D6YiAlU5
         3WpBAv3PYflERGoPfNG5qrEs60JLA6rITaRQSv5Y5M280jn4NMh0i6ifibZmcgW9WKj3
         7kvQ==
X-Gm-Message-State: AOJu0YwL0tfWdbj7FcTQH5a7eDVWlTrvhB+x0oucY/Qnqx1R3zk9CbR0
	tBPyO+W4PKG6PkxVlVTUpBMc3+HciKvy4dPmdCC1mpmce2eO2JHnVRpsCWrg83ud
X-Gm-Gg: AR+sD12IYd0dAmeBd6meYrsLZiYkYarglHyd5VUXGrGJaWeCWGVDsJP9aQJty5Vp0+3
	YARr0hBKxxMkXmPoE0bWsV6QNpRpL7hdmEf+PXjtuFR3PHKwSEg+tuhD+Ne+pIMfZk+slDuXM8L
	UmFHglsCQ5q7p3VGm1XosIbojceEwQv91jtAHSff+qCC7vJdeHP/aLaKTIKnSkzcrlJDHCEsOCv
	SZXHZz7T8FMDkJnKJeJB6gSZgXpbMEbcORCHbBo6Csgi4oBOZsEzS7QLAthdjR++0o++Vppgq69
	OC8QDkL67o8s5ySyB8lQnkbx3BOIw9P6vFCYRmtOV10B27Hg/ahqgTffslvDz7LWEOBqgl1l43O
	rzVEfQY5JmFaVlDT9h9ICJzzKYQ4uTEm6qowCEDQlMYCbjnlDh/eyMZgAIJyL27AVmOH7Pu72VM
	5VXKBk10y8FlML8Vb9TB4zdG72t23t9Pne1LyjSR3hEvUjN9+VnVudQRY3HZVKwoHWoX9Q5Vc6c
	WUt9dlDh9oYi6MHfqJuSaBWs8OHy+TCJag17j35UdATtZSyvr6Z3BOT5bKfTrvaLmc27asVXrqk
	gLqVrWNaaPQEojpNIU2tIlJ9BSI=
X-Received: by 2002:a05:600c:4f87:b0:493:f140:c3fb with SMTP id 5b1f17b1804b1-499821cf33bmr375645e9.7.1786563525471;
        Wed, 12 Aug 2026 12:38:45 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981d9613fsm22813105e9.0.2026.08.12.12.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 12:38:45 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/2] resolve_btfids: Emit arena attributes from kfunc parameter suffixes
Date: Wed, 12 Aug 2026 21:38:40 +0200
Message-ID: <20260812193842.2879226-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812193842.2879226-1-memxor@gmail.com>
References: <20260812193842.2879226-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6838; i=memxor@gmail.com; h=from:subject; bh=NUGDxQXxalzUA7ntNFGiOAemseDGOVRh2jPiOmJNN0E=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavmtGLH9eZodc+7r1k3v7p92yZ0+vUX7e5eb0M7Y9+fW VP668vujlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzkx06G/3mrHrStVHSyudnw 7um7A3PvdxytqZyjsSD3r9ntks8Je3wYGTZe2Zcy6bnx87tN9150igkt3XFm7SvZ0wytcdqtfMf +93IDAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Kfunc declarations can identify arena arguments through parameter name
suffixes without repeating KF_ARENA_ARG flags in their BTF ID sets.
resolve_btfids currently misses those arguments when synthesizing the
address_space(1) attributes used by generated vmlinux.h files.

Teach the arena prototype rewrite to recognize __arena and
__arena__nullable directly on each parameter. Keep KF_ARENA_ARG1 and
KF_ARENA_ARG2 handling for explicitly flagged kfuncs, while allowing
suffixes on any argument without synthesizing kfunc flags.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/kfuncs.rst    |  4 +-
 tools/bpf/resolve_btfids/main.c | 72 ++++++++++++++++++++++++---------
 2 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 1004eb0bec61..10e725cbe64c 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -513,8 +513,8 @@ At kernel build time the ``resolve_btfids`` tool finds all kfuncs declared with
 ``BTF_KFUNCS_START()`` and emits their BTF annotations into the kernel's BTF.
 For each kfunc it emits a ``bpf_kfunc`` BTF decl tag, a ``bpf_fastcall`` decl
 tag when the kfunc is flagged ``KF_FASTCALL``, and the ``address_space(1)`` type
-attribute on the return value and/or arguments flagged ``KF_ARENA_RET``,
-``KF_ARENA_ARG1`` or ``KF_ARENA_ARG2`` (see section 2.8).
+attribute on the return value and/or arguments that use arena pointers (see
+sections 2.3.8 and 2.8).
 
 2.7  Specifying no-cast aliases with ___init
 --------------------------------------------
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index d2e4176339da..37d7e7224207 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -64,8 +64,8 @@
  * each such kfunc it:
  *
  *   - emits a "bpf_kfunc" decl tag, and "bpf_fastcall" when KF_FASTCALL is set;
- *   - wraps the return value and/or arguments flagged KF_ARENA_RET,
- *     KF_ARENA_ARG1 or KF_ARENA_ARG2 with the "address_space(1)" type attribute;
+ *   - wraps the return value and/or arguments that use arena pointers
+ *     with the "address_space(1)" type attribute;
  *   - rewrites the prototype of KF_IMPLICIT_ARGS kfuncs.
  *
  * These kfunc annotations were historically produced by pahole.
@@ -182,6 +182,8 @@ struct object {
 #define KF_IMPLICIT_ARGS (1 << 16)
 #define KF_IMPL_SUFFIX "_impl"
 #define TYPE_ATTR_ARENA "address_space(1)"
+#define PARAM_SUFFIX_ARENA "__arena"
+#define PARAM_SUFFIX_ARENA_NULLABLE "__arena__nullable"
 
 struct kfunc {
 	struct rb_node rb_node;
@@ -1067,6 +1069,22 @@ static int collect_decl_tags(struct btf2btf_context *ctx)
 	return 0;
 }
 
+static bool param_name_has_suffix(const char *name, const char *suffix)
+{
+	size_t name_len = strlen(name);
+	size_t suffix_len = strlen(suffix);
+
+	return name_len >= suffix_len && !strcmp(name + name_len - suffix_len, suffix);
+}
+
+static bool is_arena_param(const struct btf *btf, const struct btf_param *param)
+{
+	const char *name = btf__name_by_offset(btf, param->name_off);
+
+	return param_name_has_suffix(name, PARAM_SUFFIX_ARENA) ||
+	       param_name_has_suffix(name, PARAM_SUFFIX_ARENA_NULLABLE);
+}
+
 static int collect_kfuncs(struct object *obj, struct btf2btf_context *ctx)
 {
 	Elf_Data *idlist = obj->efile.idlist;
@@ -1299,8 +1317,12 @@ static int process_kfunc_with_implicit_args(struct btf2btf_context *ctx, struct
 	return 0;
 }
 
-static bool is_arena_arg(struct kfunc *kfunc, u32 idx)
+static bool is_arena_arg(const struct btf *btf, const struct kfunc *kfunc,
+			 const struct btf_param *param, u32 idx)
 {
+	if (is_arena_param(btf, param))
+		return true;
+
 	switch (idx) {
 	case 0:
 		return kfunc->flags & KF_ARENA_ARG1;
@@ -1339,23 +1361,36 @@ static s32 arena_tag_ptr(struct btf *btf, u32 ptr_id, struct kfunc *kfunc)
 }
 
 /*
- * Add a FUNC_PROTO for @kfunc with each relevant pointer tagged with
- * an "address_space(1)" attribute. The original proto may be shared
- * with other FUNCs, so it is never modified in place.
+ * Add a FUNC_PROTO for @kfunc with each arena pointer tagged with an
+ * "address_space(1)" attribute. The original proto may be shared with
+ * other FUNCs, so it is never modified in place. Returns the original
+ * proto id when @kfunc has no arena return value or arguments.
  */
 static s32 add_arena_tagged_proto(struct btf *btf, struct kfunc *kfunc)
 {
 	const struct btf_type *func = btf__type_by_id(btf, kfunc->btf_id);
 	u32 proto_id = func->type;
 	const struct btf_type *proto = btf__type_by_id(btf, proto_id);
+	const struct btf_param *params = btf_params(proto);
 	u32 nr_params = btf_vlen(proto);
 	s32 ret_type_id = proto->type;
 	const struct btf_type *t;
-	struct btf_param *params;
+	struct btf_param *tag_params;
 	s32 new_proto_id, id;
 	const char *name;
+	bool has_arena_arg = false;
 	int err, i;
 
+	for (i = 0; i < nr_params; i++) {
+		if (is_arena_arg(btf, kfunc, &params[i], i)) {
+			has_arena_arg = true;
+			break;
+		}
+	}
+
+	if (!(kfunc->flags & KF_ARENA_RET) && !has_arena_arg)
+		return proto_id;
+
 	if (kfunc->flags & KF_ARENA_RET) {
 		ret_type_id = arena_tag_ptr(btf, ret_type_id, kfunc);
 		if (ret_type_id < 0)
@@ -1383,19 +1418,18 @@ static s32 add_arena_tagged_proto(struct btf *btf, struct kfunc *kfunc)
 	}
 
 	for (i = 0; i < nr_params; i++) {
-		if (!is_arena_arg(kfunc, i))
-			continue;
-
 		t = btf__type_by_id(btf, new_proto_id);
-		params = btf_params(t);
+		tag_params = btf_params(t);
+		if (!is_arena_arg(btf, kfunc, &tag_params[i], i))
+			continue;
 
-		id = arena_tag_ptr(btf, params[i].type, kfunc);
+		id = arena_tag_ptr(btf, tag_params[i].type, kfunc);
 		if (id < 0)
 			return id;
 
 		t = btf__type_by_id(btf, new_proto_id);
-		params = btf_params(t);
-		params[i].type = id;
+		tag_params = btf_params(t);
+		tag_params[i].type = id;
 	}
 
 	pr_debug("added arena-tagged proto for kfunc %s: %d\n", kfunc->name, new_proto_id);
@@ -1403,7 +1437,7 @@ static s32 add_arena_tagged_proto(struct btf *btf, struct kfunc *kfunc)
 	return new_proto_id;
 }
 
-static int process_kfunc_with_arena_flags(struct btf2btf_context *ctx,
+static int process_kfunc_with_arena_attrs(struct btf2btf_context *ctx,
 					  struct kfunc *kfunc)
 {
 	struct btf_type *t;
@@ -1463,11 +1497,9 @@ static int btf2btf(struct object *obj)
 				goto out;
 		}
 
-		if (kfunc->flags & (KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2)) {
-			err = process_kfunc_with_arena_flags(&ctx, kfunc);
-			if (err)
-				goto out;
-		}
+		err = process_kfunc_with_arena_attrs(&ctx, kfunc);
+		if (err)
+			goto out;
 	}
 
 	err = 0;
-- 
2.53.0

