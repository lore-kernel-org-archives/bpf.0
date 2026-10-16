Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE2443B489;
	Fri, 16 Oct 2026 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792138233; cv=none; b=OM+lAswtTzhoYvAOmu77CdpIh77AgUnYUH7EjSziLlMTpStE8+uRCBeHbixajnZbTAJZ52dB/IHZKujggFTdAKnOajc2Ui1m8vJH56sB8U7qrnHYkBwo1d/M07ay8ecy4X7KlavodBXG89q3XMzbtm0pHFxGlen5nbdXPsM25l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792138233; c=relaxed/simple;
	bh=CHwJpinNB7gxyDcTeJHdP7tOF7z4S3pU9j91ZSVVaR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOHJpBA1pi9cVCFnbGzkoaniLrE3iy/VWv8p6ZutSKlXNJAmwglt+JrFWo1TYXqwet8b85VZ4h8REnJTPo2H5VFBFe5aMByAHxs/zfyfqTvoYPDgyv+5b8j3N4i0Ufi5KyyPWIVh94Ina0hCI3l894iDdo5YDWrMS3OezFvkn0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxTNLy29FqM3AWAA--.64987S3;
	Fri, 16 Oct 2026 16:10:26 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJBx5czi29FqOAwtAA--.2269S4;
	Fri, 16 Oct 2026 16:10:25 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] LoongArch: BPF: Clean up and decouple is32 parameter from move_imm()
Date: Fri, 16 Oct 2026 16:10:05 +0800
Message-ID: <20261016081006.26069-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20261016081006.26069-1-yangtiezhu@loongson.cn>
References: <20261016081006.26069-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx5czi29FqOAwtAA--.2269S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9fXoWfGFykJr4DAF1kCF18GFy7CFX_yoW8XFWfGo
	W0qr4vga1fWF1fXay7Gr12yr17ua1kZF4rJrnrC3sYkrWrZr90vrWaqw48Za1Fqrn8KFyj
	kF1Iq3Wjyr9xZw43l-sFpf9Il3svdjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUY87kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUAVWUZwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
	0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
	aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8gAw7UUUUU==

The current move_imm() relies on the 'is32' parameter for ALU32 and JMP32,
forcing the helper to internally clear the upper 32 bits. However, this is
redundant for 64-bit immediate loads. Furthermore, it is even undesirable
for load/store signed address offset computations.

Clean up move_imm() by removing the 'is32' parameter which allows it to
focus on loading values, while moving the zero-extension logic outward to
the explicit callers. For 64-bit and load-store operations, just drop the
parameter.

This is preparation for later patch, no functional changes.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 102 +++++++++++++++++++----------------
 arch/loongarch/net/bpf_jit.h |   7 +--
 2 files changed, 58 insertions(+), 51 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index e78eb582c300..77cd96a6f84c 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -194,7 +194,7 @@ static void build_prologue(struct jit_ctx *ctx)
 	ctx->stack_size = stack_adjust;
 
 	if (ctx->arena_vm_start)
-		move_imm(ctx, REG_ARENA, ctx->arena_vm_start, false);
+		move_imm(ctx, REG_ARENA, ctx->arena_vm_start);
 }
 
 static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
@@ -339,7 +339,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 
 static void emit_store_stack_imm64(struct jit_ctx *ctx, int reg, int stack_off, u64 imm64)
 {
-	move_imm(ctx, reg, imm64, false);
+	move_imm(ctx, reg, imm64);
 	emit_insn(ctx, std, reg, LOONGARCH_GPR_FP, stack_off);
 }
 
@@ -355,7 +355,7 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	const s32 imm = insn->imm;
 	const bool isdw = BPF_SIZE(insn->code) == BPF_DW;
 
-	move_imm(ctx, t1, off, false);
+	move_imm(ctx, t1, off);
 	emit_insn(ctx, addd, t1, dst, t1);
 	move_reg(ctx, t3, src);
 
@@ -528,7 +528,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, ldbu, dst, src, off);
 			} else {
-				move_imm(ctx, t1, off, false);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, ldxbu, dst, src, t1);
 			}
 			break;
@@ -536,7 +536,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, ldhu, dst, src, off);
 			} else {
-				move_imm(ctx, t1, off, false);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, ldxhu, dst, src, t1);
 			}
 			break;
@@ -544,7 +544,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, ldwu, dst, src, off);
 			} else {
-				move_imm(ctx, t1, off, false);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, ldxwu, dst, src, t1);
 			}
 			break;
@@ -552,7 +552,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, ldd, dst, src, off);
 			} else {
-				move_imm(ctx, t1, off, false);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, ldxd, dst, src, t1);
 			}
 			break;
@@ -567,7 +567,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, stb, src, dst, off);
 			} else {
-				move_imm(ctx, t1, off, false);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, stxb, src, dst, t1);
 			}
 			break;
@@ -575,7 +575,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, sth, src, dst, off);
 			} else {
-				move_imm(ctx, t1, off, false);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, stxh, src, dst, t1);
 			}
 			break;
@@ -583,7 +583,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, stw, src, dst, off);
 			} else {
-				move_imm(ctx, t1, off, false);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, stxw, src, dst, t1);
 			}
 			break;
@@ -591,7 +591,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, std, src, dst, off);
 			} else {
-				move_imm(ctx, t1, off, false);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, stxd, src, dst, t1);
 			}
 			break;
@@ -716,7 +716,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		if (insn_is_cast_user(insn)) {
 			move_reg(ctx, t1, src);
 			emit_zext_32(ctx, t1, true);
-			move_imm(ctx, dst, (ctx->user_vm_start >> 32) << 32, false);
+			move_imm(ctx, dst, (ctx->user_vm_start >> 32) << 32);
 			emit_insn(ctx, beq, t1, LOONGARCH_GPR_ZERO, 2);
 			emit_insn(ctx, or, t1, dst, t1);
 			move_reg(ctx, dst, t1);
@@ -753,7 +753,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	/* dst = imm */
 	case BPF_ALU | BPF_MOV | BPF_K:
 	case BPF_ALU64 | BPF_MOV | BPF_K:
-		move_imm(ctx, dst, imm, is32);
+		move_imm(ctx, dst, imm);
+		emit_zext_32(ctx, dst, is32);
 		break;
 
 	/* dst = dst + src */
@@ -769,7 +770,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		if (is_signed_imm12(imm)) {
 			emit_insn(ctx, addid, dst, dst, imm);
 		} else {
-			move_imm(ctx, t1, imm, is32);
+			move_imm(ctx, t1, imm);
+			emit_zext_32(ctx, t1, is32);
 			emit_insn(ctx, addd, dst, dst, t1);
 		}
 		emit_zext_32(ctx, dst, is32);
@@ -788,7 +790,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		if (is_signed_imm12(-imm)) {
 			emit_insn(ctx, addid, dst, dst, -imm);
 		} else {
-			move_imm(ctx, t1, imm, is32);
+			move_imm(ctx, t1, imm);
+			emit_zext_32(ctx, t1, is32);
 			emit_insn(ctx, subd, dst, dst, t1);
 		}
 		emit_zext_32(ctx, dst, is32);
@@ -804,7 +807,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	/* dst = dst * imm */
 	case BPF_ALU | BPF_MUL | BPF_K:
 	case BPF_ALU64 | BPF_MUL | BPF_K:
-		move_imm(ctx, t1, imm, is32);
+		move_imm(ctx, t1, imm);
+		emit_zext_32(ctx, t1, is32);
 		emit_insn(ctx, muld, dst, dst, t1);
 		emit_zext_32(ctx, dst, is32);
 		break;
@@ -831,12 +835,13 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	case BPF_ALU | BPF_DIV | BPF_K:
 	case BPF_ALU64 | BPF_DIV | BPF_K:
 		if (!off) {
-			move_imm(ctx, t1, imm, is32);
+			move_imm(ctx, t1, imm);
+			emit_zext_32(ctx, t1, is32);
 			emit_zext_32(ctx, dst, is32);
 			emit_insn(ctx, divdu, dst, dst, t1);
 			emit_zext_32(ctx, dst, is32);
 		} else {
-			move_imm(ctx, t1, imm, false);
+			move_imm(ctx, t1, imm);
 			emit_sext_32(ctx, t1, is32);
 			emit_sext_32(ctx, dst, is32);
 			emit_insn(ctx, divd, dst, dst, t1);
@@ -866,12 +871,13 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	case BPF_ALU | BPF_MOD | BPF_K:
 	case BPF_ALU64 | BPF_MOD | BPF_K:
 		if (!off) {
-			move_imm(ctx, t1, imm, is32);
+			move_imm(ctx, t1, imm);
+			emit_zext_32(ctx, t1, is32);
 			emit_zext_32(ctx, dst, is32);
 			emit_insn(ctx, moddu, dst, dst, t1);
 			emit_zext_32(ctx, dst, is32);
 		} else {
-			move_imm(ctx, t1, imm, false);
+			move_imm(ctx, t1, imm);
 			emit_sext_32(ctx, t1, is32);
 			emit_sext_32(ctx, dst, is32);
 			emit_insn(ctx, modd, dst, dst, t1);
@@ -899,7 +905,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		if (is_unsigned_imm12(imm)) {
 			emit_insn(ctx, andi, dst, dst, imm);
 		} else {
-			move_imm(ctx, t1, imm, is32);
+			move_imm(ctx, t1, imm);
+			emit_zext_32(ctx, t1, is32);
 			emit_insn(ctx, and, dst, dst, t1);
 		}
 		emit_zext_32(ctx, dst, is32);
@@ -918,7 +925,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		if (is_unsigned_imm12(imm)) {
 			emit_insn(ctx, ori, dst, dst, imm);
 		} else {
-			move_imm(ctx, t1, imm, is32);
+			move_imm(ctx, t1, imm);
+			emit_zext_32(ctx, t1, is32);
 			emit_insn(ctx, or, dst, dst, t1);
 		}
 		emit_zext_32(ctx, dst, is32);
@@ -937,7 +945,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		if (is_unsigned_imm12(imm)) {
 			emit_insn(ctx, xori, dst, dst, imm);
 		} else {
-			move_imm(ctx, t1, imm, is32);
+			move_imm(ctx, t1, imm);
+			emit_zext_32(ctx, t1, is32);
 			emit_insn(ctx, xor, dst, dst, t1);
 		}
 		emit_zext_32(ctx, dst, is32);
@@ -1097,7 +1106,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	case BPF_JMP32 | BPF_JSLE | BPF_K:
 		jmp_offset = bpf2la_offset(i, off, ctx);
 		if (imm) {
-			move_imm(ctx, t1, imm, false);
+			move_imm(ctx, t1, imm);
 			tm = t1;
 		} else {
 			/* If imm is 0, simply use zero register. */
@@ -1129,7 +1138,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	case BPF_JMP | BPF_JSET | BPF_K:
 	case BPF_JMP32 | BPF_JSET | BPF_K:
 		jmp_offset = bpf2la_offset(i, off, ctx);
-		move_imm(ctx, t1, imm, is32);
+		move_imm(ctx, t1, imm);
+		emit_zext_32(ctx, t1, is32);
 		emit_insn(ctx, and, t1, dst, t1);
 		emit_zext_32(ctx, t1, is32);
 		if (emit_cond_jmp(ctx, cond, t1, LOONGARCH_GPR_ZERO, jmp_offset) < 0)
@@ -1227,7 +1237,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		if (bpf_pseudo_func(insn))
 			move_addr(ctx, dst, imm64);
 		else
-			move_imm(ctx, dst, imm64, is32);
+			move_imm(ctx, dst, imm64);
 		return 1;
 	}
 
@@ -1268,7 +1278,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 				else
 					emit_insn(ctx, ldbu, dst, src, off);
 			} else {
-				move_imm(ctx, t1, off, is32);
+				move_imm(ctx, t1, off);
 				if (sign_extend)
 					emit_insn(ctx, ldxb, dst, src, t1);
 				else
@@ -1282,7 +1292,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 				else
 					emit_insn(ctx, ldhu, dst, src, off);
 			} else {
-				move_imm(ctx, t1, off, is32);
+				move_imm(ctx, t1, off);
 				if (sign_extend)
 					emit_insn(ctx, ldxh, dst, src, t1);
 				else
@@ -1296,7 +1306,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 				else
 					emit_insn(ctx, ldwu, dst, src, off);
 			} else {
-				move_imm(ctx, t1, off, is32);
+				move_imm(ctx, t1, off);
 				if (sign_extend)
 					emit_insn(ctx, ldxw, dst, src, t1);
 				else
@@ -1304,7 +1314,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			}
 			break;
 		case BPF_DW:
-			move_imm(ctx, t1, off, is32);
+			move_imm(ctx, t1, off);
 			emit_insn(ctx, ldxd, dst, src, t1);
 			break;
 		}
@@ -1331,42 +1341,42 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 
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
@@ -1397,7 +1407,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, stb, src, dst, off);
 			} else {
-				move_imm(ctx, t1, off, is32);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, stxb, src, dst, t1);
 			}
 			break;
@@ -1405,7 +1415,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, sth, src, dst, off);
 			} else {
-				move_imm(ctx, t1, off, is32);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, stxh, src, dst, t1);
 			}
 			break;
@@ -1415,7 +1425,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			} else if (is_signed_imm14(off)) {
 				emit_insn(ctx, stptrw, src, dst, off);
 			} else {
-				move_imm(ctx, t1, off, is32);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, stxw, src, dst, t1);
 			}
 			break;
@@ -1425,7 +1435,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			} else if (is_signed_imm14(off)) {
 				emit_insn(ctx, stptrd, src, dst, off);
 			} else {
-				move_imm(ctx, t1, off, is32);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, stxd, src, dst, t1);
 			}
 			break;
@@ -1537,7 +1547,7 @@ static int emit_jump_and_link(struct jit_ctx *ctx, u8 rd, u64 target)
 		return -EFAULT;
 	}
 
-	move_imm(ctx, LOONGARCH_GPR_T1, target, false);
+	move_imm(ctx, LOONGARCH_GPR_T1, target);
 	emit_insn(ctx, jirl, rd, LOONGARCH_GPR_T1, 0);
 
 	return 0;
@@ -1734,7 +1744,7 @@ static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 		emit_insn(ctx, std, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_FP, -run_ctx_off + cookie_off);
 
 	/* arg1: prog */
-	move_imm(ctx, LOONGARCH_GPR_A0, (const s64)p, false);
+	move_imm(ctx, LOONGARCH_GPR_A0, (const s64)p);
 	/* arg2: &run_ctx */
 	emit_insn(ctx, addid, LOONGARCH_GPR_A1, LOONGARCH_GPR_FP, -run_ctx_off);
 	ret = emit_call(ctx, (const u64)bpf_trampoline_enter(p));
@@ -1755,7 +1765,7 @@ static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	/* arg1: &args_off */
 	emit_insn(ctx, addid, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -args_off);
 	if (!p->jited)
-		move_imm(ctx, LOONGARCH_GPR_A1, (const s64)p->insnsi, false);
+		move_imm(ctx, LOONGARCH_GPR_A1, (const s64)p->insnsi);
 	ret = emit_call(ctx, (const u64)p->bpf_func);
 	if (ret)
 		return ret;
@@ -1772,7 +1782,7 @@ static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	}
 
 	/* arg1: prog */
-	move_imm(ctx, LOONGARCH_GPR_A0, (const s64)p, false);
+	move_imm(ctx, LOONGARCH_GPR_A0, (const s64)p);
 	/* arg2: prog start time */
 	move_reg(ctx, LOONGARCH_GPR_A1, LOONGARCH_GPR_S1);
 	/* arg3: &run_ctx */
diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.h
index bb58c42c2f2a..57a98f8a055b 100644
--- a/arch/loongarch/net/bpf_jit.h
+++ b/arch/loongarch/net/bpf_jit.h
@@ -137,7 +137,7 @@ static inline void move_addr(struct jit_ctx *ctx, enum loongarch_gpr rd, u64 add
 	emit_insn(ctx, lu52id, rd, rd, imm_63_52);
 }
 
-static inline void move_imm(struct jit_ctx *ctx, enum loongarch_gpr rd, long imm, bool is32)
+static inline void move_imm(struct jit_ctx *ctx, enum loongarch_gpr rd, long imm)
 {
 	long imm_11_0, imm_31_12, imm_51_32, imm_63_52, imm_51_0, imm_51_31;
 
@@ -150,7 +150,7 @@ static inline void move_imm(struct jit_ctx *ctx, enum loongarch_gpr rd, long imm
 	/* addiw rd, $zero, imm_11_0 */
 	if (is_signed_imm12(imm)) {
 		emit_insn(ctx, addiw, rd, LOONGARCH_GPR_ZERO, imm);
-		goto zext;
+		return;
 	}
 
 	/* ori rd, $zero, imm_11_0 */
@@ -195,9 +195,6 @@ static inline void move_imm(struct jit_ctx *ctx, enum loongarch_gpr rd, long imm
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

