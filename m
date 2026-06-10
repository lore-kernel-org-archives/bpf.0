Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0039334B1B0
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781115163; cv=none; b=pfFKxABSdfIOf3dslt2zV1siM0miRaoITCtKGQNLVqVXJjVyopzNL5nadmGlWa+zaIlCeeySg+SYC/Tn7h2VRjpt1NDqhxihJp85/u4TkuhTmz1yBN4KrSsEYSgyTEG8OthCeeCKpbsdWpUU0vvIjwKDPApmMnpKAUEbQkAevXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781115163; c=relaxed/simple;
	bh=19A7LnsOccek2jAcZJMjWcacGwtua23F7Li+9eDgpi0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PQULnk0PAPHFd6I3K5IRRxZb5iM1oyGEETMLxcBuuGnLEoT5lSiyf8+tiy6PHp9Puvmuz3N2Tp9h67hDaO53+l82gqSEISXb6nSwnEf0C/JU74e/nlAQg1wOFw4eRG5R8HB/fX6lPqKdblvTLb5zTHykX5MnW3nPQCGaNQfQ5qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyzhGhbr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyzhGhbr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B361F00893;
	Wed, 10 Jun 2026 18:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781115161;
	bh=2HNPA4xEO62L9DQbzoWviR+WSTSnED75gnaNlycULKg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OyzhGhbrczrxElucM48Ga0Z6/yd/laFH3cFw1G093auhRc2ftsVcWqoacv4rRMw/I
	 xPUKTpNv7RqBNVHqoN4unDnQgixSqgxHbpYGP4q2dbjLsUd1j2lNBtRyjyZKP9nYKh
	 s2iNAnFvO/jXbZPs1A3S/6rPGpYXT6OqEblAHgzw+sFE/YN4YM47j6l6kjbA6TIY+C
	 JnL/kyn77B6W37qY3stZssZvVnW7Bi0vJ6U6Jpuhpwdc1nHyfITwPRJnBNqV/6B1A4
	 tmgy7OmBAV+prSuTbF/WsSzOjiYZJwaO6aE9lohvjWf9Xo4jRhpvMg74heK4ls8fC5
	 ZR5mlIQOPydKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: take the socket lock in
 udp_bpf_recvmsg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260610175922.1103871-1-rhkrqnwk98@gmail.com>
References: <20260610175922.1103871-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 18:12:40 +0000
Message-Id: <20260610181241.72B361F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `udp_bpf_recvmsg` returns `-EAGAIN` instead of `-EINTR` or `-EREST=
ARTSYS` on signal interruption for blocking sockets.
- [High] `udp_bpf_recvmsg` enters an infinite busy-wait loop if data is que=
ued in `psock->ingress_skb` but not yet processed into `psock->ingress_msg`.
- [High] Lost wakeups and deadlocks for BPF-redirected packets when the UDP=
 socket is initially empty.
- [High] `vsock_bpf_recvmsg` sleeps while holding the socket lock, causing =
a deadlock with incoming packet delivery.
--

commit 093cedb7b7f9c8e7af25b932fdeb58d606fcc2ea
Author: Sechang Lim <rhkrqnwk98@gmail.com>

bpf, sockmap: take the socket lock in udp_bpf_recvmsg()

udp_bpf_recvmsg() drains the psock ingress_msg queue through
sk_msg_recvmsg() without holding the socket lock. This commit
adds lock_sock() and release_sock() around the consume path
so a given ingress sk_msg is drained by one reader at a time.

> diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> index 9f33b07b14813..8dd73e9ee1ea6 100644
> --- a/net/ipv4/udp_bpf.c
> +++ b/net/ipv4/udp_bpf.c

[Severity: High]
This isn't a bug introduced by this patch, but can the unconditional
delegation to sk_udp_recvmsg() in udp_bpf_recvmsg() cause lost wakeups
and deadlocks for BPF-redirected packets when the UDP socket is
initially empty?

If !psock_has_data(psock) is initially true, udp_bpf_recvmsg() does:

    if (!psock_has_data(psock)) {
        ret =3D sk_udp_recvmsg(sk, msg, len, flags);
        goto out;
    }

sk_udp_recvmsg() will sleep on the native socket wait queue checking
only sk->sk_receive_queue.

If a packet arrives and is redirected by a BPF program to
psock->ingress_msg, the wait queue is woken up, but because
sk_receive_queue is still empty, the native UDP wait loop
(__skb_wait_for_more_packets) will immediately go back to sleep.

Does this leave the packet stuck in psock and the user thread hanging
permanently?

> @@ -80,7 +80,9 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
>  	}
> =20
>  msg_bytes_ready:
> +	lock_sock(sk);
>  	copied =3D sk_msg_recvmsg(sk, psock, msg, len, flags);
> +	release_sock(sk);

[Severity: High]
This is a pre-existing issue, but can this code enter an infinite
busy-wait loop if data is queued in psock->ingress_skb but not yet
processed into psock->ingress_msg?

If psock->ingress_skb is not empty, psock_has_data() evaluates to true.

Then udp_bpf_recvmsg() calls sk_msg_recvmsg(), which only reads from
ingress_msg, returning 0.

Because psock_has_data() is true, udp_msg_wait_data() returns 1
without sleeping. The loop sees data =3D=3D 1 and psock_has_data() =3D=3D t=
rue
and jumps back to msg_bytes_ready.

Does this create a tight spin loop that rapidly acquires and releases
lock_sock, causing CPU starvation until the backlog workqueue thread
finishes moving the skb?

>  	if (!copied) {
>  		long timeo;
>  		int data;

[Severity: High]
This is a pre-existing issue, but does udp_bpf_recvmsg() violate POSIX
semantics by returning -EAGAIN instead of -EINTR or -ERESTARTSYS on
signal interruption for blocking sockets?

If a blocking recvmsg is interrupted by a signal, wait_woken() inside
udp_msg_wait_data() returns prematurely, causing udp_msg_wait_data()
to return 0.

The code then unconditionally sets copied =3D -EAGAIN when data is 0:

    copied =3D -EAGAIN;

Does this completely ignore signal_pending(current)?

Additionally, there is a pre-existing issue in net/vmw_vsock/vsock_bpf.c:

[Severity: High]
This isn't a bug introduced by this patch, but does vsock_bpf_recvmsg()
sleep while holding the socket lock, causing a deadlock with incoming
packet delivery?

In vsock_bpf_recvmsg(), the code acquires lock_sock(sk) and calls
vsock_msg_wait_data() when no data is available:

vsock_bpf_recvmsg()
    lock_sock(sk);
    ...
    while (copied =3D=3D 0) {
        long timeo =3D sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
        if (!vsock_msg_wait_data(sk, psock, timeo)) {

This function calls wait_woken() without releasing the socket lock:

vsock_msg_wait_data()
    wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);

Meanwhile, the Rx thread (virtio_transport_recv_pkt()) needs to acquire
lock_sock(sk) to deliver incoming packets and trigger sk_data_ready().

Because the sleeping user task holds the lock, does the Rx thread block
indefinitely, resulting in a deadlock where the user task is never
woken up?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610175922.1103=
871-1-rhkrqnwk98@gmail.com?part=3D1
