Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433A738D3EE
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 19:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920099; cv=none; b=BNm+SUMcLBfT7LviMxq2h7d/2C7PF8/XEKcb6K58+OOjs21C3vZYwP0JmIPTIbYDrCHnH4259u91p+5mfy579+3K/0StTxaUZhlnfuGj+PWk2Pi1qgP3K7VFgDhkGEwGIKb1Vn1X7i7yb8NFUI+Y/1sdD901C8w/7KBlszKaO5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920099; c=relaxed/simple;
	bh=H30qCj8JoKyfkvONwZsTV4uNTn0cwK+23CCPR2HfPNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvN7getevIVsM/1ezDrwVMIwgucE6Uf7nZ0wUpP/G39rvcg8ieh056yrHF0vTe3ITN+pm1li/db6E8cpzSoZw9rnpLUBeJIPq4wjA0pnteUyBC2aSQ/Qa8X8c8DXGRDibbEq/m3Tr8b4apPGWNy4l8w3J9w7xbn6krvvxhrkBNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJIrTVhF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJIrTVhF"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso9428885ad.1
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 12:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920097; x=1785524897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=++8R1Ndv/V4h1OXgVnPw9XXb0xcjnJbXbGXNw0twZd4=;
        b=VJIrTVhFrh+avIx8DdZ+AiXJgmqN6Bu9Gt50wWLoyErLq9cEeo+IMDu/dy44Yt/8Oq
         1uVZJ5MRQUowulkQRgAqZOBJyUTxXdKDYy4xJQEMp6b7SKE2e/q7q+0xqsg9HnsSEUKU
         stwWM/69dfiYULxy/v8gO1bFy5S/SzwhpZxvqNZM3nC+M5u2nX9kiFMpxuWUynEjLOM0
         YLqHAsTDyu44pDD36IbmMShUsNHELCJNiLQt3ILZUldFnY+FTcfNg2mH0rMronTDE//Q
         j4U3rn6KgM4VHIN+EvFwigyEiza4ICvovlyPoIvNoyjntIfk0wbt7iqgHMUaG4BTchIF
         166Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920097; x=1785524897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=++8R1Ndv/V4h1OXgVnPw9XXb0xcjnJbXbGXNw0twZd4=;
        b=Z588ULsOkKQt2hoioHEnvpAJf4gB3qwxgty8sT7erRKjE7Hm3qnh4q06svZHcug6WO
         vH+FEHvOduHskjkHVkBkUo2R1bSkkDFQPGPa7YlxT/fxFucrD98HYpTBl3UbNkCQsvgP
         nS39g6vr+zyrpmc6DblTVlMTzh5o6l9S+P25kNJbdyCe+puxfQe+7dy9yhaNanRnzgKj
         OsAMSla0OsDuZ/ARHysbr1Fvjrcwmu2NKEJwaBmD67eVROdBM63NEuxNhmWkGtfeLIVU
         39ZWDOtZT2fuYP201RxfmtUVP8ypWfmaoSI7fhYSSquw+X3M6cP+KG7aRMfLpOwmAT4m
         SStg==
X-Gm-Message-State: AOJu0YxzqpJly1gYvtPaG6wLo+wf4NJFGdE8+4aQw56fkm7vB5uOpxMA
	zrDkBGunuUkMfTcIq5TBUoDQlZqDCjs6rNPLbm7WlEt+5/mY9XFo9zZQJLzdnw==
X-Gm-Gg: AR+sD12QbdtrU5gEzSHnPjpc1H7klh4KX1LHRN9hxu8i0rNiwqA9rjcFen00Ypa3bhH
	L+PpEUpn1nsdNwAeaQyJ6L0WdF07yR0SSdh0al2hmooM1z6MnYEXa7yUvIx5+XyBXhdHFM0rtf2
	hfgrATo13D65nrR74KN6wqWnhTKtPvCdSpbed1jL26LPDbSVhjvEAY5+stb3ye+YJKI0P0SkamO
	ohvF4IpCvVpMpztacrRmxEI1Va+WfpAxcEXAea9TlAN9h+TkX9MyQ7TCFPfblB9USo+VoT8tntq
	gLn4Oj4ESIi8cLqrIYjeMVm5C1pN2zsgC8ludiZmQP6boTOzARbbLNuvmZrmkvXrx32tR69HDcq
	0gTeZa7V0zB0fFmQxVVcbYcr6fsaQzHiFSpvImgmuTbCtvThL64piIiprhMaPv+xpsZAg
X-Received: by 2002:a17:903:22d0:b0:2cf:bfbb:61e2 with SMTP id d9443c01a7336-2cfbfbb66afmr49752055ad.39.1784920097353;
        Fri, 24 Jul 2026 12:08:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f31319asm57802865ad.60.2026.07.24.12.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:08:16 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 03/18] bpf: Split kfunc map argument into __const_map and __map
Date: Fri, 24 Jul 2026 12:07:57 -0700
Message-ID: <20260724190813.1458271-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260724190813.1458271-1-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kfuncs used a single '__map' suffix (KF_ARG_PTR_TO_MAP) for two different
things: a verifier-known map matched by map_uid against a bound
timer/wq/task_work object (bpf_wq_init, bpf_task_work_schedule*), and an
opaque 'struct bpf_map *' used only at runtime (bpf_arena_*), which may be a
map fd or a PTR_TO_BTF_ID struct bpf_map (e.g. a bpf_map iterator's ctx->map).

That combined path only accepted the btf map form due to type confusion. The
'if (!reg->map_ptr)' check reads reg->map_ptr, which aliases reg->btf in the
bpf_reg_state union. A PTR_TO_BTF_ID register always has a non-NULL reg->btf,
so the guard silently passed and validation fell through to
process_kf_arg_ptr_to_btf_id(). It also recorded PTR_TO_BTF_ID info in
meta->map, which would be meaningless.

Split the annotation to avoid such type confusion and to align with
helper:

- '__const_map' -> KF_ARG_CONST_MAP_PTR: verifier-known map, handled by
  process_map_ptr_arg() like helper ARG_CONST_MAP_PTR.

- '__map' -> KF_ARG_PTR_TO_BTF_ID: opaque struct bpf_map, validated by
  process_kf_arg_ptr_to_btf_id(). A map fd still matches via
  reg2btf_ids[CONST_PTR_TO_MAP], so bpf_arena_alloc_pages(&map) keeps
  working.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 30 +++++++++++++++++++++++-
 kernel/bpf/helpers.c         | 16 ++++++-------
 kernel/bpf/verifier.c        | 45 +++++++++++++++++++++---------------
 3 files changed, 64 insertions(+), 27 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index c801a330aece..cbde86d082cc 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -250,6 +250,34 @@ Or::
                 ...
         }
 
+2.3.7 __const_map and __map Annotations
+---------------------------------------
+
+These annotations are used for ``struct bpf_map *`` arguments and distinguish a
+verifier-known map from an opaque one.
+
+``__const_map`` indicates a map must be known at the verification time, i.e. a
+concrete map fd the BPF program references directly.
+
+An example is given below::
+
+        __bpf_kfunc int bpf_wq_init(struct bpf_wq *wq, void *p__const_map,
+                                    unsigned int flags)
+        {
+                ...
+        }
+
+``__map`` indicates an opaque ``struct bpf_map *`` that may be resolved
+at run time. The argument may take either a map fd or a ``PTR_TO_BTF_ID``
+``struct bpf_map`` pointer.
+
+An example is given below::
+
+        __bpf_kfunc void *bpf_arena_alloc_pages(void *p__map, ...)
+        {
+                ...
+        }
+
 .. _BPF_kfunc_nodef:
 
 2.4 Using an existing kernel function
@@ -411,7 +439,7 @@ Example declaration:
 .. code-block:: c
 
 	__bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct bpf_task_work *tw,
-						      void *map__map, bpf_task_work_callback_t callback,
+						      void *map__const_map, bpf_task_work_callback_t callback,
 						      struct bpf_prog_aux *aux) { ... }
 
 Example usage in BPF program:
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c18f1e16edee..93d0d9aa3e15 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3404,10 +3404,10 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	WARN(1, "A call to BPF exception callback should never return\n");
 }
 
-__bpf_kfunc int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags)
+__bpf_kfunc int bpf_wq_init(struct bpf_wq *wq, void *p__const_map, unsigned int flags)
 {
 	struct bpf_async_kern *async = (struct bpf_async_kern *)wq;
-	struct bpf_map *map = p__map;
+	struct bpf_map *map = p__const_map;
 
 	BUILD_BUG_ON(sizeof(struct bpf_async_kern) > sizeof(struct bpf_wq));
 	BUILD_BUG_ON(__alignof__(struct bpf_async_kern) != __alignof__(struct bpf_wq));
@@ -4642,17 +4642,17 @@ static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work
  * mode
  * @task: Task struct for which callback should be scheduled
  * @tw: Pointer to struct bpf_task_work in BPF map value for internal bookkeeping
- * @map__map: bpf_map that embeds struct bpf_task_work in the values
+ * @map__const_map: bpf_map that embeds struct bpf_task_work in the values
  * @callback: pointer to BPF subprogram to call
  * @aux: pointer to bpf_prog_aux of the caller BPF program, implicitly set by the verifier
  *
  * Return: 0 if task work has been scheduled successfully, negative error code otherwise
  */
 __bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct bpf_task_work *tw,
-					      void *map__map, bpf_task_work_callback_t callback,
+					      void *map__const_map, bpf_task_work_callback_t callback,
 					      struct bpf_prog_aux *aux)
 {
-	return bpf_task_work_schedule(task, tw, map__map, callback, aux, TWA_SIGNAL);
+	return bpf_task_work_schedule(task, tw, map__const_map, callback, aux, TWA_SIGNAL);
 }
 
 /**
@@ -4660,17 +4660,17 @@ __bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct b
  * mode
  * @task: Task struct for which callback should be scheduled
  * @tw: Pointer to struct bpf_task_work in BPF map value for internal bookkeeping
- * @map__map: bpf_map that embeds struct bpf_task_work in the values
+ * @map__const_map: bpf_map that embeds struct bpf_task_work in the values
  * @callback: pointer to BPF subprogram to call
  * @aux: pointer to bpf_prog_aux of the caller BPF program, implicitly set by the verifier
  *
  * Return: 0 if task work has been scheduled successfully, negative error code otherwise
  */
 __bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct bpf_task_work *tw,
-					      void *map__map, bpf_task_work_callback_t callback,
+					      void *map__const_map, bpf_task_work_callback_t callback,
 					      struct bpf_prog_aux *aux)
 {
-	return bpf_task_work_schedule(task, tw, map__map, callback, aux, TWA_RESUME);
+	return bpf_task_work_schedule(task, tw, map__const_map, callback, aux, TWA_RESUME);
 }
 
 static int make_file_dynptr(struct file *file, u32 flags, bool may_sleep,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a3429610b426..bb0f3ea53c99 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10817,6 +10817,11 @@ static bool is_kfunc_arg_map(const struct btf *btf, const struct btf_param *arg)
 	return btf_param_match_suffix(btf, arg, "__map");
 }
 
+static bool is_kfunc_arg_const_map(const struct btf *btf, const struct btf_param *arg)
+{
+	return btf_param_match_suffix(btf, arg, "__const_map");
+}
+
 static bool is_kfunc_arg_alloc_obj(const struct btf *btf, const struct btf_param *arg)
 {
 	return btf_param_match_suffix(btf, arg, "__alloc");
@@ -11063,7 +11068,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_RB_NODE,
 	KF_ARG_PTR_TO_NULL,
 	KF_ARG_PTR_TO_CONST_STR,
-	KF_ARG_PTR_TO_MAP,
+	KF_ARG_CONST_MAP_PTR,
 	KF_ARG_PTR_TO_TIMER,
 	KF_ARG_PTR_TO_WORKQUEUE,
 	KF_ARG_PTR_TO_IRQ_FLAG,
@@ -11382,8 +11387,11 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env, struct bpf_func_state *call
 	if (is_kfunc_arg_const_str(meta->btf, &args[arg]))
 		return KF_ARG_PTR_TO_CONST_STR;
 
+	if (is_kfunc_arg_const_map(meta->btf, &args[arg]))
+		return KF_ARG_CONST_MAP_PTR;
+
 	if (is_kfunc_arg_map(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_MAP;
+		return KF_ARG_PTR_TO_BTF_ID;
 
 	if (is_kfunc_arg_wq(meta->btf, &args[arg]))
 		return KF_ARG_PTR_TO_WORKQUEUE;
@@ -12131,19 +12139,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		if (kf_arg_type < 0)
 			return kf_arg_type;
 
+		if (is_kfunc_arg_map(btf, &args[i])) {
+			ref_id = *reg2btf_ids[CONST_PTR_TO_MAP];
+			ref_t = btf_type_by_id(btf_vmlinux, ref_id);
+			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
+		}
+
 		switch (kf_arg_type) {
 		case KF_ARG_PTR_TO_NULL:
 			continue;
-		case KF_ARG_PTR_TO_MAP:
-			if (!reg->map_ptr) {
-				verbose(env, "pointer in %s isn't map pointer\n",
-					reg_arg_name(env, argno));
-				return -EINVAL;
-			}
-			ret = process_map_ptr_arg(env, reg, argno, meta);
-			if (ret < 0)
-				return ret;
-			fallthrough;
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
 			if (!is_trusted_reg(env, reg)) {
@@ -12159,6 +12163,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				}
 			}
 			fallthrough;
+		case KF_ARG_CONST_MAP_PTR:
 		case KF_ARG_PTR_TO_ITER:
 		case KF_ARG_PTR_TO_LIST_HEAD:
 		case KF_ARG_PTR_TO_LIST_NODE:
@@ -12365,12 +12370,16 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			if (ret < 0)
 				return ret;
 			break;
-		case KF_ARG_PTR_TO_MAP:
-			/* If argument has '__map' suffix expect 'struct bpf_map *' */
-			ref_id = *reg2btf_ids[CONST_PTR_TO_MAP];
-			ref_t = btf_type_by_id(btf_vmlinux, ref_id);
-			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
-			fallthrough;
+		case KF_ARG_CONST_MAP_PTR:
+			if (base_type(reg->type) != CONST_PTR_TO_MAP) {
+				verbose(env, "pointer in %s isn't map pointer\n",
+					reg_arg_name(env, argno));
+				return -EINVAL;
+			}
+			ret = process_map_ptr_arg(env, reg, argno, meta);
+			if (ret < 0)
+				return ret;
+			break;
 		case KF_ARG_PTR_TO_BTF_ID:
 			/* Only base_type is checked, further checks are done here */
 			if ((base_type(reg->type) != PTR_TO_BTF_ID ||
-- 
2.52.0

