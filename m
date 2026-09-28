Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C011637F00B
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 18:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619277; cv=none; b=BzyXy0ofPy2K1eRIrptxoXdQDI8IfW0t4SDY8KRq3qDuYXVspu0mlVxm0pYnRSyQjniA5eV4SquAOR7hDMGJn6bAwyFFFVctVlbj2jMMLYFZTALPm4LgXbkIXc04Px3g+pdMKQuvsR9w7LsM3Ajep/YZx4rF3OzCXSbtyY/mzNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619277; c=relaxed/simple;
	bh=m6resj3DyUH1+3P3dcjqGi0bjuUdw4tqQtXXyL2vbWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHRA8yGPniy3WMbVwksbLwi66ApmF6fUtXL+Ma3BeGSoP9es8JTUKLG+amDSrpnO+WISkA8FKc6m6avqJmLKU4LjCEv6SNM6O/kVUCHbveoeh8xlGp7lAiv7GJVJg57Pg1RpyySHtN+eOJyY/H24eWeXmKN0td9HmF+VwcDp+AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USHTNuMd; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USHTNuMd"
Received: by mail-oo2-f39.google.com with SMTP id 46e09a7af769-8144632e066so1825249a34.0
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790619274; x=1791224074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zom1IlWYLrV3nhDzjm+zQNROCI0EkpCcZmypS3/lUdw=;
        b=USHTNuMd39JhNGeodkI7Xfth3S/USOiQHbDlsXMYuGJeSm2XR30FbZkpD+lZ88cS3h
         uml42WaS3Sw+B4ILmviypPAAI6WvAkZOAIutAw6B/jbtzIBj5oNAh7+65+IT3ZjsrnyB
         YZUtAXlbBSVqu9WKoL5FrkZCeGQfJqe4DT0TvKs/ZNkbrg4AtnkdMHMXOjd7HFvJ7XmF
         0hgP8b+fwro71/luV3bvPWEGCqq/tC7IaXK0MY2WPbnLE+4ByE3kciIVKlzDvK84eqWr
         yWx2oZlBjr8l2lcraO/c591qvdRfhYtJpKaEWfUgoy9yJx6HMVwmhD7GniKp4329wZsh
         LurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619274; x=1791224074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zom1IlWYLrV3nhDzjm+zQNROCI0EkpCcZmypS3/lUdw=;
        b=N0uWPiQ0WFl19hzowarDZvXOqNSTFEHlVv0jajz/3aMZZuf1c06Ar1kiEOcuKW6jdQ
         OKCo4FbazBQaP6cc8vi/r5k+X7z13CI9qmdogCmYdBOdPitJYzUjcrdwowkUImqUzUzr
         sGcy3snmBpc0itX5+h/U0pzVVRxTCjBFE2I3XR0DO+SldfMFJyo70RLSPD8rpb0G8Vpb
         Ah3y5USyVwk5SYXl2SvVvyzRkwzJq/G5/TlsQOIdkE5IGZzrd0H9aiBaFPZxCep51fz1
         cADeQ0ZaVtd4IynuvW91JIcEaHW0rMDV529Yk+b+wEqlfCbzkoXjpt9f5BMMp9MjBvId
         oxgA==
X-Gm-Message-State: AFuF++kq4NDg6tmOvkm39ngpiZlz9oroWmS0230JACgpOh2PC2Q2IfNl
	mOcOQkL6EAIjBNN/l9deLKUpWDsirAQB+zJrssuJaqDsAL2FKE3+/MT5hfOAgg==
X-Gm-Gg: AYBFou2Xk09jVEo8MmcbcK+SXcEUKObnT8JnkQAnuaVOpICmSRfXWemodobr0dUsual
	AG6bEnZKUyGvMHC/1eZPLuYB7TB3c2gdPnZE+R7NAvGVRNR3jrfxDW5iV6X994JAqKa7i5pcHQY
	dGw3/8XdEVahKuZgaN/G0+2TKIoq7lij4XF4D3Zu8qkhCYOpwOF8OUFeM6HJmiGyXh8NX1EJsjE
	XB4FXF9w4YG+YV9CcDYLO+7G13/xd9s8EJR1ZtXZahGI1asOuFWVnugdXKXkgR0tzENq0fq9Owx
	qG3H3op1P2EGdhQChMpTr409TfOvRqAEkS4Q1d7YBbcr2nIGAnNpnexIOa9fZzR4GLokEsgj7Er
	852I6QVHHRCEwVx8UahYwm7ya1AuC1D0OIvMhsbE4SGi1Jq96gQUVz5xOpJOwVP7GLvK/Qev5FP
	8RyRqqgNz7H7C5i4Wg7hRCpLyBLPVf4NPoUIliN0wKx9HzZ0+rBZC9ALl+1/J0ig==
X-Received: by 2002:a4a:e90c:0:b0:6c9:d43e:a703 with SMTP id 006d021491bc7-6d43f4bf666mr13468497eaf.33.1790619274389;
        Mon, 28 Sep 2026 11:14:34 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:51::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d882bd143asm6158238eaf.8.2026.09.28.11.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:14:34 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 11/11] bpf: Check all subprog arguments in the common path
Date: Mon, 28 Sep 2026 11:14:13 -0700
Message-ID: <20260928181414.644158-12-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260928181414.644158-1-ameryhung@gmail.com>
References: <20260928181414.644158-1-ameryhung@gmail.com>
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
index 2142610ce503..1a0a11a4894f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10846,17 +10846,13 @@ static void gen_subprog_arg_proto(const struct bpf_subprog_info *sub, const stru
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
@@ -10878,63 +10874,24 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 
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
@@ -10951,7 +10908,7 @@ static int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
 	if (prog->aux->func_info_aux[subprog].unreliable)
 		return -EINVAL;
 
-	err = btf_check_func_arg_match(env, subprog, btf, regs);
+	err = btf_check_func_arg_match(env, subprog, btf);
 	/* Compiler optimizations can remove arguments from static functions
 	 * or mismatched type can be passed into a global function.
 	 * In such cases mark the function as unreliable from BTF point of view.
@@ -10970,7 +10927,7 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	int err;
 
 	caller = state->frame[state->curframe];
-	err = btf_check_subprog_call(env, subprog, caller->regs);
+	err = btf_check_subprog_call(env, subprog);
 	if (err == -EFAULT)
 		return err;
 
@@ -11107,7 +11064,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EFAULT;
 
 	caller = state->frame[state->curframe];
-	err = btf_check_subprog_call(env, subprog, caller->regs);
+	err = btf_check_subprog_call(env, subprog);
 	if (err == -EFAULT)
 		return err;
 	if (bpf_subprog_is_global(env, subprog)) {
@@ -11243,7 +11200,7 @@ static int check_func_callx(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	/* PTR_TO_FUNC is a pointer to a static subprog */
 	subprog = reg->subprogno;
-	err = btf_check_subprog_call(env, subprog, caller->regs);
+	err = btf_check_subprog_call(env, subprog);
 	if (err == -EFAULT)
 		return err;
 
-- 
2.52.0

