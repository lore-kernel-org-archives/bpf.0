Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795664475;
	b=IZ7L7Q6nYK4R2L/b2kVDvYROV9lbQHoT+IEFZz8QZO6KtKbgakVgxwERbp8B7El9MrYI
	 2DAZ3/RMXtUQq2zJAM/VqCLiJKsnlBW6MADfTtW2NYkW/VtnvJrdBpl3u+M0WSUxG6IFz
	 9XbYHkjYlZ44CXFQ9vbS2xGxtT410bMYgeTOokT0PQKupTOzf+OYzxhL4gL2HvDPIiMEV
	 zUkA0WtgadC0HEAMQ7laiojtNJEwni+QDgLPNlYQ9fMfXBOvgdueRG8Tp2kEWsrmn28Vv
	 4eYcyzHPPChmcsTGWMlMIl7B5EwUNDinhl8pYo6Ojnjny4UAxekU9Gz5tg55eY5wOtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795664475;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bZUI4zFvKI5feENhD2kLu0gGg8DBuciBEsqLP3fBRFU=;
	b=Awhoy8ooavI4xBr3vPTw3hem9rRQgW0UFDyDVGXeJRGPvFUJEE6Cu1WJBqnh6PEyLwgM
	 EJablGBJgejSleW8qx672TGRuJNKtN7HsL8oLyXbiMouFeam8n1Lr8xn2yXhceT7T3Zi5
	 UsktKAHYPMyxc90Ale5AbhqKlZySth9BsEv76sR2W2re+SyvmV7Se8IB5vCz3sBBkRpn/
	 na7Zbr9FitiHj/7qc+yV2heWnx8vSoIRqbpNVFh1JqZvaoH+U/YBR9utPeC2YoCDzDAdc
	 eMiRArPvqS32lwLg+cjFIiBiF2jeb735umz6/2N8gatLbfHUaf67yf+bcCO8wrrvVDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hVtIMfrV;
	arc=none smtp.remote-ip=91.218.175.41
Received: from mta0.migadu.com (out-41.mta0.migadu.com [91.218.175.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D51606A69A
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 03:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4D51606A69A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hVtIMfrV
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jVwd+DHedpkNv/GZhq681Sv6TG6fh3tLpPaV5jWETFw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795664472; v=1; x=1796269272;
 b=hVtIMfrVvWAefucgujOzEp+d1PZx+semI3pTqvbfaIOE22FPMSI8ThNOt5YlU2VwtqNZjd7k
 mVyvt402hnLoF6yNXZECqM3lsDJk34ifXyFEGaRybD3SSwLGcjFxuilRItyeG+gMOVCD61Chgcj
 rzYKeOmuu/CWdwyISbMgTESg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e1608bf855ead876;
	Thu, 26 Nov 2026 03:41:12 +0000
X-Mizu-Trace-ID: e1608bf855ead876
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn
Cc: hengqi.chen@gmail.com,
	guodongtai@kylinos.cn,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] LoongArch: BPF: Add support for arena atomics
Date: Thu, 26 Nov 2026 12:40:47 +0900
Message-ID: <20261126034048.7370-6-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126034048.7370-1-dongtai.guo@linux.dev>
References: <20261126034048.7370-1-dongtai.guo@linux.dev>
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

From: George Guo <guodongtai@kylinos.cn>

In order to support the atomic instructions on arena pointers
(BPF_PROBE_ATOMIC), add the arena base held in REG_ARENA to the address
and add an exception table entry for the memory access instruction of
read-modify-write, fetch, xchg, cmpxchg, load-acquire and store-release.

If the memory access faults, clear the register that the instruction
loads into, as the verifier expects: dst_reg for load-acquire, r0 for
cmpxchg and src_reg for the fetch instructions. The zero-extension of
the 32-bit fetch instructions is emitted after the memory access, so the
cleared register remains zero.

The ll/sc loop of cmpxchg is not suitable for arena: both ll and sc can
fault if another CPU frees the page between them, but the verifier only
reserves one exception table entry for each instruction. So emit a
single amcas_db.{w/d} instruction for cmpxchg on arena, and make
bpf_jit_supports_insn() return cpu_has_lamcas for it, just like RISC-V
does with Zacas.

This is similar to commit fb7cefabae81 ("riscv, bpf: Add support arena
atomics for RV64") and commit 1519f488e8ce ("bpf, riscv: Clear fetch
destination on faulting arena atomic").

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/include/asm/inst.h |   4 +
 arch/loongarch/net/bpf_jit.c      | 137 +++++++++++++++++++++++++++---
 2 files changed, 130 insertions(+), 11 deletions(-)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index e061f966f7d1..1fc99b7d70be 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -198,6 +198,8 @@ enum reg3_op {
 	fstxs_op	= 0x7070,
 	fstxd_op	= 0x7078,
 	scq_op		= 0x70ae,
+	amcasdbw_op	= 0x70b6,
+	amcasdbd_op	= 0x70b7,
 	amswapb_op	= 0x70b8,
 	amswaph_op	= 0x70b9,
 	amaddb_op	= 0x70ba,
@@ -817,6 +819,8 @@ DEF_EMIT_REG3_FORMAT(amorw, amorw_op)
 DEF_EMIT_REG3_FORMAT(amord, amord_op)
 DEF_EMIT_REG3_FORMAT(amxorw, amxorw_op)
 DEF_EMIT_REG3_FORMAT(amxord, amxord_op)
+DEF_EMIT_REG3_FORMAT(amcasdbw, amcasdbw_op)
+DEF_EMIT_REG3_FORMAT(amcasdbd, amcasdbd_op)
 DEF_EMIT_REG3_FORMAT(amswapb, amswapb_op)
 DEF_EMIT_REG3_FORMAT(amswaph, amswaph_op)
 DEF_EMIT_REG3_FORMAT(amswapw, amswapw_op)
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 03c88cd9c96a..ebe603131396 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -418,6 +418,13 @@ static void emit_store_stack_imm64(struct jit_ctx *ctx, int reg, int stack_off,
 	emit_insn(ctx, std, reg, LOONGARCH_GPR_FP, stack_off);
 }
 
+#define BPF_FIXUP_REG_MASK	GENMASK(31, 27)
+#define BPF_FIXUP_OFFSET_MASK	GENMASK(26, 0)
+#define REG_DONT_CLEAR_MARKER	0
+
+static int add_exception_handler(const struct bpf_insn *insn,
+				 struct jit_ctx *ctx, int dst_reg);
+
 static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 {
 	const u8 t1 = LOONGARCH_GPR_T1;
@@ -429,9 +436,15 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	const s16 off = insn->off;
 	const s32 imm = insn->imm;
 	const bool isdw = BPF_SIZE(insn->code) == BPF_DW;
+	const bool arena = BPF_MODE(insn->code) == BPF_PROBE_ATOMIC;
+	bool zext = false;
+	u8 zext_reg = src;
+	int ret;
 
 	move_imm(ctx, t1, off);
 	emit_insn(ctx, addd, t1, dst, t1);
+	if (arena)
+		emit_insn(ctx, addd, t1, t1, REG_ARENA);
 	move_reg(ctx, t3, src);
 
 	switch (imm) {
@@ -502,15 +515,14 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			emit_insn(ctx, amadddbd, src, t1, t3);
 			break;
 		}
-		if (!isdw)
-			emit_insn(ctx, bstrpickd, src, src, 31, 0);
+		zext = !isdw;
 		break;
 	case BPF_AND | BPF_FETCH:
 		if (isdw) {
 			emit_insn(ctx, amanddbd, src, t1, t3);
 		} else {
 			emit_insn(ctx, amanddbw, src, t1, t3);
-			emit_insn(ctx, bstrpickd, src, src, 31, 0);
+			zext = true;
 		}
 		break;
 	case BPF_OR | BPF_FETCH:
@@ -518,7 +530,7 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			emit_insn(ctx, amordbd, src, t1, t3);
 		} else {
 			emit_insn(ctx, amordbw, src, t1, t3);
-			emit_insn(ctx, bstrpickd, src, src, 31, 0);
+			zext = true;
 		}
 		break;
 	case BPF_XOR | BPF_FETCH:
@@ -526,7 +538,7 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			emit_insn(ctx, amxordbd, src, t1, t3);
 		} else {
 			emit_insn(ctx, amxordbw, src, t1, t3);
-			emit_insn(ctx, bstrpickd, src, src, 31, 0);
+			zext = true;
 		}
 		break;
 	/* src = atomic_xchg(dst + off, src); */
@@ -553,11 +565,30 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			emit_insn(ctx, amswapdbd, src, t1, t3);
 			break;
 		}
-		if (!isdw)
-			emit_insn(ctx, bstrpickd, src, src, 31, 0);
+		zext = !isdw;
 		break;
 	/* r0 = atomic_cmpxchg(dst + off, r0, src); */
 	case BPF_CMPXCHG:
+		if (arena) {
+			/*
+			 * Another CPU can free the arena page between the ll and
+			 * the sc of an ll/sc loop, so both can fault, but the
+			 * verifier reserves a single exception table entry per
+			 * instruction. Use amcas, which bpf_jit_supports_insn()
+			 * requires for cmpxchg on arena.
+			 */
+			if (!cpu_has_lamcas) {
+				pr_err_once("bpf-jit: amcas instruction is not supported\n");
+				return -EINVAL;
+			}
+			if (isdw)
+				emit_insn(ctx, amcasdbd, r0, t1, t3);
+			else
+				emit_insn(ctx, amcasdbw, r0, t1, t3);
+			zext = !isdw;
+			zext_reg = r0;
+			break;
+		}
 		move_reg(ctx, t2, r0);
 		if (isdw) {
 			emit_insn(ctx, lld, r0, t1, 0);
@@ -582,6 +613,24 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		return -EINVAL;
 	}
 
+	/*
+	 * On arena, the memory access is the last instruction emitted so far.
+	 * If it faults, clear the register it loads into, as the verifier
+	 * expects, and resume at the next instruction: zero-extending the
+	 * cleared register keeps it zero.
+	 */
+	if (arena) {
+		int load_reg = bpf_atomic_load_reg(insn);
+
+		ret = add_exception_handler(insn, ctx, load_reg < 0 ?
+					    REG_DONT_CLEAR_MARKER : regmap[load_reg]);
+		if (ret)
+			return ret;
+	}
+
+	if (zext)
+		emit_insn(ctx, bstrpickd, zext_reg, zext_reg, 31, 0);
+
 	return 0;
 }
 
@@ -592,10 +641,37 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	const u8 dst = regmap[insn->dst_reg];
 	const s16 off = insn->off;
 	const s32 imm = insn->imm;
+	const bool arena = BPF_MODE(insn->code) == BPF_PROBE_ATOMIC;
+	int ret;
 
 	switch (imm) {
 	/* dst_reg = load_acquire(src_reg + off16) */
 	case BPF_LOAD_ACQ:
+		if (arena) {
+			/* t1 = src + off + arena_vm_start; load from [t1]. */
+			move_imm(ctx, t1, off);
+			emit_insn(ctx, addd, t1, src, t1);
+			emit_insn(ctx, addd, t1, t1, REG_ARENA);
+			switch (BPF_SIZE(insn->code)) {
+			case BPF_B:
+				emit_insn(ctx, ldbu, dst, t1, 0);
+				break;
+			case BPF_H:
+				emit_insn(ctx, ldhu, dst, t1, 0);
+				break;
+			case BPF_W:
+				emit_insn(ctx, ldwu, dst, t1, 0);
+				break;
+			case BPF_DW:
+				emit_insn(ctx, ldd, dst, t1, 0);
+				break;
+			}
+			ret = add_exception_handler(insn, ctx, dst);
+			if (ret)
+				return ret;
+			emit_insn(ctx, dbar, 0b10100);
+			break;
+		}
 		switch (BPF_SIZE(insn->code)) {
 		case BPF_B:
 			if (is_signed_imm12(off)) {
@@ -634,6 +710,31 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		break;
 	/* store_release(dst_reg + off16, src_reg) */
 	case BPF_STORE_REL:
+		if (arena) {
+			/* t1 = dst + off + arena_vm_start; store to [t1]. */
+			emit_insn(ctx, dbar, 0b10010);
+			move_imm(ctx, t1, off);
+			emit_insn(ctx, addd, t1, dst, t1);
+			emit_insn(ctx, addd, t1, t1, REG_ARENA);
+			switch (BPF_SIZE(insn->code)) {
+			case BPF_B:
+				emit_insn(ctx, stb, src, t1, 0);
+				break;
+			case BPF_H:
+				emit_insn(ctx, sth, src, t1, 0);
+				break;
+			case BPF_W:
+				emit_insn(ctx, stw, src, t1, 0);
+				break;
+			case BPF_DW:
+				emit_insn(ctx, std, src, t1, 0);
+				break;
+			}
+			ret = add_exception_handler(insn, ctx, REG_DONT_CLEAR_MARKER);
+			if (ret)
+				return ret;
+			break;
+		}
 		emit_insn(ctx, dbar, 0b10010);
 		switch (BPF_SIZE(insn->code)) {
 		case BPF_B:
@@ -678,9 +779,6 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	return 0;
 }
 
-#define BPF_FIXUP_REG_MASK	GENMASK(31, 27)
-#define BPF_FIXUP_OFFSET_MASK	GENMASK(26, 0)
-#define REG_DONT_CLEAR_MARKER	0
 
 bool ex_handler_bpf(const struct exception_table_entry *ex,
 		    struct pt_regs *regs)
@@ -710,7 +808,8 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	if (BPF_MODE(insn->code) != BPF_PROBE_MEM &&
 	    BPF_MODE(insn->code) != BPF_PROBE_MEMSX &&
 	    BPF_MODE(insn->code) != BPF_PROBE_MEM32 &&
-	    BPF_MODE(insn->code) != BPF_PROBE_MEM32SX)
+	    BPF_MODE(insn->code) != BPF_PROBE_MEM32SX &&
+	    BPF_MODE(insn->code) != BPF_PROBE_ATOMIC)
 		return 0;
 
 	if (WARN_ON_ONCE(ctx->num_exentries >= ctx->prog->aux->num_exentries))
@@ -1591,6 +1690,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	case BPF_STX | BPF_ATOMIC | BPF_H:
 	case BPF_STX | BPF_ATOMIC | BPF_W:
 	case BPF_STX | BPF_ATOMIC | BPF_DW:
+	case BPF_STX | BPF_PROBE_ATOMIC | BPF_B:
+	case BPF_STX | BPF_PROBE_ATOMIC | BPF_H:
+	case BPF_STX | BPF_PROBE_ATOMIC | BPF_W:
+	case BPF_STX | BPF_PROBE_ATOMIC | BPF_DW:
 		if (!bpf_atomic_is_load_store(insn))
 			ret = emit_atomic_rmw(insn, ctx);
 		else
@@ -2685,6 +2788,18 @@ bool bpf_jit_supports_arena(void)
 
 bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 {
+	if (!in_arena)
+		return true;
+
+	switch (insn->code) {
+	case BPF_STX | BPF_ATOMIC | BPF_W:
+	case BPF_STX | BPF_ATOMIC | BPF_DW:
+		/* cmpxchg on arena is emitted as amcas, see emit_atomic_rmw() */
+		if (insn->imm == BPF_CMPXCHG)
+			return cpu_has_lamcas;
+		break;
+	}
+
 	return true;
 }
 
-- 
2.53.0

