Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C7C46C845;
	Wed, 30 Sep 2026 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790757089; cv=none; b=MKM861CGzT7KoZdV9eU4Mdj24iSSBl4IuJx9gGv/jRZwF3OSXVtmQPKfUPcAQs1QMv93heW0lHnouxCHSCxq/MkfliLdjU/VfVFrt5dZ2ffi8GZ45NFauW5SjAaO0X37UejLMam+lnP3TaUl8jmtRQpBZcwcMsuKlctaQtTejxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790757089; c=relaxed/simple;
	bh=52FQYT/HhkA4umChPJPv3b4v6jP61MwhIAkriO+A6JI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAN3ISGBtqDmtBYtbPlPVKIRYKK/+2tB1bs2fHl+x3z/yiQRBe2J9zsmEVvaBiGadYiCwpt3ETOApHYWxyqLQSLy9pH6RugPU6iyhX4vuK39/x9CNuzXad8xTASOuZVillPL0WxWhmE4o6p70wnSsFeCADtbLt/yPwt3g0OIUKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hvpCN3HM9zKHMc3;
	Wed, 30 Sep 2026 16:30:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7CFED40576;
	Wed, 30 Sep 2026 16:31:17 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDXpyrRyLxq8dflCA--.24306S3;
	Wed, 30 Sep 2026 16:31:17 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next v3 1/4] bpf, riscv: Fix stack-passed arguments for indirect trampolines
Date: Wed, 30 Sep 2026 08:35:19 +0000
Message-Id: <20260930083522.1914145-2-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930083522.1914145-1-pulehui@huaweicloud.com>
References: <20260930083522.1914145-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXpyrRyLxq8dflCA--.24306S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1DWrWDKr4UGrWkCw47XFb_yoW5WFWkpa
	15KrnxCFW0qr4Ut3s7tFWUWFyFyanYva13GrW7Ja4SkF4jgrWkKa4Fk3WYyF98CryrA34I
	vr4YvFs5Ka4DA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIev
	Ja73UjIFyTuYvjTRMfOzDUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>

store_args() reads stack-passed arguments relative to FP assuming the
trampoline was entered through the fentry call from a traced function. In
that path, the trampoline pushes the parent frame before establishing its
final FP, so the incoming stack arguments start at FP + 16.

An indirect trampoline for a struct_ops callback is called through a
function pointer. Its prologue allocates only the trampoline frame and sets
FP to the incoming SP. The RISC-V ABI places the first stack argument at
that incoming SP, so the arguments start at FP, not FP + 16. Every
stack-passed argument of a callback with more than eight argument slots is
therefore read two slots late.

Pass the prologue-dependent offset to store_args(), using zero for a direct
struct_ops trampoline and 16 for the fentry path.

Fixes: 6801b0aef79d ("riscv, bpf: Add 12-argument support for RV64 bpf trampoline")
Cc: Björn Töpel <bjorn@kernel.org>
Cc: Pu Lehui <pulehui@huawei.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index ed0a6f871dea..b5fa6338e5eb 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -895,7 +895,8 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 	return ret;
 }
 
-static void store_args(int nr_arg_slots, int args_off, struct rv_jit_context *ctx)
+static void store_args(int nr_arg_slots, int args_off, int stack_args_off,
+		       struct rv_jit_context *ctx)
 {
 	int i;
 
@@ -903,8 +904,8 @@ static void store_args(int nr_arg_slots, int args_off, struct rv_jit_context *ct
 		if (i < RV_MAX_REG_ARGS) {
 			emit_sd(RV_REG_FP, -args_off, RV_REG_A0 + i, ctx);
 		} else {
-			/* skip slots for T0 and FP of traced function */
-			emit_ld(RV_REG_T1, 16 + (i - RV_MAX_REG_ARGS) * 8, RV_REG_FP, ctx);
+			emit_ld(RV_REG_T1, stack_args_off +
+				(i - RV_MAX_REG_ARGS) * 8, RV_REG_FP, ctx);
 			emit_sd(RV_REG_FP, -args_off, RV_REG_T1, ctx);
 		}
 		args_off -= 8;
@@ -1190,7 +1191,12 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	func_meta = nr_arg_slots;
 	emit_store_stack_imm64(RV_REG_T1, -func_meta_off, func_meta, ctx);
 
-	store_args(nr_arg_slots, args_off, ctx);
+	/*
+	 * A direct struct_ops call has its first stack argument at the incoming
+	 * SP, which the trampoline keeps as FP. The fentry path pushes the
+	 * parent frame first, so its incoming stack arguments start at FP + 16.
+	 */
+	store_args(nr_arg_slots, args_off, is_struct_ops ? 0 : 16, ctx);
 
 	if (bpf_fsession_cnt(tnodes)) {
 		/* clear all session cookies' value */
-- 
2.34.1

