Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808616;
	b=L5SUHKVB2HpCIbkYoLDB8IZBVhv4PLfAcbrg4OWAqEuUdY8dztlF1nQk03uE8zpkS2nv
	 08Ed17sNV1WtNICXTeFLfDXFJOsNoH8+vgtFkvIKMYpGxYtZf+mi1d+FqmzoKZtw4xNKb
	 eZkBkwbK0gIYo/t1FyNyf4uB7/oyOwszyjEwyMPK9saDcmK/h2zbP61cjefQWBQMoD24T
	 iWNygzCysPi4c1KYw5V+xO+XeZnSLJ5R1sdVlt1BaC88Oj7QGcyWJUtfWwFTFcBRjvh8H
	 d157mDvKOvPuwbCF9m7aE/XPIr68mG9T71fJOJ6/8OQpwvt/SQXS6yN9JJJkPHl4v4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kB+aihfPoIgmxOI7wSBU4fuM2f2ZuVOsPlsn8m29oF8=;
	b=GgpeH5lBubJkdUFlZbpSbq4Xa2mq++hg8otRQkOa2orJ/shlZ61Xfg5E5pk+QUw69Z86
	 n4tavuxPOAT8457c1zcn4dK3rMTZ0Gr6K3nOtGmdGQg8eThowWalQyF+QMGwLVTP76zvo
	 O+EZWkP29/JMkBdwGwKwqgBiZa3ZnAZJvLeoN4FMlFGYzlleSQ/cxMFSVvuvUfPR4Ndqb
	 egKZLOaAG0rbCtNfHpma70Iw+4yWMAfnytKwDQ5IJDS/PrpN7ygfmHKn7aGME2i1rHZ8g
	 CDj1i4ktYqwH6Bp07TLwb8fxyzHY+MYfCGwS1r7XjUJKNmN/LxOvHH4HEYtQ5pwpJAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mZVqVgzq;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208DB606A323
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 05:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 208DB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mZVqVgzq
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdb684859cbso2277501a12.1
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 21:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794808614; x=1795413414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kB+aihfPoIgmxOI7wSBU4fuM2f2ZuVOsPlsn8m29oF8=;
        b=mZVqVgzqhyKG0R5fNW/4OCs8T7EC7KSBlH/O2oGDIkiqJzB0QyODUOphff/O4wEjTg
         7doqFnneIsRhMjM10UmwBUvbiZiZ09pudBP2y1fUdWkpRDlsovZoYDu1gEKf+EkY63Yi
         PTp0D/r9t/qDX33z7+JM209+y3or0qjB7TSvIhwaVoQMjqik5FbSLIEIaXDNShYINV4w
         i4rSKJjb2wppC1KhEJ+Oe3x/tXp39tgfv1PC37gd8nKTFNMDZVpjjAKaFEteQsAzakmn
         DKmMyI8+LqSM6FQIXMFAuFkfFjgvKRvmWI9LuZhf1bG23ZJvcgTlvYbzDUibwmlJa6yf
         0Juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794808614; x=1795413414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kB+aihfPoIgmxOI7wSBU4fuM2f2ZuVOsPlsn8m29oF8=;
        b=zkfZW7rvylI8PETkWowjeG/y2MyTKDWqRMItNA0CX+nct/IDDh7M76G3g69gn5YMcz
         rc/0BXSK3KLGjyLV8c0mzuGcgrQSm+OLqgOghH1TDfc5h7alMIKEXCXyM1n5CGbAiax6
         KonLpy7DAPlU6A3IcDBuzkCCGjWWKXBxxN2F9xXivPb+vJBlF69v1Zi8hA0myTrBPwko
         gq6sJvY+eAYA4CVRX0WEB3u8j2dBtZALqI6LlB3x5uJIiOuBxBXi6ck6AcG6VUGZ4l6f
         Ii6Ri6Uwxsy1gsl1sOx46rkLylToXs4J4h9uvqqCVD0eKV+F0xmGCEidoeKGnYhJStP/
         2i2w==
X-Gm-Message-State: APuU4Z/p/KD9Aa/nAVuP8mdejntIMwsd8hzrS5jfjF4laYqM7714jQzn
	H3m2uEcTCkgKesjcdtfHYU8P3lvZQEScnPDveZ9KoiOkFA5MMJMoOaxB3AHDcg==
X-Gm-Gg: AZFdTZdGYUWGiJmZ8GdjFB+UEUwVS+RhRqLr6wIDIwIAKLLFvUpPLi/F8OwlCyJgTth
	hovjDsA+hZVFua6ar+zSANeWPlbSyOQ6sSeha/XlPaC0ZGgvvsGPdcRxnv84hJEKkx/gbvDLKr3
	4qSRMan3g4PGlgYbREy2mz7UeGVSBuO+oYCgge81x7cEBK+CxeZYix0kWZ9tsiBfm/g7ggVYBgL
	LX9C5EqwyI2MZYGggLgvu7CFUZZKnKAL3Yd9GB9OcqqM1LqN424Ibgl0M63Gq5LcrecEfurGX7G
	9JmqPvxA1Bw0EQ6EgK6FjrnwFPCON4z1AeZhbkjudN6LF1hnW88Y7F4paubGRoPMbqL4j3zbXBc
	cQY+NlqkifAXgXbjSuSb5HKV7MhTWUlXpNijQBfg6SOMMDsbnD+Wggg9ho0wh1f3zN5YnZcgbHi
	j9Q+stQaET2jaiGm7v9IJgA9og9djaIXfkb3aXJx6dE4sMk/WmZzShbwLIvpOzY5Musd+vW4dCp
	43liCf1cXlI85S/wbYP9gpfGSLMR+Dg5uQxaPTGmxlEX87XlEGV6/N1x996xyO5UucURA7tjlHq
	ezQDRdqKe4SLhnQXI++ku8ts6OeBmYnf8bv7tfSEN9FqU/ymCDsmBnD5TmJ8Z0/yC3XYgazVkpf
	TVY1sst86SjBKGk5xbLKhyH2WuRQ1irgNtsewU4zZ6XzvFfECr4aGdq6YE07I2lqZf3t5Z52KWg
	==
X-Received: by 2002:a17:90b:4cc7:b0:3ab:884b:65a9 with SMTP id 98e67ed59e1d1-3b1b09fcbfemr10137895a91.25.1794808614076;
        Sun, 15 Nov 2026 21:56:54 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d04336sm20623974a91.7.2026.11.15.21.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 21:56:53 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 02/21] bpf: Fail the load when there is no memory
Date: Mon, 16 Nov 2026 05:56:19 +0000
Message-ID: <20261116055638.4171529-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
References: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
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

The verifier allocates with GFP_KERNEL_ACCOUNT. At the limit of the memory
cgroup this wakes up the OOM killer, and the loader dies:

  memory.max = 64M, program needs 120M
  before:  Killed
  after:   bpf() = -ENOMEM

Use one mask for all allocations of the verifier. Most of the patch is:

  sed -i 's/GFP_KERNEL_ACCOUNT/BPF_VERIFIER_GFP/'

The rest:
 - BPF_PROG_LOAD passes the flags to bpf_prog_alloc() and friends.
   Classic BPF does not, except for the patch list of constant blinding.
 - -ENOMEM in front of the JIT fails the load. There is no fall back to
   the interpreter. A failed bpf_prog_alloc() gives -ENOMEM, not -EINVAL.

With __GFP_RETRY_MAYFAIL kvmalloc() may reclaim and compact for a table
of up to 4 MB before it uses vmalloc().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  4 ++
 kernel/bpf/cfg.c             | 14 +++----
 kernel/bpf/check_btf.c       |  6 +--
 kernel/bpf/const_fold.c      |  4 +-
 kernel/bpf/core.c            | 20 +++++-----
 kernel/bpf/diagnostics.c     |  8 ++--
 kernel/bpf/fixups.c          | 22 +++++------
 kernel/bpf/flow.c            | 70 +++++++++++++++++-----------------
 kernel/bpf/join.c            |  2 +-
 kernel/bpf/liveness.c        | 26 ++++++-------
 kernel/bpf/log.c             |  2 +-
 kernel/bpf/loops.c           | 16 ++++----
 kernel/bpf/scev.c            | 22 +++++------
 kernel/bpf/syscall.c         |  6 +--
 kernel/bpf/verifier.c        | 74 ++++++++++++++++++------------------
 15 files changed, 150 insertions(+), 146 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index ecb988ab6349..2f15b43074d1 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -13,6 +13,10 @@
 #include <linux/freezer.h>
 #include <linux/sched/signal.h>
 
+/* No memory fails the load. It does not wake up the OOM killer. */
+#define BPF_GFP_MAYFAIL (__GFP_RETRY_MAYFAIL | __GFP_NOWARN)
+#define BPF_VERIFIER_GFP (GFP_KERNEL_ACCOUNT | BPF_GFP_MAYFAIL)
+
 /*
  * For each loop that can run long. The caller returns -EINTR.
  *   killed          the task dies
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 163fdb21828f..40aafceb139e 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -188,7 +188,7 @@ struct bpf_iarray *bpf_iarray_realloc(struct bpf_iarray *old, size_t n_elem)
 	size_t new_size = sizeof(struct bpf_iarray) + n_elem * sizeof(old->items[0]);
 	struct bpf_iarray *new;
 
-	new = kvrealloc(old, new_size, GFP_KERNEL_ACCOUNT);
+	new = kvrealloc(old, new_size, BPF_VERIFIER_GFP);
 	if (!new) {
 		/* this is what callers always want, so simplify the call site */
 		kvfree(old);
@@ -663,12 +663,12 @@ int bpf_check_cfg(struct bpf_verifier_env *env)
 	int ex_insn_beg, i, ret = 0;
 
 	insn_state = env->cfg.insn_state = kvzalloc_objs(int, insn_cnt,
-							 GFP_KERNEL_ACCOUNT);
+							 BPF_VERIFIER_GFP);
 	if (!insn_state)
 		return -ENOMEM;
 
 	insn_stack = env->cfg.insn_stack = kvzalloc_objs(int, insn_cnt,
-							 GFP_KERNEL_ACCOUNT);
+							 BPF_VERIFIER_GFP);
 	if (!insn_stack) {
 		kvfree(insn_state);
 		return -ENOMEM;
@@ -771,10 +771,10 @@ int bpf_compute_postorder(struct bpf_verifier_env *env)
 	struct dfs_state *state = NULL;
 	struct bpf_iarray *succ = NULL;
 
-	postorder_nums = kvzalloc_objs(int, env->prog->len, GFP_KERNEL_ACCOUNT);
-	postorder = kvzalloc_objs(int, env->prog->len, GFP_KERNEL_ACCOUNT);
-	stack = kvzalloc_objs(int, env->prog->len, GFP_KERNEL_ACCOUNT);
-	state = kvzalloc_objs(struct dfs_state, env->prog->len, GFP_KERNEL_ACCOUNT);
+	postorder_nums = kvzalloc_objs(int, env->prog->len, BPF_VERIFIER_GFP);
+	postorder = kvzalloc_objs(int, env->prog->len, BPF_VERIFIER_GFP);
+	stack = kvzalloc_objs(int, env->prog->len, BPF_VERIFIER_GFP);
+	state = kvzalloc_objs(struct dfs_state, env->prog->len, BPF_VERIFIER_GFP);
 	if (!postorder_nums || !postorder || !stack || !state) {
 		kvfree(postorder_nums);
 		kvfree(postorder);
diff --git a/kernel/bpf/check_btf.c b/kernel/bpf/check_btf.c
index d6b930377d75..77dfb45708b6 100644
--- a/kernel/bpf/check_btf.c
+++ b/kernel/bpf/check_btf.c
@@ -63,7 +63,7 @@ static int prepare_btf_func(struct bpf_verifier_env *env,
 	urecord = make_bpfptr(attr->func_info, uattr.is_kernel);
 	min_size = min_t(u32, krec_size, urec_size);
 
-	krecord = kvcalloc(nfuncs, krec_size, GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
+	krecord = kvcalloc(nfuncs, krec_size, BPF_VERIFIER_GFP);
 	if (!krecord)
 		return -ENOMEM;
 
@@ -164,7 +164,7 @@ static int check_btf_func(struct bpf_verifier_env *env,
 
 	krecord = prog->aux->func_info;
 	info_aux = kzalloc_objs(*info_aux, nfuncs,
-				GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
+				BPF_VERIFIER_GFP);
 	if (!info_aux)
 		return -ENOMEM;
 
@@ -242,7 +242,7 @@ static int check_btf_line(struct bpf_verifier_env *env,
 	 * pass in a smaller bpf_line_info object.
 	 */
 	linfo = kvzalloc_objs(struct bpf_line_info, nr_linfo,
-			      GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
+			      BPF_VERIFIER_GFP);
 	if (!linfo)
 		return -ENOMEM;
 
diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
index 5869730547ae..1fd97f624b94 100644
--- a/kernel/bpf/const_fold.c
+++ b/kernel/bpf/const_fold.c
@@ -253,7 +253,7 @@ int bpf_compute_const_regs(struct bpf_verifier_env *env)
 	int i, r, t;
 
 	/* kvzalloc zeroes memory, so all entries start as CONST_ARG_UNVISITED (0) */
-	ci_in = kvzalloc_objs(*ci_in, insn_cnt, GFP_KERNEL_ACCOUNT);
+	ci_in = kvzalloc_objs(*ci_in, insn_cnt, BPF_VERIFIER_GFP);
 	if (!ci_in)
 		return -ENOMEM;
 
@@ -572,7 +572,7 @@ int bpf_compute_leave_conds(struct bpf_verifier_env *env)
 	bool jump;
 	u64 any;
 
-	env->leave_conds = kvcalloc(env->prog->len, sizeof(*p), GFP_KERNEL_ACCOUNT);
+	env->leave_conds = kvcalloc(env->prog->len, sizeof(*p), BPF_VERIFIER_GFP);
 	if (!env->leave_conds)
 		return -ENOMEM;
 	for (i = 0; i < env->cfg.cur_postorder; i++) {
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index b407b2393ac3..09abfed83109 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -180,7 +180,7 @@ int bpf_prog_alloc_jited_linfo(struct bpf_prog *prog)
 
 	prog->aux->jited_linfo = kvzalloc_objs(*prog->aux->jited_linfo,
 					       prog->aux->nr_linfo,
-					       bpf_memcg_flags(GFP_KERNEL | __GFP_NOWARN));
+					       bpf_memcg_flags(GFP_KERNEL | BPF_GFP_MAYFAIL));
 	if (!prog->aux->jited_linfo)
 		return -ENOMEM;
 
@@ -309,7 +309,7 @@ int bpf_prog_calc_tag(struct bpf_prog *fp)
 	bool was_ld_map;
 	u32 i;
 
-	dst = __vmalloc(size, GFP_KERNEL_ACCOUNT);
+	dst = __vmalloc(size, BPF_VERIFIER_GFP);
 	if (!dst)
 		return -ENOMEM;
 
@@ -349,7 +349,7 @@ static int patch_list_reserve_patch(struct bpf_patch_list *pl)
 		return 0;
 
 	cap = max(pl->cap * 2, 16U);
-	p = kvrealloc(pl->patches, array_size(cap, sizeof(*p)), GFP_KERNEL_ACCOUNT);
+	p = kvrealloc(pl->patches, array_size(cap, sizeof(*p)), BPF_VERIFIER_GFP);
 	if (!p)
 		return -ENOMEM;
 	pl->patches = p;
@@ -366,7 +366,7 @@ static int patch_list_reserve_insns(struct bpf_patch_list *pl, u32 cnt)
 		return 0;
 
 	cap = max3(pl->insn_cap * 2, pl->insn_cnt + cnt, 64U);
-	insns = kvrealloc(pl->insns, array_size(cap, sizeof(*insns)), GFP_KERNEL_ACCOUNT);
+	insns = kvrealloc(pl->insns, array_size(cap, sizeof(*insns)), BPF_VERIFIER_GFP);
 	if (!insns)
 		return -ENOMEM;
 	pl->insns = insns;
@@ -619,7 +619,7 @@ static int patch_image_map_linfo(struct bpf_patch_image *img, const struct bpf_p
 	const struct bpf_line_info *linfo = prog->aux->linfo;
 	u32 i, j, pos, next, nr = prog->aux->nr_linfo;
 
-	img->new_linfo = kvmalloc_array(nr + 1, sizeof(u32), GFP_KERNEL_ACCOUNT);
+	img->new_linfo = kvmalloc_array(nr + 1, sizeof(u32), BPF_VERIFIER_GFP);
 	if (!img->new_linfo)
 		return -ENOMEM;
 	img->nr_linfo = nr;
@@ -656,8 +656,8 @@ int bpf_patch_list_build(const struct bpf_patch_list *pl, const struct bpf_prog
 
 	memset(img, 0, sizeof(*img));
 	img->cnt = cnt;
-	img->new_off = kvmalloc_array(cnt + 1, sizeof(u32), GFP_KERNEL_ACCOUNT);
-	img->new_tgt = kvmalloc_array(cnt + 1, sizeof(u32), GFP_KERNEL_ACCOUNT);
+	img->new_off = kvmalloc_array(cnt + 1, sizeof(u32), BPF_VERIFIER_GFP);
+	img->new_tgt = kvmalloc_array(cnt + 1, sizeof(u32), BPF_VERIFIER_GFP);
 	if (!img->new_off || !img->new_tgt)
 		return -ENOMEM;
 
@@ -678,7 +678,7 @@ int bpf_patch_list_build(const struct bpf_patch_list *pl, const struct bpf_prog
 			return err;
 	}
 
-	img->insns = kvmalloc_array(img->new_cnt, sizeof(*img->insns), GFP_KERNEL_ACCOUNT);
+	img->insns = kvmalloc_array(img->new_cnt, sizeof(*img->insns), BPF_VERIFIER_GFP);
 	if (!img->insns)
 		return -ENOMEM;
 
@@ -3017,10 +3017,10 @@ static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struc
 	prog = bpf_jit_blind_constants(env, prog);
 	/*
 	 * Fall back to the interpreter after blinding failures, except when
-	 * the loader was killed.
+	 * the load has to stop or has no memory.
 	 */
 	if (IS_ERR(prog)) {
-		if (PTR_ERR(prog) == -EINTR)
+		if (PTR_ERR(prog) == -EINTR || (env && PTR_ERR(prog) == -ENOMEM))
 			return prog;
 		goto out_restore;
 	}
diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 3de3e1486bbd..5783fa20f568 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -234,7 +234,7 @@ int bpf_diag_init(struct bpf_verifier_env *env)
 	if (!bpf_diag_enabled(env))
 		return 0;
 
-	env->diag = kzalloc_obj(struct bpf_diag, GFP_KERNEL_ACCOUNT);
+	env->diag = kzalloc_obj(struct bpf_diag, BPF_VERIFIER_GFP);
 	if (!env->diag)
 		return -ENOMEM;
 
@@ -266,7 +266,7 @@ static char *diag_fmt_alloc(struct bpf_verifier_env *env, size_t size)
 	}
 
 	capacity = max_t(size_t, BPF_DIAG_FMT_CHUNK_SIZE, size);
-	chunk = kmalloc_flex(*chunk, data, capacity, GFP_KERNEL_ACCOUNT);
+	chunk = kmalloc_flex(*chunk, data, capacity, BPF_VERIFIER_GFP);
 	if (!chunk)
 		return NULL;
 
@@ -456,7 +456,7 @@ static void diag_append_history(struct bpf_verifier_env *env,
 		goto rotate;
 
 	cap = min(log->cap ? log->cap * 2 : 64, max_events);
-	events = kvrealloc(log->events, array_size(cap, sizeof(*events)), GFP_KERNEL_ACCOUNT);
+	events = kvrealloc(log->events, array_size(cap, sizeof(*events)), BPF_VERIFIER_GFP);
 	if (!events) {
 		log->growth_failed = true;
 		goto rotate;
@@ -542,7 +542,7 @@ static void diag_vprint_indented(struct bpf_verifier_env *env, const char *fmt,
 	if (!bpf_diag_enabled(env))
 		return;
 
-	buf = kvasprintf(GFP_KERNEL_ACCOUNT, fmt, args);
+	buf = kvasprintf(BPF_VERIFIER_GFP, fmt, args);
 	if (!buf) {
 		diag_write(env, "%s<failed to allocate diagnostic text>\n", BPF_DIAG_TEXT_INDENT);
 		return;
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 735932392a87..8d1dd0770711 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -507,11 +507,11 @@ int bpf_patch_list_commit(struct bpf_verifier_env *env)
 
 	err = -ENOMEM;
 	data = __vmalloc(array_size(img.new_cnt, sizeof(*data)),
-			 GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+			 BPF_VERIFIER_GFP | __GFP_ZERO);
 	if (!data)
 		goto out;
 
-	prog = bpf_prog_realloc(prog, bpf_prog_size(img.new_cnt), GFP_USER);
+	prog = bpf_prog_realloc(prog, bpf_prog_size(img.new_cnt), GFP_USER | BPF_GFP_MAYFAIL);
 	if (!prog)
 		goto out;
 	env->prog = prog;
@@ -651,7 +651,7 @@ int bpf_insert_loop_guards(struct bpf_verifier_env *env)
 	 * Where the subprog has 'r0 = 0; exit', 0 if it has none. And how far that moved
 	 * the subprog: guard_to is from the time before.
 	 */
-	leave = kvcalloc(2 * env->subprog_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
+	leave = kvcalloc(2 * env->subprog_cnt, sizeof(int), BPF_VERIFIER_GFP);
 	if (!leave)
 		return -ENOMEM;
 	moved = leave + env->subprog_cnt;
@@ -689,9 +689,9 @@ int bpf_insert_loop_guards(struct bpf_verifier_env *env)
 	}
 
 	/* where the guard of the insn goes */
-	target = kvcalloc(len, sizeof(int), GFP_KERNEL_ACCOUNT);
-	zero = kvcalloc(len, sizeof(u16), GFP_KERNEL_ACCOUNT);
-	patch = kvcalloc(8, sizeof(*patch), GFP_KERNEL_ACCOUNT);
+	target = kvcalloc(len, sizeof(int), BPF_VERIFIER_GFP);
+	zero = kvcalloc(len, sizeof(u16), BPF_VERIFIER_GFP);
+	patch = kvcalloc(8, sizeof(*patch), BPF_VERIFIER_GFP);
 	if (!target || !zero || !patch) {
 		err = -ENOMEM;
 		goto out;
@@ -1259,7 +1259,7 @@ int bpf_opt_remove_nops(struct bpf_verifier_env *env)
 	unsigned long *removed;
 	int i, next, err = 0;
 
-	removed = kvcalloc(BITS_TO_LONGS(insn_cnt), sizeof(long), GFP_KERNEL_ACCOUNT);
+	removed = kvcalloc(BITS_TO_LONGS(insn_cnt), sizeof(long), BPF_VERIFIER_GFP);
 	if (!removed)
 		return -ENOMEM;
 
@@ -1768,7 +1768,7 @@ static u32 *bpf_dup_subprog_starts(struct bpf_verifier_env *env)
 {
 	u32 *starts = NULL;
 
-	starts = kvmalloc_objs(u32, env->subprog_cnt, GFP_KERNEL_ACCOUNT);
+	starts = kvmalloc_objs(u32, env->subprog_cnt, BPF_VERIFIER_GFP);
 	if (starts) {
 		for (int i = 0; i < env->subprog_cnt; i++)
 			starts[i] = env->subprog_info[i].start;
@@ -1902,7 +1902,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		 * subprogs don't have IDs and not reachable via prog_get_next_id
 		 * func[i]->stats will never be accessed and stays NULL
 		 */
-		func[i] = bpf_prog_alloc_no_stats(bpf_prog_size(len), GFP_USER);
+		func[i] = bpf_prog_alloc_no_stats(bpf_prog_size(len), GFP_USER | BPF_GFP_MAYFAIL);
 		if (!func[i])
 			goto out_free;
 		memcpy(func[i]->insnsi, &prog->insnsi[subprog_start],
@@ -2215,7 +2215,7 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
 		err = bpf_jit_subprogs(env);
 		if (err == 0)
 			return 0;
-		if (err == -EFAULT || err == -EINTR)
+		if (err == -EFAULT || err == -EINTR || err == -ENOMEM)
 			return err;
 	}
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
@@ -2859,7 +2859,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			}
 			if (!tmg) {
 				tmg = alloc_percpu_gfp(struct bpf_timed_may_goto,
-						       GFP_KERNEL_ACCOUNT);
+						       BPF_VERIFIER_GFP);
 				if (!tmg)
 					return -ENOMEM;
 				prog->aux->timed_may_goto = tmg;
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index fbd1178eb9f5..70766ee48eb4 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -204,11 +204,11 @@ static int flow_compute_order(struct bpf_verifier_env *env, struct bpf_flow *flo
 	int err = -ENOMEM;
 
 	/* lists of members are indexed by loop head, len is the function */
-	next = kvmalloc_array(len, sizeof(int), GFP_KERNEL_ACCOUNT);
-	head = kvmalloc_array(len + 1, sizeof(int), GFP_KERNEL_ACCOUNT);
-	tail = kvmalloc_array(len + 1, sizeof(int), GFP_KERNEL_ACCOUNT);
-	stack = kvmalloc_array(len + 1, sizeof(int), GFP_KERNEL_ACCOUNT);
-	linked = kvcalloc(BITS_TO_LONGS(len), sizeof(long), GFP_KERNEL_ACCOUNT);
+	next = kvmalloc_array(len, sizeof(int), BPF_VERIFIER_GFP);
+	head = kvmalloc_array(len + 1, sizeof(int), BPF_VERIFIER_GFP);
+	tail = kvmalloc_array(len + 1, sizeof(int), BPF_VERIFIER_GFP);
+	stack = kvmalloc_array(len + 1, sizeof(int), BPF_VERIFIER_GFP);
+	linked = kvcalloc(BITS_TO_LONGS(len), sizeof(long), BPF_VERIFIER_GFP);
 	if (!next || !head || !tail || !stack || !linked)
 		goto out;
 
@@ -478,7 +478,7 @@ int bpf_flow_place_guards(struct bpf_verifier_env *env)
 	struct bpf_loop *loop;
 	u32 *seen;
 
-	seen = kvcalloc(len, sizeof(*seen), GFP_KERNEL_ACCOUNT);
+	seen = kvcalloc(len, sizeof(*seen), BPF_VERIFIER_GFP);
 	if (!seen)
 		return -ENOMEM;
 
@@ -859,8 +859,8 @@ int bpf_flow_compute_kinds(struct bpf_verifier_env *env)
 	bool lost = true;
 	u16 *ret;
 
-	kinds = kvmalloc_array(len, sizeof(*kinds), GFP_KERNEL_ACCOUNT);
-	ret = kvmalloc_array(env->subprog_cnt, sizeof(*ret), GFP_KERNEL_ACCOUNT);
+	kinds = kvmalloc_array(len, sizeof(*kinds), BPF_VERIFIER_GFP);
+	ret = kvmalloc_array(env->subprog_cnt, sizeof(*ret), BPF_VERIFIER_GFP);
 	if (!kinds || !ret) {
 		kvfree(kinds);
 		kvfree(ret);
@@ -1015,12 +1015,12 @@ static int flow_compute_need_const(struct bpf_verifier_env *env, struct flow_nee
 	u16 *gen, callx_regs = 0, pair = BIT(BPF_REG_0) | BIT(BPF_REG_2);
 	u8 *ret, class, op;
 
-	need = kvcalloc(env->prog->len, sizeof(*need), GFP_KERNEL_ACCOUNT);
-	gen = kvcalloc(env->prog->len, sizeof(u16), GFP_KERNEL_ACCOUNT);
+	need = kvcalloc(env->prog->len, sizeof(*need), BPF_VERIFIER_GFP);
+	gen = kvcalloc(env->prog->len, sizeof(u16), BPF_VERIFIER_GFP);
 	/* the callers need what the subprog returns: r0, and r2 of a pair */
-	ret = kvcalloc(env->subprog_cnt, sizeof(u8), GFP_KERNEL_ACCOUNT);
+	ret = kvcalloc(env->subprog_cnt, sizeof(u8), BPF_VERIFIER_GFP);
 	if (flag)
-		ahead = kvcalloc(env->prog->len, sizeof(*need), GFP_KERNEL_ACCOUNT);
+		ahead = kvcalloc(env->prog->len, sizeof(*need), BPF_VERIFIER_GFP);
 	*pneed = need;
 	if (!need || !gen || !ret || (flag && !ahead)) {
 		kvfree(ahead);
@@ -1485,9 +1485,9 @@ static int flow_compute_loop_rungs(struct bpf_verifier_env *env, const u32 *at,
 
 	/* for each insn, for the current insn, for each jump back */
 	syms = kvmalloc_array((size_t)nr + 1 + loop->backedges_cnt, n * sizeof(*syms),
-			      GFP_KERNEL_ACCOUNT);
+			      BPF_VERIFIER_GFP);
 	/* for each root, and the result for each place */
-	roots = kvcalloc(3 * n, sizeof(*roots), GFP_KERNEL_ACCOUNT);
+	roots = kvcalloc(3 * n, sizeof(*roots), BPF_VERIFIER_GFP);
 	if (!syms || !roots)
 		goto out;
 	memset(syms, 0xff, (size_t)nr * n * sizeof(*syms));
@@ -1566,7 +1566,7 @@ static int flow_compute_loop_rungs(struct bpf_verifier_env *env, const u32 *at,
 	err = 0;
 	if (!cnt)
 		goto out;
-	loop->rungs = kvcalloc(cnt, sizeof(*loop->rungs), GFP_KERNEL_ACCOUNT);
+	loop->rungs = kvcalloc(cnt, sizeof(*loop->rungs), BPF_VERIFIER_GFP);
 	if (!loop->rungs) {
 		err = -ENOMEM;
 		goto out;
@@ -1595,7 +1595,7 @@ static int flow_compute_rungs(struct bpf_verifier_env *env)
 		;
 	if (h == env->prog->len)
 		return 0;
-	at = kvmalloc_array(total, sizeof(*at), GFP_KERNEL_ACCOUNT);
+	at = kvmalloc_array(total, sizeof(*at), BPF_VERIFIER_GFP);
 	if (!at)
 		return -ENOMEM;
 	for (k = 0; k < total; k++) {
@@ -1636,22 +1636,22 @@ int bpf_flow_prepare(struct bpf_verifier_env *env)
 	struct bpf_flow *flow;
 	u8 *preds;
 
-	flow = kzalloc_obj(*flow, GFP_KERNEL_ACCOUNT);
+	flow = kzalloc_obj(*flow, BPF_VERIFIER_GFP);
 	if (!flow)
 		return -ENOMEM;
 	env->flow = flow;
 	INIT_LIST_HEAD(&flow->kept);
 	flow->pending = RB_ROOT_CACHED;
 
-	flow->pos = kvcalloc(len, sizeof(u32), GFP_KERNEL_ACCOUNT);
-	flow->rank = kvcalloc(env->subprog_cnt + 1, sizeof(u32), GFP_KERNEL_ACCOUNT);
-	flow->point = kvcalloc(BITS_TO_LONGS(len), sizeof(long), GFP_KERNEL_ACCOUNT);
-	flow->keep = kvcalloc(BITS_TO_LONGS(len), sizeof(long), GFP_KERNEL_ACCOUNT);
-	flow->states = kvmalloc_array(len, sizeof(*flow->states), GFP_KERNEL_ACCOUNT);
-	flow->enter = kvmalloc_array(len, sizeof(*flow->enter), GFP_KERNEL_ACCOUNT);
-	flow->nr_states = kvcalloc(len, sizeof(u32), GFP_KERNEL_ACCOUNT);
-	flow->funcs = kvcalloc(env->subprog_cnt + 1, sizeof(*flow->funcs), GFP_KERNEL_ACCOUNT);
-	preds = kvcalloc(len, 1, GFP_KERNEL_ACCOUNT);
+	flow->pos = kvcalloc(len, sizeof(u32), BPF_VERIFIER_GFP);
+	flow->rank = kvcalloc(env->subprog_cnt + 1, sizeof(u32), BPF_VERIFIER_GFP);
+	flow->point = kvcalloc(BITS_TO_LONGS(len), sizeof(long), BPF_VERIFIER_GFP);
+	flow->keep = kvcalloc(BITS_TO_LONGS(len), sizeof(long), BPF_VERIFIER_GFP);
+	flow->states = kvmalloc_array(len, sizeof(*flow->states), BPF_VERIFIER_GFP);
+	flow->enter = kvmalloc_array(len, sizeof(*flow->enter), BPF_VERIFIER_GFP);
+	flow->nr_states = kvcalloc(len, sizeof(u32), BPF_VERIFIER_GFP);
+	flow->funcs = kvcalloc(env->subprog_cnt + 1, sizeof(*flow->funcs), BPF_VERIFIER_GFP);
+	preds = kvcalloc(len, 1, BPF_VERIFIER_GFP);
 	if (!flow->pos || !flow->rank || !flow->point || !flow->keep || !flow->states ||
 	    !flow->enter ||
 	    !flow->nr_states || !flow->funcs || !preds) {
@@ -1808,7 +1808,7 @@ bool bpf_flow_is_point(struct bpf_verifier_env *env, int insn_idx)
 struct bpf_verifier_state *bpf_flow_keep_state(struct bpf_verifier_env *env,
 					       const struct bpf_verifier_state *st)
 {
-	struct flow_kept *k = kzalloc_obj(*k, GFP_KERNEL_ACCOUNT);
+	struct flow_kept *k = kzalloc_obj(*k, BPF_VERIFIER_GFP);
 
 	if (!k)
 		return NULL;
@@ -1915,13 +1915,13 @@ static int flow_entry_new(struct bpf_flow *flow)
 
 	if (flow->entry_cnt + 1 >= flow->entry_cap) {
 		cap = max(64U, flow->entry_cap * 2);
-		entries = kvrealloc(flow->entries, cap * sizeof(*entries), GFP_KERNEL_ACCOUNT);
+		entries = kvrealloc(flow->entries, cap * sizeof(*entries), BPF_VERIFIER_GFP);
 		if (!entries)
 			return -ENOMEM;
 		flow->entries = entries;
 		flow->entry_cap = cap;
 	}
-	e = kmalloc_obj(*e, GFP_KERNEL_ACCOUNT);
+	e = kmalloc_obj(*e, BPF_VERIFIER_GFP);
 	if (!e)
 		return -ENOMEM;
 	e->up = e;
@@ -1941,7 +1941,7 @@ static int flow_unite(struct bpf_flow *flow, u32 a, u32 b)
 		return 0;
 	if (flow->united_cnt == flow->united_cap) {
 		cap = max(16U, flow->united_cap * 2);
-		u = kvrealloc(flow->united, cap * sizeof(*u), GFP_KERNEL_ACCOUNT);
+		u = kvrealloc(flow->united, cap * sizeof(*u), BPF_VERIFIER_GFP);
 		if (!u)
 			return -ENOMEM;
 		flow->united = u;
@@ -2881,7 +2881,7 @@ static int flow_merge(struct bpf_verifier_env *env, struct flow_set *set,
 
 static struct flow_state *flow_new_state(struct bpf_verifier_env *env, int prev_insn_idx)
 {
-	struct flow_state *s = kzalloc_obj(*s, GFP_KERNEL_ACCOUNT);
+	struct flow_state *s = kzalloc_obj(*s, BPF_VERIFIER_GFP);
 	struct bpf_flow *flow = env->flow;
 
 	if (!s)
@@ -3206,7 +3206,7 @@ int bpf_flow_call(struct bpf_verifier_env *env, struct bpf_verifier_state *calle
 	struct flow_state *w;
 	int id;
 
-	w = kzalloc_obj(*w, GFP_KERNEL_ACCOUNT);
+	w = kzalloc_obj(*w, BPF_VERIFIER_GFP);
 	if (!w)
 		return -ENOMEM;
 	w->st = *caller;
@@ -3271,7 +3271,7 @@ int bpf_flow_exit(struct bpf_verifier_env *env, struct bpf_verifier_state *st, i
 		kfree(o);
 	}
 
-	x = kzalloc_obj(*x, GFP_KERNEL_ACCOUNT);
+	x = kzalloc_obj(*x, BPF_VERIFIER_GFP);
 	if (!x)
 		return -ENOMEM;
 	x->st = *st;
@@ -3368,9 +3368,9 @@ void bpf_flow_print_way(struct bpf_verifier_env *env, u64 log_pos, int head, int
 	u32 from = flow->from, cnt = 0;
 	unsigned long *seen;
 
-	seen = bitmap_zalloc(flow->len, GFP_KERNEL_ACCOUNT);
+	seen = bitmap_zalloc(flow->len, BPF_VERIFIER_GFP);
 	way = kvmalloc_array(bitmap_weight(flow->point, flow->len), sizeof(*way),
-			     GFP_KERNEL_ACCOUNT);
+			     BPF_VERIFIER_GFP);
 	if (!seen || !way)
 		goto out;
 
diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
index 67211f329907..6a8efb671a8a 100644
--- a/kernel/bpf/join.c
+++ b/kernel/bpf/join.c
@@ -46,7 +46,7 @@ struct bpf_join_state {
 static struct bpf_join_state *join_state(struct bpf_verifier_env *env)
 {
 	if (!env->join) {
-		env->join = kvzalloc_obj(*env->join, GFP_KERNEL_ACCOUNT);
+		env->join = kvzalloc_obj(*env->join, BPF_VERIFIER_GFP);
 		if (env->join)
 			env->join->env = env;
 	}
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 2c771b936d65..053b3875cde6 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -121,7 +121,7 @@ static struct func_instance *call_instance(struct bpf_verifier_env *env,
 	if (f)
 		return f;
 
-	f = kvzalloc_obj(*f, GFP_KERNEL_ACCOUNT);
+	f = kvzalloc_obj(*f, BPF_VERIFIER_GFP);
 	if (!f)
 		return ERR_PTR(-ENOMEM);
 	f->callsite = lookup_key;
@@ -155,7 +155,7 @@ static struct func_instance *lookup_instance(struct bpf_verifier_env *env,
 
 int bpf_stack_liveness_init(struct bpf_verifier_env *env)
 {
-	env->liveness = kvzalloc_obj(*env->liveness, GFP_KERNEL_ACCOUNT);
+	env->liveness = kvzalloc_obj(*env->liveness, BPF_VERIFIER_GFP);
 	if (!env->liveness)
 		return -ENOMEM;
 	hash_init(env->liveness->func_instances);
@@ -216,7 +216,7 @@ static struct frame_masks *widen_frame_masks(struct func_instance *instance,
 
 	if (old && old->words >= words)
 		return old;
-	new = kvzalloc_flex(*new, bits, frame_mask_words(instance, words), GFP_KERNEL_ACCOUNT);
+	new = kvzalloc_flex(*new, bits, frame_mask_words(instance, words), BPF_VERIFIER_GFP);
 	if (!new)
 		return NULL;
 	new->words = words;
@@ -815,7 +815,7 @@ static int print_instances(struct bpf_verifier_env *env)
 	cnt = 0;
 	hash_for_each(liveness->func_instances, bkt, instance, hl_node)
 		cnt++;
-	sorted_instances = kvmalloc_objs(*sorted_instances, cnt, GFP_KERNEL_ACCOUNT);
+	sorted_instances = kvmalloc_objs(*sorted_instances, cnt, BPF_VERIFIER_GFP);
 	if (!sorted_instances)
 		return -ENOMEM;
 	cnt = 0;
@@ -2081,15 +2081,15 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
 	bool changed;
 	int i, p, r, err = -ENOMEM;
 
-	at_in = kvmalloc_objs(*at_in, len, GFP_KERNEL_ACCOUNT);
+	at_in = kvmalloc_objs(*at_in, len, BPF_VERIFIER_GFP);
 	if (!at_in)
 		goto err_free;
 
-	at_stack_in = kvmalloc_objs(*at_stack_in, (size_t)len * nslots, GFP_KERNEL_ACCOUNT);
+	at_stack_in = kvmalloc_objs(*at_stack_in, (size_t)len * nslots, BPF_VERIFIER_GFP);
 	if (!at_stack_in)
 		goto err_free;
 
-	at_stack_out = kvmalloc_objs(*at_stack_out, nslots, GFP_KERNEL_ACCOUNT);
+	at_stack_out = kvmalloc_objs(*at_stack_out, nslots, BPF_VERIFIER_GFP);
 	if (!at_stack_out)
 		goto err_free;
 
@@ -2190,7 +2190,7 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
 			struct spill_snapshot *snap;
 
 			kvfree(env->callsite_at_stack[idx]);
-			env->callsite_at_stack[idx] = kvmalloc_flex(*snap, at, nslots, GFP_KERNEL_ACCOUNT);
+			env->callsite_at_stack[idx] = kvmalloc_flex(*snap, at, nslots, BPF_VERIFIER_GFP);
 			snap = env->callsite_at_stack[idx];
 			if (!snap) {
 				err = -ENOMEM;
@@ -2321,7 +2321,7 @@ static struct func_instance *fresh_instance(struct func_instance *src)
 {
 	struct func_instance *f;
 
-	f = kvzalloc_obj(*f, GFP_KERNEL_ACCOUNT);
+	f = kvzalloc_obj(*f, BPF_VERIFIER_GFP);
 	if (!f)
 		return ERR_PTR(-ENOMEM);
 	f->callsite = src->callsite;
@@ -2546,15 +2546,15 @@ int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env)
 	struct subprog_at_info *info;
 	int k, err = 0;
 
-	info = kvzalloc_objs(*info, env->subprog_cnt, GFP_KERNEL_ACCOUNT);
+	info = kvzalloc_objs(*info, env->subprog_cnt, BPF_VERIFIER_GFP);
 	if (!info)
 		return -ENOMEM;
 
 	env->callsite_at_stack = kvzalloc_objs(*env->callsite_at_stack, insn_cnt,
-					       GFP_KERNEL_ACCOUNT);
+					       BPF_VERIFIER_GFP);
 	env->liveness->callee_args = kvcalloc(MAX_CALL_FRAMES * MAX_AT_TRACK_REGS,
 					      sizeof(*env->liveness->callee_args),
-					      GFP_KERNEL_ACCOUNT);
+					      BPF_VERIFIER_GFP);
 	if (!env->callsite_at_stack || !env->liveness->callee_args) {
 		err = -ENOMEM;
 		insn_cnt = env->callsite_at_stack ? insn_cnt : 0;
@@ -2839,7 +2839,7 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 	 * - repeat the computation while {in,out} fields changes for
 	 *   any instruction.
 	 */
-	state = kvzalloc_objs(*state, insn_cnt, GFP_KERNEL_ACCOUNT);
+	state = kvzalloc_objs(*state, insn_cnt, BPF_VERIFIER_GFP);
 	if (!state) {
 		err = -ENOMEM;
 		goto out;
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index ffbec587a916..d5132e08ecd9 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -195,7 +195,7 @@ int bpf_vlog_stash(struct bpf_verifier_log *log, u64 pos, struct bpf_vlog_stash
 	stash->lost_end = log->end_pos - to;
 	stash->len = to - from;
 	/* as large as the buffer at worst: fail before the OOM killer is called */
-	stash->buf = kvzalloc(stash->len, GFP_KERNEL_ACCOUNT | __GFP_NOWARN | __GFP_RETRY_MAYFAIL);
+	stash->buf = kvzalloc(stash->len, BPF_VERIFIER_GFP);
 	if (!stash->buf)
 		return -ENOMEM;
 	/* two pieces if it wraps around */
diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
index 9946146847d7..434c5acfc2e1 100644
--- a/kernel/bpf/loops.c
+++ b/kernel/bpf/loops.c
@@ -28,7 +28,7 @@ static struct bpf_iarray **compute_predecessors(struct bpf_verifier_env *env)
 	size_t sz;
 	void *tmp;
 
-	num_preds = kvzalloc_objs(u32, prog->len, GFP_KERNEL_ACCOUNT);
+	num_preds = kvzalloc_objs(u32, prog->len, BPF_VERIFIER_GFP);
 	if (!num_preds)
 		return NULL;
 
@@ -49,7 +49,7 @@ static struct bpf_iarray **compute_predecessors(struct bpf_verifier_env *env)
 			i++;
 	}
 
-	result = kvzalloc(sz, GFP_KERNEL_ACCOUNT);
+	result = kvzalloc(sz, BPF_VERIFIER_GFP);
 	if (!result) {
 		kvfree(num_preds);
 		return NULL;
@@ -151,7 +151,7 @@ int bpf_compute_idoms(struct bpf_verifier_env *env)
 	if (!preds)
 		return -ENOMEM;
 
-	idoms = kvzalloc_objs(*idoms, len, GFP_KERNEL_ACCOUNT);
+	idoms = kvzalloc_objs(*idoms, len, BPF_VERIFIER_GFP);
 	if (!idoms) {
 		kvfree(preds);
 		return -ENOMEM;
@@ -212,7 +212,7 @@ static int add_exit(struct bpf_loop *loop, int from, int to)
 	}
 	if (!loop->exits) {
 		loop->exits = kvzalloc_objs(*loop->exits, MAX_LOOP_EXITS,
-					    GFP_KERNEL_ACCOUNT);
+					    BPF_VERIFIER_GFP);
 		if (!loop->exits)
 			return -ENOMEM;
 	}
@@ -229,7 +229,7 @@ static int mark_as_header(struct bpf_verifier_env *env, int h)
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
 
 	if (!aux[h].loop) {
-		aux[h].loop = kvzalloc_obj(struct bpf_loop, GFP_KERNEL_ACCOUNT);
+		aux[h].loop = kvzalloc_obj(struct bpf_loop, BPF_VERIFIER_GFP);
 		if (!aux[h].loop)
 			return -ENOMEM;
 	}
@@ -542,9 +542,9 @@ int bpf_compute_loops(struct bpf_verifier_env *env)
 	struct bpf_iarray *succ;
 	struct bpf_loop *loop;
 
-	dfs.dfs_pos = kvzalloc_objs(int, len, GFP_KERNEL_ACCOUNT);
-	dfs.state = kvzalloc_objs(struct dfs_state, len, GFP_KERNEL_ACCOUNT);
-	dfs.stack = kvzalloc_objs(int, len, GFP_KERNEL_ACCOUNT);
+	dfs.dfs_pos = kvzalloc_objs(int, len, BPF_VERIFIER_GFP);
+	dfs.state = kvzalloc_objs(struct dfs_state, len, BPF_VERIFIER_GFP);
+	dfs.stack = kvzalloc_objs(int, len, BPF_VERIFIER_GFP);
 	if (!dfs.dfs_pos || !dfs.state || !dfs.stack) {
 		err = -ENOMEM;
 		goto out;
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 616e22c038ed..5218ce1cafc1 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -275,7 +275,7 @@ static void exprs_ht_add(struct scev *scev, u32 id)
 /* @cap is a power of two. No warning for a size that kvmalloc() rejects. */
 static int grow_exprs(struct scev *scev, u32 cap)
 {
-	gfp_t gfp = GFP_KERNEL_ACCOUNT | __GFP_NOWARN;
+	gfp_t gfp = BPF_VERIFIER_GFP;
 	void *tmp;
 	u32 id;
 
@@ -957,11 +957,11 @@ static struct env *get_loop_env(struct scev *scev, int loop_header, int insn_idx
 	if (e)
 		return e;
 
-	e = kzalloc_obj(*e, GFP_KERNEL_ACCOUNT);
+	e = kzalloc_obj(*e, BPF_VERIFIER_GFP);
 	if (!e)
 		return NULL;
 
-	tmp = krealloc(envs, struct_size(envs, entries, cnt + 1), GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	tmp = krealloc(envs, struct_size(envs, entries, cnt + 1), BPF_VERIFIER_GFP | __GFP_ZERO);
 	if (!tmp) {
 		kfree(e);
 		return NULL;
@@ -1812,7 +1812,7 @@ static int worklist_push(struct bpf_verifier_env *env, int loop_header, int idx)
 		int *data;
 
 		data = kvrealloc(worklist->data, array_size(size, sizeof(*data)),
-				GFP_KERNEL_ACCOUNT);
+				BPF_VERIFIER_GFP);
 		if (!data)
 			return -ENOMEM;
 		worklist->data = data;
@@ -2300,7 +2300,7 @@ static int grow_array(void *p, u32 cnt, u32 *cap, size_t size)
 
 	if (cnt < *cap)
 		return 0;
-	tmp = kvrealloc(*(void **)p, array_size(new_cap, size), GFP_KERNEL_ACCOUNT);
+	tmp = kvrealloc(*(void **)p, array_size(new_cap, size), BPF_VERIFIER_GFP);
 	if (!tmp)
 		return -ENOMEM;
 	*(void **)p = tmp;
@@ -2567,7 +2567,7 @@ static int find_linked_regs(struct bpf_verifier_env *env, struct env *e, int h,
 		q->refine = test_bit(k, roots);
 	}
 	if (!envs) {
-		envs = kzalloc(sizeof(*envs), GFP_KERNEL_ACCOUNT);
+		envs = kzalloc(sizeof(*envs), BPF_VERIFIER_GFP);
 		if (!envs)
 			return -ENOMEM;
 		scev->envs[idx] = envs;
@@ -2634,11 +2634,11 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header, i
 	if (!cur_loop && !can_compute_subprog_scev(env, sub))
 		return 0;
 
-	cur_env = kzalloc_obj(*cur_env, GFP_KERNEL_ACCOUNT);
+	cur_env = kzalloc_obj(*cur_env, BPF_VERIFIER_GFP);
 	if (!cur_env)
 		goto nomem;
 	if (log_level2) {
-		old_env = kzalloc_obj(*old_env, GFP_KERNEL_ACCOUNT);
+		old_env = kzalloc_obj(*old_env, BPF_VERIFIER_GFP);
 		if (!old_env)
 			goto nomem;
 	}
@@ -3351,7 +3351,7 @@ int bpf_init_scev(struct bpf_verifier_env *env)
 	struct scev *scev;
 	u32 r;
 
-	scev = kzalloc_obj(struct scev, GFP_KERNEL_ACCOUNT);
+	scev = kzalloc_obj(struct scev, BPF_VERIFIER_GFP);
 	if (!scev)
 		return -ENOMEM;
 	env->scev = scev;
@@ -3369,9 +3369,9 @@ int bpf_init_scev(struct bpf_verifier_env *env)
 		set_expr_base(scev, &scev->exprs[r], r);
 	scev->exprs_cnt = REG_EXPR_ID(REGS_NUM);
 	scev->envs = kvzalloc_objs(*scev->envs, env->prog->len,
-				   GFP_KERNEL_ACCOUNT);
+				   BPF_VERIFIER_GFP);
 	scev->discovered = kvzalloc_objs(*scev->discovered, env->prog->len,
-					 GFP_KERNEL_ACCOUNT);
+					 BPF_VERIFIER_GFP);
 	if (!scev->envs || !scev->discovered)
 		goto nomem;
 	/*
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9c55f5ed8ced..bf4a9fb8e2e0 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3074,13 +3074,13 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
 	}
 
 	/* plain bpf_prog allocation */
-	prog = bpf_prog_alloc(bpf_prog_size(attr->insn_cnt), GFP_USER);
+	prog = bpf_prog_alloc(bpf_prog_size(attr->insn_cnt), GFP_USER | BPF_GFP_MAYFAIL);
 	if (!prog) {
 		if (dst_prog)
 			bpf_prog_put(dst_prog);
 		if (attach_btf)
 			btf_put(attach_btf);
-		err = -EINVAL;
+		err = -ENOMEM;
 		goto put_token;
 	}
 
@@ -3103,7 +3103,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
 	prog->aux->user = get_current_user();
 	prog->len = attr->insn_cnt;
 
-	err = bpf_prog_stream_init(prog, GFP_USER);
+	err = bpf_prog_stream_init(prog, GFP_USER | BPF_GFP_MAYFAIL);
 	if (err)
 		goto free_prog;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03f8b2f33596..d64719c85e6f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1417,7 +1417,7 @@ static void *realloc_array(void *arr, size_t old_n, size_t new_n, size_t size)
 		goto out;
 
 	alloc_size = kmalloc_size_roundup(size_mul(new_n, size));
-	new_arr = krealloc(arr, alloc_size, GFP_KERNEL_ACCOUNT);
+	new_arr = krealloc(arr, alloc_size, BPF_VERIFIER_GFP);
 	if (!new_arr) {
 		kfree(arr);
 		return NULL;
@@ -1434,7 +1434,7 @@ static void *realloc_array(void *arr, size_t old_n, size_t new_n, size_t size)
 static int copy_reference_state(struct bpf_verifier_state *dst, const struct bpf_verifier_state *src)
 {
 	dst->refs = copy_array(dst->refs, src->refs, src->acquired_refs,
-			       sizeof(struct bpf_reference_state), GFP_KERNEL_ACCOUNT);
+			       sizeof(struct bpf_reference_state), BPF_VERIFIER_GFP);
 	if (!dst->refs)
 		return -ENOMEM;
 
@@ -1453,7 +1453,7 @@ static int copy_stack_state(struct bpf_func_state *dst, const struct bpf_func_st
 	size_t n = bpf_stack_nr_slots(src);
 
 	dst->stack = copy_array(dst->stack, src->stack, n, sizeof(struct bpf_stack_state),
-				GFP_KERNEL_ACCOUNT);
+				BPF_VERIFIER_GFP);
 	if (!dst->stack)
 		return -ENOMEM;
 
@@ -1464,7 +1464,7 @@ static int copy_stack_state(struct bpf_func_state *dst, const struct bpf_func_st
 	if (n) {
 		dst->stack_arg_regs = copy_array(dst->stack_arg_regs, src->stack_arg_regs, n,
 						 sizeof(struct bpf_reg_state),
-						 GFP_KERNEL_ACCOUNT);
+						 BPF_VERIFIER_GFP);
 		if (!dst->stack_arg_regs)
 			return -ENOMEM;
 	}
@@ -1765,7 +1765,7 @@ static int copy_func_state(struct bpf_func_state *dst,
 	/* Instruction accounting is path-local, not part of verifier state. */
 	dst->insns_subtotal = 0;
 	dst->loop_stack = copy_array(dst->loop_stack, src->loop_stack, src->loop_stack_cnt,
-				     sizeof(*src->loop_stack), GFP_KERNEL_ACCOUNT);
+				     sizeof(*src->loop_stack), BPF_VERIFIER_GFP);
 	if (!dst->loop_stack)
 		return -ENOMEM;
 	return copy_stack_state(dst, src);
@@ -1797,7 +1797,7 @@ int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
 	for (i = 0; i <= src->curframe; i++) {
 		dst = dst_state->frame[i];
 		if (!dst) {
-			dst = kzalloc_obj(*dst, GFP_KERNEL_ACCOUNT);
+			dst = kzalloc_obj(*dst, BPF_VERIFIER_GFP);
 			if (!dst)
 				return -ENOMEM;
 			dst_state->frame[i] = dst;
@@ -1829,7 +1829,7 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 	struct bpf_verifier_stack_elem *elem;
 	int err;
 
-	elem = kzalloc_obj(struct bpf_verifier_stack_elem, GFP_KERNEL_ACCOUNT);
+	elem = kzalloc_obj(struct bpf_verifier_stack_elem, BPF_VERIFIER_GFP);
 	if (!elem)
 		return ERR_PTR(-ENOMEM);
 
@@ -2544,7 +2544,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	struct bpf_verifier_stack_elem *elem;
 	struct bpf_func_state *frame;
 
-	elem = kzalloc_obj(struct bpf_verifier_stack_elem, GFP_KERNEL_ACCOUNT);
+	elem = kzalloc_obj(struct bpf_verifier_stack_elem, BPF_VERIFIER_GFP);
 	if (!elem)
 		return ERR_PTR(-ENOMEM);
 
@@ -2558,7 +2558,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	 * Initialize it similar to do_check_common().
 	 */
 	elem->st.in_sleepable = is_sleepable;
-	frame = kzalloc_obj(*frame, GFP_KERNEL_ACCOUNT);
+	frame = kzalloc_obj(*frame, BPF_VERIFIER_GFP);
 	if (!frame)
 		return ERR_PTR(-ENOMEM);
 	init_func_state(env, frame,
@@ -3057,7 +3057,7 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 			return -EINVAL;
 		}
 
-		tab = kzalloc_obj(*tab, GFP_KERNEL_ACCOUNT);
+		tab = kzalloc_obj(*tab, BPF_VERIFIER_GFP);
 		if (!tab)
 			return -ENOMEM;
 		prog_aux->kfunc_tab = tab;
@@ -3075,7 +3075,7 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 		return 0;
 
 	if (!btf_tab && offset) {
-		btf_tab = kzalloc_obj(*btf_tab, GFP_KERNEL_ACCOUNT);
+		btf_tab = kzalloc_obj(*btf_tab, BPF_VERIFIER_GFP);
 		if (!btf_tab)
 			return -ENOMEM;
 		prog_aux->kfunc_btf_tab = btf_tab;
@@ -3133,7 +3133,7 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 	meta.func_name = kfunc.name;
 	meta.kfunc_flags = kfunc.flags ? *kfunc.flags : 0;
 
-	tab = krealloc(tab, struct_size(tab, descs, tab->nr_descs + 1), GFP_KERNEL_ACCOUNT);
+	tab = krealloc(tab, struct_size(tab, descs, tab->nr_descs + 1), BPF_VERIFIER_GFP);
 	if (!tab)
 		return -ENOMEM;
 	prog_aux->kfunc_tab = tab;
@@ -3369,7 +3369,7 @@ static int record_callx_edge(struct bpf_verifier_env *env, int caller, int calle
 
 	if (!env->callx_edges) {
 		env->callx_edges = kvcalloc(BITS_TO_LONGS(cnt * cnt), sizeof(long),
-					    GFP_KERNEL_ACCOUNT);
+					    BPF_VERIFIER_GFP);
 		if (!env->callx_edges)
 			return -ENOMEM;
 	}
@@ -3464,8 +3464,8 @@ static int sort_subprogs_topo(struct bpf_verifier_env *env)
 	int i, ret = 0;
 	u8 *color = NULL;
 
-	color = kvzalloc_objs(*color, cnt, GFP_KERNEL_ACCOUNT);
-	dfs_stack = kvmalloc_objs(*dfs_stack, cnt, GFP_KERNEL_ACCOUNT);
+	color = kvzalloc_objs(*color, cnt, BPF_VERIFIER_GFP);
+	dfs_stack = kvmalloc_objs(*dfs_stack, cnt, BPF_VERIFIER_GFP);
 	if (!color || !dfs_stack) {
 		ret = -ENOMEM;
 		goto out;
@@ -5567,7 +5567,7 @@ static int build_call_graph(struct bpf_verifier_env *env, struct bpf_call_graph
 
 	cg->cnt = cnt;
 	cg->words = words;
-	cg->calls = kvcalloc((2 * cnt + 6) * words, sizeof(long), GFP_KERNEL_ACCOUNT);
+	cg->calls = kvcalloc((2 * cnt + 6) * words, sizeof(long), BPF_VERIFIER_GFP);
 	if (!cg->calls)
 		return -ENOMEM;
 	cg->reach = cg->calls + cnt * words;
@@ -5914,7 +5914,7 @@ static int check_call_depth(struct bpf_verifier_env *env, struct bpf_call_graph
 	struct bpf_subprog_call_depth_info *dinfo;
 	int depth, total, tmp, s, err;
 
-	dinfo = kvzalloc_objs(*dinfo, cg->cnt, GFP_KERNEL_ACCOUNT);
+	dinfo = kvzalloc_objs(*dinfo, cg->cnt, BPF_VERIFIER_GFP);
 	if (!dinfo)
 		return -ENOMEM;
 	compute_call_depth(env, cg, dinfo);
@@ -6060,7 +6060,7 @@ static int mark_recursive_subprogs(struct bpf_verifier_env *env)
 	int i, j, s, err = 0;
 
 	/* calls + s * words: the subprogs that s calls */
-	calls = kvcalloc((cnt + 2) * words, sizeof(long), GFP_KERNEL_ACCOUNT);
+	calls = kvcalloc((cnt + 2) * words, sizeof(long), BPF_VERIFIER_GFP);
 	if (!calls)
 		return -ENOMEM;
 	taken = calls + cnt * words;
@@ -7258,11 +7258,11 @@ static int mark_reg_func_set(struct bpf_verifier_env *env, struct bpf_reg_state
 			verbose(env, "more than %d sets of functions\n", BPF_MAX_FUNC_SETS);
 			return -E2BIG;
 		}
-		sets = krealloc_array(env->func_sets, i + 1, sizeof(*sets), GFP_KERNEL_ACCOUNT);
+		sets = krealloc_array(env->func_sets, i + 1, sizeof(*sets), BPF_VERIFIER_GFP);
 		if (!sets)
 			return -ENOMEM;
 		env->func_sets = sets;
-		set = kzalloc_flex(*set, subprog, n, GFP_KERNEL_ACCOUNT);
+		set = kzalloc_flex(*set, subprog, n, BPF_VERIFIER_GFP);
 		if (!set)
 			return -ENOMEM;
 		set->cnt = n;
@@ -7330,7 +7330,7 @@ static int check_func_ptr_read(struct bpf_verifier_env *env, struct bpf_reg_stat
 		return -ENOENT;
 	if (cnt > BPF_MAX_FUNC_PTR_RANGE)
 		goto overlap;
-	targets = kmalloc_array(BPF_MAX_FUNC_PTR_TARGETS, sizeof(*targets), GFP_KERNEL_ACCOUNT);
+	targets = kmalloc_array(BPF_MAX_FUNC_PTR_TARGETS, sizeof(*targets), BPF_VERIFIER_GFP);
 	if (!targets)
 		return -ENOMEM;
 
@@ -11313,7 +11313,7 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 	}
 
 	caller = state->frame[state->curframe];
-	callee = kzalloc_obj(*callee, GFP_KERNEL_ACCOUNT);
+	callee = kzalloc_obj(*callee, BPF_VERIFIER_GFP);
 	if (!callee)
 		return -ENOMEM;
 	state->frame[state->curframe + 1] = callee;
@@ -11674,7 +11674,7 @@ static int call_func_on_its_own(struct bpf_verifier_env *env, int subprog, int i
 	struct bpf_verifier_state entry = {};
 	int i, err;
 
-	callee = kzalloc_obj(*callee, GFP_KERNEL_ACCOUNT);
+	callee = kzalloc_obj(*callee, BPF_VERIFIER_GFP);
 	if (!callee)
 		return -ENOMEM;
 	entry.frame[0] = callee;
@@ -12153,7 +12153,7 @@ static int check_func_callx_set(struct bpf_verifier_env *env, int regno, int *in
 				return PTR_ERR(branch);
 			continue;
 		}
-		copy = kzalloc_obj(*copy, GFP_KERNEL_ACCOUNT);
+		copy = kzalloc_obj(*copy, BPF_VERIFIER_GFP);
 		if (!copy)
 			return -ENOMEM;
 		err = bpf_copy_verifier_state(copy, cur);
@@ -21367,7 +21367,7 @@ static int flow_try_walk(struct bpf_verifier_env *env, struct loop_stack_entry *
 	entry->walk_id = env->walk_cnt + 1;
 	if (is_power_of_2(entry->walk_id)) {
 		walk_insns = kvrealloc(env->walk_insns, 2 * entry->walk_id * sizeof(u32),
-				       GFP_KERNEL_ACCOUNT);
+				       BPF_VERIFIER_GFP);
 		if (!walk_insns)
 			return -ENOMEM;
 		env->walk_insns = walk_insns;
@@ -22925,7 +22925,7 @@ static int add_func_ptr(struct bpf_verifier_env *env, struct bpf_map *map, u32 m
 	if (!(env->func_ptr_cnt & (env->func_ptr_cnt - 1))) {
 		ptrs = kvrealloc(env->func_ptrs,
 				 array_size(max(2 * env->func_ptr_cnt, 16U), sizeof(*ptrs)),
-				 GFP_KERNEL_ACCOUNT);
+				 BPF_VERIFIER_GFP);
 		if (!ptrs)
 			return -ENOMEM;
 		env->func_ptrs = ptrs;
@@ -23098,7 +23098,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog,
 	env->prev_linfo = NULL;
 	env->pass_cnt++;
 
-	state = kzalloc_obj(struct bpf_verifier_state, GFP_KERNEL_ACCOUNT);
+	state = kzalloc_obj(struct bpf_verifier_state, BPF_VERIFIER_GFP);
 	if (!state)
 		return -ENOMEM;
 	state->curframe = 0;
@@ -23107,7 +23107,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog,
 	/* nobody knows what the callers of a global function or of an extension hold */
 	state->callers_unknown = subprog || env->prog->type == BPF_PROG_TYPE_EXT;
 	env->no_rcu_read_lock = context == BPF_FUNC_CTX_NO_RCU_LOCK;
-	state->frame[0] = kzalloc_obj(struct bpf_func_state, GFP_KERNEL_ACCOUNT);
+	state->frame[0] = kzalloc_obj(struct bpf_func_state, BPF_VERIFIER_GFP);
 	if (!state->frame[0]) {
 		kfree(state);
 		return -ENOMEM;
@@ -23392,7 +23392,7 @@ static void add_insns_of_callees(struct bpf_verifier_env *env)
 	struct bpf_insn *insn = env->prog->insnsi;
 	int *added, i, j, s, c;
 
-	added = kvcalloc(env->subprog_cnt, sizeof(*added), GFP_KERNEL_ACCOUNT);
+	added = kvcalloc(env->subprog_cnt, sizeof(*added), BPF_VERIFIER_GFP);
 	if (!added)
 		return;
 	/* callees first */
@@ -23447,7 +23447,7 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
 			       const struct bpf_ctx_arg_aux *info, u32 cnt)
 {
-	prog->aux->ctx_arg_info = kmemdup_array(info, cnt, sizeof(*info), GFP_KERNEL_ACCOUNT);
+	prog->aux->ctx_arg_info = kmemdup_array(info, cnt, sizeof(*info), BPF_VERIFIER_GFP);
 	prog->aux->ctx_arg_info_size = cnt;
 
 	return prog->aux->ctx_arg_info ? 0 : -ENOMEM;
@@ -24636,7 +24636,7 @@ static int process_fd_array_continuous(struct bpf_verifier_env *env,
 		return -E2BIG;
 	}
 
-	env->fd_array = kvzalloc_objs(*env->fd_array, cnt, GFP_KERNEL_ACCOUNT);
+	env->fd_array = kvzalloc_objs(*env->fd_array, cnt, BPF_VERIFIER_GFP);
 	if (!env->fd_array)
 		return -ENOMEM;
 	env->fd_array_cnt = cnt;
@@ -24775,7 +24775,7 @@ static int add_kfunc_desc_target(struct bpf_verifier_env *env,
 	}
 
 	new_tab = krealloc(tab, struct_size(tab, descs, tab->nr_descs + 1),
-			   GFP_KERNEL_ACCOUNT);
+			   BPF_VERIFIER_GFP);
 	if (!new_tab)
 		return -ENOMEM;
 	tab = new_tab;
@@ -25136,7 +25136,7 @@ static int bpf_prog_verify_signature(struct bpf_verifier_env *env,
 		err = -E2BIG;
 		goto out;
 	}
-	data = kvmalloc(data_sz, GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	data = kvmalloc(data_sz, BPF_VERIFIER_GFP | __GFP_ZERO);
 	if (!data) {
 		err = -ENOMEM;
 		goto out;
@@ -25251,7 +25251,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	/* 'struct bpf_verifier_env' can be global, but since it's not small,
 	 * allocate/free it every time bpf_check() is called
 	 */
-	env = kvzalloc_obj(struct bpf_verifier_env, GFP_KERNEL_ACCOUNT);
+	env = kvzalloc_obj(struct bpf_verifier_env, BPF_VERIFIER_GFP);
 	if (!env)
 		return -ENOMEM;
 
@@ -25310,7 +25310,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	len = env->insn_aux_data_len = env->prog->len;
 	env->insn_aux_data =
 		__vmalloc(array_size(sizeof(struct bpf_insn_aux_data), len),
-			  GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+			  BPF_VERIFIER_GFP | __GFP_ZERO);
 	ret = -ENOMEM;
 	if (!env->insn_aux_data)
 		goto skip_full_check;
@@ -25561,7 +25561,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 		/* if program passed verifier, update used_maps in bpf_prog_info */
 		env->prog->aux->used_maps = kmalloc_objs(env->used_maps[0],
 							 env->used_map_cnt,
-							 GFP_KERNEL_ACCOUNT);
+							 BPF_VERIFIER_GFP);
 
 		if (!env->prog->aux->used_maps) {
 			ret = -ENOMEM;
@@ -25576,7 +25576,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 		/* if program passed verifier, update used_btfs in bpf_prog_aux */
 		env->prog->aux->used_btfs = kmalloc_objs(env->used_btfs[0],
 							 env->used_btf_cnt,
-							 GFP_KERNEL_ACCOUNT);
+							 BPF_VERIFIER_GFP);
 		if (!env->prog->aux->used_btfs) {
 			ret = -ENOMEM;
 			goto err_release_maps;
-- 
2.55.0

