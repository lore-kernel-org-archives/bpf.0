Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1DC3DA5BC
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 09:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342881; cv=none; b=VCI0dWRUVHatELPqoV6foklBI5Szbqia5zmrZAd8eqfXZCtFjOJs841McGN189expBNFp4BJKOSu9vU0lm1sPXmurE7wkGcmGIWqP2E2MgLfYy+4ay2Anr8CCQ4HWg+sCycpUabKaM2hMylPZcSHmqSjCTf9y489L4MzFAcEGJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342881; c=relaxed/simple;
	bh=4ekBA/+cyfwzVZCAoO4sTyiBZp/7jTw/DSJiaadpXNY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0SfZprOUBLlCrL6Mpc4cD842yBzVgCV+EKdUvMiKO0y2KfRLL/zTCxfN5XUh1pUyF4R2s9uNFGb8GdiKY2R2snTaUEBhAKBmgtEmyApDYyA9IF+L57d+EctHlKdovyplqmCENXD6jayfzPBRQau3BSi7FHol4buulQjVc3YJfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dx7qndUsJpmSAeAA--.26633S3;
	Tue, 24 Mar 2026 17:01:17 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxC8LTUsJpmxVcAA--.43301S7;
	Tue, 24 Mar 2026 17:01:15 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: loongarch@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [RFC PATCH 5/7] LoongArch: BPF: Add {8,16}-bit read-modify-write instructions
Date: Tue, 24 Mar 2026 17:01:04 +0800
Message-ID: <20260324090106.13527-6-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260324090106.13527-1-yangtiezhu@loongson.cn>
References: <20260324090106.13527-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxC8LTUsJpmxVcAA--.43301S7
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGr1fZryktry3JF15Kw43XFc_yoW5KF4kpr
	srWr95KaykJFWagas3Jr97JFW3Kr4xJ3srWF13J39Yg3yaqF15GF1kKF1fZFy5Cr97Cr4f
	Wr93ZFyq93W7AFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcHUqUUUUU

The 8-bit and 16-bit read-modify-write instructions amadd.{b/h} and
amswap.{b/h} were newly added in the new LoongArch Reference Manual,
handle them to avoid the error of unknown opcode if possible.

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

