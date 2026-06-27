Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9C03B4EA5;
	Sat, 27 Jun 2026 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782571987; cv=none; b=Zeoz3EYfywwAZT0WARIORFZpfemVgafefZqC2OV+5XvoUmTLpBXPUtDkY4DEPehAWEXpc9cl89FdsQWl8QVmcimmW24h/OOK46hu2dflRoaKOnEJf6E4A+gnODjVxWYnHujS4FYR8+P1bCCpyzuof7JdxQWIoZ+SgDSXwQlF510=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782571987; c=relaxed/simple;
	bh=8+eJor112y7NUn1eJRVWXB2Tp4g4kCW2NhCnTcgFzTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsz9rYDPm4t3WAA5yqWfcr+alMyjQ2SXfzgZDR+MJUBR0VZskuqC1MpJZVMrWveiyQ0YBT787YNSBTviUCEd0wBWA5n5bMqYB0MTMYBVtYwn06ab5QuQGliBtOwRrfyAJM29VKZuZIUwTFAba8UH8Hy1FG9scWCuJcYAt+ctArc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gnbB35LtlzKHMPK;
	Sat, 27 Jun 2026 22:52:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 15EDA4058F;
	Sat, 27 Jun 2026 22:52:47 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgAHPCa94z9qh0oVAA--.10903S8;
	Sat, 27 Jun 2026 22:52:46 +0800 (CST)
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
Subject: [RFC PATCH bpf-next 06/12] bpf: Add type check for SDT probe site
Date: Sat, 27 Jun 2026 22:51:40 +0000
Message-ID: <d20d2be69ab6bfa5f81c249bf54c2d47558d239e.1782571533.git.xukuohai@huawei.com>
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
X-CM-TRANSID:_Ch0CgAHPCa94z9qh0oVAA--.10903S8
X-Coremail-Antispam: 1UD129KBjvJXoW3KFWrKr1rWw4Duw4kAr4Dtwb_yoWDWFWfpa
	n7J34DAr48Jr43uwnrJa1rCry3tw4j9ay7GFWrG34FvFyjqrnYqFWjgrWjvr9xCrW8K3Wf
	Aw4q9rWq934xZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
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
	JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0fb15UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

The NOP instruction at SDT probe site will be patched to a call
instruction to observer programs. To ensure the arguments passed
to observers are as expected, add type check for bpf SDT probe site.

The check for probes with no arguments always succeeds.

For probes with arguments, argument registers are checked against
the types declared by FUNC_PROTO for the probe site.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/linux/bpf.h          |   2 +-
 include/linux/bpf_verifier.h |   3 +
 kernel/bpf/bpf_insn_array.c  |  14 +++-
 kernel/bpf/fixups.c          |   4 ++
 kernel/bpf/liveness.c        |  24 ++++++-
 kernel/bpf/verifier.c        | 132 ++++++++++++++++++++++++++++++++++-
 6 files changed, 173 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7719f6528445..cb43792afdee 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -4154,7 +4154,7 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
 			   const char **linep, int *nump);
 struct bpf_prog *bpf_prog_find_from_stack(void);
 
-int bpf_insn_array_init(struct bpf_map *map, const struct bpf_prog *prog);
+int bpf_insn_array_init(struct bpf_map *map, struct bpf_verifier_env *env);
 int bpf_insn_array_ready(struct bpf_map *map);
 void bpf_insn_array_release(struct bpf_map *map);
 void bpf_insn_array_adjust(struct bpf_map *map, u32 off, u32 len);
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 76b8b7627a10..e824b7b64690 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -691,6 +691,9 @@ struct bpf_insn_aux_data {
 	u8 fastcall_spills_num:3;
 	u8 arg_prog:4;
 
+	/* set when the instruction is a SDT probe site */
+	struct bpf_insn_array_value *sdt_entry;
+
 	/* below fields are initialized once */
 	unsigned int orig_idx; /* original instruction index */
 	u32 jmp_point:1;
diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
index aca8676ab563..fe30b08712ff 100644
--- a/kernel/bpf/bpf_insn_array.c
+++ b/kernel/bpf/bpf_insn_array.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2025 Isovalent */
 
 #include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
 
 struct bpf_insn_array {
 	struct bpf_map map;
@@ -198,10 +199,12 @@ static inline bool valid_offsets(const struct bpf_insn_array *insn_array,
 	return true;
 }
 
-int bpf_insn_array_init(struct bpf_map *map, const struct bpf_prog *prog)
+int bpf_insn_array_init(struct bpf_map *map, struct bpf_verifier_env *env)
 {
 	struct bpf_insn_array *insn_array = cast_insn_array(map);
 	struct bpf_insn_array_value *values = insn_array->values;
+	const struct bpf_prog *prog = env->prog;
+	const struct bpf_insn *insn;
 	int i;
 
 	if (!is_frozen(map))
@@ -224,6 +227,15 @@ int bpf_insn_array_init(struct bpf_map *map, const struct bpf_prog *prog)
 	for (i = 0; i < map->max_entries; i++)
 		values[i].xlated_off = values[i].orig_off;
 
+	if (insn_array->subtype == BPF_INSN_ARRAY_SUBTYPE_SDT) {
+		for (i = 0; i < map->max_entries; i++) {
+			insn = &prog->insnsi[values[i].orig_off];
+			if (insn->code != (BPF_JMP | BPF_JA) || insn->off != 0)
+				return -EINVAL;
+			env->insn_aux_data[values[i].orig_off].sdt_entry = &values[i];
+		}
+	}
+
 	return 0;
 }
 
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 3cf2cc6e3ab6..4281c71cde4c 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -568,6 +568,10 @@ int bpf_opt_remove_nops(struct bpf_verifier_env *env)
 		if (!is_may_goto_0 && !is_ja)
 			continue;
 
+		/* SDT probes are NOPs kept for text_poke at attach time. */
+		if (env->insn_aux_data[i].sdt_entry)
+			continue;
+
 		err = verifier_remove_insns(env, i, 1);
 		if (err)
 			return err;
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 0aadfbae0acc..50ab8c29c0eb 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2062,6 +2062,7 @@ struct insn_live_regs {
 /* Compute info->{use,def} fields for the instruction */
 static void compute_insn_live_regs(struct bpf_verifier_env *env,
 				   struct bpf_insn *insn,
+				   int insn_idx,
 				   struct insn_live_regs *info)
 {
 	struct bpf_call_summary cs;
@@ -2163,10 +2164,27 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 		switch (code) {
 		case BPF_JA:
 			def = 0;
-			if (BPF_SRC(insn->code) == BPF_X)
+			if (BPF_SRC(insn->code) == BPF_X) {
 				use = dst;
-			else
+			} else if (env->insn_aux_data[insn_idx].sdt_entry) {
+				struct bpf_insn_array_value *sdt;
+				int i;
+
+				/*
+				 * Without marking the argument registers arg_reg[]
+				 * as live, the liveness pass would clear them before
+				 * the probe site, causing check_sdt_probe() to reject
+				 * the prog with "arg is uninitialized".
+				 */
 				use = 0;
+				sdt = env->insn_aux_data[insn_idx].sdt_entry;
+				for (i = 0; i < sdt->nargs; i++) {
+					if (sdt->arg_reg[i] < BPF_REG_FP)
+						use |= BIT(sdt->arg_reg[i]);
+				}
+			} else {
+				use = 0;
+			}
 			break;
 		case BPF_JCOND:
 			def = 0;
@@ -2238,7 +2256,7 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 	}
 
 	for (i = 0; i < insn_cnt; ++i)
-		compute_insn_live_regs(env, &insns[i], &state[i]);
+		compute_insn_live_regs(env, &insns[i], i, &state[i]);
 
 	/* Forward pass: resolve stack access through FP-derived pointers */
 	err = bpf_compute_subprog_arg_access(env);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 05734163650a..bc972beb80cf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17242,6 +17242,133 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
 	return INSN_IDX_UPDATED;
 }
 
+static int check_sdt_probe(struct bpf_verifier_env *env, int insn_idx)
+{
+	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
+	struct bpf_insn_array_value *val;
+	struct bpf_func_state *frame;
+	struct bpf_reg_state *regs;
+	const struct btf *btf;
+	const struct btf_type *proto;
+	const struct btf_param *args;
+	int i, nargs;
+
+	val = env->insn_aux_data[insn_idx].sdt_entry;
+	if (!val->nargs)
+		return 0;
+
+	if (val->nargs > MAX_BPF_FUNC_REG_ARGS) {
+		verbose(env, "SDT probe nargs %u > 5\n", val->nargs);
+		return -EINVAL;
+	}
+
+	frame = env->cur_state->frame[env->cur_state->curframe];
+	regs = frame->regs;
+
+	for (i = 0; i < val->nargs; i++) {
+		u8 reg = val->arg_reg[i];
+		struct bpf_reg_state *rs = &regs[reg];
+
+		if (rs->type == NOT_INIT) {
+			verbose(env, "SDT arg%d (r%d) is uninitialized\n", i, reg);
+			return -EINVAL;
+		}
+	}
+
+	btf = env->prog->aux->btf;
+	if (!btf || !val->btf_id) {
+		verbose(env, "BTF is required for SDT probe with %u arguments\n", val->nargs);
+		return -EINVAL;
+	}
+
+	proto = btf_type_by_id(btf, val->btf_id);
+	if (!proto || !btf_type_is_func_proto(proto)) {
+		verbose(env, "SDT btf_id %u is not a FUNC_PROTO\n", val->btf_id);
+		return -EINVAL;
+	}
+
+	nargs = btf_type_vlen(proto);
+	if (nargs != val->nargs) {
+		verbose(env, "SDT nargs %u != BTF FUNC_PROTO nargs %d\n",
+			val->nargs, nargs);
+		return -EINVAL;
+	}
+
+	args = (const struct btf_param *)(proto + 1);
+	for (i = 0; i < nargs; i++) {
+		u8 reg = val->arg_reg[i];
+		struct bpf_reg_state *rs = &regs[reg];
+		const struct btf_type *t;
+		u32 arg_btf_id;
+		u32 t_size;
+
+		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
+		t_size = t ? t->size : 0;
+
+		if (btf_type_is_scalar(t)) {
+			if (base_type(rs->type) != SCALAR_VALUE) {
+				verbose(env, "SDT arg%d (r%d) type %s expected scalar\n",
+					i, reg, reg_type_str(env, rs->type));
+				return -EACCES;
+			}
+			continue;
+		}
+
+		/*
+		 * Small structs/unions (<= 8 bytes) are passed by value in
+		 * a register as a SCALAR_VALUE carrying the raw bytes.  The
+		 * BPF_SDT_PROBE<N> macro enforces sizeof(arg) <= 8 at build
+		 * time, so the FUNC_PROTO parameter type is the struct itself
+		 * (not a pointer) and the verifier sees SCALAR_VALUE.
+		 */
+		if (btf_type_is_struct(t) && t_size <= 8) {
+			if (base_type(rs->type) != SCALAR_VALUE) {
+				verbose(env,
+				"SDT arg%d (r%d) type %s expected scalar (small struct by value)\n",
+					i, reg, reg_type_str(env, rs->type));
+				return -EACCES;
+			}
+			continue;
+		}
+
+		if (!btf_type_is_ptr(t)) {
+			verbose(env, "SDT arg%d (r%d) unsupported BTF parameter kind\n",
+				i, reg);
+			return -EACCES;
+		}
+
+		/*
+		 * When the probe argument is the target program's context
+		 * type (e.g. struct xdp_md * for XDP), the register at the
+		 * probe site is PTR_TO_CTX, not PTR_TO_BTF_ID.
+		 */
+		if (base_type(rs->type) == PTR_TO_CTX &&
+		    btf_is_prog_ctx_type(&env->log, btf, t, prog_type, i))
+			continue;
+
+		t = btf_type_skip_modifiers(btf, t->type, &arg_btf_id);
+		if (!btf_type_is_struct(t)) {
+			verbose(env, "SDT arg%d (r%d) unsupported BTF pointer target\n",
+				i, reg);
+			return -EACCES;
+		}
+
+		if (base_type(rs->type) != PTR_TO_BTF_ID) {
+			verbose(env, "SDT arg%d (r%d) type %s expected PTR_TO_BTF_ID\n",
+				i, reg, reg_type_str(env, rs->type));
+			return -EACCES;
+		}
+
+		if (!btf_struct_ids_match(&env->log, rs->btf, rs->btf_id,
+					  rs->var_off.value, btf, arg_btf_id, false)) {
+			verbose(env, "SDT arg%d (r%d) btf_id %u does not match expected %u\n",
+				i, reg, rs->btf_id, arg_btf_id);
+			return -EACCES;
+		}
+	}
+	return 0;
+}
+
 static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 {
 	int err;
@@ -17317,6 +17444,9 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 			if (BPF_SRC(insn->code) == BPF_X)
 				return check_indirect_jump(env, insn);
 
+			if (env->insn_aux_data[env->insn_idx].sdt_entry)
+				return check_sdt_probe(env, env->insn_idx);
+
 			if (class == BPF_JMP)
 				env->insn_idx += insn->off + 1;
 			else
@@ -17882,7 +18012,7 @@ static int __add_used_map(struct bpf_verifier_env *env, struct bpf_map *map)
 	env->used_maps[env->used_map_cnt++] = map;
 
 	if (map->map_type == BPF_MAP_TYPE_INSN_ARRAY) {
-		err = bpf_insn_array_init(map, env->prog);
+		err = bpf_insn_array_init(map, env);
 		if (err) {
 			verbose(env, "Failed to properly initialize insn array\n");
 			return err;
-- 
2.47.3

