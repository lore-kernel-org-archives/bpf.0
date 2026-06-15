Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A9B403E96
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537348; cv=none; b=qU3icUSwJ7fhQNfMuO3BZ6gCEymUDVI0Ars3tAtpUzTjx1dHtPeLRY8dh00doFfbENZMxMOrNsvqq1GhzLV6Zt4+EaiGLvT5DNu1eIGk+x2eVolE4XDNbucX7CRgROhmv/iSvniDG3qs/jk/bqG7jlT4D3puY3PeC4UcPd4csrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537348; c=relaxed/simple;
	bh=MjmKna4cRwr68ZopsL4cQSU35eG9YmoIqOsYL0OmCiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHk7qRNH/M2+BOIOX9QYL9xTOE8UFgzayoR/w8yT0xJ2M+q5zb9G/gPeJgmwpdg27k+YlMECZzT3VefSC0mpyFWunCAbcEVnhXhm/GUa8vfqGzHRqJFJo4/bqagJifYcR5TOUo9Ayv2NvoLU5fqlAxfz7TvzchyZLx2x0iMN6uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RgwFyeQz; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RgwFyeQz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781537344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hj64heSBBnXd1MwM6JSlU7H3nc37cycujFFa4hzuBWE=;
	b=RgwFyeQz0591lJyheLU5vMwkN8U5fozc9ftY2dSW55f60EHZRAA5m2IVCg+MH+IG56EXp6
	HoQFfU+emB2zfChk4rz9hJ1oMWfwS9wdTaeRvaQ/WbI06E3wljJH8yvjl94AbgKj7sWe4o
	UHM3gtClh6raE0ZxF0DK1tgzyd0IMEA=
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
Subject: [PATCH bpf-next v6 12/12] selftests/bpf: Add test to verify bpf_iter for global percpu data
Date: Mon, 15 Jun 2026 23:26:46 +0800
Message-ID: <20260615152646.27639-13-leon.hwang@linux.dev>
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

Add a test to verify that it is OK to iter the percpu_array map used for
global percpu data.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../bpf/prog_tests/global_data_init.c         | 52 +++++++++++++++++++
 .../bpf/progs/test_global_percpu_data.c       | 25 +++++++++
 2 files changed, 77 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
index fcc2c4ec8644..635084d057c2 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
@@ -364,6 +364,56 @@ static void test_global_percpu_data_xlated(void)
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
@@ -380,4 +430,6 @@ void test_global_percpu_data(void)
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

