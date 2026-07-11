Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2545238D406;
	Sat, 11 Jul 2026 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783765025; cv=none; b=p8puZEYS7Uq0aMKJ6AOdcaavtoy9YcmR3N4pFWVxSFq3FQ4ovj1r+iUldfO6yVerleqEuixGjYneTCG9EpQ5r78lU1Kyr+/WirEEjvjxs1dAln0/1rRLNWlUtf3WaZnsBXw4HFNtxs2gq/VPa7Z8tx3+Duvqphb+MJltzkDDZGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783765025; c=relaxed/simple;
	bh=lTDkPTcUIEbRNrBCV9mOrz5QnwidJtu+vfZPP/ROslg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5n1YLxLlh9Otkvk0uIuGcXYJ8cs5/jldAHBMbVyNNVGeUbh5afAAWCpvjsSvRogxczNAlD7Cso41RduTmOPKmJD3WfW8tfW08ubvjeL0FYZtcUleoDd7J3kFXrwo5c0465eAKH9ukfuL+Srf1P4KUkjhp+NugOWEehhRU1KO1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxZegcGFJqF5kCAA--.9402S3;
	Sat, 11 Jul 2026 18:17:00 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxb8cZGFJqZ3EJAA--.35766S4;
	Sat, 11 Jul 2026 18:17:00 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 2/2] LoongArch: BPF: Eliminate zero/sign extensions for 32-bit operations
Date: Sat, 11 Jul 2026 18:16:56 +0800
Message-ID: <20260711101656.7415-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260711101656.7415-1-yangtiezhu@loongson.cn>
References: <20260711101656.7415-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxb8cZGFJqZ3EJAA--.35766S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9fXoWfKr1kWFWkJFWUur47uFWDZFc_yoW5Ww1kCo
	WUtr40ga1rCr1fZ3y3Kr1Yyr1xZa1kZF4rJrnrA3sYkr95Zr90vrWagw4xuanYqrn0gFyU
	Kr17ta4jq3sxZw4Ul-sFpf9Il3svdjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYj7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAF
	wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8l38UUUUUU==

Eliminate frequent and redundant zero-extensions and sign-extensions
for 32-bit operations. This prevents potential functional bugs caused
by incorrect extension selections and reduces runtime overhead.

For explicit 32-bit zero-extensions (imm == 1), generate a `lu32id`
instruction to guarantee the zero-extended form when they cannot be
bypassed by the look-ahead logic.

For other 32-bit arithmetic, emit LoongArch native 32-bit instructions
which inherently perform hardware-level sign-extension.

For bitwise logical instructions, append `addiw dst, dst, 0` to enforce
the standard sign-extended form of the result.

For 32-bit signed conditional jumps, remove redundant register copies
and pre-jump `emit_sext_32` helpers to leverage native branching, as
operands are now natively sign-extended.

For 32-bit unsigned conditional jumps, use `bstrpickd` to clear the
upper 32 bits of the operands.

For JSET bit-testing, maintain `addiw t1, t1, 0` in the jmp32 path to
ensure correctness.

With this patch, deliver an optimal native execution stream and reduce
the overall JIT image size.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 357 +++++++++++++++++++----------------
 arch/loongarch/net/bpf_jit.h |  25 +--
 2 files changed, 198 insertions(+), 184 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index b8cef3ea5c6d..08a5903dd5a3 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -209,7 +209,7 @@ static void build_prologue(struct jit_ctx *ctx)
 	ctx->stack_size = stack_adjust;
 
 	if (ctx->arena_vm_start)
-		move_imm(ctx, REG_ARENA, ctx->arena_vm_start, false);
+		move_imm(ctx, REG_ARENA, ctx->arena_vm_start);
 }
 
 static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
@@ -311,7 +311,6 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 	 *	 goto out;
 	 */
 	tc_ninsn = insn ? ctx->offset[insn+1] - ctx->offset[insn] : ctx->offset[0];
-	emit_zext_32(ctx, a2, true);
 
 	off = offsetof(struct bpf_array, map.max_entries);
 	emit_insn(ctx, ldwu, t1, a1, off);
@@ -361,7 +360,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 
 static void emit_store_stack_imm64(struct jit_ctx *ctx, int reg, int stack_off, u64 imm64)
 {
-	move_imm(ctx, reg, imm64, false);
+	move_imm(ctx, reg, imm64);
 	emit_insn(ctx, std, reg, LOONGARCH_GPR_FP, stack_off);
 }
 
@@ -377,7 +376,7 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	const s32 imm = insn->imm;
 	const bool isdw = BPF_SIZE(insn->code) == BPF_DW;
 
-	move_imm(ctx, t1, off, false);
+	move_imm(ctx, t1, off);
 	emit_insn(ctx, addd, t1, dst, t1);
 	move_reg(ctx, t3, src);
 
@@ -434,7 +433,6 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 				return -EINVAL;
 			}
 			emit_insn(ctx, amaddb, src, t1, t3);
-			emit_zext_32(ctx, src, true);
 			break;
 		case BPF_H:
 			if (!cpu_has_lam_bh) {
@@ -442,11 +440,9 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 				return -EINVAL;
 			}
 			emit_insn(ctx, amaddh, src, t1, t3);
-			emit_zext_32(ctx, src, true);
 			break;
 		case BPF_W:
 			emit_insn(ctx, amaddw, src, t1, t3);
-			emit_zext_32(ctx, src, true);
 			break;
 		case BPF_DW:
 			emit_insn(ctx, amaddd, src, t1, t3);
@@ -454,28 +450,22 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		}
 		break;
 	case BPF_AND | BPF_FETCH:
-		if (isdw) {
+		if (isdw)
 			emit_insn(ctx, amandd, src, t1, t3);
-		} else {
+		else
 			emit_insn(ctx, amandw, src, t1, t3);
-			emit_zext_32(ctx, src, true);
-		}
 		break;
 	case BPF_OR | BPF_FETCH:
-		if (isdw) {
+		if (isdw)
 			emit_insn(ctx, amord, src, t1, t3);
-		} else {
+		else
 			emit_insn(ctx, amorw, src, t1, t3);
-			emit_zext_32(ctx, src, true);
-		}
 		break;
 	case BPF_XOR | BPF_FETCH:
-		if (isdw) {
+		if (isdw)
 			emit_insn(ctx, amxord, src, t1, t3);
-		} else {
+		else
 			emit_insn(ctx, amxorw, src, t1, t3);
-			emit_zext_32(ctx, src, true);
-		}
 		break;
 	/* src = atomic_xchg(dst + off, src); */
 	case BPF_XCHG:
@@ -486,7 +476,6 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 				return -EINVAL;
 			}
 			emit_insn(ctx, amswapb, src, t1, t3);
-			emit_zext_32(ctx, src, true);
 			break;
 		case BPF_H:
 			if (!cpu_has_lam_bh) {
@@ -494,11 +483,9 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 				return -EINVAL;
 			}
 			emit_insn(ctx, amswaph, src, t1, t3);
-			emit_zext_32(ctx, src, true);
 			break;
 		case BPF_W:
 			emit_insn(ctx, amswapw, src, t1, t3);
-			emit_zext_32(ctx, src, true);
 			break;
 		case BPF_DW:
 			emit_insn(ctx, amswapd, src, t1, t3);
@@ -516,13 +503,10 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			emit_insn(ctx, beq, t3, LOONGARCH_GPR_ZERO, -4);
 		} else {
 			emit_insn(ctx, llw, r0, t1, 0);
-			emit_zext_32(ctx, t2, true);
-			emit_zext_32(ctx, r0, true);
 			emit_insn(ctx, bne, t2, r0, 4);
 			move_reg(ctx, t3, src);
 			emit_insn(ctx, scw, t3, t1, 0);
 			emit_insn(ctx, beq, t3, LOONGARCH_GPR_ZERO, -6);
-			emit_zext_32(ctx, r0, true);
 		}
 		break;
 	default:
@@ -549,7 +533,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, ldbu, dst, src, off);
 			} else {
-				move_imm(ctx, t1, off, false);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, ldxbu, dst, src, t1);
 			}
 			break;
@@ -557,7 +541,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, ldhu, dst, src, off);
 			} else {
-				move_imm(ctx, t1, off, false);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, ldxhu, dst, src, t1);
 			}
 			break;
@@ -565,7 +549,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, ldwu, dst, src, off);
 			} else {
-				move_imm(ctx, t1, off, false);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, ldxwu, dst, src, t1);
 			}
 			break;
@@ -573,7 +557,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, ldd, dst, src, off);
 			} else {
-				move_imm(ctx, t1, off, false);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, ldxd, dst, src, t1);
 			}
 			break;
@@ -596,7 +580,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, stb, src, dst, off);
 			} else {
-				move_imm(ctx, t1, off, false);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, stxb, src, dst, t1);
 			}
 			break;
@@ -604,7 +588,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, sth, src, dst, off);
 			} else {
-				move_imm(ctx, t1, off, false);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, stxh, src, dst, t1);
 			}
 			break;
@@ -612,7 +596,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, stw, src, dst, off);
 			} else {
-				move_imm(ctx, t1, off, false);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, stxw, src, dst, t1);
 			}
 			break;
@@ -620,7 +604,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, std, src, dst, off);
 			} else {
-				move_imm(ctx, t1, off, false);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, stxd, src, dst, t1);
 			}
 			break;
@@ -741,28 +725,32 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	switch (code) {
 	/* dst = src */
 	case BPF_ALU | BPF_MOV | BPF_X:
+		if (imm == 1) {
+			emit_insn(ctx, lu32id, reg, 0);
+			break;
+		}
+
+		emit_insn(ctx, addw, dst, src, LOONGARCH_GPR_ZERO);
+		break;
 	case BPF_ALU64 | BPF_MOV | BPF_X:
 		if (insn_is_cast_user(insn)) {
 			move_reg(ctx, t1, src);
-			emit_zext_32(ctx, t1, true);
-			move_imm(ctx, dst, (ctx->user_vm_start >> 32) << 32, false);
+			move_imm(ctx, dst, (ctx->user_vm_start >> 32) << 32);
 			emit_insn(ctx, beq, t1, LOONGARCH_GPR_ZERO, 1);
 			emit_insn(ctx, or, t1, dst, t1);
 			move_reg(ctx, dst, t1);
 			break;
 		}
+
 		switch (off) {
 		case 0:
 			move_reg(ctx, dst, src);
-			emit_zext_32(ctx, dst, is32);
 			break;
 		case 8:
 			emit_insn(ctx, extwb, dst, src);
-			emit_zext_32(ctx, dst, is32);
 			break;
 		case 16:
 			emit_insn(ctx, extwh, dst, src);
-			emit_zext_32(ctx, dst, is32);
 			break;
 		case 32:
 			emit_insn(ctx, addw, dst, src, LOONGARCH_GPR_ZERO);
@@ -773,202 +761,234 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	/* dst = imm */
 	case BPF_ALU | BPF_MOV | BPF_K:
 	case BPF_ALU64 | BPF_MOV | BPF_K:
-		move_imm(ctx, dst, imm, is32);
+		move_imm(ctx, dst, imm);
 		break;
 
 	/* dst = dst + src */
 	case BPF_ALU | BPF_ADD | BPF_X:
+		emit_insn(ctx, addw, dst, dst, src);
+		break;
 	case BPF_ALU64 | BPF_ADD | BPF_X:
 		emit_insn(ctx, addd, dst, dst, src);
-		emit_zext_32(ctx, dst, is32);
 		break;
 
 	/* dst = dst + imm */
 	case BPF_ALU | BPF_ADD | BPF_K:
+		if (is_signed_imm12(imm)) {
+			emit_insn(ctx, addiw, dst, dst, imm);
+		} else {
+			move_imm(ctx, t1, imm);
+			emit_insn(ctx, addw, dst, dst, t1);
+		}
+		break;
 	case BPF_ALU64 | BPF_ADD | BPF_K:
 		if (is_signed_imm12(imm)) {
 			emit_insn(ctx, addid, dst, dst, imm);
 		} else {
-			move_imm(ctx, t1, imm, is32);
+			move_imm(ctx, t1, imm);
 			emit_insn(ctx, addd, dst, dst, t1);
 		}
-		emit_zext_32(ctx, dst, is32);
 		break;
 
 	/* dst = dst - src */
 	case BPF_ALU | BPF_SUB | BPF_X:
+		emit_insn(ctx, subw, dst, dst, src);
+		break;
 	case BPF_ALU64 | BPF_SUB | BPF_X:
 		emit_insn(ctx, subd, dst, dst, src);
-		emit_zext_32(ctx, dst, is32);
 		break;
 
 	/* dst = dst - imm */
 	case BPF_ALU | BPF_SUB | BPF_K:
+		if (is_signed_imm12(-imm)) {
+			emit_insn(ctx, addiw, dst, dst, -imm);
+		} else {
+			move_imm(ctx, t1, imm);
+			emit_insn(ctx, subw, dst, dst, t1);
+		}
+		break;
 	case BPF_ALU64 | BPF_SUB | BPF_K:
 		if (is_signed_imm12(-imm)) {
 			emit_insn(ctx, addid, dst, dst, -imm);
 		} else {
-			move_imm(ctx, t1, imm, is32);
+			move_imm(ctx, t1, imm);
 			emit_insn(ctx, subd, dst, dst, t1);
 		}
-		emit_zext_32(ctx, dst, is32);
 		break;
 
 	/* dst = dst * src */
 	case BPF_ALU | BPF_MUL | BPF_X:
+		emit_insn(ctx, mulw, dst, dst, src);
+		break;
 	case BPF_ALU64 | BPF_MUL | BPF_X:
 		emit_insn(ctx, muld, dst, dst, src);
-		emit_zext_32(ctx, dst, is32);
 		break;
 
 	/* dst = dst * imm */
 	case BPF_ALU | BPF_MUL | BPF_K:
+		move_imm(ctx, t1, imm);
+		emit_insn(ctx, mulw, dst, dst, t1);
+		break;
 	case BPF_ALU64 | BPF_MUL | BPF_K:
-		move_imm(ctx, t1, imm, is32);
+		move_imm(ctx, t1, imm);
 		emit_insn(ctx, muld, dst, dst, t1);
-		emit_zext_32(ctx, dst, is32);
 		break;
 
 	/* dst = dst / src */
 	case BPF_ALU | BPF_DIV | BPF_X:
+		if (!off)
+			emit_insn(ctx, divwu, dst, dst, src);
+		else
+			emit_insn(ctx, divw, dst, dst, src);
+		break;
 	case BPF_ALU64 | BPF_DIV | BPF_X:
-		if (!off) {
-			emit_zext_32(ctx, dst, is32);
-			move_reg(ctx, t1, src);
-			emit_zext_32(ctx, t1, is32);
-			emit_insn(ctx, divdu, dst, dst, t1);
-			emit_zext_32(ctx, dst, is32);
-		} else {
-			emit_sext_32(ctx, dst, is32);
-			move_reg(ctx, t1, src);
-			emit_sext_32(ctx, t1, is32);
-			emit_insn(ctx, divd, dst, dst, t1);
-			emit_sext_32(ctx, dst, is32);
-		}
+		if (!off)
+			emit_insn(ctx, divdu, dst, dst, src);
+		else
+			emit_insn(ctx, divd, dst, dst, src);
 		break;
 
 	/* dst = dst / imm */
 	case BPF_ALU | BPF_DIV | BPF_K:
+		move_imm(ctx, t1, imm);
+		if (!off)
+			emit_insn(ctx, divwu, dst, dst, t1);
+		else
+			emit_insn(ctx, divw, dst, dst, t1);
+		break;
 	case BPF_ALU64 | BPF_DIV | BPF_K:
-		if (!off) {
-			move_imm(ctx, t1, imm, is32);
-			emit_zext_32(ctx, dst, is32);
+		move_imm(ctx, t1, imm);
+		if (!off)
 			emit_insn(ctx, divdu, dst, dst, t1);
-			emit_zext_32(ctx, dst, is32);
-		} else {
-			move_imm(ctx, t1, imm, false);
-			emit_sext_32(ctx, t1, is32);
-			emit_sext_32(ctx, dst, is32);
+		else
 			emit_insn(ctx, divd, dst, dst, t1);
-			emit_sext_32(ctx, dst, is32);
-		}
 		break;
 
 	/* dst = dst % src */
 	case BPF_ALU | BPF_MOD | BPF_X:
+		if (!off)
+			emit_insn(ctx, modwu, dst, dst, src);
+		else
+			emit_insn(ctx, modw, dst, dst, src);
+		break;
 	case BPF_ALU64 | BPF_MOD | BPF_X:
-		if (!off) {
-			emit_zext_32(ctx, dst, is32);
-			move_reg(ctx, t1, src);
-			emit_zext_32(ctx, t1, is32);
-			emit_insn(ctx, moddu, dst, dst, t1);
-			emit_zext_32(ctx, dst, is32);
-		} else {
-			emit_sext_32(ctx, dst, is32);
-			move_reg(ctx, t1, src);
-			emit_sext_32(ctx, t1, is32);
-			emit_insn(ctx, modd, dst, dst, t1);
-			emit_sext_32(ctx, dst, is32);
-		}
+		if (!off)
+			emit_insn(ctx, moddu, dst, dst, src);
+		else
+			emit_insn(ctx, modd, dst, dst, src);
 		break;
 
 	/* dst = dst % imm */
 	case BPF_ALU | BPF_MOD | BPF_K:
+		move_imm(ctx, t1, imm);
+		if (!off)
+			emit_insn(ctx, modwu, dst, dst, t1);
+		else
+			emit_insn(ctx, modw, dst, dst, t1);
+		break;
 	case BPF_ALU64 | BPF_MOD | BPF_K:
-		if (!off) {
-			move_imm(ctx, t1, imm, is32);
-			emit_zext_32(ctx, dst, is32);
+		move_imm(ctx, t1, imm);
+		if (!off)
 			emit_insn(ctx, moddu, dst, dst, t1);
-			emit_zext_32(ctx, dst, is32);
-		} else {
-			move_imm(ctx, t1, imm, false);
-			emit_sext_32(ctx, t1, is32);
-			emit_sext_32(ctx, dst, is32);
+		else
 			emit_insn(ctx, modd, dst, dst, t1);
-			emit_sext_32(ctx, dst, is32);
-		}
 		break;
 
 	/* dst = -dst */
 	case BPF_ALU | BPF_NEG:
+		emit_insn(ctx, subw, dst, LOONGARCH_GPR_ZERO, dst);
+		break;
 	case BPF_ALU64 | BPF_NEG:
 		emit_insn(ctx, subd, dst, LOONGARCH_GPR_ZERO, dst);
-		emit_zext_32(ctx, dst, is32);
 		break;
 
 	/* dst = dst & src */
 	case BPF_ALU | BPF_AND | BPF_X:
+		emit_insn(ctx, and, dst, dst, src);
+		emit_insn(ctx, addiw, dst, dst, 0);
+		break;
 	case BPF_ALU64 | BPF_AND | BPF_X:
 		emit_insn(ctx, and, dst, dst, src);
-		emit_zext_32(ctx, dst, is32);
 		break;
 
 	/* dst = dst & imm */
 	case BPF_ALU | BPF_AND | BPF_K:
+		if (is_unsigned_imm12(imm)) {
+			emit_insn(ctx, andi, dst, dst, imm);
+		} else {
+			move_imm(ctx, t1, imm);
+			emit_insn(ctx, and, dst, dst, t1);
+		}
+		emit_insn(ctx, addiw, dst, dst, 0);
 	case BPF_ALU64 | BPF_AND | BPF_K:
 		if (is_unsigned_imm12(imm)) {
 			emit_insn(ctx, andi, dst, dst, imm);
 		} else {
-			move_imm(ctx, t1, imm, is32);
+			move_imm(ctx, t1, imm);
 			emit_insn(ctx, and, dst, dst, t1);
 		}
-		emit_zext_32(ctx, dst, is32);
 		break;
 
 	/* dst = dst | src */
 	case BPF_ALU | BPF_OR | BPF_X:
+		emit_insn(ctx, or, dst, dst, src);
+		emit_insn(ctx, addiw, dst, dst, 0);
+		break;
 	case BPF_ALU64 | BPF_OR | BPF_X:
 		emit_insn(ctx, or, dst, dst, src);
-		emit_zext_32(ctx, dst, is32);
 		break;
 
 	/* dst = dst | imm */
 	case BPF_ALU | BPF_OR | BPF_K:
+		if (is_unsigned_imm12(imm)) {
+			emit_insn(ctx, ori, dst, dst, imm);
+		} else {
+			move_imm(ctx, t1, imm);
+			emit_insn(ctx, or, dst, dst, t1);
+		}
+		emit_insn(ctx, addiw, dst, dst, 0);
+		break;
 	case BPF_ALU64 | BPF_OR | BPF_K:
 		if (is_unsigned_imm12(imm)) {
 			emit_insn(ctx, ori, dst, dst, imm);
 		} else {
-			move_imm(ctx, t1, imm, is32);
+			move_imm(ctx, t1, imm);
 			emit_insn(ctx, or, dst, dst, t1);
 		}
-		emit_zext_32(ctx, dst, is32);
 		break;
 
 	/* dst = dst ^ src */
 	case BPF_ALU | BPF_XOR | BPF_X:
+		emit_insn(ctx, xor, dst, dst, src);
+		emit_insn(ctx, addiw, dst, dst, 0);
+		break;
 	case BPF_ALU64 | BPF_XOR | BPF_X:
 		emit_insn(ctx, xor, dst, dst, src);
-		emit_zext_32(ctx, dst, is32);
 		break;
 
 	/* dst = dst ^ imm */
 	case BPF_ALU | BPF_XOR | BPF_K:
+		if (is_unsigned_imm12(imm)) {
+			emit_insn(ctx, xori, dst, dst, imm);
+		} else {
+			move_imm(ctx, t1, imm);
+			emit_insn(ctx, xor, dst, dst, t1);
+		}
+		emit_insn(ctx, addiw, dst, dst, 0);
+		break;
 	case BPF_ALU64 | BPF_XOR | BPF_K:
 		if (is_unsigned_imm12(imm)) {
 			emit_insn(ctx, xori, dst, dst, imm);
 		} else {
-			move_imm(ctx, t1, imm, is32);
+			move_imm(ctx, t1, imm);
 			emit_insn(ctx, xor, dst, dst, t1);
 		}
-		emit_zext_32(ctx, dst, is32);
 		break;
 
 	/* dst = dst << src (logical) */
 	case BPF_ALU | BPF_LSH | BPF_X:
 		emit_insn(ctx, sllw, dst, dst, src);
-		emit_zext_32(ctx, dst, is32);
 		break;
-
 	case BPF_ALU64 | BPF_LSH | BPF_X:
 		emit_insn(ctx, slld, dst, dst, src);
 		break;
@@ -976,9 +996,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	/* dst = dst << imm (logical) */
 	case BPF_ALU | BPF_LSH | BPF_K:
 		emit_insn(ctx, slliw, dst, dst, imm);
-		emit_zext_32(ctx, dst, is32);
 		break;
-
 	case BPF_ALU64 | BPF_LSH | BPF_K:
 		emit_insn(ctx, sllid, dst, dst, imm);
 		break;
@@ -986,9 +1004,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	/* dst = dst >> src (logical) */
 	case BPF_ALU | BPF_RSH | BPF_X:
 		emit_insn(ctx, srlw, dst, dst, src);
-		emit_zext_32(ctx, dst, is32);
 		break;
-
 	case BPF_ALU64 | BPF_RSH | BPF_X:
 		emit_insn(ctx, srld, dst, dst, src);
 		break;
@@ -996,9 +1012,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	/* dst = dst >> imm (logical) */
 	case BPF_ALU | BPF_RSH | BPF_K:
 		emit_insn(ctx, srliw, dst, dst, imm);
-		emit_zext_32(ctx, dst, is32);
 		break;
-
 	case BPF_ALU64 | BPF_RSH | BPF_K:
 		emit_insn(ctx, srlid, dst, dst, imm);
 		break;
@@ -1006,9 +1020,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	/* dst = dst >> src (arithmetic) */
 	case BPF_ALU | BPF_ARSH | BPF_X:
 		emit_insn(ctx, sraw, dst, dst, src);
-		emit_zext_32(ctx, dst, is32);
 		break;
-
 	case BPF_ALU64 | BPF_ARSH | BPF_X:
 		emit_insn(ctx, srad, dst, dst, src);
 		break;
@@ -1016,9 +1028,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	/* dst = dst >> imm (arithmetic) */
 	case BPF_ALU | BPF_ARSH | BPF_K:
 		emit_insn(ctx, sraiw, dst, dst, imm);
-		emit_zext_32(ctx, dst, is32);
 		break;
-
 	case BPF_ALU64 | BPF_ARSH | BPF_K:
 		emit_insn(ctx, sraid, dst, dst, imm);
 		break;
@@ -1031,8 +1041,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			emit_insn(ctx, bstrpickd, dst, dst, 15, 0);
 			break;
 		case 32:
-			/* zero-extend 32 bits into 64 bits */
-			emit_zext_32(ctx, dst, is32);
+			emit_insn(ctx, addiw, dst, dst, 0);
 			break;
 		case 64:
 			/* do nothing */
@@ -1050,8 +1059,6 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			break;
 		case 32:
 			emit_insn(ctx, revb2w, dst, dst);
-			/* clear the upper 32 bits */
-			emit_zext_32(ctx, dst, true);
 			break;
 		case 64:
 			emit_insn(ctx, revbd, dst, dst);
@@ -1070,6 +1077,11 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	case BPF_JMP | BPF_JSGE | BPF_X:
 	case BPF_JMP | BPF_JSLT | BPF_X:
 	case BPF_JMP | BPF_JSLE | BPF_X:
+		jmp_offset = bpf2la_offset(i, off, ctx);
+		if (emit_cond_jmp(ctx, cond, dst, src, jmp_offset) < 0)
+			goto toofar;
+		break;
+
 	case BPF_JMP32 | BPF_JEQ | BPF_X:
 	case BPF_JMP32 | BPF_JNE | BPF_X:
 	case BPF_JMP32 | BPF_JGT | BPF_X:
@@ -1081,17 +1093,15 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	case BPF_JMP32 | BPF_JSLT | BPF_X:
 	case BPF_JMP32 | BPF_JSLE | BPF_X:
 		jmp_offset = bpf2la_offset(i, off, ctx);
-		move_reg(ctx, t1, dst);
-		move_reg(ctx, t2, src);
 		if (is_signed_bpf_cond(BPF_OP(code))) {
-			emit_sext_32(ctx, t1, is32);
-			emit_sext_32(ctx, t2, is32);
+			if (emit_cond_jmp(ctx, cond, dst, src, jmp_offset) < 0)
+				goto toofar;
 		} else {
-			emit_zext_32(ctx, t1, is32);
-			emit_zext_32(ctx, t2, is32);
+			emit_insn(ctx, bstrpickd, t1, dst, 31, 0);
+			emit_insn(ctx, bstrpickd, t2, src, 31, 0);
+			if (emit_cond_jmp(ctx, cond, t1, t2, jmp_offset) < 0)
+				goto toofar;
 		}
-		if (emit_cond_jmp(ctx, cond, t1, t2, jmp_offset) < 0)
-			goto toofar;
 		break;
 
 	/* PC += off if dst cond imm */
@@ -1105,6 +1115,17 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	case BPF_JMP | BPF_JSGE | BPF_K:
 	case BPF_JMP | BPF_JSLT | BPF_K:
 	case BPF_JMP | BPF_JSLE | BPF_K:
+		jmp_offset = bpf2la_offset(i, off, ctx);
+		if (imm) {
+			move_imm(ctx, t1, imm);
+			tm = t1;
+		} else {
+			tm = LOONGARCH_GPR_ZERO;
+		}
+
+		if (emit_cond_jmp(ctx, cond, dst, tm, jmp_offset) < 0)
+			goto toofar;
+		break;
 	case BPF_JMP32 | BPF_JEQ | BPF_K:
 	case BPF_JMP32 | BPF_JNE | BPF_K:
 	case BPF_JMP32 | BPF_JGT | BPF_K:
@@ -1117,41 +1138,55 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	case BPF_JMP32 | BPF_JSLE | BPF_K:
 		jmp_offset = bpf2la_offset(i, off, ctx);
 		if (imm) {
-			move_imm(ctx, t1, imm, false);
+			move_imm(ctx, t1, imm);
 			tm = t1;
 		} else {
-			/* If imm is 0, simply use zero register. */
 			tm = LOONGARCH_GPR_ZERO;
 		}
-		move_reg(ctx, t2, dst);
+
 		if (is_signed_bpf_cond(BPF_OP(code))) {
-			emit_sext_32(ctx, tm, is32);
-			emit_sext_32(ctx, t2, is32);
+			if (emit_cond_jmp(ctx, cond, dst, tm, jmp_offset) < 0)
+				goto toofar;
 		} else {
-			emit_zext_32(ctx, tm, is32);
-			emit_zext_32(ctx, t2, is32);
+			emit_insn(ctx, bstrpickd, t2, dst, 31, 0);
+			if (imm)
+				emit_insn(ctx, bstrpickd, t1, tm, 31, 0);
+			else
+				t1 = LOONGARCH_GPR_ZERO;
+
+			if (emit_cond_jmp(ctx, cond, t2, t1, jmp_offset) < 0)
+				goto toofar;
 		}
-		if (emit_cond_jmp(ctx, cond, t2, tm, jmp_offset) < 0)
-			goto toofar;
 		break;
 
 	/* PC += off if dst & src */
 	case BPF_JMP | BPF_JSET | BPF_X:
+		jmp_offset = bpf2la_offset(i, off, ctx);
+		emit_insn(ctx, and, t1, dst, src);
+		if (emit_cond_jmp(ctx, cond, t1, LOONGARCH_GPR_ZERO, jmp_offset) < 0)
+			goto toofar;
+		break;
 	case BPF_JMP32 | BPF_JSET | BPF_X:
 		jmp_offset = bpf2la_offset(i, off, ctx);
 		emit_insn(ctx, and, t1, dst, src);
-		emit_zext_32(ctx, t1, is32);
+		emit_insn(ctx, addiw, t1, t1, 0);
 		if (emit_cond_jmp(ctx, cond, t1, LOONGARCH_GPR_ZERO, jmp_offset) < 0)
 			goto toofar;
 		break;
 
 	/* PC += off if dst & imm */
 	case BPF_JMP | BPF_JSET | BPF_K:
+		jmp_offset = bpf2la_offset(i, off, ctx);
+		move_imm(ctx, t1, imm);
+		emit_insn(ctx, and, t1, dst, t1);
+		if (emit_cond_jmp(ctx, cond, t1, LOONGARCH_GPR_ZERO, jmp_offset) < 0)
+			goto toofar;
+		break;
 	case BPF_JMP32 | BPF_JSET | BPF_K:
 		jmp_offset = bpf2la_offset(i, off, ctx);
-		move_imm(ctx, t1, imm, is32);
+		move_imm(ctx, t1, imm);
 		emit_insn(ctx, and, t1, dst, t1);
-		emit_zext_32(ctx, t1, is32);
+		emit_insn(ctx, addiw, t1, t1, 0);
 		if (emit_cond_jmp(ctx, cond, t1, LOONGARCH_GPR_ZERO, jmp_offset) < 0)
 			goto toofar;
 		break;
@@ -1241,7 +1276,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		if (bpf_pseudo_func(insn))
 			move_addr(ctx, dst, imm64);
 		else
-			move_imm(ctx, dst, imm64, is32);
+			move_imm(ctx, dst, imm64);
 		return 1;
 	}
 
@@ -1282,7 +1317,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 				else
 					emit_insn(ctx, ldbu, dst, src, off);
 			} else {
-				move_imm(ctx, t1, off, is32);
+				move_imm(ctx, t1, off);
 				if (sign_extend)
 					emit_insn(ctx, ldxb, dst, src, t1);
 				else
@@ -1296,7 +1331,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 				else
 					emit_insn(ctx, ldhu, dst, src, off);
 			} else {
-				move_imm(ctx, t1, off, is32);
+				move_imm(ctx, t1, off);
 				if (sign_extend)
 					emit_insn(ctx, ldxh, dst, src, t1);
 				else
@@ -1310,7 +1345,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 				else
 					emit_insn(ctx, ldwu, dst, src, off);
 			} else {
-				move_imm(ctx, t1, off, is32);
+				move_imm(ctx, t1, off);
 				if (sign_extend)
 					emit_insn(ctx, ldxw, dst, src, t1);
 				else
@@ -1318,7 +1353,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			}
 			break;
 		case BPF_DW:
-			move_imm(ctx, t1, off, is32);
+			move_imm(ctx, t1, off);
 			emit_insn(ctx, ldxd, dst, src, t1);
 			break;
 		}
@@ -1353,42 +1388,42 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 
 		switch (BPF_SIZE(code)) {
 		case BPF_B:
-			move_imm(ctx, t1, imm, is32);
+			move_imm(ctx, t1, imm);
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, stb, t1, dst, off);
 			} else {
-				move_imm(ctx, t2, off, is32);
+				move_imm(ctx, t2, off);
 				emit_insn(ctx, stxb, t1, dst, t2);
 			}
 			break;
 		case BPF_H:
-			move_imm(ctx, t1, imm, is32);
+			move_imm(ctx, t1, imm);
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, sth, t1, dst, off);
 			} else {
-				move_imm(ctx, t2, off, is32);
+				move_imm(ctx, t2, off);
 				emit_insn(ctx, stxh, t1, dst, t2);
 			}
 			break;
 		case BPF_W:
-			move_imm(ctx, t1, imm, is32);
+			move_imm(ctx, t1, imm);
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, stw, t1, dst, off);
 			} else if (is_signed_imm14(off)) {
 				emit_insn(ctx, stptrw, t1, dst, off);
 			} else {
-				move_imm(ctx, t2, off, is32);
+				move_imm(ctx, t2, off);
 				emit_insn(ctx, stxw, t1, dst, t2);
 			}
 			break;
 		case BPF_DW:
-			move_imm(ctx, t1, imm, is32);
+			move_imm(ctx, t1, imm);
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, std, t1, dst, off);
 			} else if (is_signed_imm14(off)) {
 				emit_insn(ctx, stptrd, t1, dst, off);
 			} else {
-				move_imm(ctx, t2, off, is32);
+				move_imm(ctx, t2, off);
 				emit_insn(ctx, stxd, t1, dst, t2);
 			}
 			break;
@@ -1419,7 +1454,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, stb, src, dst, off);
 			} else {
-				move_imm(ctx, t1, off, is32);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, stxb, src, dst, t1);
 			}
 			break;
@@ -1427,7 +1462,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, sth, src, dst, off);
 			} else {
-				move_imm(ctx, t1, off, is32);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, stxh, src, dst, t1);
 			}
 			break;
@@ -1437,7 +1472,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			} else if (is_signed_imm14(off)) {
 				emit_insn(ctx, stptrw, src, dst, off);
 			} else {
-				move_imm(ctx, t1, off, is32);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, stxw, src, dst, t1);
 			}
 			break;
@@ -1447,7 +1482,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			} else if (is_signed_imm14(off)) {
 				emit_insn(ctx, stptrd, src, dst, off);
 			} else {
-				move_imm(ctx, t1, off, is32);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, stxd, src, dst, t1);
 			}
 			break;
@@ -1559,7 +1594,7 @@ static int emit_jump_and_link(struct jit_ctx *ctx, u8 rd, u64 target)
 		return -EFAULT;
 	}
 
-	move_imm(ctx, LOONGARCH_GPR_T1, target, false);
+	move_imm(ctx, LOONGARCH_GPR_T1, target);
 	emit_insn(ctx, jirl, rd, LOONGARCH_GPR_T1, 0);
 
 	return 0;
@@ -1733,7 +1768,7 @@ static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_node *n,
 		emit_insn(ctx, std, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_FP, -run_ctx_off + cookie_off);
 
 	/* arg1: prog */
-	move_imm(ctx, LOONGARCH_GPR_A0, (const s64)p, false);
+	move_imm(ctx, LOONGARCH_GPR_A0, (const s64)p);
 	/* arg2: &run_ctx */
 	emit_insn(ctx, addid, LOONGARCH_GPR_A1, LOONGARCH_GPR_FP, -run_ctx_off);
 	ret = emit_call(ctx, (const u64)bpf_trampoline_enter(p));
@@ -1754,7 +1789,7 @@ static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_node *n,
 	/* arg1: &args_off */
 	emit_insn(ctx, addid, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -args_off);
 	if (!p->jited)
-		move_imm(ctx, LOONGARCH_GPR_A1, (const s64)p->insnsi, false);
+		move_imm(ctx, LOONGARCH_GPR_A1, (const s64)p->insnsi);
 	ret = emit_call(ctx, (const u64)p->bpf_func);
 	if (ret)
 		return ret;
@@ -1771,7 +1806,7 @@ static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_node *n,
 	}
 
 	/* arg1: prog */
-	move_imm(ctx, LOONGARCH_GPR_A0, (const s64)p, false);
+	move_imm(ctx, LOONGARCH_GPR_A0, (const s64)p);
 	/* arg2: prog start time */
 	move_reg(ctx, LOONGARCH_GPR_A1, LOONGARCH_GPR_S1);
 	/* arg3: &run_ctx */
diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.h
index bb58c42c2f2a..2bd0dc5b911c 100644
--- a/arch/loongarch/net/bpf_jit.h
+++ b/arch/loongarch/net/bpf_jit.h
@@ -72,24 +72,6 @@ static inline int epilogue_offset(const struct jit_ctx *ctx)
 	return (to - from);
 }
 
-/* Zero-extend 32 bits into 64 bits */
-static inline void emit_zext_32(struct jit_ctx *ctx, enum loongarch_gpr reg, bool is32)
-{
-	if (!is32)
-		return;
-
-	emit_insn(ctx, lu32id, reg, 0);
-}
-
-/* Signed-extend 32 bits into 64 bits */
-static inline void emit_sext_32(struct jit_ctx *ctx, enum loongarch_gpr reg, bool is32)
-{
-	if (!is32)
-		return;
-
-	emit_insn(ctx, addiw, reg, reg, 0);
-}
-
 /* Emit proper extension according to ABI requirements.
  * Note that it requires a value of size `size` already resides in register `reg`.
  */
@@ -137,7 +119,7 @@ static inline void move_addr(struct jit_ctx *ctx, enum loongarch_gpr rd, u64 add
 	emit_insn(ctx, lu52id, rd, rd, imm_63_52);
 }
 
-static inline void move_imm(struct jit_ctx *ctx, enum loongarch_gpr rd, long imm, bool is32)
+static inline void move_imm(struct jit_ctx *ctx, enum loongarch_gpr rd, long imm)
 {
 	long imm_11_0, imm_31_12, imm_51_32, imm_63_52, imm_51_0, imm_51_31;
 
@@ -150,7 +132,7 @@ static inline void move_imm(struct jit_ctx *ctx, enum loongarch_gpr rd, long imm
 	/* addiw rd, $zero, imm_11_0 */
 	if (is_signed_imm12(imm)) {
 		emit_insn(ctx, addiw, rd, LOONGARCH_GPR_ZERO, imm);
-		goto zext;
+		return;
 	}
 
 	/* ori rd, $zero, imm_11_0 */
@@ -195,9 +177,6 @@ static inline void move_imm(struct jit_ctx *ctx, enum loongarch_gpr rd, long imm
 		if (!is_signed_imm52(imm))
 			emit_insn(ctx, lu52id, rd, rd, imm_63_52);
 	}
-
-zext:
-	emit_zext_32(ctx, rd, is32);
 }
 
 static inline void move_reg(struct jit_ctx *ctx, enum loongarch_gpr rd,
-- 
2.42.0

