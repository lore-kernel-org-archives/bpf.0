Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795473161;
	b=MSTTJ0GbU9mSTvNGK2+hGh54++A00h7Km6IsV7Rub4FFC+c5Tbb0kFuGxF4LPD5jLF+U
	 FK5V14k1XauYajkJEijnWeIixjsB7qYeM7I+WvmWacsxlKwV11zl/aDvmXLCeh5gc4l+Z
	 wPTNi4F3lkTHaEYWvGZpkmSnoa0PK7TCKralqfC/jmLIRtELqEXVttZ9rCzqvJjYr+N0W
	 6xPHclVELFLhZsobO/I9r0ooz4uuNTi+D7bOasPKmtcKMGn2x9fE8R7asVMn8pU48stBq
	 Z33qxzn9iGAbNG9xXtFaZ6fP+RaWuS+i0165E6LApZwmRC8tn7jLGKfvvsx7SVpG3Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795473161;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FvWpyaoGkKAFehuXRShfCVClR35u4H3lV4oX/vpJLdM=;
	b=zsZz4rmwdZBFUWtbmRfsGgbxCM9fMGLlufJogmsScgtY6Dp/oOlmhUuGfAtv1/lk9+J4
	 3OONgNOBp+nj5Q2cmzRPxBR2cf7i/vJDGU1NRGDebdGp54cnPq6OmFFkyK78b6qtIyblc
	 WecPL89G42LG/hVDFRkwiYARtruG9dPxtBHJTFL9m6np3ulCZnc88fjbt0DdceXu4oSPX
	 AFMMSqkEajXmRVW2HKOtSVnKpgr5FMwEBsKaQ7nq+8EkkENLOCfUT+veUqajNEWSelEA3
	 qTdIaMS+cJ1w7qVDXHTwGF1BqLWbvBhkOh0g2UwuOhgE+75AWxmLagH4W/sAkHli9Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XB8EfejU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAB2606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XB8EfejU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1361F000D8;
	Mon, 23 Nov 2026 22:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795473161;
	bh=FvWpyaoGkKAFehuXRShfCVClR35u4H3lV4oX/vpJLdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XB8EfejUauTWPiCEjNOTESTAvupPVvFKtOLi51FrfNPkbncb+LkReiYk0LxyWNU+0
	 R/Zy8STPLXmAs8U4kD82xYKspG0xlZAFZBFItSPUC+Ist4Ps4EJD9vwigvuCni75t8
	 YNnCgYd2M9AbKX2UgOAUs093zysgOz7DCZNAZulR8KeDC2IQSYgO7HwJVMmIA9nVb1
	 +Jlwaq3EnRFh68OmhxC1PfLL6rLG3++S29ZxJVBV6mPeYT3j65wzs9Wf4seGDfulFc
	 2a32PiloH+6vJkSVN5vbF4wKcKaGPfke364iVSwNLDOW0HonOJRUUNDaM3nF2UFFH6
	 Hn+FMtFtTmRUw==
From: Alan Maguire <almagui@kernel.org>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	Alan Maguire <almagui@kernel.org>
Subject: [PATCH bpf-next 2/7] bpf: Support CO-RE relocation of tracing program arguments
Date: Mon, 23 Nov 2026 22:32:22 +0000
Message-ID: <20261123223227.745345-3-almagui@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123223227.745345-1-almagui@kernel.org>
References: <20261123223227.745345-1-almagui@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Light skeletons rely on the kernel to apply CO-RE relocations, which
only knows how to find candidates by type name, so the function
arguments structs supported by libbpf (__bpf_func_args) find no
candidate: all arguments appear to be missing.

Pass the program being loaded to bpf_core_apply() and, for relocations
against a function arguments struct, use the program's attach target
as the (single) candidate, as built by bpf_core_func_args_cand() in the
shared relo_core.c. prog->aux->attach_btf and attach_btf_id are already
set when bpf_check_core_relo() runs, and the program holds a reference
to attach_btf, so no candidate cache or locking is needed.

As the matching is shared with libbpf, parameter type changes are
handled the same way as when libbpf applies the relocations: members of
a different kind than their parameter, and pointers to a type with a
different kind or name than the parameter's (other than void *), don't
match and so appear as missing arguments; integer size changes are
handled as for struct fields. Likewise, on big-endian targets, loads of
signed arguments smaller than 8 bytes that aren't sign-extending are
poisoned, as the verifier only allows loads of whole context slots.

Unlike in libbpf, all subprograms belong to the program being loaded,
so relocations in subprograms work too.

Signed-off-by: Alan Maguire <almagui@kernel.org>
Assisted-by: LLM
---
 include/linux/bpf.h    |  2 ++
 kernel/bpf/btf.c       | 38 ++++++++++++++++++++++++++++++++++++++
 kernel/bpf/check_btf.c |  1 +
 3 files changed, 41 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 971e584c6efc..f814f4e8fd81 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3445,6 +3445,8 @@ int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
 struct bpf_core_ctx {
 	struct bpf_verifier_log *log;
 	const struct btf *btf;
+	/* program being loaded, if any, for function argument relocations */
+	const struct bpf_prog *prog;
 };
 
 bool btf_nested_type_is_trusted(struct bpf_verifier_log *log,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2f28b418a7fc..e37a77dec8b8 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -10697,11 +10697,39 @@ bpf_core_find_cands(struct bpf_core_ctx *ctx, u32 local_type_id)
 	return populate_cand_cache(cands, module_cand_cache, MODULE_CAND_CACHE_SIZE);
 }
 
+/* Function argument structs (see __bpf_func_args in libbpf's bpf_tracing.h)
+ * are matched against the parameters of the program's attach target.
+ */
+static int bpf_core_func_args_cand_prog(struct bpf_core_ctx *ctx, int relo_idx,
+					struct bpf_core_cand *cand)
+{
+	const struct bpf_prog *prog = ctx->prog;
+	int err;
+
+	if ((prog->type != BPF_PROG_TYPE_TRACING && prog->type != BPF_PROG_TYPE_LSM) ||
+	    !prog->aux->attach_btf || prog->aux->attach_btf_id == 0 ||
+	    prog->aux->dst_prog) {
+		bpf_log(ctx->log,
+			"relo #%u: function argument relocations need a kernel attach target\n",
+			relo_idx);
+		return -EOPNOTSUPP;
+	}
+
+	err = bpf_core_func_args_cand(prog->aux->attach_btf, prog->aux->attach_btf_id,
+				      prog->expected_attach_type, cand);
+	if (err)
+		bpf_log(ctx->log,
+			"relo #%u: can't relocate function arguments against attach target [%u]: %d\n",
+			relo_idx, prog->aux->attach_btf_id, err);
+	return err;
+}
+
 int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 		   int relo_idx, void *insn)
 {
 	bool need_cands = relo->kind != BPF_CORE_TYPE_ID_LOCAL;
 	struct bpf_core_cand_list cands = {};
+	struct bpf_core_cand func_args_cand;
 	struct bpf_core_relo_res targ_res;
 	struct bpf_core_spec *specs;
 	const struct btf_type *type;
@@ -10722,6 +10750,16 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 		return -EINVAL;
 	}
 
+	if (need_cands && ctx->prog && bpf_core_is_func_args_type(ctx->btf, relo->type_id)) {
+		/* no locking needed, prog holds a reference to attach_btf */
+		need_cands = false;
+		err = bpf_core_func_args_cand_prog(ctx, relo_idx, &func_args_cand);
+		if (err)
+			goto out;
+		cands.cands = &func_args_cand;
+		cands.len = 1;
+	}
+
 	if (need_cands) {
 		struct bpf_cand_cache *cc;
 		int i;
diff --git a/kernel/bpf/check_btf.c b/kernel/bpf/check_btf.c
index 79e079e907c9..e302feea9ca9 100644
--- a/kernel/bpf/check_btf.c
+++ b/kernel/bpf/check_btf.c
@@ -352,6 +352,7 @@ int bpf_check_core_relo(struct bpf_verifier_env *env,
 	struct bpf_core_ctx ctx = {
 		.log = &env->log,
 		.btf = btf,
+		.prog = prog,
 	};
 	bpfptr_t u_core_relo;
 	int err;
-- 
2.56.0

