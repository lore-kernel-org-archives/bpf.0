Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F226532ABCA;
	Sat,  5 Sep 2026 06:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591548; cv=none; b=gt7nc0vKsG9qc2CCcq971jzDhzyYwtwK/auPKurcIWlpH+kUCd+sAxZ0XYhAwEZIqc9J5WmP16INbugHxk4SCgMb86ouRDjJhsCbElhutwSGXNy2lD9WqDq0AY4re1qu/Y7dBKSS13BxSjMELC+uEZf6lFNHwruvhsx5s2USBUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591548; c=relaxed/simple;
	bh=b8LHy68suuYlq55nOMDO51UBCjVeHOXVeOitY4kUZEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fKqXoG9B41MfDiNt0R9ZuUJdg7gl7DZ2owdXU8Kp3Cvty22RmiyNwA7MbzZeAWG3qNOw+9jyIVKaQWAFCO8Ncd/QzwVaVCr0wn49WbbCc/nmvnE2sGacG5RNJoN/WETZ1UcbjmAhPQDDsjL0aVFN7J3JAYZ4HlpilcBQ1DxGBaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hcPLJ28JVzYQty3;
	Sat,  5 Sep 2026 14:58:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 340844057A;
	Sat,  5 Sep 2026 14:59:02 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgDXvQi0vZtqheFEAw--.38251S3;
	Sat, 05 Sep 2026 14:59:01 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Feng Jiang <jiangfeng@kylinos.cn>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
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
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next v4 1/3] riscv, bpf: Remap BPF_REG_0 and RV_REG_TCC
Date: Sat,  5 Sep 2026 07:04:07 +0000
Message-Id: <20260905070409.4141522-2-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905070409.4141522-1-pulehui@huaweicloud.com>
References: <20260905070409.4141522-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDXvQi0vZtqheFEAw--.38251S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1fZryftry5Wry5GrWfZrb_yoWrZw43pa
	yUu3srJ34v9a13W347GF1UX3yfJrnYqay7Cw1fKayakF1qqryrXa1kKr45try5JrsYkws5
	AF1v9wsa93W8JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIw0e
	DUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

To prepare for supporting bpf stack arguments and unifying the calling
convention between bpf2bpf calls and kfunc calls, remap BPF_REG_0 to t6
and RV_REG_TCC to t5.

In the riscv abi, a0-a7 are designated for function argument passing.
Freeing a5 and a6 allows bpf2bpf calls to pass extra arguments (6th to
8th) via a5-a7 consistently with kfuncs.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit_comp64.c                         | 8 ++++----
 arch/riscv/net/bpf_timed_may_goto.S                     | 4 ++--
 tools/testing/selftests/bpf/progs/verifier_jit_inline.c | 2 +-
 tools/testing/selftests/bpf/progs/verifier_ldsx.c       | 6 +++---
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index e7378be171a9..aac128b9f0a4 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -23,11 +23,11 @@
 /* fentry and TCC init insns will be skipped on tailcall */
 #define RV_TAILCALL_OFFSET ((RV_FENTRY_NINSNS + 1) * 4)
 
-#define RV_REG_TCC RV_REG_A6
+#define RV_REG_TCC RV_REG_T5
 #define RV_REG_ARENA RV_REG_S7 /* For storing arena_vm_start */
 
 static const int regmap[] = {
-	[BPF_REG_0] =	RV_REG_A5,
+	[BPF_REG_0] =	RV_REG_T6,
 	[BPF_REG_1] =	RV_REG_A0,
 	[BPF_REG_2] =	RV_REG_A1,
 	[BPF_REG_3] =	RV_REG_A2,
@@ -47,13 +47,13 @@ static const int pt_regmap[] = {
 	[RV_REG_A2] = offsetof(struct pt_regs, a2),
 	[RV_REG_A3] = offsetof(struct pt_regs, a3),
 	[RV_REG_A4] = offsetof(struct pt_regs, a4),
-	[RV_REG_A5] = offsetof(struct pt_regs, a5),
 	[RV_REG_S1] = offsetof(struct pt_regs, s1),
 	[RV_REG_S2] = offsetof(struct pt_regs, s2),
 	[RV_REG_S3] = offsetof(struct pt_regs, s3),
 	[RV_REG_S4] = offsetof(struct pt_regs, s4),
 	[RV_REG_S5] = offsetof(struct pt_regs, s5),
 	[RV_REG_T0] = offsetof(struct pt_regs, t0),
+	[RV_REG_T6] = offsetof(struct pt_regs, t6),
 };
 
 enum {
@@ -239,7 +239,7 @@ static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
 	emit_addi(RV_REG_SP, RV_REG_SP, stack_adjust, ctx);
 	/* Set return value. */
 	if (!is_tail_call)
-		emit_addiw(RV_REG_A0, RV_REG_A5, 0, ctx);
+		emit_addiw(RV_REG_A0, regmap[BPF_REG_0], 0, ctx);
 	emit_jalr(RV_REG_ZERO, is_tail_call ? RV_REG_T3 : RV_REG_RA,
 		  is_tail_call ? RV_TAILCALL_OFFSET : 0, ctx);
 }
diff --git a/arch/riscv/net/bpf_timed_may_goto.S b/arch/riscv/net/bpf_timed_may_goto.S
index 02c637d87420..ac41bf6dcb3d 100644
--- a/arch/riscv/net/bpf_timed_may_goto.S
+++ b/arch/riscv/net/bpf_timed_may_goto.S
@@ -21,7 +21,7 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	addi	s0, sp, 8*SZREG
 
 	/* Save BPF registers R0-R5 (a5, a0-a4) */
-	REG_S	a5, 5*SZREG(sp)
+	REG_S	t6, 5*SZREG(sp)
 	REG_S	a0, 4*SZREG(sp)
 	REG_S	a1, 3*SZREG(sp)
 	REG_S	a2, 2*SZREG(sp)
@@ -38,7 +38,7 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	REG_L	a2, 2*SZREG(sp)
 	REG_L	a1, 3*SZREG(sp)
 	REG_L	a0, 4*SZREG(sp)
-	REG_L	a5, 5*SZREG(sp)
+	REG_L	t6, 5*SZREG(sp)
 
 	REG_L	s0, 6*SZREG(sp)
 	REG_L	ra, 7*SZREG(sp)
diff --git a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
index 02e562f56f9d..5b92da2ab75c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
+++ b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
@@ -11,7 +11,7 @@ __jited("	addq	%gs:{{.*}}, %rax")
 __arch_arm64
 __jited("	mrs	x8, SP_EL0")
 __arch_riscv64
-__jited("	mv	a5, tp")
+__jited("	mv	t6, tp")
 __arch_loongarch
 __jited("	move	$a5, $tp")
 int inline_bpf_get_current_task(void)
diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
index 7e25e1b8cd0b..49e8cd4bb4f9 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
@@ -289,11 +289,11 @@ __jited("ldrsh	x22, [x11, #0x18]")
 __jited("add	x11, x0, x28")
 __jited("ldrsb	x22, [x11, #0x20]")
 __arch_riscv64
-__jited("add	t2, a5, s7")
+__jited("add	t2, t6, s7")
 __jited("lw	s3, 0x10(t2)")
-__jited("add	t2, a5, s7")
+__jited("add	t2, t6, s7")
 __jited("lh	s3, 0x18(t2)")
-__jited("add	t2, a5, s7")
+__jited("add	t2, t6, s7")
 __jited("lb	s3, 0x20(t2)")
 __jited("add	t2, a0, s7")
 __jited("lw	s4, 0x10(t2)")
-- 
2.34.1

