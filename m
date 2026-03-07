Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D5C33B97A;
	Sat,  7 Mar 2026 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772878401; cv=none; b=UVhpA3v8YZsPqPoTFGv2ANvtNWzo7HrLnblJJayHC8NzFkBhj2V3QIRpJedFeUfDrX6xBo2EFsJKkRCBO81aeLzP5iTwkUQRQU8LCbX//GPObJFQd912uNDIWZnuOmtAkpzFDGlJPGihttGo3ehYq6gOwAFBHWJcOurOufkQxfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772878401; c=relaxed/simple;
	bh=C+cyOdGto3DPCASigzcJt1lYNK3PWODOUHnHd9zDpGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/F6339YW7c5LidXhso1k8xlK/HkCSNJTHUkE3Bc4QzjVlYFYnNV7tiLn8g6NpoHIcbnqUFyTvT+y/5gTzc9AKUSMCcorFVH8u6ktKAVuQEObzvi1qEyMWlDfikEnHb+WQdhHmVpvbb50n9pgtRMH/tTj+CrEMfHOb4DsawMfl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fSfGy4LcBzKHMYf;
	Sat,  7 Mar 2026 18:12:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0EDDA4056E;
	Sat,  7 Mar 2026 18:13:09 +0800 (CST)
Received: from k01.k01 (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgCngEsw+qtppX4jAA--.3809S6;
	Sat, 07 Mar 2026 18:13:08 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Shahab Vahedi <list+bpf@vahedi.org>,
	Russell King <linux@armlinux.org.uk>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Johan Almbladh <johan.almbladh@anyfinetworks.com>,
	Paul Burton <paulburton@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>,
	Xi Wang <xi.wang@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Wang YanQing <udknight@gmail.com>
Subject: [bpf-next v7 4/5] bpf, x86: Emit ENDBR for indirect jump targets
Date: Sat,  7 Mar 2026 18:39:48 +0800
Message-ID: <20260307103949.2340104-5-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307103949.2340104-1-xukuohai@huaweicloud.com>
References: <20260307103949.2340104-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCngEsw+qtppX4jAA--.3809S6
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4DXF1DAFW8Gr1UJFWUArb_yoWrCry8pa
	9xA3sIvr45Wws0gF1kXF42yryayF4vgFyxGr4rt3yruw42gr95WF1Yka4SqFyYkrWrCrs7
	XFyjkr1Du3WkurDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

On CPUs that support CET/IBT, the indirect jump selftest triggers
a kernel panic because the indirect jump targets lack ENDBR
instructions.

To fix it, emit an ENDBR instruction to each indirect jump target. Since
the ENDBR instruction shifts the position of original jited instructions,
fix the instruction address calculation wherever the addresses are used.

For reference, below is a sample panic log.

 Missing ENDBR: bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x97/0xe1
 ------------[ cut here ]------------
 kernel BUG at arch/x86/kernel/cet.c:133!
 Oops: invalid opcode: 0000 [#1] SMP NOPTI

 ...

  ? 0xffffffffc00fb258
  ? bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x97/0xe1
  bpf_prog_test_run_syscall+0x110/0x2f0
  ? fdget+0xba/0xe0
  __sys_bpf+0xe4b/0x2590
  ? __kmalloc_node_track_caller_noprof+0x1c7/0x680
  ? bpf_prog_test_run_syscall+0x215/0x2f0
  __x64_sys_bpf+0x21/0x30
  do_syscall_64+0x85/0x620
  ? bpf_prog_test_run_syscall+0x1e2/0x2f0

Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/x86/net/bpf_jit_comp.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 2c57ee446fc9..f05ce59bc785 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1658,8 +1658,8 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
 	return 0;
 }
 
-static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
-		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
+static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *addrs, u8 *image,
+		  u8 *rw_image, int oldproglen, struct jit_context *ctx, bool jmp_padding)
 {
 	bool tail_call_reachable = bpf_prog->aux->tail_call_reachable;
 	struct bpf_insn *insn = bpf_prog->insnsi;
@@ -1672,7 +1672,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 	void __percpu *priv_stack_ptr;
 	int i, excnt = 0;
 	int ilen, proglen = 0;
-	u8 *prog = temp;
+	u8 *ip, *prog = temp;
 	u32 stack_depth;
 	int err;
 
@@ -1743,6 +1743,13 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 				dst_reg = X86_REG_R9;
 		}
 
+#ifdef CONFIG_X86_KERNEL_IBT
+		if (bpf_insn_is_indirect_target(env, bpf_prog, i - 1))
+			EMIT_ENDBR();
+#endif
+
+		ip = image + addrs[i - 1] + (prog - temp);
+
 		switch (insn->code) {
 			/* ALU */
 		case BPF_ALU | BPF_ADD | BPF_X:
@@ -2449,8 +2456,6 @@ st:			if (is_imm8(insn->off))
 
 			/* call */
 		case BPF_JMP | BPF_CALL: {
-			u8 *ip = image + addrs[i - 1];
-
 			func = (u8 *) __bpf_call_base + imm32;
 			if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
 				LOAD_TAIL_CALL_CNT_PTR(stack_depth);
@@ -2474,7 +2479,8 @@ st:			if (is_imm8(insn->off))
 			if (imm32)
 				emit_bpf_tail_call_direct(bpf_prog,
 							  &bpf_prog->aux->poke_tab[imm32 - 1],
-							  &prog, image + addrs[i - 1],
+							  &prog,
+							  ip,
 							  callee_regs_used,
 							  stack_depth,
 							  ctx);
@@ -2483,7 +2489,7 @@ st:			if (is_imm8(insn->off))
 							    &prog,
 							    callee_regs_used,
 							    stack_depth,
-							    image + addrs[i - 1],
+							    ip,
 							    ctx);
 			break;
 
@@ -2648,7 +2654,7 @@ st:			if (is_imm8(insn->off))
 			break;
 
 		case BPF_JMP | BPF_JA | BPF_X:
-			emit_indirect_jump(&prog, insn->dst_reg, image + addrs[i - 1]);
+			emit_indirect_jump(&prog, insn->dst_reg, ip);
 			break;
 		case BPF_JMP | BPF_JA:
 		case BPF_JMP32 | BPF_JA:
@@ -2738,8 +2744,6 @@ st:			if (is_imm8(insn->off))
 			ctx->cleanup_addr = proglen;
 			if (bpf_prog_was_classic(bpf_prog) &&
 			    !ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {
-				u8 *ip = image + addrs[i - 1];
-
 				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
 					return -EINVAL;
 			}
@@ -3800,7 +3804,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	for (pass = 0; pass < MAX_PASSES || image; pass++) {
 		if (!padding && pass >= PADDING_PASSES)
 			padding = true;
-		proglen = do_jit(prog, addrs, image, rw_image, oldproglen, &ctx, padding);
+		proglen = do_jit(env, prog, addrs, image, rw_image, oldproglen, &ctx, padding);
 		if (proglen <= 0) {
 out_image:
 			image = NULL;
-- 
2.47.3

