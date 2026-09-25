Received: from mail-oa2-f41.google.com (mail-oa2-f41.google.com [74.125.231.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAD34F6497
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370800; cv=none; b=bpG6QXwnM+ejXgVK1no9V9sfOX74Y/9fsuDVbjB0EFucUnkrWTvxTQ/u9iWYibFmSGsHTZZndUWv02kRN39Hmw/B5fpG+ua+udQxtPEtPv31gaXBcCe5qcC0en92cqtmFM3xSpu+yAZ8Viwl4HTWoIcAP5zZCmsF8Tmux+f9h3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370800; c=relaxed/simple;
	bh=KmJiFMmf13fFeF9WzcbV5G33FM0y6iAPHtclALVEWOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzjy5DHnmkNe3gRHG4s3ikttTVe3CgwD4XX9wCN5jHoD9BQqmMvN8yhy02fRCUapqr52iveJt1XL1hthm26GgUe0XbJn498gQ3d+afIYycWl9mPudo9sid3vU5rKOzX+hXZ0uRM3UH8yqFlIVow4hEivpAXCFrT7o8+8cYR6jR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyTMTbn2; arc=none smtp.client-ip=74.125.231.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyTMTbn2"
Received: by mail-oa2-f41.google.com with SMTP id 586e51a60fabf-47bc923fe6aso912525fac.3
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 14:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790370797; x=1790975597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gs/r+9Mg/w2DlkIvVmlX0i06pz0zIxwgctzMjg5ixoU=;
        b=TyTMTbn27A0rO9CFcSLxabQUHOYRqeg/BYp3yM+RaIkOh7LPBKEYlfqsJO6v0QJmMi
         03MGqyfKtyQ5Q23Y9T6Gj/lRGZ9LzI2RJ4tp7g2dcZ2C4Gr3y+XWU6kz8cgSGFPkIxu6
         HgWFcdGxJvNSeI0UyBMEqEGBpWhTqOt+tG58cUnF/48Tr+sL/kblaHYU9y39fr8eaJ5h
         mRkIbicbJ3+mKn3/6HozJLST0yC8UuJOatfAvdJw/aSGqYC3rbFO9YjUDJeiqptR9bpi
         /U4QngFnf18mtA4MlD7EDbAO5Dx53MV/gdYx2v2srZS0KbqY4Jv1g7hlY6sDBIVBKInP
         KP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790370797; x=1790975597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gs/r+9Mg/w2DlkIvVmlX0i06pz0zIxwgctzMjg5ixoU=;
        b=mXIMPbbWP7MANvRx/3bz6E4wRI9xc+dov61Qlb7BLqzQEaJf4+oOsPBZ+Smo0oY7af
         J3XZeGrCPxDi1g5n+XJxDqNnRkcgyvFnLUcP8f432ewy+lECfczPrRgRXSKnCTuIP7ya
         aVMiZHDL+FJTLfvqnbpyfBjtoAIyYu+1cQja09UU4BVYuFCvU32+wtqI4MRb5dtpPN1h
         Hb1NPxTVNEYEDfxobbXtrFCeWOnrIjF9r873iK0P/T6Enp/UOEohLNxEasoZgHHweJS0
         kJhhnhhWVDpVpP/0miP0ZsVXzMUhQOVetZDnW1AXOxxdkZD3Jcy0bRE2yKLwMPhbLRsO
         2nbA==
X-Gm-Message-State: AFuF++l2vgnOoxAv25lfGtZH/iDkPFkhw1/PXWyE49SA8BVU9XljFuQD
	6H6TGQG9RkH8s5YGjaei//V77YK4r5Spa11VCRjtuJLGpVs3/wqo/NFn8BXG0w==
X-Gm-Gg: AYBFou36dV8E5ET1aA6FUDxxnOnKQaJ8ZiWssps1aJPNn59uoF+Uqck4pmstWGYtMPJ
	CPyN/5opf560HiPddl2cNCQFewnc86ewujwVjIwFC+y+zzHdM3193W1OC1Q/sQyd6o6m7N97Ztb
	f0f342nMrsQug4jM4qMzVqY+56ooR1cJ/axvwewX+SCN6ShIQGu3w4k2lTrHbl39aDlU3za2tuR
	T7nGg3Zpp2MAZTeG3n+eeV1jdVGkzx4OAUVTZopX4EsjgRi51n11SmzPl8qs73V2Ksl1lT6CR+F
	4tWRSP+BVMZjGMh3A5mdX93yWvhsvokBMfYytLQgIyVNyr7yy7wu3ib6sL9BdmdZZC6BfJjctm1
	EahvD+O8GC8kowW37JhyZmNte+01j3IAVIu/2lpMOoK8fVtGI05qBfQphYzYpaekVRFMv2LoHkg
	+TWqL1p6Qph3vUkLM5fWeRd6Fzm8Ee5gj9xS+FQQQJnXOqvdZ3OgTJ8eaxapFe+w==
X-Received: by 2002:a05:6871:87:b0:478:b8d8:2d5b with SMTP id 586e51a60fabf-491e7b772femr6501141fac.10.1790370797225;
        Fri, 25 Sep 2026 14:13:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:36::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-493356565b6sm3359736fac.9.2026.09.25.14.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 14:13:16 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 11/12] bpf: Check global subprog memory arguments in the common path
Date: Fri, 25 Sep 2026 14:12:55 -0700
Message-ID: <20260925211256.1834061-12-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260925211256.1834061-1-ameryhung@gmail.com>
References: <20260925211256.1834061-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Route fixed-size global ARG_PTR_TO_MEM arguments through
check_func_arg(). Preserve their read-write access check, nullable
contract, and support for BTF-defined allocated memory.

Recognize subprog calls explicitly in the common checker. Global
subprog stack liveness can prove that bytes in an argument are unused
by the callee. Retain the existing allowance for those poisoned stack
bytes when call metadata is present, and update the nullability log
expectation.

The verifier also rejects packet pointers when the callee may change
packet data, because the callee sees PTR_TO_MEM and cannot invalidate
packet bounds. Use pkt_changed from common call metadata to retain this
rule in the common fixed-memory path.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c                         | 57 +++++++++----------
 .../bpf/progs/verifier_global_ptr_args.c      |  3 +-
 .../bpf/progs/verifier_global_subprogs.c      |  2 +-
 3 files changed, 29 insertions(+), 33 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 212cada61aa6..97c125850c7a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7702,6 +7702,11 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 	return err;
 }
 
+static bool is_subprog(const struct bpf_call_arg_meta *meta)
+{
+	return meta->btf && !meta->func_id;
+}
+
 static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 			 argno_t argno, u32 mem_size, enum bpf_access_type access_type,
 			 struct bpf_call_arg_meta *meta, bool *known_memory)
@@ -7720,10 +7725,11 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 	}
 
 	/*
-	 * Only a global subprog (meta == NULL) may read poisoned stack slots:
+	 * Only a global subprog may read poisoned stack slots:
 	 * its static stack liveness proved the callee body skips them.
 	 */
-	size = (!meta && base_type(reg->type) == PTR_TO_STACK) ? -(int)mem_size : mem_size;
+	size = (is_subprog(meta) &&
+		base_type(reg->type) == PTR_TO_STACK) ? -(int)mem_size : mem_size;
 
 	if (access_type & BPF_READ)
 		err = check_helper_mem_access(env, reg, argno, size, BPF_READ, true, meta,
@@ -9047,8 +9053,8 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 		type &= ~PTR_MAYBE_NULL;
 	if (base_type(arg_type) == ARG_PTR_TO_MEM)
 		type &= ~DYNPTR_TYPE_FLAG_MASK;
-	/* Allow allocated memory for kfunc ARG_PTR_TO_MEM but not helper. */
-	if (is_kfunc(meta) && base_type(arg_type) == ARG_PTR_TO_MEM &&
+	/* Allow allocated memory for BTF-defined ARG_PTR_TO_MEM but not helpers. */
+	if (!is_helper(meta) && base_type(arg_type) == ARG_PTR_TO_MEM &&
 	    type_is_ptr_alloc_obj(type))
 		type = PTR_TO_MEM;
 
@@ -9678,6 +9684,17 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 					bpf_diag_reg_type_plain(env, reg->type));
 			return err;
 		}
+		/*
+		 * PTR_TO_PACKET gets passed as PTR_TO_MEM, preventing us from adjusting
+		 * bounds tracking information.
+		 */
+		if (is_subprog(meta) && meta->pkt_changed &&
+		    (reg_is_pkt_pointer_any(reg) || reg_is_dynptr_slice_pkt(reg))) {
+			verbose(env,
+				"cannot pass packet pointer %s to %s(): function may change packet data\n",
+				reg_arg_name(env, argno), meta->func_name);
+			return -EINVAL;
+		}
 		if (arg_type & MEM_ALIGNED)
 			err = check_ptr_alignment(env, reg, 0, arg_size, true);
 		break;
@@ -10817,6 +10834,9 @@ static void gen_subprog_arg_proto(const struct bpf_subprog_info *sub, const stru
 			arg_type = ARG_IGNORE;
 		} else if (base_type(arg_type) == ARG_PTR_TO_ARENA) {
 			arg_type |= PTR_MAYBE_NULL;
+		} else if (base_type(arg_type) == ARG_PTR_TO_MEM) {
+			proto->arg_size[arg] = sub->args[slot].mem_size;
+			arg_type |= MEM_FIXED_SIZE | MEM_WRITE;
 		} else if (base_type(arg_type) == ARG_PTR_TO_BTF_ID) {
 			proto->arg_btf_id[arg] = &sub->args[slot].btf_id;
 		}
@@ -10832,7 +10852,6 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 {
 	struct bpf_subprog_info *sub = subprog_info(env, subprog);
 	struct bpf_func_state *caller = cur_func(env);
-	struct bpf_verifier_log *log = &env->log;
 	const struct btf_param *args, *stack_args;
 	const struct btf_type *func, *func_proto;
 	struct bpf_func_proto *fn;
@@ -10874,7 +10893,6 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 	 * verifier sees.
 	 */
 	for (arg = 0, slot = 0; arg < btf_type_vlen(func_proto); arg++, slot += nslots) {
-		struct bpf_reg_state *reg = get_func_arg_reg(caller, regs, slot);
 		enum bpf_arg_type arg_type = fn->arg_type[arg];
 		argno_t argno = argno_from_arg(slot + 1);
 		const struct btf_type *t;
@@ -10886,34 +10904,11 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 		if (arg_type == ARG_SCALAR || arg_type == ARG_IGNORE ||
 		    arg_type == ARG_PTR_TO_CTX || arg_type == ARG_PTR_TO_DYNPTR ||
 		    base_type(arg_type) == ARG_PTR_TO_ARENA ||
-		    base_type(arg_type) == ARG_PTR_TO_BTF_ID) {
+		    base_type(arg_type) == ARG_PTR_TO_BTF_ID ||
+		    base_type(arg_type) == ARG_PTR_TO_MEM) {
 			ret = check_func_arg(env, arg, slot, 0, meta, env->insn_idx);
 			if (ret)
 				return ret;
-		} else if (base_type(arg_type) == ARG_PTR_TO_MEM) {
-			ret = check_func_arg_reg_off(env, reg, argno, ARG_PTR_TO_MEM);
-			if (ret < 0)
-				return ret;
-			if (check_mem_reg(env, reg, argno, sub->args[slot].mem_size,
-					  BPF_READ | BPF_WRITE, NULL,
-					  NULL))
-				return -EINVAL;
-			/*
-			 * PTR_TO_PACKET get passed as PTR_TO_MEM, preventing
-			 * us from adjusting bounds tracking info.
-			 */
-			if ((reg_is_pkt_pointer_any(reg) || reg_is_dynptr_slice_pkt(reg)) &&
-			    sub->changes_pkt_data) {
-				bpf_log(log, "%s is a packet pointer, but func#%d may change packet data\n",
-						reg_arg_name(env, argno), subprog);
-				return -EINVAL;
-			}
-			if (!(arg_type & PTR_MAYBE_NULL) &&
-			    (type_may_be_null(reg->type) || bpf_register_is_null(reg))) {
-				bpf_log(log, "%s is expected to be non-NULL\n",
-					reg_arg_name(env, argno));
-				return -EINVAL;
-			}
 		} else {
 			verifier_bug(env, "unrecognized %s type %d",
 				     reg_arg_name(env, argno), arg_type);
diff --git a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
index f639e2767e35..03507eeae3cb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
@@ -389,7 +389,8 @@ __weak int subprog_pkt_ptr_changes_data(struct __sk_buff *skb __arg_ctx,
 
 SEC("?tc")
 __failure __log_level(2)
-__msg("R2 is a packet pointer, but func#{{[0-9]+}} may change packet data")
+__msg("cannot pass packet pointer R2")
+__msg("function may change packet data")
 __msg("Caller passes invalid args into func#{{[0-9]+}} ('subprog_pkt_ptr_changes_data')")
 int pkt_ptr_to_global_mem_arg_changes_data(struct __sk_buff *skb)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index 27fbe54e8795..574b26b5a7df 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -195,7 +195,7 @@ int arg_tag_nonnull_ptr_good(void *ctx)
 
 SEC("?raw_tp")
 __failure __log_level(2)
-__msg("R1 is expected to be non-NULL")
+__msg("Possibly NULL pointer passed to trusted R1")
 int arg_tag_nonnull_ptr_null_bad(void *ctx)
 {
 	int y = 74;
-- 
2.52.0

