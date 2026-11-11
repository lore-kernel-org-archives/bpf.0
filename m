Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403245;
	b=wmGuMKyxxCa+bzNUk0CRoEJn45NVYFSVG41skh8enPFNc3uKL76G4X3Pd9K3AymF+5Yc
	 1Av2QxMU4z6ahdYtOZgq0iRUrHk/AfGmoO0fXFfRUki2yhUxifLG2udetGtmdeFa1GMoV
	 +MdJukScCvKalADhLIHc144iLVOm9mcqZqGaLS9UhBsULB/BObEjm7Q7Lo70bouUjq5+A
	 3HAJNaUXj7tRxwPdmtkpTubcIKaHSm4pnCQaRhZRfrMrvYnY4dbqZxf3VNdg/NOzaRatX
	 RwzTcHEWhl5JNL4vrRKZQjy0oOX22ZNYe60wJeYjibjJ9VPZ8H5vgYKJfZjR4G9ufWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403245;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lchSdp2ofnPIGPoe0PPFIPAPR9i120roMsUHERsyqZA=;
	b=1jcfYE+bIR1C9ZhPrpuTfEp3x+3GfOnoyXdJJG3o0HJfeXBa2TnIuAaFp9x4tuAw6sGr
	 rGt0BfySS7JsVGluEHFMI2loGp1Au8WmiIMxdBl0fWBB4m8n/hdiX17eu2TedjJ7saBUn
	 ohwBNQjoVH9lIHjfY3g61s9lGaWrDULpKNE2BgFx60FD0btPcg6J4KhSf05/j6Lx/8f5X
	 7h40IB0+y2SFlX9KQSlrNrBIH5O8nyaieZ78xhZE+yb46g1heCcxKpWn3KtWbmYRF9SrA
	 DPm8qyWOLu2RJ8dnjz51/+G17hsozIDb6x49O3MwTFUytOvRncfdZFHGFI9e748GH3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IzSINzS+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32928606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IzSINzS+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A254A1F00A05;
	Wed, 11 Nov 2026 13:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794403244;
	bh=lchSdp2ofnPIGPoe0PPFIPAPR9i120roMsUHERsyqZA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IzSINzS+rH9PWTER2fQsL5MWDRA4lGyg8REmqJQ+xxexmpP2MoECVhW4+S+A9exPH
	 xqlYq3bH/USoaI1E8t6xdZ5DCFDJTaIvpOWbpbLmBvr+3HWFWPdPiEeWQGCh0/LseQ
	 YRgDTwrUXhB39IhPKOmlLN0qrYWUewc+QP4Xw10shuP0oxoKNQnfB1yC1dPQjeVvTn
	 ee1NTr3M/YrCu0QjdLoGssvMMw53Boq51WR0nzE4A13IGqhnKZPkGYMHU40j8Wttc0
	 tAGaOIT3trjtjk+z3euT2Ok/gaNQzO/Dk1SRh9phjdCRohiifWHdk2DPND03X23TDC
	 P4/dPFeSjQJ2Q==
Message-ID: <sashiko-outbox-209058@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH net-next 01/12] net: add an exclusive TCP receive
 claim
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Markuze" <amarkuze@redhat.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261110132006.3280986-2-amarkuze@redhat.com>
References: <20261110132006.3280986-1-amarkuze@redhat.com>
 <20261110132006.3280986-2-amarkuze@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 13:20:44 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] tcp: returning -EBUSY in tcp_disconnect() breaks internal
  callers
- [Medium] net: missing sock_rx_owned() checks in kcm_attach() and
  ovpn_tcp_socket_attach()
--

commit db5306ce28288ea69fe78b0895ec7be46b42bf0b
Author: Alex Markuze <amarkuze@redhat.com>

net: add an exclusive TCP receive claim

This commit adds an optional sk_rx_owner pointer to struct sock so a
tcp_read_sock() consumer can claim exclusive access to a TCP socket's
receive sequence and reject competing readers or operations that reset the
receive stream.

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index df385a5a961e8..5c753bcb808c5 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -754,6 +754,10 @@ struct sk_psock *sk_psock_init(struct sock *sk, int =
node)
> =20
>  	write_lock_bh(&sk->sk_callback_lock);
> =20
> +	if (sock_rx_owned(sk)) {
> +		psock =3D ERR_PTR(-EBUSY);
> +		goto out;
> +	}
>  	if (sk_is_inet(sk) && inet_csk_has_ulp(sk)) {
>  		psock =3D ERR_PTR(-EINVAL);
>  		goto out;

[Severity: Medium]
Should kcm_attach() and ovpn_tcp_socket_attach() also check
sock_rx_owned()?

Like sk_psock_init(), both attach to a TCP socket by checking only
sk->sk_user_data, which remains NULL when sk_rx_owner is set.  Attaching
via kcm_attach() installs a strparser and replaces sk->sk_state_change
with psock_state_change(), which sets sk->sk_err =3D EPIPE on a normal peer
FIN and causes the receive owner to fail with -EPIPE instead of clean EOF.
Attaching via ovpn_tcp_socket_attach() replaces sk->sk_prot and
sk->sk_socket->ops with ovpn_tcp_recvmsg(), bypassing the sock_rx_owned()
checks.

> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 7677b0343abd4..54c30a59bbce4 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -649,6 +649,8 @@ int __inet_stream_connect(struct socket *sock, struct=
 sockaddr_unsized *uaddr,
>  			return -EINVAL;
> =20
>  		if (uaddr->sa_family =3D=3D AF_UNSPEC) {
> +			if (sock_rx_owned(sk))
> +				return -EBUSY;
>  			sk->sk_disconnects++;
>  			err =3D sk->sk_prot->disconnect(sk, flags);
>  			sock->state =3D err ? SS_DISCONNECTING : SS_UNCONNECTED;
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index b9de7c302ba83..6de6ce153fda1 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c

[ ... ]

> @@ -3374,6 +3389,9 @@ int tcp_disconnect(struct sock *sk, int flags)
>  	struct request_sock *req;
>  	u32 seq;
> =20
> +	if (sock_rx_owned(sk))
> +		return -EBUSY;
> +
>  	if (old_state !=3D TCP_CLOSE)
>  		tcp_set_state(sk, TCP_CLOSE);
> =20

[Severity: Medium]
Does returning -EBUSY from tcp_disconnect() break internal callers of
sk->sk_prot->disconnect()?

__inet_stream_connect() already rejects connect(AF_UNSPEC) above before
calling sk->sk_prot->disconnect().  Other callers expect tcp_disconnect()
to succeed unconditionally:

net/ipv4/af_inet.c:__inet_stream_connect() {
    ...
sock_error:
	err =3D sock_error(sk) ? : -ECONNABORTED;
	sock->state =3D SS_UNCONNECTED;
	sk->sk_disconnects++;
	if (sk->sk_prot->disconnect(sk, flags))
		sock->state =3D SS_DISCONNECTING;
	goto out;
}

When a socket connects via non-blocking connect(), sock->state stays
SS_CONNECTING after the handshake reaches TCP_ESTABLISHED.  If a receive
owner is attached and the connection is then closed by a peer RST or
timeout (moving sk->sk_state to TCP_CLOSE while sk_rx_owner is still set),
a subsequent connect() jumps to sock_error:, where disconnect() returns
-EBUSY without cleaning up the socket and leaves sock->state permanently
wedged in SS_DISCONNECTING even after the owner detaches.

__tcp_close() also ignores the return value of sk->sk_prot->disconnect(sk,
0) on a zero-linger close and assumes it moves sk->sk_state to TCP_CLOSE.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110132006.3280=
986-1-amarkuze@redhat.com?part=3D1
