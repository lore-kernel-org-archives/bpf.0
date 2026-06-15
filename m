Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDCA22CBD9
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 02:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781491057; cv=none; b=rKxHHFEcEKKcsLgbN+VPmJHYW3xKhDxQEp2QHaeWqJNTVC2eTwWUp+XdDEtP08QBpZ9ru7KXJWezIDEYXIc83b3VbTkkF2NmpOs4J+fY12s0c44IKrJ5doME783M4+0CRk6EX8xwctKiYMmjyH5/S3i8VLgpVJxBJcenvr0s5Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781491057; c=relaxed/simple;
	bh=RwAZkTFB0MBX56ybppO5+4WMzkfAnEm0kq7IFZcMzw8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pqKqSpFVD1w6zper0ahYIzfdWfGsrZNjZST1Epnqnd2bN1iN2vqdgOzbzGeThUF1VXC1i9g4Lgfo5ofXqUjC1mKsvp2DM8wiCAEd85DnXhT9/d4r8MV7inv+vhyo8hZ9fF7t6zX1B8OpOR+ZuZ3ycDUbH+umXb313aVuqceREco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhsmlJsY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhsmlJsY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF46B1F000E9;
	Mon, 15 Jun 2026 02:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781491055;
	bh=rae1qnq1+DGe1d+OtiujMXDqU4L7HCeC5dagNwuSZPI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VhsmlJsYaH39OjpmHQWiilIZSmRAjf5R0/S2ryUNGf0K+9//ny1g/jERoxeVLQEJs
	 D+IO3B+2tuBacxPovfQhebk8EHQktClMlI7GhdPVGkxdeOuxvzJ1UWs5fqtX7o6ab+
	 ikIo8kfYYcmNUvppMGV+gusehcAyX8O5lq0yXeiKDgVxhhjOtppgAETgGNLzcW+RNk
	 PxrGmTGjfCTK9nO5EMpkVvnqTtceE4MRR+BsOgdiAaHW8aYfuj9c2C7GHEHQ/DOXYH
	 QA78Bt4e6yN4SAuVZJqmHh8zZ+NSiwEcPOsYY69vTH9oqhz877/4raaZnJScykOKU3
	 OqGA8Cma1LYPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 4/6] sockmap: Fix use-after-free in
 udp_bpf_recvmsg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260615021959.140010-5-jiayuan.chen@linux.dev>
References: <20260615021959.140010-5-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 02:37:35 +0000
Message-Id: <20260615023735.BF46B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Infinite tight loop (soft lockup) holding lock_sock if data is pen=
ding only in ingress_skb.
- [High] Permanent bricking of socket receive path in `__sk_msg_recvmsg` on=
 0-byte datagrams or failed copies.
- [High] Delegating blocking recvmsg to `sk_udp_recvmsg` misses BPF wakeups=
, causing indefinite hangs.
- [High] `vsock_msg_wait_data` sleeps while holding `lock_sock(sk)`, leadin=
g to a deadlock.
--

commit a60377195171f0aa2922ffec3bb6a4d9b4e06c24
Author: Kuniyuki Iwashima <kuniyu@google.com>

sockmap: Fix use-after-free in udp_bpf_recvmsg()

syzbot reported use-after-free of struct sk_msg in sk_msg_recvmsg().
sk_msg_recvmsg() peeks sk_msg from psock->ingress_msg under a lock,
but its processing is lockless.

Link: https://lore.kernel.org/netdev/69922ac9.a70a0220.2c38d7.00e0.GAE@goog=
le.com/

> diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> --- a/net/ipv4/udp_bpf.c
> +++ b/net/ipv4/udp_bpf.c

[ ... ]

>  static int udp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t l=
en,
>  			   int flags)
>  {
>  	struct sk_psock *psock;
>  	int copied, ret;

[ ... ]

>  	psock =3D sk_psock_get(sk);
>  	if (unlikely(!psock))
>  		return sk_udp_recvmsg(sk, msg, len, flags);
> =20
>  	if (!psock_has_data(psock)) {
>  		ret =3D sk_udp_recvmsg(sk, msg, len, flags);
>  		goto out;
>  	}

[Severity: High]
This is a pre-existing issue, but does delegating a blocking recvmsg to
sk_udp_recvmsg here cause us to miss BPF wakeups?

If psock_has_data(psock) is initially false, udp_bpf_recvmsg() bypasses its
BPF-aware wait loop and delegates the read entirely to the native
sk_udp_recvmsg().

If the socket is blocking, sk_udp_recvmsg() sleeps waiting for packets on
sk->sk_receive_queue. If a BPF program subsequently redirects data to the
socket, the data is placed in psock->ingress_skb or psock->ingress_msg, and
a wakeup is issued via sk_data_ready().

This wakes up the native UDP loop, which only checks sk->sk_receive_queue,
finds it empty, and goes back to sleep. Can this cause the process to hang
indefinitely despite data being correctly available in the psock?

> +	lock_sock(sk);
>  msg_bytes_ready:
>  	copied =3D sk_msg_recvmsg(sk, psock, msg, len, flags);
>  	if (!copied) {
> @@ -90,11 +93,17 @@ static int udp_bpf_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
>  		if (data) {
>  			if (psock_has_data(psock))
>  				goto msg_bytes_ready;

[Severity: High]
This is a pre-existing issue, but can this loop cause a soft lockup if data
is pending only in ingress_skb?

If data has been enqueued to psock->ingress_skb but not yet moved to
psock->ingress_msg by the backlog worker, sk_msg_recvmsg() returns 0.
The code then calls udp_msg_wait_data().

Since psock_has_data() evaluates to true when ingress_skb is not empty,
udp_msg_wait_data() returns 1 immediately without sleeping. The loop then
jumps back to msg_bytes_ready and repeats.

On a non-preemptible kernel, if the worker is scheduled on the same CPU,
could this starve the worker and form a busy-wait loop in kernel space?


While reviewing the rx paths associated with this change, I noticed a
couple of other related issues in the subsystem.

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c

[ ... ]

>  static int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock,
>  			    struct msghdr *msg, int len, int flags,
>  			    struct sk_msg *msg_rx)
>  {

[ ... ]

> 			if (!copy) {
> 				copied =3D copied ? copied : -EFAULT;
> 				goto out;
> 			}

[Severity: High]
This is a pre-existing issue, but does returning -EFAULT here permanently
brick the socket receive path for 0-byte datagrams?

When a 0-byte UDP packet is redirected, skb_to_sgvec yields an empty
scatterlist, making copy evaluate to 0.

Because the error path jumps to out, it bypasses advancing the read pointer
(msg_rx->sg.start =3D i) and skips dequeuing the message.

On the next recvmsg call, won't the function peek the same 0-byte message
and immediately return -EFAULT again?


> diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
> --- a/net/vmw_vsock/vsock_bpf.c
> +++ b/net/vmw_vsock/vsock_bpf.c

[ ... ]

>  static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
>  			     size_t len, int flags)
>  {
>  	struct sk_psock *psock;

[ ... ]

> 	lock_sock(sk);
> 	vsk =3D vsock_sk(sk);
> ...
> 	while (copied =3D=3D 0) {
> 		long timeo =3D sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
>
> 		if (!vsock_msg_wait_data(sk, psock, timeo)) {

[Severity: High]
This is a pre-existing issue, but does vsock_msg_wait_data sleep while
holding lock_sock(sk)?

In vsock_bpf_recvmsg(), the socket lock is held when calling
vsock_msg_wait_data(). Inside vsock_msg_wait_data(), wait_woken() is called
to sleep without releasing the socket lock.

Meanwhile, the virtio transport receive path (virtio_transport_recv_pkt)
must acquire lock_sock(sk) to deliver incoming packets.

Could this result in a deadlock since the transport worker is blocked trying
to acquire lock_sock(sk) while the user process sleeps holding it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615021959.1400=
10-1-jiayuan.chen@linux.dev?part=3D4
