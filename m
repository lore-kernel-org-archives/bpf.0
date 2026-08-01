Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D556D25D53B
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 07:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785570402; cv=none; b=kaBhIC/zJrJFU+6HBDIq8KKAV92s7r80qipBGYnI8XWVoNUCoMdKHRkAuVCo2B+ACq36//fJrO0VIgXtydOYI2GOarj0LmRaonHDfoPK0V1mQK0Gkv9ZcQ4LL0KgIhftGIhywBSAdYadd5F1HNelrNKXw4Pr6rejjnvqCQwKAgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785570402; c=relaxed/simple;
	bh=jFJ3rE6eUK8FC2tqDPuWVZY4hx3H/B85SvVLi+3yLRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o83+EBiAtSSPwiVQFpTbBvGtDevRs5XnIqIIDEzIgMC3Htqh7Rxu2mFRY7B0WZcRFZ4ImU5JOWqKsUtI9cM1cV57RO43+hjhMg0f8s4xzmAVXzWiZXWAxgx23Kuwtg+D0xoq7N3y450tn6G4t84C+dbbTI2ic0wlAIm16QJWnbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZi6ow1s; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZi6ow1s"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so1133873a91.0
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 00:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785570400; x=1786175200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1BQTyPWRTbXoS2SN63ZACqlOTGrWPyIBjikEROdr6cc=;
        b=bZi6ow1s0A71VlDipypeigtjPBlUiSvODfLnaYSYfx6ndjMh93Iet3iPC2MDTUtBYw
         8siJ3l6LA5ATpJwm3lfkQ2kJEl/WJxhj7UPrIRlzdn7xpKPeXesSPxF6iIbR9YHQO9hi
         sDf9fh2YWVEy0k60UrDAqKdfAouJQ+OkWOkgeizmYJpILSRLkXaKeI7WEN0yjTG8hs7j
         b3a5fToAHSBfacUH6j1VkOwW/izH8jP4rfASISEfauQdCG881ROwTdPPpWkeWM6I2bXE
         DTIvffTwPMsHGX0bbg9Rq7/ZMEygW9JLJBpnzKQv/6wACfi/hmZnF9bWzhHzs7IH4TBI
         vthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785570400; x=1786175200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1BQTyPWRTbXoS2SN63ZACqlOTGrWPyIBjikEROdr6cc=;
        b=rJkqwlhi59GojfPLlDI1Tfnb34obUuZ0NKlCOtSkuVASS9Sjy0Pl5P+/gkqHlf4uW9
         2rm5gmACHKEdwuqsZIfU9S5tU0K8uzN439Wgfdoa2l9Qzd2WuHYWszdj9GzWAu4OZ/wh
         SALDvmemHmRl2DA4JJrKmZhX06dpbv7N9TDKIdVx7OtlnkLg8EOnAC9h/JWzGO56rT32
         k4XB0NvOOBaTVm9E0PPADih2MuSY38HlO6JY5Bfb4AOmEN4zYbvxspR21XYpn4VgtpAo
         nKCqMd5vIS9sz1jp+THhbepSDj+RnbkBYy93lL4L4R8jprrkVl3wbr9fOZBDTrZBRB6U
         v7kw==
X-Gm-Message-State: AOJu0YzS5u+szKIzz1UyuWp+AHBxU+jPwIfKxvwzjwgxuutEW0P7x+Dy
	CYmGDX4leaYpe7NzKJmRQWPcax0zPVZlg3IsddbiEZSZTF/9L6Y1PipLjEoWNQ==
X-Gm-Gg: AR+sD11oRHiplpTik4hKUggw15k6u3uzve++iprDJ7Q7fLSNt+mImBVW16x8naFBqfo
	yEjtNraBC9dKM7Axm03hpnSWaN4CiFNThb0pQ+F3Pi9J+yHj5Lc5dIQl255PneVMvg/7nQVIlcn
	UiFB+I+43rOWtthO79qj/TkWz7KfpnruPeLtKNlD4Rnb6s+5ThtCwZZ7FjC7JslTT9G3YEa53d1
	0DuhoYvIfTlubV6NzmgytfwXXiuWT0eZiT68hmapC9FmM9sWa7/g9rls12hrnOCiB0s59FcBiFL
	WmIPY1zmTf+1vRNMn2CNfcFLOyKN7/XIbq2JJkQPagACRABAjGDJbaZYytD6xHuBxiiD4YrJL19
	Qua400XXRgn4kIaCG4ODburR7uJWoKxQZYlv3JiTEvE+Uo81YR3MYVfm8sm56VoQKBwfsRPZCfX
	DZgDcOraFAa9uUmYbwNsRfU8ZeEcKm9qh8O+TZZkiHLPGJjz/i1A==
X-Received: by 2002:a17:90b:5286:b0:38e:4e61:c9e with SMTP id 98e67ed59e1d1-38fbcafca0amr1878042a91.21.1785570400192;
        Sat, 01 Aug 2026 00:46:40 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2b1244bsm1657755a91.0.2026.08.01.00.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 00:46:39 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 03/18] bpf: Split kfunc map argument into __const_map and __map
Date: Sat,  1 Aug 2026 00:46:18 -0700
Message-ID: <20260801074633.1595644-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260801074633.1595644-1-ameryhung@gmail.com>
References: <20260801074633.1595644-1-ameryhung@gmail.com>
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

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
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
index 88b38db47de9..e472535bce85 100644
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
@@ -4643,17 +4643,17 @@ static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work
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
@@ -4661,17 +4661,17 @@ __bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct b
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
index cbc727cc84e3..15422e8d7e23 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10818,6 +10818,11 @@ static bool is_kfunc_arg_map(const struct btf *btf, const struct btf_param *arg)
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
@@ -11064,7 +11069,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_RB_NODE,
 	KF_ARG_PTR_TO_NULL,
 	KF_ARG_PTR_TO_CONST_STR,
-	KF_ARG_PTR_TO_MAP,
+	KF_ARG_CONST_MAP_PTR,
 	KF_ARG_PTR_TO_TIMER,
 	KF_ARG_PTR_TO_WORKQUEUE,
 	KF_ARG_PTR_TO_IRQ_FLAG,
@@ -11383,8 +11388,11 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env, struct bpf_func_state *call
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
@@ -12132,19 +12140,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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
@@ -12160,6 +12164,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				}
 			}
 			fallthrough;
+		case KF_ARG_CONST_MAP_PTR:
 		case KF_ARG_PTR_TO_ITER:
 		case KF_ARG_PTR_TO_LIST_HEAD:
 		case KF_ARG_PTR_TO_LIST_NODE:
@@ -12366,12 +12371,16 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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

