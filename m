Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E954F68D6
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 20:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790627217; cv=none; b=rWMxjyFxxKvs7VnpxqlhOVmzdbL32Uroe9W5h7nOmt6hw8nQbDMS3RNSapebnZSNTLvp9UWs03ywFKu2Ega1qSKOQx64TaE6dHdnyVEgZOn9JMydxiYY1hIoyJe+aQ7N6FqLQ4lfXD+MguU97iJo0OTaWZmQ4Eaj3NNQq010V54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790627217; c=relaxed/simple;
	bh=9F87oM7BbfsHqmFs37dzNvNMJDdgdtKw+E6HbmCZtlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmIDd+BNGIsc7eAPq528ya34927GRjqwKnJCWOqdUINxRFzjaDfE2GJAdr4ibW/80MTP8jd0D4/eGzNtgRTwnmodP+W4KY+2nWIH7TVogwFohLe7uChkjSKx+iwhVZjpBjyiq+2qy5edeYn3tJFQnvf5CSdgqlFwag2pMlYgmec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=RxyuoQLG; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="RxyuoQLG"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc750a1482fso1894270a12.2
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 13:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790627215; x=1791232015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q+Ns2x+z7vlgfAk1Rkohb7w8QqDjYf0bSI4fAoCUwe4=;
        b=RxyuoQLGMg2PIzIZb0vv3WVsdfpPHUOZN2M0Hsn50TIH4mhyTywkfRwQ12cJHrBO27
         FYjFXyd37Eb1GxRoJPe0kaBUhdE2j0iuyQ0lFCYMDt5x3aVY1HRH6C24UMcVzr5p5LAV
         8oleSClwCnGIJZ6079WHzLuNO1qP2hp2y0ORHv0wipDCHAu0ZMgjLMc9iLeKl2P8mduv
         Lo8xwAY4kaaR0PM5BQ65FuvRI+tQPSInPIRUKJVLPqbibHw3OVIHHzTvw4GpBMOhxwv0
         l/2yPQUY737d7zQGUoRJqEmfRgeeB3cuPHWlKNWql1p6+6/GMwJryEVzIMrSn8F63qz8
         WBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790627215; x=1791232015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q+Ns2x+z7vlgfAk1Rkohb7w8QqDjYf0bSI4fAoCUwe4=;
        b=y6ZVqLY08XHU8KbsarVxMTWfS4RyYCPH6PH/VU+Zp4f7XCJEJa99iU7Ym15xkYkFGe
         HkwCQVDT/QYu9m4Z3gPazzI1jP2lP48ZfjJ9F6ITOb4ChLJVbQJqjlRV7c6r3VFaoFSF
         W0MbrfXaaWthabMd/RESmDh3uwTBCZ8Es2VkybLRh487bYXZgb1/cyOoVmC94VLClLIu
         LTOiKwjDNEunOuVMz+z81shyU/+9dUiOSivY0jJakbwiD7JdDR1Xn90q9Hh7gm83r4As
         CD0rVhY3veEnKATpz34+3c6bf5GsLkJxaaWXf31if1M3JNvBH6coV2iL/jJF1y5mAj3S
         MC6g==
X-Gm-Message-State: AFq9FYIjMjkc8QVeO1FEiOJyiFSQ9OWlTY0qKhXx4/Lytb2ttXjVa2W/
	4k4HWPA1cLpYGXywwtk0jRzUhP7R9oVDVXvytEDRY8L8wCg7DaGiNIA/RUkeMsk2ofEVhxnuYAn
	zrcujV1s=
X-Gm-Gg: AYBFou3FrMs08tP2o74MA31HAj1wFPhTTqWsTFn4G/W9Fzy7krXqNkDrfPqYTATmicM
	sCbmSHHEhNctVQwCUVxiEkJBNTyEOL4SaH1tyh8a2C4V4jFgTUoYRh2HQMpOnhqwDSLS8IG1WSu
	QImZhSnrKrL/mlH31YtpL8IqjrtFbSY1BRqGCS0AjVDRGrczL0yn5gG0K1bP07O2TsfccvuBrYw
	e1KpepQxWHhnSG7ci1PZq0j/jXHJb0zZT6caVcoJ++WEZuIyaMt7q2w6TUV30iQeyi1PKndmJYP
	uV10cn2Fy5mU+QK99RiEz0OdmEX+HghooKP1ZbHclO++ClmIj3rlNw8GbI2mfYCofaJQaPUSezh
	JrbzQR4Kz4pMa3Ze7J461Yydc05EcynlQfOScRVEHytiB4BW7A8Zd9u/shwM6W9+7c4KDab8XlA
	yitE5Sioa0OVFzZOV8rgBID1RGhJ1sqZwqt7cf/6y/okM2nibBqXocmuBNIFubZc2ivxMpzgq0w
	6TDT8959Y9Yjwz32U1OFZ8BXVnOvFmVaNlY2Ki6pw==
X-Received: by 2002:a17:90b:3a44:b0:3a2:aec0:6bc4 with SMTP id 98e67ed59e1d1-3a2aec07038mr3955810a91.50.1790627215186;
        Mon, 28 Sep 2026 13:26:55 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a492ea04b1sm975193a91.4.2026.09.28.13.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:26:54 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 7/7] selftests/bpf: Test per-call site function specialization
Date: Mon, 28 Sep 2026 20:26:43 +0000
Message-ID: <20260928202643.9114-8-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928202643.9114-1-emil@etsalapatis.com>
References: <20260928202643.9114-1-emil@etsalapatis.com>
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

