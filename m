Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA47F395D8E;
	Mon,  2 Mar 2026 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772445718; cv=none; b=O9WmSb8XtlZC3tDywI/BTwIEBPXNGM+a9tc3yW09SqDdp35wrlWKL2vIcolkjdHgjp+C1ZgLq3Nte7e648yp9d7U6tsitwGwgfG+5e1zmFKlLf8U8fU/aD8A79cMbXvsI2FmaEOnm+AchgfKpwZvggtwqUX0el0fD4bJs9Ooyw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772445718; c=relaxed/simple;
	bh=IECB0xNEatG8TMaTVovvUAwsZTsiJR4ddeNASkbq11Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKhY31cRJ5AB8+V/xiyS2RazB7JfamqRu+aauShmP1T9Otudem2rlqjExoTEihoAWE22vrZAIAto4cm7+Z1O500g66aEr8vywlOJVU2yWemRVf7993fugUcaJeYJzgpGdHiuhguHk89Li3ainU75HdI4Z6ljcKdZd1CCHvtPhZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fPZFn4KgvzYQv9Z;
	Mon,  2 Mar 2026 18:01:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9383A40571;
	Mon,  2 Mar 2026 18:01:49 +0800 (CST)
Received: from k01.k01 (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgCXQvMKYKVpfu0vJQ--.22492S5;
	Mon, 02 Mar 2026 18:01:49 +0800 (CST)
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
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next v5 3/5] bpf: Add helper to detect indirect jump targets
Date: Mon,  2 Mar 2026 18:27:24 +0800
Message-ID: <20260302102726.1126019-4-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302102726.1126019-1-xukuohai@huaweicloud.com>
References: <20260302102726.1126019-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXQvMKYKVpfu0vJQ--.22492S5
X-Coremail-Antispam: 1UD129KBjvJXoWxKw1Uuw4rKw13KF1xAr1UWrg_yoWxCw4kpF
	4DX3s3Ar48JanrWrnrAF48Aryaqa1rW39rGay7W348A3yjgrn5WF4Fgr4FvF98trW0kF1x
	ZF4j9r45Wry7ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFylc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
	vfC2KfnxnUUI43ZEXa7IU8D5r7UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Introduce helper bpf_insn_is_indirect_target to determine whether a BPF
instruction is an indirect jump target. This helper will be used by
follow-up patches to decide where to emit indirect landing pad instructions.

Add a new flag to struct bpf_insn_aux_data to mark instructions that are
indirect jump targets. The BPF verifier sets this flag, and the helper
checks it to determine whether an instruction is an indirect jump target.

Also add a new field to struct bpf_insn_aux_data to track the instruction
final index in the bpf prog, as the instructions may be rewritten by
constant blinding in the JIT stage. This field is used as a binary search
key to find the corresponding insn_aux_data for a given instruction.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/linux/bpf.h          |  2 ++
 include/linux/bpf_verifier.h | 10 ++++++----
 kernel/bpf/core.c            | 38 +++++++++++++++++++++++++++++++++---
 kernel/bpf/verifier.c        | 13 +++++++++++-
 4 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 05b34a6355b0..90760e250865 100644
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
index c1e30096ea7b..f8f70e5414f0 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -577,16 +577,18 @@ struct bpf_insn_aux_data {
 
 	/* below fields are initialized once */
 	unsigned int orig_idx; /* original instruction index */
-	bool jmp_point;
-	bool prune_point;
+	unsigned int final_idx; /* final instruction index */
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
index 7702c232c62e..9a760cf43d68 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1486,13 +1486,41 @@ static void adjust_insn_arrays(struct bpf_prog *prog, u32 off, u32 len)
 #endif
 }
 
+static int bpf_insn_aux_cmp_by_insn_idx(const void *a, const void *b)
+{
+	int insn_idx = *(int *)a;
+	int final_idx = ((const struct bpf_insn_aux_data *)b)->final_idx;
+
+	return insn_idx - final_idx;
+}
+
+bool bpf_insn_is_indirect_target(const struct bpf_verifier_env *env, const struct bpf_prog *prog,
+				 int insn_idx)
+{
+	struct bpf_insn_aux_data *insn_aux;
+	int func_idx, subprog_start, subprog_end;
+
+	if (!env)
+		return false;
+
+	func_idx = prog->aux->func_idx;
+	subprog_start = env->subprog_info[func_idx].start;
+	subprog_end = env->subprog_info[func_idx + 1].start;
+
+	insn_aux = bsearch(&insn_idx, &env->insn_aux_data[subprog_start],
+			   subprog_end - subprog_start,
+			   sizeof(struct bpf_insn_aux_data), bpf_insn_aux_cmp_by_insn_idx);
+
+	return insn_aux && insn_aux->indirect_target;
+}
+
 struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	struct bpf_insn insn_buff[16], aux[2];
 	struct bpf_prog *clone, *tmp;
-	int insn_delta, insn_cnt;
+	int insn_delta, insn_cnt, subprog_start;
 	struct bpf_insn *insn;
-	int i, rewritten;
+	int i, j, rewritten;
 
 	if (!prog->blinding_requested || prog->blinded)
 		return prog;
@@ -1503,8 +1531,10 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bp
 
 	insn_cnt = clone->len;
 	insn = clone->insnsi;
+	subprog_start = env->subprog_info[prog->aux->func_idx].start;
 
-	for (i = 0; i < insn_cnt; i++, insn++) {
+	for (i = 0, j = 0; i < insn_cnt; i++, j++, insn++) {
+		env->insn_aux_data[subprog_start + j].final_idx = i;
 		if (bpf_pseudo_func(insn)) {
 			/* ld_imm64 with an address of bpf subprog is not
 			 * a user controlled constant. Don't randomize it,
@@ -1512,6 +1542,8 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bp
 			 */
 			insn++;
 			i++;
+			j++;
+			env->insn_aux_data[subprog_start + j].final_idx = i;
 			continue;
 		}
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1d2d42078ddf..5f08d521e58a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3971,6 +3971,11 @@ static bool is_jmp_point(struct bpf_verifier_env *env, int insn_idx)
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
@@ -20943,12 +20948,14 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
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
 
@@ -22817,6 +22824,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		num_exentries = 0;
 		insn = func[i]->insnsi;
 		for (j = 0; j < func[i]->len; j++, insn++) {
+			env->insn_aux_data[subprog_start + j].final_idx = j;
 			if (BPF_CLASS(insn->code) == BPF_LDX &&
 			    (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
 			     BPF_MODE(insn->code) == BPF_PROBE_MEM32 ||
@@ -26088,8 +26096,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 
 	/* constants blinding in the JIT may increase prog->len */
 	len = env->prog->len;
-	if (env->subprog_cnt == 1)
+	if (env->subprog_cnt == 1) {
+		for (i = 0; i < len; i++)
+			env->insn_aux_data[i].final_idx = i;
 		env->prog = bpf_prog_select_jit(env, env->prog, &ret);
+	}
 
 	adjust_btf_func(env);
 
-- 
2.47.3

