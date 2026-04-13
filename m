Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853D13CA4BF;
	Mon, 13 Apr 2026 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776085598; cv=none; b=kVFDJALnGUU1CF0LC2o0aBi82rraaC7RyWMmE06S2R5oS8SkOqPnQarCFQAqdesbexeie1QED6Zv1AwLLtBXRv2uSQg44VhdTVO0y6uVR5Wp7ZnD75BTFQ1BHLYh2FemGmjIVty0Mwj7C+phxixiL+YKmTK5qfCnNvFQL4XJow0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776085598; c=relaxed/simple;
	bh=T6uYRdIiuLgP9oPnstEcNACJEeZzPvUZW07HC1rP5d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpMRHS9oXNElwewz4JxqGtzzbEKGryjUOp7qgSduHdvVcpmEQeKknzHow9mPNvZP6sJ96iTct0V+0F/P1WxOVGUxv6ZRK8S4TlXg4qf7AsbjvaRTqVvMU8dQ5iIOhf4lXdZDe5iXK8l6hyDjUy1HIS4fe0GlRvRddzASx9vzw1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fvSN150lxzKHMS9;
	Mon, 13 Apr 2026 21:06:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4087C4058C;
	Mon, 13 Apr 2026 21:06:32 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP4 (Coremail) with SMTP id gCh0CgA3Ib9U6txpI8MQAQ--.65519S5;
	Mon, 13 Apr 2026 21:06:31 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
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
Subject: [PATCH bpf-next v14 3/5] bpf: Add helper to detect indirect jump targets
Date: Mon, 13 Apr 2026 12:45:00 +0000
Message-ID: <02230fcf318eff0d60857a2887f1138e99893de6.1776062885.git.xukuohai@hotmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1776062885.git.xukuohai@hotmail.com>
References: <cover.1776062885.git.xukuohai@hotmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3Ib9U6txpI8MQAQ--.65519S5
X-Coremail-Antispam: 1UD129KBjvJXoW3WF1rWFy5Ary3Ar1xCFyDJrb_yoW7XFW5pF
	4DWF93AF4vvFZrur9rAa10yry3Ja1rW3y3CFWxC348ta1Yqr1vqFWFgr1avFn5trZ8C3Wx
	ZFs0vr4jg34UZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU
	IF4iUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Introduce helper bpf_insn_is_indirect_target to check whether a BPF
instruction is an indirect jump target.

Since the verifier knows which instructions are indirect jump targets,
add a new flag indirect_target to struct bpf_insn_aux_data to mark
them. The verifier sets this flag when verifying an indirect jump target
instruction, and the helper checks the flag to determine whether an
instruction is an indirect jump target.

Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com> #v8
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com> #v12
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/linux/bpf.h          |  2 ++
 include/linux/bpf_verifier.h |  9 +++++----
 kernel/bpf/core.c            |  9 +++++++++
 kernel/bpf/fixups.c          | 12 ++++++++++++
 kernel/bpf/verifier.c        |  7 +++++++
 5 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0136a108d083..b4b703c90ca9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1541,6 +1541,8 @@ bool bpf_has_frame_pointer(unsigned long ip);
 int bpf_jit_charge_modmem(u32 size);
 void bpf_jit_uncharge_modmem(u32 size);
 bool bpf_prog_has_trampoline(const struct bpf_prog *prog);
+bool bpf_insn_is_indirect_target(const struct bpf_verifier_env *env, const struct bpf_prog *prog,
+				 int insn_idx);
 #else
 static inline int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 					   struct bpf_trampoline *tr,
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 53e8664cb566..b148f816f25b 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -630,16 +630,17 @@ struct bpf_insn_aux_data {
 
 	/* below fields are initialized once */
 	unsigned int orig_idx; /* original instruction index */
-	bool jmp_point;
-	bool prune_point;
+	u32 jmp_point:1;
+	u32 prune_point:1;
 	/* ensure we check state equivalence and save state checkpoint and
 	 * this instruction, regardless of any heuristics
 	 */
-	bool force_checkpoint;
+	u32 force_checkpoint:1;
 	/* true if instruction is a call to a helper function that
 	 * accepts callback function as a parameter.
 	 */
-	bool calls_callback;
+	u32 calls_callback:1;
+	u32 indirect_target:1; /* if it is an indirect jump target */
 	/*
 	 * CFG strongly connected component this instruction belongs to,
 	 * zero if it is a singleton SCC.
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 79361aa11757..8b018ff48875 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1573,6 +1573,15 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bp
 	clone->blinded = 1;
 	return clone;
 }
+
+bool bpf_insn_is_indirect_target(const struct bpf_verifier_env *env, const struct bpf_prog *prog,
+				 int insn_idx)
+{
+	if (!env)
+		return false;
+	insn_idx += prog->aux->subprog_start;
+	return env->insn_aux_data[insn_idx].indirect_target;
+}
 #endif /* CONFIG_BPF_JIT */
 
 /* Base function for offset calculation. Needs to go into .text section,
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 6ef213429a2a..67f14e24d7d7 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -183,6 +183,18 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
 		data[i].seen = old_seen;
 		data[i].zext_dst = insn_has_def32(insn + i);
 	}
+
+	/*
+	 * The indirect_target flag of the original instruction was moved to the last of the
+	 * new instructions by the above memmove and memset, but the indirect jump target is
+	 * actually the first instruction, so move it back. This also matches with the behavior
+	 * of bpf_insn_array_adjust(), which preserves xlated_off to point to the first new
+	 * instruction.
+	 */
+	if (data[off + cnt - 1].indirect_target) {
+		data[off].indirect_target = 1;
+		data[off + cnt - 1].indirect_target = 0;
+	}
 }
 
 static void adjust_subprog_starts(struct bpf_verifier_env *env, u32 off, u32 len)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e804e0da3500..1e36b9e91277 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3497,6 +3497,11 @@ static int insn_stack_access_flags(int frameno, int spi)
 	return INSN_F_STACK_ACCESS | (spi << INSN_F_SPI_SHIFT) | frameno;
 }
 
+static void mark_indirect_target(struct bpf_verifier_env *env, int idx)
+{
+	env->insn_aux_data[idx].indirect_target = true;
+}
+
 #define LR_FRAMENO_BITS	3
 #define LR_SPI_BITS	6
 #define LR_ENTRY_BITS	(LR_SPI_BITS + LR_FRAMENO_BITS + 1)
@@ -17545,12 +17550,14 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
 	}
 
 	for (i = 0; i < n - 1; i++) {
+		mark_indirect_target(env, env->gotox_tmp_buf->items[i]);
 		other_branch = push_stack(env, env->gotox_tmp_buf->items[i],
 					  env->insn_idx, env->cur_state->speculative);
 		if (IS_ERR(other_branch))
 			return PTR_ERR(other_branch);
 	}
 	env->insn_idx = env->gotox_tmp_buf->items[n-1];
+	mark_indirect_target(env, env->insn_idx);
 	return INSN_IDX_UPDATED;
 }
 
-- 
2.47.3

