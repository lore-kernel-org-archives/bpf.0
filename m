Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC614C33D6
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542910; cv=none; b=puPvfaQwSHLM5mjxuD6OOSvW4Gv//JP1Xkaf16BQIHCDoyt6Lyp44pvhwiEAChD2LV/ipPegUkdIe6ZRRHZYkSsK8a2GFLPBcqjChdk2auqIu2bTj99fNrC/HWB0w8JoKyGRtLXu4zmR2sz6gJd4XZ1B14GIl0vF+su/LQy8KQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542910; c=relaxed/simple;
	bh=zSIjIDEGrc7E6bCja/lSECzf74bBZ4ojKg57CN9liYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GzU6ri1tHcxB+5ts2DycG3W7V0iuveVhOU57QqdR4p62O0f5f3HEk5AerHc8mJ9lJ0+QTuwPExCuQ2tFjRboUhvbnb2NKNBosdpHbqDq2jgTF5VQH8MWcKV7k9WZTYIvflCkEjIOBxSMMXb7gEHj59ef9cs+OqdmX95UP/U3/NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfXo8cg3; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfXo8cg3"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ab3260b2cdso342601a91.1
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542900; x=1792147700; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JigSh4OIRmwBHUlBzXjSqDsXWERN0FOVKEIsjD4HrkY=;
        b=QfXo8cg3nQhzugSijknj1y8TYZMzvLnmfnz6tb+vYu1p4jZ4SjQ7SkocQ0cAhXee/y
         rwv/PH8n5HuZApnrWP0PLWM+Uo8x8EgiLXT61/ShkUzNIIxOi2DtpSAA1R3iJD6nZneH
         14j+5sqBtnV3AoN73wRUtM+wdTFmbR58F7gPWg3h60UFA9z1dBcGYBnwxpOT4lo7Qkcg
         ngp/cPTCIgOogFaGxr8Uxe4viOWACEdisS0UzXdXYMYbcCV0HGo/EZc6RxY5g/hzJWFB
         uJwb2SkkvoEzXZCylp3s5DYRyhOOCLRGFbuH2MVPs7w3ucqBtw1aBw52e/VedSrhXWaY
         ASog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542900; x=1792147700;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JigSh4OIRmwBHUlBzXjSqDsXWERN0FOVKEIsjD4HrkY=;
        b=0+guJSraXYYeRbjJQ0Hb58XslYqRSmwFTK/29DQi+xOKHrqiomtwmSHw1wNv82DVhn
         aAka9I+CcvqDlYu6ofFrrgUXnbj5lXXStXK6BpNKL1wTO/wRndjo999rKwyzSSXBVcp7
         uW3ht0SwLdXXasVlE8eXESrOVIWJ7oXbUxNfOHR8278kYn58iwxXq+c1kLkK+nEaW8/i
         HACY/r1ioUTjXuNDYQMPVvYF98PfLYhB5y3nyvXR5BOaUg44AVu64fHYr9mRxofPq8ha
         Y2bGiDS+coRGO15XFSHz3Uv9njAEjhgU0m/qbQrJU5vsVpWaTvCBeYMTDZkNHxwEYpxX
         Ym+Q==
X-Gm-Message-State: AFq9FYLPNEepRt0eqqKYgK8kzXsBx9/DhmXdzlphzN34l0VNRgVfL1s9
	4sR+3sFpMY+naWuN/MUHQGmxCEb990Q5Se3NmhqA2dDNohMLw8eOCxAWfoB0e9oi
X-Gm-Gg: AYBFou0tBdycFzlIVv+xdM1//T0XZJC5dgQyJOiUOu8HiHS9Cp+r8YtCo3IAsm6P7BF
	XvToHRQSgSXKmaeCkJUuKBIdvf+iGS6Y4Agyb6hcg2H6tPh6aIVi2mnatOyN8SMq35gs3dyt9Vf
	7RGdO8VRbiCMiFe9ErbpJlDJT4Uyz4GNdmRWV235i3a8twzoyoboFaPlYGeI9qVdNRzTNakfY//
	gXC3yhwNW3eSvfTgTMmRpFBu1ANo127Ac6iqnd8+8SXv2DbUBfNok5ZqxCdhLfs+MT0fUcnejan
	EWlM0BSNL+74Siak4UhFpF8px/5dYmGzJWYrLpVOJ9ayKfJsG2mvVLtNFD5oiIRNnVxYve37t2E
	JMnCXSKtmrkKKxKiPyi8BAgcbL8vNblA4rDcFnagsAUE6UfW2TLJE6CUbxUxaR0RLo9qby9fyEq
	mNBET4huHB3kbdTF50CU4QVd8eK7xk/hoOqfB0FFd32WP/b48RJ4MEC/kAiIVDuhrbqenNG5iT0
	ryJuWS5rdFEYjKj
X-Received: by 2002:a17:90b:3b90:b0:3a8:5543:5572 with SMTP id 98e67ed59e1d1-3ab3a3654admr1556577a91.1.1791542899726;
        Fri, 09 Oct 2026 03:48:19 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:19 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 03/51] bpf: describe kfunc stack accesses with arg_access_info
Date: Fri,  9 Oct 2026 03:47:21 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-3-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Return kfunc stack effects through arg_access_info while preserving the
existing BTF size lookup and read/def classification. Retain __sz/__szk
handling and conservatively mark pointer arguments as possible writes.

Remove the temporary signed-size adapter from liveness. Add liveness
assertions for privileged and unprivileged __uninit outputs.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h                       |  6 +--
 kernel/bpf/liveness.c                              | 18 +--------
 kernel/bpf/verifier.c                              | 43 ++++++++++++----------
 .../selftests/bpf/progs/verifier_kfunc_uninit.c    |  6 +++
 4 files changed, 33 insertions(+), 40 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5c99c024c309..eafe79929dfa 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1734,9 +1734,9 @@ struct arg_access_info {
 struct arg_access_info
 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env,
 			      struct bpf_insn *insn, int arg, int insn_idx);
-s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env,
-				 struct bpf_insn *insn, int arg,
-				 int insn_idx);
+struct arg_access_info
+bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env,
+			     struct bpf_insn *insn, int arg, int insn_idx);
 int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env);
 
 int bpf_stack_liveness_init(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 353b52031577..d4089a488784 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1604,21 +1604,6 @@ static int record_load_store_access(struct bpf_verifier_env *env,
 	return 0;
 }
 
-/* Adapt the signed kfunc access size until its producer is converted. */
-static struct arg_access_info stack_access_info(s64 bytes)
-{
-	bool write = bytes < 0 && bytes != S64_MIN && -bytes < U32_MAX;
-
-	return (struct arg_access_info) {
-		.size = bytes == S64_MIN
-			? U32_MAX
-			: min_t(u64, bytes < 0 ? -bytes : bytes, U32_MAX),
-		.may_read = bytes > 0 || bytes == S64_MIN,
-		.may_write = write,
-		.must_write = write,
-	};
-}
-
 static int record_arg_access(struct bpf_verifier_env *env,
 			     struct func_instance *instance,
 			     struct bpf_insn *insn,
@@ -1636,8 +1621,7 @@ static int record_arg_access(struct bpf_verifier_env *env,
 	if (bpf_helper_call(insn)) {
 		info = bpf_helper_stack_access_bytes(env, insn, arg_idx, insn_idx);
 	} else if (bpf_pseudo_kfunc_call(insn)) {
-		info = stack_access_info(bpf_kfunc_stack_access_bytes(env, insn,
-								      arg_idx, insn_idx));
+		info = bpf_kfunc_stack_access_bytes(env, insn, arg_idx, insn_idx);
 	} else {
 		for (int f = 0; f <= depth; f++) {
 			err = mark_stack_read_all(env, instance, f, insn_idx);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bbb81ba0f2dc..8987c9a69d10 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14487,28 +14487,29 @@ bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *ins
 }
 
 /*
- * Determine how many bytes a kfunc accesses through a stack pointer at
- * argument position @arg (0-based, corresponding to R1-R5).
- *
- * Returns:
- *   > 0      known read access size in bytes
- *     0      doesn't access memory through that argument (ex: not a pointer)
- *   S64_MIN  unknown
- *   < 0      known write access of (-return) bytes
+ * Describe a kfunc's stack access through argument slot @arg (0-based).
+ * As for helpers, must_write describes destruction of prior verifier state,
+ * rather than a guarantee that the callee writes every byte at runtime.
  */
-s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *insn,
-				 int arg, int insn_idx)
+struct arg_access_info
+bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *insn,
+			     int arg, int insn_idx)
 {
 	struct bpf_insn_aux_data *aux = &env->insn_aux_data[insn_idx];
+	struct arg_access_info info = {
+		.size = U32_MAX,
+		.may_read = true,
+		.may_write = true,
+	};
 	struct bpf_call_arg_meta meta;
 	const struct btf_param *args;
 	const struct btf_type *t, *ref_t;
 	const struct btf *btf;
 	u32 i, slot, nargs, type_size;
-	s64 size;
+	u64 size;
 
 	if (bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta) < 0)
-		return S64_MIN;
+		return info;
 
 	btf = meta.btf;
 	args = btf_params(meta.func_proto);
@@ -14523,11 +14524,11 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *
 	for (i = 0, slot = 0; i < nargs && slot < arg; i++)
 		slot += btf_arg_slots(btf_type_skip_modifiers(btf, args[i].type, NULL));
 	if (i >= nargs || slot != arg)
-		return 0;
+		return (struct arg_access_info) {};
 
 	t = btf_type_skip_modifiers(btf, args[i].type, NULL);
 	if (!btf_type_is_ptr(t))
-		return 0;
+		return (struct arg_access_info) {};
 
 	/* dynptr: fixed 16-byte on-stack representation */
 	if (is_kfunc_arg_dynptr(btf, &args[i])) {
@@ -14543,11 +14544,11 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *
 
 		if (size_reg <= MAX_BPF_FUNC_REG_ARGS &&
 		    (aux->const_reg_mask & BIT(size_reg))) {
-			size = (s64)aux->const_reg_vals[size_reg];
+			size = aux->const_reg_vals[size_reg];
 			goto out;
 		}
 		/* Unknown size: the read may extend anywhere up to the frame top. */
-		return S64_MIN;
+		return info;
 	}
 
 	/* fixed-size pointed-to type: resolve via BTF */
@@ -14557,15 +14558,17 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *
 		goto out;
 	}
 
-	return S64_MIN;
+	return info;
 out:
+	info.size = min_t(u64, size, U32_MAX);
 	/* KF_ITER_NEW kfuncs initialize the iterator state at arg 0 */
 	if (arg == 0 && meta.kfunc_flags & KF_ITER_NEW)
-		return -size;
+		info.may_read = false;
 	if (is_kfunc_arg_uninit(btf, &args[i]) &&
 	    (is_kfunc_arg_dynptr(btf, &args[i]) || env->allow_uninit_stack))
-		return -size;
-	return size;
+		info.may_read = false;
+	info.must_write = !info.may_read && info.size != U32_MAX;
+	return info;
 }
 
 /* check special kfuncs and return:
diff --git a/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c b/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c
index ff2fb36a0260..20ed71a54686 100644
--- a/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c
+++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c
@@ -18,6 +18,9 @@ void __kfunc_btf_root(void)
 
 SEC("tc")
 __success __retval(10)
+__log_level(2)
+__msg("call bpf_kfunc_test_uninit_struct{{.*}}; def: fp0-8 fp0-16")
+__msg_unpriv("call bpf_kfunc_test_uninit_struct{{.*}}; use: fp0-8 fp0-16")
 __flag(BPF_F_TEST_STATE_FREQ)
 __caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
 __prepare_priv
@@ -44,6 +47,9 @@ __naked void struct_poisoned_at_checkpoint(void)
 
 SEC("tc")
 __success __retval(0x2a2a2a2a)
+__log_level(2)
+__msg("call bpf_kfunc_test_uninit_mem{{.*}}; def: fp0-8")
+__msg_unpriv("call bpf_kfunc_test_uninit_mem{{.*}}; use: fp0-8")
 __flag(BPF_F_TEST_STATE_FREQ)
 __caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
 __prepare_priv

-- 
2.53.0
