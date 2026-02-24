Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB853A6414
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947782; cv=none; b=SWh9rMynkdLG4QVIQqU6H/5tT8nNIOtcCYapKPscJo6oajCWkWNrKM/M3Ca+/daEc+P3BxFH6aMigIzufClRev7tfUWFasEfPC2zojaVz8j2wLsyjE+ZD2PewWpM21lZsz8OIN8iORIRUQA7pc092HIzPYbwP0gujad31Bps+5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947782; c=relaxed/simple;
	bh=uuVhZPMLQTKvEryzY971QiuVD2Q5biMcf6jIeRvmjdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SD91cnXVRpwo3h0iM6YuQrsAWWX9kZT1xLaOwsRYcf0wVDh/kGlwlSSZbh4uoKMyWOzoStg87Nt79+MZV+jcpq4QR5irsWrLJcQ6lOXOxvzxuVbn3EsLNR0Ig4T9AGo6ba6UxU3QSF0068LkxZY5v+q/Nrst3FHfNAWuggegZzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uZEM5850; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uZEM5850"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771947777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ajSl2pdKTk9QEmR1MISxYniJhjrbh949cm//bffiNdc=;
	b=uZEM5850Y3+L8n2F0E2j8gvf1S+N/9cpVe6vGsjsonYOWoAP+wN70FqWvPpNA7+gBckmtT
	HOu+F0hkzQan8fKFArHhGjZLnnjnOCPgEOIAtOhLsGSO4rVauNeoxJaaQNWNnK4H5uqgjU
	hFEvDwCEjejr491rTRD/pxQDq4bn4CQ=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Feng Yang <yangfeng@kylinos.cn>,
	Leon Hwang <leon.hwang@linux.dev>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 8/8] selftests/bpf: Add a test to verify session-kfunc compatibility enforcement
Date: Tue, 24 Feb 2026 23:40:24 +0800
Message-ID: <20260224154024.12504-9-leon.hwang@linux.dev>
In-Reply-To: <20260224154024.12504-1-leon.hwang@linux.dev>
References: <20260224154024.12504-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add prog_array coverage for tracing programs that differ in
bpf_session_cookie() / bpf_session_is_return() usage.

The test verifies one-way enforcement: !call_session_* programs
cannot tail-call call_session_* programs.

Assisted-by: Codex:gpt-5.3-codex
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/fsession_test.c  | 47 +++++++++++++++++++
 .../selftests/bpf/progs/fsession_test.c       |  6 +++
 2 files changed, 53 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/fsession_test.c b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
index a299aeb8cc2e..304986544a8d 100644
--- a/tools/testing/selftests/bpf/prog_tests/fsession_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
@@ -129,6 +129,51 @@ static void test_fsession_cookie(void)
 	fsession_test__destroy(skel);
 }
 
+static void test_fsession_prog_array_session_kfunc_compat(void)
+{
+	struct fsession_test *skel = NULL;
+	__u32 key = 0, session_kfunc_prog_fd, no_session_kfunc_prog_fd;
+	int map_fd = -1, err;
+
+	skel = fsession_test__open();
+	if (!ASSERT_OK_PTR(skel, "fsession_test__open"))
+		goto cleanup;
+
+	err = fsession_test__load(skel);
+	if (err == -EOPNOTSUPP) {
+		test__skip();
+		goto cleanup;
+	}
+	if (!ASSERT_OK(err, "fsession_test__load"))
+		goto cleanup;
+
+	session_kfunc_prog_fd = bpf_program__fd(skel->progs.test9);
+	no_session_kfunc_prog_fd = bpf_program__fd(skel->progs.test12);
+	if (!ASSERT_GE(session_kfunc_prog_fd, 0, "session_kfunc_prog_fd"))
+		goto cleanup;
+	if (!ASSERT_GE(no_session_kfunc_prog_fd, 0, "no_session_kfunc_prog_fd"))
+		goto cleanup;
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_PROG_ARRAY, NULL, sizeof(key),
+				sizeof(__u32), 1, NULL);
+	if (!ASSERT_GE(map_fd, 0, "bpf_map_create"))
+		goto cleanup;
+
+	err = bpf_map_update_elem(map_fd, &key, &no_session_kfunc_prog_fd, BPF_ANY);
+	if (!ASSERT_OK(err, "bpf_map_update_elem success"))
+		goto cleanup;
+
+	err = bpf_map_update_elem(map_fd, &key, &session_kfunc_prog_fd, BPF_ANY);
+	if (!ASSERT_ERR(err, "bpf_map_update_elem failure"))
+		goto cleanup;
+	ASSERT_EQ(errno, EINVAL, "bpf_map_update_elem errno");
+
+cleanup:
+	if (map_fd >= 0)
+		close(map_fd);
+	fsession_test__destroy(skel);
+}
+
 void test_fsession_test(void)
 {
 	if (test__start_subtest("fsession_test"))
@@ -137,4 +182,6 @@ void test_fsession_test(void)
 		test_fsession_reattach();
 	if (test__start_subtest("fsession_cookie"))
 		test_fsession_cookie();
+	if (test__start_subtest("fsession_prog_array_session_kfunc_compat"))
+		test_fsession_prog_array_session_kfunc_compat();
 }
diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
index 86e8a2fe467e..1e6be28bcc3d 100644
--- a/tools/testing/selftests/bpf/progs/fsession_test.c
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -177,3 +177,9 @@ int BPF_PROG(test11, int a)
 	test11_result = a == 1;
 	return 0;
 }
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test12, int a, int ret)
+{
+	return 0;
+}
-- 
2.52.0

