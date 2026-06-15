Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BFA30CDA2;
	Mon, 15 Jun 2026 17:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781545791; cv=none; b=IunM5Nu5sYa2Lyvo/AjA71Fri5MR03tm/NZooBEbehU9aQUPxVPDN43cxmP5e82ey5ytYoInnF24uXHtd6eCnbCnuQ//ahh5wNi7pSwqBN/s120GUvjzJtUmHaryJWQfVU847vHZswKlUa8f2y84kyCiZMYlrJFaibTBTDRQ2cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781545791; c=relaxed/simple;
	bh=r8IS1CyJ1fWTJf6mIS9MHDip7vdh1JOobUlAY04hOz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LQsjnxUuZ7+dOCqnBgKNxUNMTotQJrJkGd0JdXyx0hWS0/GIHzWz83zMVkgnHPhJ6zo6zUJBRv9XRVV1pRZoV8wwGlgM1e/+gzVQRnltJYK3I9LenU64V8F4vAtUZApzrpHrese99uKJiBaMQ9o+Jjry980fa9QU1/ksrB/Oweo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=mGJmcKAA; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="mGJmcKAA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=bpqFGnisxnUjX7MhYENXTFYF0Oe0A8z5Gp
	IoTvE+0+o=; b=mGJmcKAA/5v67703DBsNV5dEn7+UpYIM4RZRC2vkB6e2j96+XN
	vE9LJYW3nfHSP/wpvA0MKHFMD9MplZFA/KBVdgU8cVQaeGejFtIIjvR2ip4r3+/u
	bHV2u2ISQuAoXcIq8O7Q2cejX1oJ2VCcJvIPW1qGcDAc3O5YqmRrVU7PI=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web4 (Coremail) with SMTP id ywQGZQA3SJ0XOzBqCjxLAg--.43171S3;
	Tue, 16 Jun 2026 01:49:23 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: bpf@vger.kernel.org
Cc: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
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
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v5 1/2] bpf: Fix packet pointer invalidation for skb dynptr writes
Date: Mon, 15 Jun 2026 17:49:07 +0000
Message-Id: <fe46367f8e2c2ae81e626e71d200dbfc3e7d644f.1781539814.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781539813.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781535194.git.chenyy23@mails.tsinghua.edu.cn> <cover.1781539813.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQA3SJ0XOzBqCjxLAg--.43171S3
X-Coremail-Antispam: 1UD129KBjvAXoW3Zr1UGw1DtrykGFyDCrykKrg_yoW8AF1Dto
	WxGr4YyFy8Gw1xCw12yr1IkFy5X3yrGr95AF43Wan8uayxGrWYqry7J3y5Wryqgw1aqa1k
	A3WkGa4rXr98Jrs3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOG7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M28IrcIa0x
	kI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84AC
	jcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM2
	8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4U
	JwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
	AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
	IFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_
	GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRLiSJUUUUU=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

skb-backed dynptr writers can mutate packet data, but not all verifier
paths invalidate checked direct packet pointers after those writes.

bpf_dynptr_write() handles skb and skb-meta dynptrs in the normal helper
path, but global subprogram dynptr arguments are verified as
unspecialized local dynptr pointers. Treat such arguments as possibly
packet-backed for packet pointer invalidation.

Carry that possibly-packet-backed state through dynptr clones and dynptr
slices. Otherwise a global subprogram can clone its dynptr argument and
write through the stack clone, or obtain a LOCAL-typed dynptr slice and
write through the original dynptr, without invalidating packet pointers
or slice pointers that may refer to reallocated skb data.

Global subprogram summaries are computed during CFG analysis before
register states exist. Add conservative static CFG predicates for
bpf_dynptr_write() and skb dynptr writer kfuncs so caller-side packet
pointers are invalidated after global calls that may write packet data.

Keep the normal verifier invalidation precise: helpers and kfuncs still
use the checked dynptr argument and only invalidate when the written
dynptr is, or may be, skb-backed. Source-only dynptr arguments remain
unchanged.

Fixes: b5964b968ac6 ("bpf: Add skb dynptrs")
Fixes: daec295a7094 ("bpf/helpers: Introduce bpf_dynptr_copy kfunc")
Fixes: a498ee7576de ("bpf: Implement dynptr copy kfuncs")
Fixes: 5fc5d8fded57 ("bpf: Add bpf_dynptr_memset() kfunc")
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 include/linux/bpf_verifier.h |   6 ++
 include/linux/filter.h       |   5 ++
 kernel/bpf/cfg.c             |   4 +-
 kernel/bpf/states.c          |   2 +
 kernel/bpf/verifier.c        | 145 +++++++++++++++++++++++++++++++----
 5 files changed, 144 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 185b2aa43a420..4ce1f557492a1 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -66,11 +66,13 @@ struct bpf_reg_state {
 		struct { /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
 			u32 mem_size;
 			u32 dynptr_id; /* for dynptr slices */
+			bool dynptr_may_be_pkt_data; /* for dynptr slices */
 		};
 
 		/* For dynptr stack slots */
 		struct {
 			enum bpf_dynptr_type type;
+			bool may_be_pkt_data;
 			/* A dynptr is 16 bytes so it takes up 2 stack slots.
 			 * We need to track which slot is the first slot
 			 * to protect against cases where the user may try to
@@ -1332,6 +1334,7 @@ struct bpf_kfunc_call_arg_meta {
 	u32 ref_obj_id;
 	u8 release_regno;
 	bool r0_rdonly;
+	bool pkt_dynptr_write;
 	u32 ret_btf_id;
 	u64 r0_size;
 	u32 subprogno;
@@ -1365,6 +1368,7 @@ struct bpf_kfunc_call_arg_meta {
 		enum bpf_dynptr_type type;
 		u32 id;
 		u32 ref_obj_id;
+		bool may_be_pkt_data;
 	} initialized_dynptr;
 	struct {
 		u8 spi;
@@ -1389,6 +1393,8 @@ static inline bool bpf_is_kfunc_sleepable(struct bpf_kfunc_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_SLEEPABLE;
 }
+
+bool bpf_kfunc_may_change_pkt_data(struct bpf_kfunc_call_arg_meta *meta);
 bool bpf_is_kfunc_pkt_changing(struct bpf_kfunc_call_arg_meta *meta);
 struct bpf_iarray *bpf_iarray_realloc(struct bpf_iarray *old, size_t n_elem);
 int bpf_copy_insn_array_uniq(struct bpf_map *map, u32 start, u32 end, u32 *off);
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 88a241aac36a2..48485ca84d395 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1172,6 +1172,11 @@ void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp
 u64 arch_bpf_timed_may_goto(void);
 u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *);
 bool bpf_helper_changes_pkt_data(enum bpf_func_id func_id);
+static inline bool bpf_helper_may_change_pkt_data(enum bpf_func_id func_id)
+{
+	return bpf_helper_changes_pkt_data(func_id) ||
+	       func_id == BPF_FUNC_dynptr_write;
+}
 
 static inline bool bpf_dump_raw_ok(const struct cred *cred)
 {
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 26d37066465f3..54a2130f1e465 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -483,7 +483,7 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			 */
 			if (ret == 0 && fp->might_sleep)
 				mark_subprog_might_sleep(env, t);
-			if (bpf_helper_changes_pkt_data(insn->imm))
+			if (bpf_helper_may_change_pkt_data(insn->imm))
 				mark_subprog_changes_pkt_data(env, t);
 			if (insn->imm == BPF_FUNC_tail_call) {
 				ret = visit_abnormal_return_insn(env, t);
@@ -516,7 +516,7 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			 */
 			if (ret == 0 && bpf_is_kfunc_sleepable(&meta))
 				mark_subprog_might_sleep(env, t);
-			if (ret == 0 && bpf_is_kfunc_pkt_changing(&meta))
+			if (ret == 0 && bpf_kfunc_may_change_pkt_data(&meta))
 				mark_subprog_changes_pkt_data(env, t);
 			if (ret == 0 && bpf_is_throw_kfunc(insn))
 				mark_subprog_might_throw(env, t);
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 8478d2c6ed5b6..e9e8cd58bcb53 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -798,6 +798,8 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			old_reg = &old->stack[spi].spilled_ptr;
 			cur_reg = &cur->stack[spi].spilled_ptr;
 			if (old_reg->dynptr.type != cur_reg->dynptr.type ||
+			    old_reg->dynptr.may_be_pkt_data !=
+				    cur_reg->dynptr.may_be_pkt_data ||
 			    old_reg->dynptr.first_slot != cur_reg->dynptr.first_slot ||
 			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap))
 				return false;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7fb88e1cd7c4d..43a1e60cdf80b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -527,8 +527,8 @@ static bool is_spi_bounds_valid(struct bpf_func_state *state, int spi, int nr_sl
        return spi - nr_slots + 1 >= 0 && spi < allocated_slots;
 }
 
-static int stack_slot_obj_get_spi(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-			          const char *obj_kind, int nr_slots)
+static int stack_slot_obj_get_spi(struct bpf_verifier_env *env, const struct bpf_reg_state *reg,
+				  const char *obj_kind, int nr_slots)
 {
 	int off, spi;
 
@@ -554,7 +554,7 @@ static int stack_slot_obj_get_spi(struct bpf_verifier_env *env, struct bpf_reg_s
 	return spi;
 }
 
-static int dynptr_get_spi(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+static int dynptr_get_spi(struct bpf_verifier_env *env, const struct bpf_reg_state *reg)
 {
 	return stack_slot_obj_get_spi(env, reg, "dynptr", BPF_DYNPTR_NR_SLOTS);
 }
@@ -622,12 +622,15 @@ static void __mark_dynptr_reg(struct bpf_reg_state *reg,
 static void mark_dynptr_stack_regs(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *sreg1,
 				   struct bpf_reg_state *sreg2,
-				   enum bpf_dynptr_type type)
+				   enum bpf_dynptr_type type,
+				   bool may_be_pkt_data)
 {
 	int id = ++env->id_gen;
 
 	__mark_dynptr_reg(sreg1, type, true, id);
 	__mark_dynptr_reg(sreg2, type, false, id);
+	sreg1->dynptr.may_be_pkt_data = may_be_pkt_data;
+	sreg2->dynptr.may_be_pkt_data = may_be_pkt_data;
 }
 
 static void mark_dynptr_cb_reg(struct bpf_verifier_env *env,
@@ -641,7 +644,8 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 				        struct bpf_func_state *state, int spi);
 
 static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-				   enum bpf_arg_type arg_type, int insn_idx, int clone_ref_obj_id)
+				   enum bpf_arg_type arg_type, int insn_idx, int clone_ref_obj_id,
+				   bool may_be_pkt_data)
 {
 	struct bpf_func_state *state = bpf_func(env, reg);
 	enum bpf_dynptr_type type;
@@ -677,7 +681,8 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 		return -EINVAL;
 
 	mark_dynptr_stack_regs(env, &state->stack[spi].spilled_ptr,
-			       &state->stack[spi - 1].spilled_ptr, type);
+			       &state->stack[spi - 1].spilled_ptr, type,
+			       may_be_pkt_data);
 
 	if (dynptr_type_refcounted(type)) {
 		/* The id is used to track proper releasing */
@@ -1882,8 +1887,9 @@ static bool reg_is_pkt_pointer_any(const struct bpf_reg_state *reg)
 static bool reg_is_dynptr_slice_pkt(const struct bpf_reg_state *reg)
 {
 	return base_type(reg->type) == PTR_TO_MEM &&
-	       (reg->type &
-		(DYNPTR_TYPE_SKB | DYNPTR_TYPE_XDP | DYNPTR_TYPE_SKB_META));
+	       (reg->dynptr_may_be_pkt_data ||
+		(reg->type &
+		 (DYNPTR_TYPE_SKB | DYNPTR_TYPE_XDP | DYNPTR_TYPE_SKB_META)));
 }
 
 /* Unmodified PTR_TO_PACKET[_META,_END] register from ctx access. */
@@ -7452,7 +7458,8 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
  * type, and declare it as 'const struct bpf_dynptr *' in their prototype.
  */
 static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn_idx,
-			       enum bpf_arg_type arg_type, int clone_ref_obj_id)
+			       enum bpf_arg_type arg_type, int clone_ref_obj_id,
+			       bool clone_may_be_pkt_data)
 {
 	struct bpf_reg_state *reg = reg_state(env, regno);
 	int err;
@@ -7503,7 +7510,9 @@ static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn
 				return err;
 		}
 
-		err = mark_stack_slots_dynptr(env, reg, arg_type, insn_idx, clone_ref_obj_id);
+		err = mark_stack_slots_dynptr(env, reg, arg_type, insn_idx,
+					      clone_ref_obj_id,
+					      clone_may_be_pkt_data);
 	} else /* MEM_RDONLY and None case from above */ {
 		/* For the reg->type == PTR_TO_STACK case, bpf_dynptr is never const */
 		if (reg->type == CONST_PTR_TO_DYNPTR && !(arg_type & MEM_RDONLY)) {
@@ -8711,7 +8720,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 					 true, meta);
 		break;
 	case ARG_PTR_TO_DYNPTR:
-		err = process_dynptr_func(env, regno, insn_idx, arg_type, 0);
+		err = process_dynptr_func(env, regno, insn_idx, arg_type, 0, false);
 		if (err)
 			return err;
 		break;
@@ -9155,6 +9164,35 @@ static void clear_all_pkt_pointers(struct bpf_verifier_env *env)
 	}));
 }
 
+static bool dynptr_type_pkt_data(enum bpf_dynptr_type type)
+{
+	return type == BPF_DYNPTR_TYPE_SKB ||
+	       type == BPF_DYNPTR_TYPE_SKB_META;
+}
+
+static bool dynptr_may_be_pkt_data(struct bpf_verifier_env *env,
+				   const struct bpf_reg_state *reg,
+				   enum bpf_dynptr_type type)
+{
+	struct bpf_func_state *state;
+	int spi;
+
+	if (dynptr_type_pkt_data(type))
+		return true;
+	if (type != BPF_DYNPTR_TYPE_LOCAL)
+		return false;
+
+	if (reg->type == CONST_PTR_TO_DYNPTR)
+		return reg->dynptr.may_be_pkt_data;
+
+	state = bpf_func(env, reg);
+	spi = dynptr_get_spi(env, reg);
+	if (spi < 0)
+		return false;
+
+	return state->stack[spi].spilled_ptr.dynptr.may_be_pkt_data;
+}
+
 enum {
 	AT_PKT_END = -1,
 	BEYOND_PKT_END = -2,
@@ -9370,7 +9408,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			if (ret)
 				return ret;
 
-			ret = process_dynptr_func(env, regno, -1, arg->arg_type, 0);
+			ret = process_dynptr_func(env, regno, -1, arg->arg_type, 0, false);
 			if (ret)
 				return ret;
 		} else if (base_type(arg->arg_type) == ARG_PTR_TO_BTF_ID) {
@@ -10520,8 +10558,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		if (dynptr_type == BPF_DYNPTR_TYPE_INVALID)
 			return -EFAULT;
 
-		if (dynptr_type == BPF_DYNPTR_TYPE_SKB ||
-		    dynptr_type == BPF_DYNPTR_TYPE_SKB_META)
+		if (dynptr_may_be_pkt_data(env, reg, dynptr_type))
 			/* this will trigger clear_all_pkt_pointers(), which will
 			 * invalidate all dynptr slices associated with the skb
 			 */
@@ -11157,6 +11194,16 @@ enum special_kfunc_type {
 	KF_bpf_xdp_pull_data,
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
+	KF_bpf_dynptr_copy,
+	KF_bpf_dynptr_memset,
+	KF_bpf_probe_read_user_dynptr,
+	KF_bpf_probe_read_kernel_dynptr,
+	KF_bpf_probe_read_user_str_dynptr,
+	KF_bpf_probe_read_kernel_str_dynptr,
+	KF_bpf_copy_from_user_dynptr,
+	KF_bpf_copy_from_user_str_dynptr,
+	KF_bpf_copy_from_user_task_dynptr,
+	KF_bpf_copy_from_user_task_str_dynptr,
 	KF_bpf_dynptr_clone,
 	KF_bpf_percpu_obj_new_impl,
 	KF_bpf_percpu_obj_new,
@@ -11232,6 +11279,27 @@ BTF_ID_UNUSED
 #endif
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
+BTF_ID(func, bpf_dynptr_copy)
+BTF_ID(func, bpf_dynptr_memset)
+#ifdef CONFIG_BPF_EVENTS
+BTF_ID(func, bpf_probe_read_user_dynptr)
+BTF_ID(func, bpf_probe_read_kernel_dynptr)
+BTF_ID(func, bpf_probe_read_user_str_dynptr)
+BTF_ID(func, bpf_probe_read_kernel_str_dynptr)
+BTF_ID(func, bpf_copy_from_user_dynptr)
+BTF_ID(func, bpf_copy_from_user_str_dynptr)
+BTF_ID(func, bpf_copy_from_user_task_dynptr)
+BTF_ID(func, bpf_copy_from_user_task_str_dynptr)
+#else
+BTF_ID_UNUSED
+BTF_ID_UNUSED
+BTF_ID_UNUSED
+BTF_ID_UNUSED
+BTF_ID_UNUSED
+BTF_ID_UNUSED
+BTF_ID_UNUSED
+BTF_ID_UNUSED
+#endif
 BTF_ID(func, bpf_dynptr_clone)
 BTF_ID(func, bpf_percpu_obj_new_impl)
 BTF_ID(func, bpf_percpu_obj_new)
@@ -11362,9 +11430,35 @@ static bool is_kfunc_bpf_preempt_enable(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->func_id == special_kfunc_list[KF_bpf_preempt_enable];
 }
 
+static bool is_kfunc_pkt_dynptr_writer(struct bpf_kfunc_call_arg_meta *meta, u32 arg)
+{
+	u32 func_id = meta->func_id;
+
+	if (arg != 0)
+		return false;
+
+	return func_id == special_kfunc_list[KF_bpf_dynptr_copy] ||
+	       func_id == special_kfunc_list[KF_bpf_dynptr_memset] ||
+	       func_id == special_kfunc_list[KF_bpf_probe_read_user_dynptr] ||
+	       func_id == special_kfunc_list[KF_bpf_probe_read_kernel_dynptr] ||
+	       func_id == special_kfunc_list[KF_bpf_probe_read_user_str_dynptr] ||
+	       func_id == special_kfunc_list[KF_bpf_probe_read_kernel_str_dynptr] ||
+	       func_id == special_kfunc_list[KF_bpf_copy_from_user_dynptr] ||
+	       func_id == special_kfunc_list[KF_bpf_copy_from_user_str_dynptr] ||
+	       func_id == special_kfunc_list[KF_bpf_copy_from_user_task_dynptr] ||
+	       func_id == special_kfunc_list[KF_bpf_copy_from_user_task_str_dynptr];
+}
+
+bool bpf_kfunc_may_change_pkt_data(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->func_id == special_kfunc_list[KF_bpf_xdp_pull_data] ||
+	       is_kfunc_pkt_dynptr_writer(meta, 0);
+}
+
 bool bpf_is_kfunc_pkt_changing(struct bpf_kfunc_call_arg_meta *meta)
 {
-	return meta->func_id == special_kfunc_list[KF_bpf_xdp_pull_data];
+	return meta->func_id == special_kfunc_list[KF_bpf_xdp_pull_data] ||
+	       meta->pkt_dynptr_write;
 }
 
 static enum kfunc_ptr_arg_type
@@ -12288,6 +12382,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_DYNPTR:
 		{
 			enum bpf_arg_type dynptr_arg_type = ARG_PTR_TO_DYNPTR;
+			bool clone_may_be_pkt_data = false;
 			int clone_ref_obj_id = 0;
 
 			if (reg->type == CONST_PTR_TO_DYNPTR)
@@ -12318,15 +12413,27 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 
 				dynptr_arg_type |= (unsigned int)get_dynptr_type_flag(parent_type);
 				clone_ref_obj_id = meta->initialized_dynptr.ref_obj_id;
+				clone_may_be_pkt_data = meta->initialized_dynptr.may_be_pkt_data;
 				if (dynptr_type_refcounted(parent_type) && !clone_ref_obj_id) {
 					verifier_bug(env, "missing ref obj id for parent of clone");
 					return -EFAULT;
 				}
 			}
 
-			ret = process_dynptr_func(env, regno, insn_idx, dynptr_arg_type, clone_ref_obj_id);
+			ret = process_dynptr_func(env, regno, insn_idx, dynptr_arg_type,
+						  clone_ref_obj_id,
+						  clone_may_be_pkt_data);
 			if (ret < 0)
 				return ret;
+			if (is_kfunc_pkt_dynptr_writer(meta, i)) {
+				enum bpf_dynptr_type type;
+
+				type = dynptr_get_type(env, reg);
+				if (type == BPF_DYNPTR_TYPE_INVALID)
+					return -EFAULT;
+				if (dynptr_may_be_pkt_data(env, reg, type))
+					meta->pkt_dynptr_write = true;
+			}
 
 			if (!(dynptr_arg_type & MEM_UNINIT)) {
 				int id = dynptr_id(env, reg);
@@ -12338,6 +12445,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				meta->initialized_dynptr.id = id;
 				meta->initialized_dynptr.type = dynptr_get_type(env, reg);
 				meta->initialized_dynptr.ref_obj_id = dynptr_ref_obj_id(env, reg);
+				meta->initialized_dynptr.may_be_pkt_data =
+					dynptr_may_be_pkt_data(env, reg,
+							       meta->initialized_dynptr.type);
 			}
 
 			break;
@@ -12956,6 +13066,8 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
 
 		/* PTR_MAYBE_NULL will be added when is_kfunc_ret_null is checked */
 		regs[BPF_REG_0].type = PTR_TO_MEM | type_flag;
+		regs[BPF_REG_0].dynptr_may_be_pkt_data =
+			meta->initialized_dynptr.may_be_pkt_data;
 
 		if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_slice]) {
 			regs[BPF_REG_0].type |= MEM_RDONLY;
@@ -18763,6 +18875,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 			} else if (arg->arg_type == (ARG_PTR_TO_DYNPTR | MEM_RDONLY)) {
 				/* assume unspecial LOCAL dynptr type */
 				__mark_dynptr_reg(reg, BPF_DYNPTR_TYPE_LOCAL, true, ++env->id_gen);
+				reg->dynptr.may_be_pkt_data = true;
 			} else if (base_type(arg->arg_type) == ARG_PTR_TO_MEM) {
 				reg->type = PTR_TO_MEM;
 				reg->type |= arg->arg_type &
-- 
2.34.1

