Received: from mail-oo2-f36.google.com (mail-oo2-f36.google.com [74.125.231.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C5F37C0E6
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621646; cv=none; b=jh7XBgKhiiaA1k37lCOPKZlbHGUd7O37g0T6r2PzcOt0coh1TYfDzDncqD347gePzYSmohKJVzy09pxEI4kxMWayhyBqHO6h4GUV6XK/hwbKRY7wucvM4IzdwZDOxGNA4es/kxr3CHfbSS7Qf+SctcJA4KZLhojz4btV2eqTPV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621646; c=relaxed/simple;
	bh=O7GCxgq/pY3LnesExSbdjtJVCJNv1V690HDE/atSPbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0dO/Ihqim3dDjymdv6ht8uosT9S8qV4cLvgJWyIdPjSPjjX9hKLj5ayAyAs3XFsRwHYEHSCw2uAgJeoELzx84TAJaP9xURVjsH2TVtApnkAYc7PR/RDtG92cargBVQkCxuo41zGlrkb1l8E1BowWY5hpnD86S63KvAjbsa4vuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wz1z2k/S; arc=none smtp.client-ip=74.125.231.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wz1z2k/S"
Received: by mail-oo2-f36.google.com with SMTP id 006d021491bc7-6d769a6fbe4so169168eaf.3
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621632; x=1791226432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UhzAQptal3G+ETurMu5M3pPLQUPYks+6Xzslu0tt0JA=;
        b=Wz1z2k/S9xCpaovcZ4FeucazV40nuNUwg4HYsav+MOG4OX51KCUzBRisvN+5e8TmXM
         aG3abNu1VtDet/hLjub2ArJs6xiGbvjDfVBALUCw8Y62NUdaHCptFHrNUyZu/e4bXFAI
         ic0vkHYdPvWCRea1d1fl2xHHVBQpa0zXJwr4mwU5u44TtQ405FPMTlZbdVbLKfeZO7aF
         MbtPfXMvXO3zhsdzZc4HK8ndGuJ485QVs+fnihjRYLgYK9ilpZMHO4RXr6EcmZhtbmCM
         MTiHfb08ziHjnrocJ0YMG98S3rOHWLPOuWJX53boKqSISPTF9gRGdzBJyir7/dC9tXsa
         iJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621632; x=1791226432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UhzAQptal3G+ETurMu5M3pPLQUPYks+6Xzslu0tt0JA=;
        b=JIcWQgS5oiZEaIYqUGlWug2MLis0lbtUgIFL160GwQuv6Bos62NGuqaJrwlzI8Q4iP
         JOrMKurjnjpXKskqOtWnUZz4UfT7/kZEvF2KVyF6ClZyQj9A3Ccip6M3KDDoKB4AHABB
         EJ9x4V8b1JqpO6DKQV+Xtrf2fSa4+PVXJTCVnR7fLJwrLcpB9SAMm4qmB+A7CzUcTliO
         ixt+OjsxWAfd5IgXksOesTsIgNrYCYr2ts5DuzeWayhXzD4XM9MWdApWIg+MlX/mhpYv
         BLYkliPAcCCsHcGhJO8c5XRexw0WEwAeTAz446u/48qMCwyuu9HfGjutptgxaxn0TRKf
         +z+g==
X-Gm-Message-State: AFuF++neMSiq6Cn/j5zoIFarGLuUXwRljx+xeS/EErUOfMXFcwUGM3lO
	j4HJqanA0+lmN5O+uuQEwFhWgMIBxi3/IDRh2/BrSScZzkKqIOUSTFiKBw/9FA==
X-Gm-Gg: AYBFou2jOdtFsBvQ3HGnS9AXw1WXlny7pd1BdgtM9uGm2hAWTvxRg6A2BW13NMpQJy7
	n9OO/5L5InHzLGZDERxBlC0bQ75Mwad8LsHzZkTzEoW88PEIwcahBEEa9UPqDxA1lUHgYIiTM13
	e4p0hAyQV6IfHoCzFfMybq6qW7Ml5/Vb4XHYa+ywuOQb+zYwwlmmkU1qSajwJxOuRkfKlt4N48N
	X/X0kLaZTW6dLv9exYFNp4JaSNJ5582IkdWpuNANo/wyDjE7vS+YDE/+efoPvIuZMninUn4yPBv
	iOC+y7bZEhzLN4SLnzRvJ16U0Z7axCKLDlw9gccKTuK9nnvjFKbNYBSKsSboDT96zQ9IiKzGW/x
	8Qendt9ye7Uchs/VA9pDwEVrkO34YGScrPqJZ7jUdo2e41JoKhfo4mzLFm+9s31xrxfyTUM4xnA
	8FxWWvdKhAavzsGCcRvswFeOPWMxbkSMD3sGA4WSaitxNCi3SBg6bfy2/NWko9TQ==
X-Received: by 2002:a05:6820:a0c:b0:6cd:3fdc:a936 with SMTP id 006d021491bc7-6d441d78911mr11963947eaf.83.1790621631833;
        Mon, 28 Sep 2026 11:53:51 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d8802f28b6sm5745045eaf.2.2026.09.28.11.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:53:51 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 11/11] bpf: Check all subprog arguments in the common path
Date: Mon, 28 Sep 2026 11:53:34 -0700
Message-ID: <20260928185334.1004200-12-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260928185334.1004200-1-ameryhung@gmail.com>
References: <20260928185334.1004200-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All supported BPF-subprogram argument types now pass through
check_func_arg() from one guarded branch in the legacy validation loop.
Replace that loop and its outgoing-stack validation with
check_func_args().

The scratch prototype is indexed by BTF parameter and the call metadata
carries the BTF function prototype. The existing BTF argument iteration
therefore maps parameters to ABI slots for both kfunc and BPF subprogram
calls, including additional slots occupied by by-value aggregates.

The common checker can return non-EFAULT errors other than -EINVAL, as
the existing BTF-ID path already did. This is compatible with subprog
call handling: only -EFAULT is fatal. Any other error marks BTF
unreliable. Static subprogs can then fall back to inline verification,
while global subprogs reject the call.

Remove the caller-register plumbing that the dedicated loop required.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 65 ++++++++-----------------------------------
 1 file changed, 11 insertions(+), 54 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ad18b6ab7e88..1599bac1bac9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10835,17 +10835,13 @@ static void gen_subprog_arg_proto(const struct bpf_subprog_info *sub, const stru
 	}
 }
 
-static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
-				    struct btf *btf,
-				    struct bpf_reg_state *regs)
+static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog, struct btf *btf)
 {
 	struct bpf_subprog_info *sub = subprog_info(env, subprog);
 	struct bpf_func_state *caller = cur_func(env);
-	const struct btf_param *args, *stack_args;
 	const struct btf_type *func, *func_proto;
 	struct bpf_call_arg_meta meta;
 	struct bpf_func_proto *fn;
-	u32 arg, slot, nslots;
 	int ret, err;
 
 	memset(&meta, 0, sizeof(meta));
@@ -10867,63 +10863,24 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 
 	func = btf_type_by_id(btf, env->prog->aux->func_info[subprog].type_id);
 	func_proto = btf_type_by_id(btf, func->type);
-	args = btf_params(func_proto);
-	stack_args = sub->arg_slot_cnt == btf_type_vlen(func_proto) ? args : NULL;
-	ret = check_outgoing_stack_args(env, caller, sub->arg_slot_cnt,
-					bpf_subprog_name(env, subprog), btf, stack_args);
-	if (ret)
-		return ret;
 
 	fn = &env->bpf_subprog_scratch;
 	gen_subprog_arg_proto(sub, btf, func_proto, fn);
 	meta.fn = fn;
 	meta.func_proto = func_proto;
 
-	/* check that BTF function arguments match actual types that the
-	 * verifier sees.
-	 */
-	for (arg = 0, slot = 0; arg < btf_type_vlen(func_proto); arg++, slot += nslots) {
-		enum bpf_arg_type arg_type = fn->arg_type[arg];
-		argno_t argno = argno_from_arg(slot + 1);
-		const struct btf_type *t;
-		u32 k;
-
-		t = btf_type_skip_modifiers(btf, args[arg].type, NULL);
-		nslots = btf_arg_slots(t);
-
-		if (arg_type == ARG_SCALAR || arg_type == ARG_IGNORE ||
-		    arg_type == ARG_PTR_TO_CTX || arg_type == ARG_PTR_TO_DYNPTR ||
-		    base_type(arg_type) == ARG_PTR_TO_ARENA ||
-		    base_type(arg_type) == ARG_PTR_TO_BTF_ID ||
-		    base_type(arg_type) == ARG_PTR_TO_MEM) {
-			ret = check_func_arg(env, arg, slot, 0, &meta, env->insn_idx);
-			if (ret)
-				return ret;
-		} else {
-			verifier_bug(env, "unrecognized %s type %d",
-				     reg_arg_name(env, argno), arg_type);
-			return -EFAULT;
-		}
-
-		for (k = 1; k < nslots; k++) {
-			ret = check_arg_extra_slot(env, caller, slot + k, &meta);
-			if (ret)
-				return ret;
-		}
-	}
-
-	return 0;
+	return check_func_args(env, &meta, env->insn_idx);
 }
 
-/* Compare BTF of a function call with given bpf_reg_state.
+/*
+ * Check that call-site argument states match a subprog's BTF signature.
+ *
  * Returns:
  * EFAULT - there is a verifier bug. Abort verification.
- * EINVAL - there is a type mismatch or BTF is not available.
+ * Other errors - there is a type mismatch or BTF is not available.
  * 0 - BTF matches with what bpf_reg_state expects.
- * Only PTR_TO_CTX and SCALAR_VALUE states are recognized.
  */
-static int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
-				  struct bpf_reg_state *regs)
+static int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog)
 {
 	struct bpf_prog *prog = env->prog;
 	struct btf *btf = prog->aux->btf;
@@ -10940,7 +10897,7 @@ static int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
 	if (prog->aux->func_info_aux[subprog].unreliable)
 		return -EINVAL;
 
-	err = btf_check_func_arg_match(env, subprog, btf, regs);
+	err = btf_check_func_arg_match(env, subprog, btf);
 	/* Compiler optimizations can remove arguments from static functions
 	 * or mismatched type can be passed into a global function.
 	 * In such cases mark the function as unreliable from BTF point of view.
@@ -10959,7 +10916,7 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	int err;
 
 	caller = state->frame[state->curframe];
-	err = btf_check_subprog_call(env, subprog, caller->regs);
+	err = btf_check_subprog_call(env, subprog);
 	if (err == -EFAULT)
 		return err;
 
@@ -11096,7 +11053,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EFAULT;
 
 	caller = state->frame[state->curframe];
-	err = btf_check_subprog_call(env, subprog, caller->regs);
+	err = btf_check_subprog_call(env, subprog);
 	if (err == -EFAULT)
 		return err;
 	if (bpf_subprog_is_global(env, subprog)) {
@@ -11233,7 +11190,7 @@ static int check_func_callx(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	/* PTR_TO_FUNC is a pointer to a static subprog */
 	subprog = reg->subprogno;
-	err = btf_check_subprog_call(env, subprog, caller->regs);
+	err = btf_check_subprog_call(env, subprog);
 	if (err == -EFAULT)
 		return err;
 
-- 
2.52.0

