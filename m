Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE3850C28C
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 23:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790379350; cv=none; b=Av4v6IQ/CGrBg1K/leOf6UyTy27RvVik0LiNtkGatXYPDSp9MjN6YJp7T8YuCwhRvcYNfd6Wl1k7fvpJ8gf0cj9yaGjFLK9GZhxpn9SHxWVmym+a2vtQ7a4TAaCt3mnNdiG+apVp684yFM8TSyjL0HN4FlIL2ddEoitSmP+NlNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790379350; c=relaxed/simple;
	bh=9F87oM7BbfsHqmFs37dzNvNMJDdgdtKw+E6HbmCZtlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERmvN67z7HH66vIh9k5L35NK+c7d8D3tA+82/RcdvdJ2REICftbfWXdlubC9xYxZF8C9c5ufhUwWzHzm6p1N8QbnXOYNVVtpJ9Q2i1yxy7ELuRzeLcnbhrHp4XeOo11pJWlXm+pEPyjRgosOZga8ueoAn4Sns0NLbJCp4Ta/OUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=XMddtT43; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="XMddtT43"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso754867a91.2
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 16:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790379348; x=1790984148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q+Ns2x+z7vlgfAk1Rkohb7w8QqDjYf0bSI4fAoCUwe4=;
        b=XMddtT43V3f8N1U2jFy7u6Er3rUI3294Fzq8HuheRaPVrzN1BXHbCipxq9LoGfLklx
         ffMaqQzKGXkpVP1qeXmnJt6JpMGj0DcFhhNMJFYCYnJBZSfnfxDjs89xEKrCvNlEim9Q
         sDT63PW0cLn8PJ/MgT/uhOrydU1G4gdbSg7ce/6BmsIhK68m+cI7qFCyF2My8GUzUUjo
         2/0GrfzLAsZ8E9xrjOPLhoId8/J0WzEirajDAzFELOM8j6V3WDWhzXdH/IY+oJGVXMWE
         +lM9HXweByTGgZJJYZbh31gsmy/l12NpBC1kXEnInqyOC/CkqEW6PIHS0ErI+KKXStXB
         qQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790379348; x=1790984148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q+Ns2x+z7vlgfAk1Rkohb7w8QqDjYf0bSI4fAoCUwe4=;
        b=wqDFWnvZYuaVXqdZQNvWqaJ9rqP7D5g5hF1kZxhjTCHVLOVmgrKc28CzIPvPqx5HJ9
         NvL8UlOQ3G4QXIIHxDLamVWXTvGugFKIFzrsGvwvR9oSHVmVpeeol/q/KXqJGXD9/1PI
         Ew/nvKZ8lmbLfouJy/mg6sFEqU3c56D1b8Y49aNxbQr6VUctDhN+WsmabKsB04IY8MNB
         Il/2b4/xm5Y8Ign9sUkqnhtUIHTRnWkX5Xze5/DX2pOlfBpUhm/eYzgjWWTTODp7Y4kO
         aa38QHZKE48mbe2cjfg39d/dXkLBqC+EUFtCfFi0kMrlqIPOQAAztK34VkbNG/kIv+DZ
         683w==
X-Gm-Message-State: AFuF++nmeoz1wiGjfr4mQGxnlfHp5IlenMXpe3pHpqRI6ufjVNm4GSUh
	uhhBRdbmTWOW0Uql35eG+PzF2JwHCh8WQHz8zVIaiz6AQiwNAxoU7ybpKRTK6RHAhbOWt8hToRt
	NlDoichU=
X-Gm-Gg: AYBFou2m/xqimJzTCC4tOrvnQjlJtjUoShKgCm8fdYRTjPvwWa4R36ABmp2ZjLg5dDy
	7QXnjNxNGzqkICrBVzaphdOuyE1KE2aNKZ7fIhQWT15vg3GU8z9BiWqypRkvl9ZnSq6uw1Hq1gr
	xQQ0shfyf2I+FfIViH4uY/EHt3pkJ7N9DbHjyuOFS2wUkSIbSUIwQ9Zt0cNO6GHS9jsDd8dmPY8
	YdW1rr/IXP6emv/zKwHXjXknqsFqX39NpVZCV7g43mYU/CnQJLBpkP/B9q3MCkKVqqUElLHLxiX
	a48BYrsft9QsyaBPbQXhvj6z0Mg79JOYMQFIKu/U/6q6p01/wux4nk1D7yJoCu4Awk2MyRa2Q13
	gIA7BHag1a0fye4pQnXMdhNCrxGzngoUpHpsDBOMcLx41z9jjsl6cmkiBlTItgkGYohUXEjWSnf
	YKBVBRtgydeETNhx8YlIyYB0oqCUxNMVQ0QZB/yF9wMikvngNsDdmUCAOAybhpaoPZ46R6gzbkk
	TaPTN2Kwv00+pMN5FiQ8aB8iLPWfVIuqcq1v1RL0SImjPY6lp/i
X-Received: by 2002:a17:90b:47:b0:3a0:c1b2:e6e7 with SMTP id 98e67ed59e1d1-3a0c1b2e82dmr2270447a91.10.1790379347903;
        Fri, 25 Sep 2026 16:35:47 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0bec30aaasm5790436a91.15.2026.09.25.16.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 16:35:47 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 7/7] selftests/bpf: Test per-call site function specialization
Date: Fri, 25 Sep 2026 23:35:38 +0000
Message-ID: <20260925233538.5708-8-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925233538.5708-1-emil@etsalapatis.com>
References: <20260925233538.5708-1-emil@etsalapatis.com>
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

