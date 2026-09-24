Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91183A1691
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219502; cv=none; b=MFmmao9i6MC7jIF+vfNZc0xsLZG+DVoQBoxtsbffUE9aEfArv3QkkYJhCJc+fQZ6XMDNiNC4Mu16elb3EmwiIEEQF9B3XpXToflPhJHNSMFESjsQTdHcNoKXkZ6cVOvwIQl4RVA19lSBoACz3gzb0F2fa2J3aGNobgoUODJ73ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219502; c=relaxed/simple;
	bh=jxDNAMY4+pAD1x05XVMLV5PjBfYXQ+DBJHhWHX6mrqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CffnNP+1XuXsp2vlvaoytrhTDfCSsKJ63DQ5AStTDybFbvTuYT/JkAeILkO7IuIKCuRPsTmxwYS/0ur9TDQ+rOUm4Cbh2HVGNJ0J9mP278lcy3bgQsiqWbmfP4vQz6Dz8gU6iLv1GVPM4IpAf9t34cCu4I38Ly4lSqAiP7MHc8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qsTyWBPc; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsTyWBPc"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ed1368so10263215ad.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790219499; x=1790824299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rpKIN7GbT0ro5qL+oCVHvcagQTSCQk9egDU/Oal/yNw=;
        b=qsTyWBPctIehIUVUYIvpd6driND0Ytmtm3hJOm55ur/FWMfHqBaS6T6A5yk124vJCT
         iOes/jT/+iMoFMasaNfq0hLd99nIvWRERKuZUd7siMMA8fj32NvSrgerx5tVikXEG1an
         avFcXteRrBYArP3y5XIqRRzPUxsLQGfG5ZeDbMSI0HQTD37ihKaxGOFUcYMxjmWS1Chy
         4ftukBMwfoo9UBJOsFBMXhPL/3w4Kveq1QRrYBEibfekD0kgXRh6cxGcHojenzgoX3UY
         qtkxBBLCOUlEsnReYutyuZEdMNV/StC5f2KTf2MakOzLcN13mWqHrbcgkIbcT363lmt0
         3O7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790219499; x=1790824299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rpKIN7GbT0ro5qL+oCVHvcagQTSCQk9egDU/Oal/yNw=;
        b=qxOvueUf6CK7CeGFFoi8GJxwqiTq8lV4RdkYWIkslRaj5J+GVudEUqCFyH2jRvFeL3
         qoZmaGP9JO27k7imKTKu1Ob+rWMMqTJ7HcNxPtU95ONum0C/9ARMzDvkS/kOa3lJPOhe
         JtjfWkahkNLTc4mqybfd+zJ7U6qNi7imjBltulpcWvl8EyxGdRm3JFm4v+IoKDlj7+/p
         TxFJV+/3M8Lyvyv4UF7CQQvg2NqGlSYLwlp66/QtMQenc5liBnKJi8sLS9C5JCLxnbKe
         nhtIAY+kVJJmKFTh45fO4aHyZmo/KJAZhzWybTxfEw35hcjigkdiSnOFNjPHxlWcb/uR
         Yrgw==
X-Gm-Message-State: AFuF++nBVJmKJ1Gi3ToAoVz0a++xmEeQlLelgrjNScVBj+cEKHgu15dp
	gEL/b+uCXuZuePOKQ77GF4KsVE1UY/GwxUZ+e6WqT9gvZvJze1Ruz8SDobvS4g==
X-Gm-Gg: AYBFou2wCoQRpT8M+pWe6ANodWICKG4lV84teTmtbqpJ9rovMMLg/Mo8inS0U1hvLk0
	7Qx+VxmE9ADeHMkQ7ZOnOfLltuqzW4tf9tsxxrzg/f2mRZytlIu+RlSugunYEvOwi/2ije5pHrU
	xWaa+hCtBbqa5cYacu4uKjXJ1ARexkawHJ3JgVSysEA3gHBDqRl6LZ3Qrvf1N0CWdB3MR1FBQG2
	DxUg6NAznrFF3BlOGXu7W1IBecoeGc/qI/5k554Z+crXsSTNvp9SzNKM0dtIhAPZiP9sIhd3aST
	eB3H/Nb2SodefXzVNAzyzl9arcIB1knBJH6eQtPLsjkfruLHmvoMJhwK0ZzXEIwxc9YFCl0wYUS
	Qpz/MSO/weSDuFLjSk2W2XTQOufXNRXUVlkHnfH1ostbe1O+rjc/3yAgRpRkFCzBy+XRCcViGcR
	4glZRUz/ApZIXQRnRBj4nL458IHVQRBSJl/h8A4MRIpBjNgzlj5qJJOdYLXGKZhDpo+R7BrYqSt
	hQhkjl4Erc5ImM7Mz99MpD8hX6+eL+SWAVhpbdP5hFFWuNuVyG07tlVkx51EeuZGIiY9NdEo9N4
	/ZAjvws1/ui/h2IqcofGpYZels6WyEkhVfxPQMdrM9g=
X-Received: by 2002:a17:90b:524c:b0:39e:345b:3322 with SMTP id 98e67ed59e1d1-3a098ce5567mr979385a91.23.1790219498758;
        Wed, 23 Sep 2026 20:11:38 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a081232c4dsm2885624a91.2.2026.09.23.20.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 20:11:38 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 16/17] selftests/bpf: Add tests for callx through pointers in read-only data
Date: Thu, 24 Sep 2026 03:10:41 +0000
Message-ID: <20260924031042.1690890-17-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add verifier_callx_rodata tests where pointers to functions are in
.rodata, libbpf stores offsets there and the kernel recognizes them:
- vtable-like data in .rodata and .data.rel.ro, one of two vtables picked
  at run time, const and variable index, array of structs where
  the index selects the pointer or the data, address of an element,
  table without a symbol. These are executed.
- data next to a pointer is still a constant. The pointer is not:
  bpf_prune_dead_branches() must not fold a branch on it.
- all functions the index can select are verified. The rest are not.
- index that may select non-pointer, partial and misaligned reads,
  arithmetic on the pointer.
- pointer to a global function is not recognized.
- prog without callx reads the pointer as a number.
- recursion and stack depth via a table, stack depth of a callback
  that is read from a table.
- effects of the functions in a table that call each other.
- CAP_BPF without CAP_PERFMON.
- C: array of functions, NULL check of an element, struct ops with
  data, switch that may become a table, packed struct with misaligned
  pointers in a prog without callx.

Add callx_func_ptr_map test that doesn't use libbpf logic: map that
another prog uses is not scanned, the prog that failed to load is not
a user, the offset in the map is replaced at load, the data is not, no
other prog including second instance of the same one can use the map
after that.

Add callx_rodata_lskel test: two progs with a table of functions in
.rodata and one without callx loaded by light skeleton, with .rodata
set by user space.

callx needs JIT. Skip the tests when it's off.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/Makefile.skel     |   2 +-
 .../bpf/prog_tests/callx_func_ptr_map.c       | 202 +++++
 .../bpf/prog_tests/callx_rodata_lskel.c       |  63 ++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/callx_rodata.c        |  51 ++
 .../bpf/progs/verifier_callx_rodata.c         | 846 ++++++++++++++++++
 6 files changed, 1165 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
 create mode 100644 tools/testing/selftests/bpf/progs/callx_rodata.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_callx_rodata.c

diff --git a/tools/testing/selftests/bpf/Makefile.skel b/tools/testing/selftests/bpf/Makefile.skel
index 580d1d82c186..3d92cdca62ed 100644
--- a/tools/testing/selftests/bpf/Makefile.skel
+++ b/tools/testing/selftests/bpf/Makefile.skel
@@ -33,7 +33,7 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 LSKELS := fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c 	\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
 	test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c    \
-	test_ringbuf_overwrite.c
+	test_ringbuf_overwrite.c callx_rodata.c
 
 LSKELS_SIGNED := fentry_test.c fexit_test.c atomics.c
 
diff --git a/tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c b/tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c
new file mode 100644
index 000000000000..b58ebee9b1ef
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The kernel replaces the offsets of functions in a frozen read-only map with
+ * their addresses when the program is loaded. The program has to be the only
+ * user of the map, and no other program can use the map after that.
+ */
+#include <test_progs.h>
+#include <linux/filter.h>
+#include <bpf/btf.h>
+
+#if defined(__x86_64__) || defined(__aarch64__)
+
+#define CALLEE_INSN	6
+#define DATA		0x1234
+
+/*
+ * main:   r2 = &value; r2 = *(u64 *)(r2 + 8); r1 = 10; callx r2; exit
+ * add1:   r0 = r1; r0 += 1; exit
+ *
+ * where value is { DATA, offset of add1 in the program }.
+ */
+static const struct bpf_insn callx_insns[] = {
+	BPF_LD_MAP_VALUE(BPF_REG_2, 0, 0),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_2, 8),
+	BPF_MOV64_IMM(BPF_REG_1, 10),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL | BPF_X, BPF_REG_2, 0, 0, 0),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+};
+
+/* reads the data of the map */
+static const struct bpf_insn reader_insns[] = {
+	BPF_LD_MAP_VALUE(BPF_REG_2, 0, 0),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, 0),
+	BPF_EXIT_INSN(),
+};
+
+/* refers to the map and is rejected: r0 is not set */
+static const struct bpf_insn bad_insns[] = {
+	BPF_LD_MAP_VALUE(BPF_REG_2, 0, 0),
+	BPF_EXIT_INSN(),
+};
+
+static char log_buf[16 * 1024];
+static struct bpf_func_info func_info[2];
+static int btf_fd;
+
+static int create_map(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_RDONLY_PROG);
+	__u64 value[2] = { DATA, CALLEE_INSN * sizeof(struct bpf_insn) };
+	int fd, zero = 0;
+
+	fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "callx_rodata", sizeof(int), sizeof(value), 1,
+			    &opts);
+	if (!ASSERT_OK_FD(fd, "map_create"))
+		return -1;
+	if (!ASSERT_OK(bpf_map_update_elem(fd, &zero, value, 0), "map_update") ||
+	    !ASSERT_OK(bpf_map_freeze(fd), "map_freeze")) {
+		close(fd);
+		return -1;
+	}
+	return fd;
+}
+
+static int load(const struct bpf_insn *prog_insns, int cnt, int map_fd)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		.log_buf = log_buf,
+		.log_size = sizeof(log_buf),
+		.log_level = 1,
+	);
+	struct bpf_insn insns[ARRAY_SIZE(callx_insns)];
+
+	if (prog_insns == callx_insns) {
+		/* add1() is referred to by the data only and is found through func_info */
+		opts.prog_btf_fd = btf_fd;
+		opts.func_info = func_info;
+		opts.func_info_cnt = 2;
+		opts.func_info_rec_size = sizeof(func_info[0]);
+	}
+	memcpy(insns, prog_insns, cnt * sizeof(insns[0]));
+	insns[0].imm = map_fd;
+	log_buf[0] = 0;
+	return bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, "callx_map", "GPL", insns, cnt, &opts);
+}
+
+#define LOAD(insns, map_fd) load(insns, ARRAY_SIZE(insns), map_fd)
+
+static void run(int prog_fd, int expected, const char *name)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	char pkt[64] = {};
+
+	topts.data_in = pkt;
+	topts.data_size_in = sizeof(pkt);
+	if (ASSERT_OK(bpf_prog_test_run_opts(prog_fd, &topts), name))
+		ASSERT_EQ(topts.retval, expected, name);
+}
+
+void test_callx_func_ptr_map(void)
+{
+	int int_id, proto_id, map_fd = -1, prog_fd = -1, reader_fd = -1, fd, zero = 0;
+	int main_id, add1_id;
+	struct btf *btf;
+	__u64 value[2];
+
+	/* there is no support for callx in the interpreter */
+	if (!is_jit_enabled()) {
+		test__skip();
+		return;
+	}
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "btf_new"))
+		return;
+	int_id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
+	proto_id = btf__add_func_proto(btf, int_id);
+	main_id = btf__add_func(btf, "main_prog", BTF_FUNC_GLOBAL, proto_id);
+	add1_id = btf__add_func(btf, "add1", BTF_FUNC_STATIC, proto_id);
+	if (!ASSERT_GT(main_id, 0, "btf_add_main") ||
+	    !ASSERT_GT(add1_id, 0, "btf_add_add1") ||
+	    !ASSERT_OK(btf__load_into_kernel(btf), "btf_load"))
+		goto out;
+	func_info[0].insn_off = 0;
+	func_info[0].type_id = main_id;
+	func_info[1].insn_off = CALLEE_INSN;
+	func_info[1].type_id = add1_id;
+	btf_fd = btf__fd(btf);
+
+	/*
+	 * Another program relies on what the map has: it's verified with
+	 * the data folded into constants. Pointers to functions are not looked
+	 * for in such map.
+	 */
+	map_fd = create_map();
+	if (map_fd < 0)
+		goto out;
+	reader_fd = LOAD(reader_insns, map_fd);
+	if (!ASSERT_OK_FD(reader_fd, "load_reader"))
+		goto out;
+	fd = LOAD(callx_insns, map_fd);
+	if (!ASSERT_LT(fd, 0, "load_shared"))
+		close(fd);
+	ASSERT_HAS_SUBSTR(log_buf, "unreachable insn 6", "log_shared");
+	run(reader_fd, DATA, "run_reader");
+	close(reader_fd);
+	reader_fd = -1;
+	close(map_fd);
+
+	map_fd = create_map();
+	if (map_fd < 0)
+		goto out;
+
+	/* a program that is rejected is not a user, libbpf loads it again to get the log */
+	fd = LOAD(bad_insns, map_fd);
+	if (!ASSERT_LT(fd, 0, "load_bad"))
+		close(fd);
+
+	prog_fd = LOAD(callx_insns, map_fd);
+	if (!ASSERT_OK_FD(prog_fd, "load_callx")) {
+		printf("%s\n", log_buf);
+		goto out;
+	}
+	run(prog_fd, 11, "run_callx");
+
+	/* the offset of the function is gone from the map, the data is intact */
+	if (ASSERT_OK(bpf_map_lookup_elem(map_fd, &zero, value), "map_lookup")) {
+		ASSERT_EQ(value[0], DATA, "data");
+		ASSERT_NEQ(value[1], CALLEE_INSN * sizeof(struct bpf_insn), "pointer");
+	}
+
+	/* no other program can use the map now, another instance of the same one too */
+	fd = LOAD(reader_insns, map_fd);
+	if (!ASSERT_EQ(fd, -EBUSY, "load_reader_after"))
+		close(fd);
+	ASSERT_HAS_SUBSTR(log_buf, "has addresses of functions of another program", "log_reader");
+	fd = LOAD(callx_insns, map_fd);
+	if (!ASSERT_EQ(fd, -EBUSY, "load_second_instance"))
+		close(fd);
+
+	run(prog_fd, 11, "run_callx_again");
+out:
+	if (reader_fd >= 0)
+		close(reader_fd);
+	if (prog_fd >= 0)
+		close(prog_fd);
+	if (map_fd >= 0)
+		close(map_fd);
+	btf__free(btf);
+}
+
+#else
+
+void test_callx_func_ptr_map(void)
+{
+	test__skip();
+}
+
+#endif
diff --git a/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c b/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
new file mode 100644
index 000000000000..96f6179f0492
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+#include "callx_rodata.lskel.h"
+
+#if defined(__x86_64__) || defined(__aarch64__)
+
+static void run(int prog_fd, int expected, const char *name)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	char pkt[64] = {};
+
+	topts.data_in = pkt;
+	topts.data_size_in = sizeof(pkt);
+	if (ASSERT_OK(bpf_prog_test_run_opts(prog_fd, &topts), name))
+		ASSERT_EQ(topts.retval, expected, name);
+}
+
+/*
+ * Every program that has callx gets its own copy of .rodata with the offsets
+ * of its functions. The copies have what user space puts into .rodata before
+ * the load. The program that doesn't have callx uses .rodata.
+ */
+void test_callx_rodata_lskel(void)
+{
+	struct callx_rodata_lskel *skel;
+
+	/* there is no support for callx in the interpreter */
+	if (!is_jit_enabled()) {
+		test__skip();
+		return;
+	}
+
+	skel = callx_rodata_lskel__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	skel->rodata->bias = 7;
+
+	if (!ASSERT_OK(callx_rodata_lskel__load(skel), "load"))
+		goto out;
+
+	skel->bss->op_idx = 0;
+	run(skel->progs.select_op.prog_fd, 17, "add_bias");
+	skel->bss->op_idx = 1;
+	run(skel->progs.select_op.prog_fd, 30, "mul3");
+	skel->bss->op_idx = 2;
+	run(skel->progs.select_op.prog_fd, -1, "out_of_range");
+	/* mul3(add_bias(4)) */
+	run(skel->progs.both_ops.prog_fd, 33, "both_ops");
+	run(skel->progs.read_bias.prog_fd, 7, "read_bias");
+out:
+	callx_rodata_lskel__destroy(skel);
+}
+
+#else
+
+void test_callx_rodata_lskel(void)
+{
+	test__skip();
+}
+
+#endif
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index bc96a752b1ae..9c3ff7d83fbe 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -29,6 +29,7 @@
 #include "verifier_btf_unreliable_prog.skel.h"
 #include "verifier_call_large_imm.skel.h"
 #include "verifier_callx.skel.h"
+#include "verifier_callx_rodata.skel.h"
 #include "verifier_cfg.skel.h"
 #include "verifier_cgroup_inv_retcode.skel.h"
 #include "verifier_cgroup_skb.skel.h"
@@ -209,6 +210,7 @@ void test_verifier_btf_ctx_access(void)       { RUN(verifier_btf_ctx_access); }
 void test_verifier_btf_unreliable_prog(void)  { RUN(verifier_btf_unreliable_prog); }
 void test_verifier_call_large_imm(void)       { RUN(verifier_call_large_imm); }
 void test_verifier_callx(void)                { RUN_JITED(verifier_callx); }
+void test_verifier_callx_rodata(void)         { RUN_JITED(verifier_callx_rodata); }
 void test_verifier_cfg(void)                  { RUN(verifier_cfg); }
 void test_verifier_cgroup_inv_retcode(void)   { RUN(verifier_cgroup_inv_retcode); }
 void test_verifier_cgroup_skb(void)           { RUN(verifier_cgroup_skb); }
diff --git a/tools/testing/selftests/bpf/progs/callx_rodata.c b/tools/testing/selftests/bpf/progs/callx_rodata.c
new file mode 100644
index 000000000000..07ae2d1b6b8e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/callx_rodata.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/* callx through pointers to functions in .rodata, loaded by light skeleton */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+typedef int (*op_fn)(int);
+
+/* set by user space before the programs are loaded, it's in .rodata too */
+const volatile int bias = 1;
+
+int op_idx;
+
+static __noinline int add_bias(int x)
+{
+	return x + bias;
+}
+
+static __noinline int mul3(int x)
+{
+	return x * 3;
+}
+
+/* volatile, so that the compiler doesn't replace the table with direct calls */
+static op_fn const volatile ops[] = { add_bias, mul3 };
+
+SEC("socket")
+int select_op(void *ctx)
+{
+	unsigned int i = op_idx;
+
+	if (i >= sizeof(ops) / sizeof(ops[0]))
+		return -1;
+	return ops[i](10);
+}
+
+/* functions have other offsets in this program */
+SEC("socket")
+int both_ops(void *ctx)
+{
+	return ops[1](ops[0](4));
+}
+
+/* no callx here */
+SEC("socket")
+int read_bias(void *ctx)
+{
+	return bias;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
new file mode 100644
index 000000000000..af1f9305da37
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
@@ -0,0 +1,846 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Tests for callx through pointers to functions in read-only data */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../../../include/linux/filter.h"
+
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
+
+/*
+ * Read-only data with pointers to functions, where the compiler puts tables
+ * of functions, structures of operations and vtables. libbpf resolves
+ * a pointer to the offset of the function in the program and the kernel
+ * recognizes it by that value.
+ */
+#define DATA(SECTION, NAME, ...)				\
+	".pushsection " SECTION ",@progbits;"			\
+	".balign 8;"						\
+	#NAME "_%=:"						\
+	__VA_ARGS__						\
+	".type " #NAME "_%=, @object;"				\
+	".size " #NAME "_%=, .-" #NAME "_%=;"			\
+	".popsection;"
+
+#define RODATA(NAME, ...) DATA(".rodata,\"a\"", NAME, __VA_ARGS__)
+
+#define FUNC_TABLE2(NAME, F0, F1) RODATA(NAME, ".quad " #F0 "; .quad " #F1 ";")
+
+__naked __noinline __used
+static unsigned long add1(void)
+{
+	asm volatile (
+		"r0 = r1;"
+		"r0 += 1;"
+		"exit;"
+	);
+}
+
+__naked __noinline __used
+static unsigned long add2(void)
+{
+	asm volatile (
+		"r0 = r1;"
+		"r0 += 2;"
+		"exit;"
+	);
+}
+
+/* the second element of the table is called */
+SEC("socket")
+__success __retval(12)
+__naked void callx_rodata_const_index(void)
+{
+	asm volatile (
+		FUNC_TABLE2(tbl, add1, add2)
+		"r2 = tbl_%= ll;"
+		"r2 = *(u64 *)(r2 + 8);"
+		"r1 = 10;"
+		"callx r2;"
+		"exit;"
+		::: __clobber_all);
+}
+
+/*
+ * The program reads the address of a function from the data, so pointers to
+ * functions in data are recognized only for programs that may leak pointers.
+ * Otherwise nothing refers to the functions.
+ */
+SEC("socket")
+__success __retval(12)
+__failure_unpriv __msg_unpriv("unreachable insn")
+__caps_unpriv(CAP_BPF)
+__naked void callx_rodata_needs_perfmon(void)
+{
+	asm volatile (
+		FUNC_TABLE2(tbl, add1, add2)
+		"r2 = tbl_%= ll;"
+		"r2 = *(u64 *)(r2 + 8);"
+		"r1 = 10;"
+		"callx r2;"
+		"exit;"
+		::: __clobber_all);
+}
+
+/* the address of an element is used instead of the address of the table */
+SEC("socket")
+__success __retval(12)
+__naked void callx_rodata_elem_addr(void)
+{
+	asm volatile (
+		FUNC_TABLE2(tbl, add1, add2)
+		"r2 = tbl_%= + 8 ll;"
+		"r2 = *(u64 *)(r2 + 0);"
+		"r1 = 10;"
+		"callx r2;"
+		"exit;"
+		::: __clobber_all);
+}
+
+/* pointers to functions are mixed with other data like in a vtable */
+SEC("socket")
+__success __retval(23)
+__log_level(2)
+__msg("r1 = *(u64 *)(r6 +0)          ; R1=7")
+__msg("r2 = *(u64 *)(r6 +8)          ; R2=func()")
+__naked void callx_rodata_mixed_with_data(void)
+{
+	asm volatile (
+		RODATA(vt, ".quad 7; .quad add1; .quad 13; .quad add2;")
+		"r6 = vt_%= ll;"
+		"r1 = *(u64 *)(r6 + 0);"
+		"r2 = *(u64 *)(r6 + 8);"
+		/* add1(7) */
+		"callx r2;"
+		"r7 = r0;"
+		"r1 = *(u64 *)(r6 + 16);"
+		"r2 = *(u64 *)(r6 + 24);"
+		/* add2(13) */
+		"callx r2;"
+		"r0 += r7;"
+		"exit;"
+		::: __clobber_all);
+}
+
+/*
+ * Position independent code keeps constants with pointers in .data.rel.ro.
+ * libbpf treats it as read-only data.
+ */
+SEC("socket")
+__success __retval(23)
+__naked void callx_data_rel_ro(void)
+{
+	asm volatile (
+		DATA(".data.rel.ro,\"aw\"", vt, ".quad 7; .quad add1; .quad 13; .quad add2;")
+		"r6 = vt_%= ll;"
+		"r1 = *(u64 *)(r6 + 0);"
+		"r2 = *(u64 *)(r6 + 8);"
+		"callx r2;"
+		"r7 = r0;"
+		"r1 = *(u64 *)(r6 + 16);"
+		"r2 = *(u64 *)(r6 + 24);"
+		"callx r2;"
+		"r0 += r7;"
+		"exit;"
+		::: __clobber_all);
+}
+
+/* an array of structures: the index selects one of the functions, not the data */
+SEC("socket")
+__success __retval(11)
+__naked void callx_rodata_array_of_structs(void)
+{
+	asm volatile (
+		RODATA(arr, ".quad add1; .quad 0x1111; .quad add2; .quad 0x2222;")
+		"call %[bpf_get_prandom_u32];"
+		"r6 = r0;"
+		"r6 &= 1;"
+		"r3 = r6;"
+		"r3 <<= 4;"
+		"r2 = arr_%= ll;"
+		"r2 += r3;"
+		"r2 = *(u64 *)(r2 + 0);"
+		"r1 = 10;"
+		"callx r2;"
+		/* add1(10) - 0 or add2(10) - 1 */
+		"r0 -= r6;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all);
+}
+
+/* and the data of the element that the index selects can be read */
+SEC("socket")
+__success __retval(16)
+__naked void callx_rodata_array_of_structs_data(void)
+{
+	asm volatile (
+		RODATA(arr, ".quad add1; .quad 5; .quad add2; .quad 5;")
+		"call %[bpf_get_prandom_u32];"
+		"r6 = r0;"
+		"r6 &= 1;"
+		"r3 = r6;"
+		"r3 <<= 4;"
+		"r7 = arr_%= ll;"
+		"r7 += r3;"
+		"r2 = *(u64 *)(r7 + 0);"
+		"r1 = 10;"
+		"callx r2;"
+		/* add1(10) - 0 or add2(10) - 1 */
+		"r0 -= r6;"
+		"r1 = *(u64 *)(r7 + 8);"
+		"r0 += r1;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all);
+}
+
+/* but not the data and the pointer with the same load */
+SEC("socket")
+__failure __msg("overlaps with a pointer to a function")
+__naked void callx_rodata_array_of_structs_any(void)
+{
+	asm volatile (
+		RODATA(arr, ".quad add1; .quad 5; .quad add2; .quad 5;")
+		"call %[bpf_get_prandom_u32];"
+		"r0 &= 3;"
+		"r0 <<= 3;"
+		"r2 = arr_%= ll;"
+		"r2 += r0;"
+		"r2 = *(u64 *)(r2 + 0);"
+		"r1 = 10;"
+		"callx r2;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all);
+}
+
+/* dynamic dispatch: which vtable is used is not known until run time */
+SEC("socket")
+__success __retval(2)
+__naked void callx_rodata_two_vtables(void)
+{
+	asm volatile (
+		RODATA(vt_a, ".quad 1; .quad add1;")
+		RODATA(vt_b, ".quad 0; .quad add2;")
+		"call %[bpf_get_prandom_u32];"
+		"r6 = vt_a_%= ll;"
+		"r0 &= 1;"
+		"if r0 == 0 goto +2;"
+		"r6 = vt_b_%= ll;"
+		"r1 = *(u64 *)(r6 + 0);"
+		"r2 = *(u64 *)(r6 + 8);"
+		/* add1(1) or add2(0) */
+		"callx r2;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all);
+}
+
+/* both functions are verified, either of them is called */
+SEC("socket")
+__success __retval(11)
+__naked void callx_rodata_var_index(void)
+{
+	asm volatile (
+		FUNC_TABLE2(tbl, add1, add2)
+		"call %[bpf_get_prandom_u32];"
+		"r6 = r0;"
+		"r6 &= 1;"
+		"r3 = r6;"
+		"r3 <<= 3;"
+		"r2 = tbl_%= ll;"
+		"r2 += r3;"
+		"r2 = *(u64 *)(r2 + 0);"
+		"r1 = 10;"
+		"callx r2;"
+		/* add1(10) - 0 or add2(10) - 1 */
+		"r0 -= r6;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all);
+}
+
+/* a table that has no symbol, the compiler generates such for a switch statement */
+SEC("socket")
+__success __retval(11)
+__naked void callx_rodata_no_symbol(void)
+{
+	asm volatile (
+		".pushsection .rodata,\"a\",@progbits;"
+		".balign 8;"
+	".Lanon_%=:"
+		".quad add1;"
+		".quad add2;"
+		".popsection;"
+		"call %[bpf_get_prandom_u32];"
+		"r6 = r0;"
+		"r6 &= 1;"
+		"r3 = r6;"
+		"r3 <<= 3;"
+		"r2 = .Lanon_%= ll;"
+		"r2 += r3;"
+		"r2 = *(u64 *)(r2 + 0);"
+		"r1 = 10;"
+		"callx r2;"
+		"r0 -= r6;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all);
+}
+
+/* the first instruction of the function is removed by the verifier */
+__naked __noinline __used
+static unsigned long nop_add1(void)
+{
+	asm volatile (
+		"goto +0;"
+		"r0 = r1;"
+		"r0 += 1;"
+		"exit;"
+	);
+}
+
+/* the pointer follows the function when instructions are removed */
+SEC("socket")
+__success __retval(11)
+__naked void callx_rodata_func_starts_with_nop(void)
+{
+	asm volatile (
+		RODATA(tbl, ".quad nop_add1; .quad 0;")
+		"r2 = tbl_%= ll;"
+		"r2 = *(u64 *)(r2 + 0);"
+		"r1 = 10;"
+		"callx r2;"
+		"exit;"
+		::: __clobber_all);
+}
+
+/* can't be called with a scalar in r1 */
+__naked __noinline __used
+static unsigned long deref_r1(void)
+{
+	asm volatile (
+		"r0 = *(u64 *)(r1 + 0);"
+		"exit;"
+	);
+}
+
+__naked __noinline __used
+static unsigned long ret0(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"exit;"
+	);
+}
+
+/* every function that might be called is verified */
+SEC("socket")
+__failure __msg("R1 invalid mem access 'scalar'")
+__naked void callx_rodata_all_callees_verified(void)
+{
+	asm volatile (
+		FUNC_TABLE2(tbl, ret0, deref_r1)
+		"call %[bpf_get_prandom_u32];"
+		"r0 &= 1;"
+		"r0 <<= 3;"
+		"r2 = tbl_%= ll;"
+		"r2 += r0;"
+		"r2 = *(u64 *)(r2 + 0);"
+		"r1 = 0;"
+		"callx r2;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all);
+}
+
+/* a function that is never called is not verified, it's dead code */
+SEC("socket")
+__success __retval(0)
+__naked void callx_rodata_unused_callee(void)
+{
+	asm volatile (
+		FUNC_TABLE2(tbl, ret0, deref_r1)
+		"r2 = tbl_%= ll;"
+		"r2 = *(u64 *)(r2 + 0);"
+		"r1 = 0;"
+		"callx r2;"
+		"exit;"
+		::: __clobber_all);
+}
+
+/* a pointer that is read and never called doesn't keep the function, it's NULL */
+SEC("socket")
+__success __retval(1)
+__naked void callx_rodata_read_unused_callee(void)
+{
+	asm volatile (
+		FUNC_TABLE2(tbl, ret0, deref_r1)
+		"r6 = tbl_%= ll;"
+		"r2 = *(u64 *)(r6 + 0);"
+		"r1 = 0;"
+		"callx r2;"
+		"r2 = *(u64 *)(r6 + 8);"
+		"if r2 != 0 goto +1;"
+		"r0 = 1;"
+		"exit;"
+		::: __clobber_all);
+}
+
+/* the index may select what is not a pointer to a function */
+SEC("socket")
+__failure __msg("overlaps with a pointer to a function")
+__naked void callx_rodata_index_beyond_table(void)
+{
+	asm volatile (
+		RODATA(tbl, ".quad add1; .quad add2; .quad 0x1234; .quad 0x5678;")
+		"call %[bpf_get_prandom_u32];"
+		"r0 &= 3;"
+		"r0 <<= 3;"
+		"r2 = tbl_%= ll;"
+		"r2 += r0;"
+		"r2 = *(u64 *)(r2 + 0);"
+		"r1 = 10;"
+		"callx r2;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all);
+}
+
+/* the address of a function is not known until the program is jitted */
+SEC("socket")
+__failure __msg("read of 4 bytes at offset")
+__msg("overlaps with a pointer to a function")
+__naked void callx_rodata_partial_read(void)
+{
+	asm volatile (
+		FUNC_TABLE2(tbl, add1, add2)
+		"r6 = tbl_%= ll;"
+		"r2 = *(u64 *)(r6 + 8);"
+		"r1 = 10;"
+		"callx r2;"
+		"r0 = *(u32 *)(r6 + 0);"
+		"exit;"
+		::: __clobber_all);
+}
+
+SEC("socket")
+__failure __msg("read of 8 bytes at offset")
+__msg("overlaps with a pointer to a function")
+__naked void callx_rodata_misaligned_read(void)
+{
+	asm volatile (
+		RODATA(tbl, ".quad add1; .quad add2; .quad 0;")
+		"r6 = tbl_%= ll;"
+		"r2 = *(u64 *)(r6 + 0);"
+		"r1 = 10;"
+		"callx r2;"
+		"r0 = *(u64 *)(r6 + 4);"
+		"exit;"
+		::: __clobber_all);
+}
+
+/*
+ * The kernel doesn't look for pointers to functions in the data of a program
+ * that doesn't have callx. It's a number there.
+ */
+SEC("socket")
+__success
+__naked void callx_rodata_no_callx(void)
+{
+	asm volatile (
+		FUNC_TABLE2(tbl, add1, add2)
+		"r2 = tbl_%= ll;"
+		"r0 = *(u32 *)(r2 + 0);"
+		"r0 = 0;"
+		"exit;"
+		::: __clobber_all);
+}
+
+/* the data next to a pointer is still known to the verifier */
+SEC("socket")
+__success __retval(0x1234)
+__log_level(2)
+__msg("R0=4660")
+__naked void callx_rodata_data_is_const(void)
+{
+	asm volatile (
+		RODATA(tbl, ".quad add1; .quad 0x1234;")
+		"r6 = tbl_%= ll;"
+		"r2 = *(u64 *)(r6 + 0);"
+		"r1 = 10;"
+		"callx r2;"
+		"r0 = *(u64 *)(r6 + 8);"
+		"exit;"
+		::: __clobber_all);
+}
+
+/*
+ * The map has the offset of the function until the program is jitted.
+ * bpf_compute_const_regs() must not take it for a constant, otherwise
+ * bpf_prune_dead_branches() turns the branch below into the wrong one.
+ */
+SEC("socket")
+__success __retval(11)
+__naked void callx_rodata_ptr_is_not_const(void)
+{
+	asm volatile (
+		FUNC_TABLE2(tbl, add1, add2)
+		"r2 = tbl_%= ll;"
+		"r2 = *(u64 *)(r2 + 0);"
+		"r0 = 0;"
+		/* the offset is less, the address is greater */
+		"if r2 < 0x100000 goto 1f;"
+		"r1 = 10;"
+		"callx r2;"
+	"1:"
+		"exit;"
+		::: __clobber_all);
+}
+
+/* the pointer read from the data can't be modified */
+SEC("socket")
+__failure __msg("dereference of modified func ptr R2 off=8 disallowed")
+__naked void callx_rodata_modified_ptr(void)
+{
+	asm volatile (
+		FUNC_TABLE2(tbl, add1, add2)
+		"r2 = tbl_%= ll;"
+		"r2 = *(u64 *)(r2 + 0);"
+		"r2 += 8;"
+		"r1 = 10;"
+		"callx r2;"
+		"exit;"
+		::: __clobber_all);
+}
+
+__noinline __used
+int global_add3(int x)
+{
+	return x + 3;
+}
+
+/*
+ * A pointer to a global function is not recognized, it's a number. The function
+ * is called directly as well, so that libbpf adds it to the program and stores
+ * its offset into the table.
+ */
+SEC("socket")
+__failure __msg("R2 has type scalar, expected func")
+__naked void callx_rodata_global_func(void)
+{
+	asm volatile (
+		FUNC_TABLE2(tbl, add1, global_add3)
+		"r1 = 1;"
+		"call global_add3;"
+		"r2 = tbl_%= ll;"
+		"r2 = *(u64 *)(r2 + 8);"
+		"r1 = 10;"
+		"callx r2;"
+		"exit;"
+		::: __clobber_all);
+}
+
+/* selfcall(n) { return n ? tbl[0](n - 1) : 0; }, where tbl[0] == selfcall */
+__naked __noinline __used
+static unsigned long selfcall(void)
+{
+	asm volatile (
+		FUNC_TABLE2(tbl, selfcall, ret0)
+		"r0 = 0;"
+		"if r1 == 0 goto 1f;"
+		"r1 += -1;"
+		"r2 = tbl_%= ll;"
+		"r2 = *(u64 *)(r2 + 0);"
+		"callx r2;"
+	"1:"
+		"exit;"
+		::: __clobber_all);
+}
+
+SEC("socket")
+__failure __msg("recursive call from selfcall() to selfcall()")
+__naked void callx_rodata_recursion(void)
+{
+	asm volatile (
+		"r1 = 2;"
+		"call selfcall;"
+		"exit;"
+		::: __clobber_all);
+}
+
+__naked __noinline __used
+static unsigned long use_stack_304(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"*(u64 *)(r10 - 304) = r0;"
+		"exit;"
+	);
+}
+
+/* stack of all possible callees is accounted */
+SEC("socket")
+__failure __msg("combined stack size of 2 calls is")
+__naked void callx_rodata_stack_depth(void)
+{
+	asm volatile (
+		FUNC_TABLE2(tbl, ret0, use_stack_304)
+		"r0 = 0;"
+		"*(u64 *)(r10 - 304) = r0;"
+		"call %[bpf_get_prandom_u32];"
+		"r0 &= 1;"
+		"r0 <<= 3;"
+		"r2 = tbl_%= ll;"
+		"r2 += r0;"
+		"r2 = *(u64 *)(r2 + 0);"
+		"callx r2;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all);
+}
+
+/* stack of a callback that is read from the data is accounted too */
+SEC("socket")
+__failure __msg("combined stack size of 2 calls is")
+__naked void callx_rodata_callback_stack_depth(void)
+{
+	asm volatile (
+		FUNC_TABLE2(tbl, use_stack_304, ret0)
+		"r0 = 0;"
+		"*(u64 *)(r10 - 304) = r0;"
+		"r6 = tbl_%= ll;"
+		"r1 = 1;"
+		"r2 = *(u64 *)(r6 + 0);"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		"r2 = *(u64 *)(r6 + 8);"
+		"r1 = 0;"
+		"callx r2;"
+		"exit;"
+		:
+		: __imm(bpf_loop)
+		: __clobber_all);
+}
+
+static __noinline __used int pull_data(struct __sk_buff *skb)
+{
+	return bpf_skb_pull_data(skb, 0);
+}
+
+static __noinline __used int calls_pull_data(struct __sk_buff *skb)
+{
+	return pull_data(skb) + 1;
+}
+
+__noinline __used int global_calls_pull_data(struct __sk_buff *skb)
+{
+	return calls_pull_data(skb) + 2;
+}
+
+/*
+ * check_cfg() explores the functions that the data points to when it sees
+ * the address of the data. It must not lose the effects of the functions
+ * that call each other: global_calls_pull_data() changes packet data.
+ */
+SEC("tc")
+__failure __msg("R7 invalid mem access 'scalar'")
+__naked void callx_rodata_callee_effects(void)
+{
+	asm volatile (
+		FUNC_TABLE2(tbl, pull_data, calls_pull_data)
+		"r6 = r1;"
+		"r7 = *(u32 *)(r6 + %[data]);"
+		"r8 = *(u32 *)(r6 + %[data_end]);"
+		"r2 = r7;"
+		"r2 += 8;"
+		"if r2 > r8 goto 1f;"
+		"r1 = r6;"
+		"call global_calls_pull_data;"
+		"r0 = *(u8 *)(r7 + 0);"
+	"1:"
+		"r9 = tbl_%= ll;"
+		"r2 = *(u64 *)(r9 + 8);"
+		"r1 = r6;"
+		"callx r2;"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_const(data, offsetof(struct __sk_buff, data)),
+		  __imm_const(data_end, offsetof(struct __sk_buff, data_end))
+		: __clobber_all);
+}
+
+/* pointers to functions in C */
+
+typedef int (*op_fn)(int);
+
+#define DEFINE_OP(N) static __noinline int op##N(int x) { return x * (N + 2) + N; }
+
+DEFINE_OP(0)  DEFINE_OP(1)  DEFINE_OP(2)  DEFINE_OP(3)
+DEFINE_OP(4)  DEFINE_OP(5)  DEFINE_OP(6)  DEFINE_OP(7)
+DEFINE_OP(8)  DEFINE_OP(9)  DEFINE_OP(10) DEFINE_OP(11)
+DEFINE_OP(12) DEFINE_OP(13) DEFINE_OP(14) DEFINE_OP(15)
+
+static op_fn const ops[] = {
+	op0, op1, op2,  op3,  op4,  op5,  op6,  op7,
+	op8, op9, op10, op11, op12, op13, op14, op15,
+};
+
+int op_idx = 11;
+
+SEC("socket")
+__success __retval(50)
+int callx_c_table(void *ctx)
+{
+	unsigned int i = op_idx;
+
+	if (i >= sizeof(ops) / sizeof(ops[0]))
+		return -1;
+	/* op11(3) = 3 * 13 + 11 */
+	return ops[i](3);
+}
+
+SEC("socket")
+__success __retval(50)
+int callx_c_table_null_check(void *ctx)
+{
+	unsigned int i = op_idx;
+	op_fn op;
+
+	if (i >= sizeof(ops) / sizeof(ops[0]))
+		return -1;
+	/* the address of a function is not known until the program is jitted */
+	op = ops[i];
+	if (!op)
+		return -2;
+	return op(3);
+}
+
+/* a structure of operations, where pointers to functions are mixed with data */
+struct shape_ops {
+	int id;
+	op_fn area;
+	long scale;
+	op_fn perimeter;
+};
+
+static const struct shape_ops square_ops = { 1, op1, 10, op2 };
+static const struct shape_ops circle_ops = { 2, op3, 20, op1 };
+
+static __noinline int use_shape(const struct shape_ops *ops, int x)
+{
+	return ops->area(x) * ops->scale + ops->perimeter(ops->id);
+}
+
+SEC("socket")
+__success __retval(433)
+int callx_c_ops_mixed_with_data(void *ctx)
+{
+	/*
+	 * square: op1(2) * 10 + op2(1) = 7 * 10 + 6 = 76
+	 * circle: op3(3) * 20 + op1(2) = 18 * 20 + 7 = 367
+	 * minus 10, since op_idx is 11
+	 */
+	return use_shape(&square_ops, 2) + use_shape(&circle_ops, 3) - (op_idx == 11 ? 10 : 0);
+}
+
+/* the ops are selected at run time */
+SEC("socket")
+__success __retval(367)
+int callx_c_ops_selected(void *ctx)
+{
+	const struct shape_ops *ops = op_idx == 11 ? &circle_ops : &square_ops;
+
+	return use_shape(ops, 3);
+}
+
+/* the compiler might turn the switch into a table that has no symbol */
+static __noinline int call_by_switch(unsigned int idx, int x)
+{
+	op_fn op;
+
+	switch (idx) {
+	case 0:
+		op = op8;
+		break;
+	case 1:
+		op = op9;
+		break;
+	case 2:
+		op = op10;
+		break;
+	case 3:
+		op = op11;
+		break;
+	case 4:
+		op = op12;
+		break;
+	case 5:
+		op = op13;
+		break;
+	case 6:
+		op = op14;
+		break;
+	case 7:
+		op = op15;
+		break;
+	default:
+		return -1;
+	}
+	return op(x);
+}
+
+SEC("socket")
+__success __retval(50)
+int callx_c_switch_table(void *ctx)
+{
+	/* op11(3) = 3 * 13 + 11 */
+	return call_by_switch(op_idx - 8, 3);
+}
+
+/*
+ * Misaligned pointers to functions are ignored, the rest of the data is
+ * accessible as before. The program doesn't have callx, so libbpf doesn't
+ * append the functions that .rodata points to and doesn't make a copy of
+ * .rodata for it.
+ */
+static const struct {
+	char tag;
+	op_fn op;
+} __attribute__((packed)) packed_ops[] = {
+	{ 5, op0 },
+	{ 7, op1 },
+};
+
+SEC("socket")
+__success __retval(7)
+int callx_c_packed_struct(void *ctx)
+{
+	return packed_ops[op_idx & 1].tag;
+}
+
+#else
+
+SEC("socket")
+__success
+int dummy(void *ctx)
+{
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0

