Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E59327A462;
	Tue, 28 Jul 2026 03:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208591; cv=none; b=hks+eKWjbaiXvhO9qpZv2p4eJzc3tgu0YrwGZDGrvI+1H9PLbij/p+B16/HVmR4mdHGdL4aNcMLBi6/JqVunRXa+7arUIsHDcskBCWgammgZ9eoYN0dlOmJyLS6BCbEMX0itOHlKDTGc7y+zzK/sgog19GMzejJI0osgauxv6D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208591; c=relaxed/simple;
	bh=BZ+YC18inku7FFF0ojsd2JgbUS2v1U14oPlKbhr0aTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWdPf12S8NBTOjimtrIGZ2FFuZR7oSmINJvCPpEKkk3mhSWu9F04OQKOpbFHdVSxgA1FVlLdN23B76610Om8l1srofu7JZm/K0WNZSbO2sJHq8eNgHq3SpFwGwNElR4BwcxWxAdiUZaD96h3+p3QWnDKA+SEJ5jOQ5cNGCQnwwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxSesFH2hqvP8HAA--.27800S3;
	Tue, 28 Jul 2026 11:16:21 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxPcUAH2hqhzcbAA--.14265S3;
	Tue, 28 Jul 2026 11:16:20 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] LoongArch: BPF: Clean up and decouple is32 parameter from move_imm()
Date: Tue, 28 Jul 2026 11:16:14 +0800
Message-ID: <20260728031615.9389-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260728031615.9389-1-yangtiezhu@loongson.cn>
References: <20260728031615.9389-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxPcUAH2hqhzcbAA--.14265S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9fXoWfXr17ZFWxKr45Xr43Ww15Awc_yoW8Xw13Co
	W0qr4vga1rWF1fXay7Gr1jyr17ua1kZF4rJrnrC3sYkrWrZr90vrWaqw48Za1Fqrn8KFyj
	kF1Iq3Wjyr9xZw43l-sFpf9Il3svdjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYU7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUUU

The current move_imm() relies on the 'is32' parameter for ALU32 and JMP32,
forcing the helper to internally clear the upper 32 bits. However, this is
redundant for 64-bit immediate loads. Furthermore, it is even undesirable
for load/store signed address offset computations.

Clean up the helper by completely removing the 'is32' parameter. Move the
sub-word zero-extensions outward to explicit callers. Only append the zero
extension after move_imm() inside the shared 32-bit and 64-bit case blocks
where 'is32' dynamically controls the extension behavior. For 64-bit and
load-store operations, just drop the parameter.

This is preparation for later patch, no functional changes.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 102 +++++++++++++++++++----------------
 arch/loongarch/net/bpf_jit.h |   7 +--
 2 files changed, 58 insertions(+), 51 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 48d368ba0529..4c54e57455ae 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -191,7 +191,7 @@ static void build_prologue(struct jit_ctx *ctx)
 	ctx->stack_size = stack_adjust;
 
 	if (ctx->arena_vm_start)
-		move_imm(ctx, REG_ARENA, ctx->arena_vm_start, false);
+		move_imm(ctx, REG_ARENA, ctx->arena_vm_start);
 }
 
 static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
@@ -336,7 +336,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 
 static void emit_store_stack_imm64(struct jit_ctx *ctx, int reg, int stack_off, u64 imm64)
 {
-	move_imm(ctx, reg, imm64, false);
+	move_imm(ctx, reg, imm64);
 	emit_insn(ctx, std, reg, LOONGARCH_GPR_FP, stack_off);
 }
 
@@ -352,7 +352,7 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	const s32 imm = insn->imm;
 	const bool isdw = BPF_SIZE(insn->code) == BPF_DW;
 
-	move_imm(ctx, t1, off, false);
+	move_imm(ctx, t1, off);
 	emit_insn(ctx, addd, t1, dst, t1);
 	move_reg(ctx, t3, src);
 
@@ -524,7 +524,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, ldbu, dst, src, off);
 			} else {
-				move_imm(ctx, t1, off, false);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, ldxbu, dst, src, t1);
 			}
 			break;
@@ -532,7 +532,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, ldhu, dst, src, off);
 			} else {
-				move_imm(ctx, t1, off, false);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, ldxhu, dst, src, t1);
 			}
 			break;
@@ -540,7 +540,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, ldwu, dst, src, off);
 			} else {
-				move_imm(ctx, t1, off, false);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, ldxwu, dst, src, t1);
 			}
 			break;
@@ -548,7 +548,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, ldd, dst, src, off);
 			} else {
-				move_imm(ctx, t1, off, false);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, ldxd, dst, src, t1);
 			}
 			break;
@@ -563,7 +563,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, stb, src, dst, off);
 			} else {
-				move_imm(ctx, t1, off, false);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, stxb, src, dst, t1);
 			}
 			break;
@@ -571,7 +571,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, sth, src, dst, off);
 			} else {
-				move_imm(ctx, t1, off, false);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, stxh, src, dst, t1);
 			}
 			break;
@@ -579,7 +579,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, stw, src, dst, off);
 			} else {
-				move_imm(ctx, t1, off, false);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, stxw, src, dst, t1);
 			}
 			break;
@@ -587,7 +587,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, std, src, dst, off);
 			} else {
-				move_imm(ctx, t1, off, false);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, stxd, src, dst, t1);
 			}
 			break;
@@ -712,7 +712,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		if (insn_is_cast_user(insn)) {
 			move_reg(ctx, t1, src);
 			emit_zext_32(ctx, t1, true);
-			move_imm(ctx, dst, (ctx->user_vm_start >> 32) << 32, false);
+			move_imm(ctx, dst, (ctx->user_vm_start >> 32) << 32);
 			emit_insn(ctx, beq, t1, LOONGARCH_GPR_ZERO, 1);
 			emit_insn(ctx, or, t1, dst, t1);
 			move_reg(ctx, dst, t1);
@@ -740,7 +740,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	/* dst = imm */
 	case BPF_ALU | BPF_MOV | BPF_K:
 	case BPF_ALU64 | BPF_MOV | BPF_K:
-		move_imm(ctx, dst, imm, is32);
+		move_imm(ctx, dst, imm);
+		emit_zext_32(ctx, dst, is32);
 		break;
 
 	/* dst = dst + src */
@@ -756,7 +757,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		if (is_signed_imm12(imm)) {
 			emit_insn(ctx, addid, dst, dst, imm);
 		} else {
-			move_imm(ctx, t1, imm, is32);
+			move_imm(ctx, t1, imm);
+			emit_zext_32(ctx, t1, is32);
 			emit_insn(ctx, addd, dst, dst, t1);
 		}
 		emit_zext_32(ctx, dst, is32);
@@ -775,7 +777,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		if (is_signed_imm12(-imm)) {
 			emit_insn(ctx, addid, dst, dst, -imm);
 		} else {
-			move_imm(ctx, t1, imm, is32);
+			move_imm(ctx, t1, imm);
+			emit_zext_32(ctx, t1, is32);
 			emit_insn(ctx, subd, dst, dst, t1);
 		}
 		emit_zext_32(ctx, dst, is32);
@@ -791,7 +794,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	/* dst = dst * imm */
 	case BPF_ALU | BPF_MUL | BPF_K:
 	case BPF_ALU64 | BPF_MUL | BPF_K:
-		move_imm(ctx, t1, imm, is32);
+		move_imm(ctx, t1, imm);
+		emit_zext_32(ctx, t1, is32);
 		emit_insn(ctx, muld, dst, dst, t1);
 		emit_zext_32(ctx, dst, is32);
 		break;
@@ -818,12 +822,13 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
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
@@ -853,12 +858,13 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
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
@@ -886,7 +892,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		if (is_unsigned_imm12(imm)) {
 			emit_insn(ctx, andi, dst, dst, imm);
 		} else {
-			move_imm(ctx, t1, imm, is32);
+			move_imm(ctx, t1, imm);
+			emit_zext_32(ctx, t1, is32);
 			emit_insn(ctx, and, dst, dst, t1);
 		}
 		emit_zext_32(ctx, dst, is32);
@@ -905,7 +912,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		if (is_unsigned_imm12(imm)) {
 			emit_insn(ctx, ori, dst, dst, imm);
 		} else {
-			move_imm(ctx, t1, imm, is32);
+			move_imm(ctx, t1, imm);
+			emit_zext_32(ctx, t1, is32);
 			emit_insn(ctx, or, dst, dst, t1);
 		}
 		emit_zext_32(ctx, dst, is32);
@@ -924,7 +932,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		if (is_unsigned_imm12(imm)) {
 			emit_insn(ctx, xori, dst, dst, imm);
 		} else {
-			move_imm(ctx, t1, imm, is32);
+			move_imm(ctx, t1, imm);
+			emit_zext_32(ctx, t1, is32);
 			emit_insn(ctx, xor, dst, dst, t1);
 		}
 		emit_zext_32(ctx, dst, is32);
@@ -1084,7 +1093,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	case BPF_JMP32 | BPF_JSLE | BPF_K:
 		jmp_offset = bpf2la_offset(i, off, ctx);
 		if (imm) {
-			move_imm(ctx, t1, imm, false);
+			move_imm(ctx, t1, imm);
 			tm = t1;
 		} else {
 			/* If imm is 0, simply use zero register. */
@@ -1116,7 +1125,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	case BPF_JMP | BPF_JSET | BPF_K:
 	case BPF_JMP32 | BPF_JSET | BPF_K:
 		jmp_offset = bpf2la_offset(i, off, ctx);
-		move_imm(ctx, t1, imm, is32);
+		move_imm(ctx, t1, imm);
+		emit_zext_32(ctx, t1, is32);
 		emit_insn(ctx, and, t1, dst, t1);
 		emit_zext_32(ctx, t1, is32);
 		if (emit_cond_jmp(ctx, cond, t1, LOONGARCH_GPR_ZERO, jmp_offset) < 0)
@@ -1208,7 +1218,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		if (bpf_pseudo_func(insn))
 			move_addr(ctx, dst, imm64);
 		else
-			move_imm(ctx, dst, imm64, is32);
+			move_imm(ctx, dst, imm64);
 		return 1;
 	}
 
@@ -1249,7 +1259,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 				else
 					emit_insn(ctx, ldbu, dst, src, off);
 			} else {
-				move_imm(ctx, t1, off, is32);
+				move_imm(ctx, t1, off);
 				if (sign_extend)
 					emit_insn(ctx, ldxb, dst, src, t1);
 				else
@@ -1263,7 +1273,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 				else
 					emit_insn(ctx, ldhu, dst, src, off);
 			} else {
-				move_imm(ctx, t1, off, is32);
+				move_imm(ctx, t1, off);
 				if (sign_extend)
 					emit_insn(ctx, ldxh, dst, src, t1);
 				else
@@ -1277,7 +1287,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 				else
 					emit_insn(ctx, ldwu, dst, src, off);
 			} else {
-				move_imm(ctx, t1, off, is32);
+				move_imm(ctx, t1, off);
 				if (sign_extend)
 					emit_insn(ctx, ldxw, dst, src, t1);
 				else
@@ -1285,7 +1295,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			}
 			break;
 		case BPF_DW:
-			move_imm(ctx, t1, off, is32);
+			move_imm(ctx, t1, off);
 			emit_insn(ctx, ldxd, dst, src, t1);
 			break;
 		}
@@ -1312,42 +1322,42 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 
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
@@ -1378,7 +1388,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, stb, src, dst, off);
 			} else {
-				move_imm(ctx, t1, off, is32);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, stxb, src, dst, t1);
 			}
 			break;
@@ -1386,7 +1396,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, sth, src, dst, off);
 			} else {
-				move_imm(ctx, t1, off, is32);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, stxh, src, dst, t1);
 			}
 			break;
@@ -1396,7 +1406,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			} else if (is_signed_imm14(off)) {
 				emit_insn(ctx, stptrw, src, dst, off);
 			} else {
-				move_imm(ctx, t1, off, is32);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, stxw, src, dst, t1);
 			}
 			break;
@@ -1406,7 +1416,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			} else if (is_signed_imm14(off)) {
 				emit_insn(ctx, stptrd, src, dst, off);
 			} else {
-				move_imm(ctx, t1, off, is32);
+				move_imm(ctx, t1, off);
 				emit_insn(ctx, stxd, src, dst, t1);
 			}
 			break;
@@ -1518,7 +1528,7 @@ static int emit_jump_and_link(struct jit_ctx *ctx, u8 rd, u64 target)
 		return -EFAULT;
 	}
 
-	move_imm(ctx, LOONGARCH_GPR_T1, target, false);
+	move_imm(ctx, LOONGARCH_GPR_T1, target);
 	emit_insn(ctx, jirl, rd, LOONGARCH_GPR_T1, 0);
 
 	return 0;
@@ -1692,7 +1702,7 @@ static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_node *n,
 		emit_insn(ctx, std, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_FP, -run_ctx_off + cookie_off);
 
 	/* arg1: prog */
-	move_imm(ctx, LOONGARCH_GPR_A0, (const s64)p, false);
+	move_imm(ctx, LOONGARCH_GPR_A0, (const s64)p);
 	/* arg2: &run_ctx */
 	emit_insn(ctx, addid, LOONGARCH_GPR_A1, LOONGARCH_GPR_FP, -run_ctx_off);
 	ret = emit_call(ctx, (const u64)bpf_trampoline_enter(p));
@@ -1713,7 +1723,7 @@ static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_node *n,
 	/* arg1: &args_off */
 	emit_insn(ctx, addid, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -args_off);
 	if (!p->jited)
-		move_imm(ctx, LOONGARCH_GPR_A1, (const s64)p->insnsi, false);
+		move_imm(ctx, LOONGARCH_GPR_A1, (const s64)p->insnsi);
 	ret = emit_call(ctx, (const u64)p->bpf_func);
 	if (ret)
 		return ret;
@@ -1730,7 +1740,7 @@ static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_node *n,
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

