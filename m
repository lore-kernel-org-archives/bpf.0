Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE39A3624CF;
	Thu,  6 Aug 2026 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786034006; cv=none; b=WLTZ9KZj7vpez+kZabS2uupBNXQaq4RZQ3riOR+fPonEr3hAFCPS4muXjMisBx7HMload2OXGSPuA+Enx/15iB7jcPKZ9KSsOLnjMpm0enP02ut07n3R7/q4Msivv/XR+O9ebZaG3uGPHzpr/A3kXc0OZbJqBuu/eTuXcKj64cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786034006; c=relaxed/simple;
	bh=i3uyX6cbzovaPp4w1Qii84/2UaXmZJk5Df4imXwwFfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8zyKvjfZO5Y+yoQpXFu/HDhICihY6cO9uIjKA2pv2wkWIt5h1xcsbb9ac/RZomlhe4aQyh0JU+FrNiTIUcaARTY6AxvGcbssft/Mln/eWQgajq5+pr7yu8RtNeBlmEmRlaRAEUjjG3zJQBJZ4CoNbSKBXGh+UupXLMPXJCqt8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wjRVuh0d; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wjRVuh0d"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786034002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=01/KKGQN1pRCjT8ifmm+BwGyoJjIbb2a0e5ACArQx18=;
	b=wjRVuh0dNNFe9EHN9BZaHH1VkIXC3mpNW/GFD0SNyM2VsOzHStpZ81InBG8Xk0vCxYIHFy
	wgeRMRw1xlKA+AEK3+shYkEVo4kOZ7y3TEejL+zTsib0RTrLeaoEDRUDvQEX2r+Xog0QPO
	uQUws5w0AfVYAhwKwbUDSSBizMRAgR0=
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
Subject: [PATCH bpf-next v11 10/10] selftests/bpf: Verify bpf_iter for global percpu data
Date: Fri,  7 Aug 2026 00:31:25 +0800
Message-ID: <20260806163125.11172-11-leon.hwang@linux.dev>
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

Add a test to verify that it is OK to iter the percpu_array map used for
global percpu data.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../bpf/prog_tests/global_data_init.c         | 52 +++++++++++++++++++
 .../bpf/progs/test_global_percpu_data.c       | 25 +++++++++
 2 files changed, 77 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
index 91f6ec07ba85..2625651b34c7 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
@@ -301,6 +301,56 @@ static void test_global_percpu_data_verifier_log(void)
 	RUN_TESTS(test_global_percpu_data);
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
@@ -317,4 +367,6 @@ void test_global_percpu_data(void)
 	if (test__start_subtest("rdonly_direct_write"))
 		test_global_percpu_data_rdonly_direct_write();
 	test_global_percpu_data_verifier_log();
+	if (test__start_subtest("iter"))
+		test_global_percpu_data_iter();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
index 202cb9e8375b..a9443fb2050e 100644
--- a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
+++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
@@ -60,4 +60,29 @@ int verifier_snprintf(void *ctx)
 	return 0;
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
2.55.0

