Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9371A2D592C;
	Sat, 11 Apr 2026 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775916041; cv=none; b=o9vncsrG59ORLMuPKTCrMUlP/cEQMHqYmDwT5lZ6HTzCNruT5YfMwQjz3O5XJFSbSwpSHY+iGmSjxG22Ek70x1qQ9RAhxts/Zrvw/XOGKRYg79gbpzXXAWAD+naTECYnIdzWu4Jf1T134uOxVhYi6sjwkO2Z9oXhD6mKhEYJlH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775916041; c=relaxed/simple;
	bh=EwOprtutf7ipZKue5mhORGosQjkf3Jumuaxl6zf7nFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXC9GoaFPWJAQ4AVckr3B78UWpb5/74t74JtY5ZVfo+cxLiKxe14wP5T9oxG+z0ZPZhH5OCaa4eKg9d7N75pA0DAzsr3SFdeiVET9BZn9uFeuIyamBZMu4vIxDg0ocOyTN+Badtt1UBgQvC8az6uxmcchg67S3c0NDIFY5HwnTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ftFfV66jtzYQtvB;
	Sat, 11 Apr 2026 21:59:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2C27740574;
	Sat, 11 Apr 2026 22:00:26 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP1 (Coremail) with SMTP id cCh0CgBnDAfzU9ppvMQhAA--.23008S5;
	Sat, 11 Apr 2026 22:00:25 +0800 (CST)
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
Subject: [PATCH bpf-next v13 3/5] bpf: Add helper to detect indirect jump targets
Date: Sat, 11 Apr 2026 13:38:45 +0000
Message-ID: <20260411133847.1042658-4-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411133847.1042658-1-xukuohai@huaweicloud.com>
References: <20260411133847.1042658-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnDAfzU9ppvMQhAA--.23008S5
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWDGF4UZF17XF47Gw4fuFg_yoW7Jw4kpF
	4kW3s3AF4kZFZrur9rAa12yry3Ja1rW345CFWxC348AayYqr1vqFWFgryYvF95trZ5C3Wx
	ZF4qvr48WryUZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
 kernel/bpf/verifier.c        | 18 ++++++++++++++++++
 4 files changed, 34 insertions(+), 4 deletions(-)

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
index 05b9fe98b8f8..cebeb4b4cbc7 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -628,16 +628,17 @@ struct bpf_insn_aux_data {
 
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
index bd96b3a01b99..325f5379a3ca 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1572,6 +1572,15 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bp
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
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dd6dbd41b06d..dd8949874d1b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4100,6 +4100,11 @@ static bool is_jmp_point(struct bpf_verifier_env *env, int insn_idx)
 	return env->insn_aux_data[insn_idx].jmp_point;
 }
 
+static void mark_indirect_target(struct bpf_verifier_env *env, int idx)
+{
+	env->insn_aux_data[idx].indirect_target = true;
+}
+
 #define LR_FRAMENO_BITS	3
 #define LR_SPI_BITS	6
 #define LR_ENTRY_BITS	(LR_SPI_BITS + LR_FRAMENO_BITS + 1)
@@ -21595,12 +21600,14 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
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
 	return 0;
 }
 
@@ -22544,6 +22551,17 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
 		data[i].seen = old_seen;
 		data[i].zext_dst = insn_has_def32(insn + i);
 	}
+
+	/* The indirect_target flag of the original instruction was moved to the last of the
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
-- 
2.43.0

