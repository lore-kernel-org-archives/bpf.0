Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794668888;
	b=kNEh+fvbPAirdaoTmJ1pmRkUwGjjmkokEuOl8ytgB69R09rgHyo0qVN2lEctzfnuHw3a
	 nyEIxINmclfen+6pHRrc2MnYTZAZJOuzD13l3MpVyrw/YUzSOVTF4/D5kgPF+Fsft5m/E
	 spfirQPepMRp8YGIGsKWmugVUhPG+lIy8XODG/558TAP+brzjP/jAYhZuNzVVKP7COhK6
	 ITI1ocfU1Uwysckda6+6sGbyHD8/vmTXIKfZQtiu5g6h94j+TYsGtBsEdcTB2mLO87jPQ
	 g54PAS2VNpKcmj3zPHDmU8WE7z241s9+pMRSkot0FURvcJybA01eF9dYIOOn8Angbxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794668888;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ci9vDSWyHxSq9FnZq3Zk79d2N7kH1vKnpPKWHcUFCWk=;
	b=EYZfnh0rzlmmae6FINJSWayxseIC3PN7eHW+S/P4bAF7nd8HDIirf9p6SxsncsTo0GI2
	 qTC98tqqRqNgxBh4Nxyqq0i84d98y9bEIlklADBz37qmZiQZTxcFi2hdaD6/EPzame26H
	 zMY5GcvIebLMbmf+UUynpKwynNuw+uZSBNjS9iigAYMbDbHTUQ/vg+MuoZqzZXlEe2qyQ
	 BIEzoICRQAhF9lwu4NnsMRBTZxxNMthSNAv0ITe854occ6pTUOOiGVZ4iDMnr9B+olgug
	 5HnxVm++LlBfbrXH42G/lJadnl8xv3y9QmYALqYZ06sDHAGTFOzlSruJWcNlyYlbFKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SwOhxMQM;
	arc=none smtp.remote-ip=91.218.175.72
Received: from mta0.migadu.com (out-72.mta0.migadu.com [91.218.175.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC426606A323
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 15:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC426606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SwOhxMQM
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uLmLi4eG+xNd/B9EvuWggXquRDTQtxE2MGsM+EpVXzc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794668885; v=1; x=1795273685;
 b=SwOhxMQMxM2hPaTaM3Ru5xhJJ6QAKDU8hTAUi8K5S3uwBmZuEJo0IWQZGIuv9FDLDL0UdAPN
 6bKxV56dgUMspvikUPUTh893grHabWv5B7t0om9aOuNIJB3ekNGBxJewvYHwET3OKEvLfjIBQGB
 aJkFdNNiKKPeWXS9Nm76g4XA=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ee575a0b9f653efa;
	Sat, 14 Nov 2026 15:08:05 +0000
X-Mizu-Trace-ID: ee575a0b9f653efa
X-Migadu-Flow: FLOW_OUT
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
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 9/9] selftests/bpf: Verify cgroup prog link_create logs
Date: Sat, 14 Nov 2026 23:06:10 +0800
Message-ID: <20261114150610.84507-10-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114150610.84507-1-leon.hwang@linux.dev>
References: <20261114150610.84507-1-leon.hwang@linux.dev>
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

Check the error code, log message, and reported log size for unsupported
flags, invalid target FDs, and relative attachment errors. Cover missing
or conflicting ordering flags, a missing BPF_F_LINK flag, invalid link FDs
and IDs, preorder mismatches, and anchors outside the target cgroup.

Also cover revision mismatches, conflicting attachment flags, cgroup
hierarchy restrictions, and the per-cgroup program limit.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/cgroup_link.c    | 324 ++++++++++++++++++
 1 file changed, 324 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_link.c b/tools/testing/selftests/bpf/prog_tests/cgroup_link.c
index 15093a69510e..5a27d3a6a26c 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_link.c
@@ -253,3 +253,327 @@ void serial_test_cgroup_link(void)
 	}
 	cleanup_cgroup_environment();
 }
+
+static void check_cgroup_link_create_log(int prog_fd, int target_fd,
+					 struct bpf_link_create_opts *opts,
+					 int err_exp, const char *msg)
+{
+	char log_buf[128] = {};
+	LIBBPF_OPTS(bpf_log_opts, log_opts,
+		    .buf = log_buf,
+		    .size = sizeof(log_buf),
+		    .level = 1,
+	);
+	int fd;
+
+	opts->log_opts = &log_opts;
+	fd = bpf_link_create(prog_fd, target_fd, BPF_CGROUP_INET_EGRESS, opts);
+	if (!ASSERT_LT(fd, 0, "bpf_link_create")) {
+		close(fd);
+		return;
+	}
+
+	ASSERT_EQ(fd, err_exp, "err");
+	ASSERT_STREQ(log_buf, msg, "log_buf");
+	ASSERT_EQ(log_opts.true_size, strlen(msg) + 1, "log_size");
+}
+
+static void test_cgroup_link_create_log(int target_fd, __u32 flags, int err_exp, const char *msg)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, opts,
+		    .flags = flags,
+	);
+	struct test_cgroup_link *skel;
+
+	skel = test_cgroup_link__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_cgroup_link__open_and_load"))
+		return;
+
+	check_cgroup_link_create_log(bpf_program__fd(skel->progs.egress), target_fd, &opts,
+				     err_exp, msg);
+
+	test_cgroup_link__destroy(skel);
+}
+
+static void test_log_invalid_flags(void)
+{
+	const char *msg = "Invalid flags.\n";
+
+	test_cgroup_link_create_log(-1, BPF_F_ALLOW_OVERRIDE, -EINVAL, msg);
+}
+
+static void test_log_invalid_target_fd(void)
+{
+	const char *msg = "Invalid target_fd.\n";
+
+	test_cgroup_link_create_log(-1, 0, -EBADF, msg);
+}
+
+static void test_log_cgroup_attach(struct bpf_link_create_opts *opts,
+				   int err_exp, const char *msg)
+{
+	struct test_cgroup_link *skel;
+	int cg;
+
+	cg = test__join_cgroup("/cgroup_link_log_attach");
+	if (!ASSERT_GE(cg, 0, "join_cgroup"))
+		return;
+
+	skel = test_cgroup_link__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_cgroup_link__open_and_load"))
+		goto out;
+
+	check_cgroup_link_create_log(bpf_program__fd(skel->progs.egress), cg, opts, err_exp, msg);
+	test_cgroup_link__destroy(skel);
+
+out:
+	close(cg);
+}
+
+static void test_log_relative_without_order(void)
+{
+	const char *msg = "Specify exactly one of BPF_F_BEFORE or BPF_F_AFTER.\n";
+	LIBBPF_OPTS(bpf_link_create_opts, opts,
+		    .flags = BPF_F_LINK,
+	);
+
+	test_log_cgroup_attach(&opts, -EINVAL, msg);
+}
+
+static void test_log_relative_both_orders(void)
+{
+	const char *msg = "Specify exactly one of BPF_F_BEFORE or BPF_F_AFTER.\n";
+	LIBBPF_OPTS(bpf_link_create_opts, opts,
+		    .flags = BPF_F_LINK | BPF_F_BEFORE | BPF_F_AFTER,
+	);
+
+	test_log_cgroup_attach(&opts, -EINVAL, msg);
+}
+
+static void test_log_relative_type_mismatch(void)
+{
+	const char *msg = "BPF_F_LINK is required for relative link attachment.\n";
+	LIBBPF_OPTS(bpf_link_create_opts, opts,
+		    .flags = BPF_F_BEFORE,
+		    .cgroup.relative_fd = -1,
+	);
+
+	test_log_cgroup_attach(&opts, -EINVAL, msg);
+}
+
+static void test_log_invalid_relative_link_fd(void)
+{
+	const char *msg = "Invalid relative link FD.\n";
+	LIBBPF_OPTS(bpf_link_create_opts, opts,
+		    .flags = BPF_F_LINK | BPF_F_BEFORE,
+		    .cgroup.relative_fd = -1,
+	);
+
+	test_log_cgroup_attach(&opts, -EBADF, msg);
+}
+
+static void test_log_invalid_relative_link_id(void)
+{
+	const char *msg = "Invalid relative link ID.\n";
+	/* Link ID zero cannot identify a link. */
+	LIBBPF_OPTS(bpf_link_create_opts, opts,
+		    .flags = BPF_F_LINK | BPF_F_ID | BPF_F_BEFORE,
+	);
+
+	test_log_cgroup_attach(&opts, -ENOENT, msg);
+}
+
+static void test_log_relative_anchor(__u32 flags, bool other_cgroup, int err_exp, const char *msg)
+{
+	int cg, other_cg = -1, anchor_fd = -1, prog_fd;
+	LIBBPF_OPTS(bpf_link_create_opts, opts,
+		    .flags = flags,
+	);
+	struct test_cgroup_link *skel;
+
+	cg = test__join_cgroup("/cgroup_link_log_relative");
+	if (!ASSERT_GE(cg, 0, "join_cgroup"))
+		return;
+
+	if (other_cgroup) {
+		other_cg = test__join_cgroup("/cgroup_link_log_other");
+		if (!ASSERT_GE(other_cg, 0, "join_cgroup other"))
+			goto cleanup;
+	}
+
+	skel = test_cgroup_link__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_cgroup_link__open_and_load"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.egress);
+	anchor_fd = bpf_link_create(prog_fd, cg, BPF_CGROUP_INET_EGRESS, NULL);
+	if (!ASSERT_GE(anchor_fd, 0, "bpf_link_create"))
+		goto destroy;
+
+	if (flags & BPF_F_LINK)
+		opts.cgroup.relative_fd = anchor_fd;
+	check_cgroup_link_create_log(prog_fd, other_cgroup ? other_cg : cg, &opts, err_exp, msg);
+
+	close(anchor_fd);
+
+destroy:
+	test_cgroup_link__destroy(skel);
+cleanup:
+	if (other_cg >= 0)
+		close(other_cg);
+	close(cg);
+}
+
+static void test_log_both_orders(void)
+{
+	const char *msg = "BPF_F_BEFORE and BPF_F_AFTER are mutually exclusive.\n";
+
+	test_log_relative_anchor(BPF_F_BEFORE | BPF_F_AFTER, false, -EINVAL, msg);
+}
+
+static void test_log_relative_preorder_mismatch(void)
+{
+	const char *msg = "Relative attachment BPF_F_PREORDER mismatch.\n";
+
+	test_log_relative_anchor(BPF_F_LINK | BPF_F_BEFORE | BPF_F_PREORDER, false, -EINVAL, msg);
+}
+
+static void test_log_relative_not_in_cgroup(void)
+{
+	const char *msg = "Relative attachment not found in target cgroup.\n";
+
+	test_log_relative_anchor(BPF_F_LINK | BPF_F_BEFORE, true, -ENOENT, msg);
+}
+
+static void test_log_revision_mismatch(void)
+{
+	const char *msg = "Cgroup revision mismatch: expected 2, actual 1.\n";
+	LIBBPF_OPTS(bpf_link_create_opts, opts,
+		    .cgroup.expected_revision = 2,
+	);
+
+	test_log_cgroup_attach(&opts, -ESTALE, msg);
+}
+
+static void test_log_exclusive_attach(bool child, const char *msg)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, opts);
+	int cg, child_cg = -1, prog_fd, err;
+	struct test_cgroup_link *skel;
+
+	cg = test__join_cgroup("/cgroup_link_log_exclusive");
+	if (!ASSERT_GE(cg, 0, "join_cgroup"))
+		return;
+
+	if (child) {
+		child_cg = test__join_cgroup("/cgroup_link_log_exclusive/child");
+		if (!ASSERT_GE(child_cg, 0, "join_child_cgroup"))
+			goto cleanup;
+	}
+
+	skel = test_cgroup_link__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_cgroup_link__open_and_load"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.egress);
+
+	err = bpf_prog_attach(prog_fd, cg, BPF_CGROUP_INET_EGRESS, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto destroy;
+
+	check_cgroup_link_create_log(prog_fd, child ? child_cg : cg, &opts, -EPERM, msg);
+
+	err = bpf_prog_detach2(prog_fd, cg, BPF_CGROUP_INET_EGRESS);
+	ASSERT_OK(err, "bpf_prog_detach2");
+
+destroy:
+	test_cgroup_link__destroy(skel);
+cleanup:
+	if (child_cg >= 0)
+		close(child_cg);
+	close(cg);
+}
+
+static void test_log_attachment_flags_conflict(void)
+{
+	const char *msg = "Attachment flags conflict with existing flags.\n";
+
+	test_log_exclusive_attach(false, msg);
+}
+
+static void test_log_hierarchy_disallows_attach(void)
+{
+	const char *msg = "Cgroup hierarchy does not allow attachment.\n";
+
+	test_log_exclusive_attach(true, msg);
+}
+
+#define BPF_CGROUP_MAX_PROGS 64
+
+static void test_log_too_many_programs(void)
+{
+	const char *msg = "Too many programs attached to cgroup (limit 64).\n";
+	LIBBPF_OPTS(bpf_link_create_opts, opts);
+	int cg, prog_fd, err, i, nr_links = 0;
+	int link_fds[BPF_CGROUP_MAX_PROGS];
+	struct test_cgroup_link *skel;
+
+	cg = test__join_cgroup("/cgroup_link_log_limit");
+	if (!ASSERT_GE(cg, 0, "join_cgroup"))
+		return;
+
+	skel = test_cgroup_link__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_cgroup_link__open_and_load"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.egress);
+
+	for (i = 0; i < ARRAY_SIZE(link_fds); i++) {
+		err = bpf_link_create(prog_fd, cg, BPF_CGROUP_INET_EGRESS, NULL);
+		if (!ASSERT_GE(err, 0, "bpf_link_create"))
+			goto destroy;
+
+		link_fds[nr_links++] = err;
+	}
+
+	check_cgroup_link_create_log(prog_fd, cg, &opts, -E2BIG, msg);
+
+destroy:
+	for (i = 0; i < nr_links; i++)
+		close(link_fds[i]);
+	test_cgroup_link__destroy(skel);
+cleanup:
+	close(cg);
+}
+
+void test_cgroup_link_log(void)
+{
+	if (test__start_subtest("invalid_flags"))
+		test_log_invalid_flags();
+	if (test__start_subtest("invalid_target_fd"))
+		test_log_invalid_target_fd();
+	if (test__start_subtest("relative_without_order"))
+		test_log_relative_without_order();
+	if (test__start_subtest("relative_both_orders"))
+		test_log_relative_both_orders();
+	if (test__start_subtest("relative_type_mismatch"))
+		test_log_relative_type_mismatch();
+	if (test__start_subtest("invalid_relative_link_fd"))
+		test_log_invalid_relative_link_fd();
+	if (test__start_subtest("invalid_relative_link_id"))
+		test_log_invalid_relative_link_id();
+	if (test__start_subtest("both_orders"))
+		test_log_both_orders();
+	if (test__start_subtest("relative_preorder_mismatch"))
+		test_log_relative_preorder_mismatch();
+	if (test__start_subtest("relative_not_in_cgroup"))
+		test_log_relative_not_in_cgroup();
+	if (test__start_subtest("revision_mismatch"))
+		test_log_revision_mismatch();
+	if (test__start_subtest("attachment_flags_conflict"))
+		test_log_attachment_flags_conflict();
+	if (test__start_subtest("hierarchy_disallows_attach"))
+		test_log_hierarchy_disallows_attach();
+	if (test__start_subtest("too_many_programs"))
+		test_log_too_many_programs();
+}
-- 
2.55.0

