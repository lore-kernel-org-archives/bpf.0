Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7BD45BE3
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 23:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776468995; cv=none; b=aBKJYCFhi9UXlgriJJ6gjsfYsEjtpS907J1ZFWgJItN6x6smEDUOkW+qsomH8FCWJb6Z1sPCw6xKjCeAUYrc2BZRkVFYAhpsPCKU5lMwUqwneVp5WSwQbxtNHxqL17WP5KmsXAq0pjyPgIu4kt+pQxOMsuXU5qtoWVE8WVchXyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776468995; c=relaxed/simple;
	bh=7eLXmvmjH2ZIOLtXr6xn5I1rE6lcGaaCLmt0eU1r0gs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y/g94V+x+twvFq8U9+JimCh/UOCZiVNaIluPUu9XfS/oEm0QB63aVBEseXXMHnwXEBOw0h5XS9lWxDc3Sj9vARfeRx4IVYnGLszUcugEtKuaEyG8g3YDSh/d5McckcXeo+yadC3tQt5tlgqFmb8Q8Q+ndl8njDlDjFRjRWh/eX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCTKlwya; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCTKlwya"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c76d797b180so871719a12.2
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 16:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776468993; x=1777073793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1W396UnHhEOLTibKjo9HI3jgjyw+qWePRGWE9oY4u+I=;
        b=dCTKlwyaLUgHRTsJp9xahqA/u9QtnxFFLFBdOuvs5ilKl7+HKNUykvJxFKQCO0t1X9
         awPSWPtJFY6hZwOpcLTJQg1WlGFAF2A7yCHEbi+X1zbO2bm5tVbogvlw+eeRs/LqZZor
         2SuAcl0QuXBYP2aNU8p6PgH15tqPbIXTZnfbUrndZdXUBXxtKwudDKQJlpK0h/IBOUfc
         4p4sMvQt+x3S2X7S9xWInv/M1f9egALv+GpeOo4nFstmVw2exRdYkF0bGNs+RZExdrlI
         ZqENHPK2352Mcd47A1sTrGoJhlAXYfSoaQKXq9t1IDGUsJNgerXKgB4wtKaxck5XyYhi
         gqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776468993; x=1777073793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1W396UnHhEOLTibKjo9HI3jgjyw+qWePRGWE9oY4u+I=;
        b=i6vmYHAnG4L6H2R56cPE6LXXAEVOJtiCh11/V/OfOYBDJlLDZkzj+7uXnKL6on3C2o
         Zy0xv6tqvd/yImYb7+yvn6Mmlewu6U/P08e4fzRTPIYn/in/e90to1tUe9v2msHXfyJr
         bmeNVTHjhdar3HuCzpaeimmpsKdn2QwT4in1XC//jx5azb/Ldk9K5UPkaL46riGrG+mq
         q+eriZAXUCTUTJ5cd7h5trOZJszykm41rs6WAwBGBbzvjaVBD6Z5gd4uVsz+slhpvK6v
         TKTjjE/DOmO4n1CaUrJOtdy03hfv8+VvVLJ2BG3mb0525JR6nsYV/ZlwSG6280vWnWkG
         RUYg==
X-Gm-Message-State: AOJu0YxCyqbomnpF3psE9eduZmDdEpcttj5+Id6FyBiPeJJQbJP2bVp9
	rzU0IOENMI79t1EGHPWi4Ls4+CIUsh/FpFRz9NZHtf4WwY/1u8sWdsFcZjjr7g==
X-Gm-Gg: AeBDievzHoWCooXOv6mULilc90w+cFBViWOkdFAy34FBv60CKdYn0E3aTe+Cyt7pFs6
	AIp4UK4lqpUMOuj8++K0Jq/5j+niMYHdOzLXGlGNYIdjEcMwaakxhXWyyyOdT7H3mPk2NPHzGCG
	epI9K2QiydU8NKvkglP/fsQ7HMyKDFELUyg8dxpu6IW8AfAM/Kg141I81A7F2ZaqAScpl0yBlUu
	P29n0ST6ZARqURU2V2h7H9fV0zJud6dcQHvqqgP+HZDWLkLnmHh0+IXS6HlM74nvapf+hYI4KYf
	xfOIa9+P47ckDzjIjt/BOXpiyB5n5l4noRYzqJunP1A7qOm+A1daJ/zVQexk7JhWy+vcOhTg5/D
	bDW4XDewq3qjDCr8TTEBUC7ZpY3Nr8zjt3uwSQ7mwtp3MeFXjOteOuwdW+z9NtbDRvHEiLF1lUa
	EbEQDheuRSdPzpXGVVXGhLLtnZ
X-Received: by 2002:a05:6a21:328c:b0:39f:794f:94d8 with SMTP id adf61e73a8af0-3a08d8a5c43mr5474206637.29.1776468993072;
        Fri, 17 Apr 2026 16:36:33 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797701d880sm2270069a12.20.2026.04.17.16.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 16:36:32 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/1] selftests/bpf: Trace bpf_local_storage_update to debug flaky local storage tests
Date: Fri, 17 Apr 2026 16:36:31 -0700
Message-ID: <20260417233631.1443199-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

task_local_storage/sys_enter_exit and cgrp_local_storage/
cgroup_iter_sleepable occasionally fail in CI possibly because
bpf_{task,cgrp}_storage_get() returns NULL. Add a fexit probe on
bpf_local_storage_update() to capture the actual error code when this
happens. It will allow us to tell if it is trylock failure in
kmalloc_nolock(), timeout/deadlock in rqspinlock or something else.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/cgrp_local_storage.c       | 15 +++++++++++++--
 .../bpf/prog_tests/task_local_storage.c       |  1 +
 .../selftests/bpf/progs/cgrp_ls_sleepable.c   | 18 ++++++++++++++++++
 .../selftests/bpf/progs/task_local_storage.c  | 19 +++++++++++++++++++
 4 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
index 478a77cb67e6..c4398ccf3493 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
@@ -176,7 +176,7 @@ static void test_cgroup_iter_sleepable(int cgroup_fd, __u64 cgroup_id)
 	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
 	union bpf_iter_link_info linfo;
 	struct cgrp_ls_sleepable *skel;
-	struct bpf_link *link;
+	struct bpf_link *link, *fexit_link;
 	int err, iter_fd;
 	char buf[16];
 
@@ -200,16 +200,27 @@ static void test_cgroup_iter_sleepable(int cgroup_fd, __u64 cgroup_id)
 	if (!ASSERT_OK_PTR(link, "attach_iter"))
 		goto out;
 
+	fexit_link = bpf_program__attach(skel->progs.fexit_update);
+	if (!ASSERT_OK_PTR(fexit_link, "attach_fexit"))
+		goto out_link;
+
 	iter_fd = bpf_iter_create(bpf_link__fd(link));
 	if (!ASSERT_GE(iter_fd, 0, "iter_create"))
-		goto out_link;
+		goto out_fexit_link;
+
+	skel->bss->target_pid = sys_gettid();
 
 	/* trigger the program run */
 	(void)read(iter_fd, buf, sizeof(buf));
 
+	skel->bss->target_pid = 0;
+
+	ASSERT_EQ(skel->bss->update_err, 0, "update_err");
 	ASSERT_EQ(skel->bss->cgroup_id, cgroup_id, "cgroup_id");
 
 	close(iter_fd);
+out_fexit_link:
+	bpf_link__destroy(fexit_link);
 out_link:
 	bpf_link__destroy(link);
 out:
diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index 1b26c12f255a..5b2b56cc3a4f 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -47,6 +47,7 @@ static void test_sys_enter_exit(void)
 	skel->bss->target_pid = 0;
 
 	/* 2x gettid syscalls */
+	ASSERT_EQ(skel->bss->update_err, 0, "update_err");
 	ASSERT_EQ(skel->bss->enter_cnt, 2, "enter_cnt");
 	ASSERT_EQ(skel->bss->exit_cnt, 2, "exit_cnt");
 	ASSERT_EQ(skel->bss->mismatch_cnt, 0, "mismatch_cnt");
diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c b/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c
index a2de95f85648..37bd6b03ba01 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c
@@ -4,6 +4,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
+#include "err.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -16,6 +17,7 @@ struct {
 
 __s32 target_pid;
 __u64 cgroup_id;
+long update_err;
 int target_hid;
 bool is_cgroup1;
 
@@ -123,3 +125,19 @@ int yes_rcu_lock(void *ctx)
 	bpf_rcu_read_unlock();
 	return 0;
 }
+
+SEC("fexit/bpf_local_storage_update")
+int BPF_PROG(fexit_update, void *owner, struct bpf_local_storage_map *smap,
+	     void *value, u64 map_flags, bool swap_uptrs,
+	     struct bpf_local_storage_data *ret)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+
+	if (task->pid != target_pid)
+		return 0;
+
+	if (IS_ERR_VALUE(ret))
+		update_err = PTR_ERR(ret);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/task_local_storage.c b/tools/testing/selftests/bpf/progs/task_local_storage.c
index 80a0a20db88d..34fa3d6451d2 100644
--- a/tools/testing/selftests/bpf/progs/task_local_storage.c
+++ b/tools/testing/selftests/bpf/progs/task_local_storage.c
@@ -14,12 +14,15 @@ struct {
 	__type(value, long);
 } enter_id SEC(".maps");
 
+#include "err.h"
+
 #define MAGIC_VALUE 0xabcd1234
 
 pid_t target_pid = 0;
 int mismatch_cnt = 0;
 int enter_cnt = 0;
 int exit_cnt = 0;
+long update_err = 0;
 
 SEC("tp_btf/sys_enter")
 int BPF_PROG(on_enter, struct pt_regs *regs, long id)
@@ -62,3 +65,19 @@ int BPF_PROG(on_exit, struct pt_regs *regs, long id)
 		__sync_fetch_and_add(&mismatch_cnt, 1);
 	return 0;
 }
+
+SEC("fexit/bpf_local_storage_update")
+int BPF_PROG(fexit_update, void *owner, struct bpf_local_storage_map *smap,
+	     void *value, u64 map_flags, bool swap_uptrs,
+	     struct bpf_local_storage_data *ret)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+
+	if (task->pid != target_pid)
+		return 0;
+
+	if (IS_ERR_VALUE(ret))
+		update_err = PTR_ERR(ret);
+
+	return 0;
+}
-- 
2.52.0

