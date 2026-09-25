Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3255C36655C
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 21:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370801; cv=none; b=p03Tcb2pFIsaVxtW6AN30XbdRnAcxsOvPBibBwpGFF3DFWOJNhWV77OvsPUp6/pcQhFPlFCohNrL/PUzBIrcli10qu4wC/G0H7aJZB4WxPOj4Dm8jaHNESMFTIp8V5UP21ez+c2mWI5tbctVSemCFpLwLrqWKfnGDYHyZpZfA2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370801; c=relaxed/simple;
	bh=KpQN+HkidCWCvmNCbyDrRHHsqEVvRLDdixQzAUQW2kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZrQ+usRMoWN4ZCuBGtkrg74l+uVSHnoljEbff4jq5eJyiZH5mAXHrCwoI5xC5hblczFk1tV5kLB7vE6849mmqZDh4T0jc3RSp8Mi16YphSSM+O2Wg64KdVF+6rqUVfewbwrthUGcZJgXPtVeChGHShUYvjsgdmjKElGZM31o6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVqCQ7K0; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVqCQ7K0"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc9b4b63so219794fac.1
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 14:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790370799; x=1790975599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=INnaRrLw2QWrEpuY8HKp5yyV0O3IO1hRUT9DlKA6d8U=;
        b=EVqCQ7K0A8jQjF6svNjCdB8+Ck5usqtKpiTtExxu+v3Z3XPpgTq/1IJUQK8tdC1Uee
         LlmUvRzHQavIPqNmJI3jpFJ1Kd0uL4CoAtOnYV3RoyD0gJpMZfT5spMuoX1uSHuGoV/H
         7qqY/FW2iBkjGh1rA/oPC5Gm5uRDv7ziCVvLIXHBRXpyGEg8B92x7iZny69mBBWwGcgn
         TrmasGDAj2c347GdgBXD3cyh/gHvnGge4eioMgzTcZDEm58eYuKH1Q7dBnmulMU4PL5M
         Qo78blCPwihHYN0HG+2iJfAhguzj9hoFoKv7lMPcMM2NI/vRULifn29s/uzsuAHCUzIO
         yyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790370799; x=1790975599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=INnaRrLw2QWrEpuY8HKp5yyV0O3IO1hRUT9DlKA6d8U=;
        b=NZB4tnk5tGAbY/K2sKE7udTfOajV5Hq6l2BTDy/aP21Hkyvx82undkkZGmxfi7hqKF
         WkSF2wHsohy4E4ISLV4DqQ87pKDKj/BsC4oYpc7UkFXNQ99qQhY2mC88dkfT93Zv/5f2
         NhD5uVNv0mRNPEN6uq7M4H5O3sQiOC+p7WWO4sRopGhzeraO8vmBu60Px69fCKTwESuU
         RW+x8BEYHKIzWuTcum4AK0Li5oVS7Ss/F9xCHTjFOGmJ/67JcT3gzmp843T+lKxYsHms
         isP6+Wxsm7GsGPh/2n73Q0piaYmB44uTySwijI6wLbRrlNPlf40TGabHstzvQDnmiD7d
         BreA==
X-Gm-Message-State: AFuF++mUHSLwKxw0ozgT4ENQwyxfwgV+wnbpGNQy2icASTjM7CNRlbkf
	eomJK+KE9dfx8Dfh4B2N5YzfZHGElge8nVABqM0FJ6zJwMH02zG2ho3ehNi2Fw==
X-Gm-Gg: AYBFou2nkrKjE9Vs7eNSXbnb3EqLuZCBkRpSkpXxgPDaPkrLuTVKG1eU8h1YY/xH4/S
	EcnGFvzzTVe5Esuq+Y+SF3A8+ZKL4ec4g/l6Fz02yQ2GFI34eje/ewb/zPDkcn1Of2J7qMTKOLI
	cIIkdpsXge9ReQlofd3KJgHJdUT58PIotUPtit65v/grk8IT+Aw946XHhHT5rHDpkb0u+EZYvFC
	AwnTpGuIzeJR0hCGij7ORb3N5GRB7CNmUirnzfhFA5fqs1kcF8Zhm/8T62rsm33jIysHXf9mg/4
	vpaNWbjXapY3DwavFDy3GU+Y2sOzq2jyyuQRdgTlhwOjfgQ7KFjvcCmwf7E+rVxfXgIF+Dl+Zru
	vGm/3QdZhORzvcYYSZFj/u9iPsjsAEX1mbqz+XSFR9THkdsPiLGIjmdeW19TXvugaqgbeVZxIhI
	TgpYZ+iQVsA8GIUhaPbfypsslejEIXnKvU2Hug3xPhD+zWFf03MICbV4XTJWeObQ==
X-Received: by 2002:a05:6808:1b91:b0:4a3:cea7:4ab6 with SMTP id 5614622812f47-4d72ae5a4cemr5821830b6e.10.1790370799042;
        Fri, 25 Sep 2026 14:13:19 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:59::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4dbfa747bc9sm2883131b6e.15.2026.09.25.14.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 14:13:18 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 12/12] bpf: Check all subprog arguments in the common path
Date: Fri, 25 Sep 2026 14:12:56 -0700
Message-ID: <20260925211256.1834061-13-ameryhung@gmail.com>
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
 kernel/bpf/verifier.c | 62 +++++++------------------------------------
 1 file changed, 10 insertions(+), 52 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 97c125850c7a..d6a94dc5e644 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10846,16 +10846,13 @@ static void gen_subprog_arg_proto(const struct bpf_subprog_info *sub, const stru
 	}
 }
 
-static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
-				    struct btf *btf, struct bpf_reg_state *regs,
+static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog, struct btf *btf,
 				    struct bpf_call_arg_meta *meta)
 {
 	struct bpf_subprog_info *sub = subprog_info(env, subprog);
 	struct bpf_func_state *caller = cur_func(env);
-	const struct btf_param *args, *stack_args;
 	const struct btf_type *func, *func_proto;
 	struct bpf_func_proto *fn;
-	u32 arg, slot, nslots;
 	int ret, err;
 
 	memset(meta, 0, sizeof(*meta));
@@ -10877,63 +10874,24 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 
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
 	meta->fn = fn;
 	meta->func_proto = func_proto;
 
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
-			ret = check_func_arg(env, arg, slot, 0, meta, env->insn_idx);
-			if (ret)
-				return ret;
-		} else {
-			verifier_bug(env, "unrecognized %s type %d",
-				     reg_arg_name(env, argno), arg_type);
-			return -EFAULT;
-		}
-
-		for (k = 1; k < nslots; k++) {
-			ret = check_arg_extra_slot(env, caller, slot + k, meta);
-			if (ret)
-				return ret;
-		}
-	}
-
-	return 0;
+	return check_func_args(env, meta, env->insn_idx);
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
 static int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
-				  struct bpf_reg_state *regs,
 				  struct bpf_call_arg_meta *meta)
 {
 	struct bpf_prog *prog = env->prog;
@@ -10951,7 +10909,7 @@ static int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
 	if (prog->aux->func_info_aux[subprog].unreliable)
 		return -EINVAL;
 
-	err = btf_check_func_arg_match(env, subprog, btf, regs, meta);
+	err = btf_check_func_arg_match(env, subprog, btf, meta);
 	/* Compiler optimizations can remove arguments from static functions
 	 * or mismatched type can be passed into a global function.
 	 * In such cases mark the function as unreliable from BTF point of view.
@@ -10971,7 +10929,7 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	int err;
 
 	caller = state->frame[state->curframe];
-	err = btf_check_subprog_call(env, subprog, caller->regs, &meta);
+	err = btf_check_subprog_call(env, subprog, &meta);
 	if (err == -EFAULT)
 		return err;
 
@@ -11109,7 +11067,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EFAULT;
 
 	caller = state->frame[state->curframe];
-	err = btf_check_subprog_call(env, subprog, caller->regs, &meta);
+	err = btf_check_subprog_call(env, subprog, &meta);
 	if (err == -EFAULT)
 		return err;
 	if (bpf_subprog_is_global(env, subprog)) {
@@ -11246,7 +11204,7 @@ static int check_func_callx(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	/* PTR_TO_FUNC is a pointer to a static subprog */
 	subprog = reg->subprogno;
-	err = btf_check_subprog_call(env, subprog, caller->regs, &meta);
+	err = btf_check_subprog_call(env, subprog, &meta);
 	if (err == -EFAULT)
 		return err;
 
-- 
2.52.0

