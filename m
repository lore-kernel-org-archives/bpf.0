Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794738423;
	b=BC2TnlBtNrHi/Dsc4cgdYmaG238u9pGPbEpJZ7dsjm9zHWWTKnN0bFZjXzZ1DeN4Njst
	 FoQjcZX9e3kuTitFVy+NESwN85XnUA26LO5v7Go6g0pPO0ILOtN1U3FpzQr18aLLrmhoE
	 SGPbKMYcpqUZk5sFNlJH461RS1J3p0PtUUW+d55TJeC+j0Gf0Q7PgnJAjIeqU+dOYaYLO
	 cMgXdUeeMxWvwwwF0nuSlq5XBtlQdCy0xPqV8xphwe/J4Xtdp4gsVNYrWLbwZSr+4HOdp
	 X+4PuEeygtdongJoFHjceIlwIgzLQn8dPv1Si3NIH4vACuR4cD8qMcX3+wPAxxJNJWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794738423;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=wYVKws0YeHf+69uuLInp1ohGboKtWZqu1D1qG0KnOPU=;
	b=o9LiVRGxubz01TxTzydk4IC1xY3E6Ix2tv8CZo1rqfw2vYBBoywcouZS+LnT+2JeSSqZ
	 Nrjt7D5jTDgjmfXHgB795H9f41ZMJsW7SPwNaqCL4QJtHp2l4SQ+Ukk1G1Js2Qe++UvQM
	 Vwo5UNsd3lYnVEm9nz+HTvzBkCOESsDQArIwYOmbZK8kVsVUGMxc5JzybK45LTXpuYkAk
	 U/CjX0o/84tSVU2DaAUdlAVz5T4pBysmzlyArxhAbBfZUKEX0ZHnoVykkrprxDauW31xB
	 ivwK3BJ96XFREQ23gfDIaXEATCQUo2oMmtV6a/Y/cu/zRC7TrR7ohmuajxDwZ0tQL1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ImDjS4tS;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBE0606A329;
	Sun, 15 Nov 2026 10:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CBE0606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ImDjS4tS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=wY
	VKws0YeHf+69uuLInp1ohGboKtWZqu1D1qG0KnOPU=; b=ImDjS4tSIcAWypD8gK
	J10lTj7F8pQzFryZrxEFsfR+87fCMc/uRqceDSxhKm9TX2yk0Q7oGmFEAk3NUFe9
	1m7eyYApfTmKkTrb4N7ulxEl+ZG++3NVCoJaamBByVI9zyIXVwpDCrhPqMzFzWyf
	WSeJKRUASK5nX7krTMCN1+040=
Received: from nec8-i7 (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgD3X7S+iPlqHVcuGA--.3517S4;
	Sun, 15 Nov 2026 18:26:13 +0800 (CST)
From: Yuan Chen <chenyuan@kylinos.cn>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test the emitted bounds check of the array gen_lookup
Date: Sun, 15 Nov 2026 18:25:59 +0800
Message-ID: <20261115102559.465375-3-chenyuan@kylinos.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261115102559.465375-1-chenyuan@kylinos.cn>
References: <20261115102559.465375-1-chenyuan@kylinos.cn>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgD3X7S+iPlqHVcuGA--.3517S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3WF4kZryUurW3uw1fKF17KFg_yoW3Gw4Upa
	yrKFy5JrW8X3y7X34FkasFgrWY9F1kW3W3trZxWr15Cr4xWFn7X3WrKay3tF1ayFWrZF4Y
	qF1ayas7GFyqgFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j47KxUUUUU=
Sender: chenyuan_fl@163.com
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5QVsKmr5iMWX4AAA3P

Dump the translated insns of a program that inlines
bpf_map_lookup_elem() on ARRAY, PERCPU_ARRAY and ARRAY_OF_MAPS and
check that the compare bounding the index is a 32-bit JGE.  A 64-bit
JGE with max_entries >= 0x80000000 never fires (the immediate is
sign-extended), which lets the inlined lookup address the array out of
bounds.  Triggering that needs a 16 GiB map, so check the emitted
compare instead of allocating one.

Also run the program to check the inlined lookup still finds an element
in range and returns NULL for an out-of-range index.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 .../bpf/prog_tests/array_gen_lookup_jmp32.c   | 204 ++++++++++++++++++
 1 file changed, 204 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/array_gen_lookup_jmp32.c

diff --git a/tools/testing/selftests/bpf/prog_tests/array_gen_lookup_jmp32.c b/tools/testing/selftests/bpf/prog_tests/array_gen_lookup_jmp32.c
new file mode 100644
index 000000000000..ba8215506534
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/array_gen_lookup_jmp32.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 KylinSoft Corporation. */
+
+#include <test_progs.h>
+
+/*
+ * The inlined bpf_map_lookup_elem() for the array map flavors bounds the
+ * index with an emitted compare against map->max_entries.  The compare
+ * must be a 32-bit JGE: the index is zero-extended into a 64-bit register
+ * and the immediate of a 64-bit JGE is sign-extended, so for a map with
+ * max_entries >= 0x80000000 the 64-bit compare never fires and the inlined
+ * code addresses the array out of bounds (70504de0bb62 fixed the same
+ * emitted sequence in xsk_map_gen_lookup()).
+ *
+ * Triggering the bug needs a map with 0x80000000 entries, i.e. a 16 GiB
+ * allocation, so check the emitted compare instead: a regression to the
+ * 64-bit form makes the test fail.
+ */
+
+static char log_buf[16 * 1024];
+
+/* Loads a program that inlines bpf_map_lookup_elem() on @map_fd and
+ * returns 2 (XDP_PASS) when the element is found, 1 (XDP_DROP) when the
+ * lookup returns NULL.
+ */
+static int load_lookup_prog(int map_fd, __u32 key)
+{
+	const struct bpf_insn insns[] = {
+		BPF_LD_MAP_FD(BPF_REG_1, map_fd),
+		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+		BPF_ST_MEM(BPF_W, BPF_REG_2, 0, key),
+		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 2 /* XDP_PASS */),
+		BPF_JMP_A(1),
+		BPF_MOV64_IMM(BPF_REG_0, 1 /* XDP_DROP */),
+		BPF_EXIT_INSN(),
+	};
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		    .log_buf = log_buf,
+		    .log_size = sizeof(log_buf),
+		    .log_level = 1);
+	int fd;
+
+	fd = bpf_prog_load(BPF_PROG_TYPE_XDP, "gen_lookup_test", "GPL",
+			   insns, ARRAY_SIZE(insns), &opts);
+	if (fd < 0)
+		fprintf(stderr, "load failed: %s\n", log_buf);
+	return fd;
+}
+
+static void check_jmp32(int prog_fd, __u32 max_entries, const char *what)
+{
+	struct bpf_prog_info info = {};
+	__u32 info_len = sizeof(info), len;
+	struct bpf_insn *xlated;
+	__u32 i, jge32 = 0, jge64 = 0;
+	int err;
+
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
+	if (!ASSERT_OK(err, "prog_get_info"))
+		return;
+
+	len = info.xlated_prog_len;
+	xlated = calloc(1, len);
+	if (!ASSERT_OK_PTR(xlated, "calloc xlated"))
+		return;
+
+	memset(&info, 0, sizeof(info));
+	info.xlated_prog_len = len;
+	info.xlated_prog_insns = ptr_to_u64(xlated);
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
+	if (!ASSERT_OK(err, "prog_get_info xlated"))
+		goto out;
+
+	for (i = 0; i + 1 < info.xlated_prog_len / (u32)sizeof(*xlated); i++) {
+		if (xlated[i].code != (BPF_LDX | BPF_W | BPF_MEM))
+			continue;
+		if (xlated[i + 1].code != (BPF_JMP32 | BPF_JGE | BPF_K) &&
+		    xlated[i + 1].code != (BPF_JMP | BPF_JGE | BPF_K))
+			continue;
+		/* The bounds check follows the index load and uses its result. */
+		if (xlated[i + 1].dst_reg != xlated[i].dst_reg)
+			continue;
+		if (xlated[i + 1].imm != (int)max_entries)
+			continue;
+
+		if (xlated[i + 1].code == (BPF_JMP32 | BPF_JGE | BPF_K))
+			jge32++;
+		else
+			jge64++;
+	}
+
+	ASSERT_EQ(jge64, 0, "no 64-bit JGE after index load");
+	ASSERT_EQ(jge32, 1, what);
+
+out:
+	free(xlated);
+}
+
+static void run_lookup(int map_fd, __u32 key, bool expect_found)
+{
+	static char data[64];
+	int prog_fd = load_lookup_prog(map_fd, key);
+
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		    .data_in = data,
+		    .data_size_in = sizeof(data));
+
+	if (!ASSERT_GE(prog_fd, 0, "prog load"))
+		return;
+
+	if (!ASSERT_OK(bpf_prog_test_run_opts(prog_fd, &opts), "test_run"))
+		goto out;
+
+	if (expect_found)
+		ASSERT_EQ(opts.retval, 2, "in-range lookup found");
+	else
+		ASSERT_EQ(opts.retval, 1, "out-of-range lookup NULL");
+
+out:
+	close(prog_fd);
+}
+
+void test_array_gen_lookup_jmp32(void)
+{
+	const __u32 max_entries = 4;
+	LIBBPF_OPTS(bpf_map_create_opts, copts);
+	LIBBPF_OPTS(bpf_map_create_opts, oopts);
+	int map_fd = -1, pcpu_fd = -1, inner_fd = -1, outer_fd = -1, prog_fd;
+	__u32 key = 1;
+	__u64 val = 0x1234;
+
+	/* The lookup is inlined only for 64-bit programs with the JIT on. */
+	if (!is_jit_enabled() || sizeof(void *) != 8) {
+		test__skip();
+		return;
+	}
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "arr", sizeof(__u32),
+				sizeof(__u64), max_entries, &copts);
+	if (!ASSERT_GE(map_fd, 0, "array map"))
+		goto out;
+	if (!ASSERT_OK(bpf_map_update_elem(map_fd, &key, &val, BPF_ANY),
+		       "fill array"))
+		goto out;
+
+	pcpu_fd = bpf_map_create(BPF_MAP_TYPE_PERCPU_ARRAY, "parr",
+				 sizeof(__u32), sizeof(__u64), max_entries, &copts);
+	if (!ASSERT_GE(pcpu_fd, 0, "percpu array map"))
+		goto out;
+
+	inner_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "inner", sizeof(__u32),
+				  sizeof(__u64), 1, &copts);
+	if (!ASSERT_GE(inner_fd, 0, "inner map"))
+		goto out;
+
+	oopts.inner_map_fd = inner_fd;
+	outer_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY_OF_MAPS, "aom",
+				  sizeof(__u32), sizeof(__u32), max_entries,
+				  &oopts);
+	if (!ASSERT_GE(outer_fd, 0, "array of maps"))
+		goto out;
+	if (!ASSERT_OK(bpf_map_update_elem(outer_fd, &key, &inner_fd, BPF_ANY),
+		       "fill array of maps"))
+		goto out;
+
+	prog_fd = load_lookup_prog(map_fd, key);
+	if (!ASSERT_GE(prog_fd, 0, "load array prog"))
+		goto out;
+	check_jmp32(prog_fd, max_entries, "array gen_lookup uses JMP32 JGE");
+	close(prog_fd);
+
+	prog_fd = load_lookup_prog(pcpu_fd, key);
+	if (!ASSERT_GE(prog_fd, 0, "load percpu prog"))
+		goto out;
+	check_jmp32(prog_fd, max_entries, "percpu gen_lookup uses JMP32 JGE");
+	close(prog_fd);
+
+	prog_fd = load_lookup_prog(outer_fd, key);
+	if (!ASSERT_GE(prog_fd, 0, "load array of maps prog"))
+		goto out;
+	check_jmp32(prog_fd, max_entries, "array of maps gen_lookup uses JMP32 JGE");
+	close(prog_fd);
+
+	/* The inlined lookup still works, in range and out of range. */
+	run_lookup(map_fd, key, true);
+	run_lookup(map_fd, max_entries + 5, false);
+	run_lookup(pcpu_fd, key, true);
+	run_lookup(pcpu_fd, max_entries + 5, false);
+	run_lookup(outer_fd, key, true);
+	run_lookup(outer_fd, max_entries + 5, false);
+
+out:
+	if (outer_fd >= 0)
+		close(outer_fd);
+	if (inner_fd >= 0)
+		close(inner_fd);
+	if (pcpu_fd >= 0)
+		close(pcpu_fd);
+	if (map_fd >= 0)
+		close(map_fd);
+}
\ No newline at end of file
-- 
2.54.0

