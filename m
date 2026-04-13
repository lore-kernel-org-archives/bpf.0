Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FEE283FCF;
	Mon, 13 Apr 2026 04:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053133; cv=none; b=sgroTzPVQs278E+5MA6jhPzx73VuZklR7GShMJSTkHYs4Z7cEDulsSUcU6lVEkvJ6A0EkDEaOSiinN4Ad6tJz0/TBFESvaPjVCOLTDCjXkQrLy+MRkO/PmbO3T/IfE1iAiljaBvxUIvJAQRUqsNysNRuIuW5fAr9RWxxLsOAYEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053133; c=relaxed/simple;
	bh=8UTl0XC2kOUL6OyLfakMpUNxbSJ7OAL9PKnPUb1bifg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JT9+9D+/GBKLaMF0JS5n9VJAW0nTiqX8yexQe3U0xDiVUT2gygvE+nw6zZ74Q8IIGjemIdqIxwarRmRnxDwRvx7IOExDejBahiCaJiU3WTWSLu8pXaMW5rdEQEIc0Ht6oDEbpqHSAKERS8NZWM+/5EBMn6vCiq+z+x8i4so2KG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxoOp+a9xpswIAAA--.75S3;
	Mon, 13 Apr 2026 12:05:18 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxaeBya9xpD91rAA--.9793S5;
	Mon, 13 Apr 2026 12:05:17 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] LoongArch: BPF: Support 8 and 16 bit read-modify-write instructions
Date: Mon, 13 Apr 2026 12:05:04 +0800
Message-ID: <20260413040506.26640-4-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260413040506.26640-1-yangtiezhu@loongson.cn>
References: <20260413040506.26640-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxaeBya9xpD91rAA--.9793S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZFWxtFW5Cr4Utr13KF1Dtwc_yoW5KF1Dpr
	srWrZ5KaykJF4agas3Jr97JFW3Kr4xJ3srWF13J395W3yaqF13GF1kKF1fZFy5Cr97Cr4f
	W3s3ZFyq93W7AFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUco7KUUUUU

The 8 and 16 bit read-modify-write instructions {amadd/amswap}.{b/h}
were newly added in the latest LoongArch Reference Manual, use them
to avoid the error of unknown opcode if possible.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 83 ++++++++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 9 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index fefda4050a20..c9a32f124f5e 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -363,10 +363,30 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	switch (imm) {
 	/* lock *(size *)(dst + off) <op>= src */
 	case BPF_ADD:
-		if (isdw)
-			emit_insn(ctx, amaddd, t2, t1, src);
-		else
+		switch (BPF_SIZE(insn->code)) {
+		case BPF_B:
+			if (cpu_has_lam_bh) {
+				emit_insn(ctx, amaddb, t2, t1, src);
+			} else {
+				pr_err_once("bpf-jit: amadd.b instruction is not supported\n");
+				return -EINVAL;
+			}
+			break;
+		case BPF_H:
+			if (cpu_has_lam_bh) {
+				emit_insn(ctx, amaddh, t2, t1, src);
+			} else {
+				pr_err_once("bpf-jit: amadd.h instruction is not supported\n");
+				return -EINVAL;
+			}
+			break;
+		case BPF_W:
 			emit_insn(ctx, amaddw, t2, t1, src);
+			break;
+		case BPF_DW:
+			emit_insn(ctx, amaddd, t2, t1, src);
+			break;
+		}
 		break;
 	case BPF_AND:
 		if (isdw)
@@ -388,11 +408,32 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		break;
 	/* src = atomic_fetch_<op>(dst + off, src) */
 	case BPF_ADD | BPF_FETCH:
-		if (isdw) {
-			emit_insn(ctx, amaddd, src, t1, t3);
-		} else {
+		switch (BPF_SIZE(insn->code)) {
+		case BPF_B:
+			if (cpu_has_lam_bh) {
+				emit_insn(ctx, amaddb, src, t1, t3);
+				emit_zext_32(ctx, src, true);
+			} else {
+				pr_err_once("bpf-jit: amadd.b instruction is not supported\n");
+				return -EINVAL;
+			}
+			break;
+		case BPF_H:
+			if (cpu_has_lam_bh) {
+				emit_insn(ctx, amaddh, src, t1, t3);
+				emit_zext_32(ctx, src, true);
+			} else {
+				pr_err_once("bpf-jit: amadd.h instruction is not supported\n");
+				return -EINVAL;
+			}
+			break;
+		case BPF_W:
 			emit_insn(ctx, amaddw, src, t1, t3);
 			emit_zext_32(ctx, src, true);
+			break;
+		case BPF_DW:
+			emit_insn(ctx, amaddd, src, t1, t3);
+			break;
 		}
 		break;
 	case BPF_AND | BPF_FETCH:
@@ -421,11 +462,32 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		break;
 	/* src = atomic_xchg(dst + off, src); */
 	case BPF_XCHG:
-		if (isdw) {
-			emit_insn(ctx, amswapd, src, t1, t3);
-		} else {
+		switch (BPF_SIZE(insn->code)) {
+		case BPF_B:
+			if (cpu_has_lam_bh) {
+				emit_insn(ctx, amswapb, src, t1, t3);
+				emit_zext_32(ctx, src, true);
+			} else {
+				pr_err_once("bpf-jit: amswap.b instruction is not supported\n");
+				return -EINVAL;
+			}
+			break;
+		case BPF_H:
+			if (cpu_has_lam_bh) {
+				emit_insn(ctx, amswaph, src, t1, t3);
+				emit_zext_32(ctx, src, true);
+			} else {
+				pr_err_once("bpf-jit: amswap.h instruction is not supported\n");
+				return -EINVAL;
+			}
+			break;
+		case BPF_W:
 			emit_insn(ctx, amswapw, src, t1, t3);
 			emit_zext_32(ctx, src, true);
+			break;
+		case BPF_DW:
+			emit_insn(ctx, amswapd, src, t1, t3);
+			break;
 		}
 		break;
 	/* r0 = atomic_cmpxchg(dst + off, r0, src); */
@@ -1259,6 +1321,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			return ret;
 		break;
 
+	/* Atomics */
+	case BPF_STX | BPF_ATOMIC | BPF_B:
+	case BPF_STX | BPF_ATOMIC | BPF_H:
 	case BPF_STX | BPF_ATOMIC | BPF_W:
 	case BPF_STX | BPF_ATOMIC | BPF_DW:
 		ret = emit_atomic_rmw(insn, ctx);
-- 
2.42.0

