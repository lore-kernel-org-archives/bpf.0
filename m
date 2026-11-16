Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842848;
	b=QqwP645AbgGAaV8DO6lU/SGZ/dtEW0zjvGFjc3tW7RDfb0feVPu4whbgtM2rdXyBzPAu
	 VsjXvbQ1snNAM5UZgPkQQBMzwkYrwr+mOzBwfXpxhKr9/MEnz4hmiAPJzzu4Dy1JXi6TE
	 ZutAwHWGoc9OT4FyTaGcGK+bX1ndSkhIt8gpzrrb/VFcgpHCWPWvYeeirCnIkH16GvivH
	 NMknFVT+hIGXJAlo0n5YWdj56S1Uy67pmXqUK7HE0IiyjljQ4H52AT4OTCwa73sqCy8eG
	 KsdMgv1llOUE6Aio/SgN+Nj1TCAArGfMrdPUbRpTAoAdYZShgdhxG00XEnZBVtW8WKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5YOZu9WhIwC2g5J5jDctEN/36TW2PdW7ffiR3+UmEaI=;
	b=hYdlQy7t+90ORdwJRQeJi0UQYpvrhXxIRbin4bfvr3VD8XRCA1/07eK+N3Pw3BRUvpPQ
	 beg2/SF2q1CzW1bMeHO/43lkalkL/0swqeQ82OByfaWWxsRyCG4JhBQiabhYHqYOHbWdO
	 lyNlxG4uwsYI/EGvC8bAE3A5D0kcuoNFBPZC3zMQtS/YcjymCr4WEneAPCcqyCNsriS53
	 lV3wZIHPm2M0yuNMh/FT/uGlKadJXwHVfzLxMEneJ7pDk/6T5+IeH9s4+kz3Sb6yrSS1H
	 zfBmxlb2zzcjrjub6171xEZNVy8dWFl49hFbez7JmO/KjAZykjdur559OWKg+kXMmhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UQkIIlqr;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4FD606A322
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 15:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F4FD606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UQkIIlqr
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8b3577deeb0so1749888b3a.3
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 07:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794842847; x=1795447647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5YOZu9WhIwC2g5J5jDctEN/36TW2PdW7ffiR3+UmEaI=;
        b=UQkIIlqrlAbsuxwAWEkADFcOtIOPTafGRufBEF86Eu/ngP8Q2jgstrhVEV6CWmAUi5
         UmSnRy1ZbjYPTfEp6E3ke/gTBEIcCe8bHA0EEwpHK3PxTmuFmtSpmuROCU4DUMwj/bg8
         /fZHbHeT6QhtpbV22qIg2f5AFIALy1VChY0UeQ0ZsKbx05TwC5g2CNmm6BYYecjo3Rvt
         epdxWFbZ+jQ8bxObwmvy8MEMRNH/Iukmx54Fb/PThmELMBh/M5Aqn4DLaQRDp8u+3JTi
         oxyFNpCmgfpvl3U+3QCYp0AMPCcLjLlI8QuA/rZsMWJhcL7xETOoD/r9apezWYTKCuiB
         n+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794842847; x=1795447647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5YOZu9WhIwC2g5J5jDctEN/36TW2PdW7ffiR3+UmEaI=;
        b=JUK8tmM+raMwu5ciVc7+tHx3Gx/b7EbGIzPVtpXR2qJ4ko48WkK2v4T2fT5EraWdbI
         TfZU7BVMwGKd3Q6UR76RhtwM+ykaTkn/ExFGg/by5yWhBQy7MruMgU8CpenTB13j2bCe
         iz8ejByj3yAkZJ9BzZJ3qTZT/ZP4xKPw9Aq7DfwSu9Ip99PjIKdahffgEptowWnK0E4P
         8yRYT7ZodrSmLWBjy5ququKjktXnDRwmcj98UmSPXNO9ykblKMIGq475ComcgOp3ejL0
         ZWo/EPtRK69CyZ4l2rNtAHiL0OTy045HZdfS6Dm65ayaEWs8Dy+lCEvvxOk1TCLuzkbl
         AEOQ==
X-Gm-Message-State: APuU4Z/lFWJswgIUWtwP2yrXpCcGTZkkxMz0jYSpqMq/yUCBbVQ0CAdy
	fdoG1r8W4oO4JieXyDD0yYzUdJ77f0CSOIOYwC1CQeDUd2vE2RoBUGNaT0CQBw==
X-Gm-Gg: AYBFou2nhbdX8sUul/clV5FqJVrasaKKq1Alz/AknHj38Bzlft09pki31AYxwdbWHr/
	J1V7dLRm9k18Bvd/MjeFgK0xX+CfkkFH0q5C2rWGJuig5SnukKKT3uKhOM0FtRjTup/3NLSe13w
	nA8QUDKoIBn+puDhi3vBwS3EPy2VnGRPNYF0YSJkEgor1gWQx8xTVoYCNSXUX7Wmd1f9yhph4Ss
	WFnvnNAcgHGITM6CfXutI002Q2QPODTuX4ucfrfc6puVICgUgSgPdGJR/LV4MIlUhjuvHI3siqZ
	rtb2jEp3/NkFt47ooZL8OlYfTlVzuLOoasjlArwuRuMJUxXj2F5ueDjgl0fOcpUlz5aVARa+vjS
	Z/fNlZYaPE4sPDazGOeGOtp/RwGnN1r05QZzyK0pbWU7f/Q8EiFt3tWzPlyGwgkTvKVFefcAjGa
	l8pzsBLj2Erh/ni/BKNpqYJxD3EVBUoUdkjZyMzxC4MiAL25Lws8zRaSNu+Ieou7bgy8DhWDNuC
	wT5jCEzdhFSQCGEea2UDnLFuWjlCNo8sprpg/UikbNdSE6jNMx9cLRIcfk667p6XhqRBVNqup/v
	CvMJBotKBjM8HmYu1P6CG/0xU39BpkOAlOP67vwAKgnUlzSz23bfANlVt6/KwPHdYj6h+DUyNsR
	Fd3/31H0cmb95Fr78JV1+N7zHEXiCqV6tX1hMCpua3Rjfk2eevae1oQdxV41qcr7VvwGhY7Cs8F
	l//47JRB+yJn4U62/h0zE=
X-Received: by 2002:a05:6a20:9381:b0:3f2:acd9:132e with SMTP id adf61e73a8af0-3f7a7cc8843mr9143507637.61.1794842846118;
        Mon, 16 Nov 2026 07:27:26 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2b190cfsm3834953b3a.51.2026.11.16.07.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:27:25 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 09/21] bpf: Remove the limits on kfuncs of a program
Date: Mon, 16 Nov 2026 15:26:14 +0000
Message-ID: <20261116152626.4032587-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
References: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

A program can call 256 kfuncs from 256 module BTFs. Calls in dead code
count too. Each new kfunc sorts the table again.

Append to the tables and find the entries through one index:

  (func_id, offset)               -> descriptor
  (func_id, offset, specialized)  -> descriptor of the other target
  (0, offset)                     -> BTF of the module

What stays is the width of insn->off, where JITs get the number of
the descriptor: 65536 of them.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  25 ++--
 kernel/bpf/core.c            |   2 +-
 kernel/bpf/fixups.c          |   4 +-
 kernel/bpf/syscall.c         |   2 +-
 kernel/bpf/verifier.c        | 225 ++++++++++-------------------------
 5 files changed, 79 insertions(+), 179 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4d91f665109d..508aef9bad9d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1286,6 +1286,7 @@ struct bpf_verifier_env {
 	struct bpf_map **used_maps;	/* array of map's used by eBPF program */
 	struct btf_mod_pair *used_btfs;	/* array of BTF's used by BPF program */
 	struct bpf_index used_index;	/* address of a map or BTF -> entry of these two */
+	struct bpf_index kfunc_index;	/* see kfunc_key() */
 	struct bpf_map **insn_array_maps; /* array of INSN_ARRAY map's to be relocated */
 	u32 max_key_size;		/* of all used maps and their inner maps */
 	u32 max_value_size;
@@ -2195,11 +2196,6 @@ enum bpf_reg_arg_type {
 	DST_OP_NO_MARK	/* same as above, check only, don't mark */
 };
 
-#define MAX_KFUNC_DESCS 256
-/* Each kfunc can have its canonical and one specialized call target. */
-#define MAX_KFUNC_CALL_DESCS (MAX_KFUNC_DESCS * 2)
-static_assert(MAX_KFUNC_CALL_DESCS <= S16_MAX + 1);
-
 struct bpf_kfunc_desc {
 	struct btf_func_model func_model;
 	struct bpf_func_proto proto;
@@ -2209,20 +2205,17 @@ struct bpf_kfunc_desc {
 };
 
 struct bpf_kfunc_desc_tab {
+	struct bpf_kfunc_desc *descs;
 	u32 nr_descs;
-	u32 nr_base_descs;
-	/* Sorted by func_id (BTF ID) and offset (fd_array offset) during
-	 * verification. JITs use the descriptor index stored in the finalized
-	 * call's off field. The first nr_base_descs entries are the canonical
-	 * descriptors used for verifier lookups. Call specialization may append
-	 * immutable descriptors for additional targets.
-	 *
-	 * Grown one entry at a time by bpf_add_kfunc_call() and during
-	 * call specialization.
-	 */
-	struct bpf_kfunc_desc descs[];
 };
 
+static inline void bpf_free_kfunc_tab(struct bpf_kfunc_desc_tab *tab)
+{
+	if (tab)
+		kvfree(tab->descs);
+	kfree(tab);
+}
+
 /* Functions exported from verifier.c, used by fixups.c */
 void bpf_mark_subprog_exc_cb(struct bpf_verifier_env *env, int subprog);
 bool bpf_allow_tail_call_in_subprogs(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 1b51f1d97efc..3385df367b05 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -195,7 +195,7 @@ void bpf_prog_jit_attempt_done(struct bpf_prog *prog)
 		prog->aux->jited_linfo = NULL;
 	}
 
-	kfree(prog->aux->kfunc_tab);
+	bpf_free_kfunc_tab(prog->aux->kfunc_tab);
 	prog->aux->kfunc_tab = NULL;
 }
 
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 20697eba9c5f..e05d767ab71e 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -122,10 +122,10 @@ bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
 	struct bpf_kfunc_desc_tab *tab;
 
 	tab = prog->aux->kfunc_tab;
-	if (insn->off < 0 || insn->off >= tab->nr_descs)
+	if ((u16)insn->off >= tab->nr_descs)
 		return NULL;
 
-	res = &tab->descs[insn->off];
+	res = &tab->descs[(u16)insn->off];
 	if (bpf_jit_supports_far_kfunc_call()) {
 		if (res->func_id != insn->imm)
 			return NULL;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 82c9af39e342..fb2ecc9d81f5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2489,7 +2489,7 @@ static void __bpf_prog_put_rcu_tasks(struct rcu_head *rcu)
 static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
 {
 	module_put(prog->aux->mod);
-	kfree(prog->aux->kfunc_tab);
+	bpf_free_kfunc_tab(prog->aux->kfunc_tab);
 	kfree(prog->aux->ctx_arg_info);
 	if (prog->aux->attach_btf)
 		btf_put(prog->aux->attach_btf);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b316443548ff..f4e2a9f9f787 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2690,48 +2690,28 @@ static int bpf_find_exception_callback_insn_off(struct bpf_verifier_env *env)
 	return ret;
 }
 
-#define MAX_KFUNC_BTFS	256
-
 struct bpf_kfunc_btf {
 	struct btf *btf;
 	struct module *module;
-	u16 offset;
 };
 
 struct bpf_kfunc_btf_tab {
-	struct bpf_kfunc_btf descs[MAX_KFUNC_BTFS];
+	struct bpf_kfunc_btf *descs;
 	u32 nr_descs;
 };
 
-static int kfunc_desc_cmp_by_id_off(const void *a, const void *b)
+/* The key of env->kfunc_index. The BTF of a module has func_id 0. */
+static u64 kfunc_key(u32 func_id, u16 offset, bool specialized)
 {
-	const struct bpf_kfunc_desc *d0 = a;
-	const struct bpf_kfunc_desc *d1 = b;
-
-	/* func_id is not greater than BTF_MAX_TYPE */
-	return d0->func_id - d1->func_id ?: d0->offset - d1->offset;
-}
-
-static int kfunc_btf_cmp_by_off(const void *a, const void *b)
-{
-	const struct bpf_kfunc_btf *d0 = a;
-	const struct bpf_kfunc_btf *d1 = b;
-
-	return d0->offset - d1->offset;
+	return func_id | (u64)offset << 32 | (u64)specialized << 48;
 }
 
 static struct bpf_kfunc_desc *
-find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset)
+find_kfunc_desc(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 {
-	struct bpf_kfunc_desc desc = {
-		.func_id = func_id,
-		.offset = offset,
-	};
-	struct bpf_kfunc_desc_tab *tab;
+	int i = bpf_index_find(&env->kfunc_index, kfunc_key(func_id, offset, false));
 
-	tab = prog->aux->kfunc_tab;
-	return bsearch(&desc, tab->descs, tab->nr_base_descs,
-		       sizeof(tab->descs[0]), kfunc_desc_cmp_by_id_off);
+	return func_id && i >= 0 ? &env->prog->aux->kfunc_tab->descs[i] : NULL;
 }
 
 int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
@@ -2831,50 +2811,38 @@ static struct btf *fd_array_get_btf(struct bpf_verifier_env *env, u32 idx)
 static struct btf *__find_kfunc_desc_btf(struct bpf_verifier_env *env,
 					 s16 offset)
 {
-	struct bpf_kfunc_btf kf_btf = { .offset = offset };
-	struct bpf_kfunc_btf_tab *tab;
+	struct bpf_kfunc_btf_tab *tab = env->prog->aux->kfunc_btf_tab;
+	int i = bpf_index_find(&env->kfunc_index, kfunc_key(0, offset, false));
 	struct bpf_kfunc_btf *b;
 	struct module *mod;
 	struct btf *btf;
 
-	tab = env->prog->aux->kfunc_btf_tab;
-	b = bsearch(&kf_btf, tab->descs, tab->nr_descs,
-		    sizeof(tab->descs[0]), kfunc_btf_cmp_by_off);
-	if (!b) {
-		if (tab->nr_descs == MAX_KFUNC_BTFS) {
-			verbose(env, "too many different module BTFs\n");
-			return ERR_PTR(-E2BIG);
-		}
-
-		btf = fd_array_get_btf(env, offset);
-		if (IS_ERR(btf))
-			return btf;
-		if (!btf_is_module(btf)) {
-			verbose(env, "BTF fd for kfunc is not a module BTF\n");
-			btf_put(btf);
-			return ERR_PTR(-EINVAL);
-		}
+	if (i >= 0)
+		return tab->descs[i].btf;
 
-		mod = btf_try_get_module(btf);
-		if (!mod) {
-			btf_put(btf);
-			return ERR_PTR(-ENXIO);
-		}
+	b = bpf_table_next(tab->descs, tab->nr_descs);
+	if (!b)
+		return ERR_PTR(-ENOMEM);
 
-		b = &tab->descs[tab->nr_descs++];
-		b->btf = btf;
-		b->module = mod;
-		b->offset = offset;
+	btf = fd_array_get_btf(env, offset);
+	if (IS_ERR(btf))
+		return btf;
+	if (!btf_is_module(btf)) {
+		verbose(env, "BTF fd for kfunc is not a module BTF\n");
+		btf_put(btf);
+		return ERR_PTR(-EINVAL);
+	}
 
-		/* sort() reorders entries by value, so b may no longer point
-		 * to the right entry after this
-		 */
-		sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
-		     kfunc_btf_cmp_by_off, NULL);
-	} else {
-		btf = b->btf;
+	mod = btf_try_get_module(btf);
+	if (!mod) {
+		btf_put(btf);
+		return ERR_PTR(-ENXIO);
 	}
 
+	b->btf = btf;
+	b->module = mod;
+	if (bpf_index_add(&env->kfunc_index, kfunc_key(0, offset, false), tab->nr_descs++))
+		return ERR_PTR(-ENOMEM);
 	return btf;
 }
 
@@ -2887,6 +2855,7 @@ void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab)
 		module_put(tab->descs[tab->nr_descs].module);
 		btf_put(tab->descs[tab->nr_descs].btf);
 	}
+	kvfree(tab->descs);
 	kfree(tab);
 }
 
@@ -2908,22 +2877,14 @@ static struct btf *find_kfunc_desc_btf(struct bpf_verifier_env *env, s16 offset)
 
 static struct btf *find_kfunc_desc_btf_cached(struct bpf_verifier_env *env, s16 offset)
 {
-	struct bpf_kfunc_btf kf_btf = { .offset = offset };
-	struct bpf_kfunc_btf_tab *tab;
-	struct bpf_kfunc_btf *b;
+	int i = bpf_index_find(&env->kfunc_index, kfunc_key(0, offset, false));
 
 	if (!offset)
 		return btf_vmlinux ?: ERR_PTR(-ENOENT);
 	if (offset < 0)
 		return ERR_PTR(-EINVAL);
 
-	tab = env->prog->aux->kfunc_btf_tab;
-	if (!tab)
-		return ERR_PTR(-ENOENT);
-
-	b = bsearch(&kf_btf, tab->descs, tab->nr_descs,
-		    sizeof(tab->descs[0]), kfunc_btf_cmp_by_off);
-	return b ? b->btf : ERR_PTR(-ENOENT);
+	return i >= 0 ? env->prog->aux->kfunc_btf_tab->descs[i].btf : ERR_PTR(-ENOENT);
 }
 
 #define KF_IMPL_SUFFIX "_impl"
@@ -3081,19 +3042,9 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 		prog_aux->kfunc_btf_tab = btf_tab;
 	}
 
-	if (find_kfunc_desc(env->prog, func_id, offset))
+	if (find_kfunc_desc(env, func_id, offset))
 		return 0;
 
-	if (tab->nr_base_descs == MAX_KFUNC_DESCS) {
-		verbose(env, "too many different kernel function calls\n");
-		return -E2BIG;
-	}
-	if (tab->nr_descs != tab->nr_base_descs) {
-		verifier_bug(env, "unexpected specialized func desc found (%d descs, %d base descs)",
-			     tab->nr_descs, tab->nr_base_descs);
-		return -EFAULT;
-	}
-
 	err = fetch_kfunc_meta(env, func_id, offset, &kfunc);
 	if (err)
 		return err;
@@ -3133,12 +3084,9 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 	meta.func_name = kfunc.name;
 	meta.kfunc_flags = kfunc.flags ? *kfunc.flags : 0;
 
-	tab = krealloc(tab, struct_size(tab, descs, tab->nr_descs + 1), BPF_VERIFIER_GFP);
-	if (!tab)
+	desc = bpf_table_next(tab->descs, tab->nr_descs);
+	if (!desc)
 		return -ENOMEM;
-	prog_aux->kfunc_tab = tab;
-
-	desc = &tab->descs[tab->nr_descs];
 	memset(desc, 0, sizeof(*desc));
 
 	err = gen_kfunc_arg_proto(env, &meta, &func_model, &desc->proto);
@@ -3149,11 +3097,7 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 	desc->offset = offset;
 	desc->addr = addr;
 	desc->func_model = func_model;
-	tab->nr_descs++;
-	tab->nr_base_descs++;
-	sort(tab->descs, tab->nr_base_descs, sizeof(tab->descs[0]),
-	     kfunc_desc_cmp_by_id_off, NULL);
-	return 0;
+	return bpf_index_add(&env->kfunc_index, kfunc_key(func_id, offset, false), tab->nr_descs++);
 }
 
 static int add_subprogs(struct bpf_verifier_env *env)
@@ -3260,7 +3204,7 @@ static int add_kfuncs(struct bpf_verifier_env *env)
 			return -EPERM;
 		}
 
-		ret = bpf_add_kfunc_call(env, insn->imm, insn->off);
+		ret = bpf_must_abort() ? -EINTR : bpf_add_kfunc_call(env, insn->imm, insn->off);
 		if (ret < 0)
 			return ret;
 	}
@@ -15042,7 +14986,7 @@ bool bpf_needs_fixed_stack_off(struct bpf_verifier_env *env, int insn_idx)
 		if (bpf_get_helper_proto(env, insn->imm, &fn) < 0)
 			return false;
 	} else if (bpf_pseudo_kfunc_call(insn)) {
-		desc = find_kfunc_desc(env->prog, insn->imm, insn->off);
+		desc = find_kfunc_desc(env, insn->imm, insn->off);
 		if (!desc)
 			return false;
 		fn = &desc->proto;
@@ -15520,7 +15464,7 @@ static u16 call_arg_regs(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	u16 mask = 0;
 
 	if (bpf_pseudo_kfunc_call(insn)) {
-		desc = find_kfunc_desc(env->prog, insn->imm, insn->off);
+		desc = find_kfunc_desc(env, insn->imm, insn->off);
 		if (!desc)
 			return 0;
 		fn = &desc->proto;
@@ -15961,7 +15905,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	func_name = meta.func_name;
 	insn_aux = &env->insn_aux_data[insn_idx];
 
-	desc = find_kfunc_desc(env->prog, insn->imm, insn->off);
+	desc = find_kfunc_desc(env, insn->imm, insn->off);
 	if (!desc) {
 		verifier_bug(env, "kfunc descriptor not found for func_id %u", insn->imm);
 		return -EFAULT;
@@ -24703,64 +24647,21 @@ static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
 	return 0;
 }
 
-static int add_kfunc_desc_target(struct bpf_verifier_env *env,
-				 const struct bpf_kfunc_desc *target_desc,
-				 u16 base_desc_idx, u16 *desc_idx)
+/* A kfunc has at most one specialized target. Returns the index of its descriptor. */
+static int add_specialized_kfunc(struct bpf_verifier_env *env, const struct bpf_kfunc_desc *desc)
 {
-	struct bpf_kfunc_desc desc = *target_desc;
-	struct bpf_kfunc_desc_tab *new_tab;
-	struct bpf_kfunc_desc_tab *tab;
-	struct bpf_prog_aux *prog_aux;
-	u32 i;
-
-	prog_aux = env->prog->aux;
-	tab = prog_aux->kfunc_tab;
-
-	if (base_desc_idx >= tab->nr_base_descs) {
-		verifier_bug(env, "kfunc desc_idx %d out of bounds (%d descriptors)",
-				base_desc_idx, tab->nr_base_descs);
-		return -EFAULT;
-	}
-	if (tab->descs[base_desc_idx].func_id != desc.func_id) {
-		verifier_bug(env, "kfunc desc %d has invalid id (expected %d, got %d)",
-				base_desc_idx, tab->descs[base_desc_idx].func_id, desc.func_id);
-		return -EFAULT;
-	}
-	if (tab->descs[base_desc_idx].offset != desc.offset) {
-		verifier_bug(env, "kfunc desc %d has invalid offset (expected %d, got %d)",
-				base_desc_idx, tab->descs[base_desc_idx].offset, desc.offset);
-		return -EFAULT;
-	}
-
-	if (tab->descs[base_desc_idx].addr == desc.addr) {
-		*desc_idx = base_desc_idx;
-		return 0;
-	}
+	struct bpf_kfunc_desc_tab *tab = env->prog->aux->kfunc_tab;
+	u64 key = kfunc_key(desc->func_id, desc->offset, true);
+	int i = bpf_index_find(&env->kfunc_index, key);
 
-	for (i = tab->nr_base_descs; i < tab->nr_descs; i++) {
-		if (tab->descs[i].func_id == desc.func_id &&
-		    tab->descs[i].offset == desc.offset &&
-		    tab->descs[i].addr == desc.addr) {
-			*desc_idx = i;
-			return 0;
-		}
-	}
-
-	if (tab->nr_descs == MAX_KFUNC_CALL_DESCS) {
-		verbose(env, "too many different kernel function call targets\n");
-		return -E2BIG;
-	}
-
-	new_tab = krealloc(tab, struct_size(tab, descs, tab->nr_descs + 1),
-			   BPF_VERIFIER_GFP);
-	if (!new_tab)
+	if (i >= 0)
+		return verifier_bug_if(tab->descs[i].addr != desc->addr, env,
+				       "two targets of kfunc %u", desc->func_id) ? -EFAULT : i;
+	if (!bpf_table_next(tab->descs, tab->nr_descs) ||
+	    bpf_index_add(&env->kfunc_index, key, tab->nr_descs))
 		return -ENOMEM;
-	tab = new_tab;
-	prog_aux->kfunc_tab = tab;
-
-	*desc_idx = tab->nr_descs;
-	tab->descs[tab->nr_descs++] = desc;
-	return 0;
+	tab->descs[tab->nr_descs] = *desc;
+	return tab->nr_descs++;
 }
 
 static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
@@ -24786,9 +24687,8 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	struct bpf_kfunc_desc desc_copy;
 	struct bpf_kfunc_desc *desc;
 	unsigned long call_imm;
-	u16 base_desc_idx, desc_idx;
+	int err, desc_idx;
 	bool near_call;
-	int err;
 
 	if (!insn->imm) {
 		verbose(env, "invalid kernel function call not eliminated in verifier pass\n");
@@ -24801,13 +24701,13 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	 * __bpf_call_base, unless the JIT needs to call functions that are
 	 * further than 32 bits away (bpf_jit_supports_far_kfunc_call()).
 	 */
-	desc = find_kfunc_desc(env->prog, insn->imm, insn->off);
+	desc = find_kfunc_desc(env, insn->imm, insn->off);
 	if (!desc) {
 		verifier_bug(env, "kernel function descriptor not found for func_id %u",
 			     insn->imm);
 		return -EFAULT;
 	}
-	base_desc_idx = desc - env->prog->aux->kfunc_tab->descs;
+	desc_idx = desc - env->prog->aux->kfunc_tab->descs;
 
 	near_call = !bpf_jit_supports_far_kfunc_call();
 	desc_copy = *desc;
@@ -24827,9 +24727,15 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn->imm = call_imm;
 	}
 
-	err = add_kfunc_desc_target(env, desc, base_desc_idx, &desc_idx);
-	if (err)
-		return err;
+	if (desc->addr != env->prog->aux->kfunc_tab->descs[desc_idx].addr)
+		desc_idx = add_specialized_kfunc(env, desc);
+	if (desc_idx < 0)
+		return desc_idx;
+	/* JITs find the descriptor by insn->off */
+	if (desc_idx > U16_MAX) {
+		verbose(env, "too many different kernel function calls\n");
+		return -E2BIG;
+	}
 	insn->off = desc_idx;
 
 	if (is_bpf_obj_new_kfunc(desc->func_id) || is_bpf_percpu_obj_new_kfunc(desc->func_id)) {
@@ -25596,6 +25502,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	bpf_patch_list_free(env);
 	kvfree(env->fd_array);
 	kvfree(env->used_index.slots);
+	kvfree(env->kfunc_index.slots);
 	kvfree(env->insn_array_maps);
 	bpf_free_scev(env);
 	kvfree(env->walk_insns);
-- 
2.55.0

