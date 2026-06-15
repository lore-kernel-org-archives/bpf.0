Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102B73CBE74;
	Mon, 15 Jun 2026 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781532885; cv=none; b=cxtNftiu6H9epNHZcWFBsOt2tvZCC09CO0r1pIAsHyvI3nsKor8wsGSCCD9MB/8tefjON1nkEhps2A89Pix0N+w7nIpBrpanMcCrRiRjgrMd/vICAXQAM3LOKKDK6G+CUK1KCg/IhZwvTPBc88tqP48kty3UF0DLhr/t6DbwKaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781532885; c=relaxed/simple;
	bh=t3BmYg+HWIifwccydKYqPmsC+BNPQdRjUM0O6zL04+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o6fumqKbQcIW+WDy+Sv/xb2Ph8jYtVnermDVgh5zt7u0UC/ehoQ5L2L57Zi4W3IjLSY3e5m02ggaGvYcBR0mdRuk6fsR8sgQwK0aWW0oXes47EPryyqiUfGeFbrym1rjaQqUwxS3X+GBok/FqbqS/HH6WFc3OiIKtJXrp88Ib10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=NAGMLTxp; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="NAGMLTxp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=RMIll7IFERTD3ZEh2xpP20WxPZpOi12zP9
	DFKcgnhAg=; b=NAGMLTxpRgvJ2J4suMaZVnx9UN+6Pl5yJUhCTply7WNnA6xUe/
	1kI4S/QvJuwN/BYREMEAv1wbocSCa1VTyiUxp9DDm7VtU2oaogwDGs3BkWy16F5X
	ULAMubQs7g+Y0wUMRtIOaOZQxJP5EA2H2FfKGaudvTUjBROr8psUlsxQk=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web4 (Coremail) with SMTP id ywQGZQBXaZ69CDBqq7FKAg--.53046S3;
	Mon, 15 Jun 2026 22:14:34 +0800 (CST)
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
Subject: [PATCH bpf v3 1/2] bpf: Fix packet pointer invalidation for skb dynptr writes
Date: Mon, 15 Jun 2026 14:14:06 +0000
Message-Id: <baea5363a0e35d1dc16d41b972d9a9e89cc85b46.1781531784.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781531784.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781525896.git.chenyy23@mails.tsinghua.edu.cn> <cover.1781531784.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQBXaZ69CDBqq7FKAg--.53046S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKw18tw47ur4UWrWDKF47XFb_yoWxuw13pF
	4rGF92krs5ta13trnrAF48ZrWrJr4IqayxCFyDKa4S9r4UWr90qr1j9w1rJ3s8tF1Ykr42
	vw10vrW3ZryUK3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Xryl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY
	6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUUO6pPUUUUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

skb-backed dynptr writer kfuncs can mutate packet data, but the verifier
leaves checked direct packet pointers usable after kfunc calls.
The bpf_dynptr_write() helper already invalidates packet pointers
through clear_all_pkt_pointers(). Make skb dynptr writer kfuncs
follow the same rule.

Keep two verifier predicates for this. CFG analysis runs before register
states are available, so conservatively mark dynptr writer kfuncs as
packet-changing for subprogram summaries. The normal verifier path uses
the checked dynptr argument and invalidates only when the written dynptr
is, or may be, skb-backed.

Global subprogram dynptr arguments are prepared as unspecialized local
dynptr pointers, so treat CONST_PTR_TO_DYNPTR local dynptr writer
destinations as possibly packet-backed. This keeps packet pointer
invalidation sound both after global subprogram calls and inside global
subprogram bodies.

Fixes: daec295a7094 ("bpf/helpers: Introduce bpf_dynptr_copy kfunc")
Fixes: a498ee7576de ("bpf: Implement dynptr copy kfuncs")
Fixes: 5fc5d8fded57 ("bpf: Add bpf_dynptr_memset() kfunc")
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 include/linux/bpf_verifier.h |  3 ++
 kernel/bpf/cfg.c             |  2 +-
 kernel/bpf/verifier.c        | 79 +++++++++++++++++++++++++++++++++++-
 3 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 39a851e690ec4..603f22220122e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1448,6 +1448,7 @@ struct bpf_kfunc_call_arg_meta {
 	/* Out parameters */
 	u8 release_regno;
 	bool r0_rdonly;
+	bool pkt_dynptr_write;
 	u32 ret_btf_id;
 	u64 r0_size;
 	u32 subprogno;
@@ -1502,6 +1503,8 @@ static inline bool bpf_is_kfunc_sleepable(struct bpf_kfunc_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_SLEEPABLE;
 }
+
+bool bpf_kfunc_may_change_pkt_data(struct bpf_kfunc_call_arg_meta *meta);
 bool bpf_is_kfunc_pkt_changing(struct bpf_kfunc_call_arg_meta *meta);
 struct bpf_iarray *bpf_iarray_realloc(struct bpf_iarray *old, size_t n_elem);
 int bpf_copy_insn_array_uniq(struct bpf_map *map, u32 start, u32 end, u32 *off);
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 26d37066465f3..7ed6bdd986bc8 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
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
index 2abc79dbf281c..9c1e3cccbd6de 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11016,6 +11016,16 @@ enum special_kfunc_type {
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
@@ -11096,6 +11106,27 @@ BTF_ID_UNUSED
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
@@ -11227,9 +11258,52 @@ static bool is_kfunc_bpf_preempt_enable(struct bpf_kfunc_call_arg_meta *meta)
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
+}
+
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
 }
 
 static enum kfunc_ptr_arg_type
@@ -12214,6 +12288,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 						  &meta->ref_obj, &meta->dynptr);
 			if (ret < 0)
 				return ret;
+			if (is_kfunc_pkt_dynptr_writer(meta, i) &&
+			    dynptr_may_be_pkt_data(reg, meta->dynptr.type))
+				meta->pkt_dynptr_write = true;
 			break;
 		}
 		case KF_ARG_PTR_TO_ITER:
-- 
2.34.1

