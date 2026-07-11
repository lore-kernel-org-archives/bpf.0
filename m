Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398D236CDF3;
	Sat, 11 Jul 2026 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783765023; cv=none; b=L3bH6hEQ31gNg0IT/BUjwg3UlMrAKLa42aUV3JUGBeVoDtchwmmATgJ4o0jSR8Cm4OrWmDoMB6o2ghQuQMtOxfWFZbfDJOldSIx0Y42WjFn37iMBtuFWXgQRn+uLyVZ1HPM1yYZ2IQvfNOtvc+PbMMGX058tE7UBNlgTLDjFYUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783765023; c=relaxed/simple;
	bh=RAx2JL0e6dZibuM38IY/6hfhUVPPDs6nAvN3cGKc2ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brZL1lPUhg406UMxjPAuNkqZ8lHhRvTHmMhYPOvV5dlaAuaYWLkAvfaNw6paYTzE9xcLAhvSvzm0m7Ave6VE92RGMPSxShSrgonZIBs3cutrTBlDTCnEcPHVqAx2VyuvWO5myWFu4ILCCe7Bt1ePe0wU+DOjiqSwZFWUIkBDuoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxGOscGFJqE5kCAA--.10680S3;
	Sat, 11 Jul 2026 18:17:00 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxb8cZGFJqZ3EJAA--.35766S3;
	Sat, 11 Jul 2026 18:16:59 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/2] LoongArch: BPF: Eliminate zero-extension for memory load operations
Date: Sat, 11 Jul 2026 18:16:55 +0800
Message-ID: <20260711101656.7415-2-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJBxb8cZGFJqZ3EJAA--.35766S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kw4xAFWxurW8CF48ur4kAFc_yoW8uw17pr
	W7CFn5CrW0qrZ3WFyxAw48Wr13KFs5WF45WasF9a48Ja1aqrnIgF1fKa1jqF95GrWrWw18
	Xrs5Zr13u3Z8AagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcCD7UUUUU

The unsigned memory load instructions naturally clear the upper 32 bits
of the destination register during sub-word and word memory accesses.

Add a look-ahead optimization for the load instructions by checking the
next instruction. This is achieved by overwriting bpf_jit_needs_zext()
to return true.

If insn_is_zext() detects a redundant zero-extension, return 1 to inform
the outer build_body() to skip the instruction.

For normal loads, this look-ahead is safely restricted to unsigned modes
(!sign_extend) to preserve signed contexts.

With this patch, directly reduce the final JITted image size.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 69bc30f88c44..b8cef3ea5c6d 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -579,6 +579,14 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			break;
 		}
 		emit_insn(ctx, dbar, 0b10100);
+
+		/*
+		 * If our next insn is a redundant zext, return 1 to tell
+		 * build_body() to skip it, as atomic load-acquires always
+		 * zero-extend sub-word results.
+		 */
+		if (BPF_SIZE(code) != BPF_DW && insn_is_zext(&insn[1]))
+			return 1;
 		break;
 	/* store_release(dst_reg + off16, src_reg) */
 	case BPF_STORE_REL:
@@ -1318,6 +1326,14 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		ret = add_exception_handler(insn, ctx, dst);
 		if (ret)
 			return ret;
+
+		/*
+		 * If our next insn is a redundant zext, and this is a standard
+		 * unsigned sub-word load where hardware already zero-extends,
+		 * return 1 to tell build_body() to skip it.
+		 */
+		if (BPF_SIZE(code) != BPF_DW && !sign_extend && insn_is_zext(&insn[1]))
+			return 1;
 		break;
 
 	/* *(size *)(dst + off) = imm */
@@ -2397,6 +2413,11 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 	return true;
 }
 
+bool bpf_jit_needs_zext(void)
+{
+	return true;
+}
+
 bool bpf_jit_inlines_helper_call(s32 imm)
 {
 	switch (imm) {
-- 
2.42.0

