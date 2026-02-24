Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BFF1DFF0
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 01:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771898361; cv=none; b=WtkKLjQAB/OtVtsZtBuOYwAaw4aORh3+8of7Z93p/Nf2+YwF/XA6zCU8N51SNiOXUQq5GrRz8EvVqUBigWOdRrG1jWjMFR7gfVBb/kAdu5VyyPfcmJeynbVw7ph0JPNUJMr3GKcA/DUwTosnHcVVigoqcidsVrjRyy9ji+HRObI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771898361; c=relaxed/simple;
	bh=sMEnpYSH73DUDJ2uSib3a6OeS/+zeA1qo3IeycK28Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lGSPKwMzYfldvbNQQpFqWApjzYG7ipujRfvAvLD7C09B0CJr4P2q6R2xlXKVyhiiYrRdo3jbDWEMMiSSVYWbfqoKYTF8fJ/rCVhhQIluJte756JAhAxyTSCkBrX5KmqchYjfPZ+U/MbMuvLC/CTWRUqmbfkmQLPjnWBKYQ2r9Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZzyTd2Xf; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZzyTd2Xf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771898357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tLAhwByUlDvI1nu/Ra0kl0Z8oxgrgBwoc8RwzjrPVbM=;
	b=ZzyTd2Xfg4Lao2eyQuPCVUHtP+zM+UPuysYSGVQY10CxuiopvOJAxxaGfVWQ6KskeLk77w
	sRC/h10DjqdnMHqMzuSzoFmMTMkhijE4NXz8ijWPRo41xV3Ci+MdwxGsU/o2lEE8BeC9Zk
	cw7OmW9Lc0B0mpAPBVWmp972AVItZLM=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1] selftests/bpf: Fix flakiness of task_local_storage/sys_enter_exit
Date: Mon, 23 Feb 2026 17:58:55 -0800
Message-ID: <20260224015855.1481707-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The test_sys_enter_exit test was setting target_pid before attaching
the BPF programs, which causes syscalls made during the attach phase
to be counted. This is flaky because, apparently, there is no
guarantee that both on_enter and on_exit will trigger during the
attachment.

Move the target_pid assignment to after task_local_storage__attach()
so that only explicit sys_gettid() calls are counted.

Reported-by: BPF CI Bot (Claude Opus 4.6) <bot+bpf-ci@kernel.org>
Closes: https://github.com/kernel-patches/vmtest/issues/448
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

---

I've been experimenting with running AI on BPF CI to investigate test
failures. This is an example of a thing it may come up with.

I don't want to spam the list with these, so for starters I'll be
relaying only patches that I evaluated and/or tested.

The AI generated reports will be posted with "[bpf-ci-bot]" prefix
here: https://github.com/kernel-patches/vmtest/issues

The goal of this particular application of AI is to make BPF CI more
stable, less noisy/flaky, and potentially find and fix more kernel
bugs. We'll see how it goes.

---
 .../selftests/bpf/prog_tests/task_local_storage.c  | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index 7bee33797c71..2820a604aaa6 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -25,24 +25,28 @@
 static void test_sys_enter_exit(void)
 {
 	struct task_local_storage *skel;
+	pid_t pid = sys_gettid();
 	int err;
 
 	skel = task_local_storage__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
 		return;
 
-	skel->bss->target_pid = sys_gettid();
-
 	err = task_local_storage__attach(skel);
 	if (!ASSERT_OK(err, "skel_attach"))
 		goto out;
 
+	/* Set target_pid after attach so that syscalls made during
+	 * attach are not counted.
+	 */
+	skel->bss->target_pid = pid;
+
 	sys_gettid();
 	sys_gettid();
 
-	/* 3x syscalls: 1x attach and 2x gettid */
-	ASSERT_EQ(skel->bss->enter_cnt, 3, "enter_cnt");
-	ASSERT_EQ(skel->bss->exit_cnt, 3, "exit_cnt");
+	/* 2x gettid syscalls */
+	ASSERT_EQ(skel->bss->enter_cnt, 2, "enter_cnt");
+	ASSERT_EQ(skel->bss->exit_cnt, 2, "exit_cnt");
 	ASSERT_EQ(skel->bss->mismatch_cnt, 0, "mismatch_cnt");
 out:
 	task_local_storage__destroy(skel);
-- 
2.53.0

