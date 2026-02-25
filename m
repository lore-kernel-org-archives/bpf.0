Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4A5393DE4
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772021363; cv=none; b=gkcV1ZH7jvegKL2LyEAtZ///I8SjcOkySwUw7nw+7yd42vQYhmwAhBjCgzFD281kLxYU5XlU1snM+5xUjtWnxUEOSoNAaxzfKBKOWMayzQsUo/xUco+OVKwO2cnrVIuufzemHLzd91ptcTB4oqjst7ALOoUOxoGUpxrXafjYBVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772021363; c=relaxed/simple;
	bh=mLvTN+O3BKF3mbdPLwVYW8s8IkfSwZfkqRXG0ilO5Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jNqFeKufuIE3mLwGDFf3nSxDtqNBqqN3yR4jBfj6nExred5bxUPaUdFnuj13RFMRMvRM53ytYYzQyoKF/UBcksJx88I36/n5aik8URxHaLrS4q5leQv98vm4hzneZq0npi+NA/b04cgI9ql4wy4MmPm1UL+EM3Ob3bU65LmUQjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CeL+AhAJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CeL+AhAJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772021361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4vNSEsUBRZl6jY9gpW6GgeIxs1897El9k4DDbEwV3uE=;
	b=CeL+AhAJl60bosMWjdiNT0m8tMHQbDnpa+v6vZQXcxWWk7c5DrucIq6upJKeE+PWMWZC8z
	qApad68sFJbKrpGozfF0lzN2xQzja5J8fEdciVw741RFivyxscpWymarwo/RtZg4qvbD49
	UGtcBEDdAA44PGVXmRXNIwhvsGTBeZA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-iTzJ0ylxMnilJvFLYSBd1Q-1; Wed,
 25 Feb 2026 07:09:15 -0500
X-MC-Unique: iTzJ0ylxMnilJvFLYSBd1Q-1
X-Mimecast-MFC-AGG-ID: iTzJ0ylxMnilJvFLYSBd1Q_1772021353
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F29071800464;
	Wed, 25 Feb 2026 12:09:12 +0000 (UTC)
Received: from vmalik-fedora.brq.redhat.com (unknown [10.43.17.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4200E3003D89;
	Wed, 25 Feb 2026 12:09:08 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
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
	Viktor Malik <vmalik@redhat.com>,
	Shubham Sharma <slopixelz@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH bpf-next] selftests/bpf: Split module_attach into subtests
Date: Wed, 25 Feb 2026 13:09:04 +0100
Message-ID: <20260225120904.1529112-1-vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The test verifies attachment to various hooks in a kernel module,
however, everything is flattened into a single test. This makes it
impossible to run or skip test cases selectively.

Isolate each BPF program into a separate subtest. This is done by
disabling auto-loading of programs and loading and testing each program
separately.

At the same time, modernize the test to use ASSERT* instead of CHECK and
replace `return` by `goto cleanup` where necessary.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 .../selftests/bpf/prog_tests/module_attach.c  | 171 +++++++++++++-----
 .../selftests/bpf/progs/test_module_attach.c  |  63 +++----
 2 files changed, 148 insertions(+), 86 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/module_attach.c b/tools/testing/selftests/bpf/prog_tests/module_attach.c
index 70fa7ae93173..67763f609b6e 100644
--- a/tools/testing/selftests/bpf/prog_tests/module_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/module_attach.c
@@ -6,7 +6,22 @@
 #include "test_module_attach.skel.h"
 #include "testing_helpers.h"
 
-static int duration;
+static const char * const read_tests[] = {
+	"handle_raw_tp",
+	"handle_tp_btf",
+	"handle_fentry",
+	"handle_fentry_explicit",
+	"handle_fmod_ret",
+};
+
+static const char * const detach_tests[] = {
+	"handle_fentry",
+	"handle_fexit",
+	"kprobe_multi",
+};
+
+static const int READ_SZ = 456;
+static const int WRITE_SZ = 457;
 
 static int trigger_module_test_writable(int *val)
 {
@@ -33,53 +48,73 @@ static int trigger_module_test_writable(int *val)
 	return 0;
 }
 
-void test_module_attach(void)
+static void test_module_attach_prog(const char *prog_name, int sz,
+				    const char *attach_target, int ret)
 {
-	const int READ_SZ = 456;
-	const int WRITE_SZ = 457;
-	struct test_module_attach* skel;
-	struct test_module_attach__bss *bss;
-	struct bpf_link *link;
+	struct test_module_attach *skel;
+	struct bpf_program *prog;
 	int err;
-	int writable_val = 0;
 
 	skel = test_module_attach__open();
-	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
+	if (!ASSERT_OK_PTR(skel, "module_attach open"))
 		return;
 
-	err = bpf_program__set_attach_target(skel->progs.handle_fentry_manual,
-					     0, "bpf_testmod_test_read");
-	ASSERT_OK(err, "set_attach_target");
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "module_attach find_program"))
+		goto cleanup;
+	bpf_program__set_autoload(prog, true);
 
-	err = bpf_program__set_attach_target(skel->progs.handle_fentry_explicit_manual,
-					     0, "bpf_testmod:bpf_testmod_test_read");
-	ASSERT_OK(err, "set_attach_target_explicit");
+	if (attach_target) {
+		err = bpf_program__set_attach_target(prog, 0, attach_target);
+		if (!ASSERT_OK(err, attach_target))
+			goto cleanup;
+	}
 
 	err = test_module_attach__load(skel);
-	if (CHECK(err, "skel_load", "failed to load skeleton\n"))
+	if (!ASSERT_OK(err, "module_attach load"))
+		goto cleanup;
+
+	err = test_module_attach__attach(skel);
+	if (!ASSERT_OK(err, "module_attach attach"))
+		goto cleanup;
+
+	if (sz) {
+		/* trigger both read and write though each test uses only one */
+		ASSERT_OK(trigger_module_test_read(sz), "trigger_read");
+		ASSERT_OK(trigger_module_test_write(sz), "trigger_write");
+
+		ASSERT_EQ(skel->bss->sz, sz, prog_name);
+	}
+
+	if (ret)
+		ASSERT_EQ(skel->bss->retval, ret, "ret");
+cleanup:
+	test_module_attach__destroy(skel);
+}
+
+static void test_module_attach_writable(void)
+{
+	struct test_module_attach__bss *bss;
+	struct test_module_attach *skel;
+	int writable_val = 0;
+	int err;
+
+	skel = test_module_attach__open();
+	if (!ASSERT_OK_PTR(skel, "module_attach open"))
 		return;
 
+	bpf_program__set_autoload(skel->progs.handle_raw_tp_writable_bare, true);
+
+	err = test_module_attach__load(skel);
+	if (!ASSERT_OK(err, "module_attach load"))
+		goto cleanup;
+
 	bss = skel->bss;
 
 	err = test_module_attach__attach(skel);
-	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
+	if (!ASSERT_OK(err, "module_attach attach"))
 		goto cleanup;
 
-	/* trigger tracepoint */
-	ASSERT_OK(trigger_module_test_read(READ_SZ), "trigger_read");
-	ASSERT_OK(trigger_module_test_write(WRITE_SZ), "trigger_write");
-
-	ASSERT_EQ(bss->raw_tp_read_sz, READ_SZ, "raw_tp");
-	ASSERT_EQ(bss->raw_tp_bare_write_sz, WRITE_SZ, "raw_tp_bare");
-	ASSERT_EQ(bss->tp_btf_read_sz, READ_SZ, "tp_btf");
-	ASSERT_EQ(bss->fentry_read_sz, READ_SZ, "fentry");
-	ASSERT_EQ(bss->fentry_manual_read_sz, READ_SZ, "fentry_manual");
-	ASSERT_EQ(bss->fentry_explicit_read_sz, READ_SZ, "fentry_explicit");
-	ASSERT_EQ(bss->fentry_explicit_manual_read_sz, READ_SZ, "fentry_explicit_manual");
-	ASSERT_EQ(bss->fexit_read_sz, READ_SZ, "fexit");
-	ASSERT_EQ(bss->fexit_ret, -EIO, "fexit_tet");
-	ASSERT_EQ(bss->fmod_ret_read_sz, READ_SZ, "fmod_ret");
-
 	bss->raw_tp_writable_bare_early_ret = true;
 	bss->raw_tp_writable_bare_out_val = 0xf1f2f3f4;
 	ASSERT_OK(trigger_module_test_writable(&writable_val),
@@ -87,31 +122,73 @@ void test_module_attach(void)
 	ASSERT_EQ(bss->raw_tp_writable_bare_in_val, 1024, "writable_test_in");
 	ASSERT_EQ(bss->raw_tp_writable_bare_out_val, writable_val,
 		  "writable_test_out");
+cleanup:
+	test_module_attach__destroy(skel);
+}
 
-	test_module_attach__detach(skel);
-
-	/* attach fentry/fexit and make sure it gets module reference */
-	link = bpf_program__attach(skel->progs.handle_fentry);
-	if (!ASSERT_OK_PTR(link, "attach_fentry"))
-		goto cleanup;
+static void test_module_attach_detach(const char *prog_name)
+{
+	struct test_module_attach *skel;
+	struct bpf_program *prog;
+	struct bpf_link *link;
+	int err;
 
-	ASSERT_ERR(unload_bpf_testmod(false), "unload_bpf_testmod");
-	bpf_link__destroy(link);
+	skel = test_module_attach__open();
+	if (!ASSERT_OK_PTR(skel, "module_attach open"))
+		return;
 
-	link = bpf_program__attach(skel->progs.handle_fexit);
-	if (!ASSERT_OK_PTR(link, "attach_fexit"))
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "module_attach find_program"))
 		goto cleanup;
+	bpf_program__set_autoload(prog, true);
 
-	ASSERT_ERR(unload_bpf_testmod(false), "unload_bpf_testmod");
-	bpf_link__destroy(link);
+	err = test_module_attach__load(skel);
+	if (!ASSERT_OK(err, "module_attach load"))
+		goto cleanup;
 
-	link = bpf_program__attach(skel->progs.kprobe_multi);
-	if (!ASSERT_OK_PTR(link, "attach_kprobe_multi"))
+	/* attach and make sure it gets module reference */
+	link = bpf_program__attach(prog);
+	if (!ASSERT_OK_PTR(link, "module_attach attach"))
 		goto cleanup;
 
 	ASSERT_ERR(unload_bpf_testmod(false), "unload_bpf_testmod");
 	bpf_link__destroy(link);
-
 cleanup:
 	test_module_attach__destroy(skel);
 }
+
+void test_module_attach(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(read_tests); i++) {
+		if (!test__start_subtest(read_tests[i]))
+			continue;
+		test_module_attach_prog(read_tests[i], READ_SZ, NULL, 0);
+	}
+	if (test__start_subtest("handle_raw_tp_bare"))
+		test_module_attach_prog("handle_raw_tp_bare", WRITE_SZ, NULL, 0);
+	if (test__start_subtest("handle_raw_tp_writable_bare"))
+		test_module_attach_writable();
+	if (test__start_subtest("handle_fentry_manual")) {
+		test_module_attach_prog("handle_fentry_manual", READ_SZ,
+					"bpf_testmod_test_read", 0);
+	}
+	if (test__start_subtest("handle_fentry_explicit_manual")) {
+		test_module_attach_prog("handle_fentry_explicit_manual",
+					READ_SZ,
+					"bpf_testmod:bpf_testmod_test_read", 0);
+	}
+	if (test__start_subtest("handle_fexit"))
+		test_module_attach_prog("handle_fexit", READ_SZ, NULL, -EIO);
+	if (test__start_subtest("handle_fexit_ret"))
+		test_module_attach_prog("handle_fexit_ret", 0, NULL, 0);
+	for (i = 0; i < ARRAY_SIZE(detach_tests); i++) {
+		char test_name[50];
+
+		snprintf(test_name, sizeof(test_name), "%s_detach", detach_tests[i]);
+		if (!test__start_subtest(test_name))
+			continue;
+		test_module_attach_detach(detach_tests[i]);
+	}
+}
diff --git a/tools/testing/selftests/bpf/progs/test_module_attach.c b/tools/testing/selftests/bpf/progs/test_module_attach.c
index 03d7f89787a1..5609e388fb58 100644
--- a/tools/testing/selftests/bpf/progs/test_module_attach.c
+++ b/tools/testing/selftests/bpf/progs/test_module_attach.c
@@ -7,23 +7,21 @@
 #include <bpf/bpf_core_read.h>
 #include "../test_kmods/bpf_testmod.h"
 
-__u32 raw_tp_read_sz = 0;
+__u32 sz = 0;
 
-SEC("raw_tp/bpf_testmod_test_read")
+SEC("?raw_tp/bpf_testmod_test_read")
 int BPF_PROG(handle_raw_tp,
 	     struct task_struct *task, struct bpf_testmod_test_read_ctx *read_ctx)
 {
-	raw_tp_read_sz = BPF_CORE_READ(read_ctx, len);
+	sz = BPF_CORE_READ(read_ctx, len);
 	return 0;
 }
 
-__u32 raw_tp_bare_write_sz = 0;
-
-SEC("raw_tp/bpf_testmod_test_write_bare_tp")
+SEC("?raw_tp/bpf_testmod_test_write_bare_tp")
 int BPF_PROG(handle_raw_tp_bare,
 	     struct task_struct *task, struct bpf_testmod_test_write_ctx *write_ctx)
 {
-	raw_tp_bare_write_sz = BPF_CORE_READ(write_ctx, len);
+	sz = BPF_CORE_READ(write_ctx, len);
 	return 0;
 }
 
@@ -31,7 +29,7 @@ int raw_tp_writable_bare_in_val = 0;
 int raw_tp_writable_bare_early_ret = 0;
 int raw_tp_writable_bare_out_val = 0;
 
-SEC("raw_tp.w/bpf_testmod_test_writable_bare_tp")
+SEC("?raw_tp.w/bpf_testmod_test_writable_bare_tp")
 int BPF_PROG(handle_raw_tp_writable_bare,
 	     struct bpf_testmod_test_writable_ctx *writable)
 {
@@ -41,76 +39,65 @@ int BPF_PROG(handle_raw_tp_writable_bare,
 	return 0;
 }
 
-__u32 tp_btf_read_sz = 0;
-
-SEC("tp_btf/bpf_testmod_test_read")
+SEC("?tp_btf/bpf_testmod_test_read")
 int BPF_PROG(handle_tp_btf,
 	     struct task_struct *task, struct bpf_testmod_test_read_ctx *read_ctx)
 {
-	tp_btf_read_sz = read_ctx->len;
+	sz = read_ctx->len;
 	return 0;
 }
 
-__u32 fentry_read_sz = 0;
-
-SEC("fentry/bpf_testmod_test_read")
+SEC("?fentry/bpf_testmod_test_read")
 int BPF_PROG(handle_fentry,
 	     struct file *file, struct kobject *kobj,
 	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
 {
-	fentry_read_sz = len;
+	sz = len;
 	return 0;
 }
 
-__u32 fentry_manual_read_sz = 0;
-
-SEC("fentry")
+SEC("?fentry")
 int BPF_PROG(handle_fentry_manual,
 	     struct file *file, struct kobject *kobj,
 	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
 {
-	fentry_manual_read_sz = len;
+	sz = len;
 	return 0;
 }
 
-__u32 fentry_explicit_read_sz = 0;
-
-SEC("fentry/bpf_testmod:bpf_testmod_test_read")
+SEC("?fentry/bpf_testmod:bpf_testmod_test_read")
 int BPF_PROG(handle_fentry_explicit,
 	     struct file *file, struct kobject *kobj,
 	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
 {
-	fentry_explicit_read_sz = len;
+	sz = len;
 	return 0;
 }
 
 
-__u32 fentry_explicit_manual_read_sz = 0;
-
-SEC("fentry")
+SEC("?fentry")
 int BPF_PROG(handle_fentry_explicit_manual,
 	     struct file *file, struct kobject *kobj,
 	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
 {
-	fentry_explicit_manual_read_sz = len;
+	sz = len;
 	return 0;
 }
 
-__u32 fexit_read_sz = 0;
-int fexit_ret = 0;
+int retval = 0;
 
-SEC("fexit/bpf_testmod_test_read")
+SEC("?fexit/bpf_testmod_test_read")
 int BPF_PROG(handle_fexit,
 	     struct file *file, struct kobject *kobj,
 	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len,
 	     int ret)
 {
-	fexit_read_sz = len;
-	fexit_ret = ret;
+	sz = len;
+	retval = ret;
 	return 0;
 }
 
-SEC("fexit/bpf_testmod_return_ptr")
+SEC("?fexit/bpf_testmod_return_ptr")
 int BPF_PROG(handle_fexit_ret, int arg, struct file *ret)
 {
 	long buf = 0;
@@ -122,18 +109,16 @@ int BPF_PROG(handle_fexit_ret, int arg, struct file *ret)
 	return 0;
 }
 
-__u32 fmod_ret_read_sz = 0;
-
-SEC("fmod_ret/bpf_testmod_test_read")
+SEC("?fmod_ret/bpf_testmod_test_read")
 int BPF_PROG(handle_fmod_ret,
 	     struct file *file, struct kobject *kobj,
 	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
 {
-	fmod_ret_read_sz = len;
+	sz = len;
 	return 0; /* don't override the exit code */
 }
 
-SEC("kprobe.multi/bpf_testmod_test_read")
+SEC("?kprobe.multi/bpf_testmod_test_read")
 int BPF_PROG(kprobe_multi)
 {
 	return 0;
-- 
2.53.0

