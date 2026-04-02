Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B1B3B389F
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 21:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775165356; cv=none; b=LK/yqaPP9oTeKTR/dQNNh+P9a7r3rTIrsi1IeKSTi5RBizdJD0guEvIhIslg2PVBj8ksnO7OaI3XaQ5RO2tvPR2uGx6Di8YhyZ5gHUu8bKutDqRVJ/Pwmt7Y/F0JyO0mzMk7JdQ+yr3WQe0qdMw48LLBnxUF5Zz92eIqMM/cHQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775165356; c=relaxed/simple;
	bh=bqTEWjpJJbUfqc2qbMLshBWQUcM4KrE4bgzqYYO1duc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYQFohyVSyRpwb7RA28v1NOrsWwTEywvqdEDaEBrPn95Wv2vanUl8madv6VBrnalfd7OU18/RSwWQg3D/uV2P/yWoMg6ltqCMcxWrgGVXiuZbJ7E37taixphYLe5TA+1WKXpU7aRUYpV5DVG1jlD/VwBKdLLHn+FRwnexjSoUnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgVWw0iE; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgVWw0iE"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35d9827661bso686400a91.3
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 14:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775165354; x=1775770154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeQ8vUcgHcFn7lXmephhCW0/GTFnMNeD1f4ZWr9mwWo=;
        b=YgVWw0iEek1/tvN0lHiUVk4yLqkDPCDWUqhVrpfSEeDlhD+1WtI4xs5KMPqwuFjORL
         YMsIcM9HWZugAU10EbkRL0vqLFjymnc+3pNNgRHs94/4X/elqRH26ym7cNYkND88zZM8
         diyKkcC+nQDs6OAMZLxaizq+Z8FRJWrmhfnqsWc0iLiicJTXxc3daToeu2N7Zcep8dn3
         6WiW5jJfcGcvzE8Crim9V4/lkn265IWIuB/b8o5bGhg/emhctPUDxQj2QZZ4lpuEkXTm
         DXQlt5Zq1t9Wp4dMVr+OX5Lodx2ZJMJ55PbB/D4OIn+9QHFpnthHpKlxLTs4BTyxc/Fg
         fKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775165354; x=1775770154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zeQ8vUcgHcFn7lXmephhCW0/GTFnMNeD1f4ZWr9mwWo=;
        b=Geiwpnm71+97mXN7+4x44/y3EoeOyASJsGB8H14i6gWDjrG0tOBKyPVlB7MU96XVrI
         1cpmiZ2H2ov0k3YbvjNr3kZ9vUKsv9tfFG1YCdFBLPvAzLbzBR9404UNUIVNvZa2n7Tk
         Mnxtedt1juzpxdG+IYUpEgj2FWN+NZNve30pTVYla9Ykq3fgoCgYOS9u4TdWtNMqjTyx
         ouOLfQDM0N9qQwobLLu9ci9uE9UN6m24cDINWftC7lJS3eXOSwP7BOp5pjwyYTg3WTmn
         IDrUDXSUaKHpHd2dEeytRouUYwNlIROImkUmUNFsHoZQD3YOzItxuLipK73ZzBOGKMAQ
         3rvw==
X-Gm-Message-State: AOJu0YyAb1OOfne312Cg9ScozuOekF1e/+M+6D38mPie38FzRrE5yntG
	yQ/tjbJdRMR9Hr6cOev0yKet9V1KyaAfGTzBrOp6N4L1vFdwKs7fSdROLgv0iA==
X-Gm-Gg: AeBDiesYoeHhyTHMj64b8BWqw9SFLL19k+c0E06Z4Ka9rTYXZPTu09/ou1Phyn06KkQ
	3cBYw7PJH4Bdo+mEBArvf7d59ieR94CzcGXeipFUBqzginmiDl9eKe6ncdX0OFpQxQcXaPwodTQ
	7Fk3RHkZSWpHWzTZGaCVM1E79siwIVohaRTaPFHjoqm1KOzlGM1yXS2TiU/WBFQWX7FbUk7O/aH
	RdM4WzX9VIx4FE4IhRBCMMAQmCw8qOvPKrQeI0UinW4j5/uRwTWSAKeRTrlZ/za+nTHyTGJvlr3
	sDoHXz8K57CCJfoU7PfufesEBq7RNXlbfw0NsNIgv2yZVPog3DI1L9Vv8Rc0xb0mfB6N2cVIevV
	tJYvLHfM29x09vu1sdE4iS5vNxBdunqzRjH+y5qlGlbJuXeyMvlseuZ46R697PVA4/HyM2Oho76
	CdFrMDg23Y5YIvfMp0XvhmvPHsgSNHXuOfctZiGcqv4vL4XJ4AqGodrLPq5V0Cb9NlmhjL8/zkU
	cgdjYW1ZaljTCghh8lOkloaf8eXiHdG3RA+1sCFgLU7x67UWaiihDCPAZnl+w==
X-Received: by 2002:a17:902:ffd0:b0:2b2:5857:601a with SMTP id d9443c01a7336-2b281684961mr8214015ad.13.1775165353920;
        Thu, 02 Apr 2026 14:29:13 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27497c117sm36363565ad.40.2026.04.02.14.29.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 14:29:13 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v3 bpf-next 6/6] bpf: Add helper and kfunc stack access size resolution
Date: Thu,  2 Apr 2026 14:28:56 -0700
Message-ID: <20260402212856.86606-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402212856.86606-1-alexei.starovoitov@gmail.com>
References: <20260402212856.86606-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The static stack liveness analysis needs to know how many bytes a
helper or kfunc accesses through a stack pointer argument, so it can
precisely mark the affected stack slots as stack 'def' or 'use'.

Add bpf_helper_stack_access_bytes() and bpf_kfunc_stack_access_bytes()
which resolve the access size for a given call argument.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   6 ++
 kernel/bpf/verifier.c        | 188 +++++++++++++++++++++++++++++++++++
 2 files changed, 194 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 76f62c8907bf..30e4a970c826 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1136,6 +1136,12 @@ bool bpf_is_may_goto_insn(struct bpf_insn *insn);
 void bpf_verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *insn);
 bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
 			  struct bpf_call_summary *cs);
+s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env,
+				  struct bpf_insn *insn, int arg,
+				  int insn_idx);
+s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env,
+				 struct bpf_insn *insn, int arg,
+				 int insn_idx);
 
 int bpf_stack_liveness_init(struct bpf_verifier_env *env);
 void bpf_stack_liveness_free(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 55f82fba2f6e..ee47d31c7ecc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14087,6 +14087,194 @@ static int fetch_kfunc_arg_meta(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/*
+ * Determine how many bytes a helper accesses through a stack pointer at
+ * argument position @arg (0-based, corresponding to R1-R5).
+ *
+ * Returns:
+ *   > 0   known read access size in bytes
+ *     0   doesn't read anything directly
+ * S64_MIN unknown
+ *   < 0   known write access of (-return) bytes
+ */
+s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *insn,
+				  int arg, int insn_idx)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[insn_idx];
+	const struct bpf_func_proto *fn;
+	enum bpf_arg_type at;
+	s64 size;
+
+	if (get_helper_proto(env, insn->imm, &fn) < 0)
+		return S64_MIN;
+
+	at = fn->arg_type[arg];
+
+	switch (base_type(at)) {
+	case ARG_PTR_TO_MAP_KEY:
+	case ARG_PTR_TO_MAP_VALUE: {
+		bool is_key = base_type(at) == ARG_PTR_TO_MAP_KEY;
+		u64 val;
+		int i, map_reg;
+
+		for (i = 0; i < arg; i++) {
+			if (base_type(fn->arg_type[i]) == ARG_CONST_MAP_PTR)
+				break;
+		}
+		if (i >= arg)
+			goto scan_all_maps;
+
+		map_reg = BPF_REG_1 + i;
+
+		if (!(aux->const_reg_map_mask & BIT(map_reg)))
+			goto scan_all_maps;
+
+		i = aux->const_reg_vals[map_reg];
+		if (i < env->used_map_cnt) {
+			size = is_key ? env->used_maps[i]->key_size
+				      : env->used_maps[i]->value_size;
+			goto out;
+		}
+scan_all_maps:
+		/*
+		 * Map pointer is not known at this call site (e.g. different
+		 * maps on merged paths).  Conservatively return the largest
+		 * key_size or value_size across all maps used by the program.
+		 */
+		val = 0;
+		for (i = 0; i < env->used_map_cnt; i++) {
+			struct bpf_map *map = env->used_maps[i];
+			u32 sz = is_key ? map->key_size : map->value_size;
+
+			if (sz > val)
+				val = sz;
+			if (map->inner_map_meta) {
+				sz = is_key ? map->inner_map_meta->key_size
+					    : map->inner_map_meta->value_size;
+				if (sz > val)
+					val = sz;
+			}
+		}
+		if (!val)
+			return S64_MIN;
+		size = val;
+		goto out;
+	}
+	case ARG_PTR_TO_MEM:
+		if (at & MEM_FIXED_SIZE) {
+			size = fn->arg_size[arg];
+			goto out;
+		}
+		if (arg + 1 < ARRAY_SIZE(fn->arg_type) &&
+		    arg_type_is_mem_size(fn->arg_type[arg + 1])) {
+			int size_reg = BPF_REG_1 + arg + 1;
+
+			if (aux->const_reg_mask & BIT(size_reg)) {
+				size = (s64)aux->const_reg_vals[size_reg];
+				goto out;
+			}
+			/*
+			 * Size arg is const on each path but differs across merged
+			 * paths. MAX_BPF_STACK is a safe upper bound for reads.
+			 */
+			if (at & MEM_UNINIT)
+				return 0;
+			return MAX_BPF_STACK;
+		}
+		return S64_MIN;
+	case ARG_PTR_TO_DYNPTR:
+		size = BPF_DYNPTR_SIZE;
+		break;
+	case ARG_PTR_TO_STACK:
+		/*
+		 * Only used by bpf_calls_callback() helpers. The helper itself
+		 * doesn't access stack. The callback subprog does and it's
+		 * analyzed separately.
+		 */
+		return 0;
+	default:
+		return S64_MIN;
+	}
+out:
+	/*
+	 * MEM_UNINIT args are write-only: the helper initializes the
+	 * buffer without reading it.
+	 */
+	if (at & MEM_UNINIT)
+		return -size;
+	return size;
+}
+
+/*
+ * Determine how many bytes a kfunc accesses through a stack pointer at
+ * argument position @arg (0-based, corresponding to R1-R5).
+ *
+ * Returns:
+ *   > 0      known read access size in bytes
+ *     0      doesn't access memory through that argument (ex: not a pointer)
+ *   S64_MIN  unknown
+ *   < 0      known write access of (-return) bytes
+ */
+s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *insn,
+				 int arg, int insn_idx)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[insn_idx];
+	struct bpf_kfunc_call_arg_meta meta;
+	const struct btf_param *args;
+	const struct btf_type *t, *ref_t;
+	const struct btf *btf;
+	u32 nargs, type_size;
+	s64 size;
+
+	if (fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta) < 0)
+		return S64_MIN;
+
+	btf = meta.btf;
+	args = btf_params(meta.func_proto);
+	nargs = btf_type_vlen(meta.func_proto);
+	if (arg >= nargs)
+		return 0;
+
+	t = btf_type_skip_modifiers(btf, args[arg].type, NULL);
+	if (!btf_type_is_ptr(t))
+		return 0;
+
+	/* dynptr: fixed 16-byte on-stack representation */
+	if (is_kfunc_arg_dynptr(btf, &args[arg])) {
+		size = BPF_DYNPTR_SIZE;
+		goto out;
+	}
+
+	/* ptr + __sz/__szk pair: size is in the next register */
+	if (arg + 1 < nargs &&
+	    (btf_param_match_suffix(btf, &args[arg + 1], "__sz") ||
+	     btf_param_match_suffix(btf, &args[arg + 1], "__szk"))) {
+		int size_reg = BPF_REG_1 + arg + 1;
+
+		if (aux->const_reg_mask & BIT(size_reg)) {
+			size = (s64)aux->const_reg_vals[size_reg];
+			goto out;
+		}
+		return MAX_BPF_STACK;
+	}
+
+	/* fixed-size pointed-to type: resolve via BTF */
+	ref_t = btf_type_skip_modifiers(btf, t->type, NULL);
+	if (!IS_ERR(btf_resolve_size(btf, ref_t, &type_size))) {
+		size = type_size;
+		goto out;
+	}
+
+	return S64_MIN;
+out:
+	/* KF_ITER_NEW kfuncs initialize the iterator state at arg 0 */
+	if (arg == 0 && meta.kfunc_flags & KF_ITER_NEW)
+		return -size;
+	if (is_kfunc_arg_uninit(btf, &args[arg]))
+		return -size;
+	return size;
+}
+
 /* check special kfuncs and return:
  *  1  - not fall-through to 'else' branch, continue verification
  *  0  - fall-through to 'else' branch
-- 
2.52.0

