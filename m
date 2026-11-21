Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795258436;
	b=remaiHigZz3ztYbWyLCdXtnTNgqtHlbHSBie/rDkgZr8+HnbGcuFb5VN0Y5MJ9IYlCbx
	 h1VDTHPR5Q7yhzNzadTOXc+ygrJqxpyIN8oXLFiFebVgBw0dNXl5puPs2Gee/0T90m1UC
	 0tWoPpe0O7/VJFkjjsRCjJO0zmx0sX7R/BhYIbhcCMxN2N/L2bwQhi4YyjB7o5FqcLiBa
	 QHrEn4qeGgrRcm4qTziyoIYBIsc8T/nGqwkfrZf7ycOOYc3MXAgbKXWDsfoXDZnTHGyZL
	 R2znUaOCX8/bkvD2dsRL+hq66hwDpaHWKjumu8UfOssXbKeM8+tKaZ1ktMhhptJeBvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795258436;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LZUQvLbgzRBynzxMrVCnD4/tt8uQLsR+IJqriHcD9lY=;
	b=KWP2sQuvlBJZK2oKKUnZP6lB42woGZoBUatnT47l4ZURDgsDcNPtkHxY0g3ddQ+KWXcW
	 JtX/8ayuY2pmWHQV/QO4BsXZ2D7r2SRtJS3qU4QrIgOgKkviZPBzeUVr4OYoHFhlb2xxG
	 HanzZ1jZN7lVwCXZU3MK/dDx8KWntXnvCyIUSQ/exy69CRkVspjzXLtKPjs6Dz3hZ6U7U
	 xN3m9tmR9pXKuZ2acDUxYGq/uIrN/h1SxvPRvuITDtaoG+fSTVKr1n9NjxW7RMn52SYFA
	 B9zd0w/pY0H6Hjq60iI4XvLj9+E/py1LTT0xzUNUGFn7NBFyHDs7XkySwTx6zz/J0Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="a/Ns2hPi";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC14606A320
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 10:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a/Ns2hPi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42011F000C0;
	Sat, 21 Nov 2026 10:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795258435;
	bh=LZUQvLbgzRBynzxMrVCnD4/tt8uQLsR+IJqriHcD9lY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=a/Ns2hPiWcbjVPKRYEcFzuEGLB1rrflvX4Kh+R2uhsN68Y3JD9jb/moJmrp0g4HWI
	 TFPGrsUc+8JRT2m9rWNqEO8AUl6DnF/4hyLKCu39zc+g738LRY5Y7J07P8MqF5Fh0x
	 Pl+jRT4vX+GskZNRj5V1bOMVv7lOHE0UFdaSWCw9WPJubZRY7UP3atlvW40IuaaF/D
	 N6HACw13WH+fjHz2SdkHVoZmrRQFFqt3hBOhGkGBKVFBKAi32tYDQDhqDSNw5LesnL
	 8sl2cNjSaum6aljhjYjJvpqQBoMbBz/K+lo4soHwWO3ifHnu5rCzVKql3RkC0sohCd
	 cPT52TT00pT3g==
Message-ID: <sashiko-outbox-226959@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 05/11] bpf, sockmap: Fix concurrent senders on one
 psock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
In-Reply-To: <20261121103222.88209-6-jiayuan.chen@linux.dev>
References: <20261121103222.88209-1-jiayuan.chen@linux.dev>
 <20261121103222.88209-6-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 10:53:55 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] bpf, sockmap: -EBUSY from tcp_bpf_sendmsg() aborts
  sk_psock_backlog()
--

commit d941631cdccff7e72d215bc4dd09b124e439b443
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

bpf, sockmap: Fix concurrent senders on one psock

This commit adds an SK_PSOCK_TX_BUSY state bit to reject concurrent
callers of tcp_bpf_sendmsg() on the same psock with -EBUSY.

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 7191b95c7b1c7..077b65927ac8d 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -602,6 +602,16 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct m=
sghdr *msg, size_t size)
>  	if (unlikely(!psock))
>  		return tcp_sendmsg(sk, msg, size);
> =20
> +	/*
> +	 * The verdict, apply_bytes, sk_redir and the cork live in the psock
> +	 * and span the places where the socket lock is dropped below. They
> +	 * can only serve one sender at a time.
> +	 */
> +	if (test_and_set_bit(SK_PSOCK_TX_BUSY, &psock->state)) {
> +		sk_psock_put(sk, psock);
> +		return -EBUSY;
> +	}

[Severity: High]
Can returning -EBUSY here abort sk_psock_backlog() when an sk_buff is
redirected to the egress of a socket that also has a msg_parser program
attached?

For egress sk_buff redirects, sk_psock_handle_skb() sends the packet via
skb_send_sock() -> sendmsg_unlocked() -> sock_sendmsg() ->
tcp_bpf_sendmsg().  Previously, skb_send_sock() and a userspace sendmsg()
on that socket serialized on lock_sock(sk).  With this change, when a
userspace sender sleeps in sk_stream_wait_memory() with SK_PSOCK_TX_BUSY
set and freeing send buffer space wakes sk_psock_write_space(), the
backlog work runs and hits -EBUSY:

CPU0 (userspace sendmsg)          CPU1 (psock->work)
tcp_bpf_sendmsg()
  test_and_set_bit(SK_PSOCK_TX_BUSY, ...)
  lock_sock(sk)
  ...
  sk_stream_wait_memory()
    release_sock(sk)
                                  sk_psock_backlog()
                                    sk_psock_handle_skb()
                                      skb_send_sock()
                                        ...
                                          tcp_bpf_sendmsg()
                                            test_and_set_bit(SK_PSOCK_TX_BU=
SY)
                                            return -EBUSY

sk_psock_backlog() only retries on -EAGAIN and treats any other error as
fatal:

net/core/skmsg.c:sk_psock_backlog() {
	...
			if (ret <=3D 0) {
				if (ret =3D=3D -EAGAIN) {
					...
					goto end;
				}
				/* Hard errors break pipe and stop xmit. */
				sk_psock_report_error(psock, ret ? -ret : EPIPE);
				sk_psock_clear_state(psock, SK_PSOCK_TX_ENABLED);
				goto end;
			}
	...
}

This sets sk->sk_err =3D EBUSY (which also aborts the sleeping userspace
sendmsg()) and permanently clears SK_PSOCK_TX_ENABLED, stranding queued
packets in psock->ingress_skb.  Conversely, if sk_psock_backlog() sets
SK_PSOCK_TX_BUSY first, a single userspace sender on the socket fails
with -EBUSY instead of waiting on lock_sock(sk).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121103222.8820=
9-1-jiayuan.chen@linux.dev?part=3D5
