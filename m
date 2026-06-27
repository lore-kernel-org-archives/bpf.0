Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56570146D5A;
	Sat, 27 Jun 2026 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782571973; cv=none; b=SnAMf7yHvBJIUaEM3JfW8wBun+tKHox9eQy4uI2TAHLe18WBaQcYdOqljeciDozuI3GpM9IrcnWC8dRXZaRoLp5Hs5UhI2pLYmSsWMC3BiDKHyNQwcMig/4EUv5l4P3lG/hUQW6TTj8nDIq4DeqQ0jouTjYTIkpVmA+Kk04krmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782571973; c=relaxed/simple;
	bh=kbbHKVdcCrmuhh9vNlo3CLH+iKSgMmRw3nvFr5bpbPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehCyAo2hujbqd6NYVWEyIPHQ16/hNK80drcDK0ZHmGcHmm2xEqpvN3/wRVB+vWnE9S2Lcl7utGQalcGSpCH8xxHewif8IpjMJHIZGwhbd318KuxvpNTTRC6c4H6nFLdvwj8gw6C/oP8BQyTJwoVAQZW2l63wOJMOA0pUwU1m3mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gnb9C3QdZzYQtky;
	Sat, 27 Jun 2026 22:51:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 46A124056F;
	Sat, 27 Jun 2026 22:52:47 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgAHPCa94z9qh0oVAA--.10903S11;
	Sat, 27 Jun 2026 22:52:47 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Eyal Birger <eyal.birger@gmail.com>,
	Rong Tao <rongtao@cestc.cn>
Subject: [RFC PATCH bpf-next 09/12] bpf: Add kernel support to load SDT observer program
Date: Sat, 27 Jun 2026 22:51:43 +0000
Message-ID: <e5e991c7573600676c0de49b7b794e1f2b6d956a.1782571533.git.xukuohai@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782571533.git.xukuohai@huawei.com>
References: <cover.1782571533.git.xukuohai@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHPCa94z9qh0oVAA--.10903S11
X-Coremail-Antispam: 1UD129KBjvJXoWfJrWrGF1ftr1UtF17urW3Jrb_yoWkWr1UpF
	4kXr18Ar40q3y2qryqyayfu343tr4UW34UGFZrG34avayaqws5JayUGFWavFyY9FWDG3WS
	vw1jvFZ0grW7ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
	FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJw
	A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7
	CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j
	6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUIJ5rDUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Add kernel support to load SDT observer program. The program is
verified as a normal tracing type program while the target FUNC_PROTO
is resolved in the SDT map of the target program using the probe name
passed by the user. The probe data is preserved in prog->aux->sdt_probe,
so that the later attach can find the target probe information easily.

Also introduce a returning false weak function bpf_jit_supports_sdt_probe()
to hint if SDT probe is supported by the JIT.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/linux/bpf.h         | 15 +++++++
 include/linux/bpf_types.h   |  1 +
 include/linux/filter.h      |  1 +
 kernel/bpf/bpf_insn_array.c | 28 +++++++++++++
 kernel/bpf/core.c           |  5 +++
 kernel/bpf/syscall.c        | 78 ++++++++++++++++++++++++++++++-------
 kernel/bpf/verifier.c       | 19 +++++++++
 7 files changed, 134 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cb43792afdee..93c196f38b87 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1220,6 +1220,8 @@ struct btf_func_model {
 	u8 nr_args;
 	u8 arg_size[MAX_BPF_FUNC_ARGS];
 	u8 arg_flags[MAX_BPF_FUNC_ARGS];
+	/* argument registers for bpf SDT probe site */
+	u8 arg_regs[MAX_BPF_FUNC_REG_ARGS];
 };
 
 /* Restore arguments before returning from trampoline to let original function
@@ -1419,6 +1421,15 @@ struct bpf_attach_target_info {
 	const struct btf_type *tgt_type;
 };
 
+/*
+ * cached in prog->aux, used by the verifier to type the observer's context
+ * arguments, and by link_create to build the trampoline without re-resolving
+ */
+struct bpf_sdt_probe_info {
+	struct bpf_insn_array_value val;
+	unsigned long probe_ip;
+};
+
 #define BPF_DISPATCHER_MAX 48 /* Fits in 2048B */
 
 struct bpf_dispatcher_prog {
@@ -1762,6 +1773,7 @@ struct bpf_prog_aux {
 	void __percpu *priv_stack_ptr;
 	struct mutex dst_mutex; /* protects dst_* pointers below, *after* prog becomes visible */
 	struct bpf_prog *dst_prog;
+	struct bpf_sdt_probe_info *sdt_probe;
 	struct bpf_trampoline *dst_trampoline;
 	enum bpf_prog_type saved_dst_prog_type;
 	enum bpf_attach_type saved_dst_attach_type;
@@ -4159,6 +4171,9 @@ int bpf_insn_array_ready(struct bpf_map *map);
 void bpf_insn_array_release(struct bpf_map *map);
 void bpf_insn_array_adjust(struct bpf_map *map, u32 off, u32 len);
 void bpf_insn_array_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);
+int bpf_insn_array_get_sdt_probe_by_name(struct bpf_prog *prog, const char *name,
+					 struct bpf_insn_array_value *val,
+					 unsigned long *ip);
 
 #ifdef CONFIG_BPF_SYSCALL
 void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image);
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index e5906829aa6f..1aac6bc71c6f 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -157,3 +157,4 @@ BPF_LINK_TYPE(BPF_LINK_TYPE_KPROBE_MULTI, kprobe_multi)
 BPF_LINK_TYPE(BPF_LINK_TYPE_STRUCT_OPS, struct_ops)
 BPF_LINK_TYPE(BPF_LINK_TYPE_UPROBE_MULTI, uprobe_multi)
 BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING_MULTI, tracing_multi)
+BPF_LINK_TYPE(BPF_LINK_TYPE_SDT, sdt)
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 67d337ede91b..ba4025160a6f 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1190,6 +1190,7 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
 bool bpf_jit_supports_private_stack(void);
 bool bpf_jit_supports_timed_may_goto(void);
 bool bpf_jit_supports_fsession(void);
+bool bpf_jit_supports_sdt_probe(void);
 u64 bpf_arch_uaddress_limit(void);
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie);
 u64 arch_bpf_timed_may_goto(void);
diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
index a9564ef4b2ef..067cc1b817d5 100644
--- a/kernel/bpf/bpf_insn_array.c
+++ b/kernel/bpf/bpf_insn_array.c
@@ -263,6 +263,34 @@ void bpf_insn_array_release(struct bpf_map *map)
 	atomic_set(&insn_array->used, 0);
 }
 
+int bpf_insn_array_get_sdt_probe_by_name(struct bpf_prog *prog, const char *name,
+					 struct bpf_insn_array_value *val,
+					 unsigned long *ip)
+{
+	int i, j;
+	struct bpf_map *map;
+	struct bpf_insn_array *insn_array;
+
+	for (i = 0; i < prog->aux->used_map_cnt; i++) {
+		map = prog->aux->used_maps[i];
+		if (map->map_type != BPF_MAP_TYPE_INSN_ARRAY ||
+		    !(map->map_flags & BPF_F_INSN_ARRAY_SDT))
+			continue;
+		insn_array = cast_insn_array(map);
+		for (j = 0; j < map->max_entries; j++) {
+			if (insn_array->values[j].xlated_off == INSN_DELETED)
+				continue;
+			if (!strcmp(insn_array->values[j].name, name)) {
+				*val = insn_array->values[j];
+				*ip = (unsigned long)insn_array->ips[j];
+				return 0;
+			}
+		}
+	}
+
+	return -EEXIST;
+}
+
 void bpf_insn_array_adjust(struct bpf_map *map, u32 off, u32 len)
 {
 	struct bpf_insn_array *insn_array = cast_insn_array(map);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 649cce41e13f..78c7ad3b4e2f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3263,6 +3263,11 @@ bool __weak bpf_jit_supports_fsession(void)
 	return false;
 }
 
+bool __weak bpf_jit_supports_sdt_probe(void)
+{
+	return false;
+}
+
 u64 __weak bpf_arch_uaddress_limit(void)
 {
 #if defined(CONFIG_64BIT) && defined(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index dc881e5ad411..8b2c73bb6c2a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2454,6 +2454,7 @@ static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
 	kvfree(prog->aux->linfo);
 	kfree(prog->aux->kfunc_tab);
 	kfree(prog->aux->ctx_arg_info);
+	kfree(prog->aux->sdt_probe);
 	if (prog->aux->attach_btf)
 		btf_put(prog->aux->attach_btf);
 
@@ -2967,13 +2968,15 @@ int __init __used bpf_multi_func(void) { return 0; }
 BTF_ID_LIST_GLOBAL_SINGLE(bpf_multi_func_btf_id, func, bpf_multi_func)
 
 /* last field in 'union bpf_attr' used by this command */
-#define BPF_PROG_LOAD_LAST_FIELD sdt_map_fd
+#define BPF_PROG_LOAD_LAST_FIELD sdt.name
 
 static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_attr *attr_log)
 {
 	enum bpf_prog_type type = attr->prog_type;
+	struct bpf_sdt_probe_info *prog_sdt_probe = NULL;
 	struct bpf_prog *prog, *dst_prog = NULL;
 	struct btf *attach_btf = NULL;
+	u32 attach_btf_id = 0;
 	struct bpf_token *token = NULL;
 	bool bpf_cap;
 	int err;
@@ -3082,33 +3085,75 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
 		btf_get(attach_btf);
 	}
 
+	/*
+	 * find the probe site in the target program at load time of the
+	 * observer program, so the verifier can check the observer's context
+	 * arguments from the probe's FUNC_PROTO.
+	 */
+	if (attr->expected_attach_type == BPF_TRACE_SDT) {
+		struct bpf_insn_array_value sdt_val;
+		struct bpf_sdt_probe_info *sdt_probe;
+		unsigned long probe_ip;
+
+		if (!bpf_jit_supports_sdt_probe()) {
+			err = -EOPNOTSUPP;
+			goto put_token;
+		}
+		if (!attr->sdt.target_prog_fd) {
+			err = -EINVAL;
+			goto put_token;
+		}
+		dst_prog = bpf_prog_get(attr->sdt.target_prog_fd);
+		if (IS_ERR(dst_prog)) {
+			err = PTR_ERR(dst_prog);
+			dst_prog = NULL;
+			goto put_token;
+		}
+		err = bpf_insn_array_get_sdt_probe_by_name(dst_prog, attr->sdt.name,
+							   &sdt_val, &probe_ip);
+		if (err)
+			goto put_sdt;
+		sdt_probe = kzalloc_obj(struct bpf_sdt_probe_info, GFP_USER);
+		if (!sdt_probe) {
+			err = -ENOMEM;
+			goto put_sdt;
+		}
+		sdt_probe->val = sdt_val;
+		sdt_probe->probe_ip = probe_ip;
+		prog_sdt_probe = sdt_probe;
+		attach_btf_id = sdt_val.btf_id;
+	}
+
+
 	if (bpf_prog_load_check_attach(type, attr->expected_attach_type,
-				       attach_btf, attr->attach_btf_id,
+				       attach_btf,
+				       prog_sdt_probe ? attach_btf_id : attr->attach_btf_id,
 				       dst_prog, multi_func)) {
-		if (dst_prog)
-			bpf_prog_put(dst_prog);
-		if (attach_btf)
-			btf_put(attach_btf);
 		err = -EINVAL;
-		goto put_token;
+		goto put_sdt;
 	}
 
 	/* plain bpf_prog allocation */
 	prog = bpf_prog_alloc(bpf_prog_size(attr->insn_cnt), GFP_USER);
 	if (!prog) {
-		if (dst_prog)
-			bpf_prog_put(dst_prog);
-		if (attach_btf)
-			btf_put(attach_btf);
 		err = -EINVAL;
-		goto put_token;
+		goto put_sdt;
 	}
 
 	prog->expected_attach_type = attr->expected_attach_type;
 	prog->sleepable = !!(attr->prog_flags & BPF_F_SLEEPABLE);
 	prog->aux->attach_btf = attach_btf;
-	prog->aux->attach_btf_id = multi_func ? bpf_multi_func_btf_id[0] : attr->attach_btf_id;
+	if (prog_sdt_probe)
+		prog->aux->attach_btf_id = attach_btf_id;
+	else
+		prog->aux->attach_btf_id =
+			multi_func ? bpf_multi_func_btf_id[0] : attr->attach_btf_id;
 	prog->aux->dst_prog = dst_prog;
+	prog->aux->sdt_probe = prog_sdt_probe;
+	/* ownership of dst_prog/attach_btf/prog_sdt_probe moved to prog->aux */
+	dst_prog = NULL;
+	attach_btf = NULL;
+	prog_sdt_probe = NULL;
 	prog->aux->dev_bound = !!attr->prog_ifindex;
 	prog->aux->xdp_has_frags = attr->prog_flags & BPF_F_XDP_HAS_FRAGS;
 
@@ -3242,6 +3287,12 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
 	if (prog->aux->attach_btf)
 		btf_put(prog->aux->attach_btf);
 	bpf_prog_free(prog);
+put_sdt:
+	kfree(prog_sdt_probe);
+	if (attach_btf)
+		btf_put(attach_btf);
+	if (dst_prog)
+		bpf_prog_put(dst_prog);
 put_token:
 	bpf_token_put(token);
 	return err;
@@ -4507,6 +4558,7 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	case BPF_TRACE_FENTRY_MULTI:
 	case BPF_TRACE_FEXIT_MULTI:
 	case BPF_MODIFY_RETURN:
+	case BPF_TRACE_SDT:
 		return BPF_PROG_TYPE_TRACING;
 	case BPF_LSM_MAC:
 		return BPF_PROG_TYPE_LSM;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bc972beb80cf..a875d64a0950 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16451,6 +16451,7 @@ static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_
 			break;
 		case BPF_TRACE_RAW_TP:
 		case BPF_MODIFY_RETURN:
+		case BPF_TRACE_SDT:
 			return false;
 		case BPF_TRACE_ITER:
 		default:
@@ -19458,6 +19459,24 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	    prog->type != BPF_PROG_TYPE_EXT)
 		return 0;
 
+	if (prog->expected_attach_type == BPF_TRACE_SDT) {
+		const struct btf_type *sdt_t;
+		struct btf *sdt_btf = tgt_prog ? tgt_prog->aux->btf : NULL;
+
+		if (!sdt_btf) {
+			verbose(env, "SDT observer requires a target program with BTF\n");
+			return -EINVAL;
+		}
+		sdt_t = btf_type_by_id(sdt_btf, btf_id);
+		if (!sdt_t || !btf_type_is_func_proto(sdt_t)) {
+			verbose(env, "SDT attach_btf_id %u is not a FUNC_PROTO\n", btf_id);
+			return -EINVAL;
+		}
+		prog->aux->attach_func_proto = sdt_t;
+		prog->aux->attach_func_name = "sdt_probe";
+		return 0;
+	}
+
 	ret = bpf_check_attach_target(&env->log, prog, tgt_prog, btf_id, &tgt_info);
 	if (ret)
 		return ret;
-- 
2.47.3

