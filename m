Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C51F17B425
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121121; cv=none; b=GVdzzyj9xz2KzshQp0/tJF7O8wrcmz5Uprg2sspDtQ2g9LeD0Zh1+kmvFV1wIk8j1k3XcHvfcG1bE8ArgL+YOuAvcZ4mA+4eRkDy6w8Ef6OPWBrImd4yF4YkbQaj2oIH5Kh5IekNfDsXriUyoKR/ASyB9wSMU3Q7DNZvb0LN/rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121121; c=relaxed/simple;
	bh=yIywlPmh4WePWF+rv8LvDmZKtg7DoQ30CxGWc6h7qK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CyNB0Byj0Yr1Cc0Ek7XIKyxXswG2zCGoC4N62X4+MJIQFjOHsayEYHZvEZn0KokDC+YJoPMq6iWo3yj4JqZQ+8OX9N8/ZqDMpX9UX1uK8dPzekJaUydinlInTmka3TgGRJNUwACLQ2G9RCfPMlgNH5donjsKa+onG8uJ3AgehSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LuHpwsqh; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuHpwsqh"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3a78673d65fso284199a91.0
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121120; x=1791725920; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oxoTQVz9EYT6oFVFO/OMKWBkOrOIs4xyZ8Clx+brupM=;
        b=LuHpwsqhwbkf3/t85+y1Q7bLk1qdCX7nKWOO4JC56UByi1+c135W9iHxS2OiQCLjch
         g8cNZabAClFtKktXARARvDBlsVz9VjJVE1zx24gMjEcKPsNE+SztKMhnCsBBlqvw0luP
         nCJRXa+Pa+W4RLOnjcCKwTLSAKoHNYjK8RVlEh/kvslmem6j/VtIPhXMVDol1VSiNpcc
         5HDlcm2H3gzNZ51CGx2NtyrwtYa4JM829bRDZiOVpovQinKDEO4CCnbBEv4j7orlvkmd
         5K8UVcVayCGMGrcHr1MDt+kpjfqJUEpJ+MQSW2UNr3xTWjORO7rhWdltoxGxM/hEaoXB
         UfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121120; x=1791725920;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oxoTQVz9EYT6oFVFO/OMKWBkOrOIs4xyZ8Clx+brupM=;
        b=wpeP4gLrN30f+7cJnbp1t93kSUEN7unH04prMK0jIp3nmadZr5eXH825BWYZa5bxN+
         ejQqdW63BeKAes0jv8s/1l9SKidxH7HLrKRA/xjn0GuKLWgEQ7dLcrFi8QnVvdNUQqhI
         b2u4UCza84mCha07hvzGuCaiCRGO0NE3yaHjj5ndvI9OZnmTDVZFK7cYfTAAMkviPhP/
         TN23aj9cl5bNbYXJ9HjWhwLc0M8HKKNcmz8W9mx8tENug2cBIP6G+hC7/9LDu1WdEAu6
         1BunsH2WBTx9kXzVEcT58WZ7WtW7VKBsP5PV9CrElrOwMVobEmGELLztn/onWm7lXqPA
         qPTw==
X-Gm-Message-State: AFuF++luULSFxIzf7xv3rBcXuI0eofJ7P88B9ZvmCWv5HVYlnQLmuinf
	AKJT7tGwV/TIbEH1fbrsQx/pAdSFTM6CKF4qJdGDfRhL9ff8n57VnyKRaoQYJg==
X-Gm-Gg: AYBFou01L5PIvzkiMxHvjLeG8EDz5z7bMSl2LzsKm5a0sekDvcuX0gvaemt90cF2fm7
	GRbxkm4r+dXx4mrHaiE/dVqeBm4OkHnoL35GhrAlcyv5UF8W2ycXg2Vfe1SrbTQdPn99pGd6d9w
	AGCuQp0r1Qua5RYxX1niKLXneeh1CnxNst0PsBhcNqMxCOK3NjZlY0Kd1fluIxrVGSxHWu/+KoS
	ttvxvbs/ZEeT49LV7pb3XpJ5YkHdjRLQT778MBjObxgq6CLlfIn3tHJ9VyXAkrCwzk4vl1f2UVN
	yuF0OxogOnIjskSQbtc+bdiZGgQHgaAFm84zGYlrSPLK8OlBWlGjmnTLqG6hoBpTxERiLHuwMNI
	IQ9UVZozcXfkXSUifAEm209T0cZy6wWlb6Xc9uDXeUqLef1Re1nXvDbkbs8girr2IpNSCC8Fd4m
	Ob35pfS889NZ1ZeERv5PkFt5g5zEysrVmrDXtw3vkRWJrc0HHAOlxySVm5angv0iLWol1nWazAr
	B1/ei/pRr5UMq8=
X-Received: by 2002:a05:6a20:918c:b0:3da:e57d:4a79 with SMTP id adf61e73a8af0-3deacbef024mr8711112637.13.1791121119539;
        Sun, 04 Oct 2026 06:38:39 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:38:38 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 03/43] bpf: describe kfunc stack accesses with arg_access_info
Date: Sun,  4 Oct 2026 06:37:45 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-3-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
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
index b558399bdc08..98e64a138921 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14473,28 +14473,29 @@ bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *ins
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
@@ -14509,11 +14510,11 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *
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
@@ -14529,11 +14530,11 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *
 
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
@@ -14543,15 +14544,17 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *
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
