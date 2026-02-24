Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E9B33A70F
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 21:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771967538; cv=none; b=N1Bsej3zfmrsSHXBbSCctl57fgEa+rNQ4ZbaOuBQK0MA1czmw0RrcnRlpxOkNLOcwcdlcaMgqzFOreIVLpmBHNxwtQ9NieGSmsFgW8I3Jo/4Oy30IXVy6NgGTLT7TQ29EK9bGsnecslCQK8UkThWbPpISQCAsbeMCGDNCi6pAtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771967538; c=relaxed/simple;
	bh=sx6nzEgsTL+dLPWUBvSithGjFGALJFXoQAdX5TxrXks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JZzLTxAajQk7svKXUaksjv9AwOpcmB6aA9B1oHWXTwFvkRs1y1ROjl7JNhBFAlwXLg0yIHss0ztmEHRdd2jv2vGZObOK2mrwjh8kGJYO6shmUHWhy/P1HYzoOZ8FlwkRsJRgNd7VG4H1JdzWmbz4xNq16o+WENibZGswUJB6H7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J4aA80Ml; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J4aA80Ml"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771967534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZVdjpkS6hpQa7/nbEiuJR5gXeuovddUa0HnphowMz3I=;
	b=J4aA80Ml7DEJyPbboIBKRMe851Plc6WXXrjh4pKPUZCkO8b0Qwr1L70vImVRWbVuRqZB+M
	mJEBUbqMeZe9ssgZKDnjYKC/R7PvaO9/x/ZmqhDBmYv+ZsvSJlPWSfJ7Ptz8bO62/zw6Fx
	nn6jjXXx7Y2NQgGcQvgnhjmCu6pqV0Q=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>
Cc: Mykyta Yatsenko <yatsenko@meta.com>,
	bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2] selftests/bpf: Fix flakiness of task_local_storage/sys_enter_exit
Date: Tue, 24 Feb 2026 13:12:02 -0800
Message-ID: <20260224211202.214325-1-ihor.solodrai@linux.dev>
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

v1->v2: reset skel->bss->target_pid to 0 before asserts (Amery)
v1: https://lore.kernel.org/bpf/20260224015855.1481707-1-ihor.solodrai@linux.dev/

---
 .../bpf/prog_tests/task_local_storage.c          | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index 7bee33797c71..1b26c12f255a 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -25,24 +25,30 @@
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
+	skel->bss->target_pid = 0;
+
+	/* 2x gettid syscalls */
+	ASSERT_EQ(skel->bss->enter_cnt, 2, "enter_cnt");
+	ASSERT_EQ(skel->bss->exit_cnt, 2, "exit_cnt");
 	ASSERT_EQ(skel->bss->mismatch_cnt, 0, "mismatch_cnt");
 out:
 	task_local_storage__destroy(skel);
-- 
2.53.0

