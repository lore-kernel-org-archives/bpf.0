Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42685263F5D
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 10:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790938352; cv=none; b=je6yn5kqZ0KViq486YEgDVAilyJrvvDWDQwOZQOua9LMnjuLWk6OmE4FNRHCn9ZZczK3X2HtvcNc8C5W8+HTcPMRaOMMf2lFZzeDm2Ee3VjfZWMV0/mFRMaY6cdag2+aGBgRpeZ+HEjImv5NYyQ3Ulid3+Y9DifWt4n9Bpb38W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790938352; c=relaxed/simple;
	bh=9F87oM7BbfsHqmFs37dzNvNMJDdgdtKw+E6HbmCZtlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gB8OZ3ODXJTamLpi8bq+d7jdmCR04Oi2TVdvKX+aqRkwUrbEJhDQgp29P7cQXxOyt2e/ngs2KEn93i86J7jz706JT9X9IvLnimnt0QdZroTADXwpjsktpzayDEaMq1bt84Bq+4FE3QfABYGOYRyvYCXTmTKZg4Ae1KTz5H9CO0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=CULTZVH8; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="CULTZVH8"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d822dso55801055e9.2
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 03:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790938349; x=1791543149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q+Ns2x+z7vlgfAk1Rkohb7w8QqDjYf0bSI4fAoCUwe4=;
        b=CULTZVH8OPzsClLOGOaA1BONILz3pqoLDx2FtHjwhN/8vK5UG0p8PYvEbs0JyZl+fI
         zGRMA8IY4h0qBEK8ACLKCf38YAG3FhUsTM70wsSe8kGqKDwQ6Ot9x246LlYHDty0HPjH
         YR6HbIEoZ8A5YwtMeJMfljNHF5FjfjUPmUoecRE/N+0ghfkj3qlGcJzJEVQI9+uP/YkM
         Fha4N8wT9ym/0fzY/I/RFQZv2mcfcBo+6yckfAHOeAaV9F6vj5HOteYBoSm2ZjUBkeko
         EhRp7f2qWLXG4WabgHQOdNsvER5eWHpNuKy594a3dqNpwnOxhbzEuha0khJrufbRZdam
         asNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790938349; x=1791543149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q+Ns2x+z7vlgfAk1Rkohb7w8QqDjYf0bSI4fAoCUwe4=;
        b=KXslZArZ8iNRJJ/PWuTwtMmkLBLHWvUilThuIFxJNJgjqdBKBvRqGWr3gt1OHv4VML
         9FOn3a8dUESIwUMOMr4OR15bDTQiAIbD1oEE23cgIRycggZShio+tNH1JX4SUf2q6I4j
         upDyZNcfacisutzq588pcz7WPuTEHl76D5lEMtFMo8GiX4IaGquDkkJqH8jGlVybF+om
         K9blaPxDs5ZJMQb6yi32uO/nKRzWW8Z3PChdE3nyMzv9Wp/MahM87ncOirAXmDobPmua
         5HPMkKkocK+br1dW5SlO6x/EG9DWzt54XSPA39r9NTe59qg5taxyf3xNv9ja4oJI3u1i
         a02A==
X-Gm-Message-State: AFuF++lQb4tdKaerMR3S4MIhAup7/mnjkIdPrIISwScUFMlH3eCQpBkp
	qQkfcoRoxxzUGs4FR8vrx0tgcaTcCbicm5c1XJOAvmRfgr4WroruyDCKJsSb1djTxWxsXClonXF
	dCcToB3k=
X-Gm-Gg: AYBFou3UOyJKxgzqUpHATF28mNhylY1eQ7ctwQUZ0I0FCFx50qnNstbOoLZDCZMAv+J
	VO5qZODaLiPIGT6abrN8tK8xJ+vNytXffjsycwWl/wTuZbRBQm4dGvjkzCpnWouktNjiWyJE53C
	vpIzR2F+NbucncKPH8WxA88EaZ/Hc6Nl51w3Vgb7+nd6FBz69kJwuLBWrukN8f8Kkky3D+9+TgY
	qs5qNaUm2coRfmeh2Iyl+hWRK5TS7MIh60zf0VkKptnnefS2plwkg1CCplMQf5nPI5QcraRoKgo
	rSjneVZBDx86H3h81UTlXCZI7I5r4+UlkGOy7hZfqUi4YOnqe3nWqx4a3yiDBXRUz0UcJPhE6fJ
	QDDAntIsLgM4MvMgGYaZkkhW5JELFqvfkJhI8Z3EJ1hKiWMOwRylMYYtwPyhkZff9aOZLa3P1UW
	SSaBkedIq4zf1oyx2t7reiJtks3K5Q38k1+x6YzU6O2EC/9HgTiuaGcZUPvQ==
X-Received: by 2002:a05:600c:608c:b0:4a0:20fa:603f with SMTP id 5b1f17b1804b1-4a02758e4e1mr40633135e9.17.1790938348477;
        Fri, 02 Oct 2026 03:52:28 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c092:600::1:5543])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027da120bsm77866625e9.0.2026.10.02.03.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 03:52:28 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [RESEND PATCH bpf-next v6 7/7] selftests/bpf: Test per-call site function specialization
Date: Fri,  2 Oct 2026 10:52:18 +0000
Message-ID: <20261002105218.6171-8-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002105218.6171-1-emil@etsalapatis.com>
References: <20261002105218.6171-1-emil@etsalapatis.com>
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

