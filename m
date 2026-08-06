Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D1830D3ED
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033980; cv=none; b=oyAz0rbrea7n7+mFtJaUv/dykJ8hjrL9HU5Sh63Vg5e/H9p92LogdRUqUuI3m9ZhNUHqg3rKt9bx5FVN3Kq1YQyfDobEiGCg9mo3S72/KFHq4fWVR4W+8R7oxShv6R35DAWAfj7bqtNEWHsh84cV8rY8QSEr7dRR8FzhQZkjDmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033980; c=relaxed/simple;
	bh=8vLd4u5J9b3dhBvJpv2Pug7IyKEGnIJm26/jtssGtik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rg7hfm20tS0Ko9fh5NYBBf+geNXGWNL1ZiZdfEWkBajdMq+8o26v4T8cCF900bND/Bzz63/R7iNgIiVuKHsiemD5GlbSd2y4IhPvemUo40VlR5KG+7WcSSDZpH5qAQ+bClhb3IbVvYhNos+DUKAv4J1GA2oMfBqFfOFRcavusIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jXV9RzIx; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jXV9RzIx"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786033975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B7NrFgaFB6A1vdYXnlt1fXVnUYINivJU3/7O6RkkV6w=;
	b=jXV9RzIx2+tv0CKr9fOGeN9GCnz/4B27IqgAEggwIquuw+Lozn9H2ujcuskihf0EQBkkfb
	+XZEVY2W3kUUpNRc44vq9JlU4Grg1DRx5rN2jR+vV7AHwrvY66dYq9u+XslGonKdQXq3Al
	W+0yO0fGIQEbyQvaQkyeMLri2QbK4co=
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
	kernel-patches-bot@fb.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v11 09/10] selftests/bpf: Test verifier log for global percpu data
Date: Fri,  7 Aug 2026 00:31:24 +0800
Message-ID: <20260806163125.11172-10-leon.hwang@linux.dev>
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

Add two tests to verify the verifier log
"R%d points to percpu_array map which cannot be used as const string\n".

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../bpf/prog_tests/global_data_init.c         |  6 +++++
 .../bpf/progs/test_global_percpu_data.c       | 23 +++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
index 23a7e676abd6..91f6ec07ba85 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
@@ -296,6 +296,11 @@ static void test_global_percpu_data_rdonly_direct_write(void)
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
@@ -311,4 +316,5 @@ void test_global_percpu_data(void)
 		test_global_percpu_data_rdonly_direct_read();
 	if (test__start_subtest("rdonly_direct_write"))
 		test_global_percpu_data_rdonly_direct_write();
+	test_global_percpu_data_verifier_log();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
index b106314ba4e3..202cb9e8375b 100644
--- a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
+++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
@@ -37,4 +37,27 @@ int update_percpu_data(void *ctx)
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

