Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795408756;
	b=3VaYrqzGbqdBnHjMltaY/cLBM81vCqO9aq7eC+pAdQR/4bNiWjCuKSS1Tm+mYT2NT2pL
	 aRANdl1Ec677v1J78sZCAg/9xDeXz56XCndJ2NO5EAEqyk+f8ttCogcn9xdi+yxE8HMM4
	 4otDrK5F34z+eAu3EXiCE0qR3mdq8Rc3ie1CD51pLFOl3iXDCIvRBFy9Le8ZBXBIMuCWF
	 Ta1kEha0G+47Hg5dzLJgGF+Z+PZ0CO3DBLsW0m5Untd/aVvzc1S5rGZCsUOHP12vhbtit
	 rbc4oESXK7xXuksd0m11zoMtdY7iRW4AJSsW/+aULpykgTqX9jExzGsg7nIw1UsFgZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795408756;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=ZpBqNDeMQl4YytbtlYqAfP/xkPPhADrTeLTX5f7dp8k=;
	b=ZPgOibffAcp4MpBPRD7Gr2ysTKKAvThtHxMYDcTnyX3qqLAwhz4SoJvmowSYz6ls97lB
	 sQ0MUotSD09ap1lgBjgor2lfoQW6P/pMDp7sRDKnq/UHky/6A+SeIxa5KuzzYnIs+JTnT
	 fsUlR+HrJ9RQT91WDCLMCjtiVlrorOTLXAn2yd4zy7NmOISsOI3YYkQ7Z1mcIatsF0gvS
	 LFHgb4i51rmo7m/gXHT57mWZY2oeVLh0G7SV2Or2L6FjXZqP+HO49FpLMG1AR7ISCuaEp
	 vGVHEFJQplRGvZXk++Vy4l3Wd/dkoac0Sg1Gnb7Tv6/QlkonESgovtYNhr2lsuYehYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2FA606A32A;
	Mon, 23 Nov 2026 04:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A2FA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8AxntJywwNrEh0iAA--.31589S3;
	Mon, 23 Nov 2026 12:39:14 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJCxPs9rwwNra8s2AA--.43419S4;
	Mon, 23 Nov 2026 12:39:13 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] LoongArch: BPF: Add support for instructions array
Date: Mon, 23 Nov 2026 12:39:05 +0800
Message-ID: <20261123043907.20225-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20261123043907.20225-1-yangtiezhu@loongson.cn>
References: <20261123043907.20225-1-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJCxPs9rwwNra8s2AA--.43419S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WF45Zr4kZryktryDWF1fKrX_yoW8Gw1rpa
	sxCF9xAr4DWr4UGFnrJay5uryfta1DWrW3X398urWFgF90qr4kJayFkwn09an5Jrs5Ar1k
	Ww4FkrnIga4kAacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcHUqUUUUU

Add support for the instructions array map type in the LoongArch
JIT by calling bpf_prog_update_insn_ptrs() with the offsets that
map xlated_offset to the jited_offset in the final image.

LoongArch JIT already has this offset array which was being used
for bpf_prog_fill_jited_linfo() and can be used directly for the
function bpf_prog_update_insn_ptrs().

This is similar to commit 84b1c40d5b4d ("bpf: arm64: Add support
for instructions array").

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 873b2b146f02..415b945bf818 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -2401,6 +2401,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 		for (i = 0; i <= prog->len; i++)
 			ctx.offset[i] *= LOONGARCH_INSN_SIZE;
 		bpf_prog_fill_jited_linfo(prog, ctx.offset + 1);
+		/*
+		 * The bpf_prog_update_insn_ptrs function expects offsets to
+		 * point to the first byte of the jitted instruction (unlike
+		 * the bpf_prog_fill_jited_linfo above, which, for historical
+		 * reasons, expects to point to the next instruction)
+		 */
+		bpf_prog_update_insn_ptrs(prog, ctx.offset, ctx.ro_image);
 
 out_offset:
 		kvfree(ctx.offset);
-- 
2.42.0

