Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0973CCFA8
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 04:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790312158; cv=none; b=JrzMO4l1kWCNwpA0u8BpMnuKp0n6pOCw9bIrJ0LGb8dJH9Kbl5aexiS3YSdp8lFyCmCx/vhTQ/VnYAqcWGQnuN4ElGmpqbZOl4HPTmJfelEaJdrzX7XkIUuNCHr7K66CxVOpHDOKJzNFsv2zXkINFd8Z50+21h0zjU2XGjXi/fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790312158; c=relaxed/simple;
	bh=NfKabUNvYINKkeoVUpcXPk2+dMxpvhZjuIMqUOsPQG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCY0W2vIHJN7oGiD1Cu2CSoY7ZzTpkIhaQUV8VwQ3gIYuq/LCv+6h6OL4rmwsja+bEzE6EdhaKGPh2GMXoms9IJi4zh29SK4G8BmCN55GeeFk/DxwmSKGTubFDiF8GO7vBUdtckLQ1UfMF3pum4k6E+sPALW7twc6asGCspWJb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnUeVD//; arc=none smtp.client-ip=74.125.225.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnUeVD//"
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e66652cc3so3070365e9.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 21:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790312154; x=1790916954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LB0uwCl0W9QtyXQT/2l6PkJ1+tyQNOrHDd6qTfVty4I=;
        b=mnUeVD//WQmrR+ENBk4NcGwrvpRC+8dm1kVs5GTnvLyDs43sYtNh/JvZqT7qYiv/bn
         DIdb6RxQAPr/s2OkavvBPPGjgqoafpwkwNu3bTJ7akXNwc2u6O7gysMyTpR8d8bAtpPu
         ZXnalRDUKotg6KpkTXTRneGSOO0gmx+pyFsEaPrKMDAe6U789a3TaAh5wdyH48cxwUmD
         dO14v4sZ6Of89zdIDq+VrID3vDmizBL43mirugStudwfIZeHuH2AGjhHNzR78gd9Aj6b
         Y5I19Mon2/IQxZ9/gP0jlto611ccwFOpJrD8tw39tpsf48lLTVA2WIznMYfCQabFhLrq
         lJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790312154; x=1790916954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LB0uwCl0W9QtyXQT/2l6PkJ1+tyQNOrHDd6qTfVty4I=;
        b=aFMUFxuBsp86x10q0iscGZEkC1L2AoUH2Xe3xc2s5jYAewV8ZqCccI9z17hHxiGcYF
         eERkJljWu8OpjsyOe/7dIllb+5xLV5OZX0l1EZodnv9lqCL7BaSeTgcWmRZLlc71UO2J
         PJhri9ApG6HfnZLUmyCkUNnV6meJUyGkfu8FcjXneJBLc7/PjUrqj8vYbCeGhIHK6KzD
         TQ7nqOKT/V03cjXij4P8sSs2fO9JJyfyviwR2BX9WcGVl3cSv7f5TWqKyEQ+kseMK1t/
         kBk9DS0bNetUXNozIoDe0efvY1XdJkZGZMIn3iZTvC3AM+zFs9XdZT8FtTS27+8pl1Ss
         FJvg==
X-Gm-Message-State: AFuF++lIqqaa22CHQYIivyN+qJFK8H9JBhUZM7K9WrFGmpEC1qZ9qDZz
	qQhTDQiqefTTQRvW/w5ncKfjEsADd3YjzfklzmhD0QqnzTwMZ6Axhz8W55VXZDTg0cY=
X-Gm-Gg: AYBFou0hAorS9FKCX7SNEYOrELn4dsb4FpZ18wS69FT0CI2YyvqTt1EaeueaeaKpQ0e
	+tfb51IaLgO754KJMw/yPeMJZUWCO1sZ6fp98ilzOWTwnz/qYb3CamwDVNsV7FfGS+fjVCeXOqc
	c04p2ykIvMrmeiX5SnkFx1RFr+rvGCw1tgu8Xa68eOrA8G4CDuyQGQRmpI9ocLDPPC0BpWp2ni2
	uH5JPa1Owqp2fKepaX+4aMhSTRhIcWilWaNp+PvdCMjXGr1bxNi3O4F5Xa7pNUBgUz6pFdzDG1g
	reKPiNqP7MmmLAUV1cDymSMCNBiRnSfxzgstkqrd9RY7rfOEJ295ukxAbZSwW1OAEGNTr//M1xC
	NPqBmqQYtvhJaaLFeRvScwmJOaxXR2LGfrJ+ubEi5G+sS9FhMHnCdiK9DX4gXwQ8EgZcfVWuRGf
	FkA02K3bSZwvXpd0NS+J/wCSrNXxQR1FwJDoVEvaR82n8xA66qMOS4TLZDsiCDkFOEdc8WckV2f
	TH7rNv4ScwEJoAGbT/z9dqnjKfQN0An7pUwQ0gG19x7Ou5v2Frgc1btq+2wFbjObG52qLkNUteH
	MiZXo0qWmjNbKIZ8rzWcBRMe9idRICEACtnzOA==
X-Received: by 2002:a05:600c:34c6:b0:49e:7cff:f8ca with SMTP id 5b1f17b1804b1-49fe66f4dc9mr91310295e9.29.1790312154540;
        Thu, 24 Sep 2026 21:55:54 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff06cbd2dsm27945315e9.12.2026.09.24.21.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 21:55:52 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 5/5] selftests/bpf: Test program stream file descriptors
Date: Fri, 25 Sep 2026 06:55:32 +0200
Message-ID: <20260925045536.1480933-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925045536.1480933-1-memxor@gmail.com>
References: <20260925045536.1480933-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17238; i=memxor@gmail.com; h=from:subject; bh=NfKabUNvYINKkeoVUpcXPk2+dMxpvhZjuIMqUOsPQG8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvrv6nR3k49HxP4Tauj17Dq+KQYH97dVpAT48tsIn6qw GLb246OUhYGMS4GWTFFlpL/+5iMT1T+DrRdxg0zh5UJZAgDF6cATMTTh+GfPee0dS/bzO5pG/5R 5FJ0ZZdd5nRt+hqe1xMypGt8ojdcZ/ifqXLnvfw/9WxJhq3WpyMOL3n6sGq3/J33Oh8+XDTtODO HHwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Exercise validation and normal file semantics of BPF_PROG_STREAM_OPEN.
Cover read-only and close-on-exec state, write and lseek rejection,
non-blocking reads, partial reads, poll readiness, and a blocking reader
woken by new stream data. Also check that an empty stream write produces
neither readable data nor poll readiness.

Register the descriptor with EPOLLET, consume the initial data event
without draining buffered output, then release the program. Require a
second edge carrying POLLIN and POLLHUP, drain the buffered bytes, and
verify that poll continues to report HUP before read returns EOF. This
ensures program teardown notifies edge-triggered loops even when
readability never transitions.

Notifications are only sent when an empty stream turns readable, so also
consume the first edge of an edge-triggered descriptor, leave part of the
output behind while more arrives, drain the stream and require a new edge
for output published afterwards. This covers the transition that re-arms
notifications once readers, including partial ones, bring the count back
to zero.

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
 .../testing/selftests/bpf/prog_tests/stream.c | 486 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/stream.c    |  20 +
 2 files changed, 506 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
index 74bd15c4bfba..ae400dcfbf24 100644
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
@@ -62,6 +68,486 @@ void test_stream_syscall(void)
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
+	opts.flags = BPF_F_RDONLY;
+	fd = bpf_prog_stream_open(prog_fd, BPF_STREAM_STDOUT, &opts);
+	ASSERT_EQ(fd, -EINVAL, "access_flag");
+
+	opts.flags = 1U << 31;
+	fd = bpf_prog_stream_open(prog_fd, BPF_STREAM_STDOUT, &opts);
+	ASSERT_EQ(fd, -EINVAL, "unknown_flag");
+
+	fd = bpf_prog_stream_open(prog_fd, BPF_STREAM_STDERR, NULL);
+	if (ASSERT_OK_FD(fd, "stderr"))
+		close(fd);
+
+	stream__destroy(skel);
+}
+
+static void test_stream_fd_nonblock(void)
+{
+	LIBBPF_OPTS(bpf_prog_stream_open_opts, opts,
+		.flags = BPF_F_STREAM_NONBLOCK,
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
+	ret = lseek(fd, 0, SEEK_SET);
+	ASSERT_EQ(ret, -1, "lseek");
+	ASSERT_EQ(errno, ESPIPE, "lseek_errno");
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
+static void test_stream_fd_empty(void)
+{
+	LIBBPF_OPTS(bpf_prog_stream_open_opts, opts,
+		.flags = BPF_F_STREAM_NONBLOCK,
+	);
+	struct pollfd pfd = { .events = POLLIN | POLLHUP };
+	struct stream *skel;
+	char buf[4];
+	int fd, ret;
+
+	skel = stream__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
+		return;
+
+	fd = bpf_prog_stream_open(bpf_program__fd(skel->progs.stream_empty),
+				  BPF_STREAM_STDOUT, &opts);
+	if (!ASSERT_OK_FD(fd, "stream_open"))
+		goto out_destroy;
+	pfd.fd = fd;
+
+	/* Empty output produces neither data nor readiness. */
+	if (!stream_fd_trigger(skel->progs.stream_empty))
+		goto out_close;
+	ret = poll(&pfd, 1, 0);
+	ASSERT_EQ(ret, 0, "poll_empty_write");
+	ret = read(fd, buf, sizeof(buf));
+	ASSERT_EQ(ret, -1, "read_empty_write");
+	ASSERT_EQ(errno, EAGAIN, "read_empty_write_errno");
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
+static void test_stream_fd_edge(void)
+{
+	LIBBPF_OPTS(bpf_prog_stream_open_opts, opts,
+		.flags = BPF_F_STREAM_NONBLOCK,
+	);
+	struct epoll_event event = {
+		.events = EPOLLIN | EPOLLET,
+	};
+	struct stream *skel;
+	char buf[8] = {};
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
+	epfd = epoll_create1(EPOLL_CLOEXEC);
+	if (!ASSERT_OK_FD(epfd, "epoll_create"))
+		goto out_close;
+	event.data.fd = fd;
+	ret = epoll_ctl(epfd, EPOLL_CTL_ADD, fd, &event);
+	if (!ASSERT_OK(ret, "epoll_ctl"))
+		goto out_close;
+
+	/* Output into an empty stream raises an edge. */
+	if (!stream_fd_trigger(skel->progs.stream_syscall))
+		goto out_close;
+	ret = epoll_wait(epfd, &event, 1, 5000);
+	if (!ASSERT_EQ(ret, 1, "epoll_wait_first"))
+		goto out_close;
+	ASSERT_NEQ(event.events & EPOLLIN, 0, "epollin_first");
+
+	/*
+	 * Leave data behind, add more, then drain everything. Whether output
+	 * into a non-empty stream raises an edge of its own is not part of the
+	 * contract, so discard any pending event before re-arming the stream.
+	 */
+	ret = read(fd, buf, 2);
+	ASSERT_EQ(ret, 2, "read_partial");
+	if (!stream_fd_trigger(skel->progs.stream_syscall))
+		goto out_close;
+	ret = read(fd, buf, sizeof(buf));
+	ASSERT_EQ(ret, 4, "read_rest");
+	ASSERT_OK(memcmp(buf, "ofoo", 4), "read_rest_data");
+	ret = read(fd, buf, sizeof(buf));
+	ASSERT_EQ(ret, -1, "read_drained");
+	ASSERT_EQ(errno, EAGAIN, "read_drained_errno");
+	epoll_wait(epfd, &event, 1, 0);
+
+	/* Output into the drained stream raises an edge again. */
+	if (!stream_fd_trigger(skel->progs.stream_syscall))
+		goto out_close;
+	ret = epoll_wait(epfd, &event, 1, 5000);
+	if (!ASSERT_EQ(ret, 1, "epoll_wait_after_drain"))
+		goto out_close;
+	ASSERT_NEQ(event.events & EPOLLIN, 0, "epollin_after_drain");
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
+	if (test__start_subtest("empty"))
+		test_stream_fd_empty();
+	if (test__start_subtest("blocking"))
+		test_stream_fd_blocking();
+	if (test__start_subtest("hup"))
+		test_stream_fd_hup();
+	if (test__start_subtest("edge"))
+		test_stream_fd_edge();
+	if (test__start_subtest("nmi_epoll"))
+		test_stream_fd_nmi_epoll();
+}
+
 void test_stream_oversize(void)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, opts);
diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
index 12fc29e45487..1ae015c4e6b4 100644
--- a/tools/testing/selftests/bpf/progs/stream.c
+++ b/tools/testing/selftests/bpf/progs/stream.c
@@ -44,6 +44,7 @@ struct {
 		  _X64 _X64 _X64 _X64 _X64 _X64 _X64 _X64)
 
 int size;
+int nmi_stream_prints;
 u64 fault_addr;
 void *arena_ptr;
 
@@ -124,6 +125,25 @@ int stream_syscall(void *ctx)
 	return 0;
 }
 
+SEC("syscall")
+__success __retval(0)
+int stream_empty(void *ctx)
+{
+	return bpf_stream_printk(BPF_STDOUT, "");
+}
+
+SEC("perf_event")
+int stream_nmi(void *ctx)
+{
+	if (nmi_stream_prints)
+		return 0;
+	/* Retry on a later sample if the write failed, e.g. with -EBUSY. */
+	if (bpf_stream_printk(BPF_STDOUT, "nmi"))
+		return 0;
+	nmi_stream_prints = 1;
+	return 0;
+}
+
 SEC("syscall")
 __success __retval(0)
 int stream_oversize(void *ctx)
-- 
2.53.0

