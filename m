Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2858433C1B4
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771968389; cv=none; b=ks9be/3ise0ApbEXwVq7IORQSdNbLDIfGHdblVhkhxEayiYpaKdnRoeUYwSBZWpR4tjiKTJkOaCovLubfAzzaqglXeEEY2TYAcagnkRMNcfO+9fDMlZ792NgfKlgK7d2lmH7bDzNB7fZO6XOt4WLbMOBb7GYBo3MLph83+wlWsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771968389; c=relaxed/simple;
	bh=U+jn2sF8dWx92yWwAWMWVO9fVpGiPkRx18IV5LgoQcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lH+vjcgteSfGVlOFQnpd9m96nWluo4s7eMa5qsojcR9roHOl1hapflXG/pDEZg/PutZ/Splmp9IYqJDT9AiMfbJxXBx0+lR8f+khO5hQMbqnFR65woAMhTRyjZH5j9MgbBHwKP2eUGfg8w+oxnZnsZcWhSbDdl4UubMuH5m9rIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suquMXBo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suquMXBo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EDFC116D0;
	Tue, 24 Feb 2026 21:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771968389;
	bh=U+jn2sF8dWx92yWwAWMWVO9fVpGiPkRx18IV5LgoQcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=suquMXBo3Ny0DlVu/WUot4noyHi2sfDRQZbA/Pc+NoseBZJcbjXxxnUMz5xvB6Vv5
	 57+ChAROIhY6CQ0NJpWxMb4YP6DBZAzeUhhd5WfwG2zFYrbgWGMdJxGSrW0YN7IQUL
	 O7n+ds3gg1TnMk29n12dYOvS1BE09uT+D/lG69T0FPA2UWmwIZ7jGZ7Kgr1VqhMcQ8
	 PvY8Hd3Kio37+aMeL3ENY0+oIPp4fpN01aT7dHNim/Xpc4GfKOLUYvILqy4sH2y7J7
	 JPcqhVcmYilDcb7hjkChgs1kCHCMQ5wFLcTx+xkRGA5S77E82QM/khYMyXjwZw2ZUW
	 fn2QF3UCQMLgw==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 7/7] selftests/bpf: Add tests for split task_vma iterator
Date: Tue, 24 Feb 2026 13:25:29 -0800
Message-ID: <20260224212535.1165151-8-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224212535.1165151-1-puranjay@kernel.org>
References: <20260224212535.1165151-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add runtime and verifier tests for the split task_vma iteration model.

The runtime tests are:
- iter_task_vma_release_and_copy: iterates VMAs, saves vm_start,
  releases mmap_lock via bpf_iter_task_vma_release(), then calls
  bpf_copy_from_user() on the saved address.
- iter_task_vma_nested: two nested task_vma iterators on the same task
  verify that mmap_read_trylock() succeeds for the second reader on
  the same mm.

The verifier tests cover:
- nosleep_iter_release_then_sleep: release then sleep is accepted
- nosleep_iter_sleep_without_release: sleep without release is rejected
  with "in nosleep region"
- nosleep_iter_vma_access_after_release: VMA access after release is
  rejected with "invalid mem access 'scalar'"
- nosleep_iter_double_release: double release is rejected
- nosleep_iter_release_without_acquire: release without prior _next is
  rejected
- nosleep_iter_nested_release_inner: releasing inner iterator does not
  allow sleeping when outer still holds a nosleep reference

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../testing/selftests/bpf/bpf_experimental.h  |   1 +
 .../testing/selftests/bpf/prog_tests/iters.c  |  24 ++++
 .../selftests/bpf/progs/iters_task_vma.c      |  71 ++++++++++
 .../bpf/progs/iters_task_vma_nosleep.c        | 125 ++++++++++++++++++
 4 files changed, 221 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_vma_nosleep.c

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 9df77e59d4f5..531d6c6aab45 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -165,6 +165,7 @@ extern int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 				 struct task_struct *task,
 				 __u64 addr) __ksym;
 extern struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_vma *it) __ksym;
+extern void bpf_iter_task_vma_release(struct bpf_iter_task_vma *it) __ksym;
 extern void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it) __ksym;
 
 /* Convenience macro to wrap over bpf_obj_drop_impl */
diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/testing/selftests/bpf/prog_tests/iters.c
index a539980a2fbe..ab24871762c8 100644
--- a/tools/testing/selftests/bpf/prog_tests/iters.c
+++ b/tools/testing/selftests/bpf/prog_tests/iters.c
@@ -21,6 +21,7 @@
 #include "iters_css_task.skel.h"
 #include "iters_css.skel.h"
 #include "iters_task_failure.skel.h"
+#include "iters_task_vma_nosleep.skel.h"
 
 static void subtest_num_iters(void)
 {
@@ -152,6 +153,28 @@ static void subtest_task_vma_iters(void)
 	if (!ASSERT_EQ(skel->bss->vmas_seen, seen, "vmas_seen_eq"))
 		goto cleanup;
 
+	/* Test release+sleepable: trigger the release_and_copy program */
+	skel->bss->release_vmas_seen = 0;
+	err = iters_task_vma__attach(skel);
+	if (!ASSERT_OK(err, "skel_reattach"))
+		goto cleanup;
+
+	getpgid(skel->bss->target_pid);
+	iters_task_vma__detach(skel);
+
+	ASSERT_GT(skel->bss->release_vmas_seen, 0, "release_vmas_seen_gt_zero");
+
+	/* Test nested iterators on same task (same mmap_lock) */
+	skel->bss->nested_vmas_seen = 0;
+	err = iters_task_vma__attach(skel);
+	if (!ASSERT_OK(err, "skel_reattach_nested"))
+		goto cleanup;
+
+	getpgid(skel->bss->target_pid);
+	iters_task_vma__detach(skel);
+
+	ASSERT_GT(skel->bss->nested_vmas_seen, 0, "nested_vmas_seen_gt_zero");
+
 cleanup:
 	if (f)
 		fclose(f);
@@ -322,4 +345,5 @@ void test_iters(void)
 	if (test__start_subtest("css"))
 		subtest_css_iters();
 	RUN_TESTS(iters_task_failure);
+	RUN_TESTS(iters_task_vma_nosleep);
 }
diff --git a/tools/testing/selftests/bpf/progs/iters_task_vma.c b/tools/testing/selftests/bpf/progs/iters_task_vma.c
index dc0c3691dcc2..baecd79d2998 100644
--- a/tools/testing/selftests/bpf/progs/iters_task_vma.c
+++ b/tools/testing/selftests/bpf/progs/iters_task_vma.c
@@ -40,4 +40,75 @@ int iter_task_vma_for_each(const void *ctx)
 	return 0;
 }
 
+unsigned int release_vmas_seen = 0;
+
+SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
+int iter_task_vma_release_and_copy(const void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct vm_area_struct *vma;
+	unsigned int seen = 0;
+
+	if (task->pid != target_pid)
+		return 0;
+
+	if (release_vmas_seen)
+		return 0;
+
+	bpf_for_each(task_vma, vma, task, 0) {
+		__u64 start;
+		char buf[8];
+
+		if (bpf_cmp_unlikely(seen, >=, 1000))
+			break;
+
+		/* Phase 1: mmap_lock held, read VMA data */
+		start = vma->vm_start;
+
+		/* Transition: release mmap_lock */
+		bpf_iter_task_vma_release(&___it);
+		/* VMA pointer is now invalid; sleepable helpers allowed */
+
+		/* Phase 2: mmap_lock released, sleepable call */
+		bpf_copy_from_user(&buf, sizeof(buf), (void *)start);
+
+		seen++;
+	}
+
+	release_vmas_seen = seen;
+	return 0;
+}
+
+/*
+ * Test nested task_vma iterators on the same task.  Both iterators take
+ * mmap_read_trylock() on the same mm; the rwsem should allow the second
+ * reader and the inner loop should observe at least one VMA.
+ */
+unsigned int nested_vmas_seen = 0;
+
+SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
+int iter_task_vma_nested(const void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct vm_area_struct *vma1, *vma2;
+	unsigned int seen = 0;
+
+	if (task->pid != target_pid)
+		return 0;
+
+	if (nested_vmas_seen)
+		return 0;
+
+	bpf_for_each(task_vma, vma1, task, 0) {
+		bpf_for_each(task_vma, vma2, task, 0) {
+			seen++;
+			break;
+		}
+		break;
+	}
+
+	nested_vmas_seen = seen;
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/iters_task_vma_nosleep.c b/tools/testing/selftests/bpf/progs/iters_task_vma_nosleep.c
new file mode 100644
index 000000000000..ab607e29b36a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters_task_vma_nosleep.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include "bpf_experimental.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+/* Negative test: sleepable call without release should be rejected */
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("sleepable helper bpf_copy_from_user#148 in nosleep region")
+int nosleep_iter_sleep_without_release(const void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct vm_area_struct *vma;
+
+	bpf_for_each(task_vma, vma, task, 0) {
+		char buf[8];
+
+		/* Attempt to call sleepable helper without releasing mmap_lock.
+		 * Verifier should reject this.
+		 */
+		bpf_copy_from_user(&buf, sizeof(buf), (void *)vma->vm_start);
+		break;
+	}
+	return 0;
+}
+
+/* Negative test: VMA access after release should be rejected */
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("invalid mem access 'scalar'")
+int nosleep_iter_vma_access_after_release(const void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct vm_area_struct *vma;
+	__u64 val = 0;
+
+	bpf_for_each(task_vma, vma, task, 0) {
+		bpf_iter_task_vma_release(&___it);
+		/* VMA pointer is now invalid. Accessing it should be rejected. */
+		val = vma->vm_start;
+		break;
+	}
+	__sink(val);
+	return 0;
+}
+
+/* Positive test: release then sleepable call should succeed */
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__success
+int nosleep_iter_release_then_sleep(const void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct vm_area_struct *vma;
+
+	bpf_for_each(task_vma, vma, task, 0) {
+		__u64 start = vma->vm_start;
+		char buf[8];
+
+		bpf_iter_task_vma_release(&___it);
+		bpf_copy_from_user(&buf, sizeof(buf), (void *)start);
+		break;
+	}
+	return 0;
+}
+
+/* Negative test: double release should be rejected */
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("no acquired reference to release")
+int nosleep_iter_double_release(const void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct vm_area_struct *vma;
+
+	bpf_for_each(task_vma, vma, task, 0) {
+		bpf_iter_task_vma_release(&___it);
+		bpf_iter_task_vma_release(&___it);
+		break;
+	}
+	return 0;
+}
+
+/* Negative test: release without any prior _next acquire */
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("no acquired reference to release")
+int nosleep_iter_release_without_acquire(const void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct bpf_iter_task_vma it;
+
+	bpf_iter_task_vma_new(&it, task, 0);
+	/* No _next called, so no acquired reference exists */
+	bpf_iter_task_vma_release(&it);
+	bpf_iter_task_vma_destroy(&it);
+	return 0;
+}
+
+/* Negative test: nested iterators, releasing inner should not allow sleeping
+ * because the outer iterator still holds a nosleep reference.
+ */
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("sleepable helper bpf_copy_from_user#148 in nosleep region")
+int nosleep_iter_nested_release_inner(const void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct vm_area_struct *vma_outer, *vma_inner;
+
+	bpf_for_each(task_vma, vma_outer, task, 0) {
+		bpf_for_each(task_vma, vma_inner, task, 0) {
+			__u64 start = vma_inner->vm_start;
+			char buf[8];
+
+			bpf_iter_task_vma_release(&___it);
+			/* Inner released, but outer still holds nosleep ref.
+			 * Sleeping should still be forbidden.
+			 */
+			bpf_copy_from_user(&buf, sizeof(buf), (void *)start);
+			break;
+		}
+		break;
+	}
+	return 0;
+}
-- 
2.47.3

