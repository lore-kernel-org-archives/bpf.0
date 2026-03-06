Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FAB34D905;
	Fri,  6 Mar 2026 09:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772791006; cv=none; b=uKrs9XX89OM6yO7Rug4Yvl+oCUlcZWlR35bjgGYrFoOFE7xy/6undM7dMRXjg2xWynZrH4ic4QMRIa+EAZxWBmmDTejzERy061bvXOqVxn5c+lwadLeLxRhx7Lv54ygd0pxsTz7kprJiUosyYkXCxxmkae/D76ZQjhjMb70EY/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772791006; c=relaxed/simple;
	bh=iK1R7L5/VlOPQ2zsOgcgfUFdO6KVvi/EM50W2RZRzKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxNwmwnTPGegAfQGsULDlN8OTGmEGbCIqt/qrBcCht5tDXRYa++m1J+4i5rt4N0UlFxiC6DdC+KcHbzqSSi6RZJyNZZu1Lo3ZRnlpBIPOhSib7/obIeZ0Z67siHeuVK77ctIzghuFCOOC/mM8ZuiuxWz2UqX919WClk9XEi3W9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fS1yF4XSwzKHMfw;
	Fri,  6 Mar 2026 17:56:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 777D040539;
	Fri,  6 Mar 2026 17:56:30 +0800 (CST)
Received: from k01.k01 (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgAHs_PKpKppIrAYJw--.30802S3;
	Fri, 06 Mar 2026 17:56:30 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Shahab Vahedi <list+bpf@vahedi.org>,
	Russell King <linux@armlinux.org.uk>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Johan Almbladh <johan.almbladh@anyfinetworks.com>,
	Paul Burton <paulburton@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>,
	Xi Wang <xi.wang@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Wang YanQing <udknight@gmail.com>
Subject: [bpf-next v6 1/5] bpf: Move constants blinding from JIT to verifier
Date: Fri,  6 Mar 2026 18:23:25 +0800
Message-ID: <20260306102329.2056216-2-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306102329.2056216-1-xukuohai@huaweicloud.com>
References: <20260306102329.2056216-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHs_PKpKppIrAYJw--.30802S3
X-Coremail-Antispam: 1UD129KBjvAXoWDXF18Ww1xAr4Utw1UKw1UAwb_yoW7Aw1UAo
	Wak34DAa18trykG3y7Krn3GF13Zw18trsrAr4fJa98Cas7A3yUKrZxXwsru39aqF15WFWD
	uFyxJayYyrZIkry5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUO87kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	4l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
	v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jx
	txhUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

During the JIT stage, constants blinding rewrites instructions but only
rewrites the private instruction copy of the JITed subprog, leaving the
global instructions and insn_aux_data unchanged. This causes a mismatch
between subprog instructions and the global state, making it difficult
to look up the global insn_aux_data in the JIT.

To avoid this mismatch, and given that all arch-specific JITs already
support constants blinding, move it to the generic verifier code, and
switch to rewrite the global env->insnsi with the global states
adjusted, as other rewrites in the verifier do.

This removes the constant blinding calls in each JIT, which are largely
duplicated code across architectures.

And the prog clone functions and insn_array adjustment for the JIT
constant blinding are no longer needed, remove them too.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arc/net/bpf_jit_core.c      |  20 +--
 arch/arm/net/bpf_jit_32.c        |  41 +----
 arch/arm64/net/bpf_jit_comp.c    |  59 ++-----
 arch/loongarch/net/bpf_jit.c     |  50 ++----
 arch/mips/net/bpf_jit_comp.c     |  20 +--
 arch/parisc/net/bpf_jit_core.c   |  38 +----
 arch/powerpc/net/bpf_jit_comp.c  |  45 ++----
 arch/riscv/net/bpf_jit_core.c    |  45 ++----
 arch/s390/net/bpf_jit_comp.c     |  41 +----
 arch/sparc/net/bpf_jit_comp_64.c |  41 +----
 arch/x86/net/bpf_jit_comp.c      |  40 +----
 arch/x86/net/bpf_jit_comp32.c    |  33 +---
 include/linux/filter.h           |   3 -
 kernel/bpf/core.c                | 263 -------------------------------
 kernel/bpf/verifier.c            | 215 +++++++++++++++++++++++--
 15 files changed, 288 insertions(+), 666 deletions(-)

diff --git a/arch/arc/net/bpf_jit_core.c b/arch/arc/net/bpf_jit_core.c
index 1421eeced0f5..12facf5750da 100644
--- a/arch/arc/net/bpf_jit_core.c
+++ b/arch/arc/net/bpf_jit_core.c
@@ -79,7 +79,6 @@ struct arc_jit_data {
  * The JIT pertinent context that is used by different functions.
  *
  * prog:		The current eBPF program being handled.
- * orig_prog:		The original eBPF program before any possible change.
  * jit:			The JIT buffer and its length.
  * bpf_header:		The JITed program header. "jit.buf" points inside it.
  * emit:		If set, opcodes are written to memory; else, a dry-run.
@@ -94,12 +93,10 @@ struct arc_jit_data {
  * need_extra_pass:	A forecast if an "extra_pass" will occur.
  * is_extra_pass:	Indicates if the current pass is an extra pass.
  * user_bpf_prog:	True, if VM opcodes come from a real program.
- * blinded:		True if "constant blinding" step returned a new "prog".
  * success:		Indicates if the whole JIT went OK.
  */
 struct jit_context {
 	struct bpf_prog			*prog;
-	struct bpf_prog			*orig_prog;
 	struct jit_buffer		jit;
 	struct bpf_binary_header	*bpf_header;
 	bool				emit;
@@ -114,7 +111,6 @@ struct jit_context {
 	bool				need_extra_pass;
 	bool				is_extra_pass;
 	bool				user_bpf_prog;
-	bool				blinded;
 	bool				success;
 };
 
@@ -161,13 +157,7 @@ static int jit_ctx_init(struct jit_context *ctx, struct bpf_prog *prog)
 {
 	memset(ctx, 0, sizeof(*ctx));
 
-	ctx->orig_prog = prog;
-
-	/* If constant blinding was requested but failed, scram. */
-	ctx->prog = bpf_jit_blind_constants(prog);
-	if (IS_ERR(ctx->prog))
-		return PTR_ERR(ctx->prog);
-	ctx->blinded = (ctx->prog != ctx->orig_prog);
+	ctx->prog = prog;
 
 	/* If the verifier doesn't zero-extend, then we have to do it. */
 	ctx->do_zext = !ctx->prog->aux->verifier_zext;
@@ -214,14 +204,6 @@ static inline void maybe_free(struct jit_context *ctx, void **mem)
  */
 static void jit_ctx_cleanup(struct jit_context *ctx)
 {
-	if (ctx->blinded) {
-		/* if all went well, release the orig_prog. */
-		if (ctx->success)
-			bpf_jit_prog_release_other(ctx->prog, ctx->orig_prog);
-		else
-			bpf_jit_prog_release_other(ctx->orig_prog, ctx->prog);
-	}
-
 	maybe_free(ctx, (void **)&ctx->bpf2insn);
 	maybe_free(ctx, (void **)&ctx->jit_data);
 
diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index deeb8f292454..e6b1bb2de627 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -2144,9 +2144,7 @@ bool bpf_jit_needs_zext(void)
 
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 {
-	struct bpf_prog *tmp, *orig_prog = prog;
 	struct bpf_binary_header *header;
-	bool tmp_blinded = false;
 	struct jit_ctx ctx;
 	unsigned int tmp_idx;
 	unsigned int image_size;
@@ -2156,20 +2154,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	 * the interpreter.
 	 */
 	if (!prog->jit_requested)
-		return orig_prog;
-
-	/* If constant blinding was enabled and we failed during blinding
-	 * then we must fall back to the interpreter. Otherwise, we save
-	 * the new JITed code.
-	 */
-	tmp = bpf_jit_blind_constants(prog);
-
-	if (IS_ERR(tmp))
-		return orig_prog;
-	if (tmp != prog) {
-		tmp_blinded = true;
-		prog = tmp;
-	}
+		return prog;
 
 	memset(&ctx, 0, sizeof(ctx));
 	ctx.prog = prog;
@@ -2179,10 +2164,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	 * we must fall back to the interpreter
 	 */
 	ctx.offsets = kcalloc(prog->len, sizeof(int), GFP_KERNEL);
-	if (ctx.offsets == NULL) {
-		prog = orig_prog;
-		goto out;
-	}
+	if (ctx.offsets == NULL)
+		return prog;
 
 	/* 1) fake pass to find in the length of the JITed code,
 	 * to compute ctx->offsets and other context variables
@@ -2194,10 +2177,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	 * being successful in the second pass, so just fall back
 	 * to the interpreter.
 	 */
-	if (build_body(&ctx)) {
-		prog = orig_prog;
+	if (build_body(&ctx))
 		goto out_off;
-	}
 
 	tmp_idx = ctx.idx;
 	build_prologue(&ctx);
@@ -2213,10 +2194,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	ctx.idx += ctx.imm_count;
 	if (ctx.imm_count) {
 		ctx.imms = kcalloc(ctx.imm_count, sizeof(u32), GFP_KERNEL);
-		if (ctx.imms == NULL) {
-			prog = orig_prog;
+		if (ctx.imms == NULL)
 			goto out_off;
-		}
 	}
 #else
 	/* there's nothing about the epilogue on ARMv7 */
@@ -2238,10 +2217,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	/* Not able to allocate memory for the structure then
 	 * we must fall back to the interpretation
 	 */
-	if (header == NULL) {
-		prog = orig_prog;
+	if (header == NULL)
 		goto out_imms;
-	}
 
 	/* 2.) Actual pass to generate final JIT code */
 	ctx.target = (u32 *) image_ptr;
@@ -2278,16 +2255,12 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 #endif
 out_off:
 	kfree(ctx.offsets);
-out:
-	if (tmp_blinded)
-		bpf_jit_prog_release_other(prog, prog == orig_prog ?
-					   tmp : orig_prog);
+
 	return prog;
 
 out_free:
 	image_ptr = NULL;
 	bpf_jit_binary_free(header);
-	prog = orig_prog;
 	goto out_imms;
 }
 
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index adf84962d579..c5ed9d84c3ae 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2009,14 +2009,12 @@ struct arm64_jit_data {
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 {
 	int image_size, prog_size, extable_size, extable_align, extable_offset;
-	struct bpf_prog *tmp, *orig_prog = prog;
 	struct bpf_binary_header *header;
 	struct bpf_binary_header *ro_header = NULL;
 	struct arm64_jit_data *jit_data;
 	void __percpu *priv_stack_ptr = NULL;
 	bool was_classic = bpf_prog_was_classic(prog);
 	int priv_stack_alloc_sz;
-	bool tmp_blinded = false;
 	bool extra_pass = false;
 	struct jit_ctx ctx;
 	u8 *image_ptr;
@@ -2025,26 +2023,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	int exentry_idx;
 
 	if (!prog->jit_requested)
-		return orig_prog;
-
-	tmp = bpf_jit_blind_constants(prog);
-	/* If blinding was requested and we failed during blinding,
-	 * we must fall back to the interpreter.
-	 */
-	if (IS_ERR(tmp))
-		return orig_prog;
-	if (tmp != prog) {
-		tmp_blinded = true;
-		prog = tmp;
-	}
+		return prog;
 
 	jit_data = prog->aux->jit_data;
 	if (!jit_data) {
 		jit_data = kzalloc_obj(*jit_data);
-		if (!jit_data) {
-			prog = orig_prog;
-			goto out;
-		}
+		if (!jit_data)
+			return prog;
 		prog->aux->jit_data = jit_data;
 	}
 	priv_stack_ptr = prog->aux->priv_stack_ptr;
@@ -2056,10 +2041,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		priv_stack_alloc_sz = round_up(prog->aux->stack_depth, 16) +
 				      2 * PRIV_STACK_GUARD_SZ;
 		priv_stack_ptr = __alloc_percpu_gfp(priv_stack_alloc_sz, 16, GFP_KERNEL);
-		if (!priv_stack_ptr) {
-			prog = orig_prog;
+		if (!priv_stack_ptr)
 			goto out_priv_stack;
-		}
 
 		priv_stack_init_guard(priv_stack_ptr, priv_stack_alloc_sz);
 		prog->aux->priv_stack_ptr = priv_stack_ptr;
@@ -2079,10 +2062,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	ctx.prog = prog;
 
 	ctx.offset = kvzalloc_objs(int, prog->len + 1);
-	if (ctx.offset == NULL) {
-		prog = orig_prog;
+	if (ctx.offset == NULL)
 		goto out_off;
-	}
 
 	ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
 	ctx.arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
@@ -2095,15 +2076,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	 * BPF line info needs ctx->offset[i] to be the offset of
 	 * instruction[i] in jited image, so build prologue first.
 	 */
-	if (build_prologue(&ctx, was_classic)) {
-		prog = orig_prog;
+	if (build_prologue(&ctx, was_classic))
 		goto out_off;
-	}
 
-	if (build_body(&ctx, extra_pass)) {
-		prog = orig_prog;
+	if (build_body(&ctx, extra_pass))
 		goto out_off;
-	}
 
 	ctx.epilogue_offset = ctx.idx;
 	build_epilogue(&ctx, was_classic);
@@ -2121,10 +2098,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	ro_header = bpf_jit_binary_pack_alloc(image_size, &ro_image_ptr,
 					      sizeof(u64), &header, &image_ptr,
 					      jit_fill_hole);
-	if (!ro_header) {
-		prog = orig_prog;
+	if (!ro_header)
 		goto out_off;
-	}
 
 	/* Pass 2: Determine jited position and result for each instruction */
 
@@ -2152,10 +2127,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	/* Dont write body instructions to memory for now */
 	ctx.write = false;
 
-	if (build_body(&ctx, extra_pass)) {
-		prog = orig_prog;
+	if (build_body(&ctx, extra_pass))
 		goto out_free_hdr;
-	}
 
 	ctx.epilogue_offset = ctx.idx;
 	ctx.exentry_idx = exentry_idx;
@@ -2164,19 +2137,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
 	/* Pass 3: Adjust jump offset and write final image */
 	if (build_body(&ctx, extra_pass) ||
-		WARN_ON_ONCE(ctx.idx != ctx.epilogue_offset)) {
-		prog = orig_prog;
+		WARN_ON_ONCE(ctx.idx != ctx.epilogue_offset))
 		goto out_free_hdr;
-	}
 
 	build_epilogue(&ctx, was_classic);
 	build_plt(&ctx);
 
 	/* Extra pass to validate JITed code. */
-	if (validate_ctx(&ctx)) {
-		prog = orig_prog;
+	if (validate_ctx(&ctx))
 		goto out_free_hdr;
-	}
 
 	/* update the real prog size */
 	prog_size = sizeof(u32) * ctx.idx;
@@ -2201,7 +2170,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		if (WARN_ON(bpf_jit_binary_pack_finalize(ro_header, header))) {
 			/* ro_header has been freed */
 			ro_header = NULL;
-			prog = orig_prog;
 			goto out_off;
 		}
 		/*
@@ -2245,10 +2213,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		kfree(jit_data);
 		prog->aux->jit_data = NULL;
 	}
-out:
-	if (tmp_blinded)
-		bpf_jit_prog_release_other(prog, prog == orig_prog ?
-					   tmp : orig_prog);
+
 	return prog;
 
 out_free_hdr:
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 3bd89f55960d..3a5cc3e88424 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1911,43 +1911,26 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 {
-	bool tmp_blinded = false, extra_pass = false;
+	bool extra_pass = false;
 	u8 *image_ptr, *ro_image_ptr;
 	int image_size, prog_size, extable_size;
 	struct jit_ctx ctx;
 	struct jit_data *jit_data;
 	struct bpf_binary_header *header;
 	struct bpf_binary_header *ro_header;
-	struct bpf_prog *tmp, *orig_prog = prog;
 
 	/*
 	 * If BPF JIT was not enabled then we must fall back to
 	 * the interpreter.
 	 */
 	if (!prog->jit_requested)
-		return orig_prog;
-
-	tmp = bpf_jit_blind_constants(prog);
-	/*
-	 * If blinding was requested and we failed during blinding,
-	 * we must fall back to the interpreter. Otherwise, we save
-	 * the new JITed code.
-	 */
-	if (IS_ERR(tmp))
-		return orig_prog;
-
-	if (tmp != prog) {
-		tmp_blinded = true;
-		prog = tmp;
-	}
+		return prog;
 
 	jit_data = prog->aux->jit_data;
 	if (!jit_data) {
 		jit_data = kzalloc_obj(*jit_data);
-		if (!jit_data) {
-			prog = orig_prog;
-			goto out;
-		}
+		if (!jit_data)
+			return prog;
 		prog->aux->jit_data = jit_data;
 	}
 	if (jit_data->ctx.offset) {
@@ -1967,17 +1950,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
 
 	ctx.offset = kvcalloc(prog->len + 1, sizeof(u32), GFP_KERNEL);
-	if (ctx.offset == NULL) {
-		prog = orig_prog;
+	if (ctx.offset == NULL)
 		goto out_offset;
-	}
 
 	/* 1. Initial fake pass to compute ctx->idx and set ctx->flags */
 	build_prologue(&ctx);
-	if (build_body(&ctx, extra_pass)) {
-		prog = orig_prog;
+	if (build_body(&ctx, extra_pass))
 		goto out_offset;
-	}
 	ctx.epilogue_offset = ctx.idx;
 	build_epilogue(&ctx);
 
@@ -1993,10 +1972,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	/* Now we know the size of the structure to make */
 	ro_header = bpf_jit_binary_pack_alloc(image_size, &ro_image_ptr, sizeof(u32),
 					      &header, &image_ptr, jit_fill_hole);
-	if (!ro_header) {
-		prog = orig_prog;
+	if (!ro_header)
 		goto out_offset;
-	}
 
 	/* 2. Now, the actual pass to generate final JIT code */
 	/*
@@ -2016,17 +1993,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	ctx.num_exentries = 0;
 
 	build_prologue(&ctx);
-	if (build_body(&ctx, extra_pass)) {
-		prog = orig_prog;
+	if (build_body(&ctx, extra_pass))
 		goto out_free;
-	}
 	build_epilogue(&ctx);
 
 	/* 3. Extra pass to validate JITed code */
-	if (validate_ctx(&ctx)) {
-		prog = orig_prog;
+	if (validate_ctx(&ctx))
 		goto out_free;
-	}
 
 	/* And we're done */
 	if (bpf_jit_enable > 1)
@@ -2041,7 +2014,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		if (WARN_ON(bpf_jit_binary_pack_finalize(ro_header, header))) {
 			/* ro_header has been freed */
 			ro_header = NULL;
-			prog = orig_prog;
 			goto out_free;
 		}
 		/*
@@ -2073,10 +2045,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		prog->aux->jit_data = NULL;
 	}
 
-out:
-	if (tmp_blinded)
-		bpf_jit_prog_release_other(prog, prog == orig_prog ? tmp : orig_prog);
-
 	return prog;
 
 out_free:
diff --git a/arch/mips/net/bpf_jit_comp.c b/arch/mips/net/bpf_jit_comp.c
index e355dfca4400..d2b6c955f18e 100644
--- a/arch/mips/net/bpf_jit_comp.c
+++ b/arch/mips/net/bpf_jit_comp.c
@@ -911,10 +911,8 @@ bool bpf_jit_needs_zext(void)
 
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 {
-	struct bpf_prog *tmp, *orig_prog = prog;
 	struct bpf_binary_header *header = NULL;
 	struct jit_context ctx;
-	bool tmp_blinded = false;
 	unsigned int tmp_idx;
 	unsigned int image_size;
 	u8 *image_ptr;
@@ -925,19 +923,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	 * the interpreter.
 	 */
 	if (!prog->jit_requested)
-		return orig_prog;
-	/*
-	 * If constant blinding was enabled and we failed during blinding
-	 * then we must fall back to the interpreter. Otherwise, we save
-	 * the new JITed code.
-	 */
-	tmp = bpf_jit_blind_constants(prog);
-	if (IS_ERR(tmp))
-		return orig_prog;
-	if (tmp != prog) {
-		tmp_blinded = true;
-		prog = tmp;
-	}
+		return prog;
 
 	memset(&ctx, 0, sizeof(ctx));
 	ctx.program = prog;
@@ -1025,14 +1011,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	prog->jited_len = image_size;
 
 out:
-	if (tmp_blinded)
-		bpf_jit_prog_release_other(prog, prog == orig_prog ?
-					   tmp : orig_prog);
 	kfree(ctx.descriptors);
 	return prog;
 
 out_err:
-	prog = orig_prog;
 	if (header)
 		bpf_jit_binary_free(header);
 	goto out;
diff --git a/arch/parisc/net/bpf_jit_core.c b/arch/parisc/net/bpf_jit_core.c
index a5eb6b51e27a..4d339636a34a 100644
--- a/arch/parisc/net/bpf_jit_core.c
+++ b/arch/parisc/net/bpf_jit_core.c
@@ -44,30 +44,19 @@ bool bpf_jit_needs_zext(void)
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 {
 	unsigned int prog_size = 0, extable_size = 0;
-	bool tmp_blinded = false, extra_pass = false;
-	struct bpf_prog *tmp, *orig_prog = prog;
+	bool extra_pass = false;
 	int pass = 0, prev_ninsns = 0, prologue_len, i;
 	struct hppa_jit_data *jit_data;
 	struct hppa_jit_context *ctx;
 
 	if (!prog->jit_requested)
-		return orig_prog;
-
-	tmp = bpf_jit_blind_constants(prog);
-	if (IS_ERR(tmp))
-		return orig_prog;
-	if (tmp != prog) {
-		tmp_blinded = true;
-		prog = tmp;
-	}
+		return prog;
 
 	jit_data = prog->aux->jit_data;
 	if (!jit_data) {
 		jit_data = kzalloc_obj(*jit_data);
-		if (!jit_data) {
-			prog = orig_prog;
-			goto out;
-		}
+		if (!jit_data)
+			return prog;
 		prog->aux->jit_data = jit_data;
 	}
 
@@ -81,10 +70,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
 	ctx->prog = prog;
 	ctx->offset = kzalloc_objs(int, prog->len);
-	if (!ctx->offset) {
-		prog = orig_prog;
+	if (!ctx->offset)
 		goto out_offset;
-	}
 	for (i = 0; i < prog->len; i++) {
 		prev_ninsns += 20;
 		ctx->offset[i] = prev_ninsns;
@@ -93,10 +80,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	for (i = 0; i < NR_JIT_ITERATIONS; i++) {
 		pass++;
 		ctx->ninsns = 0;
-		if (build_body(ctx, extra_pass, ctx->offset)) {
-			prog = orig_prog;
+		if (build_body(ctx, extra_pass, ctx->offset))
 			goto out_offset;
-		}
 		ctx->body_len = ctx->ninsns;
 		bpf_jit_build_prologue(ctx);
 		ctx->prologue_len = ctx->ninsns - ctx->body_len;
@@ -116,10 +101,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 						     &jit_data->image,
 						     sizeof(long),
 						     bpf_fill_ill_insns);
-			if (!jit_data->header) {
-				prog = orig_prog;
+			if (!jit_data->header)
 				goto out_offset;
-			}
 
 			ctx->insns = (u32 *)jit_data->image;
 			/*
@@ -134,7 +117,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		pr_err("bpf-jit: image did not converge in <%d passes!\n", i);
 		if (jit_data->header)
 			bpf_jit_binary_free(jit_data->header);
-		prog = orig_prog;
 		goto out_offset;
 	}
 
@@ -148,7 +130,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	bpf_jit_build_prologue(ctx);
 	if (build_body(ctx, extra_pass, NULL)) {
 		bpf_jit_binary_free(jit_data->header);
-		prog = orig_prog;
 		goto out_offset;
 	}
 	bpf_jit_build_epilogue(ctx);
@@ -183,13 +164,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		kfree(jit_data);
 		prog->aux->jit_data = NULL;
 	}
-out:
+
 	if (HPPA_JIT_REBOOT)
 		{ extern int machine_restart(char *); machine_restart(""); }
 
-	if (tmp_blinded)
-		bpf_jit_prog_release_other(prog, prog == orig_prog ?
-					   tmp : orig_prog);
 	return prog;
 }
 
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 52162e4a7f84..7a7c49640a2f 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -142,9 +142,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	int flen;
 	struct bpf_binary_header *fhdr = NULL;
 	struct bpf_binary_header *hdr = NULL;
-	struct bpf_prog *org_fp = fp;
-	struct bpf_prog *tmp_fp;
-	bool bpf_blinded = false;
 	bool extra_pass = false;
 	u8 *fimage = NULL;
 	u32 *fcode_base;
@@ -152,24 +149,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	u32 fixup_len;
 
 	if (!fp->jit_requested)
-		return org_fp;
-
-	tmp_fp = bpf_jit_blind_constants(org_fp);
-	if (IS_ERR(tmp_fp))
-		return org_fp;
-
-	if (tmp_fp != org_fp) {
-		bpf_blinded = true;
-		fp = tmp_fp;
-	}
+		return fp;
 
 	jit_data = fp->aux->jit_data;
 	if (!jit_data) {
 		jit_data = kzalloc_obj(*jit_data);
-		if (!jit_data) {
-			fp = org_fp;
-			goto out;
-		}
+		if (!jit_data)
+			return fp;
 		fp->aux->jit_data = jit_data;
 	}
 
@@ -194,10 +180,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	}
 
 	addrs = kcalloc(flen + 1, sizeof(*addrs), GFP_KERNEL);
-	if (addrs == NULL) {
-		fp = org_fp;
+	if (addrs == NULL)
 		goto out_addrs;
-	}
 
 	memset(&cgctx, 0, sizeof(struct codegen_context));
 	bpf_jit_init_reg_mapping(&cgctx);
@@ -211,11 +195,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	cgctx.exception_cb = fp->aux->exception_cb;
 
 	/* Scouting faux-generate pass 0 */
-	if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false)) {
+	if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false))
 		/* We hit something illegal or unsupported. */
-		fp = org_fp;
 		goto out_addrs;
-	}
 
 	/*
 	 * If we have seen a tail call, we need a second pass.
@@ -226,10 +208,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	 */
 	if (cgctx.seen & SEEN_TAILCALL || !is_offset_in_branch_range((long)cgctx.idx * 4)) {
 		cgctx.idx = 0;
-		if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false)) {
-			fp = org_fp;
+		if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false))
 			goto out_addrs;
-		}
 	}
 
 	bpf_jit_realloc_regs(&cgctx);
@@ -250,10 +230,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 
 	fhdr = bpf_jit_binary_pack_alloc(alloclen, &fimage, 4, &hdr, &image,
 					      bpf_jit_fill_ill_insns);
-	if (!fhdr) {
-		fp = org_fp;
+	if (!fhdr)
 		goto out_addrs;
-	}
 
 	if (extable_len)
 		fp->aux->extable = (void *)fimage + FUNCTION_DESCR_SIZE + proglen + fixup_len;
@@ -272,7 +250,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 				       extra_pass)) {
 			bpf_arch_text_copy(&fhdr->size, &hdr->size, sizeof(hdr->size));
 			bpf_jit_binary_pack_free(fhdr, hdr);
-			fp = org_fp;
 			goto out_addrs;
 		}
 		bpf_jit_build_epilogue(code_base, &cgctx);
@@ -301,7 +278,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 
 	if (!fp->is_func || extra_pass) {
 		if (bpf_jit_binary_pack_finalize(fhdr, hdr)) {
-			fp = org_fp;
+			fp->bpf_func = NULL;
+			fp->jited = 0;
+			fp->jited_len = 0;
 			goto out_addrs;
 		}
 		bpf_prog_fill_jited_linfo(fp, addrs);
@@ -318,10 +297,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		jit_data->hdr = hdr;
 	}
 
-out:
-	if (bpf_blinded)
-		bpf_jit_prog_release_other(fp, fp == org_fp ? tmp_fp : org_fp);
-
 	return fp;
 }
 
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index b3581e926436..c77e8aba14d3 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -44,29 +44,19 @@ bool bpf_jit_needs_zext(void)
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 {
 	unsigned int prog_size = 0, extable_size = 0;
-	bool tmp_blinded = false, extra_pass = false;
-	struct bpf_prog *tmp, *orig_prog = prog;
+	bool extra_pass = false;
 	int pass = 0, prev_ninsns = 0, i;
 	struct rv_jit_data *jit_data;
 	struct rv_jit_context *ctx;
 
 	if (!prog->jit_requested)
-		return orig_prog;
-
-	tmp = bpf_jit_blind_constants(prog);
-	if (IS_ERR(tmp))
-		return orig_prog;
-	if (tmp != prog) {
-		tmp_blinded = true;
-		prog = tmp;
-	}
+		return prog;
 
 	jit_data = prog->aux->jit_data;
 	if (!jit_data) {
 		jit_data = kzalloc_obj(*jit_data);
 		if (!jit_data) {
-			prog = orig_prog;
-			goto out;
+			return prog;
 		}
 		prog->aux->jit_data = jit_data;
 	}
@@ -83,15 +73,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	ctx->user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
 	ctx->prog = prog;
 	ctx->offset = kzalloc_objs(int, prog->len);
-	if (!ctx->offset) {
-		prog = orig_prog;
+	if (!ctx->offset)
 		goto out_offset;
-	}
 
-	if (build_body(ctx, extra_pass, NULL)) {
-		prog = orig_prog;
+	if (build_body(ctx, extra_pass, NULL))
 		goto out_offset;
-	}
 
 	for (i = 0; i < prog->len; i++) {
 		prev_ninsns += 32;
@@ -105,10 +91,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		bpf_jit_build_prologue(ctx, bpf_is_subprog(prog));
 		ctx->prologue_len = ctx->ninsns;
 
-		if (build_body(ctx, extra_pass, ctx->offset)) {
-			prog = orig_prog;
+		if (build_body(ctx, extra_pass, ctx->offset))
 			goto out_offset;
-		}
 
 		ctx->epilogue_offset = ctx->ninsns;
 		bpf_jit_build_epilogue(ctx);
@@ -126,10 +110,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 							  &jit_data->ro_image, sizeof(u32),
 							  &jit_data->header, &jit_data->image,
 							  bpf_fill_ill_insns);
-			if (!jit_data->ro_header) {
-				prog = orig_prog;
+			if (!jit_data->ro_header)
 				goto out_offset;
-			}
 
 			/*
 			 * Use the image(RW) for writing the JITed instructions. But also save
@@ -150,7 +132,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
 	if (i == NR_JIT_ITERATIONS) {
 		pr_err("bpf-jit: image did not converge in <%d passes!\n", i);
-		prog = orig_prog;
 		goto out_free_hdr;
 	}
 
@@ -163,10 +144,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	ctx->nexentries = 0;
 
 	bpf_jit_build_prologue(ctx, bpf_is_subprog(prog));
-	if (build_body(ctx, extra_pass, NULL)) {
-		prog = orig_prog;
+	if (build_body(ctx, extra_pass, NULL))
 		goto out_free_hdr;
-	}
 	bpf_jit_build_epilogue(ctx);
 
 	if (bpf_jit_enable > 1)
@@ -180,7 +159,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		if (WARN_ON(bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header))) {
 			/* ro_header has been freed */
 			jit_data->ro_header = NULL;
-			prog = orig_prog;
+			prog->bpf_func = NULL;
+			prog->jited = 0;
+			prog->jited_len = 0;
 			goto out_offset;
 		}
 		/*
@@ -198,11 +179,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		kfree(jit_data);
 		prog->aux->jit_data = NULL;
 	}
-out:
 
-	if (tmp_blinded)
-		bpf_jit_prog_release_other(prog, prog == orig_prog ?
-					   tmp : orig_prog);
 	return prog;
 
 out_free_hdr:
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 1f9a6b728beb..d6de2abfe4a7 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2305,36 +2305,20 @@ static struct bpf_binary_header *bpf_jit_alloc(struct bpf_jit *jit,
  */
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 {
-	struct bpf_prog *tmp, *orig_fp = fp;
 	struct bpf_binary_header *header;
 	struct s390_jit_data *jit_data;
-	bool tmp_blinded = false;
 	bool extra_pass = false;
 	struct bpf_jit jit;
 	int pass;
 
 	if (!fp->jit_requested)
-		return orig_fp;
-
-	tmp = bpf_jit_blind_constants(fp);
-	/*
-	 * If blinding was requested and we failed during blinding,
-	 * we must fall back to the interpreter.
-	 */
-	if (IS_ERR(tmp))
-		return orig_fp;
-	if (tmp != fp) {
-		tmp_blinded = true;
-		fp = tmp;
-	}
+		return fp;
 
 	jit_data = fp->aux->jit_data;
 	if (!jit_data) {
 		jit_data = kzalloc_obj(*jit_data);
-		if (!jit_data) {
-			fp = orig_fp;
-			goto out;
-		}
+		if (!jit_data)
+			return fp;
 		fp->aux->jit_data = jit_data;
 	}
 	if (jit_data->ctx.addrs) {
@@ -2347,33 +2331,26 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 
 	memset(&jit, 0, sizeof(jit));
 	jit.addrs = kvcalloc(fp->len + 1, sizeof(*jit.addrs), GFP_KERNEL);
-	if (jit.addrs == NULL) {
-		fp = orig_fp;
+	if (jit.addrs == NULL)
 		goto free_addrs;
-	}
 	/*
 	 * Three initial passes:
 	 *   - 1/2: Determine clobbered registers
 	 *   - 3:   Calculate program size and addrs array
 	 */
 	for (pass = 1; pass <= 3; pass++) {
-		if (bpf_jit_prog(&jit, fp, extra_pass)) {
-			fp = orig_fp;
+		if (bpf_jit_prog(&jit, fp, extra_pass))
 			goto free_addrs;
-		}
 	}
 	/*
 	 * Final pass: Allocate and generate program
 	 */
 	header = bpf_jit_alloc(&jit, fp);
-	if (!header) {
-		fp = orig_fp;
+	if (!header)
 		goto free_addrs;
-	}
 skip_init_ctx:
 	if (bpf_jit_prog(&jit, fp, extra_pass)) {
 		bpf_jit_binary_free(header);
-		fp = orig_fp;
 		goto free_addrs;
 	}
 	if (bpf_jit_enable > 1) {
@@ -2383,7 +2360,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	if (!fp->is_func || extra_pass) {
 		if (bpf_jit_binary_lock_ro(header)) {
 			bpf_jit_binary_free(header);
-			fp = orig_fp;
 			goto free_addrs;
 		}
 	} else {
@@ -2402,10 +2378,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		kfree(jit_data);
 		fp->aux->jit_data = NULL;
 	}
-out:
-	if (tmp_blinded)
-		bpf_jit_prog_release_other(fp, fp == orig_fp ?
-					   tmp : orig_fp);
+
 	return fp;
 }
 
diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
index b23d1c645ae5..86abd84d4005 100644
--- a/arch/sparc/net/bpf_jit_comp_64.c
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -1479,37 +1479,22 @@ struct sparc64_jit_data {
 
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 {
-	struct bpf_prog *tmp, *orig_prog = prog;
 	struct sparc64_jit_data *jit_data;
 	struct bpf_binary_header *header;
 	u32 prev_image_size, image_size;
-	bool tmp_blinded = false;
 	bool extra_pass = false;
 	struct jit_ctx ctx;
 	u8 *image_ptr;
 	int pass, i;
 
 	if (!prog->jit_requested)
-		return orig_prog;
-
-	tmp = bpf_jit_blind_constants(prog);
-	/* If blinding was requested and we failed during blinding,
-	 * we must fall back to the interpreter.
-	 */
-	if (IS_ERR(tmp))
-		return orig_prog;
-	if (tmp != prog) {
-		tmp_blinded = true;
-		prog = tmp;
-	}
+		return prog;
 
 	jit_data = prog->aux->jit_data;
 	if (!jit_data) {
 		jit_data = kzalloc_obj(*jit_data);
-		if (!jit_data) {
-			prog = orig_prog;
-			goto out;
-		}
+		if (!jit_data)
+			return prog;
 		prog->aux->jit_data = jit_data;
 	}
 	if (jit_data->ctx.offset) {
@@ -1527,10 +1512,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	ctx.prog = prog;
 
 	ctx.offset = kmalloc_array(prog->len, sizeof(unsigned int), GFP_KERNEL);
-	if (ctx.offset == NULL) {
-		prog = orig_prog;
+	if (ctx.offset == NULL)
 		goto out_off;
-	}
 
 	/* Longest sequence emitted is for bswap32, 12 instructions.  Pre-cook
 	 * the offset array so that we converge faster.
@@ -1543,10 +1526,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		ctx.idx = 0;
 
 		build_prologue(&ctx);
-		if (build_body(&ctx)) {
-			prog = orig_prog;
+		if (build_body(&ctx))
 			goto out_off;
-		}
 		build_epilogue(&ctx);
 
 		if (bpf_jit_enable > 1)
@@ -1569,10 +1550,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	image_size = sizeof(u32) * ctx.idx;
 	header = bpf_jit_binary_alloc(image_size, &image_ptr,
 				      sizeof(u32), jit_fill_hole);
-	if (header == NULL) {
-		prog = orig_prog;
+	if (header == NULL)
 		goto out_off;
-	}
 
 	ctx.image = (u32 *)image_ptr;
 skip_init_ctx:
@@ -1582,7 +1561,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
 	if (build_body(&ctx)) {
 		bpf_jit_binary_free(header);
-		prog = orig_prog;
 		goto out_off;
 	}
 
@@ -1592,7 +1570,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		pr_err("bpf_jit: Failed to converge, prev_size=%u size=%d\n",
 		       prev_image_size, ctx.idx * 4);
 		bpf_jit_binary_free(header);
-		prog = orig_prog;
 		goto out_off;
 	}
 
@@ -1604,7 +1581,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	if (!prog->is_func || extra_pass) {
 		if (bpf_jit_binary_lock_ro(header)) {
 			bpf_jit_binary_free(header);
-			prog = orig_prog;
 			goto out_off;
 		}
 	} else {
@@ -1624,9 +1600,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		kfree(jit_data);
 		prog->aux->jit_data = NULL;
 	}
-out:
-	if (tmp_blinded)
-		bpf_jit_prog_release_other(prog, prog == orig_prog ?
-					   tmp : orig_prog);
+
 	return prog;
 }
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8f10080e6fe3..bb8e7541d078 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3726,13 +3726,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 {
 	struct bpf_binary_header *rw_header = NULL;
 	struct bpf_binary_header *header = NULL;
-	struct bpf_prog *tmp, *orig_prog = prog;
 	void __percpu *priv_stack_ptr = NULL;
 	struct x64_jit_data *jit_data;
 	int priv_stack_alloc_sz;
 	int proglen, oldproglen = 0;
 	struct jit_context ctx = {};
-	bool tmp_blinded = false;
 	bool extra_pass = false;
 	bool padding = false;
 	u8 *rw_image = NULL;
@@ -3742,27 +3740,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	int i;
 
 	if (!prog->jit_requested)
-		return orig_prog;
-
-	tmp = bpf_jit_blind_constants(prog);
-	/*
-	 * If blinding was requested and we failed during blinding,
-	 * we must fall back to the interpreter.
-	 */
-	if (IS_ERR(tmp))
-		return orig_prog;
-	if (tmp != prog) {
-		tmp_blinded = true;
-		prog = tmp;
-	}
+		return prog;
 
 	jit_data = prog->aux->jit_data;
 	if (!jit_data) {
 		jit_data = kzalloc_obj(*jit_data);
-		if (!jit_data) {
-			prog = orig_prog;
+		if (!jit_data)
 			goto out;
-		}
 		prog->aux->jit_data = jit_data;
 	}
 	priv_stack_ptr = prog->aux->priv_stack_ptr;
@@ -3774,10 +3758,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		priv_stack_alloc_sz = round_up(prog->aux->stack_depth, 8) +
 				      2 * PRIV_STACK_GUARD_SZ;
 		priv_stack_ptr = __alloc_percpu_gfp(priv_stack_alloc_sz, 8, GFP_KERNEL);
-		if (!priv_stack_ptr) {
-			prog = orig_prog;
+		if (!priv_stack_ptr)
 			goto out_priv_stack;
-		}
 
 		priv_stack_init_guard(priv_stack_ptr, priv_stack_alloc_sz);
 		prog->aux->priv_stack_ptr = priv_stack_ptr;
@@ -3795,10 +3777,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		goto skip_init_addrs;
 	}
 	addrs = kvmalloc_objs(*addrs, prog->len + 1);
-	if (!addrs) {
-		prog = orig_prog;
+	if (!addrs)
 		goto out_addrs;
-	}
 
 	/*
 	 * Before first pass, make a rough estimation of addrs[]
@@ -3829,8 +3809,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 						   sizeof(rw_header->size));
 				bpf_jit_binary_pack_free(header, rw_header);
 			}
-			/* Fall back to interpreter mode */
-			prog = orig_prog;
 			if (extra_pass) {
 				prog->bpf_func = NULL;
 				prog->jited = 0;
@@ -3861,10 +3839,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 			header = bpf_jit_binary_pack_alloc(roundup(proglen, align) + extable_size,
 							   &image, align, &rw_header, &rw_image,
 							   jit_fill_hole);
-			if (!header) {
-				prog = orig_prog;
+			if (!header)
 				goto out_addrs;
-			}
 			prog->aux->extable = (void *) image + roundup(proglen, align);
 		}
 		oldproglen = proglen;
@@ -3917,8 +3893,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		prog->bpf_func = (void *)image + cfi_get_offset();
 		prog->jited = 1;
 		prog->jited_len = proglen - cfi_get_offset();
-	} else {
-		prog = orig_prog;
 	}
 
 	if (!image || !prog->is_func || extra_pass) {
@@ -3934,10 +3908,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		kfree(jit_data);
 		prog->aux->jit_data = NULL;
 	}
+
 out:
-	if (tmp_blinded)
-		bpf_jit_prog_release_other(prog, prog == orig_prog ?
-					   tmp : orig_prog);
 	return prog;
 }
 
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index dda423025c3d..5f259577614a 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -2521,35 +2521,19 @@ bool bpf_jit_needs_zext(void)
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 {
 	struct bpf_binary_header *header = NULL;
-	struct bpf_prog *tmp, *orig_prog = prog;
 	int proglen, oldproglen = 0;
 	struct jit_context ctx = {};
-	bool tmp_blinded = false;
 	u8 *image = NULL;
 	int *addrs;
 	int pass;
 	int i;
 
 	if (!prog->jit_requested)
-		return orig_prog;
-
-	tmp = bpf_jit_blind_constants(prog);
-	/*
-	 * If blinding was requested and we failed during blinding,
-	 * we must fall back to the interpreter.
-	 */
-	if (IS_ERR(tmp))
-		return orig_prog;
-	if (tmp != prog) {
-		tmp_blinded = true;
-		prog = tmp;
-	}
+		return prog;
 
 	addrs = kmalloc_objs(*addrs, prog->len);
-	if (!addrs) {
-		prog = orig_prog;
-		goto out;
-	}
+	if (!addrs)
+		return prog;
 
 	/*
 	 * Before first pass, make a rough estimation of addrs[]
@@ -2574,7 +2558,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 			image = NULL;
 			if (header)
 				bpf_jit_binary_free(header);
-			prog = orig_prog;
 			goto out_addrs;
 		}
 		if (image) {
@@ -2588,10 +2571,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		if (proglen == oldproglen) {
 			header = bpf_jit_binary_alloc(proglen, &image,
 						      1, jit_fill_hole);
-			if (!header) {
-				prog = orig_prog;
+			if (!header)
 				goto out_addrs;
-			}
 		}
 		oldproglen = proglen;
 		cond_resched();
@@ -2604,16 +2585,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		prog->bpf_func = (void *)image;
 		prog->jited = 1;
 		prog->jited_len = proglen;
-	} else {
-		prog = orig_prog;
 	}
 
 out_addrs:
 	kfree(addrs);
-out:
-	if (tmp_blinded)
-		bpf_jit_prog_release_other(prog, prog == orig_prog ?
-					   tmp : orig_prog);
 	return prog;
 }
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 44d7ae95ddbc..b69369dc3727 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1310,9 +1310,6 @@ int bpf_jit_get_func_addr(const struct bpf_prog *prog,
 
 const char *bpf_jit_get_prog_name(struct bpf_prog *prog);
 
-struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *fp);
-void bpf_jit_prog_release_other(struct bpf_prog *fp, struct bpf_prog *fp_other);
-
 static inline void bpf_jit_dump(unsigned int flen, unsigned int proglen,
 				u32 pass, void *image)
 {
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 229c74f3d6ae..93150343ac35 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1290,269 +1290,6 @@ const char *bpf_jit_get_prog_name(struct bpf_prog *prog)
 		return prog->aux->ksym.name;
 	return prog->aux->name;
 }
-
-static int bpf_jit_blind_insn(const struct bpf_insn *from,
-			      const struct bpf_insn *aux,
-			      struct bpf_insn *to_buff,
-			      bool emit_zext)
-{
-	struct bpf_insn *to = to_buff;
-	u32 imm_rnd = get_random_u32();
-	s16 off;
-
-	BUILD_BUG_ON(BPF_REG_AX  + 1 != MAX_BPF_JIT_REG);
-	BUILD_BUG_ON(MAX_BPF_REG + 1 != MAX_BPF_JIT_REG);
-
-	/* Constraints on AX register:
-	 *
-	 * AX register is inaccessible from user space. It is mapped in
-	 * all JITs, and used here for constant blinding rewrites. It is
-	 * typically "stateless" meaning its contents are only valid within
-	 * the executed instruction, but not across several instructions.
-	 * There are a few exceptions however which are further detailed
-	 * below.
-	 *
-	 * Constant blinding is only used by JITs, not in the interpreter.
-	 * The interpreter uses AX in some occasions as a local temporary
-	 * register e.g. in DIV or MOD instructions.
-	 *
-	 * In restricted circumstances, the verifier can also use the AX
-	 * register for rewrites as long as they do not interfere with
-	 * the above cases!
-	 */
-	if (from->dst_reg == BPF_REG_AX || from->src_reg == BPF_REG_AX)
-		goto out;
-
-	if (from->imm == 0 &&
-	    (from->code == (BPF_ALU   | BPF_MOV | BPF_K) ||
-	     from->code == (BPF_ALU64 | BPF_MOV | BPF_K))) {
-		*to++ = BPF_ALU64_REG(BPF_XOR, from->dst_reg, from->dst_reg);
-		goto out;
-	}
-
-	switch (from->code) {
-	case BPF_ALU | BPF_ADD | BPF_K:
-	case BPF_ALU | BPF_SUB | BPF_K:
-	case BPF_ALU | BPF_AND | BPF_K:
-	case BPF_ALU | BPF_OR  | BPF_K:
-	case BPF_ALU | BPF_XOR | BPF_K:
-	case BPF_ALU | BPF_MUL | BPF_K:
-	case BPF_ALU | BPF_MOV | BPF_K:
-	case BPF_ALU | BPF_DIV | BPF_K:
-	case BPF_ALU | BPF_MOD | BPF_K:
-		*to++ = BPF_ALU32_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ from->imm);
-		*to++ = BPF_ALU32_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
-		*to++ = BPF_ALU32_REG_OFF(from->code, from->dst_reg, BPF_REG_AX, from->off);
-		break;
-
-	case BPF_ALU64 | BPF_ADD | BPF_K:
-	case BPF_ALU64 | BPF_SUB | BPF_K:
-	case BPF_ALU64 | BPF_AND | BPF_K:
-	case BPF_ALU64 | BPF_OR  | BPF_K:
-	case BPF_ALU64 | BPF_XOR | BPF_K:
-	case BPF_ALU64 | BPF_MUL | BPF_K:
-	case BPF_ALU64 | BPF_MOV | BPF_K:
-	case BPF_ALU64 | BPF_DIV | BPF_K:
-	case BPF_ALU64 | BPF_MOD | BPF_K:
-		*to++ = BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ from->imm);
-		*to++ = BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
-		*to++ = BPF_ALU64_REG_OFF(from->code, from->dst_reg, BPF_REG_AX, from->off);
-		break;
-
-	case BPF_JMP | BPF_JEQ  | BPF_K:
-	case BPF_JMP | BPF_JNE  | BPF_K:
-	case BPF_JMP | BPF_JGT  | BPF_K:
-	case BPF_JMP | BPF_JLT  | BPF_K:
-	case BPF_JMP | BPF_JGE  | BPF_K:
-	case BPF_JMP | BPF_JLE  | BPF_K:
-	case BPF_JMP | BPF_JSGT | BPF_K:
-	case BPF_JMP | BPF_JSLT | BPF_K:
-	case BPF_JMP | BPF_JSGE | BPF_K:
-	case BPF_JMP | BPF_JSLE | BPF_K:
-	case BPF_JMP | BPF_JSET | BPF_K:
-		/* Accommodate for extra offset in case of a backjump. */
-		off = from->off;
-		if (off < 0)
-			off -= 2;
-		*to++ = BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ from->imm);
-		*to++ = BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
-		*to++ = BPF_JMP_REG(from->code, from->dst_reg, BPF_REG_AX, off);
-		break;
-
-	case BPF_JMP32 | BPF_JEQ  | BPF_K:
-	case BPF_JMP32 | BPF_JNE  | BPF_K:
-	case BPF_JMP32 | BPF_JGT  | BPF_K:
-	case BPF_JMP32 | BPF_JLT  | BPF_K:
-	case BPF_JMP32 | BPF_JGE  | BPF_K:
-	case BPF_JMP32 | BPF_JLE  | BPF_K:
-	case BPF_JMP32 | BPF_JSGT | BPF_K:
-	case BPF_JMP32 | BPF_JSLT | BPF_K:
-	case BPF_JMP32 | BPF_JSGE | BPF_K:
-	case BPF_JMP32 | BPF_JSLE | BPF_K:
-	case BPF_JMP32 | BPF_JSET | BPF_K:
-		/* Accommodate for extra offset in case of a backjump. */
-		off = from->off;
-		if (off < 0)
-			off -= 2;
-		*to++ = BPF_ALU32_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ from->imm);
-		*to++ = BPF_ALU32_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
-		*to++ = BPF_JMP32_REG(from->code, from->dst_reg, BPF_REG_AX,
-				      off);
-		break;
-
-	case BPF_LD | BPF_IMM | BPF_DW:
-		*to++ = BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ aux[1].imm);
-		*to++ = BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
-		*to++ = BPF_ALU64_IMM(BPF_LSH, BPF_REG_AX, 32);
-		*to++ = BPF_ALU64_REG(BPF_MOV, aux[0].dst_reg, BPF_REG_AX);
-		break;
-	case 0: /* Part 2 of BPF_LD | BPF_IMM | BPF_DW. */
-		*to++ = BPF_ALU32_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ aux[0].imm);
-		*to++ = BPF_ALU32_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
-		if (emit_zext)
-			*to++ = BPF_ZEXT_REG(BPF_REG_AX);
-		*to++ = BPF_ALU64_REG(BPF_OR,  aux[0].dst_reg, BPF_REG_AX);
-		break;
-
-	case BPF_ST | BPF_MEM | BPF_DW:
-	case BPF_ST | BPF_MEM | BPF_W:
-	case BPF_ST | BPF_MEM | BPF_H:
-	case BPF_ST | BPF_MEM | BPF_B:
-		*to++ = BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ from->imm);
-		*to++ = BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
-		*to++ = BPF_STX_MEM(from->code, from->dst_reg, BPF_REG_AX, from->off);
-		break;
-	}
-out:
-	return to - to_buff;
-}
-
-static struct bpf_prog *bpf_prog_clone_create(struct bpf_prog *fp_other,
-					      gfp_t gfp_extra_flags)
-{
-	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO | gfp_extra_flags;
-	struct bpf_prog *fp;
-
-	fp = __vmalloc(fp_other->pages * PAGE_SIZE, gfp_flags);
-	if (fp != NULL) {
-		/* aux->prog still points to the fp_other one, so
-		 * when promoting the clone to the real program,
-		 * this still needs to be adapted.
-		 */
-		memcpy(fp, fp_other, fp_other->pages * PAGE_SIZE);
-	}
-
-	return fp;
-}
-
-static void bpf_prog_clone_free(struct bpf_prog *fp)
-{
-	/* aux was stolen by the other clone, so we cannot free
-	 * it from this path! It will be freed eventually by the
-	 * other program on release.
-	 *
-	 * At this point, we don't need a deferred release since
-	 * clone is guaranteed to not be locked.
-	 */
-	fp->aux = NULL;
-	fp->stats = NULL;
-	fp->active = NULL;
-	__bpf_prog_free(fp);
-}
-
-void bpf_jit_prog_release_other(struct bpf_prog *fp, struct bpf_prog *fp_other)
-{
-	/* We have to repoint aux->prog to self, as we don't
-	 * know whether fp here is the clone or the original.
-	 */
-	fp->aux->prog = fp;
-	bpf_prog_clone_free(fp_other);
-}
-
-static void adjust_insn_arrays(struct bpf_prog *prog, u32 off, u32 len)
-{
-#ifdef CONFIG_BPF_SYSCALL
-	struct bpf_map *map;
-	int i;
-
-	if (len <= 1)
-		return;
-
-	for (i = 0; i < prog->aux->used_map_cnt; i++) {
-		map = prog->aux->used_maps[i];
-		if (map->map_type == BPF_MAP_TYPE_INSN_ARRAY)
-			bpf_insn_array_adjust(map, off, len);
-	}
-#endif
-}
-
-struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
-{
-	struct bpf_insn insn_buff[16], aux[2];
-	struct bpf_prog *clone, *tmp;
-	int insn_delta, insn_cnt;
-	struct bpf_insn *insn;
-	int i, rewritten;
-
-	if (!prog->blinding_requested || prog->blinded)
-		return prog;
-
-	clone = bpf_prog_clone_create(prog, GFP_USER);
-	if (!clone)
-		return ERR_PTR(-ENOMEM);
-
-	insn_cnt = clone->len;
-	insn = clone->insnsi;
-
-	for (i = 0; i < insn_cnt; i++, insn++) {
-		if (bpf_pseudo_func(insn)) {
-			/* ld_imm64 with an address of bpf subprog is not
-			 * a user controlled constant. Don't randomize it,
-			 * since it will conflict with jit_subprogs() logic.
-			 */
-			insn++;
-			i++;
-			continue;
-		}
-
-		/* We temporarily need to hold the original ld64 insn
-		 * so that we can still access the first part in the
-		 * second blinding run.
-		 */
-		if (insn[0].code == (BPF_LD | BPF_IMM | BPF_DW) &&
-		    insn[1].code == 0)
-			memcpy(aux, insn, sizeof(aux));
-
-		rewritten = bpf_jit_blind_insn(insn, aux, insn_buff,
-						clone->aux->verifier_zext);
-		if (!rewritten)
-			continue;
-
-		tmp = bpf_patch_insn_single(clone, i, insn_buff, rewritten);
-		if (IS_ERR(tmp)) {
-			/* Patching may have repointed aux->prog during
-			 * realloc from the original one, so we need to
-			 * fix it up here on error.
-			 */
-			bpf_jit_prog_release_other(prog, clone);
-			return tmp;
-		}
-
-		clone = tmp;
-		insn_delta = rewritten - 1;
-
-		/* Instructions arrays must be updated using absolute xlated offsets */
-		adjust_insn_arrays(clone, prog->aux->subprog_start + i, rewritten);
-
-		/* Walk new program and skip insns we just inserted. */
-		insn = clone->insnsi + i + insn_delta;
-		insn_cnt += insn_delta;
-		i        += insn_delta;
-	}
-
-	clone->blinded = 1;
-	return clone;
-}
 #endif /* CONFIG_BPF_JIT */
 
 /* Base function for offset calculation. Needs to go into .text section,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d92cf2821657..e2fffa08cba0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22815,7 +22815,6 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	struct bpf_insn *insn;
 	void *old_bpf_func;
 	int err, num_exentries;
-	int old_len, subprog_start_adjustment = 0;
 
 	if (env->subprog_cnt <= 1)
 		return 0;
@@ -22887,10 +22886,11 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 			goto out_free;
 		func[i]->is_func = 1;
 		func[i]->sleepable = prog->sleepable;
+		func[i]->blinded = prog->blinded;
 		func[i]->aux->func_idx = i;
 		/* Below members will be freed only at prog->aux */
 		func[i]->aux->btf = prog->aux->btf;
-		func[i]->aux->subprog_start = subprog_start + subprog_start_adjustment;
+		func[i]->aux->subprog_start = subprog_start;
 		func[i]->aux->func_info = prog->aux->func_info;
 		func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
 		func[i]->aux->poke_tab = prog->aux->poke_tab;
@@ -22946,15 +22946,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
 		if (!i)
 			func[i]->aux->exception_boundary = env->seen_exception;
-
-		/*
-		 * To properly pass the absolute subprog start to jit
-		 * all instruction adjustments should be accumulated
-		 */
-		old_len = func[i]->len;
 		func[i] = bpf_int_jit_compile(func[i]);
-		subprog_start_adjustment += func[i]->len - old_len;
-
 		if (!func[i]->jited) {
 			err = -ENOTSUPP;
 			goto out_free;
@@ -23093,6 +23085,206 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	return err;
 }
 
+static int bpf_blind_insn(const struct bpf_insn *from,
+			      const struct bpf_insn *aux,
+			      struct bpf_insn *to_buff,
+			      bool emit_zext)
+{
+	struct bpf_insn *to = to_buff;
+	u32 imm_rnd = get_random_u32();
+	s16 off;
+
+	BUILD_BUG_ON(BPF_REG_AX  + 1 != MAX_BPF_JIT_REG);
+	BUILD_BUG_ON(MAX_BPF_REG + 1 != MAX_BPF_JIT_REG);
+
+	/* Constraints on AX register:
+	 *
+	 * AX register is inaccessible from user space. It is mapped in
+	 * all JITs, and used here for constant blinding rewrites. It is
+	 * typically "stateless" meaning its contents are only valid within
+	 * the executed instruction, but not across several instructions.
+	 * There are a few exceptions however which are further detailed
+	 * below.
+	 *
+	 * Constant blinding is only used by JITs, not in the interpreter.
+	 * The interpreter uses AX in some occasions as a local temporary
+	 * register e.g. in DIV or MOD instructions.
+	 *
+	 * In restricted circumstances, the verifier can also use the AX
+	 * register for rewrites as long as they do not interfere with
+	 * the above cases!
+	 */
+	if (from->dst_reg == BPF_REG_AX || from->src_reg == BPF_REG_AX)
+		goto out;
+
+	if (from->imm == 0 &&
+	    (from->code == (BPF_ALU   | BPF_MOV | BPF_K) ||
+	     from->code == (BPF_ALU64 | BPF_MOV | BPF_K))) {
+		*to++ = BPF_ALU64_REG(BPF_XOR, from->dst_reg, from->dst_reg);
+		goto out;
+	}
+
+	switch (from->code) {
+	case BPF_ALU | BPF_ADD | BPF_K:
+	case BPF_ALU | BPF_SUB | BPF_K:
+	case BPF_ALU | BPF_AND | BPF_K:
+	case BPF_ALU | BPF_OR  | BPF_K:
+	case BPF_ALU | BPF_XOR | BPF_K:
+	case BPF_ALU | BPF_MUL | BPF_K:
+	case BPF_ALU | BPF_MOV | BPF_K:
+	case BPF_ALU | BPF_DIV | BPF_K:
+	case BPF_ALU | BPF_MOD | BPF_K:
+		*to++ = BPF_ALU32_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ from->imm);
+		*to++ = BPF_ALU32_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
+		*to++ = BPF_ALU32_REG_OFF(from->code, from->dst_reg, BPF_REG_AX, from->off);
+		break;
+
+	case BPF_ALU64 | BPF_ADD | BPF_K:
+	case BPF_ALU64 | BPF_SUB | BPF_K:
+	case BPF_ALU64 | BPF_AND | BPF_K:
+	case BPF_ALU64 | BPF_OR  | BPF_K:
+	case BPF_ALU64 | BPF_XOR | BPF_K:
+	case BPF_ALU64 | BPF_MUL | BPF_K:
+	case BPF_ALU64 | BPF_MOV | BPF_K:
+	case BPF_ALU64 | BPF_DIV | BPF_K:
+	case BPF_ALU64 | BPF_MOD | BPF_K:
+		*to++ = BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ from->imm);
+		*to++ = BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
+		*to++ = BPF_ALU64_REG_OFF(from->code, from->dst_reg, BPF_REG_AX, from->off);
+		break;
+
+	case BPF_JMP | BPF_JEQ  | BPF_K:
+	case BPF_JMP | BPF_JNE  | BPF_K:
+	case BPF_JMP | BPF_JGT  | BPF_K:
+	case BPF_JMP | BPF_JLT  | BPF_K:
+	case BPF_JMP | BPF_JGE  | BPF_K:
+	case BPF_JMP | BPF_JLE  | BPF_K:
+	case BPF_JMP | BPF_JSGT | BPF_K:
+	case BPF_JMP | BPF_JSLT | BPF_K:
+	case BPF_JMP | BPF_JSGE | BPF_K:
+	case BPF_JMP | BPF_JSLE | BPF_K:
+	case BPF_JMP | BPF_JSET | BPF_K:
+		/* Accommodate for extra offset in case of a backjump. */
+		off = from->off;
+		if (off < 0)
+			off -= 2;
+		*to++ = BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ from->imm);
+		*to++ = BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
+		*to++ = BPF_JMP_REG(from->code, from->dst_reg, BPF_REG_AX, off);
+		break;
+
+	case BPF_JMP32 | BPF_JEQ  | BPF_K:
+	case BPF_JMP32 | BPF_JNE  | BPF_K:
+	case BPF_JMP32 | BPF_JGT  | BPF_K:
+	case BPF_JMP32 | BPF_JLT  | BPF_K:
+	case BPF_JMP32 | BPF_JGE  | BPF_K:
+	case BPF_JMP32 | BPF_JLE  | BPF_K:
+	case BPF_JMP32 | BPF_JSGT | BPF_K:
+	case BPF_JMP32 | BPF_JSLT | BPF_K:
+	case BPF_JMP32 | BPF_JSGE | BPF_K:
+	case BPF_JMP32 | BPF_JSLE | BPF_K:
+	case BPF_JMP32 | BPF_JSET | BPF_K:
+		/* Accommodate for extra offset in case of a backjump. */
+		off = from->off;
+		if (off < 0)
+			off -= 2;
+		*to++ = BPF_ALU32_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ from->imm);
+		*to++ = BPF_ALU32_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
+		*to++ = BPF_JMP32_REG(from->code, from->dst_reg, BPF_REG_AX,
+				      off);
+		break;
+
+	case BPF_LD | BPF_IMM | BPF_DW:
+		*to++ = BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ aux[1].imm);
+		*to++ = BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
+		*to++ = BPF_ALU64_IMM(BPF_LSH, BPF_REG_AX, 32);
+		*to++ = BPF_ALU64_REG(BPF_MOV, aux[0].dst_reg, BPF_REG_AX);
+		break;
+	case 0: /* Part 2 of BPF_LD | BPF_IMM | BPF_DW. */
+		*to++ = BPF_ALU32_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ aux[0].imm);
+		*to++ = BPF_ALU32_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
+		if (emit_zext)
+			*to++ = BPF_ZEXT_REG(BPF_REG_AX);
+		*to++ = BPF_ALU64_REG(BPF_OR,  aux[0].dst_reg, BPF_REG_AX);
+		break;
+
+	case BPF_ST | BPF_MEM | BPF_DW:
+	case BPF_ST | BPF_MEM | BPF_W:
+	case BPF_ST | BPF_MEM | BPF_H:
+	case BPF_ST | BPF_MEM | BPF_B:
+		*to++ = BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ from->imm);
+		*to++ = BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
+		*to++ = BPF_STX_MEM(from->code, from->dst_reg, BPF_REG_AX, from->off);
+		break;
+	}
+out:
+	return to - to_buff;
+}
+
+static int bpf_blind_constants(struct bpf_verifier_env *env)
+{
+	struct bpf_insn insn_buff[16], aux[2];
+	struct bpf_prog *prog = env->prog;
+	int insn_delta, insn_cnt;
+	struct bpf_insn *insn;
+	int i, rewritten;
+
+	if (!prog->blinding_requested || prog->blinded)
+		return 0;
+
+	insn_cnt = prog->len;
+	insn = prog->insnsi;
+
+	for (i = 0; i < insn_cnt; i++, insn++) {
+		if (bpf_pseudo_func(insn)) {
+			/* ld_imm64 with an address of bpf subprog is not
+			 * a user controlled constant. Don't randomize it,
+			 * since it will conflict with jit_subprogs() logic.
+			 */
+			insn++;
+			i++;
+			continue;
+		}
+
+		/* We temporarily need to hold the original ld64 insn
+		 * so that we can still access the first part in the
+		 * second blinding run.
+		 */
+		if (insn[0].code == (BPF_LD | BPF_IMM | BPF_DW) &&
+		    insn[1].code == 0)
+			memcpy(aux, insn, sizeof(aux));
+
+		rewritten = bpf_blind_insn(insn, aux, insn_buff, prog->aux->verifier_zext);
+		if (!rewritten)
+			continue;
+
+		prog = bpf_patch_insn_data(env, i, insn_buff, rewritten);
+		if (!prog)
+			return -ENOMEM;
+
+		env->prog = prog;
+		insn_delta = rewritten - 1;
+
+		/* Walk new program and skip insns we just inserted. */
+		insn = prog->insnsi + i + insn_delta;
+		insn_cnt += insn_delta;
+		i        += insn_delta;
+
+		/* bpf_patch_insn_data() calls adjust_insn_aux_data() to adjust insn_aux_data. The
+		 * indirect_target flag for the original instruction is moved to the last of the new
+		 * instructions, but the indirect jump target is actually the first one, so move
+		 * it back.
+		 */
+		if (env->insn_aux_data[i].indirect_target) {
+			env->insn_aux_data[i].indirect_target = 0;
+			env->insn_aux_data[i - insn_delta].indirect_target = 1;
+		}
+	}
+
+	prog->blinded = 1;
+	return 0;
+}
+
 static int fixup_call_args(struct bpf_verifier_env *env)
 {
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
@@ -23105,6 +23297,9 @@ static int fixup_call_args(struct bpf_verifier_env *env)
 
 	if (env->prog->jit_requested &&
 	    !bpf_prog_is_offloaded(env->prog->aux)) {
+		err = bpf_blind_constants(env);
+		if (err)
+			return err;
 		err = jit_subprogs(env);
 		if (err == 0)
 			return 0;
-- 
2.47.3

