Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF226434987
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895389; cv=pass; b=WN9BQqPl4xKj8LP5kQpPllDvuVuEkCWg5tcFpswPFzmRN8OF4i9GBOGnTEXfhCx1O0/bPWAkeLRzN87ljsjqVDGF+0yO/xriFM1CG+nOV9ni9dTQiMl8/7PrFwRM/KfH7fakPJXOqJhhBhyNrc5yo8wgh89hUqb6T6E3gbuZob8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895389; c=relaxed/simple;
	bh=4JN5uHv7YA4XAJtfBQUk8LQw6RtCsdPvHtBR5xTSBAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEDXgP/EdOG4Rv106ilpSk+3dFUjzeZVwwWOGE6+86zqcyg6vuA5vYK4iPcc+XJ7kVcgxQgzSDKIVT57mQgtJ8irRRPryNUEgDaFzbqMRChiIZAnZQxZ9RQL5fm0DmCyGy04/oS3FmeonbQBo8fSa+biUwVKBhAxWr7N3j8amnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=x9+Enluy; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="x9+Enluy"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-861feb6d61bso46254457b3.2
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 12:23:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788895386; cv=none;
        d=google.com; s=arc-20260327;
        b=BrTDJo/0Eblytiy2j6PRsbm7r16UCxzQ91hNWalgJYus37F2J5yQbAd8uFI9VFQOAR
         hUlsCR7OHkq4m43zlvZsH579MAOxoZTgX8xtu5RbNjeO+iRFD/juGqQCObV3Fw7+b+PO
         6W0u6B1hsncJaTwlBYZL/5RZpfTxsmwuaCuw9y1jSoMkYCmegA/pGq1/9WffmOgMnFC2
         OauPiIiPm+N5n7HM1Za7C2fWAyu1/EO7xp8ErfhKDSmW5KYDIYkVZtN2t9i1jeLfeGNg
         kYhsZf6oIcnFODBTgYk1e4JBy7PwKt8pW9Ga4pxr5atO1iTWGZlCQa+GHacIXHiKoue9
         etJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v0jtJ3/aidmwiFpGwyFoV7+yGhMcXuq2qVW41qstQcw=;
        fh=5bG9Ph3wKY1cq0b9UgO3oml+l2PwNGRHDr56ATb400I=;
        b=LWpuFzztXyP1J6ImaSJHm3XN3ysdpW3BIiUesKTrqyHSueWUUkGTlmGn912z8SmWYa
         9VgUGNz7CNcDZZcb98sYEEMamS8ZvsEfzQ+Cd8VcvyboK3p8vLEzm0oZjF9oxlEINR94
         HUiBMCiHZaDXOU/8bMPtueuWaZ3rLkvk6SXHxUorsUQc0RPHjXRoeybm39eukIx4sBof
         pig363q/kNkOsKYKd3ExvR/hzhU1fkzvpoUdd4MXh+81pSdbwFqGJHuEoepK1QAgq6qN
         hVa64ZilXk65w1KaRfVTlUV5bRwj7JRCzYeev+jv6s1N5k9EQ9KurTjLQaDu88dQhyw8
         iZvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788895386; x=1789500186; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v0jtJ3/aidmwiFpGwyFoV7+yGhMcXuq2qVW41qstQcw=;
        b=x9+EnluyrD+1nYXLQX2Ncgp0nY+3xcin/NRSPkzIVjPvg7QYwvsddGsKtLCGQbTbDc
         xGyPBcQZC/q6wcmcH61ZmxZ5fm0G5NwT4Q+UMrs+vH2ZMWVl3sjGX3ZFYWeSnFTAB2sE
         KetFC/v8GzZAarnvYVdBW/WKwbqMv000oPs3TQ/uD6PaYOj8czR2CNl8LlN0K/U+N80t
         N+v4o/7x8z0Tie/CGGoj7DEs3hfuj2gKlz8f4kgQzO+2bNu0YqGpbKKRjNxSxx36xCZG
         rp65TQK0lruwj0CxvjHbd/hi044FdG9RjOn4uQmnzgyo7EC6645HqHl/KzKsNDKex9H1
         mlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788895386; x=1789500186;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v0jtJ3/aidmwiFpGwyFoV7+yGhMcXuq2qVW41qstQcw=;
        b=l4Gc2iNNrcA0QXFROxN/mphBwYJVu1vWzOmwgbeR9JgDHVG29J/UB0etAvB62EQfc0
         z8wVhcV6nPl0myvQNCMbiAnvINrjl58YxayLo0d6NvF9wW66Q6adphSgHWJvFGo6RTN3
         gWCdwF+YKTg4UMn+6OxLzGAYL8C9TywQBhbYtutAZTpqvjgSBPscz8bWpnqwjKvboOXd
         5b3xtKgREpZ5oBKR+D0ZJH6JwBelQhm0mAwEFrn+9In+D1t8R5e7cpsTOn3ZdRWJm/gC
         fPUPF4ONqenEesix65BLTusZ3qMsfPZkF4Glx6WQe/rILG9IV7zeokMHJYXiJfo8m98E
         f5gA==
X-Gm-Message-State: AFuF++lnvGbUFFAd6CYryWp6rIPRe8zNFIV3OewJaWBZGBS9nJaJsWu3
	x2aZlf5zxMYeRjTcvjIKBLNiYV3ZzhvEk7lINKMBUyTWGl6Rx11ERy1p4gwap/mSqwGP/CZHVTB
	+6FDy6EK6mdKG5yavamnmRMHsSvrkqoClFO0S3FGewQ==
X-Gm-Gg: AYBFou0PHCMdOdpJIkjNX2sfTvckZ5ivqLX8J5c+HobzD1TBashLIEIyySX3US7g2uR
	ynN1J236c0I1NqXKWkbOAoPNPbnoroAA425WLebFSCxpTeh3SXLUONblw2fNqS3SH2sWNVVNqJF
	951YS2o519Xlmp5hkiCGHrHgNjRxvAD2pMLcIO+Wa1UWVuIuxQptsns7O/8fQAxSLIcZCFfFD/j
	UaLzTfoduiqrFWkY5loLjPYVxnJakqIkB/WLNdeB1XhQ1Pj1MN+eqZps3/fO8q2900qCsYhTJA/
	bVSoxe9TrtXGyM2uxksoGIKRbOgw8YLdWHTaS2p4uIz9
X-Received: by 2002:a05:690c:4a01:b0:86f:8707:1682 with SMTP id
 00721157ae682-87125448905mr134532027b3.5.1788895386248; Tue, 08 Sep 2026
 12:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830093514.4105972-1-memxor@gmail.com> <20260830093514.4105972-7-memxor@gmail.com>
In-Reply-To: <20260830093514.4105972-7-memxor@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Tue, 8 Sep 2026 15:22:55 -0400
X-Gm-Features: AcwNN1XRnfOGdGMLcjewvyZA8f2HDJUJzhP4bmDMlGgGFXno5PQVi99TvMP3RMc
Message-ID: <CABFh=a4pZLm7VpbMZu_FHzZwnasOfgkoyYUVSng3yarbmRBNdg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 6/6] selftests/bpf: Test program stream file descriptors
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 5:35=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Exercise validation and normal file semantics of BPF_PROG_STREAM_OPEN.
> Cover read-only and close-on-exec state, write rejection, non-blocking
> reads, partial reads, poll readiness, and a blocking reader woken by new
> stream data.
>
> Register the descriptor with EPOLLET, consume the initial data event
> without draining buffered output, then release the program. Require a
> second edge carrying POLLIN and POLLHUP, drain the buffered bytes, and
> verify that poll continues to report HUP before read returns EOF. This
> ensures program teardown notifies edge-triggered loops even when
> readability never transitions.
>
> Also block a reader on an empty live stream, release the program, and
> verify that it wakes and returns EOF. This directly covers the teardown
> wait condition and its no-lost-wakeup ordering.
>
> Finally, attach a stream-writing program to a hardware perf event and
> busy-poll its epoll registration until output arrives. This both drives t=
he
> per-thread event into NMI context and directly verifies that the deferred
> irq_work notification reaches epoll, without a separate BSS completion
> handshake.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  .../testing/selftests/bpf/prog_tests/stream.c | 376 ++++++++++++++++++
>  tools/testing/selftests/bpf/progs/stream.c    |  10 +
>  2 files changed, 386 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/test=
ing/selftests/bpf/prog_tests/stream.c
> index 74bd15c4bfba..655aab35c03e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/stream.c
> +++ b/tools/testing/selftests/bpf/prog_tests/stream.c
> @@ -1,11 +1,17 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
>  #include <test_progs.h>
> +#include <linux/perf_event.h>
> +#include <poll.h>
> +#include <sys/epoll.h>
>  #include <sys/mman.h>
> +#include <sys/syscall.h>
>
>  #include "stream.skel.h"
>  #include "stream_fail.skel.h"
>
> +#define NMI_TIMEOUT_NS (5ULL * 1000 * 1000 * 1000)
> +
>  void test_stream_failure(void)
>  {
>         RUN_TESTS(stream_fail);
> @@ -62,6 +68,376 @@ void test_stream_syscall(void)
>         stream__destroy(skel);
>  }
>
> +static bool stream_fd_trigger(struct bpf_program *prog)
> +{
> +       LIBBPF_OPTS(bpf_test_run_opts, opts);
> +       int ret;
> +
> +       ret =3D bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
> +       return ASSERT_OK(ret, "test_run") && ASSERT_OK(opts.retval, "retv=
al");
> +}
> +
> +static void test_stream_fd_open(void)
> +{
> +       LIBBPF_OPTS(bpf_prog_stream_open_opts, opts);
> +       struct stream *skel;
> +       int fd, prog_fd;
> +
> +       skel =3D stream__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
> +               return;
> +
> +       prog_fd =3D bpf_program__fd(skel->progs.stream_syscall);
> +       fd =3D bpf_prog_stream_open(0, BPF_STREAM_STDOUT, NULL);
> +       ASSERT_EQ(fd, -EINVAL, "bad_prog_fd");
> +
> +       fd =3D bpf_prog_stream_open(prog_fd, 0, NULL);
> +       ASSERT_EQ(fd, -ENOENT, "bad_stream_id");
> +
> +       opts.flags =3D BPF_F_WRONLY;
> +       fd =3D bpf_prog_stream_open(prog_fd, BPF_STREAM_STDOUT, &opts);
> +       ASSERT_EQ(fd, -EINVAL, "writable");
> +
> +       opts.flags =3D 1U << 31;
> +       fd =3D bpf_prog_stream_open(prog_fd, BPF_STREAM_STDOUT, &opts);
> +       ASSERT_EQ(fd, -EINVAL, "unknown_flag");
> +
> +       opts.flags =3D BPF_F_RDONLY;
> +       fd =3D bpf_prog_stream_open(prog_fd, BPF_STREAM_STDERR, &opts);
> +       if (ASSERT_OK_FD(fd, "readonly"))
> +               close(fd);
> +
> +       stream__destroy(skel);
> +}
> +
> +static void test_stream_fd_nonblock(void)
> +{
> +       LIBBPF_OPTS(bpf_prog_stream_open_opts, opts,
> +               .flags =3D BPF_F_RDONLY | BPF_F_STREAM_NONBLOCK,
> +       );
> +       struct pollfd pfd =3D { .events =3D POLLIN | POLLHUP };
> +       struct stream *skel;
> +       char buf[4] =3D {};
> +       int fd, flags, ret;
> +
> +       skel =3D stream__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
> +               return;
> +
> +       fd =3D bpf_prog_stream_open(bpf_program__fd(skel->progs.stream_sy=
scall),
> +                                 BPF_STREAM_STDOUT, &opts);
> +       if (!ASSERT_OK_FD(fd, "stream_open"))
> +               goto out_destroy;
> +       pfd.fd =3D fd;
> +
> +       flags =3D fcntl(fd, F_GETFD);
> +       ASSERT_GE(flags, 0, "getfd");
> +       ASSERT_NEQ(flags & FD_CLOEXEC, 0, "cloexec");
> +       flags =3D fcntl(fd, F_GETFL);
> +       ASSERT_GE(flags, 0, "getfl");
> +       ASSERT_EQ(flags & O_ACCMODE, O_RDONLY, "readonly");
> +       ASSERT_NEQ(flags & O_NONBLOCK, 0, "nonblock");
> +
> +       ret =3D write(fd, "x", 1);
> +       ASSERT_EQ(ret, -1, "write");
> +       ASSERT_EQ(errno, EBADF, "write_errno");
> +
> +       ret =3D poll(&pfd, 1, 0);
> +       ASSERT_EQ(ret, 0, "poll_empty");
> +       ret =3D read(fd, buf, sizeof(buf));
> +       ASSERT_EQ(ret, -1, "read_empty");
> +       ASSERT_EQ(errno, EAGAIN, "read_empty_errno");
> +
> +       if (!stream_fd_trigger(skel->progs.stream_syscall))
> +               goto out_close;
> +       ret =3D poll(&pfd, 1, 0);
> +       ASSERT_EQ(ret, 1, "poll_data");
> +       ASSERT_NEQ(pfd.revents & POLLIN, 0, "pollin");
> +       ASSERT_EQ(pfd.revents & POLLHUP, 0, "no_pollhup");
> +
> +       ret =3D read(fd, buf, 2);
> +       ASSERT_EQ(ret, 2, "read_first");
> +       ASSERT_OK(memcmp(buf, "fo", 2), "read_first_data");
> +       pfd.revents =3D 0;
> +       ret =3D poll(&pfd, 1, 0);
> +       ASSERT_EQ(ret, 1, "poll_partial");
> +       ASSERT_NEQ(pfd.revents & POLLIN, 0, "pollin_partial");
> +
> +       ret =3D read(fd, buf, sizeof(buf));
> +       ASSERT_EQ(ret, 1, "read_rest");
> +       ASSERT_EQ(buf[0], 'o', "read_rest_data");
> +       ret =3D read(fd, buf, sizeof(buf));
> +       ASSERT_EQ(ret, -1, "read_drained");
> +       ASSERT_EQ(errno, EAGAIN, "read_drained_errno");
> +
> +out_close:
> +       close(fd);
> +out_destroy:
> +       stream__destroy(skel);
> +}
> +
> +struct stream_fd_read_ctx {
> +       int fd;
> +       ssize_t ret;
> +       char buf[4];
> +};
> +
> +static void *stream_fd_read_thread(void *arg)
> +{
> +       struct stream_fd_read_ctx *ctx =3D arg;
> +
> +       ctx->ret =3D read(ctx->fd, ctx->buf, sizeof(ctx->buf));
> +       return NULL;
> +}
> +
> +static int stream_fd_timed_join(pthread_t thread)
> +{
> +       struct timespec timeout;
> +
> +       clock_gettime(CLOCK_REALTIME, &timeout);
> +       timeout.tv_sec +=3D 5;
> +       return pthread_timedjoin_np(thread, NULL, &timeout);
> +}
> +
> +static void test_stream_fd_blocking(void)
> +{
> +       struct stream_fd_read_ctx ctx =3D {};
> +       struct stream *skel;
> +       pthread_t thread;
> +       bool thread_live =3D false;
> +       int fd, flags, ret;
> +
> +       skel =3D stream__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
> +               return;
> +
> +       fd =3D bpf_prog_stream_open(bpf_program__fd(skel->progs.stream_sy=
scall),
> +                                 BPF_STREAM_STDOUT, NULL);
> +       if (!ASSERT_OK_FD(fd, "stream_open"))
> +               goto out_destroy;
> +       ctx.fd =3D fd;
> +
> +       flags =3D fcntl(fd, F_GETFL);
> +       ASSERT_GE(flags, 0, "getfl");
> +       ASSERT_EQ(flags & O_NONBLOCK, 0, "blocking");
> +
> +       ret =3D pthread_create(&thread, NULL, stream_fd_read_thread, &ctx=
);
> +       if (!ASSERT_OK(ret, "pthread_create"))
> +               goto out_close;
> +       thread_live =3D true;
> +
> +       usleep(50000);
> +       ret =3D pthread_tryjoin_np(thread, NULL);
> +       if (!ASSERT_EQ(ret, EBUSY, "read_blocks")) {
> +               thread_live =3D ret !=3D 0;
> +               goto out_thread;
> +       }
> +       if (!stream_fd_trigger(skel->progs.stream_syscall))
> +               goto out_thread;
> +
> +       ret =3D stream_fd_timed_join(thread);
> +       if (!ASSERT_OK(ret, "pthread_join"))
> +               goto out_thread;
> +       thread_live =3D false;
> +       ASSERT_EQ(ctx.ret, 3, "read_len");
> +       ASSERT_OK(memcmp(ctx.buf, "foo", 3), "read_data");
> +
> +       memset(&ctx, 0, sizeof(ctx));
> +       ctx.fd =3D fd;
> +       ret =3D pthread_create(&thread, NULL, stream_fd_read_thread, &ctx=
);
> +       if (!ASSERT_OK(ret, "pthread_create_eof"))
> +               goto out_close;
> +       thread_live =3D true;
> +
> +       usleep(50000);
> +       ret =3D pthread_tryjoin_np(thread, NULL);
> +       if (!ASSERT_EQ(ret, EBUSY, "read_eof_blocks")) {
> +               thread_live =3D ret !=3D 0;
> +               goto out_thread;
> +       }
> +
> +       stream__destroy(skel);
> +       skel =3D NULL;
> +       ret =3D stream_fd_timed_join(thread);
> +       if (!ASSERT_OK(ret, "pthread_join_eof"))
> +               goto out_thread;
> +       thread_live =3D false;
> +       ASSERT_EQ(ctx.ret, 0, "read_eof");
> +
> +out_thread:
> +       if (thread_live) {
> +               stream__destroy(skel);
> +               skel =3D NULL;
> +               ret =3D stream_fd_timed_join(thread);
> +               if (ret) {
> +                       pthread_cancel(thread);
> +                       pthread_join(thread, NULL);
> +               }
> +       }
> +out_close:
> +       close(fd);
> +out_destroy:
> +       stream__destroy(skel);
> +}
> +
> +static void test_stream_fd_hup(void)
> +{
> +       LIBBPF_OPTS(bpf_prog_stream_open_opts, opts,
> +               .flags =3D BPF_F_STREAM_NONBLOCK,
> +       );
> +       struct epoll_event event =3D {
> +               .events =3D EPOLLIN | EPOLLET,
> +       };
> +       struct pollfd pfd =3D { .events =3D POLLIN | POLLHUP };
> +       struct stream *skel;
> +       char buf[4] =3D {};
> +       int epfd =3D -1, fd, ret;
> +
> +       skel =3D stream__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
> +               return;
> +
> +       fd =3D bpf_prog_stream_open(bpf_program__fd(skel->progs.stream_sy=
scall),
> +                                 BPF_STREAM_STDOUT, &opts);
> +       if (!ASSERT_OK_FD(fd, "stream_open"))
> +               goto out_destroy;
> +       pfd.fd =3D fd;
> +       epfd =3D epoll_create1(EPOLL_CLOEXEC);
> +       if (!ASSERT_OK_FD(epfd, "epoll_create"))
> +               goto out_close;
> +       event.data.fd =3D fd;
> +       ret =3D epoll_ctl(epfd, EPOLL_CTL_ADD, fd, &event);
> +       if (!ASSERT_OK(ret, "epoll_ctl"))
> +               goto out_close;
> +
> +       if (!stream_fd_trigger(skel->progs.stream_syscall))
> +               goto out_close;
> +       ret =3D epoll_wait(epfd, &event, 1, 5000);
> +       if (!ASSERT_EQ(ret, 1, "epoll_wait_data"))
> +               goto out_close;
> +       ASSERT_NEQ(event.events & EPOLLIN, 0, "epollin");
> +       ASSERT_EQ(event.events & EPOLLHUP, 0, "no_epollhup");
> +
> +       stream__destroy(skel);
> +       skel =3D NULL;
> +       event.events =3D 0;
> +       ret =3D epoll_wait(epfd, &event, 1, 5000);
> +       if (!ASSERT_EQ(ret, 1, "epoll_wait_hup"))
> +               goto out_close;
> +       ASSERT_NEQ(event.events & EPOLLIN, 0, "epollin_with_hup");
> +       ASSERT_NEQ(event.events & EPOLLHUP, 0, "epollhup");
> +
> +       ret =3D read(fd, buf, sizeof(buf));
> +       ASSERT_EQ(ret, 3, "read_buffered");
> +       ASSERT_OK(memcmp(buf, "foo", 3), "read_buffered_data");
> +       pfd.revents =3D 0;
> +       ret =3D poll(&pfd, 1, 0);
> +       ASSERT_EQ(ret, 1, "poll_drained_hup");
> +       ASSERT_EQ(pfd.revents & POLLIN, 0, "no_pollin_after_drain");
> +       ASSERT_NEQ(pfd.revents & POLLHUP, 0, "pollhup_after_drain");
> +       ret =3D read(fd, buf, sizeof(buf));
> +       ASSERT_EQ(ret, 0, "read_eof");
> +
> +out_close:
> +       if (epfd >=3D 0)
> +               close(epfd);
> +       close(fd);
> +out_destroy:
> +       stream__destroy(skel);
> +}
> +
> +static void test_stream_fd_nmi_epoll(void)
> +{
> +       LIBBPF_OPTS(bpf_prog_stream_open_opts, opts,
> +               .flags =3D BPF_F_STREAM_NONBLOCK,
> +       );
> +       struct perf_event_attr attr =3D {
> +               .size =3D sizeof(attr),
> +               .type =3D PERF_TYPE_HARDWARE,
> +               .config =3D PERF_COUNT_HW_CPU_CYCLES,
> +               .freq =3D 1,
> +               .sample_freq =3D 10,
> +       };
> +       struct epoll_event event =3D {
> +               .events =3D EPOLLIN,
> +       };
> +       struct bpf_link *link =3D NULL;
> +       struct stream *skel;
> +       __u64 deadline;
> +       char buf[4] =3D {};
> +       int epfd =3D -1, fd =3D -1, pmu_fd =3D -1;
> +       int ret;
> +
> +       skel =3D stream__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
> +               return;
> +       fd =3D bpf_prog_stream_open(bpf_program__fd(skel->progs.stream_nm=
i),
> +                                 BPF_STREAM_STDOUT, &opts);
> +       if (!ASSERT_OK_FD(fd, "stream_open"))
> +               goto out;
> +
> +       epfd =3D epoll_create1(EPOLL_CLOEXEC);
> +       if (!ASSERT_OK_FD(epfd, "epoll_create"))
> +               goto out;
> +       event.data.fd =3D fd;
> +       ret =3D epoll_ctl(epfd, EPOLL_CTL_ADD, fd, &event);
> +       if (!ASSERT_OK(ret, "epoll_ctl"))
> +               goto out;
> +
> +       pmu_fd =3D syscall(__NR_perf_event_open, &attr, 0, -1, -1,
> +                        PERF_FLAG_FD_CLOEXEC);
> +       if (pmu_fd < 0 && (errno =3D=3D ENOENT || errno =3D=3D EOPNOTSUPP=
)) {
> +               printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n", __func__)=
;
> +               test__skip();
> +               goto out;
> +       }
> +       if (!ASSERT_GE(pmu_fd, 0, "perf_event_open"))
> +               goto out;
> +
> +       link =3D bpf_program__attach_perf_event(skel->progs.stream_nmi, p=
mu_fd);
> +       if (!ASSERT_OK_PTR(link, "attach_perf_event")) {
> +               link =3D NULL;
> +               goto out;
> +       }
> +       pmu_fd =3D -1;
> +
> +       deadline =3D get_time_ns() + NMI_TIMEOUT_NS;
> +       do {
> +               ret =3D epoll_wait(epfd, &event, 1, 0);
> +       } while (ret =3D=3D 0 && get_time_ns() < deadline);
> +       if (!ASSERT_EQ(ret, 1, "epoll_wait"))
> +               goto out;
> +       ASSERT_NEQ(event.events & EPOLLIN, 0, "epollin");
> +
> +       ret =3D read(fd, buf, sizeof(buf));
> +       ASSERT_EQ(ret, 3, "read_len");
> +       ASSERT_OK(memcmp(buf, "nmi", 3), "read_data");
> +
> +out:
> +       bpf_link__destroy(link);
> +       if (pmu_fd >=3D 0)
> +               close(pmu_fd);
> +       if (epfd >=3D 0)
> +               close(epfd);
> +       if (fd >=3D 0)
> +               close(fd);
> +       stream__destroy(skel);
> +}
> +
> +void test_stream_fd(void)
> +{
> +       if (test__start_subtest("open"))
> +               test_stream_fd_open();
> +       if (test__start_subtest("nonblock"))
> +               test_stream_fd_nonblock();
> +       if (test__start_subtest("blocking"))
> +               test_stream_fd_blocking();
> +       if (test__start_subtest("hup"))
> +               test_stream_fd_hup();
> +       if (test__start_subtest("nmi_epoll"))
> +               test_stream_fd_nmi_epoll();
> +}
> +
>  void test_stream_oversize(void)
>  {
>         LIBBPF_OPTS(bpf_test_run_opts, opts);
> diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/s=
elftests/bpf/progs/stream.c
> index 12fc29e45487..00843127bca8 100644
> --- a/tools/testing/selftests/bpf/progs/stream.c
> +++ b/tools/testing/selftests/bpf/progs/stream.c
> @@ -44,6 +44,7 @@ struct {
>                   _X64 _X64 _X64 _X64 _X64 _X64 _X64 _X64)
>
>  int size;
> +int nmi_stream_prints;
>  u64 fault_addr;
>  void *arena_ptr;
>
> @@ -124,6 +125,15 @@ int stream_syscall(void *ctx)
>         return 0;
>  }
>
> +SEC("perf_event")
> +int stream_nmi(void *ctx)
> +{
> +       if (nmi_stream_prints)
> +               return 0;
> +       nmi_stream_prints =3D 1;
> +       return bpf_stream_printk(BPF_STDOUT, "nmi");
> +}
> +
>  SEC("syscall")
>  __success __retval(0)
>  int stream_oversize(void *ctx)
> --
> 2.53.0
>
