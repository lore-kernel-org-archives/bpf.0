Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F904AF691
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 20:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368794; cv=none; b=ozNuycV2vu3ApxKnJ/fQPhu+vWKmtpedKakUEFBwdKwop0ZfyBcl0vElGVTQ0J6KKtPKfpCtkHdbd1t7TicGGk4eAGrSFc3F5Jkwin1cr/dy/JOrT1Djrkx8A6AObqnC4FrZuMDrqrQkSk3pnCSrs3YdJqfrzOaxcqKOjv+ShTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368794; c=relaxed/simple;
	bh=9F87oM7BbfsHqmFs37dzNvNMJDdgdtKw+E6HbmCZtlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIWs2bN7bpv7p2kJilBdi9bOE9ZsfCSlnwFsi+1D66plEfn7NDY6s++iFQ9OycWEAQM2m5OxInR9hSJmr2AxOp7Osv8SUJnqnYWevfo/WXJ8QYnlmPS8lNeABT5m4O+BzQb8+HrZP5Sm26jnkxw3Qbl9Co6TXUFAGuVChIWoJKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Ol8icjgQ; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Ol8icjgQ"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d91ede8035so11883355ad.3
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 13:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790368792; x=1790973592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q+Ns2x+z7vlgfAk1Rkohb7w8QqDjYf0bSI4fAoCUwe4=;
        b=Ol8icjgQZfnABMfRcuKDpbUv2wHpGbk8dqAqZj7hYNcnvHp6Xs+h+RpIwFMrDyphxl
         Vc19MAldpqkzr76z/q8S6OLeVEnTywOdnk2aAtMPk3lWG3KMqiBOCYnYVRp+FJJPM5ny
         H+hdJL8StFlp0M8+rc/NzJf3TMGYh2prgb+FPaW8rU568JeN70L/Y+7PDkk0xQkZTsXm
         JVt7Pzsh9wbTJE65C+d4EMnudBSuSie/sF88yvK60Uqyx6pZb8BVDE25we+LnnIASN3p
         JBRswuDZgeA1A4s34VjIfv0Ie9kYyJdYly6x68s9Rgm5on/5c26wxfauma4nGMM1Iwa3
         6aCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790368792; x=1790973592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q+Ns2x+z7vlgfAk1Rkohb7w8QqDjYf0bSI4fAoCUwe4=;
        b=kpbsf7ZEs0XsekCS/8Uk2R0/aQzDUYLXuGGfLL494GyO8fWCtSaGuBLYq6E6qTG8MB
         zbjuLJfUK5Z+dhM0dvcsV1NIOH8iZ26S2VvS5U7N1vL8VYfDf0OZFoS70t3ZFIPabBCi
         CNmmWzR3qLEwvux/wCRiW/SVWl/QSAHqjhv7haYAu/HbW5u2lcflVxQxSUN1a0DrnMJF
         Z4GxE0bybDiuBeY789g74jaQT2tw2HlK7z2RADHxD0H2fFO5szfKBqkvThLEMTPEx+Lq
         TxrFyk9pBPbwgt/AIWEZ1R2tUZuQi+djzl1G4/61ymX+78D4abNwWSDlteedZpH5bhxX
         XDBg==
X-Gm-Message-State: AFuF++kVZmhBxHYNeFHHIgzv3ZnlqX8wTwVTgyZFSs4PQr7yqFFUIHn9
	L7Gf49k6OQPf7BTUiInvNwRuxmnoI7/MkL87vIacuTGszf/bKh1vVmXVHeNXSoA4IuWTVyQy7X7
	nRxpb2qA=
X-Gm-Gg: AYBFou2kFZTQ7nPrJYBMbNhL3gGN4C18btUGww+YDoJ342C/DekuuwbkirUdgczxK7u
	QYuENzSj5T7tjAPTiaVfcdgQEXufh3l3VRnCap/ufAXMNhFRLRgW2MgqoDSnTuNtTwpm/cx5Qwl
	Vt4JvUMyn7CXnTud1Y+QG1Tc8Sq1XYWlEqA8Ch+XmDttR2lVFzvFnQctVZohEz6druf5aHtDyEZ
	a7tvqzM8XMpLxIBgHvTOvPUGJupVU9Fg+UtFgxh6/sL35/o/obY+lolHlziTMAm0DTFS9y4VLsc
	Cai34KE3/XOBVQLcFATl0z8x6vzoXIW4uUJWPsVsgjuF/y2WrbCBgqiBlrex/V9pzDKamgK2fpK
	jpfS/kShepgOAL64DVgdik1jV1Yhr9tDSxYj4s0QmNVomK1dmPjUtTBADLr6IoKRN2C2Z5fnIck
	NJHehmX4988rCCg0icU55QWsmkpkaizjKv4atM9JTn+jwSdjYcSpH2w6DNx1aZKMBzKNeaUiGWG
	3lJbL5ftrMKedNnmaMCb5JcVMJBMtkgK8+OmWtnpg==
X-Received: by 2002:a17:90a:e7d0:b0:39e:6a80:b796 with SMTP id 98e67ed59e1d1-3a0bb60e399mr2824406a91.38.1790368791801;
        Fri, 25 Sep 2026 13:39:51 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9481e17sm5955125a91.8.2026.09.25.13.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 13:39:51 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v3 7/7] selftests/bpf: Test per-call site function specialization
Date: Fri, 25 Sep 2026 20:39:39 +0000
Message-ID: <20260925203939.4105-8-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925203939.4105-1-emil@etsalapatis.com>
References: <20260925203939.4105-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test to ensure function call specialization is
done per-call site. Use bpf_dynptr_from_file that has
observably different behavior between its sleepable and
nonsleepable versions. The sleepable path fails in the
sleepable __kernel_read() call with -EIO, while the
nonsleepable fails in the page-cache lookup path with
-EFAULT. Test that whatever the order the nonsleepable
and sleepable calls are made in the program, both
call sites use the correct specialized kfunc.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/bpf/prog_tests/file_reader.c    |  15 ++
 .../testing/selftests/bpf/progs/file_reader.c | 129 ++++++++++++++++++
 2 files changed, 144 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/file_reader.c b/tools/testing/selftests/bpf/prog_tests/file_reader.c
index 48aae7ea0e4b..e59c6c87e9d5 100644
--- a/tools/testing/selftests/bpf/prog_tests/file_reader.c
+++ b/tools/testing/selftests/bpf/prog_tests/file_reader.c
@@ -7,10 +7,12 @@
 #include "file_reader_fail.skel.h"
 #include <dlfcn.h>
 #include <sys/mman.h>
+#include <sys/stat.h>
 
 const char *user_ptr = "hello world";
 char file_contents[256000];
 void *addr;
+__u64 beyond_eof_offset;
 
 void *get_executable_base_addr(void)
 {
@@ -26,12 +28,18 @@ void *get_executable_base_addr(void)
 
 static int initialize_file_contents(void)
 {
+	struct stat st;
 	int fd, page_sz = sysconf(_SC_PAGESIZE);
 	ssize_t n = 0, cur;
 
 	fd = open("/proc/self/exe", O_RDONLY);
 	if (!ASSERT_OK_FD(fd, "Open /proc/self/exe\n"))
 		return 1;
+	if (!ASSERT_OK(fstat(fd, &st), "fstat /proc/self/exe")) {
+		close(fd);
+		return 1;
+	}
+	beyond_eof_offset = st.st_size + (1ULL << 30);
 
 	do {
 		cur = read(fd, file_contents + n, sizeof(file_contents) - n);
@@ -75,6 +83,7 @@ static void run_test(const char *prog_name)
 
 	memcpy(skel->bss->user_buf, file_contents, sizeof(file_contents));
 	skel->bss->pid = getpid();
+	skel->bss->beyond_eof_offset = beyond_eof_offset;
 
 	err = file_reader__load(skel);
 	if (!ASSERT_OK(err, "file_reader__load"))
@@ -110,6 +119,12 @@ void test_file_reader(void)
 	if (test__start_subtest("on_open_validate_file_read"))
 		run_test("on_open_validate_file_read");
 
+	if (test__start_subtest("on_open_non_sleepable_first"))
+		run_test("on_open_non_sleepable_first");
+
+	if (test__start_subtest("on_open_sleepable_first"))
+		run_test("on_open_sleepable_first");
+
 	if (test__start_subtest("negative"))
 		RUN_TESTS(file_reader_fail);
 }
diff --git a/tools/testing/selftests/bpf/progs/file_reader.c b/tools/testing/selftests/bpf/progs/file_reader.c
index aa2c05cce2b3..8b972fd26d73 100644
--- a/tools/testing/selftests/bpf/progs/file_reader.c
+++ b/tools/testing/selftests/bpf/progs/file_reader.c
@@ -27,9 +27,14 @@ char tmp_buf[256000];
 
 int pid = 0;
 int err, run_success = 0;
+__u64 beyond_eof_offset;
 
 static int validate_file_read(struct file *file);
 static int task_work_callback(struct bpf_map *map, void *key, void *value);
+static int sleepable_second_callback(struct bpf_map *map, void *key, void *value);
+
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
 
 SEC("lsm/file_open")
 int on_open_expect_fault(void *c)
@@ -81,6 +86,101 @@ int on_open_validate_file_read(void *c)
 	return 0;
 }
 
+/*
+ * Exercise bpf_dynptr_from_file() first from a non-sleepable LSM program and
+ * then from its sleepable task-work callback. Reading beyond EOF makes the two
+ * backing implementations return different errors.
+ */
+SEC("lsm/file_open")
+int on_open_non_sleepable_first(void *c)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct bpf_dynptr dynptr;
+	struct elem *work;
+	struct file *file;
+	int key = 0;
+	int ret;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	file = bpf_get_task_exe_file(task);
+	if (!file) {
+		err = 1;
+		return 0;
+	}
+
+	/* The non-sleepable reader cannot fault in an uncached folio. */
+	ret = bpf_dynptr_from_file(file, 0, &dynptr);
+	if (!ret)
+		ret = bpf_dynptr_read(tmp_buf, 1, &dynptr, beyond_eof_offset, 0);
+	bpf_dynptr_file_discard(&dynptr);
+	bpf_put_file(file);
+	if (ret != -EFAULT) {
+		err = 2;
+		return 0;
+	}
+
+	work = bpf_map_lookup_elem(&arrmap, &key);
+	if (!work) {
+		err = 3;
+		return 0;
+	}
+
+	ret = bpf_task_work_schedule_signal(task, &work->tw, &arrmap,
+					    sleepable_second_callback);
+	if (ret)
+		err = 4;
+	return 0;
+}
+
+/*
+ * Exercise the opposite fixup order: the first call is made from a sleepable
+ * LSM program, while the RCU read-side section makes the second non-sleepable.
+ */
+SEC("lsm.s/file_open")
+int on_open_sleepable_first(void *c)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct bpf_dynptr dynptr;
+	struct file *file;
+	int ret;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	file = bpf_get_task_exe_file(task);
+	if (!file) {
+		err = 7;
+		return 0;
+	}
+
+	ret = bpf_dynptr_from_file(file, 0, &dynptr);
+	if (!ret)
+		ret = bpf_dynptr_read(tmp_buf, 1, &dynptr, beyond_eof_offset, 0);
+	bpf_dynptr_file_discard(&dynptr);
+	if (ret != -EIO) {
+		err = 8;
+		goto out;
+	}
+
+	bpf_rcu_read_lock();
+	ret = bpf_dynptr_from_file(file, 0, &dynptr);
+	bpf_rcu_read_unlock();
+	if (!ret)
+		ret = bpf_dynptr_read(tmp_buf, 1, &dynptr, beyond_eof_offset, 0);
+	bpf_dynptr_file_discard(&dynptr);
+	if (ret != -EFAULT) {
+		err = 9;
+		goto out;
+	}
+
+	run_success = 1;
+out:
+	bpf_put_file(file);
+	return 0;
+}
+
 /* Called in a sleepable context, read 256K bytes, cross check with user space read data */
 static int task_work_callback(struct bpf_map *map, void *key, void *value)
 {
@@ -97,6 +197,35 @@ static int task_work_callback(struct bpf_map *map, void *key, void *value)
 	return 0;
 }
 
+/* Task-work callbacks are verified as sleepable. */
+static int sleepable_second_callback(struct bpf_map *map, void *key, void *value)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct bpf_dynptr dynptr;
+	struct file *file;
+	int ret;
+
+	file = bpf_get_task_exe_file(task);
+	if (!file) {
+		err = 5;
+		return 0;
+	}
+
+	/* freader_fetch() converts __kernel_read()'s short read at EOF to -EIO. */
+	ret = bpf_dynptr_from_file(file, 0, &dynptr);
+	if (!ret)
+		ret = bpf_dynptr_read(tmp_buf, 1, &dynptr, beyond_eof_offset, 0);
+	bpf_dynptr_file_discard(&dynptr);
+	bpf_put_file(file);
+	if (ret != -EIO) {
+		err = 6;
+		return 0;
+	}
+
+	run_success = 1;
+	return 0;
+}
+
 static int verify_dynptr_read(struct bpf_dynptr *ptr, u32 off, char *user_buf, u32 len)
 {
 	int i;
-- 
2.52.0

