Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A383626F293
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771006922; cv=none; b=LLldaCBFrR+E/gNAKq1Ta0k/+dYV2s3ZuucKP+1GIgcV6FI2pByyTRh3nXaqn0LgGKkcUTgJEjSJO0NfH9r8JKOHmlU21CJ3cCOT/qZw/lLnEuk3CbriPhHbOPgOv3avdx7h2V8PVOf1ZCHX/uU+eifl1MLxFFW8WECV06GiHqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771006922; c=relaxed/simple;
	bh=b6qG9EkxjWgb5lk8lrjhixv0Dssc0WySfpEN9RkT1Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=blsSkEirtzPUQCDLF6DuSeDkelUxiJ2mb+Rxi5Y0YsnvdhF+Jvju6w2ouPFW8IhTGtdK/rblH8n8vmOg5JoIPjD07FFphfL1GQ2cH2AKBfxNmAGRQ1vYIc2hOl8hu6qaceDGep5qEe94ZjeMnoqrt+QLr6S7n6JqEkOFrkKD6+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iHjtBgVU; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iHjtBgVU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771006918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BJQM94TmWpOrifxNmgYC4ZJZ4gp+CDLVgPGe/Z/I7n8=;
	b=iHjtBgVU8YxOYZ5l8wTzMLWai5UQHnypEzW3Wxq2i6lWqihN9gBKH1kA6sW32ysbfNu1/q
	5LOZNz0qu2BnRXIbWbUsNaoA8hcQT7bnjbGqiHxgYciyK2qjLiawM9LkgkACPUIqxYvE2y
	tpM58nyXtzE1i4TJTnsySTXyI3qIplU=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v1] selftests/sched_ext: Fix rt_stall flaky failure
Date: Fri, 13 Feb 2026 10:21:36 -0800
Message-ID: <20260213182136.1388270-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The rt_stall test measures the runtime ratio between an EXT and an RT
task pinned to the same CPU, verifying that the deadline server prevents
RT tasks from starving SCHED_EXT tasks. It expects the EXT task to get
at least 4% of CPU time.

The test is flaky because sched_stress_test() calls sleep(RUN_TIME)
immediately after fork(), without waiting for the RT child to complete
its setup (set_affinity + set_sched). If the RT child experiences
scheduling latency before completing setup, that delay eats into the
measurement window: the RT child runs for less than RUN_TIME seconds,
and the EXT task's measured ratio drops below the 4% threshold.

For example, in the failing CI run [1]:
  EXT=0.140s RT=4.750s total=4.890s (expected ~5.0s)
  ratio=2.86% < 4% → FAIL

The 110ms gap (5.0 - 4.89) corresponds to the RT child's setup time
being counted inside the measurement window, during which fewer
deadline server ticks fire for the EXT task.

Fix by using pipes to synchronize: each child signals the parent after
completing its setup, and the parent waits for both signals before
starting sleep(RUN_TIME). This ensures the measurement window only
counts time when both tasks are fully configured and competing.

[1] https://github.com/kernel-patches/bpf/actions/runs/21961895809/job/63442490449

Fixes: be621a76341c ("selftests/sched_ext: Add test for sched_ext dl_server")
Assisted-by: claude-opus-4-6-v1
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

---

BPF CI caught the failure, I fed the logs to Claude Code and this is
what it came up with. I ran this 3 times on CI, and the failure didn't
happen again. The change makes sense to me, although synchronization
via pipes might be an overkill?

Please let me know if this is too sloppy, I'll try to refine.

Thanks!

---
 tools/testing/selftests/sched_ext/rt_stall.c | 49 ++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/sched_ext/rt_stall.c b/tools/testing/selftests/sched_ext/rt_stall.c
index 015200f80f6e..ab772e336f86 100644
--- a/tools/testing/selftests/sched_ext/rt_stall.c
+++ b/tools/testing/selftests/sched_ext/rt_stall.c
@@ -23,6 +23,30 @@
 #define CORE_ID		0	/* CPU to pin tasks to */
 #define RUN_TIME        5	/* How long to run the test in seconds */
 
+/* Signal the parent that setup is complete by writing to a pipe */
+static void signal_ready(int fd)
+{
+	char c = 1;
+
+	if (write(fd, &c, 1) != 1) {
+		perror("write to ready pipe");
+		exit(EXIT_FAILURE);
+	}
+	close(fd);
+}
+
+/* Wait for a child to signal readiness via a pipe */
+static void wait_ready(int fd)
+{
+	char c;
+
+	if (read(fd, &c, 1) != 1) {
+		perror("read from ready pipe");
+		exit(EXIT_FAILURE);
+	}
+	close(fd);
+}
+
 /* Simple busy-wait function for test tasks */
 static void process_func(void)
 {
@@ -122,14 +146,24 @@ static bool sched_stress_test(bool is_ext)
 
 	float ext_runtime, rt_runtime, actual_ratio;
 	int ext_pid, rt_pid;
+	int ext_ready[2], rt_ready[2];
 
 	ksft_print_header();
 	ksft_set_plan(1);
 
+	if (pipe(ext_ready) || pipe(rt_ready)) {
+		perror("pipe");
+		ksft_exit_fail();
+	}
+
 	/* Create and set up a EXT task */
 	ext_pid = fork();
 	if (ext_pid == 0) {
+		close(ext_ready[0]);
+		close(rt_ready[0]);
+		close(rt_ready[1]);
 		set_affinity(CORE_ID);
+		signal_ready(ext_ready[1]);
 		process_func();
 		exit(0);
 	} else if (ext_pid < 0) {
@@ -140,8 +174,12 @@ static bool sched_stress_test(bool is_ext)
 	/* Create an RT task */
 	rt_pid = fork();
 	if (rt_pid == 0) {
+		close(ext_ready[0]);
+		close(ext_ready[1]);
+		close(rt_ready[0]);
 		set_affinity(CORE_ID);
 		set_sched(SCHED_FIFO, 50);
+		signal_ready(rt_ready[1]);
 		process_func();
 		exit(0);
 	} else if (rt_pid < 0) {
@@ -149,6 +187,17 @@ static bool sched_stress_test(bool is_ext)
 		ksft_exit_fail();
 	}
 
+	/*
+	 * Wait for both children to complete their setup (affinity and
+	 * scheduling policy) before starting the measurement window.
+	 * This prevents flaky failures caused by the RT child's setup
+	 * time eating into the measurement period.
+	 */
+	close(ext_ready[1]);
+	close(rt_ready[1]);
+	wait_ready(ext_ready[0]);
+	wait_ready(rt_ready[0]);
+
 	/* Let the processes run for the specified time */
 	sleep(RUN_TIME);
 
-- 
2.53.0

