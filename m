Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5033D904F;
	Tue, 24 Mar 2026 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774353285; cv=none; b=AQ7azPgzU0cKDdg5hPyOufCa/JCDIcuXGt818vSmq8nm1PMi1gtkxW/2s0RILLHwnumM8mMKv/LeuNNDRiJT0xHbMDidNpIY5iyS7IjzdV3BZhkPiL39peMCfh9L5K11EzSiFTRRzMd3i8wh6XtEOWsnSF4OW9T1I/Sz3TVdi98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774353285; c=relaxed/simple;
	bh=l9An8UTwuha9FnbI46d+7kUVwVpCIzqotCCZEVArBso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xkf0EOMpJXFd0seutta2PceYjLPDqrKc7qmPezfKPxfLlnK+V2csZAtp7sq9Aiw+iTwGj9p25xqYXklEmvHGvOiNfxXZAoeXn/iwo64Jgd2PQmKh9ZZ01WZZssBd/f1hxhWxVVBIPjXWS/X9WQUzWpnd4XrYEdYqve1dKW84ic8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fg7jk3HV0zKHMcc;
	Tue, 24 Mar 2026 19:54:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7E22B40574;
	Tue, 24 Mar 2026 19:54:39 +0800 (CST)
Received: from k01.k01 (unknown [10.67.174.197])
	by APP1 (Coremail) with SMTP id cCh0CgAXGdl7e8Jpv2M5CA--.508S3;
	Tue, 24 Mar 2026 19:54:39 +0800 (CST)
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
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
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
Subject: [PATCH bpf-next v10 1/5] bpf: Move constants blinding out of arch-specific JITs
Date: Tue, 24 Mar 2026 20:20:48 +0800
Message-ID: <20260324122052.342751-2-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324122052.342751-1-xukuohai@huaweicloud.com>
References: <20260324122052.342751-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAXGdl7e8Jpv2M5CA--.508S3
X-Coremail-Antispam: 1UD129KBjvAXoWDCw4fAFW3AF4rJry8Gr1kuFg_yoW7WF1kWo
	Wa9w1DAF4rK34kGw4xKrn7GF13Zr18GrZrZr4fGFZ8Gayxt3yUKrZrXws8KaySva15GryD
	uF97Jay5ArZ0krnxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
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

This removes the constants blinding calls in each JIT, which are largely
duplicated code across architectures.

Since constants blinding is only required for JIT, and there are two
entry functions for JIT, jit_subprogs() and bpf_prog_select_runtime(),
move the constants blinding invocation into the two functions.

If constants blinding fails, or if it succeeds but the subsequent JIT
compilation fails, kernel falls back to running the BPF program with
interpreter. To ensure a correct rollback, the program cloning before
instruction rewriting in the constants blinding is preserved. During
the blinding process, only the cloned instructions are patched, leaving
the original program untouched.

Since bpf_patch_insn_data() is chosen for the constants blinding in the
verifier path, and it adjusts the global auxiliary data in the verifier
state, a key question is whether this auxiliary data should be restored
when JIT fails?

Besides instructions, bpf_patch_insn_data() adjusts env->insn_aux_data,
env->subprog_info, prog->aux->poke_tab and env->insn_array_maps. env->
insn_aux_data and env->subprog_info are no longer used after JIT failure
and are freed at the end of bpf_check(). prog->aux->poke_tab is only
used by JIT. And when the JIT fails, programs using insn_array would be
rejected by bpf_insn_array_ready() function since no JITed addresses
available. This means env->insn_array_maps is only useful for JIT.
Therefore, all the auxiliary data adjusted does not need to be restored.

For classic BPF programs, constants blinding works as before since it
is still invoked from bpf_prog_select_runtime().

Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com> # v8
Reviewed-by: Hari Bathini <hbathini@linux.ibm.com> # powerpc jit
Reviewed-by: Pu Lehui <pulehui@huawei.com> # riscv jit
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arc/net/bpf_jit_core.c      | 39 ++++++-----------
 arch/arm/net/bpf_jit_32.c        | 41 +++---------------
 arch/arm64/net/bpf_jit_comp.c    | 72 +++++++++----------------------
 arch/loongarch/net/bpf_jit.c     | 59 ++++++++------------------
 arch/mips/net/bpf_jit_comp.c     | 20 +--------
 arch/parisc/net/bpf_jit_core.c   | 73 +++++++++++++-------------------
 arch/powerpc/net/bpf_jit_comp.c  | 68 +++++++++++------------------
 arch/riscv/net/bpf_jit_core.c    | 61 ++++++++++----------------
 arch/s390/net/bpf_jit_comp.c     | 59 +++++++++-----------------
 arch/sparc/net/bpf_jit_comp_64.c | 61 +++++++++-----------------
 arch/x86/net/bpf_jit_comp.c      | 43 +++----------------
 arch/x86/net/bpf_jit_comp32.c    | 33 ++-------------
 include/linux/filter.h           | 23 +++++++++-
 kernel/bpf/core.c                | 66 +++++++++++++++++++++++++----
 kernel/bpf/verifier.c            | 53 ++++++++++++++---------
 15 files changed, 301 insertions(+), 470 deletions(-)

diff --git a/arch/arc/net/bpf_jit_core.c b/arch/arc/net/bpf_jit_core.c
index 1421eeced0f5..973ceae48675 100644
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
 
@@ -229,12 +211,19 @@ static void jit_ctx_cleanup(struct jit_context *ctx)
 		ctx->bpf2insn_valid = false;
 
 	/* Freeing "bpf_header" is enough. "jit.buf" is a sub-array of it. */
-	if (!ctx->success && ctx->bpf_header) {
-		bpf_jit_binary_free(ctx->bpf_header);
-		ctx->bpf_header = NULL;
-		ctx->jit.buf    = NULL;
-		ctx->jit.index  = 0;
-		ctx->jit.len    = 0;
+	if (!ctx->success) {
+		if (ctx->bpf_header) {
+			bpf_jit_binary_free(ctx->bpf_header);
+			ctx->bpf_header = NULL;
+			ctx->jit.buf    = NULL;
+			ctx->jit.index  = 0;
+			ctx->jit.len    = 0;
+		}
+		if (ctx->is_extra_pass) {
+			ctx->prog->bpf_func = NULL;
+			ctx->prog->jited = 0;
+			ctx->prog->jited_len = 0;
+		}
 	}
 
 	ctx->emit = false;
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
index adf84962d579..cd5a72fff500 100644
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
@@ -2193,16 +2162,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		if (extra_pass && ctx.idx > jit_data->ctx.idx) {
 			pr_err_once("multi-func JIT bug %d > %d\n",
 				    ctx.idx, jit_data->ctx.idx);
-			prog->bpf_func = NULL;
-			prog->jited = 0;
-			prog->jited_len = 0;
 			goto out_free_hdr;
 		}
 		if (WARN_ON(bpf_jit_binary_pack_finalize(ro_header, header))) {
-			/* ro_header has been freed */
+			/* ro_header and header has been freed */
 			ro_header = NULL;
-			prog = orig_prog;
-			goto out_off;
+			header = NULL;
+			goto out_free_hdr;
 		}
 		/*
 		 * The instructions have now been copied to the ROX region from
@@ -2245,13 +2211,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
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
+	if (extra_pass) {
+		prog->bpf_func = NULL;
+		prog->jited = 0;
+		prog->jited_len = 0;
+	}
 	if (header) {
 		bpf_arch_text_copy(&ro_header->size, &header->size,
 				   sizeof(header->size));
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 9cb796e16379..fcc8c0c29fb0 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1922,43 +1922,26 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 
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
@@ -1978,17 +1961,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
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
 
@@ -2004,10 +1983,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
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
@@ -2027,17 +2004,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
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
@@ -2050,9 +2023,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 			goto out_free;
 		}
 		if (WARN_ON(bpf_jit_binary_pack_finalize(ro_header, header))) {
-			/* ro_header has been freed */
+			/* ro_header and header have been freed */
 			ro_header = NULL;
-			prog = orig_prog;
+			header = NULL;
 			goto out_free;
 		}
 		/*
@@ -2084,13 +2057,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		prog->aux->jit_data = NULL;
 	}
 
-out:
-	if (tmp_blinded)
-		bpf_jit_prog_release_other(prog, prog == orig_prog ? tmp : orig_prog);
-
 	return prog;
 
 out_free:
+	if (extra_pass) {
+		prog->bpf_func = NULL;
+		prog->jited = 0;
+		prog->jited_len = 0;
+	}
+
 	if (header) {
 		bpf_arch_text_copy(&ro_header->size, &header->size, sizeof(header->size));
 		bpf_jit_binary_pack_free(ro_header, header);
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
index a5eb6b51e27a..35dca372b5df 100644
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
-		goto out_offset;
-	}
+	if (!ctx->offset)
+		goto out_err;
 	for (i = 0; i < prog->len; i++) {
 		prev_ninsns += 20;
 		ctx->offset[i] = prev_ninsns;
@@ -93,10 +80,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	for (i = 0; i < NR_JIT_ITERATIONS; i++) {
 		pass++;
 		ctx->ninsns = 0;
-		if (build_body(ctx, extra_pass, ctx->offset)) {
-			prog = orig_prog;
-			goto out_offset;
-		}
+		if (build_body(ctx, extra_pass, ctx->offset))
+			goto out_err;
 		ctx->body_len = ctx->ninsns;
 		bpf_jit_build_prologue(ctx);
 		ctx->prologue_len = ctx->ninsns - ctx->body_len;
@@ -116,10 +101,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 						     &jit_data->image,
 						     sizeof(long),
 						     bpf_fill_ill_insns);
-			if (!jit_data->header) {
-				prog = orig_prog;
-				goto out_offset;
-			}
+			if (!jit_data->header)
+				goto out_err;
 
 			ctx->insns = (u32 *)jit_data->image;
 			/*
@@ -134,8 +117,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		pr_err("bpf-jit: image did not converge in <%d passes!\n", i);
 		if (jit_data->header)
 			bpf_jit_binary_free(jit_data->header);
-		prog = orig_prog;
-		goto out_offset;
+		goto out_err;
 	}
 
 	if (extable_size)
@@ -148,8 +130,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	bpf_jit_build_prologue(ctx);
 	if (build_body(ctx, extra_pass, NULL)) {
 		bpf_jit_binary_free(jit_data->header);
-		prog = orig_prog;
-		goto out_offset;
+		goto out_err;
 	}
 	bpf_jit_build_epilogue(ctx);
 
@@ -160,20 +141,19 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 			{ extern int machine_restart(char *); machine_restart(""); }
 	}
 
+	if (!prog->is_func || extra_pass) {
+		if (bpf_jit_binary_lock_ro(jit_data->header)) {
+			bpf_jit_binary_free(jit_data->header);
+			goto out_err;
+		}
+		bpf_flush_icache(jit_data->header, ctx->insns + ctx->ninsns);
+	}
+
 	prog->bpf_func = (void *)ctx->insns;
 	prog->jited = 1;
 	prog->jited_len = prog_size;
 
-	bpf_flush_icache(jit_data->header, ctx->insns + ctx->ninsns);
-
 	if (!prog->is_func || extra_pass) {
-		if (bpf_jit_binary_lock_ro(jit_data->header)) {
-			bpf_jit_binary_free(jit_data->header);
-			prog->bpf_func = NULL;
-			prog->jited = 0;
-			prog->jited_len = 0;
-			goto out_offset;
-		}
 		prologue_len = ctx->epilogue_offset - ctx->body_len;
 		for (i = 0; i < prog->len; i++)
 			ctx->offset[i] += prologue_len;
@@ -183,14 +163,19 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
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
+
+out_err:
+	if (extra_pass) {
+		prog->bpf_func = NULL;
+		prog->jited = 0;
+		prog->jited_len = 0;
+	}
+	goto out_offset;
 }
 
 u64 hppa_div64(u64 div, u64 divisor)
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index a62a9a92b7b5..711028bebea3 100644
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
-		goto out_addrs;
-	}
+	if (addrs == NULL)
+		goto out_err;
 
 	memset(&cgctx, 0, sizeof(struct codegen_context));
 	bpf_jit_init_reg_mapping(&cgctx);
@@ -211,11 +195,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	cgctx.exception_cb = fp->aux->exception_cb;
 
 	/* Scouting faux-generate pass 0 */
-	if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false)) {
+	if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false))
 		/* We hit something illegal or unsupported. */
-		fp = org_fp;
-		goto out_addrs;
-	}
+		goto out_err;
 
 	/*
 	 * If we have seen a tail call, we need a second pass.
@@ -226,10 +208,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	 */
 	if (cgctx.seen & SEEN_TAILCALL || !is_offset_in_branch_range((long)cgctx.idx * 4)) {
 		cgctx.idx = 0;
-		if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false)) {
-			fp = org_fp;
-			goto out_addrs;
-		}
+		if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false))
+			goto out_err;
 	}
 
 	bpf_jit_realloc_regs(&cgctx);
@@ -250,10 +230,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 
 	fhdr = bpf_jit_binary_pack_alloc(alloclen, &fimage, 4, &hdr, &image,
 					      bpf_jit_fill_ill_insns);
-	if (!fhdr) {
-		fp = org_fp;
-		goto out_addrs;
-	}
+	if (!fhdr)
+		goto out_err;
 
 	if (extable_len)
 		fp->aux->extable = (void *)fimage + FUNCTION_DESCR_SIZE + proglen + fixup_len;
@@ -272,8 +250,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 				       extra_pass)) {
 			bpf_arch_text_copy(&fhdr->size, &hdr->size, sizeof(hdr->size));
 			bpf_jit_binary_pack_free(fhdr, hdr);
-			fp = org_fp;
-			goto out_addrs;
+			goto out_err;
 		}
 		bpf_jit_build_epilogue(code_base, &cgctx);
 
@@ -295,15 +272,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	((u64 *)image)[1] = local_paca->kernel_toc;
 #endif
 
+	if (!fp->is_func || extra_pass) {
+		if (bpf_jit_binary_pack_finalize(fhdr, hdr))
+			goto out_err;
+	}
+
 	fp->bpf_func = (void *)fimage;
 	fp->jited = 1;
 	fp->jited_len = cgctx.idx * 4 + FUNCTION_DESCR_SIZE;
 
 	if (!fp->is_func || extra_pass) {
-		if (bpf_jit_binary_pack_finalize(fhdr, hdr)) {
-			fp = org_fp;
-			goto out_addrs;
-		}
 		bpf_prog_fill_jited_linfo(fp, addrs);
 out_addrs:
 		kfree(addrs);
@@ -318,11 +296,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		jit_data->hdr = hdr;
 	}
 
-out:
-	if (bpf_blinded)
-		bpf_jit_prog_release_other(fp, fp == org_fp ? tmp_fp : org_fp);
-
 	return fp;
+
+out_err:
+	if (extra_pass) {
+		fp->bpf_func = NULL;
+		fp->jited = 0;
+		fp->jited_len = 0;
+	}
+	goto out_addrs;
 }
 
 /*
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index b3581e926436..527baa50dc68 100644
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
 
@@ -163,26 +144,27 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	ctx->nexentries = 0;
 
 	bpf_jit_build_prologue(ctx, bpf_is_subprog(prog));
-	if (build_body(ctx, extra_pass, NULL)) {
-		prog = orig_prog;
+	if (build_body(ctx, extra_pass, NULL))
 		goto out_free_hdr;
-	}
 	bpf_jit_build_epilogue(ctx);
 
 	if (bpf_jit_enable > 1)
 		bpf_jit_dump(prog->len, prog_size, pass, ctx->insns);
 
-	prog->bpf_func = (void *)ctx->ro_insns + cfi_get_offset();
-	prog->jited = 1;
-	prog->jited_len = prog_size - cfi_get_offset();
-
 	if (!prog->is_func || extra_pass) {
 		if (WARN_ON(bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header))) {
 			/* ro_header has been freed */
 			jit_data->ro_header = NULL;
-			prog = orig_prog;
-			goto out_offset;
+			jit_data->header = NULL;
+			goto out_free_hdr;
 		}
+	}
+
+	prog->bpf_func = (void *)ctx->ro_insns + cfi_get_offset();
+	prog->jited = 1;
+	prog->jited_len = prog_size - cfi_get_offset();
+
+	if (!prog->is_func || extra_pass) {
 		/*
 		 * The instructions have now been copied to the ROX region from
 		 * where they will execute.
@@ -198,14 +180,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		kfree(jit_data);
 		prog->aux->jit_data = NULL;
 	}
-out:
 
-	if (tmp_blinded)
-		bpf_jit_prog_release_other(prog, prog == orig_prog ?
-					   tmp : orig_prog);
 	return prog;
 
 out_free_hdr:
+	if (extra_pass) {
+		prog->bpf_func = NULL;
+		prog->jited = 0;
+		prog->jited_len = 0;
+	}
 	if (jit_data->header) {
 		bpf_arch_text_copy(&jit_data->ro_header->size, &jit_data->header->size,
 				   sizeof(jit_data->header->size));
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index d08d159b6319..2dfc279b1be2 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2314,36 +2314,20 @@ static struct bpf_binary_header *bpf_jit_alloc(struct bpf_jit *jit,
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
@@ -2356,34 +2340,27 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 
 	memset(&jit, 0, sizeof(jit));
 	jit.addrs = kvcalloc(fp->len + 1, sizeof(*jit.addrs), GFP_KERNEL);
-	if (jit.addrs == NULL) {
-		fp = orig_fp;
-		goto free_addrs;
-	}
+	if (jit.addrs == NULL)
+		goto out_err;
 	/*
 	 * Three initial passes:
 	 *   - 1/2: Determine clobbered registers
 	 *   - 3:   Calculate program size and addrs array
 	 */
 	for (pass = 1; pass <= 3; pass++) {
-		if (bpf_jit_prog(&jit, fp, extra_pass)) {
-			fp = orig_fp;
-			goto free_addrs;
-		}
+		if (bpf_jit_prog(&jit, fp, extra_pass))
+			goto out_err;
 	}
 	/*
 	 * Final pass: Allocate and generate program
 	 */
 	header = bpf_jit_alloc(&jit, fp);
-	if (!header) {
-		fp = orig_fp;
-		goto free_addrs;
-	}
+	if (!header)
+		goto out_err;
 skip_init_ctx:
 	if (bpf_jit_prog(&jit, fp, extra_pass)) {
 		bpf_jit_binary_free(header);
-		fp = orig_fp;
-		goto free_addrs;
+		goto out_err;
 	}
 	if (bpf_jit_enable > 1) {
 		bpf_jit_dump(fp->len, jit.size, pass, jit.prg_buf);
@@ -2392,8 +2369,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	if (!fp->is_func || extra_pass) {
 		if (bpf_jit_binary_lock_ro(header)) {
 			bpf_jit_binary_free(header);
-			fp = orig_fp;
-			goto free_addrs;
+			goto out_err;
 		}
 	} else {
 		jit_data->header = header;
@@ -2411,11 +2387,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		kfree(jit_data);
 		fp->aux->jit_data = NULL;
 	}
-out:
-	if (tmp_blinded)
-		bpf_jit_prog_release_other(fp, fp == orig_fp ?
-					   tmp : orig_fp);
+
 	return fp;
+
+out_err:
+	if (extra_pass) {
+		fp->bpf_func = NULL;
+		fp->jited = 0;
+		fp->jited_len = 0;
+	}
+	goto free_addrs;
 }
 
 bool bpf_jit_supports_kfunc_call(void)
diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
index b23d1c645ae5..e83e29137566 100644
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
-		goto out_off;
-	}
+	if (ctx.offset == NULL)
+		goto out_err;
 
 	/* Longest sequence emitted is for bswap32, 12 instructions.  Pre-cook
 	 * the offset array so that we converge faster.
@@ -1543,10 +1526,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		ctx.idx = 0;
 
 		build_prologue(&ctx);
-		if (build_body(&ctx)) {
-			prog = orig_prog;
-			goto out_off;
-		}
+		if (build_body(&ctx))
+			goto out_err;
 		build_epilogue(&ctx);
 
 		if (bpf_jit_enable > 1)
@@ -1569,10 +1550,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	image_size = sizeof(u32) * ctx.idx;
 	header = bpf_jit_binary_alloc(image_size, &image_ptr,
 				      sizeof(u32), jit_fill_hole);
-	if (header == NULL) {
-		prog = orig_prog;
-		goto out_off;
-	}
+	if (header == NULL)
+		goto out_err;
 
 	ctx.image = (u32 *)image_ptr;
 skip_init_ctx:
@@ -1582,8 +1561,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
 	if (build_body(&ctx)) {
 		bpf_jit_binary_free(header);
-		prog = orig_prog;
-		goto out_off;
+		goto out_err;
 	}
 
 	build_epilogue(&ctx);
@@ -1592,8 +1570,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		pr_err("bpf_jit: Failed to converge, prev_size=%u size=%d\n",
 		       prev_image_size, ctx.idx * 4);
 		bpf_jit_binary_free(header);
-		prog = orig_prog;
-		goto out_off;
+		goto out_err;
 	}
 
 	if (bpf_jit_enable > 1)
@@ -1604,8 +1581,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	if (!prog->is_func || extra_pass) {
 		if (bpf_jit_binary_lock_ro(header)) {
 			bpf_jit_binary_free(header);
-			prog = orig_prog;
-			goto out_off;
+			goto out_err;
 		}
 	} else {
 		jit_data->ctx = ctx;
@@ -1624,9 +1600,14 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		kfree(jit_data);
 		prog->aux->jit_data = NULL;
 	}
-out:
-	if (tmp_blinded)
-		bpf_jit_prog_release_other(prog, prog == orig_prog ?
-					   tmp : orig_prog);
+
 	return prog;
+
+out_err:
+	if (extra_pass) {
+		prog->bpf_func = NULL;
+		prog->jited = 0;
+		prog->jited_len = 0;
+	}
+	goto out_off;
 }
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e9b78040d703..77d00a8dec87 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3717,13 +3717,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
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
@@ -3733,27 +3731,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
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
-			goto out;
-		}
+		if (!jit_data)
+			return prog;
 		prog->aux->jit_data = jit_data;
 	}
 	priv_stack_ptr = prog->aux->priv_stack_ptr;
@@ -3765,10 +3749,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
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
@@ -3786,10 +3768,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
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
@@ -3820,8 +3800,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 						   sizeof(rw_header->size));
 				bpf_jit_binary_pack_free(header, rw_header);
 			}
-			/* Fall back to interpreter mode */
-			prog = orig_prog;
 			if (extra_pass) {
 				prog->bpf_func = NULL;
 				prog->jited = 0;
@@ -3852,10 +3830,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
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
@@ -3908,8 +3884,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		prog->bpf_func = (void *)image + cfi_get_offset();
 		prog->jited = 1;
 		prog->jited_len = proglen - cfi_get_offset();
-	} else {
-		prog = orig_prog;
 	}
 
 	if (!image || !prog->is_func || extra_pass) {
@@ -3925,10 +3899,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
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
index 44d7ae95ddbc..d8c97f463e0f 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1184,6 +1184,18 @@ static inline bool bpf_dump_raw_ok(const struct cred *cred)
 
 struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 				       const struct bpf_insn *patch, u32 len);
+
+#ifdef CONFIG_BPF_SYSCALL
+struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
+				     const struct bpf_insn *patch, u32 len);
+#else
+static inline struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
+						   const struct bpf_insn *patch, u32 len)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+#endif
+
 int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt);
 
 static inline bool xdp_return_frame_no_direct(void)
@@ -1310,7 +1322,7 @@ int bpf_jit_get_func_addr(const struct bpf_prog *prog,
 
 const char *bpf_jit_get_prog_name(struct bpf_prog *prog);
 
-struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *fp);
+struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bpf_prog *prog);
 void bpf_jit_prog_release_other(struct bpf_prog *fp, struct bpf_prog *fp_other);
 
 static inline void bpf_jit_dump(unsigned int flen, unsigned int proglen,
@@ -1451,6 +1463,15 @@ static inline void bpf_prog_kallsyms_del(struct bpf_prog *fp)
 {
 }
 
+static inline
+struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bpf_prog *prog)
+{
+	return prog;
+}
+
+static inline void bpf_jit_prog_release_other(struct bpf_prog *fp, struct bpf_prog *fp_other)
+{
+}
 #endif /* CONFIG_BPF_JIT */
 
 void bpf_prog_kallsyms_del_all(struct bpf_prog *fp);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 67eb12b637a5..8f52f4b6c3af 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1507,13 +1507,16 @@ static void adjust_insn_arrays(struct bpf_prog *prog, u32 off, u32 len)
 #endif
 }
 
-struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
+struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	struct bpf_insn insn_buff[16], aux[2];
 	struct bpf_prog *clone, *tmp;
 	int insn_delta, insn_cnt;
 	struct bpf_insn *insn;
-	int i, rewritten;
+	int i, rewritten, subprog_start;
+
+	if (env)
+		prog = env->prog;
 
 	if (!prog->blinding_requested || prog->blinded)
 		return prog;
@@ -1522,8 +1525,13 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
 	if (!clone)
 		return ERR_PTR(-ENOMEM);
 
+	/* make sure bpf_patch_insn_data() patches the correct prog */
+	if (env)
+		env->prog = clone;
+
 	insn_cnt = clone->len;
 	insn = clone->insnsi;
+	subprog_start = prog->aux->subprog_start;
 
 	for (i = 0; i < insn_cnt; i++, insn++) {
 		if (bpf_pseudo_func(insn)) {
@@ -1549,21 +1557,34 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
 		if (!rewritten)
 			continue;
 
-		tmp = bpf_patch_insn_single(clone, i, insn_buff, rewritten);
-		if (IS_ERR(tmp)) {
+		if (env)
+			tmp = bpf_patch_insn_data(env, subprog_start + i, insn_buff, rewritten);
+		else
+			tmp = bpf_patch_insn_single(clone, i, insn_buff, rewritten);
+
+		if (IS_ERR_OR_NULL(tmp)) {
+			/* restore the original prog */
+			if (env)
+				env->prog = prog;
 			/* Patching may have repointed aux->prog during
 			 * realloc from the original one, so we need to
 			 * fix it up here on error.
 			 */
 			bpf_jit_prog_release_other(prog, clone);
-			return tmp;
+			return IS_ERR(tmp) ? tmp : ERR_PTR(-ENOMEM);
 		}
 
 		clone = tmp;
 		insn_delta = rewritten - 1;
 
-		/* Instructions arrays must be updated using absolute xlated offsets */
-		adjust_insn_arrays(clone, prog->aux->subprog_start + i, rewritten);
+		if (env)
+			env->prog = clone;
+		else
+			/* Instructions arrays must be updated using absolute xlated offsets.
+			 * The arrays have already been adjusted by bpf_patch_insn_data() when
+			 * env is not NULL.
+			 */
+			adjust_insn_arrays(clone, subprog_start + i, rewritten);
 
 		/* Walk new program and skip insns we just inserted. */
 		insn = clone->insnsi + i + insn_delta;
@@ -2532,6 +2553,35 @@ static bool bpf_prog_select_interpreter(struct bpf_prog *fp)
 	return select_interpreter;
 }
 
+static struct bpf_prog *bpf_prog_jit_compile(struct bpf_prog *prog)
+{
+#ifdef CONFIG_BPF_JIT
+	bool blinded = false;
+	struct bpf_prog *orig_prog = prog;
+
+	prog = bpf_jit_blind_constants(NULL, orig_prog);
+	/* If blinding was requested and we failed during blinding, we must fall
+	 * back to the interpreter.
+	 */
+	if (IS_ERR(prog))
+		return orig_prog;
+
+	if (prog != orig_prog)
+		blinded = true;
+
+	prog = bpf_int_jit_compile(prog);
+	if (blinded) {
+		if (!prog->jited) {
+			bpf_jit_prog_release_other(orig_prog, prog);
+			prog = orig_prog;
+		} else {
+			bpf_jit_prog_release_other(prog, orig_prog);
+		}
+	}
+#endif
+	return prog;
+}
+
 /**
  *	bpf_prog_select_runtime - select exec runtime for BPF program
  *	@fp: bpf_prog populated with BPF program
@@ -2571,7 +2621,7 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
 		if (*err)
 			return fp;
 
-		fp = bpf_int_jit_compile(fp);
+		fp = bpf_prog_jit_compile(fp);
 		bpf_prog_jit_attempt_done(fp);
 		if (!fp->jited && jit_needed) {
 			*err = -ENOTSUPP;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cd008b146ee5..1b2b99f2d859 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22105,8 +22105,8 @@ static void adjust_poke_descs(struct bpf_prog *prog, u32 off, u32 len)
 	}
 }
 
-static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
-					    const struct bpf_insn *patch, u32 len)
+struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
+				     const struct bpf_insn *patch, u32 len)
 {
 	struct bpf_prog *new_prog;
 	struct bpf_insn_aux_data *new_data = NULL;
@@ -22875,17 +22875,23 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 
 static int jit_subprogs(struct bpf_verifier_env *env)
 {
-	struct bpf_prog *prog = env->prog, **func, *tmp;
+	struct bpf_prog *orig_prog = env->prog, *prog, **func, *tmp;
 	int i, j, subprog_start, subprog_end = 0, len, subprog;
 	struct bpf_map *map_ptr;
 	struct bpf_insn *insn;
 	void *old_bpf_func;
 	int err, num_exentries;
-	int old_len, subprog_start_adjustment = 0;
+	bool blinded = false;
 
 	if (env->subprog_cnt <= 1)
 		return 0;
 
+	prog = bpf_jit_blind_constants(env, NULL);
+	if (IS_ERR(prog))
+		return -ENOMEM;
+	if (prog != orig_prog)
+		blinded = true;
+
 	for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
 		if (!bpf_pseudo_func(insn) && !bpf_pseudo_call(insn))
 			continue;
@@ -22896,8 +22902,13 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		 */
 		subprog = find_subprog(env, i + insn->imm + 1);
 		if (verifier_bug_if(subprog < 0, env, "No program to jit at insn %d",
-				    i + insn->imm + 1))
+				    i + insn->imm + 1)) {
+			if (blinded) {
+				bpf_jit_prog_release_other(orig_prog, prog);
+				env->prog = orig_prog;
+			}
 			return -EFAULT;
+		}
 		/* temporarily remember subprog id inside insn instead of
 		 * aux_data, since next loop will split up all insns into funcs
 		 */
@@ -22953,10 +22964,11 @@ static int jit_subprogs(struct bpf_verifier_env *env)
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
@@ -23012,15 +23024,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
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
@@ -23124,6 +23128,10 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	prog->aux->bpf_exception_cb = (void *)func[env->exception_callback_subprog]->bpf_func;
 	prog->aux->exception_boundary = func[0]->aux->exception_boundary;
 	bpf_prog_jit_attempt_done(prog);
+
+	if (blinded)
+		bpf_jit_prog_release_other(prog, orig_prog);
+
 	return 0;
 out_free:
 	/* We failed JIT'ing, so at this point we need to unregister poke
@@ -23146,14 +23154,21 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	}
 	kfree(func);
 out_undo_insn:
+	if (blinded) {
+		bpf_jit_prog_release_other(orig_prog, prog);
+		env->prog = prog = orig_prog;
+	}
 	/* cleanup main prog to be interpreted */
 	prog->jit_requested = 0;
 	prog->blinding_requested = 0;
-	for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
-		if (!bpf_pseudo_call(insn))
-			continue;
-		insn->off = 0;
-		insn->imm = env->insn_aux_data[i].call_imm;
+	/* we already rolled back to the clean orig_prog when blinded is true */
+	if (!blinded) {
+		for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
+			if (!bpf_pseudo_call(insn))
+				continue;
+			insn->off = 0;
+			insn->imm = env->insn_aux_data[i].call_imm;
+		}
 	}
 	bpf_prog_jit_attempt_done(prog);
 	return err;
-- 
2.47.3

