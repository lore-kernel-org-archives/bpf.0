Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3FE366DD6
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770732904; cv=none; b=PF10Y08rHFGEIuPKeSrwkKVf/rvYV1ftBCasDI9A//etoOeg8jLNiFUvRcnB50LxR9Jq2COZYWOZEDrIgN3rixc7yeFbOY4Sc7JFw9HMmGZyS0l707B2pgEzHSSSerivehy0sRaqG5O2pR1HqIW9Xvr1ixmCbJcNihmv+DTGN8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770732904; c=relaxed/simple;
	bh=IXQCtH77xqgqV71ExLvn9G3KmhQp0sGPRerk1As0scU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7Bdp1hkwWS5IumzK82eGhH3HMzKKImYSDsN1SiSPl8rC2I7gcqUaWdQYDDiW83VzZPXepi2UH3j82/Qyso5em4t4jT2KKnKzNmozGwe3fMvQDA/GFOm7n/kyHeyvSha4WLjTQJ63LMNtzzL/lUNcIgTqIQslL7xIuz+eF01exc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bvryyJ7G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvryyJ7G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770732902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5EUjYgRCDV9akhtoLZZIv5Ew5TbxgrPsIFTsS879+bQ=;
	b=bvryyJ7GkqzaXrO5b5R+uUBC1QJSwisD8F3bwSkqgjc4+l/DNvwKL8VD6nAYcxujoofZk/
	FWyDH9qBOaQvrULpWkRxP6OYw1DMWnO8Lz5IUJtV0g8rAnngkCOQ6lUzT4j58odryEo+Jw
	017qRKjY2n+TDxtztqlRZ5yjLhqRXFk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-NPSc0weLOuOpTx4dM4rssw-1; Tue,
 10 Feb 2026 09:14:57 -0500
X-MC-Unique: NPSc0weLOuOpTx4dM4rssw-1
X-Mimecast-MFC-AGG-ID: NPSc0weLOuOpTx4dM4rssw_1770732894
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A43819560A1;
	Tue, 10 Feb 2026 14:14:53 +0000 (UTC)
Received: from vmalik-fedora.brq.redhat.com (unknown [10.43.17.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E0FC30001A5;
	Tue, 10 Feb 2026 14:14:49 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jordan Rome <linux@jordanrome.com>,
	Viktor Malik <vmalik@redhat.com>,
	Qais Yousef <qyousef@layalina.io>,
	Hou Tao <houtao1@huawei.com>
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: Split read_vsyscall into subtests
Date: Tue, 10 Feb 2026 15:14:31 +0100
Message-ID: <0a86acb424f640367792c9d30d2023d6c51a13e7.1770732776.git.vmalik@redhat.com>
In-Reply-To: <cover.1770732776.git.vmalik@redhat.com>
References: <cover.1770732776.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Split the test into two subtests: one for checking bpf_probe_read* of a
vsyscall page from a non-sleepable probe and one for checking
bpf_copy_from_user* of a vsyscall page from a sleepable probe.

The split is useful for running the test on kernels which do not support
sleepable fentry programs to allow skipping just a part of the test.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 .../selftests/bpf/prog_tests/read_vsyscall.c  | 41 ++++++++++++++++---
 .../selftests/bpf/progs/read_vsyscall.c       | 18 ++++----
 2 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c b/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
index a8d1eaa67020..bbacd1309046 100644
--- a/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
@@ -14,22 +14,30 @@
 struct read_ret_desc {
 	const char *name;
 	int ret;
-} all_read[] = {
+};
+
+struct read_ret_desc all_probe_read[] = {
 	{ .name = "probe_read_kernel", .ret = -ERANGE },
 	{ .name = "probe_read_kernel_str", .ret = -ERANGE },
 	{ .name = "probe_read", .ret = -ERANGE },
 	{ .name = "probe_read_str", .ret = -ERANGE },
 	{ .name = "probe_read_user", .ret = -EFAULT },
 	{ .name = "probe_read_user_str", .ret = -EFAULT },
+};
+
+struct read_ret_desc all_copy_from_user[] = {
 	{ .name = "copy_from_user", .ret = -EFAULT },
 	{ .name = "copy_from_user_task", .ret = -EFAULT },
 	{ .name = "copy_from_user_str", .ret = -EFAULT },
 	{ .name = "copy_from_user_task_str", .ret = -EFAULT },
 };
 
-void test_read_vsyscall(void)
+static void test_read_vsyscall_subtest(const char *prog_name,
+				       const struct read_ret_desc *descs,
+				       unsigned int cnt)
 {
 	struct read_vsyscall *skel;
+	struct bpf_program *prog;
 	unsigned int i;
 	int err;
 
@@ -37,10 +45,19 @@ void test_read_vsyscall(void)
 	test__skip();
 	return;
 #endif
-	skel = read_vsyscall__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "read_vsyscall open_load"))
+	skel = read_vsyscall__open();
+	if (!ASSERT_OK_PTR(skel, "read_vsyscall open"))
 		return;
 
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "read_vsyscall find program"))
+		goto out;
+	bpf_program__set_autoload(prog, true);
+
+	err = read_vsyscall__load(skel);
+	if (!ASSERT_EQ(err, 0, "read_vsyscall load"))
+		goto out;
+
 	skel->bss->target_pid = getpid();
 	err = read_vsyscall__attach(skel);
 	if (!ASSERT_EQ(err, 0, "read_vsyscall attach"))
@@ -52,8 +69,20 @@ void test_read_vsyscall(void)
 	skel->bss->user_ptr = (void *)VSYSCALL_ADDR;
 	usleep(1);
 
-	for (i = 0; i < ARRAY_SIZE(all_read); i++)
-		ASSERT_EQ(skel->bss->read_ret[i], all_read[i].ret, all_read[i].name);
+	for (i = 0; i < cnt; i++)
+		ASSERT_EQ(skel->bss->read_ret[i], descs[i].ret, descs[i].name);
 out:
 	read_vsyscall__destroy(skel);
 }
+
+void test_read_vsyscall(void)
+{
+	if (test__start_subtest("probe_read")) {
+		test_read_vsyscall_subtest("probe_read", all_probe_read,
+					   ARRAY_SIZE(all_probe_read));
+	}
+	if (test__start_subtest("copy_from_user")) {
+		test_read_vsyscall_subtest("copy_from_user", all_copy_from_user,
+					   ARRAY_SIZE(all_copy_from_user));
+	}
+}
diff --git a/tools/testing/selftests/bpf/progs/read_vsyscall.c b/tools/testing/selftests/bpf/progs/read_vsyscall.c
index 395591374d4f..45bcf923ec70 100644
--- a/tools/testing/selftests/bpf/progs/read_vsyscall.c
+++ b/tools/testing/selftests/bpf/progs/read_vsyscall.c
@@ -8,7 +8,7 @@
 
 int target_pid = 0;
 void *user_ptr = 0;
-int read_ret[10];
+int read_ret[6];
 
 char _license[] SEC("license") = "GPL";
 
@@ -19,8 +19,8 @@ int bpf_copy_from_user_str(void *dst, u32, const void *, u64) __weak __ksym;
 int bpf_copy_from_user_task_str(void *dst, u32, const void *,
 				struct task_struct *, u64) __weak __ksym;
 
-SEC("fentry/" SYS_PREFIX "sys_nanosleep")
-int do_probe_read(void *ctx)
+SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
+int probe_read(void *ctx)
 {
 	char buf[8];
 
@@ -37,19 +37,19 @@ int do_probe_read(void *ctx)
 	return 0;
 }
 
-SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
-int do_copy_from_user(void *ctx)
+SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
+int copy_from_user(void *ctx)
 {
 	char buf[8];
 
 	if ((bpf_get_current_pid_tgid() >> 32) != target_pid)
 		return 0;
 
-	read_ret[6] = bpf_copy_from_user(buf, sizeof(buf), user_ptr);
-	read_ret[7] = bpf_copy_from_user_task(buf, sizeof(buf), user_ptr,
+	read_ret[0] = bpf_copy_from_user(buf, sizeof(buf), user_ptr);
+	read_ret[1] = bpf_copy_from_user_task(buf, sizeof(buf), user_ptr,
 					      bpf_get_current_task_btf(), 0);
-	read_ret[8] = bpf_copy_from_user_str((char *)buf, sizeof(buf), user_ptr, 0);
-	read_ret[9] = bpf_copy_from_user_task_str((char *)buf,
+	read_ret[2] = bpf_copy_from_user_str((char *)buf, sizeof(buf), user_ptr, 0);
+	read_ret[3] = bpf_copy_from_user_task_str((char *)buf,
 						  sizeof(buf),
 						  user_ptr,
 						  bpf_get_current_task_btf(),
-- 
2.53.0

