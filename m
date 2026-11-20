Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795164276;
	b=1d26wJXKr6UbhlOWHBEg/Vx+NtMpGza29hKrU1hD2dut9nagUCg+hUye2FvTQ++p9sW/
	 y4zxEkSXQ1YaPxC7X5S51QQKo77WJBcgHQon08ZMT2kZX71c9dkQUb1ageA16xhrqiTmZ
	 vH5Tnbogud4Sz6B//SV/Bkb9A60bDMjsyWXT+ZTIlc2QdkZwZ5xADP7uP90BIsdHjDZAp
	 2g0+jXK6W8LI57kZ+Gd6LoMENXj2lhy8BoUP1fgm6S3fxNiu4WP5xZ3wLMZLgabOQ1UiA
	 hmsz2mIBmo5foHaEhyv3cmVOgzqMWfr8v1Esxg128469/eFAROoJu9SEJIf+FvurMNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164276;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=HQ/MC2rhbtrQvM+saZG3xHAEtDy44m0IiJf1k707Apo=;
	b=PBjcc8NKhTtK9FHQ/ay0bwhcNrLmZ39mLhQdXMTR9xXXn/2eH5hANjn8XLaeql2YDosh
	 71AVdJc597i17cHEXOMb0VDLNbobo25Pjdihmn+y0KYHGM1OcaxTgQV1intT7/g3ijV4/
	 JCBXL3j52GkHupmN5nGIsFICjcbZLvkKe7y2YIbtNDLUEiMlnbscM84BXfCep3gYBen6/
	 gDQK2YevxhK8WR+ERlKERPIF2VULHZAl/JKx8x+dZAjhlnVBD2VS/YAosjsazoe5rPeWo
	 GVHP9GTG1+CqMrE+FGthg+hwO2f5He0yd/P4qohFWhscm/L3A8/NDHgN/ObutZS2nlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=azCzh2LC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609FF606A7FF;
	Fri, 20 Nov 2026 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=azCzh2LC
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795164276;
	b=fF1E77TJZTIijgyJXmiKxF0hU7vpq692yHVkgeEgCxuOjoUV8IMw6y0R32eeRRDT3XF5
	 PZY6IzgTazUeAmrWbxIOJz0qvWQoR6wJEA2CN/nkdwlM4QS1jCfaGZPzptvBDU99Asf9Z
	 4XKVyGBMIyyAxoVR/5lhX5/vi+jaj2tG2UaSeASbj0GDYBItyMt4SNgasNqswYOquclkd
	 vZ8qfLMNEx9FB0nzQGtMKHRLduNVV5WF1sXwuKZVMV9JJ4aQqz0gwVqd3cdFIyZXdz3Nb
	 BbNe3N+FHVlyubSdxS4nUXxNXCZ7w8FmWcANgfXyGkggaa8aj/sRm+FYyM9rNSuubmg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795164276;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=HQ/MC2rhbtrQvM+saZG3xHAEtDy44m0IiJf1k707Apo=;
	b=RxLvoUqWT4eoOP4ppJrUVR+N6+xXMKgKVpPp6VZpkmMHvRC33noJDUkAYURO9I2wIwhu
	 i5pjqUYDQ6krMqsEm83p4vfqRtzA7GPgRbZUKwbcgWESC+kyLC2qP3OWOq8polsigsFCL
	 gvr6zfyLGew+Wx6z7cwvV22d5/s1e6hTXEHmXhJMG6jPfGvKwYn1ZfmSgSTyFFhK2cvO0
	 Ybgfd1RfbSdauhc6wuH0QYZhuvf0o8a0HE5cedWjgnAeeqnMDU3bdaZxcIza5uXj1g6bO
	 cu4STA7fgz3B0b7IpILP6ZbS76UK6allMAcf8uNvFJlABcEnJMUojeitS2kcXSUw4/A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 50B971F000D2;
	Fri, 20 Nov 2026 08:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795164276;
	bh=HQ/MC2rhbtrQvM+saZG3xHAEtDy44m0IiJf1k707Apo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=azCzh2LCpQdwzt+n9aqxqtOpSWlGIs0svMrlhMf5qJO+Jy/Kku36/gS1nZBy7gBr/
	 i5lUo2pp63ULYuWsfSVRqfKNUCwSUnRlDg6mooSeeXJEES131nr/nHSj67oxWfS4it
	 Bhi7oYtQMko0doET4/7pxCaUiyrK+tXxecbjqkCXoUJ6V7Q8czoCyxdMOzBjmR5zHa
	 kVsISul5J7Pqb+w5DWSLKdVqVb/EGV5Rv8wFL4KRwBDNdZc2d16U5dkMq6Nmjv75y6
	 Eho+WDIPOp0h81NibvIaMA/PVw7rQhrS4unNDhaE30F3WzKlIoUvRrQY33BA0oChrL
	 OmaATEABHk42w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CCB8B497B4;
	Fri, 20 Nov 2026 08:44:34 +0000 (UTC)
From: Hang Zhengyang via B4 Relay <devnull+hang.zhengyang1010.gmail.com@kernel.org>
Date: Fri, 20 Nov 2026 16:44:23 +0800
Subject: [PATCH sched_ext/for-7.5 2/2] selftests/sched_ext: Test sync
 wakeups from an RT task
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261120-scx-fix75-v1-2-254f782ff9b0@gmail.com>
References: <20261120-scx-fix75-v1-0-254f782ff9b0@gmail.com>
In-Reply-To: <20261120-scx-fix75-v1-0-254f782ff9b0@gmail.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, Shuah Khan <shuah@kernel.org>
Cc: Kuba Piecuch <jpiecuch@google.com>, 
 Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>, 
 Hui Su <sh_def@163.com>, sched-ext@lists.linux.dev, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Hang Zhengyang <hang.zhengyang1010@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795164273; l=7737;
 i=hang.zhengyang1010@gmail.com; s=20261008; h=from:subject:message-id;
 bh=ZdH0zACDdHFIhPF1NiY9Xw4N3rcdSdQGPyZtTNXQl2k=;
 b=HdoouE0PZ48l4E/8Wqvn7vjxTSXVoGoSc+v6R02Y2sDKcoTESxDs4FwTQezq03JDJIDMSNGEO
 loIGnICLn5ZCJvWQ64oME+FiK82CmKGfx8MGoMYBffTk/3HlTyAQZR5
X-Developer-Key: i=hang.zhengyang1010@gmail.com; a=ed25519;
 pk=5drRny3PqRPLhKVB0YIQXN5YyD8miKCpXWhnEPvafAI=
X-Endpoint-Received: by B4 Relay for hang.zhengyang1010@gmail.com/20261008
 with auth_id=1133
X-Original-From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
Reply-To: hang.zhengyang1010@gmail.com
Content-Transfer-Encoding: 7bit

From: Hang Zhengyang <hang.zhengyang1010@gmail.com>

Add the sync_wake_rt test. It loads the minimal scheduler, so the
kernel picks the CPU for each wakeup.

In each round, a reader task first runs on one CPU. Then it blocks on
a pipe and may run on any usable CPU. An RT task, pinned to that first
CPU, writes to the pipe and spins until the reader has run, for at
most 300 ms.

The test fails if the reader runs on the RT task's CPU in more than 5
of 10 rounds. It is skipped if fewer than two CPUs are usable. It
checks where the reader runs, not how long it waits, because the wait
depends on the state of the ext dl_server.

Signed-off-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>
---
 tools/testing/selftests/sched_ext/Makefile       |   1 +
 tools/testing/selftests/sched_ext/sync_wake_rt.c | 257 +++++++++++++++++++++++
 2 files changed, 258 insertions(+)

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 44083f1c6596..8d2c5b5b0070 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -201,6 +201,7 @@ auto-test-targets :=			\
 	test_example			\
 	total_bw			\
 	cyclic_kick_wait		\
+	sync_wake_rt			\
 
 testcase-targets := $(addsuffix .o,$(addprefix $(SCXOBJ_DIR)/,$(auto-test-targets)))
 
diff --git a/tools/testing/selftests/sched_ext/sync_wake_rt.c b/tools/testing/selftests/sched_ext/sync_wake_rt.c
new file mode 100644
index 000000000000..54af31a17076
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/sync_wake_rt.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * An RT task wakes a task with a sync wakeup (a pipe write) and keeps
+ * running. The wakee must not be queued behind the RT task on its CPU
+ * while other CPUs are idle. Otherwise it waits until the RT task blocks
+ * or the ext dl_server runs it.
+ *
+ * The minimal scheduler has no ops.select_cpu(), so the kernel's default
+ * idle selection picks the wakee's CPU.
+ *
+ * How long the wakee waits depends on the state of the dl_server, so the
+ * test checks where the wakee runs, not how long it waits.
+ */
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <sched.h>
+#include <scx/common.h>
+#include <signal.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+#include "minimal.bpf.skel.h"
+#include "scx_test.h"
+
+#define ROUNDS		10
+#define SPIN_MS		300	/* max time the RT waker spins */
+#define SLEEP_WAIT_MS	5000	/* max time to wait for the wakee to block */
+
+struct shared {
+	int	cpu;		/* CPU the wakee ran on after read() */
+	int	ran;
+};
+
+static cpu_set_t allowed;
+static int waker_cpu;
+
+static u64 now_ns(void)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	return ts.tv_sec * 1000000000ULL + ts.tv_nsec;
+}
+
+static void spin(struct shared *sh, u64 ns)
+{
+	u64 end = now_ns() + ns;
+
+	while (!(sh && __atomic_load_n(&sh->ran, __ATOMIC_ACQUIRE)) &&
+	       now_ns() < end)
+		;
+}
+
+static int pin(int cpu)
+{
+	cpu_set_t mask;
+
+	CPU_ZERO(&mask);
+	CPU_SET(cpu, &mask);
+	return sched_setaffinity(0, sizeof(mask), &mask);
+}
+
+/* Wait until @pid is sleeping, i.e. blocked in read() */
+static bool wait_sleeping(pid_t pid)
+{
+	char path[64], buf[256], *p;
+	int i, fd;
+	ssize_t len;
+
+	snprintf(path, sizeof(path), "/proc/%d/stat", pid);
+	for (i = 0; i < SLEEP_WAIT_MS; i++) {
+		fd = open(path, O_RDONLY);
+		if (fd < 0)
+			return false;
+		len = read(fd, buf, sizeof(buf) - 1);
+		close(fd);
+		if (len <= 0)
+			return false;
+		buf[len] = '\0';
+		p = strrchr(buf, ')');
+		if (p && p[1] == ' ' && p[2] == 'S')
+			return true;
+		usleep(1000);
+	}
+	return false;
+}
+
+static bool reap(pid_t pid)
+{
+	int status;
+
+	return waitpid(pid, &status, 0) == pid && WIFEXITED(status) &&
+	       !WEXITSTATUS(status);
+}
+
+/*
+ * One round. The wakee first runs on waker_cpu, so that waker_cpu is its
+ * prev_cpu. Then it blocks on a pipe and may run on any allowed CPU. The
+ * RT waker, pinned to waker_cpu, writes to the pipe and spins until the
+ * wakee has run, for at most SPIN_MS. Returns the CPU the wakee ran on,
+ * or -1 on error.
+ */
+static int one_round(struct shared *sh)
+{
+	struct sched_param param = { .sched_priority = 1 };
+	int ret = -1;
+	pid_t wakee, waker;
+	int pipefd[2];
+	char c = 0;
+	bool ok;
+
+	memset(sh, 0, sizeof(*sh));
+	if (pipe(pipefd))
+		return -1;
+
+	wakee = fork();
+	if (wakee < 0)
+		goto out_close;
+	if (wakee == 0) {
+		close(pipefd[1]);
+		if (pin(waker_cpu))
+			_exit(1);
+		spin(NULL, 1000000);
+		if (sched_setaffinity(0, sizeof(allowed), &allowed) ||
+		    read(pipefd[0], &c, 1) != 1)
+			_exit(1);
+		sh->cpu = sched_getcpu();
+		__atomic_store_n(&sh->ran, 1, __ATOMIC_RELEASE);
+		_exit(0);
+	}
+
+	if (!wait_sleeping(wakee)) {
+		kill(wakee, SIGKILL);
+		reap(wakee);
+		goto out_close;
+	}
+
+	waker = fork();
+	if (waker < 0) {
+		kill(wakee, SIGKILL);
+		reap(wakee);
+		goto out_close;
+	}
+	if (waker == 0) {
+		close(pipefd[0]);
+		if (pin(waker_cpu) ||
+		    sched_setscheduler(0, SCHED_FIFO, &param))
+			_exit(1);
+		if (write(pipefd[1], &c, 1) != 1)
+			_exit(1);
+		spin(sh, SPIN_MS * 1000000ULL);
+		_exit(0);
+	}
+
+	close(pipefd[0]);
+	close(pipefd[1]);
+	ok = reap(waker);
+	ok = reap(wakee) && ok;
+	if (ok)
+		ret = sh->cpu;
+	return ret;
+
+out_close:
+	close(pipefd[0]);
+	close(pipefd[1]);
+	return -1;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct minimal *skel;
+
+	SCX_FAIL_IF(sched_getaffinity(0, sizeof(allowed), &allowed),
+		    "Failed to get CPU affinity");
+	if (CPU_COUNT(&allowed) < 2) {
+		fprintf(stderr, "Skipping: requires at least 2 usable CPUs\n");
+		return SCX_TEST_SKIP;
+	}
+	for (waker_cpu = 0; !CPU_ISSET(waker_cpu, &allowed); waker_cpu++)
+		;
+
+	skel = minimal__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	if (minimal__load(skel)) {
+		SCX_ERR("Failed to load skel");
+		minimal__destroy(skel);
+		return SCX_TEST_FAIL;
+	}
+
+	*ctx = skel;
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	enum scx_test_status status = SCX_TEST_PASS;
+	struct minimal *skel = ctx;
+	struct bpf_link *link;
+	struct shared *sh;
+	int i, cpu, stacked = 0;
+
+	sh = mmap(NULL, sizeof(*sh), PROT_READ | PROT_WRITE,
+		  MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	SCX_FAIL_IF(sh == MAP_FAILED, "Failed to mmap");
+
+	link = bpf_map__attach_struct_ops(skel->maps.minimal_ops);
+	if (!link) {
+		SCX_ERR("Failed to attach scheduler");
+		status = SCX_TEST_FAIL;
+		goto out_unmap;
+	}
+
+	for (i = 0; i < ROUNDS; i++) {
+		cpu = one_round(sh);
+		if (cpu < 0) {
+			SCX_ERR("Round %d failed", i);
+			status = SCX_TEST_FAIL;
+			goto out_destroy;
+		}
+		if (cpu == waker_cpu)
+			stacked++;
+	}
+
+	/*
+	 * Allow a few rounds on waker_cpu: if no CPU is idle, the wakee can
+	 * still end up there.
+	 */
+	if (stacked > ROUNDS / 2) {
+		SCX_ERR("Wakee ran on the RT waker's CPU in %d of %d rounds",
+			stacked, ROUNDS);
+		status = SCX_TEST_FAIL;
+	}
+
+out_destroy:
+	bpf_link__destroy(link);
+out_unmap:
+	munmap(sh, sizeof(*sh));
+	return status;
+}
+
+static void cleanup(void *ctx)
+{
+	minimal__destroy(ctx);
+}
+
+struct scx_test sync_wake_rt = {
+	.name = "sync_wake_rt",
+	.description = "Verify that a sync wakeup from an RT task doesn't stack the wakee",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&sync_wake_rt)

-- 
2.53.0


