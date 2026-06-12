Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0850734E75A
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 03:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781234991; cv=none; b=L6c7NOUxE247iUQp/FwYfMjPD7I70/R0+k5Udi7V9R8Gn0LF1tm2na8Wf2va4pWxEg1vp8HqR2UTwONkZM1zqAubcu6lJcOm4AACrxLD4317LptCpCiAkh82esS8ui0SA3o2iQTaYdApIMmmV3CZAGg3nsZHb6kmn9p0cBVu37g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781234991; c=relaxed/simple;
	bh=u5rh4Qqvi0s8OCODrI+xGQAYGLWCohZPG7lsp4zENrk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RAL0rnhm9GUv7x9OcebJK71cuAe3Rqj0OaVmxWN7QelyoWk9lAss8MXQtL9r2gKiXTeTxusVrRWUtuX2rs54WLu4J1gqNCdmsO6ITgiKtAYq2R3cUeXsB/ivQT9Uq6FcipBhq951+t6dNqHG2krkYa76Mbv188Zg2lnRiI9CdtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNjH1Zv/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNjH1Zv/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A3F1F000E9;
	Fri, 12 Jun 2026 03:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781234989;
	bh=r/afzwc3Zr+i70BaarjTjjwiIBDNpMX+J826I2mpbSY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mNjH1Zv/ix2CIqoiMqGHGRAgKjC5XfE7ZNzy94ZougxpKXIzSndVJif+Y98YxESLP
	 YV5Wc76doplPVWPOQZIhYXx+50epO0JE3GE1ZbyjKc7QHN71cUNuuwN0+rNWQcCgpu
	 L/yKqLiSK1D3xquG1CqUeVhhejX9sSr2DsFX+prdNGyEmS1lrSqNy1ofntfpbXTxud
	 Jroj4d18AjkkJR6259snic+HhQhfyKfEsGRD57P1N3Ah0MlmqmFDvv9L2Kwzhb1rqc
	 Batu4Y9bnnvMbSqO4y5PfSOU9FHJyKB7OatnmD5ZUvRlDPkPWG3m7SLuesMvCX0sSa
	 Dj1teaExkPouQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 2/5] tcp_bpf: busy-poll the splice ring
 before parking the receiver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cong Wang" <xiyou.wangcong@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260612011452.134466-3-xiyou.wangcong@gmail.com>
References: <20260612011452.134466-3-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 03:29:48 +0000
Message-Id: <20260612032949.68A3F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing `need_resched()` check in `splice_busy_loop()` allows an u=
nprivileged user to monopolize a CPU, causing soft lockups and denial of se=
rvice.
- [High] `tcp_bpf_splice_recvmsg` incorrectly returns `-EINTR` instead of `=
-ERESTARTSYS` for blocking sockets when interrupted by a signal, breaking `=
SA_RESTART` semantics.
- [High] Providing an invalid memory buffer to `recvmsg` on a spliced socke=
t causes an uninterruptible infinite loop in kernel space, leading to Denia=
l of Service.
--

commit 8f0193a527ddda6d7d50681be8a081f8bc267f16
Author: Cong Wang <xiyou.wangcong@gmail.com>

tcp_bpf: busy-poll the splice ring before parking the receiver

This commit adds an optional bounded busy-poll of the ring before parking,
reusing the socket's SO_BUSY_POLL budget via sk_can_busy_loop() and
sk_busy_loop_timeout(). It spins directly on the in-kernel ring without
polling a NAPI instance.

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 549f370772446..9c4421a74225b 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c

[ ... ]

> @@ -1255,6 +1256,33 @@ static long splice_recv_wait(struct sock *sk, stru=
ct sk_psock_splice *s,
>  					splice_recv_ready(sk, s), timeo);
>  }
> =20
> +/* Bounded busy-poll on the ring before parking the receiver. Reuses the
> + * socket's SO_BUSY_POLL budget (sk_ll_usec) via sk_can_busy_loop() and
> + * sk_busy_loop_timeout(); the default budget of 0 makes sk_can_busy_loo=
p()
> + * false so this is a no-op unless the application (or net.core.busy_rea=
d)
> + * opted in.
> + *
> + * Unlike sk_busy_loop() / napi_busy_loop(), this spins on the in-kernel
> + * ring directly rather than polling a NAPI instance, so it is effective=
 on
> + * loopback - which delivers via the per-CPU backlog and exposes no
> + * pollable napi_id. Keeping the receiver hot lets a synchronous sender's
> + * small writes accumulate in the ring without a wakeup per message.
> + */
> +static void splice_busy_loop(struct sock *sk, struct sk_psock_splice *s)
> +{
> +	unsigned long start;
> +
> +	if (!sk_can_busy_loop(sk))
> +		return;
> +
> +	start =3D busy_loop_current_time();
> +	do {
> +		cpu_relax();
> +		if (splice_recv_ready(sk, s) || signal_pending(current))
> +			return;
> +	} while (!sk_busy_loop_timeout(sk, start));

[Severity: High]
Does this loop need a need_resched() check or a call to cond_resched()?

Because an unprivileged user can set SO_BUSY_POLL to an extremely large
value (up to INT_MAX microseconds), triggering this path via recvmsg()
could cause the thread to spin on the CPU without yielding.

On non-preemptible kernels, this might completely starve other tasks,
stall RCU grace periods, and trigger watchdog soft lockups.

> +}
> +
>  /* prot->sock_is_readable for paired-splice sockets. tcp_stream_is_reada=
ble()

[ ... ]

> @@ -1349,6 +1377,16 @@ static int tcp_bpf_splice_recvmsg(struct sock *sk,
>  			return 0;
>  		}
> =20
> +		/* Spin on the ring for the SO_BUSY_POLL budget before
> +		 * sleeping. If the spin observes data, re-read from the
> +		 * loop head; otherwise (budget expired or a terminal
> +		 * condition) proceed to park - splice_recv_wait() returns
> +		 * immediately for terminal conditions.
> +		 */
> +		splice_busy_loop(sk, s);
> +		if (splice_ring_has_data(s))
> +			continue;

[Severity: High]
Could this result in an infinite loop if a user provides an invalid
buffer to recvmsg?

If the user buffer is unmapped memory, copy_to_iter() in splice_ring_read()
called earlier in the loop might safely fault and return 0. If
splice_ring_read() returns 0, the ring's tail pointer isn't advanced, and
the data remains in the ring buffer.

tcp_bpf_splice_recvmsg() seems to treat the 0 return as an empty read
rather than an -EFAULT error. When it subsequently checks
splice_ring_has_data() here, it will evaluate to true because the data is
still present.

This triggers the continue statement, which loops back immediately,
potentially creating a tight infinite loop in the kernel.

> +
>  		timeo =3D splice_recv_wait(sk, s, timeo);

[Severity: High]
Could this cause the system call to incorrectly return -EINTR instead of
-ERESTARTSYS when interrupted by a signal?

When splice_recv_wait() uses wait_event_interruptible_timeout() and is
interrupted, it returns -ERESTARTSYS (-512). This return value directly
overwrites the timeo variable here.

On the next loop iteration, signal_pending(current) would evaluate to true,
and the error code is computed via sock_intr_errno(timeo). Because timeo
is now -512 instead of MAX_SCHEDULE_TIMEOUT, sock_intr_errno() might
incorrectly return -EINTR instead of -ERESTARTSYS, which breaks SA_RESTART
semantics.

>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612011452.1344=
66-1-xiyou.wangcong@gmail.com?part=3D2
