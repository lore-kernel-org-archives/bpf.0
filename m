Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDD33BA232
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 07:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591627; cv=none; b=rTUd4Lw5UluU9zvmODBmADbcphvBoIydj6Z99wCbHf+bm96IrjETdqYd9uj5Cc7g6sMLXYcFezsdhGIQRdnVMr2R/i45FYFf26uZe9PszFw1uq8KXheoEqDaeZ1I01AIouzfwUd/A8fFRGHqorx9ntsXbxATaAO7qrwFEIEAXDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591627; c=relaxed/simple;
	bh=un4EqKSpjszRLLrGbZXIDMytQ0AUYaeYfFCHa0AmG44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pU4xhInOPwmCtnUgiMbvr/pZ7QkxMsssE1fSZ9Wn2ixv/xavTPD+LvMPf+L96fkfx13UiEJDe+Kmx8bt/Ajs0fM0IFrVrgwz/m72vKy7aSNLnwY8x6Y6HVKpc91evknu2ljDtqkxCMcdQgtgTA6rClo4r4lcU2of57eG2DaLNUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFkiRti0; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFkiRti0"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-483960225ccso527581f8f.1
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 00:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591607; x=1789196407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tUXWKB1W6LaUQmqyFFwzNQKPp+kPaUIL616ZeUs4N4M=;
        b=TFkiRti04CQKz7dKzfJq1Lh2ysQQN93sBb7etUO5PcBCRGGbOcsXIJGcDY9mwwdBfP
         xOHKEOykzjZSxstvNqyMSj3lNNhXoRAA81+zxZixSJK0Y1Qf/J1Eq9PFyDD5lEBOYQzT
         vexZNpV/ilK1pvecJOPuFONgdwVkmN6Jds4bNeNJ1vguqY3vqzzWqUQg4PT+TZoaGp7w
         jm30yjJNyboqQR4uqPLph1DtCxIBOShpB5NSlsZ+R6yHX+MMJw5DiH8DspxQUI/PUHNL
         QGJDp+IiWimzpAV/8fTuK2dqSFHNU1QC0nL7FQnJGfxg9h0r2D0DZECGEWSpo1P+T6wF
         VNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591607; x=1789196407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tUXWKB1W6LaUQmqyFFwzNQKPp+kPaUIL616ZeUs4N4M=;
        b=V9RAXL6Fa5tTTWyBIhdyJprHCAEo6zu497uoheHUXFQKEO1us4sfcimc8lGImBuiOS
         MU7uCPTcfLsZTCJc7UEQ+gxvFBlWt6PqPK2MC1HqvcEG3z0CtzRMwsl65Vxs2VdB3+fc
         f1h8JS2/poBvxgJxs4gYx4xcyxvME9PhGKoQrqGmIW2jX6pGK1QoXfWL6yb431n7lNw5
         K2PQFdelGWozdIx/i1AYm57JpaB3+tr78Qg4qd91/BLKWir9V0HzrSBvcT5NVsNGuoIr
         Vx9RmJYBPObIACXJwkmNpSp88o6DWMUCA08sGJeINQta1ORQFAIhXDNezAn2dzkKC/av
         J+uA==
X-Gm-Message-State: AFuF++mKi1dkT5rtG9i4TudjkLR1XnRQ3X57mLc5bl1QnDowlKftFHXL
	oy6BXhzIyM0PstDypCHdBGGIvrL3LqzOJYytuhnZkAcInUXkEUjX8jwkXTHW0SNU
X-Gm-Gg: AYBFou11DGIK3AqoxAJarMiJmDqlyU74tihlEzDriGOkVHooZ7F8efrnc2gA3qxnyZd
	SuQ/O2KdTGcPh/ytr0m17zZM+F3qCGJjua8Lh2mH2yJAQZOkYEUGhFuzSmSk1kvyArLB0DijEhA
	7yKs6cgSDAUIHu0COD4M8Y7GLP79xQ/OgvR6TxhRAuwyxH47E55nI3tlhDl3f69ucWmqfh/3d5Q
	fbiwtyyT8KjPHaO+EiBi4q1Ci7ZCjB36kHOcqU+Rc9utUOHJU78bA1d8/QyZu9/FxV3BvLb7wu2
	WY3lzQlx0XuAVU/7P9VPyLXAtOKc/7r8vZwLmjgLA5eTKtgKI1AuFtEvmk4AUbrx2zbd6I1nCkE
	7rZLFSaaCpKiucxD5hEar2ZzVHDbKdAUWNnwfCIQ6QwRMX4ygT8SvpsJmhejyxX7hoW+aeXtovF
	za2nlfXkqqzl8VXsXHf2OhXEmiCh+xJN7ZJ/WerINN+RYrext7p6zOUEb0rdiHd5rrVvff+HH2g
	yBOSAZRMMbt/m91tM140cXnuIjHQ3jPUfHtb3St8pBsja5cWies0SfQngD1ZOtjGSrYTazepj4J
	+hy7ZUXP98d2QVFPUCnx3Xuije1srYHDnzaHug==
X-Received: by 2002:a05:600c:c48f:b0:497:fecd:5b00 with SMTP id 5b1f17b1804b1-49cf825d507mr107310345e9.9.1788591607456;
        Sat, 05 Sep 2026 00:00:07 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee80eda4sm205794095e9.15.2026.09.05.00.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 00:00:07 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 2/8] selftests/bpf: Test killing a loader during instruction rewrites
Date: Sat,  5 Sep 2026 08:59:53 +0200
Message-ID: <20260905070003.3193366-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905070003.3193366-1-memxor@gmail.com>
References: <20260905070003.3193366-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4531; i=memxor@gmail.com; h=from:subject; bh=un4EqKSpjszRLLrGbZXIDMytQ0AUYaeYfFCHa0AmG44=; b=kA0DAAoWRy03e2NUL4MByyZiAGqbvaWhn5GWa+Nz4oFc7QiQHpXmG8iH9OvA4wLiHEiolgDJs Yh1BAAWCgAdFiEEdP++AjPIeftRPaYLRy03e2NUL4MFAmqbvaUACgkQRy03e2NUL4O7bAEAykLx y0Eru9sWSdceoGc+oOfb2gYG+VnF1gfAwdTXep4A/iBWgKHTVuDsjQ67fXX2Z4/QJ0SxxU+Jjvq zrQDjbAID
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Exercise fatal-signal handling after verifier exploration has completed. Load
a 32768-instruction control program to estimate the time needed for linear
verification, then load the same-sized program made of unconditional jumps by
zero in a child process.

The latter reaches the quadratic bpf_opt_remove_nops() rewrite. Send SIGKILL
after four control-load durations and require the child to be reaped within
one second. Without cancellation points in the rewrite helpers, the killed
child stays in BPF_PROG_LOAD until all no-ops have been removed.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/prog_load_signal.c         | 131 ++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/prog_load_signal.c

diff --git a/tools/testing/selftests/bpf/prog_tests/prog_load_signal.c b/tools/testing/selftests/bpf/prog_tests/prog_load_signal.c
new file mode 100644
index 000000000000..0f78db3bccc7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/prog_load_signal.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+
+#define NOP_CNT		32768
+#define MIN_KILL_DELAY_NS	(100ULL * 1000 * 1000)
+#define REAP_TIMEOUT_NS		(1000ULL * 1000 * 1000)
+
+static __u64 monotonic_ns(void)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	return ts.tv_sec * 1000000000ULL + ts.tv_nsec;
+}
+
+static void sleep_ns(__u64 duration)
+{
+	struct timespec ts = {
+		.tv_sec = duration / 1000000000ULL,
+		.tv_nsec = duration % 1000000000ULL,
+	};
+
+	while (nanosleep(&ts, &ts) && errno == EINTR)
+		;
+}
+
+static int waitpid_timeout(pid_t pid, int *status, __u64 timeout)
+{
+	__u64 deadline = monotonic_ns() + timeout;
+	int ret;
+
+	do {
+		ret = waitpid(pid, status, WNOHANG);
+		if (ret)
+			return ret;
+		usleep(1000);
+	} while (monotonic_ns() < deadline);
+
+	return 0;
+}
+
+void test_prog_load_signal(void)
+{
+	struct bpf_insn *insns = NULL;
+	__u64 start, control_time, kill_delay;
+	int pipefd[2] = { -1, -1 };
+	int prog_fd = -1, status = 0;
+	pid_t pid = -1;
+	char byte;
+	int i, ret;
+
+	insns = calloc(NOP_CNT + 2, sizeof(*insns));
+	if (!ASSERT_OK_PTR(insns, "calloc"))
+		return;
+
+	for (i = 0; i < NOP_CNT; i++)
+		insns[i] = BPF_MOV64_REG(BPF_REG_1, BPF_REG_1);
+	insns[NOP_CNT] = BPF_MOV64_IMM(BPF_REG_0, 0);
+	insns[NOP_CNT + 1] = BPF_EXIT_INSN();
+
+	start = monotonic_ns();
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL",
+				insns, NOP_CNT + 2, NULL);
+	control_time = monotonic_ns() - start;
+	if (!ASSERT_GE(prog_fd, 0, "control_prog_load"))
+		goto cleanup;
+	close(prog_fd);
+	prog_fd = -1;
+
+	for (i = 0; i < NOP_CNT; i++)
+		insns[i] = BPF_JMP_IMM(BPF_JA, 0, 0, 0);
+
+	if (!ASSERT_OK(pipe(pipefd), "pipe"))
+		goto cleanup;
+
+	pid = fork();
+	if (!ASSERT_GE(pid, 0, "fork"))
+		goto cleanup;
+	if (!pid) {
+		close(pipefd[0]);
+		if (write(pipefd[1], "x", 1) != 1)
+			_exit(1);
+		close(pipefd[1]);
+		prog_fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL",
+					insns, NOP_CNT + 2, NULL);
+		if (prog_fd >= 0)
+			close(prog_fd);
+		_exit(prog_fd < 0);
+	}
+
+	close(pipefd[1]);
+	pipefd[1] = -1;
+	ret = read(pipefd[0], &byte, 1);
+	if (!ASSERT_EQ(ret, 1, "child_ready"))
+		goto cleanup;
+
+	/*
+	 * Allow linear verification to finish before sending SIGKILL. The nop
+	 * removal pass is quadratic, so four control-load times still leaves a
+	 * wide window in which an affected kernel is rewriting instructions.
+	 */
+	kill_delay = MAX(control_time * 4, MIN_KILL_DELAY_NS);
+	sleep_ns(kill_delay);
+	if (!ASSERT_OK(kill(pid, SIGKILL), "kill"))
+		goto cleanup;
+
+	start = monotonic_ns();
+	ret = waitpid_timeout(pid, &status, REAP_TIMEOUT_NS);
+	if (!ASSERT_EQ(ret, pid, "prog_load_killable")) {
+		fprintf(stderr, "control load %llu us, child still alive %llu us after SIGKILL\n",
+			control_time / 1000, (monotonic_ns() - start) / 1000);
+		goto cleanup;
+	}
+	pid = -1;
+	ASSERT_TRUE(WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL,
+		    "killed_by_sigkill");
+
+cleanup:
+	if (prog_fd >= 0)
+		close(prog_fd);
+	if (pipefd[0] >= 0)
+		close(pipefd[0]);
+	if (pipefd[1] >= 0)
+		close(pipefd[1]);
+	if (pid > 0) {
+		kill(pid, SIGKILL);
+		waitpid(pid, &status, 0);
+	}
+	free(insns);
+}
-- 
2.53.0

