Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27E63E8343
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930391; cv=none; b=T8nUU+WrGXnJrDEDFMsSuRXekcupzSNp3nVb1kYY1/egfp1+9yEfvpnrSMfWQAPTqjC3Pmz8hYHtpiEaeMVjOmM9TVj2HWNWTNJaoNmICAu1HwkWh/Vw02lKusXD8OZ0xFDu3Wx5+dsbPEPwRk8h8Y8XlleCBYyfM3Ys6junmIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930391; c=relaxed/simple;
	bh=uNjEJQVaiwGfjFqLcZSST6lRJJ35j68zmav5RUA9qzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjmZ66JkCEu+VTBfGY96pDmJuCv9ohbdymiPXyhqjlETEzndeUyK2QVjPPhu8ttaUj/jbhCoRdTNAnE3ge1JuGBplNzMJS2se/OekcpdqKzRik32k+BCCvDc+KlblX3ZOZb1alHmWDfcye8uA6XIHl0SaRkVQq+mCETl0o6gfLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LUfk9bnN; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LUfk9bnN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780930386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uwy7mfUyDgcryPy9sSPwAYDJt9jeqKziYtczq+do/PQ=;
	b=LUfk9bnNy+2Ib6kslcauVqTI8bXDNnpVbgnXLGMYN47+qND/jBwtteAaf35DYTQ7H8sahe
	WlLdz+4XqDsrGSb8vBXJElo6QqBw9Z13+GjiEfu8FEIpPpl6qtytmE1E8N0WBsQqLtX32f
	RnPnKGi3ASXD092Gk7EpEwUgjVSUTRo=
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
Subject: [PATCH bpf-next v5 7/9] selftests/bpf: Add tests to verify verifier log for global percpu data
Date: Mon,  8 Jun 2026 22:51:11 +0800
Message-ID: <20260608145113.65857-8-leon.hwang@linux.dev>
In-Reply-To: <20260608145113.65857-1-leon.hwang@linux.dev>
References: <20260608145113.65857-1-leon.hwang@linux.dev>
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
 .../bpf/prog_tests/global_data_init.c         |  7 ++++++
 .../bpf/progs/test_global_percpu_data.c       | 23 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
index 5abdb0b8b8b3..729878d5d3b3 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
@@ -244,6 +244,11 @@ static void test_global_percpu_data_lskel(void)
 	free(online);
 }
 
+static void test_global_percpu_data_verifier_log(void)
+{
+	RUN_TESTS(test_global_percpu_data);
+}
+
 void test_global_percpu_data(void)
 {
 	if (!feat_supported(NULL, FEAT_PERCPU_DATA)) {
@@ -255,4 +260,6 @@ void test_global_percpu_data(void)
 		test_global_percpu_data_init();
 	if (test__start_subtest("lskel"))
 		test_global_percpu_data_lskel();
+	if (test__start_subtest("verifier_log"))
+		test_global_percpu_data_verifier_log();
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

