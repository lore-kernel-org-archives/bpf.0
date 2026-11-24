Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795481430;
	b=hSSLWd8PbcQBNa6QA7NCBms8T1bDWmy2L8wDvv+LS/rHd+ImBIGmiPs3vYWu8QigJKKS
	 ULfCV0I1p/4jmAahYtsIcbsbVMeXuOtRRkb59UlGZxmA9VvPPYgiWs4dL5Su0B7HlKX8j
	 VazniKXFLAcTjKWyquyWDQ5/ToU9WTcHKwZjFiUEytnC/9gB5LHJwbVXZ4NLdLjP7J693
	 dPmyeFbKn/Kr4gBaxD5+bsfIlmWsrLNJG53SB+422JQU+1pkjtHvQlCf9nNXOjZBoBc/r
	 lmjQv8yeEqbwKVeX/gYmiy1DTQ+hoVBVIJ51VgUx/8qfXZljHVTNmAqF4xNbutBHjIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795481430;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=qKMjkwNCJ/VDGbu/tDrASQVNBbjLIgdSkMRGXrvWNb8=;
	b=WREf7jUity2JmBluNQ3hki3OSK3p2KCBgILTEEooBBXJOACWkExKrgQVwFn+sBgHEXK4
	 8i40LtoV3bGm0A23DlVJkq6tStSIp6jFxdjgh6kk05hFnwI0+EO0mW7bVnaUuejaDj/ai
	 I+/YGg1JdT97zKbMxUloUpX8jTEj2oZiKyvmbdb5vLj9VkzC39NX4Li8KD9U3Mxp0iQww
	 jXLqE9N3l/+2i/XPvuTDxnazZxGLO+Dy3DTRSRsSvtwxD7ETqAmH5v5tCP51lNYHSByle
	 Mqg2gHDwstzJrG+/DBPx3ILMv2PupKaolmywxyfbMfNBWRnPX7Xws9iYs5P7x173GGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CFpeDddV;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9783F606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 00:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9783F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CFpeDddV
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2f0414c1062so22092655ad.2
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 16:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795481429; x=1796086229; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qKMjkwNCJ/VDGbu/tDrASQVNBbjLIgdSkMRGXrvWNb8=;
        b=CFpeDddVBrhPiNJHWd7GcMUI9vqKx/AgG0qc6yS94Z24/I0Fb+aNKo3V+wO3zseKFQ
         niqqePoYWxCMRF7tqR030m92Rv6KmT+iFH1qdDVWeP9PLAmH2zP1UuHcbatHqraF1UHw
         VEJfTY13K7wkhFbIMPwcVUT0XSbhzaHgx7C3GaVWCKucj4i1Bt7yu+LAXzm8CZ7ewI2Y
         3NLtvHBshHahKklI8MyhEV1kapnI+9VVgKtCUs6pMFevr71CYlhH6HKdTn9kwqlE4tej
         MTbI5DP0yEc40Vu5iCT4jigHw9HkNIu13v5GU1i/eciS09ULD7QdbnkJrjRUTAtqNcnn
         QCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795481429; x=1796086229;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qKMjkwNCJ/VDGbu/tDrASQVNBbjLIgdSkMRGXrvWNb8=;
        b=j2jdC9RThWTUwjNhveP5f3YO/+wcgGoPaBrTefGehOqOSxNQkTLE27qag5aeq5LO/y
         kIKONj6/NnwkTlD/30hd6/kSNdYbaWavSpVjChWQqi8OdFurPEEh6H+bcGxK2YGs4Tqe
         DW64oGn1QIOydL/wO2PTJaShmxzUqccCtMsSGbyOGHEGrxRWxyoZXN4+tNRMec4evlhx
         okd+5uZ8zzYSPbtHPSA3gCznbdsbiXK4HhKnFauUq52A0DZVLqtFz13nertQnkVazOFI
         CMH9e46soIoOJKk6xOFnpYUAHKke3swEXOVY2xZGiFWBTDyxO6jaL3J/G63GZoD2Vx9A
         lHGw==
X-Forwarded-Encrypted: i=1; AL+hErFdxbVsrjpTN7vg+vbF/TdSYFLNorvUv/XEPr+eonzM6gjjV0aQs+MdlrHLJoDxam1xCec=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gSwwwLRguLKS1fdI6M7/aFIGhAwCFDwyydIhEeae6a/7XIvRj
	7b9GlA/fGSuD+azRIGhhuImNM98j85sIGXxWgmSz+QZMlVBlCsxMqB1U
X-Gm-Gg: AZFdTZcbl2fBfvRepoDvXOWpE6Uc785D+1PAubG5JLs26lTYGORNh/CpSxnySKRoslp
	/oZhjh+g7YSqDn6rvqUYjwV+2Ikjn7vcRZSs7OhiW0PD2Sen7x6F+EiYg6+fBFPW1cDgemcSlMm
	BvBQtCGyJfuob+RoWtpOTwHR8SMktwEk3QcgshRqCsqIEFnWL1qQHBljo54PYLvjONaH9N1zYsF
	qp8IITFk3GLsc1vrhciW6y6UZfSJxa5XSaj57e8xHq8SO2b7dIGrgqrjsDDpEMGYUSRubQMH0JI
	7UhxMj6e4hBLPa8QM4hMD0x2JHRY+9UMBFKAhWXV7YhuxAJslQzxkpopdrBJANLlvRTVgWS8Rpu
	HYs/CD9+2Aa6nAo858pERheYzqR+44z5bnIVlRg53OVkrMuoZ0QHQT6ps0m8HABPArPVVUve71v
	6k8IRgRuqpdLppzGZEgWEx+ghJ7mgtzxmPDqSXnPFT4exnjZrbmBTD723puOPisSgH8CElrF4kr
	q3X0OH4ZVi34ueIKTV1fs6w1fjYWCucS5jAJKPwO91jssw1xxufgwuA1D9Xv7kbGsOc0RUNZmMR
	5haxxT/2l7PsX5IC6YSM7O3nuLqirGEygmKLTtk7Fjwr13HW+jc4LR9Tguh23k7RDbURmBprKSZ
	vR3h1htdrzO4CdtkmIZVeb6Clt2whpZVkfA==
X-Received: by 2002:a17:90b:2516:b0:3b4:c9f8:abce with SMTP id 98e67ed59e1d1-3b4c9f8abe0mr981182a91.35.1795481428691;
        Mon, 23 Nov 2026 16:50:28 -0800 (PST)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b828ab9sm7102772a91.2.2026.11.23.16.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 16:50:28 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 00:50:27 +0000
Message-Id: <DN311OXVTVFO.AKQ8VYM3W5EL@gmail.com>
Cc: <eddyz87@gmail.com>, <memxor@gmail.com>, <martin.lau@linux.dev>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <john.fastabend@gmail.com>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 0/7] libbpf, bpf: Utilize CO-RE for BPF program
 parameter presence, ordering
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Alan Maguire" <almagui@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>
In-Reply-To: <20261123223227.745345-1-almagui@kernel.org>
References: <20261123223227.745345-1-almagui@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 23, 2026 at 02:32 PM Alan Maguire <almagui@kernel.org> wrote:
> By instead creating a structure with named members, we can
> bring a Compile Once, Run Everywhere experience to parameter
> specifications via a new BPF_PROG_CORE() macro.  This will
> better handle cases like the following:

I like the idea. It sounds similar to what Ihor propopsed in the other
thread.
But implementation is kinda heavy.

Here is an alternative
and it cover tp_btf, fentry, fexit, fmod_ret, fsession and lsm progs.

Let bpf prog describe the context as

  struct bpf_func_args {
          int dfd;
          struct filename *name;
          int __ret;
  };

in a split BTF on top of the BTF of the target.
It is the only candidate for 'struct bpf_func_args___xyz' of the prog.
The rest is ordinary CO-RE.
No changes in relo_core.[ch] and in bpf_tracing.h.
The kernel does the same for lskel.

The prog:

  struct bpf_func_args___unlink {
          struct filename *name;
          int dfd;
          int __ret;
  } __attribute__((preserve_access_index));

  SEC("fexit/filename_unlinkat")
  int handle(struct bpf_func_args___unlink *ctx)
  {
          if (bpf_core_field_exists(ctx->dfd))
                  bpf_printk("dfd %d", ctx->dfd);
          bpf_printk("%s %d", ctx->name->name, ctx->__ret);
          return 0;
  }

What goes away:

  the series                            with the real struct
  ------------------------------------  -------------------------------
  FUNC as a candidate, 3 cand flags     a struct candidate
  2 decl tags, marker member for GCC    the name of the struct
  ___flavor on members                  ___flavor on the struct
  compat rules for pointers             bpf_core_type_matches()
  TYPE_EXISTS special case              bpf_core_type_exists()
  scan of all types for every relo      strncmp()
  BPF_PROG_CORE() and friends           ctx->arg

bpf_core_type_matches() compares the names of the pointed-to structs.
It covers vma vs vma___new:

  struct bpf_func_args___new {
          struct mm_area *vma;
  } __attribute__((preserve_access_index));

  if (bpf_core_type_matches(struct bpf_func_args___new))

BPF_PROG_CORE() reads a missing arg as zero.
An old libbpf finds no candidate. Every arg is zero and the prog loads.
Patches 5 and 6 exist because of that.
ctx->arg without a guard is poisoned there and the load fails.

Big endian: a small arg is in the low bytes of its slot.
btf_ctx_access() rejects such offset.
I think the 'off % 8' check can go for scalars.
Then there is no need to rewrite loads in libbpf, and int args work.

Not in the diff: that verifier change and the selftest.
tp_btf on kernels older than 5.10 fails to load.

btf.c compiles with this. I didn't compile the libbpf half and didn't
run anything:

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4e9a4d1..fb29ebf 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3446,6 +3446,7 @@ int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
 struct bpf_core_ctx {
 	struct bpf_verifier_log *log;
 	const struct btf *btf;
+	const struct bpf_prog *prog;
 };

 bool btf_nested_type_is_trusted(struct bpf_verifier_log *log,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c4386a9..c86ad9a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -10709,11 +10709,124 @@ check_modules:
 	return populate_cand_cache(cands, module_cand_cache, MODULE_CAND_CACHE_SIZE);
 }

+#define BPF_FUNC_ARGS "bpf_func_args"
+
+/*
+ * The context of tp_btf, fentry, fexit, fmod_ret, fsession and lsm progs is
+ * an array of u64 slots: the arguments of the attach target, then its return
+ * value, see btf_ctx_arg_idx(). Describe it as
+ *
+ *	struct bpf_func_args {
+ *		<type of the parameter> <name of the parameter>;
+ *		...
+ *		<return type> __ret;
+ *	};
+ *
+ * in a split BTF on top of the BTF of the target. Then the relocations
+ * against 'struct bpf_func_args___xyz' of the prog are ordinary CO-RE.
+ */
+struct func_args_btf {
+	struct btf btf;
+	struct btf_type *types[1];
+	struct bpf_core_cand cand;
+	struct btf_type t;
+	struct btf_member m[MAX_BPF_FUNC_ARGS + 1];
+};
+
+static const char func_args_strs[] = BPF_FUNC_ARGS "\0__ret";
+
+static bool bpf_core_is_func_args(const struct btf *btf, const struct btf_type *t)
+{
+	const char *name = btf_name_by_offset(btf, t->name_off);
+	size_t len = sizeof(BPF_FUNC_ARGS) - 1;
+
+	return __btf_type_is_struct(t) && name &&
+	       bpf_core_essential_name_len(name) == len &&
+	       !strncmp(name, BPF_FUNC_ARGS, len);
+}
+
+static int func_args_add(struct func_args_btf *a, u32 name_off, u32 type_id)
+{
+	const struct btf_type *t = btf_type_skip_modifiers(&a->btf, type_id, NULL);
+	u32 sz = btf_type_is_ptr(t) ? 8 : t->size;
+	u32 n = btf_type_vlen(&a->t);
+
+	if (n == ARRAY_SIZE(a->m))
+		return -E2BIG;
+
+	a->m[n].name_off = name_off;
+	a->m[n].type = type_id;
+	a->m[n].offset = a->t.size * 8;
+	/* a small argument is in the low bytes of its slot */
+	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) && sz < 8)
+		a->m[n].offset += (8 - sz) * 8;
+	a->t.size += roundup(sz, 8);
+	a->t.info = BTF_KIND_STRUCT << 24 | (n + 1);
+	return 0;
+}
+
+static struct func_args_btf *bpf_core_func_args_btf(const struct bpf_prog *prog)
+{
+	struct btf *targ_btf = prog->aux->attach_btf;
+	const struct btf_type *t = NULL;
+	const struct btf_param *p;
+	struct func_args_btf *a;
+	int i, first = 0, err = 0;
+	const char *tname;
+	char name[128];
+	s32 id;
+
+	if (targ_btf)
+		t = btf_type_by_id(targ_btf, prog->aux->attach_btf_id);
+	if (t && btf_type_is_typedef(t)) {
+		/* btf_trace_xyz has no names of parameters, __probestub_xyz() has */
+		tname = btf_name_by_offset(targ_btf, t->name_off);
+		if (strncmp(tname, "btf_trace_", 10))
+			return ERR_PTR(-EINVAL);
+		snprintf(name, sizeof(name), "__probestub_%s", tname + 10);
+		id = btf_find_by_name_kind(targ_btf, name, BTF_KIND_FUNC);
+		t = id > 0 ? btf_type_by_id(targ_btf, id) : NULL;
+		first = 1; /* void *__data is not in the context */
+	}
+	if (!t || !btf_type_is_func(t))
+		return ERR_PTR(-EINVAL);
+	t = btf_type_by_id(targ_btf, t->type);
+
+	a = kzalloc_obj(*a, GFP_KERNEL_ACCOUNT);
+	if (!a)
+		return ERR_PTR(-ENOMEM);
+
+	a->btf.base_btf = targ_btf;
+	a->btf.start_id = btf_nr_types(targ_btf);
+	a->btf.start_str_off = targ_btf->start_str_off + targ_btf->hdr.str_len;
+	a->btf.strings = func_args_strs;
+	a->btf.hdr.str_len = sizeof(func_args_strs);
+	a->btf.types = a->types;
+	a->btf.nr_types = 1;
+	a->types[0] = &a->t;
+	a->t.name_off = a->btf.start_str_off;
+	a->t.info = BTF_KIND_STRUCT << 24;
+	a->cand.btf = &a->btf;
+	a->cand.id = a->btf.start_id;
+
+	p = btf_params(t);
+	for (i = first; !err && i < btf_type_vlen(t); i++)
+		err = func_args_add(a, p[i].name_off, p[i].type);
+	if (!err && !first && t->type)
+		err = func_args_add(a, a->t.name_off + sizeof(BPF_FUNC_ARGS), t->type);
+	if (err) {
+		kfree(a);
+		return ERR_PTR(err);
+	}
+	return a;
+}
+
 int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 		   int relo_idx, void *insn)
 {
 	bool need_cands = relo->kind != BPF_CORE_TYPE_ID_LOCAL;
 	struct bpf_core_cand_list cands = {};
+	struct func_args_btf *args = NULL;
 	struct bpf_core_relo_res targ_res;
 	struct bpf_core_spec *specs;
 	const struct btf_type *type;
@@ -10734,6 +10847,19 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 		return -EINVAL;
 	}

+	if (need_cands && bpf_core_is_func_args(ctx->btf, type)) {
+		/* the prog holds attach_btf, no need for cand_cache_mutex */
+		need_cands = false;
+		args = bpf_core_func_args_btf(ctx->prog);
+		if (IS_ERR(args)) {
+			err = PTR_ERR(args);
+			args = NULL;
+			goto out;
+		}
+		cands.cands = &args->cand;
+		cands.len = 1;
+	}
+
 	if (need_cands) {
 		struct bpf_cand_cache *cc;
 		int i;
@@ -10779,6 +10905,7 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,

 out:
 	kfree(specs);
+	kfree(args);
 	if (need_cands) {
 		kfree(cands.cands);
 		mutex_unlock(&cand_cache_mutex);
diff --git a/kernel/bpf/check_btf.c b/kernel/bpf/check_btf.c
index 79e079e..e302fee 100644
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
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1efc0dd..82a532a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6256,6 +6256,18 @@ static const struct bpf_core_relo *find_relo_core(struct bpf_program *prog, int
 	return NULL;
 }

+#define BPF_FUNC_ARGS "bpf_func_args"
+
+static struct btf *bpf_program_func_args_btf(struct bpf_program *prog);
+
+static bool bpf_core_is_func_args(const struct btf_type *t, const char *name)
+{
+	size_t len = sizeof(BPF_FUNC_ARGS) - 1;
+
+	return btf_is_struct(t) && bpf_core_essential_name_len(name) == len &&
+	       strncmp(name, BPF_FUNC_ARGS, len) == 0;
+}
+
 static int bpf_core_resolve_relo(struct bpf_program *prog,
 				 const struct bpf_core_relo *relo,
 				 int relo_idx,
@@ -6279,6 +6291,25 @@ static int bpf_core_resolve_relo(struct bpf_program *prog,
 	if (!local_name)
 		return -EINVAL;

+	if (relo->kind != BPF_CORE_TYPE_ID_LOCAL &&
+	    bpf_core_is_func_args(local_type, local_name)) {
+		/* the candidate depends on the prog, keep it out of cand_cache */
+		struct bpf_core_cand_list args_cands = { .len = 1 };
+		struct bpf_core_cand args_cand;
+		struct btf *args_btf;
+
+		args_btf = bpf_program_func_args_btf(prog);
+		if (IS_ERR(args_btf))
+			return PTR_ERR(args_btf);
+		args_cand.btf = args_btf;
+		args_cand.id = btf__type_cnt(args_btf) - 1;
+		args_cands.cands = &args_cand;
+		err = bpf_core_calc_relo_insn(prog_name, relo, relo_idx, local_btf, &args_cands,
+					      specs_scratch, targ_res);
+		btf__free(args_btf);
+		return err;
+	}
+
 	if (relo->kind != BPF_CORE_TYPE_ID_LOCAL &&
 	    !hashmap__find(cand_cache, local_id, &cands)) {
 		cands = bpf_core_find_cands(prog->obj, local_btf, local_id);
@@ -11641,6 +11672,110 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attac
 	return 0;
 }

+static int func_args_add(struct btf *btf, const char *name, int type_id, __u32 *off)
+{
+	__s64 sz = btf__resolve_size(btf, type_id);
+	__u32 pad = 0;
+	int err;
+
+	if (sz < 0)
+		return sz;
+	/* a small argument is in the low bytes of its slot */
+	if (sz < 8 && btf__endianness(btf) == BTF_BIG_ENDIAN)
+		pad = 8 - sz;
+	err = btf__add_field(btf, name, type_id, (*off + pad) * 8, 0);
+	*off += roundup(sz, 8);
+	return err;
+}
+
+/*
+ * The context of tp_btf, fentry, fexit, fmod_ret, fsession and lsm progs is
+ * an array of u64 slots: the arguments of the attach target, then its return
+ * value, see btf_ctx_arg_idx() in the kernel. Describe it as
+ *
+ *	struct bpf_func_args {
+ *		<type of the parameter> <name of the parameter>;
+ *		...
+ *		<return type> __ret;
+ *	};
+ *
+ * in a split BTF on top of the BTF of the target. Then the relocations
+ * against 'struct bpf_func_args___xyz' of the prog are ordinary CO-RE.
+ */
+static struct btf *bpf_program_func_args_btf(struct bpf_program *prog)
+{
+	int btf_obj_fd = 0, id = 0, i, first = 0, err;
+	struct bpf_object *obj = prog->obj;
+	struct btf *targ_btf = obj->btf_vmlinux, *btf;
+	const struct btf_param *p;
+	const struct btf_type *t;
+	const char *name;
+	__u32 off = 0;
+
+	/* subprogs are shared and have no type */
+	if ((prog->type != BPF_PROG_TYPE_TRACING && prog->type != BPF_PROG_TYPE_LSM) ||
+	    prog->attach_prog_fd) {
+		pr_warn("prog '%s': struct %s needs an attach target in kernel BTF\n",
+			prog->name, BPF_FUNC_ARGS);
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	if (!prog->attach_btf_id) {
+		name = strchr(prog->sec_name, '/');
+		if (!name)
+			return ERR_PTR(-EINVAL);
+		err = libbpf_find_attach_btf_id(prog, name + 1, &btf_obj_fd, &id);
+		if (err)
+			return ERR_PTR(err);
+		/* libbpf_prepare_prog_load() doesn't search again */
+		prog->attach_btf_obj_fd = btf_obj_fd;
+		prog->attach_btf_id = id;
+	}
+
+	for (i = 0; prog->attach_btf_obj_fd && i < obj->btf_module_cnt; i++) {
+		if (obj->btf_modules[i].fd == prog->attach_btf_obj_fd)
+			targ_btf = obj->btf_modules[i].btf;
+	}
+
+	t = btf__type_by_id(targ_btf, prog->attach_btf_id);
+	if (t && btf_is_typedef(t)) {
+		/*
+		 * btf_trace_xyz has no names of parameters. __probestub_xyz()
+		 * has (6.5+), and __traceiter_xyz() has (5.10+).
+		 */
+		name = btf__name_by_offset(targ_btf, t->name_off) + sizeof(BTF_TRACE_PREFIX) - 1;
+		id = find_btf_by_prefix_kind(targ_btf, "__probestub_", name, BTF_KIND_FUNC);
+		if (id == -ENOENT)
+			id = find_btf_by_prefix_kind(targ_btf, "__traceiter_", name, BTF_KIND_FUNC);
+		if (id < 0)
+			return ERR_PTR(id);
+		t = btf__type_by_id(targ_btf, id);
+		first = 1; /* void *__data is not in the context */
+	}
+	if (!t || !btf_is_func(t))
+		return ERR_PTR(-EINVAL);
+	t = btf__type_by_id(targ_btf, t->type);
+
+	btf = btf__new_empty_split(targ_btf);
+	if (!btf)
+		return ERR_PTR(-errno);
+
+	id = btf__add_struct(btf, BPF_FUNC_ARGS, 0);
+	err = id < 0 ? id : 0;
+	p = btf_params(t);
+	for (i = first; !err && i < btf_vlen(t); i++)
+		err = func_args_add(btf, btf__name_by_offset(targ_btf, p[i].name_off),
+				    p[i].type, &off);
+	if (!err && !first && t->type)
+		err = func_args_add(btf, "__ret", t->type, &off);
+	if (err) {
+		btf__free(btf);
+		return ERR_PTR(err);
+	}
+	btf_type_by_id(btf, id)->size = off;
+	return btf;
+}
+
 int libbpf_attach_type_by_name(const char *name,
 			       enum bpf_attach_type *attach_type)
 {

>  .../selftests/bpf/prog_tests/func_args_core.c | 325 +++++++++++++
>  .../selftests/bpf/progs/func_args_core.c      | 241 +++++++++
>  .../selftests/bpf/progs/func_args_core_lsm.c  | 156 ++++++
>  .../bpf/progs/func_args_core_lsm_cgroup.c     |  40 ++

Also 762 lines of selftests are too much.
Pls make all of it much shorter.

pw-bot: cr
