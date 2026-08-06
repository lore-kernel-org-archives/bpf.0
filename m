Received: from out-189.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A3A36D503;
	Thu,  6 Aug 2026 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033976; cv=none; b=NWjhbFfmMVVODRrNJjhxK3P9kkycS+HYZlcKRLYKMjhcAHa/h6Gjkz+kTrI88jxTzZ0D2bqaDwtHnPUJ/jDeeWIoWvGWsQBshfDrRG+AXjyOwVJMAWcFhdSpsktqk3egQ3L1TFywFW//yJgeqnlpEyagvQh3MPK6LLIDuwAhHaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033976; c=relaxed/simple;
	bh=6wIa2MxUvgoScM6qcCvscyS6KZoG11mPZt+YIOxIzu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qswhNLIIUYBXB84ZzzZc+mb+s9nCoEPYVio4nMzFKnXr9lc3wtMyhJJBmXUqu6ZtaJwthrvqKtCvQk1Fku/qR8tLxTlpkls5AsAhP4VjkGXHTUXHr6e534FhhznKU2FcRq0K2KEyRi5NHhUsw4CkGKo6BJ3GOF9iNY+uNxQ0P04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BotJDvu6; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BotJDvu6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786033971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dOMbDsCCmsO+Te89y6JQ49E9CDtkzXKhshe9x4tRNPg=;
	b=BotJDvu6ymgGjAlM+yicu8v5i8aChIbysfn3sB9brPw6OybkxFLKz64zDI8QcS1Q80DrKQ
	M1r94EdZ5YxOqby2/I20TQqSc2yDeiV9JbFZLewZfbJVafPmE93wqkMyhKXpHdWlZOIH7D
	fgj1kbRexNXgEoOgl8Pr2ppPpqskdyc=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v11 08/10] selftests/bpf: Test direct reading/writing read-only percpu_array map
Date: Fri,  7 Aug 2026 00:31:23 +0800
Message-ID: <20260806163125.11172-9-leon.hwang@linux.dev>
In-Reply-To: <20260806163125.11172-1-leon.hwang@linux.dev>
References: <20260806163125.11172-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Verify these two cases:

1. Direct reading the data of read-only percpu data's percpu_array map
   is allowed.
2. Direct writing the data of read-only percpu data's percpu_array map
   is disallowed.

Assisted-by: Codex:gpt-5.5-xhigh
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../bpf/prog_tests/global_data_init.c         | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
index b3aca2cb4ab6..23a7e676abd6 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
@@ -210,6 +210,92 @@ static void test_global_percpu_data_lskel(void)
 	test_global_percpu_data_lskel__destroy(lskel);
 }
 
+static int create_rdonly_percpu_array(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts,
+		    .map_flags = BPF_F_RDONLY_PROG,
+	);
+	int key = 0, map_fd, err;
+	__u64 value = 0;
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_PERCPU_ARRAY, "percpu_ro_map", sizeof(int),
+				sizeof(__u64), 1, &map_opts);
+	if (!ASSERT_GE(map_fd, 0, "bpf_map_create"))
+		return -1;
+
+	err = bpf_map_update_elem(map_fd, &key, &value, BPF_F_ALL_CPUS);
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
+		goto out;
+
+	err = bpf_map_freeze(map_fd);
+	if (!ASSERT_OK(err, "bpf_map_freeze"))
+		goto out;
+
+	return map_fd;
+
+out:
+	close(map_fd);
+	return -1;
+}
+
+static void test_global_percpu_data_rdonly_direct_read(void)
+{
+	/*
+	 * Raw instructions with manually prepared rdonly percpu_array map
+	 * for testing direct-read global percpu data, because libbpf
+	 * doesn't have rdonly internal percpu_array map support for
+	 * global percpu data.
+	 */
+	struct bpf_insn insns[] = {
+		BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0),
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
+		BPF_EXIT_INSN(),
+	};
+	int map_fd, prog_fd;
+
+	map_fd = create_rdonly_percpu_array();
+	if (map_fd < 0)
+		return;
+
+	insns[0].imm = map_fd;
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, "percpu_ro_prog", "GPL", insns,
+				ARRAY_SIZE(insns), NULL);
+	if (ASSERT_GE(prog_fd, 0, "bpf_prog_load"))
+		close(prog_fd);
+	close(map_fd);
+}
+
+static void test_global_percpu_data_rdonly_direct_write(void)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts);
+	/* See the comment in test_global_percpu_data_rdonly_direct_read() */
+	struct bpf_insn insns[] = {
+		BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0),
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
+		BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
+		BPF_EXIT_INSN(),
+	};
+	char log_buf[256] = {};
+	int map_fd, prog_fd;
+
+	prog_opts.log_buf = log_buf;
+	prog_opts.log_size = sizeof(log_buf);
+	prog_opts.log_level = 1;
+
+	map_fd = create_rdonly_percpu_array();
+	if (map_fd < 0)
+		return;
+
+	insns[0].imm = map_fd;
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, "percpu_ro_prog", "GPL", insns,
+				ARRAY_SIZE(insns), &prog_opts);
+	if (!ASSERT_LT(prog_fd, 0, "bpf_prog_load"))
+		close(prog_fd);
+	else
+		ASSERT_HAS_SUBSTR(log_buf, "write into map forbidden", "verifier log");
+	close(map_fd);
+}
+
 void test_global_percpu_data(void)
 {
 	if (!feat_supported(NULL, FEAT_PERCPU_DATA)) {
@@ -221,4 +307,8 @@ void test_global_percpu_data(void)
 		test_global_percpu_data_init();
 	if (test__start_subtest("lskel"))
 		test_global_percpu_data_lskel();
+	if (test__start_subtest("rdonly_direct_read"))
+		test_global_percpu_data_rdonly_direct_read();
+	if (test__start_subtest("rdonly_direct_write"))
+		test_global_percpu_data_rdonly_direct_write();
 }
-- 
2.55.0

