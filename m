Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA1A2F616A
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 02:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782959033; cv=none; b=eKGGYrA22muFwz542XS2e6XLNiqByOiQZVZQtJXU5XI34d8TuqTGeldyYrXXyjklYF+nJyDp3RK0scCdhhJ3BQQIgqpSmzwKgnM+CcPKfGC6EEUz/a/MUHoH8ECYCxpYpqB06pomGyxYbQlHnC4kgYyZ3rOzCJBOy9XFuUoaifQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782959033; c=relaxed/simple;
	bh=rdGGYd8HBSBm0PQiimn8quc308MI7ZlN91GbLHF+0dE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kyIRe8okL3VbV5MYT8ZAn3IVP9y3PfqqVlxeyXRgBWLNeECpS4GCvt/+oYHuwFEWfML+jNasyZSKZg6Vq3Htru0eaj7l9c7bLV7J8XfHZKlQ4gv1mGLzwGZgAVI7re/gnyDwY5qaHQnPyzwCGGLH1qH1ztUct5fuM3lD5w20Hms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DyfkwzFU; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DyfkwzFU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782959030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fdl9DmD6RXS5x2tUOcc0lHixqZnNyzGXPIpAV6z7p7E=;
	b=DyfkwzFUCzdrP8wIaL5GwwRm0PPIB9hdn3rNhRHhuVx21kEfPtKkDCyKwKR8EXF1koP2+B
	aFi6s/+NJlnEF1GBWsUPOlr/ho3oz5ziXBZgN7WKzhMCEh9EPuq6e56qZuF0pviX9gSsjy
	1tYUqEItjJP4h/zjKFvTROwb28DFHFI=
From: George Guo <dongtai.guo@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	George Guo <guodongtai@kylinos.cn>,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 01/11] LoongArch: BPF: Fix tail call count pointer offset for arena programs
Date: Thu,  2 Jul 2026 10:23:12 +0800
Message-Id: <20260702022322.51033-2-dongtai.guo@linux.dev>
In-Reply-To: <20260702022322.51033-1-dongtai.guo@linux.dev>
References: <20260702022322.51033-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

The tail call count (TCC) and its pointer occupy the two deepest slots of
the callee-saved area set up by build_prologue(). An arena program reserves
one extra word for REG_ARENA (arena_vm_start) right above them:

    ra fp s0 s1 s2 s3 s4 s5      <- 8 words
    [ REG_ARENA ]                <- only if ctx->arena_vm_start
    tail_call_cnt
    tail_call_cnt_ptr            <- loaded on tail call / bpf2bpf call

BPF_TAIL_CALL_CNT_PTR_STACK_OFF() hardcodes the pointer at
round_up(stack, 16) - 80, which is only correct when REG_ARENA is absent.
For an arena program the extra word shifts every slot below it down by 8
bytes, so the macro resolves to the tail_call_cnt slot (the counter value)
instead of tail_call_cnt_ptr. The JIT then loads the counter value and
dereferences it as the TCC pointer, corrupting memory or panicking the
kernel whenever an arena program performs a tail call or a bpf2bpf call.

Replace the macro with a helper that accounts for the REG_ARENA slot,
mirroring the reservation logic in build_prologue().

This is the same fix already posted separately for the bpf tree; it is
included here, as patch 1/11, only so the rest of this series applies
and builds cleanly on top of it. It can be dropped from this series
once it lands via the bpf tree.

  https://lore.kernel.org/all/20260629085511.359546-1-dongtai.guo@linux.dev

Fixes: ef54c517a937 ("LoongArch: BPF: Implement PROBE_MEM32 pseudo instructions")
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/net/bpf_jit.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index ad7e28375aa9..5e34e9e3f508 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -25,7 +25,23 @@
 
 #define REG_TCC		LOONGARCH_GPR_A6
 #define REG_ARENA	LOONGARCH_GPR_S6 /* For storing arena_vm_start */
-#define BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack) (round_up(stack, 16) - 80)
+
+static int tail_call_cnt_ptr_stack_off(struct jit_ctx *ctx)
+{
+	/* Ten words are pushed below the BPF stack: ra, fp, s0-s5, and the
+	 * tail call count plus its pointer, which occupy the two deepest
+	 * slots of the callee-saved area.
+	 */
+	int offset = sizeof(long) * 10;
+
+	/* An arena program reserves one extra word above them (REG_ARENA),
+	 * which pushes the tail call count pointer down by one slot.
+	 */
+	if (ctx->arena_vm_start)
+		offset += sizeof(long);
+
+	return round_up(ctx->stack_size, 16) - offset;
+}
 
 static const int regmap[] = {
 	/* return value from in-kernel function, and exit value for eBPF program */
@@ -291,7 +307,7 @@ bool bpf_jit_supports_far_kfunc_call(void)
 static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 {
 	int off, tc_ninsn = 0;
-	int tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size);
+	int tcc_ptr_off = tail_call_cnt_ptr_stack_off(ctx);
 	u8 a1 = LOONGARCH_GPR_A1;
 	u8 a2 = LOONGARCH_GPR_A2;
 	u8 t1 = LOONGARCH_GPR_T1;
@@ -1181,7 +1197,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			return ret;
 
 		if (insn->src_reg == BPF_PSEUDO_CALL) {
-			tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size);
+			tcc_ptr_off = tail_call_cnt_ptr_stack_off(ctx);
 			emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, tcc_ptr_off);
 		}
 
-- 
2.25.1

