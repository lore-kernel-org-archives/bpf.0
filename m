Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF977405878
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537311; cv=none; b=D66e+dYFYzDV/g9ziZq6JoKmUfIMLIq6BjuWTlEvLFhb2uvUQDw68L4bhUZz/KrQ9UVmnehkXP7cWALlrR1tDne2PK+dxFQ4JLL2GJ0DwrmiS8ZELrkg2b+JhiaMUSHqlg/f7paJ6jn4bTdZsxl1V420Z8CpDCr187SWvtZKFwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537311; c=relaxed/simple;
	bh=+iVnkSjrUALapW3rs8Y6CctC8RqrBVxpwHvXo41etLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pm3UxPfJbV064CuR9IejgOJ/Mao9q1kiQOUCvOogowwj05M4tOI1Pemtjhf03Rpb7rskvBJgUHRYlEeIcXU6eoU4x+vWhlm7pUHa8v7zXtCbGxOckzmtVJMV692Q07bb35k6LArATbl5IDoCk9RKr767PvPgsRCKgzNPc0psyew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hikVLmHx; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hikVLmHx"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781537308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OsR3j4bPeNB81J31xotlVNAUKQzKW+YGnaUCPQ++dcw=;
	b=hikVLmHxZD970//jWVlEuEL06nVLDskYloHAHBhXhGvsPrnO1KLPNCqMSkDJGvGVACgz/p
	reP5H8DVC7Z5K6E4xUVurlt3DP+y+wPVmJyciNpyLi45a0Ujg46IGpg2vfVK4Rw0pLcP6Z
	B3UiMLzrCXTvEWv3f7dCNwD0YB38clU=
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
Subject: [PATCH bpf-next v6 09/12] selftests/bpf: Add test to verify accessing rdonly percpu_array
Date: Mon, 15 Jun 2026 23:26:43 +0800
Message-ID: <20260615152646.27639-10-leon.hwang@linux.dev>
In-Reply-To: <20260615152646.27639-1-leon.hwang@linux.dev>
References: <20260615152646.27639-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since percpu_array supports direct-read, it should not break accessing
rdonly percpu_array.

Add a test to verify that adding '.map_direct_value_addr' to percpu_array
won't break the case.

Assisted-by: Codex:gpt-5.5-xhigh
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../bpf/prog_tests/global_data_init.c         | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
index ea7e4e3d91cf..f59d83919058 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
@@ -232,6 +232,48 @@ static void test_global_percpu_data_lskel(void)
 	free(online);
 }
 
+static void test_global_percpu_data_rdonly_direct_read(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts,
+		    .map_flags = BPF_F_RDONLY_PROG,
+	);
+	struct bpf_insn insns[] = {
+		BPF_ST_MEM(BPF_W, BPF_REG_10, -8, 0),
+		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+		BPF_LD_MAP_FD(BPF_REG_1, 0),
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int key = 0, map_fd, prog_fd = -1, err;
+	__u64 value = 0;
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_PERCPU_ARRAY, "percpu_ro_map", sizeof(int),
+				sizeof(__u64), 1, &map_opts);
+	if (!ASSERT_GE(map_fd, 0, "bpf_map_create"))
+		return;
+
+	err = bpf_map_update_elem(map_fd, &key, &value, BPF_F_ALL_CPUS);
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
+		goto out;
+
+	err = bpf_map_freeze(map_fd);
+	if (!ASSERT_OK(err, "bpf_map_freeze"))
+		goto out;
+
+	insns[3].imm = map_fd;
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, "percpu_ro_prog", "GPL", insns,
+				ARRAY_SIZE(insns), NULL);
+	ASSERT_GE(prog_fd, 0, "bpf_prog_load");
+
+out:
+	if (prog_fd >= 0)
+		close(prog_fd);
+	close(map_fd);
+}
+
 void test_global_percpu_data(void)
 {
 	if (!feat_supported(NULL, FEAT_PERCPU_DATA)) {
@@ -243,4 +285,6 @@ void test_global_percpu_data(void)
 		test_global_percpu_data_init();
 	if (test__start_subtest("lskel"))
 		test_global_percpu_data_lskel();
+	if (test__start_subtest("rdonly_direct_read"))
+		test_global_percpu_data_rdonly_direct_read();
 }
-- 
2.54.0

