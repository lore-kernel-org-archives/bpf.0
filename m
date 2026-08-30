Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9063A784A
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 09:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788082531; cv=none; b=oiAQWhUlJdu83LNLXRiPqfseJGM4F8hl1AIZFgF0Fj/61yVpCxDMmxpXFCdG/7TNOrN8RMXS+ueUB+8z6IipljZuu4JKlgL4zpWZsSkO56x6G+6IWKQ9oHaxF1I0wR6CY/N06r3KQYE1/+me4+wQTAmGFIz6YRlJY/HDZBvkJxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788082531; c=relaxed/simple;
	bh=iGrwkdWvO8xcRwemNZZQNXdi6WKNcX5NB8lj5Pgt9VE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCBKkTz+0RMeL/CHOX6TGu9NrudzEXPi352VINPpV2tEGo5Zi1EugR+Z/uRsdsBGf8YY4YRlKanKwM7oVTkCVff79wvSD0uwosWh4CRuaMMnIrBnPh22eaIeeIN5ZLsRiAUFSMsoX5IYvdam2mvlchR0hVhMDCcpCFBwq2lOiwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXRSVl4t; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXRSVl4t"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49556ce3549so16061025e9.0
        for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 02:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788082527; x=1788687327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a23SJjVI0hmCxzfTu3GF1uYATMOyyZF7TsSoKvTZeq0=;
        b=fXRSVl4tmKgFm/SkzBuTxogw5Sof/QBVM8w2kuFumnQ8rGsiNZNxHY5iWhpkbuzpM6
         AuVcVftO0ZBG4+BHnog0ZQt0t9T94TGV8+cRDvPcnL3Ojfz8Le+vLjj7DEt+1Bez/5Mc
         4AVqmiT8HXIXP5uOiTwL9bAlk+V6Os2HENcfp+0AmwLd1qgTfN1Gho8awMjXQVKH/jkq
         cN2exGXH//DuSuUW+DHcVhNUHQGcOJinUiSbmOk6/SIUq5U9ScDWgCmZaoUgU189pUHG
         pjn2jXKBuGB19jS1G9Ac6ExgIH7Hf6FVYgx6wLv4l/1CTfWcGYE2wC45LbzjGCBhiB3k
         R1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788082527; x=1788687327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a23SJjVI0hmCxzfTu3GF1uYATMOyyZF7TsSoKvTZeq0=;
        b=Yb+gJ4haXZiXaiD9pYzSjJjERdsNPq4IO+QreNOqnTkIwx2VXRlfTUoeKWWkHRvzJe
         LIE3eWbIpzgIxBzEa1Pd1OwDWC6hNu+n6ep8j3ssGFtAY7EJoJEf1UHJ0ULo19YqQ+SX
         WvJuUjdaGYM48CaFlYHm1pnrhV+m8xwFZDQDn1GQ3nYiHRQHv8u94vk/SebM6KIxFdq9
         14dXqPbGSxpIMnR+9rNgP8VQ5ehViGdQvox3V9NFV5SuUpYn18wdfAPIGqRGuxAvIJJ6
         1U85yTm7zu4X3QJguqvT6x4Ci6lGF2Rm3i9vGzHTlnijCeOZOwVddnlPLwm7GP5N2v7U
         IOPg==
X-Gm-Message-State: AFuF++mL42KIYtuPjp2CnJUjcc6d5cEWKL3dsPJVikNdrZBM5xc/mtFE
	M9paXtsQjeiOejkSyxP3p4H8+UDAXkTWm1mEo9zXWQA7NL1QlOr3lBePSuIYpVLLYR0=
X-Gm-Gg: AR+sD10FMGjwxzuMbgVdZ862MeY6FdBL2zBNVK2RJ5lANVs8gIlMS+1OI4A575KEJ2v
	imIUtdEB+FsQJcPEq0KUn9guV43tTB0iG4/sCP+MrwqqxDghWpMzGXqjM1TDJOOgc+OvVbvgT0r
	IOnTSQITgu4E8KEpv/MEmC/JE+0jz/o+8Imy1ZnyRXPc02F+Ic5CHsNIFkGI/jKbcFlcAB17FDS
	XMLJskWLJ7v0I4OlTODP7rJlaT4UFNXlqe2i05tFWwyx5YDhLuMoTf9Rj98UKUghmVXRj1sMcWs
	dFFIwWIDKr+dmxPQsrkLb2GaR4490fGQLXPNkmPl8Mi8jFMGchNJetLcCg49Hsf0tGPxQyvPXC2
	iqMrsbjbW1Io9aptaoa2mHT56zZ0vA+Jfz4uwwg9czLjj/hVxRYV7fpjUJD6a/KiM4UB39wIytB
	wCrCTlqnQX//miPXw67NqukqfJa3j6QloZyy1j9Pah7EAssHaJ6YbL627P1Ydz2S8VVsbTUVoiv
	Nd+kS/6MNMXP5O9xhS5Bs4wazgGFfgkAmJyZQGZQYcy1zl3wdlK43TS+4vx+KD5rNphadsN4IKJ
	0N7GqKy/n0mBHTdThCGl3p8KCN7AE6L56vPMCw==
X-Received: by 2002:a05:600c:34d2:b0:49c:cbad:1c44 with SMTP id 5b1f17b1804b1-49ccbad1cf1mr159803015e9.6.1788082527364;
        Sun, 30 Aug 2026 02:35:27 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b94dd2517sm195444235e9.7.2026.08.30.02.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 02:35:26 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 6/6] selftests/bpf: Test program stream file descriptors
Date: Sun, 30 Aug 2026 11:35:11 +0200
Message-ID: <20260830093514.4105972-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260830093514.4105972-1-memxor@gmail.com>
References: <20260830093514.4105972-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13186; i=memxor@gmail.com; h=from:subject; bh=iGrwkdWvO8xcRwemNZZQNXdi6WKNcX5NB8lj5Pgt9VE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvyx23ib4T3vAn6cM/hjZde3P7v3555/DvG7c759ePfN CmnxArHjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAExkhhgjw0SnAHammdovZn+L aE89sngGz9ryXUpZ8w+bXm7LPc8j+pDhn8bqmkcTSkRZ7ZdcPCx8ReLnb76ulGk79jz0kj811TX tORsA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Exercise validation and normal file semantics of BPF_PROG_STREAM_OPEN.
Cover read-only and close-on-exec state, write rejection, non-blocking
reads, partial reads, poll readiness, and a blocking reader woken by new
stream data.

Register the descriptor with EPOLLET, consume the initial data event
without draining buffered output, then release the program. Require a
second edge carrying POLLIN and POLLHUP, drain the buffered bytes, and
verify that poll continues to report HUP before read returns EOF. This
ensures program teardown notifies edge-triggered loops even when
readability never transitions.

Also block a reader on an empty live stream, release the program, and
verify that it wakes and returns EOF. This directly covers the teardown
wait condition and its no-lost-wakeup ordering.

Finally, attach a stream-writing program to a hardware perf event and
busy-poll its epoll registration until output arrives. This both drives the
per-thread event into NMI context and directly verifies that the deferred
irq_work notification reaches epoll, without a separate BSS completion
handshake.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/stream.c | 376 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/stream.c    |  10 +
 2 files changed, 386 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
index 74bd15c4bfba..655aab35c03e 100644
--- a/tools/testing/selftests/bpf/prog_tests/stream.c
+++ b/tools/testing/selftests/bpf/prog_tests/stream.c
@@ -1,11 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
 #include <test_progs.h>
+#include <linux/perf_event.h>
+#include <poll.h>
+#include <sys/epoll.h>
 #include <sys/mman.h>
+#include <sys/syscall.h>
 
 #include "stream.skel.h"
 #include "stream_fail.skel.h"
 
+#define NMI_TIMEOUT_NS (5ULL * 1000 * 1000 * 1000)
+
 void test_stream_failure(void)
 {
 	RUN_TESTS(stream_fail);
@@ -62,6 +68,376 @@ void test_stream_syscall(void)
 	stream__destroy(skel);
 }
 
+static bool stream_fd_trigger(struct bpf_program *prog)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int ret;
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
+	return ASSERT_OK(ret, "test_run") && ASSERT_OK(opts.retval, "retval");
+}
+
+static void test_stream_fd_open(void)
+{
+	LIBBPF_OPTS(bpf_prog_stream_open_opts, opts);
+	struct stream *skel;
+	int fd, prog_fd;
+
+	skel = stream__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
+		return;
+
+	prog_fd = bpf_program__fd(skel->progs.stream_syscall);
+	fd = bpf_prog_stream_open(0, BPF_STREAM_STDOUT, NULL);
+	ASSERT_EQ(fd, -EINVAL, "bad_prog_fd");
+
+	fd = bpf_prog_stream_open(prog_fd, 0, NULL);
+	ASSERT_EQ(fd, -ENOENT, "bad_stream_id");
+
+	opts.flags = BPF_F_WRONLY;
+	fd = bpf_prog_stream_open(prog_fd, BPF_STREAM_STDOUT, &opts);
+	ASSERT_EQ(fd, -EINVAL, "writable");
+
+	opts.flags = 1U << 31;
+	fd = bpf_prog_stream_open(prog_fd, BPF_STREAM_STDOUT, &opts);
+	ASSERT_EQ(fd, -EINVAL, "unknown_flag");
+
+	opts.flags = BPF_F_RDONLY;
+	fd = bpf_prog_stream_open(prog_fd, BPF_STREAM_STDERR, &opts);
+	if (ASSERT_OK_FD(fd, "readonly"))
+		close(fd);
+
+	stream__destroy(skel);
+}
+
+static void test_stream_fd_nonblock(void)
+{
+	LIBBPF_OPTS(bpf_prog_stream_open_opts, opts,
+		.flags = BPF_F_RDONLY | BPF_F_STREAM_NONBLOCK,
+	);
+	struct pollfd pfd = { .events = POLLIN | POLLHUP };
+	struct stream *skel;
+	char buf[4] = {};
+	int fd, flags, ret;
+
+	skel = stream__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
+		return;
+
+	fd = bpf_prog_stream_open(bpf_program__fd(skel->progs.stream_syscall),
+				  BPF_STREAM_STDOUT, &opts);
+	if (!ASSERT_OK_FD(fd, "stream_open"))
+		goto out_destroy;
+	pfd.fd = fd;
+
+	flags = fcntl(fd, F_GETFD);
+	ASSERT_GE(flags, 0, "getfd");
+	ASSERT_NEQ(flags & FD_CLOEXEC, 0, "cloexec");
+	flags = fcntl(fd, F_GETFL);
+	ASSERT_GE(flags, 0, "getfl");
+	ASSERT_EQ(flags & O_ACCMODE, O_RDONLY, "readonly");
+	ASSERT_NEQ(flags & O_NONBLOCK, 0, "nonblock");
+
+	ret = write(fd, "x", 1);
+	ASSERT_EQ(ret, -1, "write");
+	ASSERT_EQ(errno, EBADF, "write_errno");
+
+	ret = poll(&pfd, 1, 0);
+	ASSERT_EQ(ret, 0, "poll_empty");
+	ret = read(fd, buf, sizeof(buf));
+	ASSERT_EQ(ret, -1, "read_empty");
+	ASSERT_EQ(errno, EAGAIN, "read_empty_errno");
+
+	if (!stream_fd_trigger(skel->progs.stream_syscall))
+		goto out_close;
+	ret = poll(&pfd, 1, 0);
+	ASSERT_EQ(ret, 1, "poll_data");
+	ASSERT_NEQ(pfd.revents & POLLIN, 0, "pollin");
+	ASSERT_EQ(pfd.revents & POLLHUP, 0, "no_pollhup");
+
+	ret = read(fd, buf, 2);
+	ASSERT_EQ(ret, 2, "read_first");
+	ASSERT_OK(memcmp(buf, "fo", 2), "read_first_data");
+	pfd.revents = 0;
+	ret = poll(&pfd, 1, 0);
+	ASSERT_EQ(ret, 1, "poll_partial");
+	ASSERT_NEQ(pfd.revents & POLLIN, 0, "pollin_partial");
+
+	ret = read(fd, buf, sizeof(buf));
+	ASSERT_EQ(ret, 1, "read_rest");
+	ASSERT_EQ(buf[0], 'o', "read_rest_data");
+	ret = read(fd, buf, sizeof(buf));
+	ASSERT_EQ(ret, -1, "read_drained");
+	ASSERT_EQ(errno, EAGAIN, "read_drained_errno");
+
+out_close:
+	close(fd);
+out_destroy:
+	stream__destroy(skel);
+}
+
+struct stream_fd_read_ctx {
+	int fd;
+	ssize_t ret;
+	char buf[4];
+};
+
+static void *stream_fd_read_thread(void *arg)
+{
+	struct stream_fd_read_ctx *ctx = arg;
+
+	ctx->ret = read(ctx->fd, ctx->buf, sizeof(ctx->buf));
+	return NULL;
+}
+
+static int stream_fd_timed_join(pthread_t thread)
+{
+	struct timespec timeout;
+
+	clock_gettime(CLOCK_REALTIME, &timeout);
+	timeout.tv_sec += 5;
+	return pthread_timedjoin_np(thread, NULL, &timeout);
+}
+
+static void test_stream_fd_blocking(void)
+{
+	struct stream_fd_read_ctx ctx = {};
+	struct stream *skel;
+	pthread_t thread;
+	bool thread_live = false;
+	int fd, flags, ret;
+
+	skel = stream__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
+		return;
+
+	fd = bpf_prog_stream_open(bpf_program__fd(skel->progs.stream_syscall),
+				  BPF_STREAM_STDOUT, NULL);
+	if (!ASSERT_OK_FD(fd, "stream_open"))
+		goto out_destroy;
+	ctx.fd = fd;
+
+	flags = fcntl(fd, F_GETFL);
+	ASSERT_GE(flags, 0, "getfl");
+	ASSERT_EQ(flags & O_NONBLOCK, 0, "blocking");
+
+	ret = pthread_create(&thread, NULL, stream_fd_read_thread, &ctx);
+	if (!ASSERT_OK(ret, "pthread_create"))
+		goto out_close;
+	thread_live = true;
+
+	usleep(50000);
+	ret = pthread_tryjoin_np(thread, NULL);
+	if (!ASSERT_EQ(ret, EBUSY, "read_blocks")) {
+		thread_live = ret != 0;
+		goto out_thread;
+	}
+	if (!stream_fd_trigger(skel->progs.stream_syscall))
+		goto out_thread;
+
+	ret = stream_fd_timed_join(thread);
+	if (!ASSERT_OK(ret, "pthread_join"))
+		goto out_thread;
+	thread_live = false;
+	ASSERT_EQ(ctx.ret, 3, "read_len");
+	ASSERT_OK(memcmp(ctx.buf, "foo", 3), "read_data");
+
+	memset(&ctx, 0, sizeof(ctx));
+	ctx.fd = fd;
+	ret = pthread_create(&thread, NULL, stream_fd_read_thread, &ctx);
+	if (!ASSERT_OK(ret, "pthread_create_eof"))
+		goto out_close;
+	thread_live = true;
+
+	usleep(50000);
+	ret = pthread_tryjoin_np(thread, NULL);
+	if (!ASSERT_EQ(ret, EBUSY, "read_eof_blocks")) {
+		thread_live = ret != 0;
+		goto out_thread;
+	}
+
+	stream__destroy(skel);
+	skel = NULL;
+	ret = stream_fd_timed_join(thread);
+	if (!ASSERT_OK(ret, "pthread_join_eof"))
+		goto out_thread;
+	thread_live = false;
+	ASSERT_EQ(ctx.ret, 0, "read_eof");
+
+out_thread:
+	if (thread_live) {
+		stream__destroy(skel);
+		skel = NULL;
+		ret = stream_fd_timed_join(thread);
+		if (ret) {
+			pthread_cancel(thread);
+			pthread_join(thread, NULL);
+		}
+	}
+out_close:
+	close(fd);
+out_destroy:
+	stream__destroy(skel);
+}
+
+static void test_stream_fd_hup(void)
+{
+	LIBBPF_OPTS(bpf_prog_stream_open_opts, opts,
+		.flags = BPF_F_STREAM_NONBLOCK,
+	);
+	struct epoll_event event = {
+		.events = EPOLLIN | EPOLLET,
+	};
+	struct pollfd pfd = { .events = POLLIN | POLLHUP };
+	struct stream *skel;
+	char buf[4] = {};
+	int epfd = -1, fd, ret;
+
+	skel = stream__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
+		return;
+
+	fd = bpf_prog_stream_open(bpf_program__fd(skel->progs.stream_syscall),
+				  BPF_STREAM_STDOUT, &opts);
+	if (!ASSERT_OK_FD(fd, "stream_open"))
+		goto out_destroy;
+	pfd.fd = fd;
+	epfd = epoll_create1(EPOLL_CLOEXEC);
+	if (!ASSERT_OK_FD(epfd, "epoll_create"))
+		goto out_close;
+	event.data.fd = fd;
+	ret = epoll_ctl(epfd, EPOLL_CTL_ADD, fd, &event);
+	if (!ASSERT_OK(ret, "epoll_ctl"))
+		goto out_close;
+
+	if (!stream_fd_trigger(skel->progs.stream_syscall))
+		goto out_close;
+	ret = epoll_wait(epfd, &event, 1, 5000);
+	if (!ASSERT_EQ(ret, 1, "epoll_wait_data"))
+		goto out_close;
+	ASSERT_NEQ(event.events & EPOLLIN, 0, "epollin");
+	ASSERT_EQ(event.events & EPOLLHUP, 0, "no_epollhup");
+
+	stream__destroy(skel);
+	skel = NULL;
+	event.events = 0;
+	ret = epoll_wait(epfd, &event, 1, 5000);
+	if (!ASSERT_EQ(ret, 1, "epoll_wait_hup"))
+		goto out_close;
+	ASSERT_NEQ(event.events & EPOLLIN, 0, "epollin_with_hup");
+	ASSERT_NEQ(event.events & EPOLLHUP, 0, "epollhup");
+
+	ret = read(fd, buf, sizeof(buf));
+	ASSERT_EQ(ret, 3, "read_buffered");
+	ASSERT_OK(memcmp(buf, "foo", 3), "read_buffered_data");
+	pfd.revents = 0;
+	ret = poll(&pfd, 1, 0);
+	ASSERT_EQ(ret, 1, "poll_drained_hup");
+	ASSERT_EQ(pfd.revents & POLLIN, 0, "no_pollin_after_drain");
+	ASSERT_NEQ(pfd.revents & POLLHUP, 0, "pollhup_after_drain");
+	ret = read(fd, buf, sizeof(buf));
+	ASSERT_EQ(ret, 0, "read_eof");
+
+out_close:
+	if (epfd >= 0)
+		close(epfd);
+	close(fd);
+out_destroy:
+	stream__destroy(skel);
+}
+
+static void test_stream_fd_nmi_epoll(void)
+{
+	LIBBPF_OPTS(bpf_prog_stream_open_opts, opts,
+		.flags = BPF_F_STREAM_NONBLOCK,
+	);
+	struct perf_event_attr attr = {
+		.size = sizeof(attr),
+		.type = PERF_TYPE_HARDWARE,
+		.config = PERF_COUNT_HW_CPU_CYCLES,
+		.freq = 1,
+		.sample_freq = 10,
+	};
+	struct epoll_event event = {
+		.events = EPOLLIN,
+	};
+	struct bpf_link *link = NULL;
+	struct stream *skel;
+	__u64 deadline;
+	char buf[4] = {};
+	int epfd = -1, fd = -1, pmu_fd = -1;
+	int ret;
+
+	skel = stream__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
+		return;
+	fd = bpf_prog_stream_open(bpf_program__fd(skel->progs.stream_nmi),
+				  BPF_STREAM_STDOUT, &opts);
+	if (!ASSERT_OK_FD(fd, "stream_open"))
+		goto out;
+
+	epfd = epoll_create1(EPOLL_CLOEXEC);
+	if (!ASSERT_OK_FD(epfd, "epoll_create"))
+		goto out;
+	event.data.fd = fd;
+	ret = epoll_ctl(epfd, EPOLL_CTL_ADD, fd, &event);
+	if (!ASSERT_OK(ret, "epoll_ctl"))
+		goto out;
+
+	pmu_fd = syscall(__NR_perf_event_open, &attr, 0, -1, -1,
+			 PERF_FLAG_FD_CLOEXEC);
+	if (pmu_fd < 0 && (errno == ENOENT || errno == EOPNOTSUPP)) {
+		printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n", __func__);
+		test__skip();
+		goto out;
+	}
+	if (!ASSERT_GE(pmu_fd, 0, "perf_event_open"))
+		goto out;
+
+	link = bpf_program__attach_perf_event(skel->progs.stream_nmi, pmu_fd);
+	if (!ASSERT_OK_PTR(link, "attach_perf_event")) {
+		link = NULL;
+		goto out;
+	}
+	pmu_fd = -1;
+
+	deadline = get_time_ns() + NMI_TIMEOUT_NS;
+	do {
+		ret = epoll_wait(epfd, &event, 1, 0);
+	} while (ret == 0 && get_time_ns() < deadline);
+	if (!ASSERT_EQ(ret, 1, "epoll_wait"))
+		goto out;
+	ASSERT_NEQ(event.events & EPOLLIN, 0, "epollin");
+
+	ret = read(fd, buf, sizeof(buf));
+	ASSERT_EQ(ret, 3, "read_len");
+	ASSERT_OK(memcmp(buf, "nmi", 3), "read_data");
+
+out:
+	bpf_link__destroy(link);
+	if (pmu_fd >= 0)
+		close(pmu_fd);
+	if (epfd >= 0)
+		close(epfd);
+	if (fd >= 0)
+		close(fd);
+	stream__destroy(skel);
+}
+
+void test_stream_fd(void)
+{
+	if (test__start_subtest("open"))
+		test_stream_fd_open();
+	if (test__start_subtest("nonblock"))
+		test_stream_fd_nonblock();
+	if (test__start_subtest("blocking"))
+		test_stream_fd_blocking();
+	if (test__start_subtest("hup"))
+		test_stream_fd_hup();
+	if (test__start_subtest("nmi_epoll"))
+		test_stream_fd_nmi_epoll();
+}
+
 void test_stream_oversize(void)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, opts);
diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
index 12fc29e45487..00843127bca8 100644
--- a/tools/testing/selftests/bpf/progs/stream.c
+++ b/tools/testing/selftests/bpf/progs/stream.c
@@ -44,6 +44,7 @@ struct {
 		  _X64 _X64 _X64 _X64 _X64 _X64 _X64 _X64)
 
 int size;
+int nmi_stream_prints;
 u64 fault_addr;
 void *arena_ptr;
 
@@ -124,6 +125,15 @@ int stream_syscall(void *ctx)
 	return 0;
 }
 
+SEC("perf_event")
+int stream_nmi(void *ctx)
+{
+	if (nmi_stream_prints)
+		return 0;
+	nmi_stream_prints = 1;
+	return bpf_stream_printk(BPF_STDOUT, "nmi");
+}
+
 SEC("syscall")
 __success __retval(0)
 int stream_oversize(void *ctx)
-- 
2.53.0

