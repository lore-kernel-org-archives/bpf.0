Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81AB17753
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 02:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712285750; cv=none; b=SUbXPj60WXM6CT3DZju4lSOha+nmb7wvIsVZCJn2BBU59gpaPvB6iMy0asHE/cpRiJyCTgx6a9xaVXZC37hVmrt+6Ifwpu2ckxxmMGZkIlzOK3oW5Om8S+qO7ElX3P7xvDRI8Cv9kciQoeSL67hqCVubM3UCz3EZBkUHYVxXieE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712285750; c=relaxed/simple;
	bh=DvceODhaB1tHxNm1FpKmm7uZl7DWIick8vdGWbSX3TM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tF0XDFSNULqw0nYotJKL+nMifCiw29etvkHH/4IB9/HVCLlfRKXC44rWCJYXtkQnD17rb2wS4eHfk28+hN0sx3SXZ48wTrvQ4Dqg25qy60K5CIegGrEBwWiRrlsNo5c14aHw6LO+b84hr9IP+xdrDX431fvR6csLCvZNk9Mo9l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CrTQMPLz; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CrTQMPLz"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712285739; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=LxZt5tXjRsxx8gQM1cIxMsxJfZueZZ+jKFSqpAwuYuI=;
	b=CrTQMPLzcy9u68gGel+HK7qV3Eys9PjCCaRSA4JDSJxC8JWPHNwfMZ3cqAFBUJ6817M6ovg28ryEJc6VtXMe5nQQcECuVDk3JmhLNYbb+UGvmwpziTyZu82sJAXvYPY0Um+yIzyBBoT6s8yvXZSmt8HVjbHjvpFEU1eVA5Hmk/A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W3vouyG_1712285738;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W3vouyG_1712285738)
          by smtp.aliyun-inc.com;
          Fri, 05 Apr 2024 10:55:39 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	xuanzhuo@linux.alibaba.com
Subject: [PATCH bpf-next v1 1/3] bpf: store both map ptr and state in bpf_insn_aux_data
Date: Fri,  5 Apr 2024 10:55:34 +0800
Message-Id: <20240405025536.18113-2-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240405025536.18113-1-lulie@linux.alibaba.com>
References: <20240405025536.18113-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, bpf_insn_aux_data->map_ptr_state is used to store either
map_ptr or its poison state (i.e., BPF_MAP_PTR_POISON). Thus
BPF_MAP_PTR_POISON must be checked before reading map_ptr. In certain
cases, we may need valid map_ptr even in case of poison state.
This will be explained in next patch with bpf_for_each_map_elem()
helper.

This patch changes map_ptr_state into a new struct including both map
pointer and its state (poison/unpriv). It's in the same union with
struct bpf_loop_inline_state, so there is no extra memory overhead.
Besides, macros BPF_MAP_PTR_UNPRIV/BPF_MAP_PTR_POISON/BPF_MAP_PTR are no
longer needed.

This patch does not change any existing functionality.

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 include/linux/bpf_verifier.h |  9 ++++++++-
 kernel/bpf/verifier.c        | 36 ++++++++++++++++--------------------
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7cb1b75eee38..36d19cd32eb5 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -502,6 +502,13 @@ struct bpf_loop_inline_state {
 	u32 callback_subprogno; /* valid when fit_for_inline is true */
 };
 
+/* pointer and state for maps */
+struct bpf_map_ptr_state {
+	struct bpf_map *map_ptr;
+	bool poison;
+	bool unpriv;
+};
+
 /* Possible states for alu_state member. */
 #define BPF_ALU_SANITIZE_SRC		(1U << 0)
 #define BPF_ALU_SANITIZE_DST		(1U << 1)
@@ -514,7 +521,7 @@ struct bpf_loop_inline_state {
 struct bpf_insn_aux_data {
 	union {
 		enum bpf_reg_type ptr_type;	/* pointer type for load/store insns */
-		unsigned long map_ptr_state;	/* pointer/poison value for maps */
+		struct bpf_map_ptr_state map_ptr_state;
 		s32 call_imm;			/* saved imm field of call insn */
 		u32 alu_limit;			/* limit for add/sub register with pointer */
 		struct {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index edb650667f44..7f95a186e636 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -190,11 +190,6 @@ struct bpf_verifier_stack_elem {
 #define BPF_MAP_KEY_POISON	(1ULL << 63)
 #define BPF_MAP_KEY_SEEN	(1ULL << 62)
 
-#define BPF_MAP_PTR_UNPRIV	1UL
-#define BPF_MAP_PTR_POISON	((void *)((0xeB9FUL << 1) +	\
-					  POISON_POINTER_DELTA))
-#define BPF_MAP_PTR(X)		((struct bpf_map *)((X) & ~BPF_MAP_PTR_UNPRIV))
-
 #define BPF_GLOBAL_PERCPU_MA_MAX_SIZE  512
 
 static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx);
@@ -209,21 +204,22 @@ static bool is_trusted_reg(const struct bpf_reg_state *reg);
 
 static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
 {
-	return BPF_MAP_PTR(aux->map_ptr_state) == BPF_MAP_PTR_POISON;
+	return aux->map_ptr_state.poison;
 }
 
 static bool bpf_map_ptr_unpriv(const struct bpf_insn_aux_data *aux)
 {
-	return aux->map_ptr_state & BPF_MAP_PTR_UNPRIV;
+	return aux->map_ptr_state.unpriv;
 }
 
 static void bpf_map_ptr_store(struct bpf_insn_aux_data *aux,
-			      const struct bpf_map *map, bool unpriv)
+			      struct bpf_map *map,
+			      bool unpriv, bool poison)
 {
-	BUILD_BUG_ON((unsigned long)BPF_MAP_PTR_POISON & BPF_MAP_PTR_UNPRIV);
 	unpriv |= bpf_map_ptr_unpriv(aux);
-	aux->map_ptr_state = (unsigned long)map |
-			     (unpriv ? BPF_MAP_PTR_UNPRIV : 0UL);
+	aux->map_ptr_state.unpriv = unpriv;
+	aux->map_ptr_state.poison = poison;
+	aux->map_ptr_state.map_ptr = map;
 }
 
 static bool bpf_map_key_poisoned(const struct bpf_insn_aux_data *aux)
@@ -9658,7 +9654,7 @@ static int set_map_elem_callback_state(struct bpf_verifier_env *env,
 		return -EINVAL;
 	}
 
-	map = BPF_MAP_PTR(insn_aux->map_ptr_state);
+	map = insn_aux->map_ptr_state.map_ptr;
 	if (!map->ops->map_set_for_each_callback_args ||
 	    !map->ops->map_for_each_callback) {
 		verbose(env, "callback function not allowed for map\n");
@@ -10017,12 +10013,12 @@ record_func_map(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		return -EACCES;
 	}
 
-	if (!BPF_MAP_PTR(aux->map_ptr_state))
+	if (!aux->map_ptr_state.map_ptr)
+		bpf_map_ptr_store(aux, meta->map_ptr,
+				  !meta->map_ptr->bypass_spec_v1, false);
+	else if (aux->map_ptr_state.map_ptr != meta->map_ptr)
 		bpf_map_ptr_store(aux, meta->map_ptr,
-				  !meta->map_ptr->bypass_spec_v1);
-	else if (BPF_MAP_PTR(aux->map_ptr_state) != meta->map_ptr)
-		bpf_map_ptr_store(aux, BPF_MAP_PTR_POISON,
-				  !meta->map_ptr->bypass_spec_v1);
+				  !meta->map_ptr->bypass_spec_v1, true);
 	return 0;
 }
 
@@ -19829,7 +19825,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			    !bpf_map_ptr_unpriv(aux)) {
 				struct bpf_jit_poke_descriptor desc = {
 					.reason = BPF_POKE_REASON_TAIL_CALL,
-					.tail_call.map = BPF_MAP_PTR(aux->map_ptr_state),
+					.tail_call.map = aux->map_ptr_state.map_ptr,
 					.tail_call.key = bpf_map_key_immediate(aux),
 					.insn_idx = i + delta,
 				};
@@ -19858,7 +19854,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 				return -EINVAL;
 			}
 
-			map_ptr = BPF_MAP_PTR(aux->map_ptr_state);
+			map_ptr = aux->map_ptr_state.map_ptr;
 			insn_buf[0] = BPF_JMP_IMM(BPF_JGE, BPF_REG_3,
 						  map_ptr->max_entries, 2);
 			insn_buf[1] = BPF_ALU32_IMM(BPF_AND, BPF_REG_3,
@@ -19966,7 +19962,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			if (bpf_map_ptr_poisoned(aux))
 				goto patch_call_imm;
 
-			map_ptr = BPF_MAP_PTR(aux->map_ptr_state);
+			map_ptr = aux->map_ptr_state.map_ptr;
 			ops = map_ptr->ops;
 			if (insn->imm == BPF_FUNC_map_lookup_elem &&
 			    ops->map_gen_lookup) {
-- 
2.32.0.3.g01195cf9f

