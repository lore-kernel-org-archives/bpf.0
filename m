Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15C535DA53
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 01:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019384; cv=none; b=oqZtKvNiyLbKOfyoIqzivjwqXDUhFVn4gWiwyYu5vxn3hXR85Fs8YkODzsiqbz5YsHhmZN+JzdLFU5glk/zhB4VRQst8AH4x48wYcO6g7JI63Wf8Pt250gAIvXB9nkpIVIEIV4wTd4N10M8nHhPtOXA4FucctILTay7JUm1E2VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019384; c=relaxed/simple;
	bh=9S1CRuBJ6X7KuqmsyeFFBi+WzmYyEkbp7icgKR5ToGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6btWxIIUTe0l1zgKFo3koL5iSZG3y/jEVwPrdpTt1FgXBmEUtpLj5iLUZDZxY9a1xPZP0Rhf5Sjvz+JnXEZpBFoZ837EIky3FzwX7E1cb8jB2VvPDS5Hif4dZWMbpOET9aJVH//0k3hWEi6TN3bw2FktYA1WU8U8JGpHzfNVt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7J4SS7Z; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7J4SS7Z"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ba4a1a0325so90841735ad.0
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 18:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019382; x=1780624182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQk8S1bAKDLPt7hM76oZRYV6tpBHe+7xVljDQXucAkU=;
        b=H7J4SS7Zefanh+oyi2AWsBhPWfUf2wO8cJ839AZshaTOg6SxCug835i41W+7tS8TCD
         6wqwA+0D2Qrqr5ucUIlyGe4+TXTPybX/N95w7pHVIJ5O56UNvd/qtgTrdZuRvFr29Is1
         EtWLSe9CQf/iEXj6++ir+9qxqryiWtvScniciEL7BhPFwGOds7srw1qMS3/ueEaTwvPE
         4GfxAvvQOcwPLxG9TqicF+Hi3obSEcz4knsmNRCtlutZmGeoXCy+XjSpUd7y1yEyveTc
         S4ClQTYA/mQJkEyp5Ln32S9bU00ifCZ27As4uZczKtvRgpNzCr8BBPbmQbTOKWHrhUre
         tNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019382; x=1780624182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VQk8S1bAKDLPt7hM76oZRYV6tpBHe+7xVljDQXucAkU=;
        b=hvVvWwpgSRdfLnKEVh/srqYsmdgGz7fBRIUiSAt5gFSwAfHyvPfKrnXved61XZxm27
         H5b3vyyVAklJf6l92zWN5OfC23vPJNHYvmwuYYHUA1bhRDe30hwHoFWXOPZKYWeBS5P+
         zqtKo49tc6f1H9spwYTQ1I6ueMxoKrtyh4pkfO+U+er0jLOcAI1yQMr7g4LKnJlcZNwn
         bVuLm4j+cvpfOSiynRJyeiPH3B3KBlWrTcy6qGDrsv5yT43wj2t+QxJYHFaQHV+Mw4Zh
         AaJS9y3hm6JmCp7gehZCL0ES8KmUvG4Pe1WT8rJ4JKAP81b7wzIZ9jutNHaAn6rFvV3R
         VrmA==
X-Gm-Message-State: AOJu0Yy5mhUgMab0roCzj1LaJ+pMThRpatarBpPVyyOar8H/kTf/w56v
	lleluCpq9IIv6BqB5YOnnbH10D3S8YMVyI15LjcTH9d4cg0QuaJynG5RAI955Q==
X-Gm-Gg: Acq92OG9zJWfIdCAZlHxLKWjk45XmDiSydA2Pdf+gCwnlehLEbOFvYikxoKql2563q8
	ZiSjUhjdzulfXZhqN6fZcp9ubDi2OAhujxwahAKzGmd5XmOKhgxdEKtTIdGl3iC44u6x3AEk0AT
	mvz5cPx85/sXNhY019TsItZZtexrutVRDLC0WmH2VyTjfCzRI2Lvsgx20PToggaUu/L+uSK3rMZ
	9ilXMpjMkm2FQ8etczh/07naq7YUkLHYFimlCjF2xjnjqNsWB0fYRsmnf6QmK6zzUrTCNmvIgCb
	E8TuMEVA54yzoKwQaMRnnJjHNuOGFSAvzImpE6DHJDsRmkjZU4ILfAzD0qe7GcTU9tB4t5XJfMv
	PimvBJGZv0pSRWLn56eFXKfL1y+ovxAenfIY6tT7TgY0vMfslblp1NlI8S3tsSnjIFC5ETN99hy
	1vE3Q9yXS0cVNP5Dfr25Su0LFN
X-Received: by 2002:a17:902:f541:b0:2b2:6df1:1112 with SMTP id d9443c01a7336-2bf20bd2b24mr10721375ad.40.1780019382097;
        Thu, 28 May 2026 18:49:42 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:58::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c2da36sm647625ad.69.2026.05.28.18.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:49:41 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 02/13] bpf: Unify dynptr handling in the verifier
Date: Thu, 28 May 2026 18:49:25 -0700
Message-ID: <20260529014936.2811085-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260529014936.2811085-1-ameryhung@gmail.com>
References: <20260529014936.2811085-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify dynptr checking for helper and kfunc by unifying it. Remember
the initialized dynptr (i.e.,g !(arg_type |= MEM_UNINIT)) pass to a
dynptr kfunc during process_dynptr_func() so that we can easily
retrieve the information for verification later. By saving it in
meta->dynptr, there is no need to call dynptr helpers such as
dynptr_id(), dynptr_ref_obj_id() and dynptr_type() in check_func_arg().

Remove and open code the helpers in process_dynptr_func() when
saving id, ref_obj_id, and type.

Besides, since dynptr ref_obj_id information is now pass around in
meta->bpf_dynptr_desc, drop the check in helper_multiple_ref_obj_use.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_verifier.h |  13 ++-
 kernel/bpf/verifier.c        | 178 +++++++----------------------------
 2 files changed, 40 insertions(+), 151 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5cbad3b64130..3a5c226bf1c3 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1438,6 +1438,13 @@ struct bpf_map_desc {
 	int uid;
 };
 
+/* The last initialized dynptr; Populated by process_dynptr_func() */
+struct bpf_dynptr_desc {
+	enum bpf_dynptr_type type;
+	u32 id;
+	u32 ref_obj_id;
+};
+
 struct bpf_kfunc_call_arg_meta {
 	/* In parameters */
 	struct btf *btf;
@@ -1478,16 +1485,12 @@ struct bpf_kfunc_call_arg_meta {
 	struct {
 		struct btf_field *field;
 	} arg_rbtree_root;
-	struct {
-		enum bpf_dynptr_type type;
-		u32 id;
-		u32 ref_obj_id;
-	} initialized_dynptr;
 	struct {
 		u8 spi;
 		u8 frameno;
 	} iter;
 	struct bpf_map_desc map;
+	struct bpf_dynptr_desc dynptr;
 	u64 mem_size;
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cddbdb4f78aa..d29846c4998a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -233,6 +233,7 @@ static void bpf_map_key_store(struct bpf_insn_aux_data *aux, u64 state)
 
 struct bpf_call_arg_meta {
 	struct bpf_map_desc map;
+	struct bpf_dynptr_desc dynptr;
 	bool raw_mode;
 	bool pkt_access;
 	u8 release_regno;
@@ -241,7 +242,6 @@ struct bpf_call_arg_meta {
 	int mem_size;
 	u64 msize_max_value;
 	int ref_obj_id;
-	int dynptr_id;
 	int func_id;
 	struct btf *btf;
 	u32 btf_id;
@@ -470,11 +470,6 @@ static bool is_ptr_cast_function(enum bpf_func_id func_id)
 		func_id == BPF_FUNC_skc_to_tcp_request_sock;
 }
 
-static bool is_dynptr_ref_function(enum bpf_func_id func_id)
-{
-	return func_id == BPF_FUNC_dynptr_data;
-}
-
 static bool is_sync_callback_calling_kfunc(u32 btf_id);
 static bool is_async_callback_calling_kfunc(u32 btf_id);
 static bool is_callback_calling_kfunc(u32 btf_id);
@@ -542,8 +537,6 @@ static bool helper_multiple_ref_obj_use(enum bpf_func_id func_id,
 		ref_obj_uses++;
 	if (is_acquire_function(func_id, map))
 		ref_obj_uses++;
-	if (is_dynptr_ref_function(func_id))
-		ref_obj_uses++;
 
 	return ref_obj_uses > 1;
 }
@@ -7215,8 +7208,9 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
  * use case. The second level is tracked using the upper bit of bpf_dynptr->size
  * and checked dynamically during runtime.
  */
-static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno, int insn_idx,
-			       enum bpf_arg_type arg_type, int clone_ref_obj_id)
+static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+			       argno_t argno, int insn_idx, enum bpf_arg_type arg_type,
+			       int clone_ref_obj_id, struct bpf_dynptr_desc *dynptr)
 {
 	int spi, err = 0;
 
@@ -7281,6 +7275,8 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 		}
 
 		if (reg->type != CONST_PTR_TO_DYNPTR) {
+			struct bpf_func_state *state = bpf_func(env, reg);
+
 			spi = dynptr_get_spi(env, reg);
 			if (spi < 0)
 				return spi;
@@ -7290,6 +7286,14 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 			 * in check_helper_call and mark_btf_func_reg_size in check_kfunc_call.
 			 */
 			mark_stack_slots_scratched(env, spi, BPF_DYNPTR_NR_SLOTS);
+
+			reg = &state->stack[spi].spilled_ptr;
+		}
+
+		if (dynptr) {
+			dynptr->type = reg->dynptr.type;
+			dynptr->id = reg->id;
+			dynptr->ref_obj_id = reg->ref_obj_id;
 		}
 	}
 	return err;
@@ -8059,72 +8063,6 @@ static int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	}
 }
 
-static struct bpf_reg_state *get_dynptr_arg_reg(struct bpf_verifier_env *env,
-						const struct bpf_func_proto *fn,
-						struct bpf_reg_state *regs)
-{
-	struct bpf_reg_state *state = NULL;
-	int i;
-
-	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++)
-		if (arg_type_is_dynptr(fn->arg_type[i])) {
-			if (state) {
-				verbose(env, "verifier internal error: multiple dynptr args\n");
-				return NULL;
-			}
-			state = &regs[BPF_REG_1 + i];
-		}
-
-	if (!state)
-		verbose(env, "verifier internal error: no dynptr arg found\n");
-
-	return state;
-}
-
-static int dynptr_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
-{
-	struct bpf_func_state *state = bpf_func(env, reg);
-	int spi;
-
-	if (reg->type == CONST_PTR_TO_DYNPTR)
-		return reg->id;
-	spi = dynptr_get_spi(env, reg);
-	if (spi < 0)
-		return spi;
-	return state->stack[spi].spilled_ptr.id;
-}
-
-static int dynptr_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
-{
-	struct bpf_func_state *state = bpf_func(env, reg);
-	int spi;
-
-	if (reg->type == CONST_PTR_TO_DYNPTR)
-		return reg->ref_obj_id;
-	spi = dynptr_get_spi(env, reg);
-	if (spi < 0)
-		return spi;
-	return state->stack[spi].spilled_ptr.ref_obj_id;
-}
-
-static enum bpf_dynptr_type dynptr_get_type(struct bpf_verifier_env *env,
-					    struct bpf_reg_state *reg)
-{
-	struct bpf_func_state *state = bpf_func(env, reg);
-	int spi;
-
-	if (reg->type == CONST_PTR_TO_DYNPTR)
-		return reg->dynptr.type;
-
-	spi = bpf_get_spi(reg->var_off.value);
-	if (spi < 0) {
-		verbose(env, "verifier internal error: invalid spi when querying dynptr type\n");
-		return BPF_DYNPTR_TYPE_INVALID;
-	}
-
-	return state->stack[spi].spilled_ptr.dynptr.type;
-}
-
 static int check_arg_const_str(struct bpf_verifier_env *env,
 			       struct bpf_reg_state *reg, argno_t argno)
 {
@@ -8482,7 +8420,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 					 true, meta);
 		break;
 	case ARG_PTR_TO_DYNPTR:
-		err = process_dynptr_func(env, reg, argno_from_reg(regno), insn_idx, arg_type, 0);
+		err = process_dynptr_func(env, reg, argno_from_reg(regno), insn_idx, arg_type, 0,
+					  &meta->dynptr);
 		if (err)
 			return err;
 		break;
@@ -9164,7 +9103,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			if (ret)
 				return ret;
 
-			ret = process_dynptr_func(env, reg, argno, -1, arg->arg_type, 0);
+			ret = process_dynptr_func(env, reg, argno, -1, arg->arg_type, 0, NULL);
 			if (ret)
 				return ret;
 		} else if (base_type(arg->arg_type) == ARG_PTR_TO_BTF_ID) {
@@ -10272,52 +10211,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			}
 		}
 		break;
-	case BPF_FUNC_dynptr_data:
-	{
-		struct bpf_reg_state *reg;
-		int id, ref_obj_id;
-
-		reg = get_dynptr_arg_reg(env, fn, regs);
-		if (!reg)
-			return -EFAULT;
-
-
-		if (meta.dynptr_id) {
-			verifier_bug(env, "meta.dynptr_id already set");
-			return -EFAULT;
-		}
-		if (meta.ref_obj_id) {
-			verifier_bug(env, "meta.ref_obj_id already set");
-			return -EFAULT;
-		}
-
-		id = dynptr_id(env, reg);
-		if (id < 0) {
-			verifier_bug(env, "failed to obtain dynptr id");
-			return id;
-		}
-
-		ref_obj_id = dynptr_ref_obj_id(env, reg);
-		if (ref_obj_id < 0) {
-			verifier_bug(env, "failed to obtain dynptr ref_obj_id");
-			return ref_obj_id;
-		}
-
-		meta.dynptr_id = id;
-		meta.ref_obj_id = ref_obj_id;
-
-		break;
-	}
 	case BPF_FUNC_dynptr_write:
 	{
-		enum bpf_dynptr_type dynptr_type;
-		struct bpf_reg_state *reg;
+		enum bpf_dynptr_type dynptr_type = meta.dynptr.type;
 
-		reg = get_dynptr_arg_reg(env, fn, regs);
-		if (!reg)
-			return -EFAULT;
-
-		dynptr_type = dynptr_get_type(env, reg);
 		if (dynptr_type == BPF_DYNPTR_TYPE_INVALID)
 			return -EFAULT;
 
@@ -10509,10 +10406,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return -EFAULT;
 	}
 
-	if (is_dynptr_ref_function(func_id))
-		regs[BPF_REG_0].dynptr_id = meta.dynptr_id;
-
-	if (is_ptr_cast_function(func_id) || is_dynptr_ref_function(func_id)) {
+	if (is_ptr_cast_function(func_id)) {
 		/* For release_reference() */
 		regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
 	} else if (is_acquire_function(func_id, meta.map.ptr)) {
@@ -10526,6 +10420,11 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		regs[BPF_REG_0].ref_obj_id = id;
 	}
 
+	if (func_id == BPF_FUNC_dynptr_data) {
+		regs[BPF_REG_0].dynptr_id = meta.dynptr.id;
+		regs[BPF_REG_0].ref_obj_id = meta.dynptr.ref_obj_id;
+	}
+
 	err = do_refine_retval_range(env, regs, fn->ret_type, func_id, &meta);
 	if (err)
 		return err;
@@ -12181,7 +12080,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				meta->release_regno = regno;
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_clone] &&
 				   (dynptr_arg_type & MEM_UNINIT)) {
-				enum bpf_dynptr_type parent_type = meta->initialized_dynptr.type;
+				enum bpf_dynptr_type parent_type = meta->dynptr.type;
 
 				if (parent_type == BPF_DYNPTR_TYPE_INVALID) {
 					verifier_bug(env, "no dynptr type for parent of clone");
@@ -12189,30 +12088,17 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				}
 
 				dynptr_arg_type |= (unsigned int)get_dynptr_type_flag(parent_type);
-				clone_ref_obj_id = meta->initialized_dynptr.ref_obj_id;
+				clone_ref_obj_id = meta->dynptr.ref_obj_id;
 				if (dynptr_type_refcounted(parent_type) && !clone_ref_obj_id) {
 					verifier_bug(env, "missing ref obj id for parent of clone");
 					return -EFAULT;
 				}
 			}
 
-			ret = process_dynptr_func(env, reg, argno, insn_idx,
-						  dynptr_arg_type, clone_ref_obj_id);
+			ret = process_dynptr_func(env, reg, argno, insn_idx, dynptr_arg_type,
+						  clone_ref_obj_id, &meta->dynptr);
 			if (ret < 0)
 				return ret;
-
-			if (!(dynptr_arg_type & MEM_UNINIT)) {
-				int id = dynptr_id(env, reg);
-
-				if (id < 0) {
-					verifier_bug(env, "failed to obtain dynptr id");
-					return id;
-				}
-				meta->initialized_dynptr.id = id;
-				meta->initialized_dynptr.type = dynptr_get_type(env, reg);
-				meta->initialized_dynptr.ref_obj_id = dynptr_ref_obj_id(env, reg);
-			}
-
 			break;
 		}
 		case KF_ARG_PTR_TO_ITER:
@@ -12843,7 +12729,7 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
 		}
 	} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_slice] ||
 		   meta->func_id == special_kfunc_list[KF_bpf_dynptr_slice_rdwr]) {
-		enum bpf_type_flag type_flag = get_dynptr_type_flag(meta->initialized_dynptr.type);
+		enum bpf_type_flag type_flag = get_dynptr_type_flag(meta->dynptr.type);
 
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 
@@ -12867,11 +12753,11 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
 			}
 		}
 
-		if (!meta->initialized_dynptr.id) {
+		if (!meta->dynptr.id) {
 			verifier_bug(env, "no dynptr id");
 			return -EFAULT;
 		}
-		regs[BPF_REG_0].dynptr_id = meta->initialized_dynptr.id;
+		regs[BPF_REG_0].dynptr_id = meta->dynptr.id;
 
 		/* we don't need to set BPF_REG_0's ref obj id
 		 * because packet slices are not refcounted (see
@@ -13057,7 +12943,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (meta.release_regno) {
 		struct bpf_reg_state *reg = &regs[meta.release_regno];
 
-		if (meta.initialized_dynptr.ref_obj_id) {
+		if (meta.dynptr.ref_obj_id) {
 			err = unmark_stack_slots_dynptr(env, reg);
 		} else {
 			err = release_reference(env, reg->ref_obj_id);
-- 
2.53.0-Meta

