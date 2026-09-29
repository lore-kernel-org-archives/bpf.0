Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C71D55198A
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707178; cv=none; b=cbSQQU+Ios0MwMlC1MoNjbH8WWL1OE8na5zg3dE21Qf9IaX017fpQvAgZU+cwxZXr1quEbqgwRB+bwHba6b4UqIaun4bHbsnqgiaoofW3b9PYxMjc4KMzZHeHfnIqu5+juSteQdKFxDXX9sZmTjjKplpfRef4tF7E2PiIG1fwXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707178; c=relaxed/simple;
	bh=9F87oM7BbfsHqmFs37dzNvNMJDdgdtKw+E6HbmCZtlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kSLjZ8x0BQX71oa7T6zphj/frPeWwL/kPDiTG5BXQe40HCovBU+RFfpR7kIqTp+0kQjqlTM2xEqFt4HMP6WlwL9sBKKOvF/59n8Lk9ZPDz075v1Ctn4TpujuQNNBcd9kyDfuMFINtDElu16F3O1H+M7b68GL0F3QCHTptlX4WVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=nUCTilyr; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="nUCTilyr"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0d2c37b0bso1693536a91.0
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 11:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790707176; x=1791311976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q+Ns2x+z7vlgfAk1Rkohb7w8QqDjYf0bSI4fAoCUwe4=;
        b=nUCTilyrTqp3aXpZxBqKP9/vHcW477bamyuvLkpWAfcM3rwH//GI0Fabd0fVcW2+ah
         IStPRvHHFZ4/UpNwr566vyFhs42dWZfejTbOyti/DmBmRI7A0X+5Gdo6+DeY8YMaIoWd
         22k9aBikLaORJan5/grn+1fpvklEqPcLBXQ746sI0UF8NDCdIbEn/y0ptHeAqWo+AR7r
         9TEJ43tzo3NAy0rz2Qs5ae4oI9RMSYSF+Q2mE7GCp4QarIB593wk7wxZyW4ipErzmb9Q
         k26PXqcpn81JawOtDgjCo/9LulrQnMlluaI2YDmoweu5iqFYPYkITd5wWJPuY0oQht3x
         dHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790707176; x=1791311976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q+Ns2x+z7vlgfAk1Rkohb7w8QqDjYf0bSI4fAoCUwe4=;
        b=dADx397Ummm3/G1v90ratJC6IglF3sZAdpZpOvs+Q4V7vXLnyfCyjm5yP2jovaGCsb
         1SxDS9b1lzDYEUJYV9/tgwhmU2Dmslu2kD+2JRQeJkmyu2YRZ3zRRPLeXqs21jA0JynK
         3OI4JT3mCQzhRpcDxvH2CUlz8+XYSsbL6Zpt/p6EB0rOQjLro6HDrHTPzYQ4yYNY0DR1
         VLjebfbLgCWeeVCcoxv+cBhILXfZV1vAD0SPBY+PvWW+HfVpTYl3ubesZPOdAD4aSp0k
         uWrcAg30eF86bX+1nos1IQKVgTrM3ITXZXkoHyRsr0xkZ0/jOZnuzdYCwxJNcCmTQb9V
         DhyA==
X-Gm-Message-State: AFq9FYK8PhL0hq4cUG28REDodoq7C1yU1zHttphOBfFu8uF0iJzELy2x
	y8rg0unck4i5vZDxvWsGYlChDnwQYFGAp8deZ4poDJoUIV9yGDvahHClICq3YYUgbD2o038pTsc
	QFeYnmbo=
X-Gm-Gg: AYBFou2GY2U2keaITygAXkid0QLoL3PFjqmwk2nxySE31pRexYRIwfsgXrTuqBaeKfp
	eWrYNyrqvmtZmc6JjZnzvhF3NyK4+ueucrM2nPcPaXID2+Oq6Mxo51pnb5ELLP7vM08i5gsJEAw
	O50aITqnb/hmTcqXnPn0U6/syNrEP4/wEYrPW0+LX9AGQ9YLFttmpssnNhkgTBlx3oL8u4E/79Z
	gh0KIyVaphVq3IFFj4uRFWK8By7AyoHaEqc/P6EMpoC6fLLXwM5FJo7svavLoT5oWqwH5nCZkLZ
	AIXFHESrHJl/4cmRsWunJW0MqPbYfYqjecSekY5z2UHwdUJhNLA+zUVCY+FRk83Bkd/wow8Bdpg
	1+0J8GdKLvXMU6dGJiu5tbkWSimL6XrrNe+ctyCbdMVJe1T69y2ERTUTW/d5W3QuBPzlOBAMfBf
	BOIk+9wWP4NHK7wNOdEkcbsY/ibEGIuy479d77m0YONvj/PJYy7Q9Big7OIWD1OGpKbqrl0Qrvt
	yBLNX1RYT5aUEzzoVicstRVyjvDA3OxJSOU+gyeIx2vqyxdWfSS
X-Received: by 2002:a17:90b:4d84:b0:3a0:8a03:2a2d with SMTP id 98e67ed59e1d1-3a4bfe40be4mr216209a91.29.1790707176371;
        Tue, 29 Sep 2026 11:39:36 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a49858bf27sm6796494a91.4.2026.09.29.11.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:39:36 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v6 7/7] selftests/bpf: Test per-call site function specialization
Date: Tue, 29 Sep 2026 18:39:28 +0000
Message-ID: <20260929183928.4896-8-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260929183928.4896-1-emil@etsalapatis.com>
References: <20260929183928.4896-1-emil@etsalapatis.com>
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

