Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E460F3BBFDC
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537333; cv=none; b=f7zirRK9w8jBnhOLMl37l9Yiw4mAmZM0IbJ64cvbTr4mkZmZyzRI2mUH+v7sG3UlbVduCpBPY3jGyqpq9Qy7nbCXSGskKeEKAEXnEkJ62JoWxXEcJr9rAfMQOg4QwJUg50gOTyORq2s/AatcqFzCUdS8upxm4/WWFFiR7Arwt+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537333; c=relaxed/simple;
	bh=yzPVTIL9VZ4C9oQf1TMMhUxzYQWpMKLL/+25ICrmjx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVvA47OfsG4WXgLliLNdhE+s7cjpqg6aUwLPtVQST/ndU/uT9IG0a9P3KBkUis4BFQi3LpvT4K3QQAx6qOgRLA05M6Wz83gi+M1MpIlWdFmB3R08xZbxCkG0vZGiFiUGRz25wa5nPueZGkfQbzZaqMTtUbxa7rhWz3efzCI9Ebs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QbykqQmt; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QbykqQmt"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781537329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tLiDtV7FMbtpUOGQvPa1N+o1D4eJIyOpSILvEUPoJc4=;
	b=QbykqQmtDtBiQ5fwtCZuNKFFEwNEvSuuE4B/oOT/fPNf1w4zicuNW/zE1TAVE8ux2uKvN1
	NzPkWra2CL9DATrfxHT1AP69ouY2fNjmghYT7aTZhjXwUSPhZTJfw4PI+guveiu/4gooyV
	Hik7NvQHhErZnulr5W2IqJVcX/FUZPI=
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
Subject: [PATCH bpf-next v6 10/12] selftests/bpf: Add tests to verify verifier log for global percpu data
Date: Mon, 15 Jun 2026 23:26:44 +0800
Message-ID: <20260615152646.27639-11-leon.hwang@linux.dev>
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

Add two tests to verify the verifier log
"R%d points to percpu_array map which cannot be used as const string\n".

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../bpf/prog_tests/global_data_init.c         |  6 +++++
 .../bpf/progs/test_global_percpu_data.c       | 23 +++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
index f59d83919058..e4c290492ff8 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
@@ -274,6 +274,11 @@ static void test_global_percpu_data_rdonly_direct_read(void)
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
@@ -287,4 +292,5 @@ void test_global_percpu_data(void)
 		test_global_percpu_data_lskel();
 	if (test__start_subtest("rdonly_direct_read"))
 		test_global_percpu_data_rdonly_direct_read();
+	test_global_percpu_data_verifier_log();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
index ba92ffb0ca49..2222ad3a49bd 100644
--- a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
+++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
@@ -28,4 +28,27 @@ int update_percpu_data(void *ctx)
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
+	len = bpf_snprintf(buf, sizeof(buf), fmt, args, 1);
+	if (len > 0)
+		bpf_printk("snprintf: %s\n", buf);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.54.0

