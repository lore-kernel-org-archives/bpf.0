Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76263EC2EA;
	Mon,  8 Jun 2026 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930406; cv=none; b=nqvdItRBjwMpkgzrjqovB9r8sHeh3hEzu6ydn67InUJwV37ewI9ncK63Y1RWL4XHENxu9JjMYDP6SBBIkDf0mXc4WVPjGFfVwPZN0MxEjrKFa2MiN6MlL0NrDcwQej7iTf95cmfjDLFS5q+yQwpLP3W4XIUr18XeQE1ZBmX19jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930406; c=relaxed/simple;
	bh=Pl7tYw4HIb7Q4Al7iFy0KP1+3bJ5bnGm7Psh7CNKj78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPoIUFy43syH9CYlYcyPcIQ9Qi3tjm2GdYljvBiwii1kcD374mX7A0ZpyXHcKO5lCoIRgIQvkrYu7QndiZVGWQu2WynEOQ5Mm6fSBURIWcLwcgUEzh/r4HeBUmiJvO341zw20NuVWT3oKis9MaZD+Z1bXwIAGuK8sGVeb/E00o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IyGeyX86; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IyGeyX86"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780930401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/YipO/dVbEf/rkjPdFkXbR7ai/n9Yp+2D4IvUsZ6fnQ=;
	b=IyGeyX86qW2NcXufPVn7ZV2UXTi83hg0Ri+Z9+964IZcDSW95CcQ5ZgliHxGEawJaUIMao
	BBgn0ZPz+DGESJTQwHe/kvtUDV8yqWloKMDh4C1i+jq93IsGyeoyEAqawRTO+KLVMfKGkW
	oPEgAejkoqNJ1HJ8NLaHwYj+NS91UBQ=
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
Subject: [PATCH bpf-next v5 9/9] selftests/bpf: Add test to verify bpf_iter for global percpu data
Date: Mon,  8 Jun 2026 22:51:13 +0800
Message-ID: <20260608145113.65857-10-leon.hwang@linux.dev>
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

Add a test to verify that it is OK to iter the percpu_array map used for
global percpu data.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../bpf/prog_tests/global_data_init.c         | 52 +++++++++++++++++++
 .../bpf/progs/test_global_percpu_data.c       | 25 +++++++++
 2 files changed, 77 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
index c3b9423246b5..6c1813ffe5f3 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
@@ -333,6 +333,56 @@ static void test_global_percpu_data_xlated(void)
 	free(insns);
 }
 
+static void test_global_percpu_data_iter(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	struct test_global_percpu_data *skel;
+	union bpf_iter_link_info linfo = {};
+	struct bpf_link *link = NULL;
+	int fd, num_cpus, len, err;
+	char buf[16];
+
+	num_cpus = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(num_cpus, 0, "libbpf_num_possible_cpus"))
+		return;
+
+	skel = test_global_percpu_data__open();
+	if (!ASSERT_OK_PTR(skel, "test_global_percpu_data__open"))
+		return;
+
+	skel->rodata->num_cpus = num_cpus;
+	skel->rodata->offsetof_num = offsetof(struct test_global_percpu_data__percpu, struct_data);
+	skel->rodata->offsetof_num += sizeof(skel->percpu->struct_data) - sizeof(int);
+	skel->rodata->elem_sz = roundup(sizeof(struct test_global_percpu_data__percpu), 8);
+	skel->percpu->struct_data.nums[6] = 0xc0de;
+
+	err = test_global_percpu_data__load(skel);
+	if (!ASSERT_OK(err, "test_global_percpu_data__load"))
+		goto out;
+
+	linfo.map.map_fd = bpf_map__fd(skel->maps.percpu);
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+	link = bpf_program__attach_iter(skel->progs.dump_percpu_data, &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_iter"))
+		goto out;
+
+	fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_GE(fd, 0, "bpf_iter_create"))
+		goto out;
+
+	while ((len = read(fd, buf, sizeof(buf))) > 0)
+		do { } while (0);
+	ASSERT_EQ(len, 0, "read iter");
+	ASSERT_TRUE(skel->bss->run_iter, "run_iter");
+	ASSERT_EQ(skel->bss->percpu_data_sum, 0xc0de * num_cpus, "percpu_data_sum");
+
+	close(fd);
+out:
+	bpf_link__destroy(link);
+	test_global_percpu_data__destroy(skel);
+}
+
 void test_global_percpu_data(void)
 {
 	if (!feat_supported(NULL, FEAT_PERCPU_DATA)) {
@@ -348,4 +398,6 @@ void test_global_percpu_data(void)
 		test_global_percpu_data_verifier_log();
 	if (test__start_subtest("xlated"))
 		test_global_percpu_data_xlated();
+	if (test__start_subtest("iter"))
+		test_global_percpu_data_iter();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
index 9a1b1a314c2f..037c8a05be4b 100644
--- a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
+++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
@@ -62,4 +62,29 @@ int verifier_percpu_read(void *ctx)
 	return c == ' ';
 }
 
+volatile const __u32 num_cpus = 0;
+volatile const int offsetof_num;
+volatile const int elem_sz;
+__u32 percpu_data_sum = 0;
+bool run_iter = false;
+
+SEC("iter/bpf_map_elem")
+__auxiliary
+int dump_percpu_data(struct bpf_iter__bpf_map_elem *ctx)
+{
+	void *pptr = ctx->value;
+	int i;
+
+	if (!pptr)
+		return 0;
+
+	run_iter = true;
+
+	for (i = 0; i < num_cpus; i++) {
+		percpu_data_sum += *(int *) (pptr + offsetof_num);
+		pptr += elem_sz;
+	}
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.54.0

