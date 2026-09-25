Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDE34F648C
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370797; cv=none; b=ZwPMah09OrQXdZGkRQkMeABAYtL0QEoJBc2eHAizQU0Og2hpyopB/ZoJDn6HNzgrVpOUza/7bDgRrEnrDE+Vn1/5CrSLV8pyDisOCzcEHgUOCiZv8CnYzCiodxaK5J1LeDlQT3le7arMA3YvChDof+vmoqDBf44VBkVDYNLnLr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370797; c=relaxed/simple;
	bh=lnyJFdWjY8dJE2bLPls3s2PgFt1cY7yOA7Ngax+WQwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjkMdjLjHEKO+XKXdZZ1IEx2o5CCcz4QAbS/EP8XAvnZ1cOPnNfgec0PugmMb7/+bBpubLGRJnqW2HqBEPSdvqH3xEBBNOIGfhOpwLsseMKX813yPtF2qW1Yl3Jx/9EI1yvULgdc+wYypppNQBQhpAO6UsafZ9nE7GLrhJ8uT8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNqLWLp2; arc=none smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNqLWLp2"
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-7f4f0c89e34so867635a34.1
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 14:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790370795; x=1790975595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xe8K1EtzUBBT0HxlYBDLVVvtcpUdkw0xGvdNTDAetgU=;
        b=LNqLWLp2PFYzLyrLMCAUFljieMclkngHZdLZnKONBFEdpzPbjtt6+LaUnnQsINWx6a
         vT6UqjnjMKuJxOuxc/jlPE2w6ykD+xeVGtEf6ihbk0XIuRBCD4C17GV0irjnegbkgZLi
         a9NWRsC1BWAoCqNhMUGYNatkmwO6r9/1mC7OjHNWPZaoPnEl0PBvftKUXS1kHB27A7rY
         KbS/v55xpePLMczDcskE/CX5LyDkdkYrqHpC6J7sz5bya2yrzN6CMihfdbQnQPAMfbIW
         V4UoaJnCIYez4h/w9Mba1D/X0T61VDI92f5iCQjwlRH3lkMJjDKFfb0nU6oHizyVBN6W
         5cYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790370795; x=1790975595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xe8K1EtzUBBT0HxlYBDLVVvtcpUdkw0xGvdNTDAetgU=;
        b=Vu4oTozHtwMS3Vk7IfUI2ygizjmshUPDq1vQE4BPjpK/RGucLiZt1sN/ce/vASIJCp
         WOog6b6u/eO76nC1A+XPnBQdngrNEi+JQ9cscMJtT04Kig7PQcY/6fU/pxWJs2pjm2N3
         1LZbF6QsxZPR1PTq4szbT2THNzs/jeuJj3FAQo3Ipve/XXELRSz5SEdbZ1ZNcOrIQBiY
         INJo99EpzTzeoQd+OvofJ2pYcPqMyg6a/zI1aP5DdLcLA9VnPq1ql05SrATTYRGoetaW
         zxipam3f/cTsFJlKZqxqCrgNVZNIXss476F5Ggjmw5t3ShvUPv5bTktIFehkPNVuT0JG
         rhAQ==
X-Gm-Message-State: AFuF++kH3kDv+aEKt4+0mGhR2xsDMin/2ErCSjUAfT26ZySst8IoOf9Y
	9XUk+fXwqCQJHV6rRjM2uOie8uN1NH8CPvoZI8bK56i/qkVXynPxd0bQHgpczw==
X-Gm-Gg: AYBFou33w3vM0B9ofJb66JnnYb2VY8klRQVD6ocA9e1RhVnmI9ABw3Q/ZLSKWmqLr5H
	H8biMJ5d7aa48E1qCO8pKrhOvoezNvGGM5vHP/dV5dCO7E+qm6n52IKBR5j9n2ytg/p8A7V45AM
	ysgGJlEOcQD9KkRabwBUaBGm6CU5IPbQWKhBIpurs3paW2yMyzeTbTHYUMk9/GXjIBZ6uAUudwi
	tg7eXpq8BJC95Lhw0RC+Mjy0LalbagGcJPcwgZGPOzE5gM/21+v2GSc86bWn19Sb9aNxTIoNsY5
	k0f0Spzz+X380mXnw04a1skVqhgdgQK34Jw4hyYdBu6Ld10b8tKXxByOK5c0ZFvd+V9aHlsEz0J
	wpikX61B36nktPfNajE6vUW9ovcJPni3eemTgc+on7MwHmdRvZ62kBWAOtFHAZKvSG799+WhjMD
	teaNJnmJkB5Vv+11hseEy04zSa5reHo61wxPK4/57gitVn2x5KZ32CSFuX7Ta59A==
X-Received: by 2002:a05:6830:621c:b0:802:4cf7:ea46 with SMTP id 46e09a7af769-81782a86ed9mr8600940a34.20.1790370795103;
        Fri, 25 Sep 2026 14:13:15 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2c::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-818e98a06b6sm3716273a34.25.2026.09.25.14.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 14:13:13 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 10/12] bpf: Track packet changes in call metadata
Date: Fri, 25 Sep 2026 14:12:54 -0700
Message-ID: <20260925211256.1834061-11-ameryhung@gmail.com>
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

Helper, kfunc, and global subprog calls each determine whether a call
can invalidate packet pointers, but carry the result through
call-specific variables or look it up again where packet state is
cleared.

Record the effect in bpf_call_arg_meta. Initialize it from the helper
or kfunc identity and from the subprog propagated changes_pkt_data
flag. Keep the dynptr helper backing-type refinement and tail-call
handling on the common field, then have all three call paths clear
packet pointers from it.

No functional change is intended.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 54 +++++++++++++++++++-----------------
 2 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 144da990ee8c..590ac30a5691 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1640,6 +1640,7 @@ struct bpf_call_arg_meta {
 	u32 func_id;
 	const struct bpf_func_proto *fn;
 	const struct btf_type *func_proto;
+	bool pkt_changed;
 	u8 release_regno;
 	u32 ret_btf_id;
 	u32 subprogno;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 73a1c4877427..212cada61aa6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10827,22 +10827,22 @@ static void gen_subprog_arg_proto(const struct bpf_subprog_info *sub, const stru
 }
 
 static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
-				    struct btf *btf,
-				    struct bpf_reg_state *regs)
+				    struct btf *btf, struct bpf_reg_state *regs,
+				    struct bpf_call_arg_meta *meta)
 {
 	struct bpf_subprog_info *sub = subprog_info(env, subprog);
 	struct bpf_func_state *caller = cur_func(env);
 	struct bpf_verifier_log *log = &env->log;
 	const struct btf_param *args, *stack_args;
 	const struct btf_type *func, *func_proto;
-	struct bpf_call_arg_meta meta;
 	struct bpf_func_proto *fn;
 	u32 arg, slot, nslots;
 	int ret, err;
 
-	memset(&meta, 0, sizeof(meta));
-	meta.btf = btf;
-	meta.func_name = bpf_subprog_name(env, subprog);
+	memset(meta, 0, sizeof(*meta));
+	meta->btf = btf;
+	meta->pkt_changed = sub->changes_pkt_data;
+	meta->func_name = bpf_subprog_name(env, subprog);
 
 	ret = btf_prepare_func_args(env, subprog);
 	if (ret) {
@@ -10867,8 +10867,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 
 	fn = &env->bpf_subprog_scratch;
 	gen_subprog_arg_proto(sub, btf, func_proto, fn);
-	meta.fn = fn;
-	meta.func_proto = func_proto;
+	meta->fn = fn;
+	meta->func_proto = func_proto;
 
 	/* check that BTF function arguments match actual types that the
 	 * verifier sees.
@@ -10887,7 +10887,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 		    arg_type == ARG_PTR_TO_CTX || arg_type == ARG_PTR_TO_DYNPTR ||
 		    base_type(arg_type) == ARG_PTR_TO_ARENA ||
 		    base_type(arg_type) == ARG_PTR_TO_BTF_ID) {
-			ret = check_func_arg(env, arg, slot, 0, &meta, env->insn_idx);
+			ret = check_func_arg(env, arg, slot, 0, meta, env->insn_idx);
 			if (ret)
 				return ret;
 		} else if (base_type(arg_type) == ARG_PTR_TO_MEM) {
@@ -10921,7 +10921,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 		}
 
 		for (k = 1; k < nslots; k++) {
-			ret = check_arg_extra_slot(env, caller, slot + k, &meta);
+			ret = check_arg_extra_slot(env, caller, slot + k, meta);
 			if (ret)
 				return ret;
 		}
@@ -10938,7 +10938,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
  * Only PTR_TO_CTX and SCALAR_VALUE states are recognized.
  */
 static int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
-				  struct bpf_reg_state *regs)
+				  struct bpf_reg_state *regs,
+				  struct bpf_call_arg_meta *meta)
 {
 	struct bpf_prog *prog = env->prog;
 	struct btf *btf = prog->aux->btf;
@@ -10955,7 +10956,7 @@ static int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
 	if (prog->aux->func_info_aux[subprog].unreliable)
 		return -EINVAL;
 
-	err = btf_check_func_arg_match(env, subprog, btf, regs);
+	err = btf_check_func_arg_match(env, subprog, btf, regs, meta);
 	/* Compiler optimizations can remove arguments from static functions
 	 * or mismatched type can be passed into a global function.
 	 * In such cases mark the function as unreliable from BTF point of view.
@@ -10970,11 +10971,12 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 			      set_callee_state_fn set_callee_state_cb)
 {
 	struct bpf_verifier_state *state = env->cur_state, *callback_state;
+	struct bpf_call_arg_meta meta;
 	struct bpf_func_state *caller, *callee;
 	int err;
 
 	caller = state->frame[state->curframe];
-	err = btf_check_subprog_call(env, subprog, caller->regs);
+	err = btf_check_subprog_call(env, subprog, caller->regs, &meta);
 	if (err == -EFAULT)
 		return err;
 
@@ -11100,6 +11102,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			   int *insn_idx)
 {
 	struct bpf_verifier_state *state = env->cur_state;
+	struct bpf_call_arg_meta meta;
 	struct bpf_func_state *caller;
 	int err, subprog, target_insn;
 	u32 i, nregs;
@@ -11111,7 +11114,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EFAULT;
 
 	caller = state->frame[state->curframe];
-	err = btf_check_subprog_call(env, subprog, caller->regs);
+	err = btf_check_subprog_call(env, subprog, caller->regs, &meta);
 	if (err == -EFAULT)
 		return err;
 	if (bpf_subprog_is_global(env, subprog)) {
@@ -11154,7 +11157,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				subprog, sub_name);
 		sub_aux->called[in_sleepable_context(env)] = true;
 		returns_void = subprog_returns_void(env, subprog);
-		if (env->subprog_info[subprog].changes_pkt_data)
+		if (meta.pkt_changed)
 			clear_all_pkt_pointers(env);
 		if (returns_void)
 			bpf_diag_record_scrub(env, &caller->regs[BPF_REG_0], BPF_DIAG_MOD_CALLER_SAVED);
@@ -11212,6 +11215,7 @@ static int check_func_callx(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    int *insn_idx)
 {
 	struct bpf_func_state *caller = cur_func(env);
+	struct bpf_call_arg_meta meta;
 	struct bpf_reg_state *reg;
 	const char *reason;
 	int err, subprog;
@@ -11247,7 +11251,7 @@ static int check_func_callx(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	/* PTR_TO_FUNC is a pointer to a static subprog */
 	subprog = reg->subprogno;
-	err = btf_check_subprog_call(env, subprog, caller->regs);
+	err = btf_check_subprog_call(env, subprog, caller->regs, &meta);
 	if (err == -EFAULT)
 		return err;
 
@@ -12111,7 +12115,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	struct bpf_call_arg_meta meta;
 	const char *operation;
 	int insn_idx = *insn_idx_p;
-	bool changes_data;
 	int i, err, func_id;
 
 	/* find function prototype */
@@ -12153,15 +12156,15 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return -EINVAL;
 	}
 
+	memset(&meta, 0, sizeof(meta));
+	meta.pkt_changed = bpf_helper_changes_pkt_data(func_id);
+
 	/* With LD_ABS/IND some JITs save/restore skb from r1. */
-	changes_data = bpf_helper_changes_pkt_data(func_id);
-	if (changes_data && fn->arg1_type != ARG_PTR_TO_CTX) {
+	if (meta.pkt_changed && fn->arg1_type != ARG_PTR_TO_CTX) {
 		verifier_bug(env, "func %s#%d: r1 != ctx", func_id_name(func_id), func_id);
 		return -EFAULT;
 	}
 
-	memset(&meta, 0, sizeof(meta));
-
 	err = check_func_proto(env, fn, &meta);
 	if (err) {
 		verifier_bug(env, "incorrect func proto %s#%d", func_id_name(func_id), func_id);
@@ -12332,7 +12335,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			/* this will trigger clear_all_pkt_pointers(), which will
 			 * invalidate all dynptr slices associated with the skb
 			 */
-			changes_data = true;
+			meta.pkt_changed = true;
 
 		break;
 	}
@@ -12617,11 +12620,11 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 				return err;
 			env->insn_idx--;
 		} else {
-			changes_data = false;
+			meta.pkt_changed = false;
 		}
 	}
 
-	if (changes_data)
+	if (meta.pkt_changed)
 		clear_all_pkt_pointers(env);
 	return 0;
 }
@@ -14753,6 +14756,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	}
 	if (err)
 		return err;
+	meta.pkt_changed = bpf_is_kfunc_pkt_changing(&meta);
 	desc_btf = meta.btf;
 	func_name = meta.func_name;
 	insn_aux = &env->insn_aux_data[insn_idx];
@@ -15180,7 +15184,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
-	if (bpf_is_kfunc_pkt_changing(&meta))
+	if (meta.pkt_changed)
 		clear_all_pkt_pointers(env);
 
 	proto_slots = kfunc_abi_slots(&desc->func_model);
-- 
2.52.0

