Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCA718EA8
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 06:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712038589; cv=none; b=iEUqXyWTdFueNb1P0903uDZtdwW1kL1sthw3TEDSykrvtlBqnIXnKCEn8Xl4vc1taUotHerYwIoiCG+527nl/Pgogz6l4ds+QwuDS+nIfzR0052knD6NAWRo2VR2nzcv4QrkfdDBkjujwbdEAXsjfgJwrPAotw28DD88SOe/6gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712038589; c=relaxed/simple;
	bh=deN3UNCmfW+foWvNZo+ofJMPvUUHLpo1UwYwi7pCRUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SKgbPgawKd312qIKa+EvsPTI0UxA6KLo7Vq61KlsS3o7NAtYtYbNrkG+Nan0gemOfRhK6bERsFf1fiPaAYdp8Gys2hZyumGljfrfNtEUFpU76TMfy2pWDeXFrtLqV78xjg5SVhoFYSnbxP356lvO0lGHKZkvxupFU7xKKxtgVe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Gz3wH+tg; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Gz3wH+tg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712038577; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=PQ3BYGiy0zy9vbPw8iOelIQli0W4ah04yMYaimLIaiE=;
	b=Gz3wH+tgChWI8GYiGbrHM2eALuMyXZ5q2y3KKPPsD6cjeGNLbUM+YP0iiYU3fr4XLPFmCLzob3mkOQiKsc3OL6ZnVjcZRxeWPtvFe9b5bmgl7MckGO/QWBNXa/fCyujHfysXQY6ckeQIH6sl/aocGlH0zlmC9Jpkrs1BGHxGTxQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W3nLkVa_1712038576;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W3nLkVa_1712038576)
          by smtp.aliyun-inc.com;
          Tue, 02 Apr 2024 14:16:17 +0800
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
Subject: [PATCH bpf-next 1/3] bpf: store both map ptr and state in bpf_insn_aux_data
Date: Tue,  2 Apr 2024 14:16:13 +0800
Message-Id: <20240402061615.48894-2-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240402061615.48894-1-lulie@linux.alibaba.com>
References: <20240402061615.48894-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, bpf_insn_aux_data->map_ptr_state is used to store either
map_ptr or its poison state (i.e., BPF_MAP_PTR_POISON). Thus
BPF_MAP_PTR_POISON must be checked before reading map_ptr. However we do
need both of them sometimes, e.g., in bpf_for_each_map_elem() helper ().

This patch changes map_ptr_state into a new struct including both map
pointer and its state (poison/unpriv). It's in the same union with
struct bpf_loop_inline_state, so there is no extra memory overhead.
Besides, macros BPF_MAP_PTR_UNPRIV/BPF_MAP_PTR_POISON/BPF_MAP_PTR are no
longer needed.

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 include/linux/bpf_verifier.h |  9 ++++++++-
 kernel/bpf/verifier.c        | 36 ++++++++++++++++--------------------
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7cb1b75eee38..1b5d6c7bb4e0 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -502,6 +502,13 @@ struct bpf_loop_inline_state {
 	u32 callback_subprogno; /* valid when fit_for_inline is true */
 };
 
+/* pointer and state for maps */
+struct bpf_map_ptr_state {
+	struct bpf_map *map_ptr;
+	unsigned int poison:1;
+	unsigned int unpriv:1;
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
index edb650667f44..515ac6165ab1 100644
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
+	return !!aux->map_ptr_state.poison;
 }
 
 static bool bpf_map_ptr_unpriv(const struct bpf_insn_aux_data *aux)
 {
-	return aux->map_ptr_state & BPF_MAP_PTR_UNPRIV;
+	return !!aux->map_ptr_state.unpriv;
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

