Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84101342CB3
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 01:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781227993; cv=none; b=muzphD27RzZg79Js+zWxqD8qVdwspa39CjJScFZUdlipiH6PRnqQ8/l9ZaxCOKeQMKlo6gpH3noXss3hYhSjnU+xzK6FAWfMqpmd2nWRlCFtA4LPKAtbF7DVpuyg7FbhykUMWerRwg3o9zacX6UfH43LYLcKgek0bOskvU2WO2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781227993; c=relaxed/simple;
	bh=PYtfSTiJXntGswecjzXH710Qea2ec0wFnI+TOIfNvBQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VpYx1wBtIz4XfvrRclzN9MzuZqHoe/NGsA9R2CFd3w+xcP/5lbAA2z9A5OQWIFPAstJbJ2R4fT9fg7kMKMkOGvdi0IbgFzqd3EKT/sq/gbi7FEPqoSARDK1BhPRR1x73/fw20Y0ENFqM40hcipMWwkrMsz7qKY5+Zmy4Gf7+SGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1F2JGuG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1F2JGuG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC6F1F000E9;
	Fri, 12 Jun 2026 01:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781227992;
	bh=AdTCDzo3F/hQDF0bkKaIlmhm3o0x8zBqHfbi3KPh1R4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F1F2JGuGevGIPgWCsPgS3EfiuwZD6VbJa5RGABz1MdzspfWwGI2nAA9uc5pADqIDH
	 LIhlUttgNu45ShrodzSc9RjwcHUOtPXyAwWGLIps1EfdyqR3fmvPSa3hdg7D3wMxmd
	 dXxGXSpxSEUskXfvlgc9lLkBCE2tBAuhMSJdw1JSi3pa3P1+AcAFfwlT2chvDaQ8qC
	 0fHnTPv4DhY8sK2ZzlbgoMFADDjy9Q4+zOrGojhbIGaPs4UoALIfziVxJJu5I3oF5h
	 ismH3CjLCkt92Ur+Ts3O668MjOaksANp/AdOoo/3K/SYIoj1Pbuxa/O0w1x9W1FRUe
	 rl85VDaU8zUdg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 1/5] tcp_bpf: add bpf_sock_splice_pair
 kfunc for opportunistic loopback splice
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cong Wang" <xiyou.wangcong@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260612011452.134466-2-xiyou.wangcong@gmail.com>
References: <20260612011452.134466-2-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 01:33:11 +0000
Message-Id: <20260612013311.EFC6F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [High] Missing socket lock in spliced sendmsg/recvmsg leading to SPSC rin=
g buffer corruption.
- [High] Permanent memory leak of sockets and psocks due to circular refere=
nces.
- [High] TCP stream ordering violation due to fast path racing with in-flig=
ht TCP data.
- [High] Use-after-free of socket waitqueue due to missing RCU read lock in=
 splice_wake.
- [High] RCU API Violations and lockless data races when accessing `psock->=
splice`.
- [High] Silent data blackhole when the receiving spliced socket has an ing=
ress BPF program.
- [High] Refcount leak and Use-After-Free due to ignoring the return value =
of `sk_psock_get()`.
- [Medium] Missing __GFP_ACCOUNT on ring buffer allocations allows memcg li=
mits bypass.
- [Medium] MSG_PEEK semantics broken for spliced sockets, causing hangs or =
silent data omission.
- [Medium] Socket errors are not cleared when fetched, leading to permanent=
 error state.
--

commit 2f2595b5999c95fe8a664fc82201339a3716f692
Author: Cong Wang <xiyou.wangcong@gmail.com>

    tcp_bpf: add bpf_sock_splice_pair kfunc for opportunistic loopback spli=
ce

    Two locally-connected TCP sockets can be paired by a sock_ops BPF
    program at handshake completion. Once paired, sendmsg copies the user
    payload into a per-direction kernel-side byte ring; recvmsg drains the
    ring into the user buffer. Both copies happen in their own task's mm,
    so no cross-mm pin / kmap dance is needed and the splice fast path
    incurs no skb construction, no softirq, and no TCP protocol-state
    processing. The TCP wire connection itself never sees the spliced
    bytes: sequence numbers stay frozen at post-handshake values, so FIN,
    RST, and keepalive continue to work through the regular paths and the
    pair tears down via a normal close handshake.

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index e1850caf1a71a..b39fc249a18d5 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c

[ ... ]

> @@ -881,12 +881,15 @@ static void sk_psock_destroy(struct work_struct *wo=
rk)
>  		sock_put(psock->sk_redir);
>  	if (psock->sk_pair)
>  		sock_put(psock->sk_pair);
> +	tcp_bpf_splice_destroy(psock);
>  	sock_put(psock->sk);
>  	kfree(psock);
>  }
> =20
>  void sk_psock_drop(struct sock *sk, struct sk_psock *psock)
>  {
> +	tcp_bpf_splice_unpair(psock);
> +

[Severity: High]
Does this code create a permanent memory leak due to a circular reference?

In bpf_sock_splice_pair(), both sides of the paired connection acquire a
reference to the other's sk_psock via sk_psock_get(). This establishes a
circular reference.

Since the cross-references are only dropped in tcp_bpf_splice_unpair(), and
this is only called from sk_psock_drop() which executes when a psock's
reference count reaches 0, the circular reference guarantees neither refcou=
nt
will ever reach 0.

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index cc0bd73f36b6d..549f370772446 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c

[ ... ]

> @@ -626,8 +683,9 @@ static void tcp_bpf_rebuild_protos(struct proto prot[=
TCP_BPF_NUM_CFGS],
>  	prot[TCP_BPF_BASE]			=3D *base;
>  	prot[TCP_BPF_BASE].destroy		=3D sock_map_destroy;
>  	prot[TCP_BPF_BASE].close		=3D sock_map_close;
> +	prot[TCP_BPF_BASE].sendmsg		=3D tcp_bpf_splice_sendmsg;
>  	prot[TCP_BPF_BASE].recvmsg		=3D tcp_bpf_recvmsg;
> -	prot[TCP_BPF_BASE].sock_is_readable	=3D sk_msg_is_readable;
> +	prot[TCP_BPF_BASE].sock_is_readable	=3D tcp_bpf_is_readable;
>  	prot[TCP_BPF_BASE].ioctl		=3D tcp_bpf_ioctl;

[Severity: High]
Does this cause a silent data blackhole when the receiving spliced socket h=
as
an ingress BPF program?

The TCP_BPF_RX protocol configuration inherits its base configuration here,
so its sendmsg is assigned tcp_bpf_splice_sendmsg. However, its recvmsg
is explicitly overridden to tcp_bpf_recvmsg_parser, which lacks the splice
ring-buffer logic.

A sender will correctly push data into the splice ring buffer, but the
receiver will only poll the standard sk_receive_queue and ingress_msg queue,
never reading the ring buffer.

[ ... ]

> +static inline void splice_wake(struct sock *sk)
> +{
> +	wait_queue_head_t *wq =3D sk_sleep(sk);
> +
> +	smp_mb();
> +	if (wq && waitqueue_active(wq))
> +		wake_up_interruptible_all(wq);
> +}

[Severity: High]
Is it possible for sk_sleep(sk) to access a freed waitqueue here?

This function uses sk_sleep(sk) to get the socket's waitqueue, which uses
rcu_dereference_raw(). Without the caller holding the RCU read lock, the
memory backing the waitqueue could be concurrently freed by sock_release().

[ ... ]

> +static bool sk_psock_is_spliced(const struct sk_psock *psock)
> +{
> +	struct sk_psock_splice *s =3D rcu_dereference(psock->splice);
> +
> +	return s && rcu_access_pointer(s->peer);
> +}

[Severity: High]
Is this missing an RCU read lock?

sk_psock_is_spliced() calls rcu_dereference(psock->splice) from
tcp_bpf_splice_sendmsg() and tcp_bpf_recvmsg() without an active
rcu_read_lock(), which can trigger a lockdep warning.

[ ... ]

> +static int tcp_bpf_splice_sendmsg(struct sock *sk, struct msghdr *msg,
> +				  size_t size)
> +{
> +	struct sk_psock *psock;
> +	int spliced =3D 0;
> +	int ret;

[Severity: High]
Could the lack of socket locking here lead to SPSC ring buffer corruption?

tcp_bpf_splice_sendmsg() bypasses the standard socket lock (lock_sock(sk)).
Since userspace can call sendmsg or recvmsg from multiple threads concurren=
tly
on the same socket descriptor, multiple producers or consumers will race
when accessing the SPSC ring buffer logic in splice_ring_write() and
tcp_bpf_splice_recvmsg(). This can lead to non-atomic cursor updates and
memory corruption.

[ ... ]

> +void tcp_bpf_splice_unpair(struct sk_psock *psock)
> +{
> +	struct sk_psock_splice *self_s, *peer_s;
> +	struct sk_psock *peer;
> +	bool was_paired =3D false;
> +
> +	self_s =3D rcu_dereference_protected(psock->splice, 1);
> +	if (!self_s)
> +		return;
> +
> +	rcu_read_lock();
> +	peer =3D rcu_dereference(self_s->peer);
> +	if (!peer) {
> +		rcu_read_unlock();
> +		return;
> +	}
> +	if (!sk_psock_get(peer->sk)) {

[Severity: High]
Does ignoring the return value of sk_psock_get() here cause a refcount leak
and use-after-free?

If a socket's psock is concurrently replaced, sk_psock_get() returns and
increments the refcount of the new psock. Because this code continues using
the original peer pointer to interact with and ultimately drop the refcount
(via sk_psock_put()), it creates an unbalanced increment on the new psock
(memory leak) and an unbalanced decrement on the old psock (use-after-free).

[ ... ]

> +	rcu_read_unlock();

[ ... ]

> +	/* Wake any blocked rendezvous waiters on either side. They will
> +	 * re-check the predicate, see splice->peer =3D=3D NULL, and exit.
> +	 */
> +	splice_wake(psock->sk);
> +	splice_wake(peer->sk);

[Severity: High]
Is it safe to call splice_wake() here after dropping the RCU read lock?

splice_wake() requires the RCU read lock to safely access the socket's
waitqueue without it being concurrently freed.

[ ... ]

> +static int splice_ring_alloc(struct sk_psock_splice *s)
> +{
> +	void *buf;
> +
> +	if (READ_ONCE(s->ring_buf))
> +		return 0;
> +
> +	buf =3D (void *)__get_free_pages(GFP_ATOMIC | __GFP_NOWARN,
> +				       get_order(SPLICE_RING_SIZE));

[Severity: Medium]
Should this allocation use the __GFP_ACCOUNT flag?

Because this 16 KiB allocation is not charged to the memory cgroup, a local
application could create and pair an arbitrary number of sockets to
intentionally exhaust host memory without being restricted by its container=
's
memory limits.

[ ... ]

> +static int tcp_bpf_splice_recvmsg(struct sock *sk,
> +				  struct sk_psock *psock,
> +				  struct msghdr *msg, size_t len,
> +				  int flags, int *err)
> +{
> +	struct sk_psock_splice *s;
> +	size_t copied;
> +	long timeo;
> +
> +	*err =3D 0;
> +	/* PEEK is not implemented against the ring (no peek-without-advance
> +	 * helper). Return 0 with no error so the dispatcher defers to the
> +	 * TCP path; ring contents are invisible to PEEK but the socket
> +	 * continues to work for normal apps.
> +	 */
> +	if (flags & MSG_PEEK)
> +		return 0;

[Severity: Medium]
Does returning 0 here break MSG_PEEK semantics?

Since the data has already been spliced directly into the ring buffer, it is
completely invisible to the TCP stack. A MSG_PEEK call falling back to the
standard TCP sk_receive_queue will falsely report that no data is available,
and a blocking MSG_PEEK could hang indefinitely waiting for normal TCP data.

[ ... ]

> +	s =3D rcu_dereference_protected(psock->splice, 1);

[Severity: High]
Can using a hardcoded 1 here cause data races?

Using rcu_dereference_protected() with a hardcoded 1 in a lockless,
concurrently accessible path suppresses lockdep checks and omits the data
dependency barriers provided by rcu_dereference() or READ_ONCE(). In a
concurrent environment, this creates data races and risks observing
uninitialized ring buffer state on architectures that require strict data
dependency barriers.

[ ... ]

> +		if (sk->sk_err) {
> +			*err =3D -sk->sk_err;
> +			return 0;
> +		}

[Severity: Medium]
Should the socket error be cleared when it is fetched?

When this observes an error in sk->sk_err, it sets *err and returns, which
propagates the error to user space. However, sk->sk_err is never cleared
(e.g., via sock_error(sk) or xchg(&sk->sk_err, 0)). Failing to clear the
error means every subsequent recvmsg() call will erroneously fail with the
exact same error, permanently breaking the socket.

[ ... ]

> +static int splice_send_ring(struct sock *sk, struct sk_psock *psock,
> +			    struct msghdr *msg, size_t size, int flags)
> +{

[ ... ]

> +			if (ps && READ_ONCE(ps->ring_buf) &&
> +			    !sk->sk_err && !(sk->sk_shutdown & SEND_SHUTDOWN) &&
> +			    skb_queue_empty(&peer_sk->sk_receive_queue)) {

[Severity: High]
Does this check violate TCP stream ordering by ignoring in-flight TCP data?

To preserve stream ordering when falling back to the standard TCP stack, the
sender relies on skb_queue_empty(&peer_sk->sk_receive_queue) to determine if
it is safe to write to the ring buffer. However, this check ignores data th=
at
is actively in-flight (queued in the sender's sk_write_queue, the local
qdisc, or softirq backlog). A subsequent sendmsg will see an empty
peer_sk->sk_receive_queue and splice new data directly into the ring buffer,
allowing the receiver to read it before the older in-flight TCP data arrive=
s.

[ ... ]

> +__bpf_kfunc int bpf_sock_splice_pair(struct sock *peer,
> +				     struct bpf_sock_ops_kern *skops)
> +{

[ ... ]

> +	/* Each side keeps a psock ref on the other for the duration. */
> +	if (!sk_psock_get(sk)) {
> +		ret =3D -ENOENT;
> +		goto out_unlock;
> +	}
> +	if (!sk_psock_get(peer)) {

[Severity: High]
Could ignoring the return value of sk_psock_get() here cause a refcount leak
and use-after-free?

Similar to tcp_bpf_splice_unpair(), if a socket's psock is concurrently
replaced, sk_psock_get() returns and increments the refcount of the new pso=
ck.
Because this code continues using the original peer pointer to interact with
it, it creates an unbalanced increment on the new psock and an unbalanced
decrement on the old psock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612011452.1344=
66-1-xiyou.wangcong@gmail.com?part=3D1
