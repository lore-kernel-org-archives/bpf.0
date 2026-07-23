Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11EA1FC7C5
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 05:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783294; cv=none; b=SVKZe+b8/woV6I1H67KTjt0voofxtLUg/VPV0Jc7gI30zYPsxsU6le/EoJY9pKMGT9oFnff+s6DnZkuCkjyWqsVE7f3XFIUzPyqrOeWevXryz6NwZWJgXlkHE022lKCoViLoOfYTh1bl/zAUmfaRvq0bn+fQDdSCUXzqbb3ZSVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783294; c=relaxed/simple;
	bh=16LZujqTOG+sxGCodbBcmTZuk7SF5pq5lLgFzEkz1kA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ky486Q5Y2fOhE61J5gcJ4mK9r8JiKiUsRfA5ThTtskuPzFsI8tkNKQK/tFF/YP4X3Iagvl8fIcVZKvidHOehfwzYRwgswu0kpLyayQYCAPFnFAID3mo1+1XvtTfChVqTdHW0RbDKcaF7phGmiDg1il2UOmwwQxBFyIca6/jjLcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7bY7oCZ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7bY7oCZ"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso207043b3a.1
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 22:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784783292; x=1785388092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7j6nmR0vL4pImAWXCjDtdkhv7Vp2eNCUSqCoJTljnEA=;
        b=l7bY7oCZT1KgBa4NkxkguTHTnJ6BIkIYLCGRO/UTH0ejo+RdgIq6qF6iJJ50ctU+Jq
         i3lHkvXWU3v20FVPQ3eKMKaDCmILcYgQc1Cc7TUQhHU8z2uwL58lLCrSDNL/S4Ue6Cph
         L7xcH0XM/Ih2+ckTPeiIOPRJ82TMDi8XZ/BRb2QbG0PnJhO4x3yiM9K2W4P5+WIknu1I
         cRNf5YaRe3GLJzU1Gv3vHzI7OzvgDhPmCP92uFdXkLJdwSqbQ3M+CyhPhOdyIm/g5gs1
         UXADAu9YeL1PUEU26H+dlxKLytaC7CNJN/xEqaNUuG7GfFvLUzmRuINW7gq3TBnJ4JIj
         K/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784783292; x=1785388092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7j6nmR0vL4pImAWXCjDtdkhv7Vp2eNCUSqCoJTljnEA=;
        b=n/4edkmnWBvwxmOung/0P+oJFAp/UeVTzowI42mPvO0ZI9tVXtG0a+sgB3QG5wZs6j
         ZlIK2LIfptAezioUkKGD/r7tiPK8vV2erLWTZhImOBainfGB0h3mAstxbwHyz9D2ATWY
         1JAvLtwyXOLmwzZz5muxv5DpS3YKFb8a5TXwBk2t34TSkgcxYyXrzUIL05PiQWrKKIlt
         yUlROca3oIRibv647mPS71F6yklIBX3TjPb3RNwQX+60pGD1fuZ/lYbgfk7rXNxDsB2Y
         5SNfbGgnchnlFZGXkprGDjT1gOOh5kaMvz9Y90Z9SEOa/hob2jg5wOspnhbaYsrrDin6
         +1Dw==
X-Gm-Message-State: AOJu0YyQBJ62qEZmniI+F2G6JB2s/36lBKXKHaTeUJ3Vvd6OqUr+EdpM
	OTePIuQKQD2LgWYR5kl7QxF88zQ+WZQjpAZtgutEvXhH4kU+YKyFiYc4VwDECg==
X-Gm-Gg: AR+sD12sf5EGgqEz913JVsulT2Q+KielJYl45Urojp7vA06mpK9nHAwfuvOCwOYY0Br
	nB/2iBRtEEXeDoiJnLPBiwwPoAKaFlDuELPOQQ/UxeI0V5jN8/wg5YPx1GgLXIhqQMoc3IZVTQo
	wbbjh3fftHT84N9K5XEBTRigaCDuNmudlTPLK04YKi1FPj2aZmNyfRt+FZS07ISqVHBCQHdxGC3
	IXLC+T1TdSmYlSwXhHc3/MCKaPNA5M2aI20fo+ZGIy4yhs68MeE5y04lr+Cld0HPwjlReMudbSr
	7/J1OkwGsL3JbhX3pDR2N1IHYj4vTb70+vmeNcgHZ15GMj5MXpaNjhVG4BP6o9kuBcu8mQnXs2J
	f2cBgNA3C2U+pr1IppHv6qoXmtTndSjDaD16D5QW8GXtpL/I2vtobfPu45wvocZHWxh6+
X-Received: by 2002:a05:6a00:35c9:b0:845:c8f9:6ce0 with SMTP id d2e1a72fcca58-84e2b8a6c44mr2020885b3a.21.1784783292053;
        Wed, 22 Jul 2026 22:08:12 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4c::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17600a72sm2373651b3a.58.2026.07.22.22.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 22:08:11 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 03/18] bpf: Split kfunc map argument into __const_map and __map
Date: Wed, 22 Jul 2026 22:07:51 -0700
Message-ID: <20260723050806.1158442-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723050806.1158442-1-ameryhung@gmail.com>
References: <20260723050806.1158442-1-ameryhung@gmail.com>
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
index bff51aff2557..0ba0de8eb8fe 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10823,6 +10823,11 @@ static bool is_kfunc_arg_map(const struct btf *btf, const struct btf_param *arg)
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
@@ -11069,7 +11074,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_RB_NODE,
 	KF_ARG_PTR_TO_NULL,
 	KF_ARG_PTR_TO_CONST_STR,
-	KF_ARG_PTR_TO_MAP,
+	KF_ARG_CONST_MAP_PTR,
 	KF_ARG_PTR_TO_TIMER,
 	KF_ARG_PTR_TO_WORKQUEUE,
 	KF_ARG_PTR_TO_IRQ_FLAG,
@@ -11388,8 +11393,11 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env, struct bpf_func_state *call
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
@@ -12137,19 +12145,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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
@@ -12165,6 +12169,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				}
 			}
 			fallthrough;
+		case KF_ARG_CONST_MAP_PTR:
 		case KF_ARG_PTR_TO_ITER:
 		case KF_ARG_PTR_TO_LIST_HEAD:
 		case KF_ARG_PTR_TO_LIST_NODE:
@@ -12371,12 +12376,16 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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
+			if (!reg->map_ptr) {
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

