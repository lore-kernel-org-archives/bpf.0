Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148296;
	b=1PxK7oytW3uXb1OQpYlx8fvJrZCOxGif/tcQEY9IDakaeSp16L8yWFnnPx3q2XwcLUgD
	 98TvkIQyxx1BZAsRio22NOQt1FXDhXYXUbu7GEqruaY7teTwjvBzKF0OBf/F3DegoZwxz
	 8ceNGWlM5YhwPmY9W22711kGeJSw4UsqJO3B+WFTKW85QdA69MNbUbmMTZDPmBbCmQssQ
	 9xuwwCgUEfaus3hWs+5m741A8fGTUBEvM45TuOsc8aUbeCQ+7pk/wEKAOsHavuR+PxDyW
	 YV2yNcfI29fEgleLhWDOYIY+CeEVm417mLZ/Sq7swn+U3XhTuyt68ZdCIiZcFGiMC8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=MPCAvEVlDplZjIJpS+1gpI4FdQYvYF7C8Gn9ePrUGZM=;
	b=TMPDlJy8zv5qvBY+H67c+TvF65OM7ArPEVNG4ii8HVNqBAu3X+Fhe1vB5PEdeUtXrVX/
	 nnU2Ff6jyVGCYwvya2Kr3cI6WJYgDCQhX+DfMp5jhMWoA97PrxMQDpWuOnq2uQo5L6xAq
	 qsQTauZBVVB9Wv2zlfacZgRlDttS4dA4ZK8YWbJfxH81GBYOkGGXPTOKNXHOW360Q++F7
	 gTeYHi789OjlhjVWALQc+UMKkiDL+rJIHIYgw8zTvF0Ym0Aa+r7hZyqBNzcUMgOhKrKM/
	 qWQUvnt5KO4CG1Dwa0Ifm9Xr50CPCo7b5cLEZa4kklbK0Em6Lk8KvBwdhJG2Ipy8nFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="p+5D/5+1";
	arc=none smtp.remote-ip=74.125.225.74
Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34AD606A323
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 00:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D34AD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p+5D/5+1
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-48df0245ce6so247566f8f.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 17:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793148294; x=1793753094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MPCAvEVlDplZjIJpS+1gpI4FdQYvYF7C8Gn9ePrUGZM=;
        b=p+5D/5+1NreXoVx6V6cnNXTJ2Hc+tnF7geaWXPqwcFWvtqXaZywBcOP65n8fCwNRX2
         BTvkGZPz1CNjTE7YTxsA6QJAqZrlIFyDBHT8faQEOoA5uHn07QfVdEGz25zyM5yMEZwr
         F2hgT0uN1iv+NVh1byKwTMQ6vcXBw6VkuaaTNNszwOZyjrdxI4TL9OAIqAU8xHW9LW0a
         TFoWiXedazM0LZJ9LiRQmbIS1GuMvf5gO0UkqSZKxj1Ji36wVb39omlm+PyPllESWJ7i
         4LvsnHrFaywxNbT2QhTbbp8afcpYEugz8CB3EGtKaaVITI4o0/boNGy6/wZCqUB8xB0n
         tZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793148294; x=1793753094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MPCAvEVlDplZjIJpS+1gpI4FdQYvYF7C8Gn9ePrUGZM=;
        b=Z+ULAGAm73AMNCxCMCYshT3oXJommMLxYr92Wwz9B7gXIQkc3Nr6tgD3AAmswaMPEs
         V5feP6CHxEvpAImsQy/eQtZ74mG1Pua5hTpvqdaN+C5hbAvZxwQ+127uFwGjrJyI6CkF
         L/rdDE+B2ei9AsURvssIelA05p+fbQGDCnOkzhK2tTgUfMN4K7VcbAUANRhve+nGC2d8
         Fm+4fpz5w0mSZUdjwxRnsR1OUkmf0L6GIzogv2JQ2FWKejYWHKd/Kefc3losFiSx5bKt
         ZjBUoiURZtC2YFPbudJhDBxhQDNweA8nB/CgmcAm+uIWv9SunW4GWJhMXvq2wSoFURBl
         KX+A==
X-Gm-Message-State: AFq9FYJWf2AztgAhgz9aqkxDC2XMjRjSTVLbwMe4IESKueim1q7rx3NN
	KYeEja0zO+VKEOHbByvKx7Q/T49fJsMmFiMiIIXxCQPnz4nZjgJc2Yv3nd0rhbYs
X-Gm-Gg: AYBFou1s2FzMnhxUWCIsKcSgWYSMpefHBL7a5NBA2Jd/gVUj7lcXdPRBsMlgxoPF1nB
	rSIvuTk5+tJb/wjPozTCOAETMRbp8k/qdvbrAR4K56BAjgoCfqALE660kAkTIhVeugmmDjG/4qy
	8aTkSHs/RO2KvFqODHF9AusAFnV68uCHnkD4VH04xAVFaV7ik8elcTfeoDWEz53VCXjfDSXiNlB
	EEdufU8HBpLm7nqL6Y+LPjFrrK9cahNGtznsUfdlC99LPj+zTdKvjbdJInBUkcQ5L8DnrmJ0S9N
	rxvvXUTIoQyb8largOH58kVPKH8WqtevVZD/hU79na9qTw8MskfSaVSTXlhjrbo/NHlAESVwl7j
	UlM5JyOPO54+71lVOmX4aRJ1sD1r84+9e+Qrs5Nv0aZVS8JW4hHjUfcBdbC3mvTVfCCBCzXNzaX
	hK5XpuTC8xgLymCYFgpEVFZIEK09TovDRU7v+9BIB5jJBPxtLNeAOh3sSjX4g5r75eTMxTAiAW+
	4OjPOyvY4FiYzniAa42TitWtQKHlBAat+VukMOT4oLbPeNRp2g9s9umCWRb1Oj9faMJzqUI7x0V
	xR1RUXEiAIN+8NFPVMQP1KApjX2DHqLijDwDpveCjnX4PUBP952oMuN4BGJGxI/FUEU2N7aYljU
	jBoahJQPAFa+N0qGiGrU=
X-Received: by 2002:a5d:5611:0:b0:48e:f10:ceb8 with SMTP id ffacd0b85a97d-48e5d5909d7mr1551288f8f.11.1793148294080;
        Tue, 27 Oct 2026 17:44:54 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f37csm20662779f8f.8.2026.10.27.17.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 17:44:53 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 02/11] bpf, arm64: Let the pad after a helper call have r0
Date: Wed, 28 Oct 2026 01:44:39 +0100
Message-ID: <f86599ab5644a86943345b2650d1d11a0363bb6f.1793147364.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793147364.git.memxor@gmail.com>
References: <cover.1793147364.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8482; i=memxor@gmail.com; h=from:subject:message-id; bh=nr/hkIOGn+Kcm+5st09jsxGDqJ2Y9yRUJuO8eoJ7AN4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuh49MQPfa9/x/ZvnMOOxVcLnBXMKSIbcWX2r6ERp3j9 hF7QnQ7SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMBGxeIa/ksm3Dmg0e5ne2i5w LahQ5NZ5i96Ttzp/ibCeeFfnutIthuEPv3TFS6UpcqecDs36udcxwKLzmdS2b5KOr2d87S/kuJv LDQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The JIT emits 'bl foo; mov x8, x0' for a call, and the extable entry of
the unwind_goto that follows sends unwind_exit of the callee past the
mov, into the pad. That is fine after the call of a subprog: r0 is x8 in
the subprog too, its epilogue copies x8 to x0 and leaves x8 as it is. A
helper that leaves to the pad from a pad of its own, see
bpf_unwind_leave(), returns r0 in x0 alone, and x8 is whatever it last
used it for.

So the pad after the call of a helper or a kfunc is entered through a
landing of its own, 'mov x8, x0; b pad', past the epilogue where nothing
falls into it, and the entry of the unwind_goto points there. The
landings go in after the body, when the pads are placed and the entries
are in, and each fills in the fixup of its entry. The normal path has
nothing in its way: unwind_goto emits nothing, as before. The pad after
the call of a subprog is as it was. x86-64 needs nothing: r0 is rax.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c | 97 +++++++++++++++++++++++++++++++----
 1 file changed, 86 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index b8fb49b00063..284c1dd791ad 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -81,6 +81,8 @@ struct jit_ctx {
 	int epilogue_offset;
 	int *offset;
 	int exentry_idx;
+	int *landing_ex;	/* the extable entry of each landing, see build_landings() */
+	int landing_idx;
 	int nr_used_callee_reg;
 	u8 used_callee_reg[8]; /* r6~r9, fp, arena_vm_start */
 	__le32 *image;
@@ -1227,19 +1229,24 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	return 0;
 }
 
+/* unwind_goto after the call of a helper or a kfunc, which return r0 in x0 alone */
+static bool unwind_goto_after_helper(const struct bpf_insn *insn)
+{
+	const struct bpf_insn *call = insn - 1;
+
+	return call->code == (BPF_JMP | BPF_CALL) && call->src_reg != BPF_PSEUDO_CALL;
+}
+
 /*
  * There is no branch for unwind_goto, only an extable entry
- *   { .insn = ret_addr - 1, .fixup = pad - ret_addr }
- * where ret_addr is the return address of the call in front of it. unwind_exit
- * adds .fixup to its LR.
+ *   { .insn = ret_addr - 1, .fixup = target - ret_addr }
+ * where ret_addr is the return address of the call in front of it, and target
+ * the pad, or the way into it. unwind_exit adds .fixup to its LR.
  * ret_addr - 1, because what follows the call can have an entry of its own.
  * No insn starts there, so a fault cannot hit the entry.
- * 'bl foo; mov x8, x0' is in front of unwind_goto. The pad doesn't miss the mov:
- * r0 is x8 and the epilogue of the callee copies it to x0 and leaves x8 as it is.
  */
-static int add_unwind_exentry(struct jit_ctx *ctx, int pad)
+static int add_unwind_exentry(struct jit_ctx *ctx, int ret_addr, int target)
 {
-	int ret_addr = ctx->idx - 1;
 	struct exception_table_entry *ex;
 	off_t ins_offset;
 
@@ -1259,13 +1266,47 @@ static int add_unwind_exentry(struct jit_ctx *ctx, int pad)
 	/* switch ex to rw buffer for writing */
 	ex = (void *)ctx->image + ((void *)ex - (void *)ctx->ro_image);
 	ex->insn = ins_offset;
-	ex->fixup = (ctx->offset[pad] - ret_addr) * AARCH64_INSN_SIZE;
+	ex->fixup = (target - ret_addr) * AARCH64_INSN_SIZE;
 	ex->type = EX_TYPE_BPF;
 
 	ctx->exentry_idx++;
 	return 0;
 }
 
+/*
+ * The landings of the pads after the calls of helpers and kfuncs, past the
+ * epilogue, where nothing falls into them: 'mov x8, x0; b pad' each, see the
+ * unwind_goto case of build_insn(). They go in after the body, when the pads
+ * are placed and the entries are in, and each fills in the fixup of its entry.
+ */
+static int build_landings(struct jit_ctx *ctx)
+{
+	const struct bpf_prog *prog = ctx->prog;
+	int i, k = 0;
+
+	for (i = 1; i < prog->len; i++) {
+		const struct bpf_insn *insn = &prog->insnsi[i];
+		int ret_addr, jmp_offset;
+
+		if (!bpf_is_unwind_goto(insn) || !unwind_goto_after_helper(insn))
+			continue;
+		ret_addr = ctx->offset[i] - 1;
+		if (ctx->image) {
+			struct exception_table_entry *ex;
+
+			ex = &prog->aux->extable[ctx->landing_ex[k]];
+			ex = (void *)ctx->image + ((void *)ex - (void *)ctx->ro_image);
+			ex->fixup = (ctx->idx - ret_addr) * AARCH64_INSN_SIZE;
+		}
+		k++;
+		emit(A64_MOV(1, bpf2a64[BPF_REG_0], A64_R(0)), ctx);
+		jmp_offset = ctx->offset[i + 1 + insn->off] - ctx->idx;
+		check_imm26(jmp_offset);
+		emit(A64_B(jmp_offset), ctx);
+	}
+	return 0;
+}
+
 /*
  * The verifier made sure that unwind_goto follows a call in a prog. When the
  * kernel called an async callback, it's exit. A helper that calls a callback
@@ -1901,10 +1942,27 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 		break;
 	/* unwind_goto. The verifier expanded may_goto. */
 	case BPF_JMP | BPF_JCOND:
-		ret = add_unwind_exentry(ctx, i + 1 + off);
+	{
+		int ret_addr = ctx->idx - 1;
+		int target = ctx->offset[i + 1 + off];
+
+		/*
+		 * 'bl foo; mov x8, x0' is in front. After the call of a subprog
+		 * the pad doesn't miss the mov: r0 is x8 in the subprog too, its
+		 * epilogue copies x8 to x0 and leaves x8 as it is. A helper that
+		 * leaves to the pad returns r0 in x0 alone, so the pad after its
+		 * call is entered through a landing past the epilogue, see
+		 * build_landings(), which fills in the fixup of the entry.
+		 */
+		if (unwind_goto_after_helper(insn)) {
+			ctx->landing_ex[ctx->landing_idx++] = ctx->exentry_idx;
+			target = ret_addr;
+		}
+		ret = add_unwind_exentry(ctx, ret_addr, target);
 		if (ret)
 			return ret;
 		break;
+	}
 	/* function return */
 	case BPF_JMP | BPF_EXIT:
 		if (bpf_is_unwind_exit(insn) && bpf_prog_can_unwind(ctx->prog)) {
@@ -2342,7 +2400,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	u8 *ro_image_ptr;
 	int body_idx;
 	int exentry_idx;
+	int nr_landings = 0;
 	int out_cnt;
+	int i;
 
 	if (!prog->jit_requested)
 		return prog;
@@ -2387,6 +2447,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	if (ctx.offset == NULL)
 		goto out_off;
 
+	for (i = 1; i < prog->len; i++)
+		if (bpf_is_unwind_goto(&prog->insnsi[i]) &&
+		    unwind_goto_after_helper(&prog->insnsi[i]))
+			nr_landings++;
+	if (nr_landings) {
+		ctx.landing_ex = kvzalloc_objs(int, nr_landings);
+		if (ctx.landing_ex == NULL)
+			goto out_off;
+	}
+
 	if (bpf_prog_uses_arena_insns(prog)) {
 		ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
 		ctx.arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
@@ -2416,6 +2486,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 
 	ctx.epilogue_offset = ctx.idx;
 	build_epilogue(&ctx, was_classic, false);
+	if (build_landings(&ctx))
+		goto out_off;
 	build_plt(&ctx);
 
 	extable_align = __alignof__(struct exception_table_entry);
@@ -2449,6 +2521,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 skip_init_ctx:
 	ctx.idx = 0;
 	ctx.exentry_idx = 0;
+	ctx.landing_idx = 0;
 	ctx.write = true;
 
 	build_prologue(&ctx, was_classic);
@@ -2464,6 +2537,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 
 	ctx.epilogue_offset = ctx.idx;
 	ctx.exentry_idx = exentry_idx;
+	ctx.landing_idx = 0;
 	ctx.idx = body_idx;
 	ctx.write = true;
 
@@ -2473,6 +2547,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 		goto out_free_hdr;
 
 	build_epilogue(&ctx, was_classic, false);
+	if (build_landings(&ctx))
+		goto out_free_hdr;
 	build_plt(&ctx);
 
 	/* Extra pass to validate JITed code. */
@@ -2514,8 +2590,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	prog->jited_len = prog_size - cfi_get_offset();
 
 	if (!prog->is_func || extra_pass) {
-		int i;
-
 		/* offset[prog->len] is the size of program */
 		for (i = 0; i <= prog->len; i++)
 			ctx.offset[i] *= AARCH64_INSN_SIZE;
@@ -2533,6 +2607,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 			prog->aux->priv_stack_ptr = NULL;
 		}
 		kvfree(ctx.offset);
+		kvfree(ctx.landing_ex);
 out_priv_stack:
 		kfree(jit_data);
 		prog->aux->jit_data = NULL;
-- 
2.53.0

