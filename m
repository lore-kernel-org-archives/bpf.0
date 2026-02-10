Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CFA13FEE
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770727263; cv=none; b=bSWNGIM2ia5cdbUNiiX1BMCaUTvRoPo8rawipR6EX7qhn9dEuIIh03S6fArc4Klc4LrUuQjd7DWofJ4owEeP+FdsZnGuBF+41132Fv7lyeoZ4XXhs2kn+m8kqPJTmhX0LgZEM/fpVLaSCreG0P1FDArjFubO71Hzk0leYYumyfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770727263; c=relaxed/simple;
	bh=8m1aiw5dCT/9dAF118a6EdpmqjqR8uTXgFQOzDTRhvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCawezez+iSizIabLPUziUpY+H5ke8YOKuYjFdhDhdQH9iQLq3iUggaSxoQd/VurmXfWdBVMLkbyanSm+mULcfnpoLSRSpPpZdeJAW9PzaDNEQjNY2dudoIpJ4sN/FU2GCCyqeE7BWCcln8YLYnXVWDbtf21V53rhEUffa9Aemg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MjEA/64R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MjEA/64R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770727261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j0uC/hm9dDbYXMMtVNqNCVOpE/wxnFHX64qAFNKfT1g=;
	b=MjEA/64R4ZjvKisi0X5qfHcR2hQnFuEj3tPVJqWV0Q/YCc/m7FL6ubVrs9Nc3ovKk2I9Fh
	e3nRSnK1he4129TBRKdMjm7CobHC3Wu17Be/xcWwhZbEGmvn9c6Y7UV3csL+Z/L+Y+cOK2
	4hghxsNFZWqnfM1PiOl7lZTcFKpF9ts=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-AcHTzYkDPUav6ZSoMIGkqA-1; Tue,
 10 Feb 2026 07:40:57 -0500
X-MC-Unique: AcHTzYkDPUav6ZSoMIGkqA-1
X-Mimecast-MFC-AGG-ID: AcHTzYkDPUav6ZSoMIGkqA_1770727255
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CA3C195609F;
	Tue, 10 Feb 2026 12:40:55 +0000 (UTC)
Received: from vmalik-fedora.brq.redhat.com (unknown [10.43.17.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F0B41800674;
	Tue, 10 Feb 2026 12:40:50 +0000 (UTC)
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
	Viktor Malik <vmalik@redhat.com>,
	Jordan Rome <linux@jordanrome.com>,
	Qais Yousef <qyousef@layalina.io>,
	Hou Tao <houtao1@huawei.com>
Subject: [PATCH bpf-next 2/3] selftests/bpf: Split read_vsyscall into subtests
Date: Tue, 10 Feb 2026 13:40:33 +0100
Message-ID: <05e00d8a6ffd7a18f3bbd5d4268aead29ff8ab04.1770723724.git.vmalik@redhat.com>
In-Reply-To: <cover.1770723724.git.vmalik@redhat.com>
References: <cover.1770723724.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Split the test into two subtests: one for checking bpf_probe_read* of a
vsyscall page from a non-sleepable probe and one for checking
bpf_copy_from_user* of a vsyscall page from a sleepable probe.

The split is useful for running the test on kernels which do not support
sleepable fentry programs to allow skipping just a part of the test.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 .../selftests/bpf/prog_tests/read_vsyscall.c  | 41 ++++++++++++++++---
 .../selftests/bpf/progs/read_vsyscall.c       |  8 ++--
 2 files changed, 39 insertions(+), 10 deletions(-)

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
index 395591374d4f..2a3e5325b7d8 100644
--- a/tools/testing/selftests/bpf/progs/read_vsyscall.c
+++ b/tools/testing/selftests/bpf/progs/read_vsyscall.c
@@ -19,8 +19,8 @@ int bpf_copy_from_user_str(void *dst, u32, const void *, u64) __weak __ksym;
 int bpf_copy_from_user_task_str(void *dst, u32, const void *,
 				struct task_struct *, u64) __weak __ksym;
 
-SEC("fentry/" SYS_PREFIX "sys_nanosleep")
-int do_probe_read(void *ctx)
+SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
+int probe_read(void *ctx)
 {
 	char buf[8];
 
@@ -37,8 +37,8 @@ int do_probe_read(void *ctx)
 	return 0;
 }
 
-SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
-int do_copy_from_user(void *ctx)
+SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
+int copy_from_user(void *ctx)
 {
 	char buf[8];
 
-- 
2.53.0

