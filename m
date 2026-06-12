Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC6531ED8B
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270696; cv=none; b=dAZSRJ51EKrYLN4axMs3yfKMfEMhdPj0tNS14mlaeTU243uuSdcbvtETUAWlrv7lkNerTt+9wsUpMuLqd2bNzo8QhaUkys3E4fyD0tfJ+ZSWxMwujWReCSGRb5rcx6X+x6eZ+Pb2IRkS8QAmqEq524GMRi2YXIZ55JlqOtSqwOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270696; c=relaxed/simple;
	bh=Mqut3l3zRTjjonPUQ+nM35/1kD99UwE21MQP4zmH1Qw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lP6ePPKXvtxKLvDPGIuXpVlsVkdToRXHuBOrx/klFtxHaAGIjCCMn1wcuJ0i1LGXHm4o4FwsSjzCHROwe6zs2nCCIiUU0FkpkJ0RLk/ptiBlWfVkmau+6LhCNm4ULZmmUzu1fP2pO7XZ4oMkmSmO6VrTST3XuVYbkH5y5dhQRZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kH1NxPsM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kH1NxPsM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14321F000E9;
	Fri, 12 Jun 2026 13:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781270695;
	bh=78wzFlAJiCogDmjSTXCECA7NKU0smngGVgJ9JY/kJ9E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kH1NxPsMOUiNrcXys23CKnCLleWvsPrbJszcxugj83syfbd+iXCNyppvz9ZGa/ydz
	 WNJIKqwDHqoFR+NMguR8UwthgIrX1QZ4j2ZfEWdKMzHYCe/xd43DpzGOt1Z4ekSVON
	 HKWh+fM1Bph5GlF5OQH/elDqKDmQGZvQcPd/PMetnYB5Htm6JAXMQ/4xQBzh4JzKP5
	 LQC2d9Viq2tWe6bS4Ox6dkDClJvv4xwW68P98vtVL608rAn2zaNqqN/GfNSl9LphPs
	 N79ttE7MX0yHu7lO6pLzKfh7kZo5AYM0HkeGJcWJN5kxbjMMjuNrxbWy6AaspXNQjl
	 KkCopSJIcNlEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 5/7] sockmap: Fix use-after-free in
 udp_bpf_recvmsg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260612130919.299124-6-jiayuan.chen@linux.dev>
References: <20260612130919.299124-6-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 13:24:54 +0000
Message-Id: <20260612132454.F14321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Critical] Infinite loop holding the socket lock when data is pending in =
`ingress_skb` but not yet in `ingress_msg`.

Pre-existing issues:
- [High] Blocking recvmsg() incorrectly returns -EAGAIN instead of -EINTR (=
-ERESTARTSYS) when interrupted by a signal.
- [High] Delegating to `sk_udp_recvmsg` ignores data subsequently arriving =
via BPF redirect, causing a permanent hang.
- [High] udp_bpf_recvmsg() resets the receive timeout on every loop iterati=
on, allowing indefinite blocking despite SO_RCVTIMEO.
- [High] udp_msg_wait_data() does not check sk_shutdown after waking up, ca=
using recvmsg to return -EAGAIN instead of 0 on a closed socket.
--

commit d3eae210a4563564468c062b23ec1d89b4e36196
Author: Kuniyuki Iwashima <kuniyu@google.com>

sockmap: Fix use-after-free in udp_bpf_recvmsg()

This commit fixes a use-after-free of struct sk_msg in sk_msg_recvmsg()
reported by syzbot. It serialises sk_msg_recvmsg() by adding lock_sock()
inside udp_bpf_recvmsg(), ensuring that multiple threads do not concurrently
process the same sk_msg.

Link: https://lore.kernel.org/netdev/69922ac9.a70a0220.2c38d7.00e0.GAE@goog=
le.com/

> diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> index 9f33b07b14813..ad57c4c9eaab6 100644
> --- a/net/ipv4/udp_bpf.c
> +++ b/net/ipv4/udp_bpf.c
> @@ -50,7 +50,9 @@ static int udp_msg_wait_data(struct sock *sk, struct sk=
_psock *psock,
>  	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
>  	ret =3D udp_msg_has_data(sk, psock);
>  	if (!ret) {
> +		release_sock(sk);
>  		wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
> +		lock_sock(sk);
>  		ret =3D udp_msg_has_data(sk, psock);

[Severity: High]
This is a pre-existing issue, but does this miss checking for socket shutdo=
wn
after waking up?

If the socket is shut down (RCV_SHUTDOWN) while the thread is sleeping in
wait_woken(), the thread wakes up and evaluates udp_msg_has_data(). If it
finds no data, it returns 0.

The caller udp_bpf_recvmsg() then sets copied =3D -EAGAIN and returns it to
userspace. Does this violate POSIX semantics, which require a blocking
recvmsg() to return 0 (EOF) immediately on a gracefully closed socket?

[Severity: High]
This is also a pre-existing issue, but is there a missing check for
signal_pending(current) here?

If wait_woken() is interrupted by a signal, it returns early. Since
udp_msg_wait_data() fails to check for signals after the wait, it will
return 0 if no data has arrived.

In udp_bpf_recvmsg(), this 0 is unconditionally translated to -EAGAIN.
Should this instead return -EINTR / -ERESTARTSYS when interrupted by a
signal? Returning -EAGAIN on a blocking socket can cause applications
to fail or spin indefinitely.

>  	}
>  	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);

[ ... ]

>  	if (!psock_has_data(psock)) {
>  		ret =3D sk_udp_recvmsg(sk, msg, len, flags);
>  		goto out;
>  	}

[Severity: High]
This is a pre-existing issue, but does delegating to sk_udp_recvmsg() here
ignore data that might arrive via BPF redirect?

If the socket currently has no data (!psock_has_data(psock)), the fast path
drops into sk_udp_recvmsg(). If the socket is blocking, sk_udp_recvmsg()
will block waiting for data in sk->sk_receive_queue.

If a BPF program subsequently redirects a packet to this socket's psock, the
wait queue is woken up, but sk_udp_recvmsg() only checks
sk->sk_receive_queue. Finding it empty, it will go back to sleep
indefinitely. Can this result in a permanent hang?

> =20
> +	lock_sock(sk);
>  msg_bytes_ready:
>  	copied =3D sk_msg_recvmsg(sk, psock, msg, len, flags);
>  	if (!copied) {
>  		long timeo;
>  		int data;
> =20
>  		timeo =3D sock_rcvtimeo(sk, flags & MSG_DONTWAIT);

[Severity: High]
This is a pre-existing issue, but does this reset the receive timeout on
every loop iteration?

Inside the loop, sock_rcvtimeo() is called to fetch the timeout value.
udp_msg_wait_data() uses this timeout, but drops the remaining time when it
returns.

On the next iteration (for example, due to a spurious wakeup),
sock_rcvtimeo() is called again, reloading the full original timeout from
the socket. Doesn't this break SO_RCVTIMEO semantics by allowing the socket
to block indefinitely if wakeups keep occurring?

>  		data =3D udp_msg_wait_data(sk, psock, timeo);
>  		if (data) {
>  			if (psock_has_data(psock))
>  				goto msg_bytes_ready;

[Severity: Critical]
Does this loop introduce a hard lockup if data is pending in the
ingress_skb queue but not yet in ingress_msg?

If data is queued in psock->ingress_skb but not yet processed into
psock->ingress_msg, psock_has_data() returns true, but sk_msg_recvmsg()
returns 0.

The code then calls udp_msg_wait_data():

static int udp_msg_wait_data(...)
{
    ...
    ret =3D udp_msg_has_data(sk, psock);
    if (!ret) {
        release_sock(sk);
        wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
        lock_sock(sk);
        ...
    }
    return ret;
}

Because udp_msg_has_data() evaluates to true, udp_msg_wait_data() returns 1
immediately WITHOUT releasing lock_sock(sk).

Back in udp_bpf_recvmsg(), the code sees data is non-zero and
psock_has_data() is true, so it jumps to msg_bytes_ready. Because we still
hold lock_sock(sk), no other thread can process the ingress_skb, and
sk_msg_recvmsg() will again return 0.

Can this result in a 100% CPU tight spin loop while holding the socket
lock?

> +
> +			release_sock(sk);
> +
>  			ret =3D sk_udp_recvmsg(sk, msg, len, flags);
>  			goto out;
>  		}
>  		copied =3D -EAGAIN;
>  	}
> +
> +	release_sock(sk);
> +
>  	ret =3D copied;
>  out:
>  	sk_psock_put(sk, psock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612130919.2991=
24-1-jiayuan.chen@linux.dev?part=3D5
