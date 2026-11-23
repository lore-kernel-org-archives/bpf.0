Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795408756;
	b=hxuW8fBYlOPIbSD+KMeB3W82B3brj61q/fs6+lbLiTEiJtI2EKA73f/JY4WyCZe8TaDc
	 0lfkiVib9W4+JY/nUnmuXZ8jaANoqsrBiH8rMaciigVVaW4SXe8hTKXrTQqt68l0xau+L
	 nsF0Q4WA/ylyMYG8fL51w2+wsDw9Fv+qe0bb6ux/32JL6vBozra23rKb/6hhoKVeDipIO
	 1/2/z6a0yIj8Kj5gX8k6/mRMnsW3N4iRWrJKVFw1D01+53SPQUtgds6bysU3WTm1aSirL
	 YrBP3VG0LZCs37EQ9xRSTpR92qoISEG5RsU6BwZgKS7OOpRII6pvC7Q6JRApTvdNRrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795408756;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=Y5vnHn5+SNVJPardiVVrlUUndhewH/fyUFaks4gQYFQ=;
	b=Nzz9o8lK0reX4D/ecFH+LffSnJ3s0mGjnGHSK79lAysxg8aWfHeTvcInyEn2ovEutDX5
	 olNiWKmsElyl4mysLtzJA5DO8BlIi4JHlJjwNPhpuaQIpdX8C0/FhO5nc5PBP84Hp4uyD
	 axPweLw9sBEDcR6kY3O15O/sORi0bWQjyfoHYgfC9oZPwW+xcsB/iTL5qqoj/kky7TRp6
	 EmgsQZSVa6ZujRfqgBozqTkbUIrqU2N/Wpej1+RpyJZ6OXrdCpdLaU/GK1NxeVQ6lLIdI
	 NWTZ1EOtm7CTkpp8XkIhpjR+0SI0FKrclvWBI2DjQZFU5UyXlxQLMKgDbm3xRur7ibg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC35606A320;
	Mon, 23 Nov 2026 04:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AC35606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8BxrtBxwwNrDx0iAA--.4415S3;
	Mon, 23 Nov 2026 12:39:13 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJCxPs9rwwNra8s2AA--.43419S3;
	Mon, 23 Nov 2026 12:39:12 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] LoongArch: BPF: Optimize BPF_CALL control flow
Date: Mon, 23 Nov 2026 12:39:04 +0800
Message-ID: <20261123043907.20225-2-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJCxPs9rwwNra8s2AA--.43419S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WFyrtr4xKFyxJw1xGF43twc_yoW8XrWkpr
	n8C3Z5Cr48Wa4jgF1kta97Wr1SyF4DWF17ua42y3yxA3ZIqw1fWa4UKw1aka90yw1rJr4x
	Xrs0yF1j9a1DCwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU82g43UUUUU==

Separate BPF_PSEUDO_CALL handling into its own execution path by
emitting the jump instruction and breaking early. This eliminates
the need for a redundant 'insn->src_reg != BPF_PSEUDO_CALL' check
at the end of the main BPF_CALL case.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index d36891db1179..873b2b146f02 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1219,6 +1219,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		if (insn->src_reg == BPF_PSEUDO_CALL) {
 			tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size);
 			emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, tcc_ptr_off);
+			move_addr(ctx, t1, func_addr);
+			emit_insn(ctx, jirl, LOONGARCH_GPR_RA, t1, 0);
+			break;
 		}
 
 		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
@@ -1245,8 +1248,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		 * convention with the argument and return value in BPF_REG_AX,
 		 * so skip moving the C return value into BPF_REG_0.
 		 */
-		if (insn->src_reg != BPF_PSEUDO_CALL &&
-		    func_addr != (u64)arch_bpf_timed_may_goto)
+		if (func_addr != (u64)arch_bpf_timed_may_goto)
 			move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_A0);
 
 		break;
-- 
2.42.0

