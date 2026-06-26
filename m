Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730283FB074
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488708; cv=none; b=ZXxnCseH9tAKvzMiU/CWRnu6MFtUgyCcUKCkpbLRh12CNSWMO2X3SMj9uwQ9bOjs/1+qmPJBkbjldsn5a8v+Y7YAsygX30B52vnwa8YGEj0gH6vex3n14bOkZ9UpsTW23jKFyyM3poAZ13ESTRuWj02aYQLfL+sPgXFak6iyhvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488708; c=relaxed/simple;
	bh=S36dmioeq5JmxpvklqSOgRjgekgZWFLUGP2U60Q1Qvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONzJgz/0iaNgAF2d+gs5rVH42V+/wzPG0xfC4iGD8/Fx+cpJvhn7XbReaIFQLTeAwF0DYCK21x8WkefXYufqImHV9pPvZLhrk+IaVM6WLCoZs1u7qxbCy3bVA8XFSjLcnXBeGskVAF+4uFwXLl5tkv9rmZYpvByq9teCRMHOsSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vPJtmDek; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vPJtmDek"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782488696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fTDoUKeEHrD91QYn6iazNfbdz5n3erK/7aI8Py32sAs=;
	b=vPJtmDekV7x6OKA9YMJ54N9rSpz3OpvbgYU7Ol6NMDjfRau/uGjSDYNiABB13HpiL+l/JA
	mSuzLh3owAbZL22SOp7x4ZTRNbOuCf/CdpizlNR94j7GlidkVI7kvelILztPLmQNo814r6
	zQ+X26QmpChS0dymqS8b/Xh5GDrmIyg=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf 6/6] lib/test_bpf: Add interpreter-fallback tests
Date: Fri, 26 Jun 2026 23:43:30 +0800
Message-ID: <20260626154330.33619-7-leon.hwang@linux.dev>
In-Reply-To: <20260626154330.33619-1-leon.hwang@linux.dev>
References: <20260626154330.33619-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add following tests to verify interpreter-fallback issues:

* arena-related insns, such as user ADDR_SPACE_CAST insn, ST/STX/LDX
  insns, are not recognized by the interpreter.
* the internal ADDR_PERCPU insn is not recognized by the interpreter.
* the internal PROBE_ATOMIC insn is not recognized by the interpreter,
  too.
* the gotox insn used for indirect jumps is not recognized by the
  interpreter.

With the fixes, all of them are rejected by returning -EOPNOTSUPP.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h                      |   1 +
 include/linux/filter.h                   |   4 +
 kernel/bpf/core.c                        |  15 +
 lib/test_bpf.c                           | 800 ++++++++++++++++++++++-
 tools/lib/bpf/skel_internal.h            |   2 +
 tools/testing/selftests/bpf/test_kmod.sh |  39 +-
 6 files changed, 855 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7719f6528445..7baab7dd3444 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2699,6 +2699,7 @@ extern const struct bpf_prog_ops bpf_offload_prog_ops;
 extern const struct bpf_verifier_ops tc_cls_act_analyzer_ops;
 extern const struct bpf_verifier_ops xdp_analyzer_ops;
 
+int kern_sys_bpf(int cmd, union bpf_attr *attr, unsigned int size);
 struct bpf_prog *bpf_prog_get(u32 ufd);
 struct bpf_prog *bpf_prog_get_type_dev(u32 ufd, enum bpf_prog_type type,
 				       bool attach_drv);
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 67d337ede91b..82d349ee03ed 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1312,6 +1312,10 @@ extern int bpf_jit_kallsyms;
 extern long bpf_jit_limit;
 extern long bpf_jit_limit_max;
 
+#if IS_ENABLED(CONFIG_TEST_BPF)
+void bpf_jit_set_test_force_fail(bool force);
+#endif
+
 typedef void (*bpf_jit_fill_hole_t)(void *area, unsigned int size);
 
 void bpf_jit_fill_hole_with_zero(void *area, unsigned int size);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 427d4e54ede4..6b28c8641b26 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -550,6 +550,16 @@ int bpf_jit_harden   __read_mostly;
 long bpf_jit_limit   __read_mostly;
 long bpf_jit_limit_max __read_mostly;
 
+#if IS_ENABLED(CONFIG_TEST_BPF)
+static struct task_struct *bpf_jit_test_fail_task;
+
+void bpf_jit_set_test_force_fail(bool force)
+{
+	WRITE_ONCE(bpf_jit_test_fail_task, force ? current : NULL);
+}
+EXPORT_SYMBOL_GPL(bpf_jit_set_test_force_fail);
+#endif
+
 static void
 bpf_prog_ksym_set_addr(struct bpf_prog *prog)
 {
@@ -2567,6 +2577,11 @@ static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struc
 	struct bpf_prog *orig_prog;
 	struct bpf_insn_aux_data *orig_insn_aux;
 
+#if IS_ENABLED(CONFIG_TEST_BPF)
+	if (unlikely(READ_ONCE(bpf_jit_test_fail_task) == current))
+		return prog;
+#endif
+
 	if (!bpf_prog_need_blind(prog))
 		return bpf_int_jit_compile(env, prog);
 
diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index af6f3340c034..8bf227e8ab75 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/filter.h>
 #include <linux/bpf.h>
+#include <linux/fdtable.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 #include <linux/if_vlan.h>
@@ -15786,6 +15787,778 @@ static __init int test_tail_calls(struct bpf_array *progs)
 static char test_suite[32];
 module_param_string(test_suite, test_suite, sizeof(test_suite), 0);
 
+#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_BPF_JIT) && !defined(CONFIG_UML)
+#define CAN_TEST_INTERPRETER_FALLBACK
+
+struct test_bpf_insn_array {
+	struct bpf_map map;
+	atomic_t used;
+	long *ips;
+};
+
+enum interpreter_fallback_expect {
+	EXPECT_LOAD_REJECT,
+	EXPECT_LOAD_RUN,
+};
+
+struct interpreter_fallback_test {
+	const char *name;
+	bool (*supported)(void);
+	int (*load)(void);
+	int (*verify)(const struct bpf_prog *prog);
+	int (*check_result)(u32 retval);
+	void (*cleanup)(void);
+	enum interpreter_fallback_expect expect;
+	u32 retval;
+};
+
+static __init int prog_load(const struct bpf_insn *insns, u32 insn_cnt)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, license);
+	union bpf_attr attr = {
+		.prog_type = BPF_PROG_TYPE_SOCKET_FILTER,
+		.insn_cnt = insn_cnt,
+		.insns = (long)insns,
+		.license = (long)"GPL",
+	};
+
+	return kern_sys_bpf(BPF_PROG_LOAD, &attr, attr_sz);
+}
+
+static __init int map_create(enum bpf_map_type map_type, u32 key_size,
+			     u32 value_size, u32 max_entries, u32 map_flags,
+			     u64 map_extra)
+{
+	union bpf_attr attr = {
+		.map_type = map_type,
+		.key_size = key_size,
+		.value_size = value_size,
+		.max_entries = max_entries,
+		.map_flags = map_flags,
+		.map_extra = map_extra,
+	};
+
+	return kern_sys_bpf(BPF_MAP_CREATE, &attr, sizeof(attr));
+}
+
+static __init int map_update(int map_fd, const void *key, const void *value)
+{
+	union bpf_attr attr = {
+		.map_fd = map_fd,
+		.key = (long)key,
+		.value = (long)value,
+		.flags = BPF_ANY,
+	};
+
+	return kern_sys_bpf(BPF_MAP_UPDATE_ELEM, &attr, sizeof(attr));
+}
+
+static __init int map_freeze(int map_fd)
+{
+	union bpf_attr attr = {
+		.map_fd = map_fd,
+	};
+
+	return kern_sys_bpf(BPF_MAP_FREEZE, &attr, sizeof(attr));
+}
+
+static __init int check_interpreter_fallback_env(void)
+{
+	const struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(R0, 0),
+		BPF_EXIT_INSN(),
+	};
+	struct bpf_prog *prog;
+	int prog_fd, err = 0;
+
+	prog_fd = prog_load(insns, ARRAY_SIZE(insns));
+	if (prog_fd < 0)
+		return prog_fd;
+
+	prog = bpf_prog_get_type_dev(prog_fd, BPF_PROG_TYPE_SOCKET_FILTER,
+				     false);
+	close_fd(prog_fd);
+	if (IS_ERR(prog))
+		return PTR_ERR(prog);
+
+	if (!prog->jit_requested || prog->jited)
+		err = -EAGAIN;
+
+	bpf_prog_put(prog);
+	return err;
+}
+
+static __init bool x86_interpreter_fallback_supported(void)
+{
+	return IS_ENABLED(CONFIG_X86_64) && IS_ENABLED(CONFIG_SMP);
+}
+
+static __init bool jit_inline_helper_supported(void)
+{
+	return IS_ENABLED(CONFIG_X86_64) ||
+	       IS_ENABLED(CONFIG_ARM64) ||
+	       IS_ENABLED(CONFIG_ARCH_RV64I) ||
+	       IS_ENABLED(CONFIG_S390) ||
+	       IS_ENABLED(CONFIG_PPC);
+}
+
+static __init int load_addr_percpu_prog(void)
+{
+	const struct bpf_insn insns[] = {
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+			     BPF_FUNC_get_smp_processor_id),
+		BPF_EXIT_INSN(),
+	};
+
+	return prog_load(insns, ARRAY_SIZE(insns));
+}
+
+static __init int verify_addr_percpu_prog(const struct bpf_prog *prog)
+{
+	const struct bpf_insn *insn = prog->insnsi;
+
+	if (prog->len != 4)
+		goto unexpected;
+
+	if (insn[0].code != (BPF_ALU64 | BPF_MOV | BPF_K) ||
+	    insn[0].dst_reg != BPF_REG_0 ||
+	    insn[0].src_reg != BPF_REG_0 ||
+	    insn[0].off != 0)
+		goto unexpected;
+
+	if (!insn_is_mov_percpu_addr(&insn[1]) ||
+	    insn[1].dst_reg != BPF_REG_0 ||
+	    insn[1].src_reg != BPF_REG_0 ||
+	    insn[1].imm != 0)
+		goto unexpected;
+
+	if (insn[2].code != (BPF_LDX | BPF_MEM | BPF_W) ||
+	    insn[2].dst_reg != BPF_REG_0 ||
+	    insn[2].src_reg != BPF_REG_0 ||
+	    insn[2].off != 0 ||
+	    insn[2].imm != 0)
+		goto unexpected;
+
+	if (insn[3].code != (BPF_JMP | BPF_EXIT) ||
+	    insn[3].dst_reg != BPF_REG_0 ||
+	    insn[3].src_reg != BPF_REG_0 ||
+	    insn[3].off != 0 ||
+	    insn[3].imm != 0)
+		goto unexpected;
+
+	pr_info("ADDR_PERCPU: verified BPF_MOV64_PERCPU_REG in prog->insnsi\n");
+	return 0;
+
+unexpected:
+	pr_info("ADDR_PERCPU: unexpected prog->insnsi, len=%u\n", prog->len);
+	return -EINVAL;
+}
+
+static __init int load_jit_inline_helper_prog(void)
+{
+	const struct bpf_insn insns[] = {
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+			     BPF_FUNC_get_smp_processor_id),
+		BPF_MOV64_IMM(R0, 0),
+		BPF_EXIT_INSN(),
+	};
+
+	return prog_load(insns, ARRAY_SIZE(insns));
+}
+
+#define BPF_CAST_ADDR_SPACE(REG, IMM)					\
+	BPF_RAW_INSN(BPF_ALU64 | BPF_MOV | BPF_X, REG, REG,		\
+		     BPF_ADDR_SPACE_CAST, IMM)
+
+#define TEST_ARENA_USER_ADDR ((1ULL << 44) | PAGE_SIZE)
+
+static int addr_space_cast_result_map_fd __initdata = -1;
+
+static __init int load_arena_prog(struct bpf_insn *insns, u32 insn_cnt)
+{
+	int map_fd, prog_fd;
+
+	map_fd = map_create(BPF_MAP_TYPE_ARENA, 0, 0, 1, BPF_F_MMAPABLE,
+			    TEST_ARENA_USER_ADDR);
+	if (map_fd < 0)
+		return map_fd;
+
+	insns[0].imm = map_fd;
+	prog_fd = prog_load(insns, insn_cnt);
+	close_fd(map_fd);
+	return prog_fd;
+}
+
+static __init void cleanup_addr_space_cast_prog(void)
+{
+	if (addr_space_cast_result_map_fd < 0)
+		return;
+
+	close_fd(addr_space_cast_result_map_fd);
+	addr_space_cast_result_map_fd = -1;
+}
+
+static __init int load_addr_space_cast_prog(void)
+{
+	enum {
+		ARENA_MAP_INSN = 0,
+		RESULT_MAP_INSN = 6,
+	};
+	struct bpf_insn insns[] = {
+		BPF_LD_IMM64_RAW(R1, BPF_PSEUDO_MAP_VALUE, 0),
+		BPF_CAST_ADDR_SPACE(R1, 1),
+		BPF_CAST_ADDR_SPACE(R1, 1U << 16),
+		BPF_MOV64_REG(R0, R1),
+		BPF_ALU64_IMM(BPF_RSH, R0, 32),
+		BPF_LD_IMM64_RAW(R2, BPF_PSEUDO_MAP_VALUE, 0),
+		BPF_JMP_IMM(BPF_JNE, R0, TEST_ARENA_USER_ADDR >> 32, 3),
+		BPF_MOV64_IMM(R0, 0),
+		BPF_STX_MEM(BPF_W, R2, R0, 0),
+		BPF_EXIT_INSN(),
+		BPF_MOV64_IMM(R0, 1),
+		BPF_STX_MEM(BPF_W, R2, R0, 0),
+		BPF_EXIT_INSN(),
+	};
+	u32 key = 0, value = U32_MAX;
+	int arena_fd, prog_fd, result_fd;
+	int err;
+
+	cleanup_addr_space_cast_prog();
+
+	arena_fd = map_create(BPF_MAP_TYPE_ARENA, 0, 0, 1, BPF_F_MMAPABLE,
+			      TEST_ARENA_USER_ADDR);
+	if (arena_fd < 0)
+		return arena_fd;
+
+	result_fd = map_create(BPF_MAP_TYPE_ARRAY, sizeof(key), sizeof(value),
+			       1, 0, 0);
+	if (result_fd < 0) {
+		prog_fd = result_fd;
+		goto out_close_arena;
+	}
+
+	addr_space_cast_result_map_fd = result_fd;
+
+	err = map_update(result_fd, &key, &value);
+	if (err) {
+		prog_fd = err;
+		goto out_cleanup_result;
+	}
+
+	insns[ARENA_MAP_INSN].imm = arena_fd;
+	insns[RESULT_MAP_INSN].imm = result_fd;
+	prog_fd = prog_load(insns, ARRAY_SIZE(insns));
+	if (prog_fd < 0)
+		goto out_cleanup_result;
+
+	close_fd(arena_fd);
+	return prog_fd;
+
+out_cleanup_result:
+	cleanup_addr_space_cast_prog();
+out_close_arena:
+	close_fd(arena_fd);
+	return prog_fd;
+}
+
+static __init int verify_addr_space_cast_prog(const struct bpf_prog *prog)
+{
+	const struct bpf_insn *insn = prog->insnsi;
+
+	if (prog->len != 15)
+		goto unexpected;
+
+	if (insn[0].code != (BPF_LD | BPF_IMM | BPF_DW) ||
+	    insn[0].dst_reg != BPF_REG_1 ||
+	    insn[0].src_reg != BPF_REG_0 ||
+	    insn[0].off != 0 ||
+	    insn[1].code != 0 ||
+	    insn[1].dst_reg != BPF_REG_0 ||
+	    insn[1].src_reg != BPF_REG_0 ||
+	    insn[1].off != 0)
+		goto unexpected;
+
+	if (insn[2].code != (BPF_ALU | BPF_MOV | BPF_X) ||
+	    insn[2].dst_reg != BPF_REG_1 ||
+	    insn[2].src_reg != BPF_REG_1 ||
+	    insn[2].off != 0 ||
+	    insn[2].imm != 0)
+		goto unexpected;
+
+	if (insn[3].code != (BPF_ALU64 | BPF_MOV | BPF_X) ||
+	    insn[3].dst_reg != BPF_REG_1 ||
+	    insn[3].src_reg != BPF_REG_1 ||
+	    insn[3].off != BPF_ADDR_SPACE_CAST ||
+	    insn[3].imm != 1U << 16)
+		goto unexpected;
+
+	if (insn[4].code != (BPF_ALU64 | BPF_MOV | BPF_X) ||
+	    insn[4].dst_reg != BPF_REG_0 ||
+	    insn[4].src_reg != BPF_REG_1 ||
+	    insn[4].off != 0 ||
+	    insn[4].imm != 0)
+		goto unexpected;
+
+	if (insn[5].code != (BPF_ALU64 | BPF_RSH | BPF_K) ||
+	    insn[5].dst_reg != BPF_REG_0 ||
+	    insn[5].src_reg != BPF_REG_0 ||
+	    insn[5].off != 0 ||
+	    insn[5].imm != 32)
+		goto unexpected;
+
+	if (insn[6].code != (BPF_LD | BPF_IMM | BPF_DW) ||
+	    insn[6].dst_reg != BPF_REG_2 ||
+	    insn[6].src_reg != BPF_REG_0 ||
+	    insn[6].off != 0 ||
+	    insn[7].code != 0 ||
+	    insn[7].dst_reg != BPF_REG_0 ||
+	    insn[7].src_reg != BPF_REG_0 ||
+	    insn[7].off != 0)
+		goto unexpected;
+
+	if (insn[8].code != (BPF_JMP | BPF_JNE | BPF_K) ||
+	    insn[8].dst_reg != BPF_REG_0 ||
+	    insn[8].src_reg != BPF_REG_0 ||
+	    insn[8].off != 3 ||
+	    insn[8].imm != TEST_ARENA_USER_ADDR >> 32)
+		goto unexpected;
+
+	if (insn[9].code != (BPF_ALU64 | BPF_MOV | BPF_K) ||
+	    insn[9].dst_reg != BPF_REG_0 ||
+	    insn[9].src_reg != BPF_REG_0 ||
+	    insn[9].off != 0 ||
+	    insn[9].imm != 0 ||
+	    insn[10].code != (BPF_STX | BPF_MEM | BPF_W) ||
+	    insn[10].dst_reg != BPF_REG_2 ||
+	    insn[10].src_reg != BPF_REG_0 ||
+	    insn[10].off != 0 ||
+	    insn[10].imm != 0)
+		goto unexpected;
+
+	if (insn[11].code != (BPF_JMP | BPF_EXIT) ||
+	    insn[11].dst_reg != BPF_REG_0 ||
+	    insn[11].src_reg != BPF_REG_0 ||
+	    insn[11].off != 0 ||
+	    insn[11].imm != 0)
+		goto unexpected;
+
+	if (insn[12].code != (BPF_ALU64 | BPF_MOV | BPF_K) ||
+	    insn[12].dst_reg != BPF_REG_0 ||
+	    insn[12].src_reg != BPF_REG_0 ||
+	    insn[12].off != 0 ||
+	    insn[12].imm != 1 ||
+	    insn[13].code != (BPF_STX | BPF_MEM | BPF_W) ||
+	    insn[13].dst_reg != BPF_REG_2 ||
+	    insn[13].src_reg != BPF_REG_0 ||
+	    insn[13].off != 0 ||
+	    insn[13].imm != 0)
+		goto unexpected;
+
+	if (insn[14].code != (BPF_JMP | BPF_EXIT) ||
+	    insn[14].dst_reg != BPF_REG_0 ||
+	    insn[14].src_reg != BPF_REG_0 ||
+	    insn[14].off != 0 ||
+	    insn[14].imm != 0)
+		goto unexpected;
+
+	pr_info("ADDR_SPACE_CAST: verified BPF_ADDR_SPACE_CAST in prog->insnsi\n");
+	return 0;
+
+unexpected:
+	pr_info("ADDR_SPACE_CAST: unexpected prog->insnsi, len=%u\n",
+		prog->len);
+	return -EINVAL;
+}
+
+static __init int check_addr_space_cast_result(u32 retval)
+{
+	struct bpf_map *map;
+	void *ptr;
+	u32 key = 0, value = U32_MAX;
+	int err = 0;
+
+	if (addr_space_cast_result_map_fd < 0) {
+		pr_info("ADDR_SPACE_CAST: result map is not available\n");
+		return -EINVAL;
+	}
+
+	map = bpf_map_get(addr_space_cast_result_map_fd);
+	if (IS_ERR(map)) {
+		err = PTR_ERR(map);
+		pr_info("ADDR_SPACE_CAST: result map get failed err=%d\n", err);
+		return err;
+	}
+
+	rcu_read_lock();
+	ptr = map->ops->map_lookup_elem(map, &key);
+	if (IS_ERR(ptr))
+		err = PTR_ERR(ptr);
+	else if (!ptr)
+		err = -ENOENT;
+	else
+		value = READ_ONCE(*(u32 *)ptr);
+	rcu_read_unlock();
+	bpf_map_put(map);
+
+	if (err) {
+		pr_info("ADDR_SPACE_CAST: result map lookup failed err=%d\n",
+			err);
+		return err;
+	}
+
+	pr_info("ADDR_SPACE_CAST: retval=%u map_value=%u\n", retval, value);
+	if (value != retval) {
+		pr_info("ADDR_SPACE_CAST: result map value mismatch\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static __init int load_arena_st_prog(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_LD_IMM64_RAW(R1, BPF_PSEUDO_MAP_VALUE, 0),
+		BPF_CAST_ADDR_SPACE(R1, 1),
+		BPF_ST_MEM(BPF_W, R1, 0, 0),
+		BPF_MOV64_IMM(R0, 0),
+		BPF_EXIT_INSN(),
+	};
+
+	return load_arena_prog(insns, ARRAY_SIZE(insns));
+}
+
+static __init int load_arena_ldx_prog(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_LD_IMM64_RAW(R1, BPF_PSEUDO_MAP_VALUE, 0),
+		BPF_CAST_ADDR_SPACE(R1, 1),
+		BPF_LDX_MEM(BPF_W, R0, R1, 0),
+		BPF_EXIT_INSN(),
+	};
+
+	return load_arena_prog(insns, ARRAY_SIZE(insns));
+}
+
+static __init int load_arena_ldxsx_prog(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_LD_IMM64_RAW(R1, BPF_PSEUDO_MAP_VALUE, 0),
+		BPF_CAST_ADDR_SPACE(R1, 1),
+		BPF_LDX_MEMSX(BPF_W, R0, R1, 0),
+		BPF_EXIT_INSN(),
+	};
+
+	return load_arena_prog(insns, ARRAY_SIZE(insns));
+}
+
+static __init int load_arena_stx_prog(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_LD_IMM64_RAW(R1, BPF_PSEUDO_MAP_VALUE, 0),
+		BPF_CAST_ADDR_SPACE(R1, 1),
+		BPF_MOV64_IMM(R2, 0),
+		BPF_STX_MEM(BPF_W, R1, R2, 0),
+		BPF_MOV64_IMM(R0, 0),
+		BPF_EXIT_INSN(),
+	};
+
+	return load_arena_prog(insns, ARRAY_SIZE(insns));
+}
+
+static __init int load_acquire_prog(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_LD_IMM64_RAW(R1, BPF_PSEUDO_MAP_VALUE, 0),
+		BPF_CAST_ADDR_SPACE(R1, 1),
+		BPF_ATOMIC_OP(BPF_W, BPF_LOAD_ACQ, R0, R1, 0),
+		BPF_EXIT_INSN(),
+	};
+
+	return load_arena_prog(insns, ARRAY_SIZE(insns));
+}
+
+static __init int store_release_prog(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_LD_IMM64_RAW(R1, BPF_PSEUDO_MAP_VALUE, 0),
+		BPF_CAST_ADDR_SPACE(R1, 1),
+		BPF_MOV64_IMM(R2, 0),
+		BPF_ATOMIC_OP(BPF_W, BPF_STORE_REL, R1, R2, 0),
+		BPF_MOV64_IMM(R0, 0),
+		BPF_EXIT_INSN(),
+	};
+
+	return load_arena_prog(insns, ARRAY_SIZE(insns));
+}
+
+static __init int load_gotox_prog(void)
+{
+	struct bpf_insn_array_value value = {
+		.orig_off = 4,
+	};
+	struct bpf_insn insns[] = {
+		BPF_LD_IMM64_RAW(R0, BPF_PSEUDO_MAP_VALUE, 0),
+		BPF_LDX_MEM(BPF_DW, R0, R0, 0),
+		BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, R0, 0, 0, 0),
+		BPF_MOV64_IMM(R0, 0),
+		BPF_EXIT_INSN(),
+	};
+	struct test_bpf_insn_array *array;
+	struct bpf_map *map;
+	u32 key = 0;
+	int map_fd, prog_fd;
+	int err;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, sizeof(key),
+			    sizeof(value), 1, 0, 0);
+	if (map_fd < 0)
+		return map_fd;
+
+	err = map_update(map_fd, &key, &value);
+	if (err)
+		goto out_close_map;
+
+	err = map_freeze(map_fd);
+	if (err)
+		goto out_close_map;
+
+	map = bpf_map_get(map_fd);
+	if (IS_ERR(map)) {
+		err = PTR_ERR(map);
+		goto out_close_map;
+	}
+
+	array = container_of(map, struct test_bpf_insn_array, map);
+	WRITE_ONCE(array->ips[0], 1);
+	bpf_map_put(map);
+
+	insns[0].imm = map_fd;
+	prog_fd = prog_load(insns, ARRAY_SIZE(insns));
+	close_fd(map_fd);
+	return prog_fd;
+
+out_close_map:
+	close_fd(map_fd);
+	return err;
+}
+
+static struct interpreter_fallback_test interpreter_fallback_tests[] __initdata = {
+	{
+		.name = "ADDR_PERCPU",
+		.supported = x86_interpreter_fallback_supported,
+		.load = load_addr_percpu_prog,
+		.verify = verify_addr_percpu_prog,
+		.expect = EXPECT_LOAD_REJECT,
+	},
+	{
+		.name = "ADDR_SPACE_CAST",
+		.supported = x86_interpreter_fallback_supported,
+		.load = load_addr_space_cast_prog,
+		.verify = verify_addr_space_cast_prog,
+		.check_result = check_addr_space_cast_result,
+		.cleanup = cleanup_addr_space_cast_prog,
+		.expect = EXPECT_LOAD_REJECT,
+	},
+	{
+		.name = "JIT_INLINE_HELPER",
+		.supported = jit_inline_helper_supported,
+		.load = load_jit_inline_helper_prog,
+		.expect = EXPECT_LOAD_REJECT,
+		.retval = 0,
+	},
+	{
+		.name = "ARENA_ST",
+		.supported = x86_interpreter_fallback_supported,
+		.load = load_arena_st_prog,
+		.expect = EXPECT_LOAD_REJECT,
+	},
+	{
+		.name = "ARENA_LDX",
+		.supported = x86_interpreter_fallback_supported,
+		.load = load_arena_ldx_prog,
+		.expect = EXPECT_LOAD_REJECT,
+	},
+	{
+		.name = "ARENA_LDXSX",
+		.supported = x86_interpreter_fallback_supported,
+		.load = load_arena_ldxsx_prog,
+		.expect = EXPECT_LOAD_REJECT,
+	},
+	{
+		.name = "ARENA_STX",
+		.supported = x86_interpreter_fallback_supported,
+		.load = load_arena_stx_prog,
+		.expect = EXPECT_LOAD_REJECT,
+	},
+	{
+		.name = "LOAD_ACQ",
+		.supported = x86_interpreter_fallback_supported,
+		.load = load_acquire_prog,
+		.expect = EXPECT_LOAD_REJECT,
+	},
+	{
+		.name = "STORE_REL",
+		.supported = x86_interpreter_fallback_supported,
+		.load = store_release_prog,
+		.expect = EXPECT_LOAD_REJECT,
+	},
+	{
+		.name = "GOTOX",
+		.supported = x86_interpreter_fallback_supported,
+		.load = load_gotox_prog,
+		.expect = EXPECT_LOAD_REJECT,
+	},
+};
+
+#define INTERPRETER_FALLBACK_TEST_CNT ARRAY_SIZE(interpreter_fallback_tests)
+
+static __init int run_prog(int prog_fd,
+			   const struct interpreter_fallback_test *test,
+			   u32 *retval)
+{
+	struct bpf_prog *prog;
+	int err = 0;
+
+	prog = bpf_prog_get_type_dev(prog_fd, BPF_PROG_TYPE_SOCKET_FILTER,
+				     false);
+	close_fd(prog_fd);
+	if (IS_ERR(prog))
+		return PTR_ERR(prog);
+
+	if (test->verify) {
+		err = test->verify(prog);
+		if (err)
+			goto out_put_prog;
+	}
+
+	migrate_disable();
+	*retval = bpf_prog_run(prog, NULL);
+	migrate_enable();
+
+	if (test->check_result) {
+		err = test->check_result(*retval);
+		if (err)
+			goto out_put_prog;
+	}
+
+out_put_prog:
+	bpf_prog_put(prog);
+	return err;
+}
+#else
+#define INTERPRETER_FALLBACK_TEST_CNT 1
+#endif
+
+static __init int test_interpreter_fallback(void)
+{
+#ifdef CAN_TEST_INTERPRETER_FALLBACK
+	int err_cnt = 0, pass_cnt = 0, skip_cnt = 0;
+	int err, i;
+
+	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON)) {
+		pr_info("interpreter fallback: SKIP (JIT always on)\n");
+		return 0;
+	}
+
+	bpf_jit_set_test_force_fail(true);
+	err = check_interpreter_fallback_env();
+	if (err == -EAGAIN) {
+		pr_info("interpreter fallback: SKIP (JIT fallback environment not set)\n");
+		err = 0;
+		goto out_disable_force_fail;
+	}
+	if (err) {
+		pr_info("interpreter fallback: FAIL to verify environment err=%d\n",
+			err);
+		goto out_disable_force_fail;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(interpreter_fallback_tests); i++) {
+		const struct interpreter_fallback_test *test;
+		u32 retval;
+		int prog_fd;
+
+		if (exclude_test(i))
+			continue;
+
+		test = &interpreter_fallback_tests[i];
+		if (test->supported && !test->supported()) {
+			pr_info("#%d %s: SKIP\n", i, test->name);
+			skip_cnt++;
+			goto next_test;
+		}
+
+		pr_info("#%d %s: loading\n", i, test->name);
+
+		prog_fd = test->load();
+
+		if (test->expect == EXPECT_LOAD_REJECT) {
+			if (prog_fd == -EOPNOTSUPP) {
+				pr_info("#%d %s: PASS\n", i, test->name);
+				pass_cnt++;
+				goto next_test;
+			}
+
+			if (prog_fd < 0)
+				pr_info("#%d %s: FAIL prog_load returned %d, expected %d\n",
+					i, test->name, prog_fd, -EOPNOTSUPP);
+			else {
+				err = run_prog(prog_fd, test, &retval);
+				if (err)
+					pr_info("#%d %s: FAIL to run loaded prog err=%d\n",
+						i, test->name, err);
+				else
+					pr_info("#%d %s: FAIL prog loaded and returned %u\n",
+						i, test->name, retval);
+			}
+			err_cnt++;
+			goto next_test;
+		}
+
+		if (prog_fd < 0) {
+			pr_info("#%d %s: FAIL prog_load returned %d\n",
+				i, test->name, prog_fd);
+			err_cnt++;
+			goto next_test;
+		}
+
+		err = run_prog(prog_fd, test, &retval);
+		if (err) {
+			pr_info("#%d %s: FAIL to run loaded prog err=%d\n",
+				i, test->name, err);
+			err_cnt++;
+			goto next_test;
+		}
+
+		if (retval != test->retval) {
+			pr_info("#%d %s: FAIL prog returned %u, expected %u\n",
+				i, test->name, retval, test->retval);
+			err_cnt++;
+			goto next_test;
+		}
+
+		pr_info("#%d %s: PASS\n", i, test->name);
+		pass_cnt++;
+
+next_test:
+		if (test->cleanup)
+			test->cleanup();
+	}
+
+	pr_info("interpreter fallback: Summary: %d PASSED, %d SKIPPED, %d FAILED\n",
+		pass_cnt, skip_cnt, err_cnt);
+	err = err_cnt ? -EINVAL : 0;
+
+out_disable_force_fail:
+	bpf_jit_set_test_force_fail(false);
+	return err;
+#else
+	pr_info("interpreter fallback: SKIP (unsupported configuration)\n");
+	return 0;
+#endif
+}
+
 static __init int find_test_index(const char *test_name)
 {
 	int i;
@@ -15811,6 +16584,15 @@ static __init int find_test_index(const char *test_name)
 		}
 	}
 
+	if (!strcmp(test_suite, "test_interpreter_fallback")) {
+#ifdef CAN_TEST_INTERPRETER_FALLBACK
+		for (i = 0; i < ARRAY_SIZE(interpreter_fallback_tests); i++) {
+			if (!strcmp(interpreter_fallback_tests[i].name, test_name))
+				return i;
+		}
+#endif
+	}
+
 	return -1;
 }
 
@@ -15824,6 +16606,8 @@ static __init int prepare_test_range(void)
 		valid_range = ARRAY_SIZE(tail_call_tests);
 	else if (!strcmp(test_suite, "test_skb_segment"))
 		valid_range = ARRAY_SIZE(skb_segment_tests);
+	else if (!strcmp(test_suite, "test_interpreter_fallback"))
+		valid_range = INTERPRETER_FALLBACK_TEST_CNT;
 	else
 		return 0;
 
@@ -15881,7 +16665,8 @@ static int __init test_bpf_init(void)
 	if (strlen(test_suite) &&
 	    strcmp(test_suite, "test_bpf") &&
 	    strcmp(test_suite, "test_tail_calls") &&
-	    strcmp(test_suite, "test_skb_segment")) {
+	    strcmp(test_suite, "test_skb_segment") &&
+	    strcmp(test_suite, "test_interpreter_fallback")) {
 		pr_err("test_bpf: invalid test_suite '%s' specified.\n", test_suite);
 		return -EINVAL;
 	}
@@ -15917,8 +16702,14 @@ static int __init test_bpf_init(void)
 			return ret;
 	}
 
-	if (!strlen(test_suite) || !strcmp(test_suite, "test_skb_segment"))
-		return test_skb_segment();
+	if (!strlen(test_suite) || !strcmp(test_suite, "test_skb_segment")) {
+		ret = test_skb_segment();
+		if (ret)
+			return ret;
+	}
+
+	if (!strcmp(test_suite, "test_interpreter_fallback"))
+		return test_interpreter_fallback();
 
 	return 0;
 }
@@ -15930,5 +16721,8 @@ static void __exit test_bpf_exit(void)
 module_init(test_bpf_init);
 module_exit(test_bpf_exit);
 
+#ifdef CAN_TEST_INTERPRETER_FALLBACK
+MODULE_IMPORT_NS("BPF_INTERNAL");
+#endif
 MODULE_DESCRIPTION("Testsuite for BPF interpreter and BPF JIT compiler");
 MODULE_LICENSE("GPL");
diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index 74503d358bc8..ede991cb0cdc 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -76,7 +76,9 @@ struct bpf_load_and_run_opts {
 	__u32 excl_prog_hash_sz;
 };
 
+#ifndef __KERNEL__
 long kern_sys_bpf(__u32 cmd, void *attr, __u32 attr_size);
+#endif
 
 static inline int skel_sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
 			  unsigned int size)
diff --git a/tools/testing/selftests/bpf/test_kmod.sh b/tools/testing/selftests/bpf/test_kmod.sh
index 50dca53ac536..6dbad2a6ef0a 100755
--- a/tools/testing/selftests/bpf/test_kmod.sh
+++ b/tools/testing/selftests/bpf/test_kmod.sh
@@ -47,14 +47,14 @@ test_run()
 			rc=1
 		fi
 	fi
-	rmmod  test_bpf 2> /dev/null
+	rmmod test_bpf 2> /dev/null
 	dmesg | grep FAIL
 }
 
 test_save()
 {
-	JE=`sysctl -n net.core.bpf_jit_enable`
-	JH=`sysctl -n net.core.bpf_jit_harden`
+	JE=$(sysctl -n net.core.bpf_jit_enable)
+	JH=$(sysctl -n net.core.bpf_jit_harden)
 }
 
 test_restore()
@@ -63,11 +63,44 @@ test_restore()
 	sysctl -w net.core.bpf_jit_harden=$JH 2>&1 > /dev/null
 }
 
+test_interpreter_fallback()
+{
+	if ! sysctl -w net.core.bpf_jit_enable=1 >/dev/null 2>&1 ||
+		! sysctl -w net.core.bpf_jit_harden=0 >/dev/null 2>&1; then
+		echo "[ interpreter fallback: SKIP ]"
+		return
+	fi
+
+	echo "[ interpreter fallback ]"
+	dmesg -C
+	if [ -f ${OUTPUT}/lib/test_bpf.ko ]; then
+		insmod ${OUTPUT}/lib/test_bpf.ko \
+			test_suite=test_interpreter_fallback 2>/dev/null
+		if [ $? -ne 0 ]; then
+			rc=1
+		fi
+	else
+		if ! /sbin/modprobe -q -n test_bpf \
+			test_suite=test_interpreter_fallback; then
+			echo "test_bpf (test_suite=test_interpreter_fallback): [SKIP]"
+		elif /sbin/modprobe -q test_bpf \
+			test_suite=test_interpreter_fallback; then
+			echo "test_bpf (test_suite=test_interpreter_fallback): ok"
+		else
+			echo "test_bpf (test_suite=test_interpreter_fallback): [FAIL]"
+			rc=1
+		fi
+	fi
+	rmmod test_bpf 2>/dev/null
+	dmesg | grep FAIL
+}
+
 rc=0
 test_save
 test_run 0 0 "$@"
 test_run 1 0 "$@"
 test_run 1 1 "$@"
 test_run 1 2 "$@"
+test_interpreter_fallback
 test_restore
 exit $rc
-- 
2.54.0

