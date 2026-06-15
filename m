Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F893FF887;
	Mon, 15 Jun 2026 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536580; cv=none; b=HtbKV6le71oVB6EztImCqrdQOvSgNWhHvAY25WFVIRq7ca/E1Lyds8vQRE0qsyp3tku1rFJuEtBV+5wh1Y/yCA2Q32XdtvZecci3A02uKOuEU7qe9jPgc9ZGGvewdl43FgH72unmfqIYrQmsEkDqTnAucYlb8K+3SWkZcErJdqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536580; c=relaxed/simple;
	bh=qeudFOh/ejfAM2AAyECfXbVu52fFsHoWUuZCibU0URU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PhFvnyJ97ANWNoT4GFqcKjGQ1J39wkmql35er3qTrF0AsUxtNk8nDdirE0CUWeFyqKJay/ISbpHtEblyav4loOCoi761QyVes3bM3Oc5ilG7q6j8TX1aIOVcPLBxUuLxlO5EkNbWq0ME9RJ7eXGvZdTjqFZzfXL4GjqPdc+79e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=BMV/6/dW; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="BMV/6/dW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=Yr88zWYn/8Iexu2f7Nm2od4ZmJgFE9HMS0
	SLKBFUFwk=; b=BMV/6/dWUSvASFzV2oH5j4H4v3n2J/tj5JhJu/qi1o7R3po7Q4
	Po9OktQRQI8KRebmsQOfQ4dsW7B+9qOO3QdQIf3coADigbyrzrjfGSBX6i43qOGf
	CFvpMV4nZ9C1THmqCJF+r0MgabwV1M18j7pu00grmut+cbZmbvX4TqPiE=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web5 (Coremail) with SMTP id zAQGZQDXj78mFzBqGxJyAg--.21012S3;
	Mon, 15 Jun 2026 23:16:08 +0800 (CST)
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
Subject: [PATCH bpf v4 1/2] bpf: Fix packet pointer invalidation for skb dynptr writes
Date: Mon, 15 Jun 2026 15:15:48 +0000
Message-Id: <76830c72d48ea174272d4a2ee9d5cc0f3ef02c8d.1781535194.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781535194.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781531784.git.chenyy23@mails.tsinghua.edu.cn> <cover.1781535194.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zAQGZQDXj78mFzBqGxJyAg--.21012S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKw48Ww1xZw4UWw1UGry7GFg_yoWfArWfpF
	s5Cr9F9r4kta1ftrnrJF47ZrW5tr4Iq3yxCFykKa4S9F48Wr98Zr1UKw18tas8tF1jyrW2
	va10vrW5ZryUK3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_XrWl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY
	6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRicTmPUUUUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

skb-backed dynptr writers can mutate packet data, but not all verifier
paths invalidate checked direct packet pointers after those writes.

bpf_dynptr_write() handles skb and skb-meta dynptrs in the normal helper
path, but global subprogram dynptr arguments are verified as
unspecialized local dynptr pointers. Treat CONST_PTR_TO_DYNPTR local
arguments as possibly packet-backed for packet pointer invalidation.

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
 include/linux/bpf_verifier.h |  3 ++
 include/linux/filter.h       |  5 ++
 kernel/bpf/cfg.c             |  4 +-
 kernel/bpf/verifier.c        | 88 ++++++++++++++++++++++++++++++++++--
 4 files changed, 95 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 185b2aa43a420..b550e5a702081 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1332,6 +1332,7 @@ struct bpf_kfunc_call_arg_meta {
 	u32 ref_obj_id;
 	u8 release_regno;
 	bool r0_rdonly;
+	bool pkt_dynptr_write;
 	u32 ret_btf_id;
 	u64 r0_size;
 	u32 subprogno;
@@ -1389,6 +1390,8 @@ static inline bool bpf_is_kfunc_sleepable(struct bpf_kfunc_call_arg_meta *meta)
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
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7fb88e1cd7c4d..51468faa76a47 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9155,6 +9155,23 @@ static void clear_all_pkt_pointers(struct bpf_verifier_env *env)
 	}));
 }
 
+static bool dynptr_type_pkt_data(enum bpf_dynptr_type type)
+{
+	return type == BPF_DYNPTR_TYPE_SKB ||
+	       type == BPF_DYNPTR_TYPE_SKB_META;
+}
+
+static bool dynptr_may_be_pkt_data(const struct bpf_reg_state *reg,
+				   enum bpf_dynptr_type type)
+{
+	if (dynptr_type_pkt_data(type))
+		return true;
+
+	/* Global subprog dynptr args are verified as unspecialized LOCAL. */
+	return reg->type == CONST_PTR_TO_DYNPTR &&
+	       type == BPF_DYNPTR_TYPE_LOCAL;
+}
+
 enum {
 	AT_PKT_END = -1,
 	BEYOND_PKT_END = -2,
@@ -10520,8 +10537,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		if (dynptr_type == BPF_DYNPTR_TYPE_INVALID)
 			return -EFAULT;
 
-		if (dynptr_type == BPF_DYNPTR_TYPE_SKB ||
-		    dynptr_type == BPF_DYNPTR_TYPE_SKB_META)
+		if (dynptr_may_be_pkt_data(reg, dynptr_type))
 			/* this will trigger clear_all_pkt_pointers(), which will
 			 * invalidate all dynptr slices associated with the skb
 			 */
@@ -11157,6 +11173,16 @@ enum special_kfunc_type {
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
@@ -11232,6 +11258,27 @@ BTF_ID_UNUSED
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
@@ -11362,9 +11409,35 @@ static bool is_kfunc_bpf_preempt_enable(struct bpf_kfunc_call_arg_meta *meta)
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
@@ -12327,6 +12400,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			ret = process_dynptr_func(env, regno, insn_idx, dynptr_arg_type, clone_ref_obj_id);
 			if (ret < 0)
 				return ret;
+			if (is_kfunc_pkt_dynptr_writer(meta, i)) {
+				enum bpf_dynptr_type type;
+
+				type = dynptr_get_type(env, reg);
+				if (type == BPF_DYNPTR_TYPE_INVALID)
+					return -EFAULT;
+				if (dynptr_may_be_pkt_data(reg, type))
+					meta->pkt_dynptr_write = true;
+			}
 
 			if (!(dynptr_arg_type & MEM_UNINIT)) {
 				int id = dynptr_id(env, reg);
-- 
2.34.1

