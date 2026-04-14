Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7817F3E6DDA
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173163; cv=none; b=JlLEpnE32nfXrOUZDSUp3yVJuQ6pXFyM0DlyPqwF9uDD0pjoPOfIydg0vRhv0S71ZNVZyJm1OPczlOiv36BHlSlei2YKLRWe2595jqaZRXilR9hTwI5jgKWKRHP8l4uhwScwkWIVTmkQq6LOCdHodXGqmVoUoCscvM3rKQn4dV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173163; c=relaxed/simple;
	bh=zSQdD2Q0MsdiSayYIbFrHXBJOq4ODP5pBF6xVJ9Z+rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeZcH9xHvrQDxtrhKTThZup1tvKcb7TjCOVtfJ9BmoTQOw3/gfVVDe67RnQowoXXwiP+WkD43C9TPvIeQ73RGBNqtvZiqnpdi027ziupw7AvWLwV2BVok9rnbdHNmwFBa6USeIg7xcYo2MekM0+Sy5jweP4CQZAjOtEl4Gwoy00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QkGhQ7Ov; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QkGhQ7Ov"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776173160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SLsBEILRFj2uxpy0K8iic1oVr+hSITfXzsUFYSG7iJk=;
	b=QkGhQ7Ovf1X3ZPSHr91p0lFuorOSL4dJtDHvSdPLMxTHCYpvuCkPlAc+hegAa7HQY6Y3OR
	vuSz/+gAJTy5QWsZbONAteFjfzy+bVKPD9KuB705zRjOqzjIl0tye91ULw7Otrmb+gjiof
	gW4azHU87z23lc2uywnpBMHXIdf6vyQ=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	qmo@kernel.org,
	dxu@dxuuu.xyz,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v4 8/8] selftests/bpf: Add a test to verify bpf_iter for global percpu data
Date: Tue, 14 Apr 2026 21:24:20 +0800
Message-ID: <20260414132421.63409-9-leon.hwang@linux.dev>
In-Reply-To: <20260414132421.63409-1-leon.hwang@linux.dev>
References: <20260414132421.63409-1-leon.hwang@linux.dev>
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
 .../bpf/prog_tests/global_data_init.c         | 53 +++++++++++++++++++
 .../bpf/progs/test_global_percpu_data.c       | 36 +++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
index 0b0384b6515e..9ff09ff1981c 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
@@ -269,6 +269,57 @@ static void test_global_percpu_data_verifier_failure(void)
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
+	skel->percpu->struct_data.nums[6] = 0xc0de;
+
+	err = test_global_percpu_data__load(skel);
+	if (err == -EOPNOTSUPP) {
+		test__skip();
+		goto out;
+	}
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
@@ -282,4 +333,6 @@ void test_global_percpu_data(void)
 		test_global_percpu_data_lskel();
 	if (test__start_subtest("verifier_failure"))
 		test_global_percpu_data_verifier_failure();
+	if (test__start_subtest("iter"))
+		test_global_percpu_data_iter();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
index 947721c21f30..0ddb820509eb 100644
--- a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
+++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
@@ -63,4 +63,40 @@ int verifier_percpu_read(void *ctx)
 	return c == 'd';
 }
 
+volatile const __u32 num_cpus = 0;
+__u32 percpu_data_sum = 0;
+bool run_iter = false;
+
+SEC("iter/bpf_map_elem")
+__auxiliary
+int dump_percpu_data(struct bpf_iter__bpf_map_elem *ctx)
+{
+	struct {
+		int data;
+		char run;
+		struct {
+			char set;
+			int i;
+			int nums[7];
+		} struct_data;
+		int nums[7];
+	} *pptr = ctx->value;
+	__u32 step;
+	int i;
+
+	if (!pptr)
+		return 0;
+
+	run_iter = true;
+
+	/* percpu array element size is aligned to 8 */
+	step = (sizeof(*pptr) + 7) & ~7;
+
+	for (i = 0; i < num_cpus; i++) {
+		percpu_data_sum += pptr->struct_data.nums[6];
+		pptr = (void *)pptr + step;
+	}
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

