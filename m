Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2689248BD48
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784129643; cv=none; b=tQT0fd4LhJBoiJuK5lIP7ImaigW2DR3dmz/DdOmQFi4opxgWuCshJLwjWPktpOxOWwp/eYRiFEJWPi2MH21+YBCZoKtDgFuaWndq8+HqkqM2U63pUgfmrBzBsbpfqfcazKUyV2uBe4TtST5qbuohC20KL4bjzRa34LOKfF7n5Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784129643; c=relaxed/simple;
	bh=9VUVkuDLNQLapCOn23MphWt3JIcg5d8d10IFnq8dNtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gP6uYLlIjMmlSDg9ZWyxATeSRgGlqlhiEnCqg8vF9Bc4If+HqtiyA9I6esTXYVE0csP8/kOdC/yeeNfSlR1OGFmU+yTeapB6U91n3si8Btb4uTkizY6yohnbYAU1oKmkp1bEcaWAoeBEJG7rapp+wDw/jve0GLnCdTVuEqh5biw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vf8fCgWf; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vf8fCgWf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784129639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KhEu73XdDjzOZKOTaznlKskzsmU22YqaUUFeK6qekak=;
	b=Vf8fCgWf/u08hba2gqVMkCZt+s2Nay8B782PE2Et3rLDQvL69jip6Fw53uHCLjNqC6/HOG
	nrfBW5Y7L5rSlslpdkqlwi6XjJHht1RQLXYiuOTQ6NMdhi4/J03v1Zwn2MGVQkDK9GA74q
	NJwxWcZ5eFKc24sFIO738AAzOvynv7E=
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
Subject: [PATCH bpf-next v10 8/9] selftests/bpf: Test verifier log for global percpu data
Date: Wed, 15 Jul 2026 23:32:52 +0800
Message-ID: <20260715153254.92010-9-leon.hwang@linux.dev>
In-Reply-To: <20260715153254.92010-1-leon.hwang@linux.dev>
References: <20260715153254.92010-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add two tests to verify the verifier log
"R%d points to percpu_array map which cannot be used as const string\n".

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../bpf/prog_tests/global_data_init.c         |  6 +++++
 .../bpf/progs/test_global_percpu_data.c       | 23 +++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
index d4405646847a..598b7dde6581 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
@@ -278,6 +278,11 @@ static void test_global_percpu_data_rdonly_direct_write(void)
 	close(map_fd);
 }
 
+static void test_global_percpu_data_verifier_log(void)
+{
+	RUN_TESTS(test_global_percpu_data);
+}
+
 void test_global_percpu_data(void)
 {
 	if (!feat_supported(NULL, FEAT_PERCPU_DATA)) {
@@ -293,4 +298,5 @@ void test_global_percpu_data(void)
 		test_global_percpu_data_rdonly_direct_read();
 	if (test__start_subtest("rdonly_direct_write"))
 		test_global_percpu_data_rdonly_direct_write();
+	test_global_percpu_data_verifier_log();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
index 54380dfb11a5..b852a0b07508 100644
--- a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
+++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
@@ -30,4 +30,27 @@ int update_percpu_data(void *ctx)
 	return 0;
 }
 
+static const char fmt[] SEC(".percpu.fmt") = "data %d\n";
+
+SEC("?kprobe")
+__failure __msg("R{{[0-9]+}} points to percpu_array map which cannot be used as const string")
+int verifier_strncmp(void *ctx)
+{
+	return bpf_strncmp("test", 5, fmt);
+}
+
+SEC("?kprobe")
+__failure __msg("R{{[0-9]+}} points to percpu_array map which cannot be used as const string")
+int verifier_snprintf(void *ctx)
+{
+	u64 args[] = { data };
+	char buf[128];
+	int len;
+
+	len = bpf_snprintf(buf, sizeof(buf), fmt, args, sizeof(args));
+	if (len > 0)
+		bpf_printk("snprintf: %s\n", buf);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.55.0

