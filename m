Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7B5421EF8
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788517203; cv=none; b=jh0o/qChKvI2YeTxb1nDLRDxtaaZ04G51MU2IJel/DUh9a70/fvBXqrInsNxijO1xqV6Le+vnzoWGGtvqst/EZm75bAHQuu93is0hT+fvgH8eD2kdLOR50Q2A8fpkGmjtIUeSQNqVWmnY83v8ubq8DDjmETM5UDlTyYiyjTQ97w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788517203; c=relaxed/simple;
	bh=Jprzx/SzhQX/YeXrJG4V+qyALTc9BSYG/yYE/yiQ9bY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O6EiCNBuOMpd/6tqkFTvZGLMo9io6pwOjli4oV6GZRXslxX4PGJ23BiPISUzMLLwMV1SmErNxKcRMIkCzOJr9vjpprCnGQhKRtaohva/xbqFwCiyoz4QWdaDZyrb8lxsM/VndaVJZv4S06r2noO6JVam8x81JXnM/BOeNirIwMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hClYALz7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hClYALz7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE741F00A3D;
	Fri,  4 Sep 2026 10:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788517198;
	bh=9TCl79eTtLWqLm7FnAa03AholdqZupu1fcb6w2vRSXA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hClYALz71Iz9Q3W3Zt/k2eBOMJAzkfUUWKdRZwct4wKx3D3F+jrrXqAheZk2dKnBg
	 aYQfxpIdgiayFRBwmYO/RpDRDc25Wu/wtJTXJJqRhPEK8NY2CcX7MXR5QpFb6MsrFe
	 /rDmVHYCEU7ijEmKy82Idg6AxigAca5byb6y7zH3UIwW8fKUD4FZpPU38gVj9AT/vQ
	 mCXZMzWeGfwBgjiZ8P/R7doMO/t9hDAFYXts2q7Xn07yjJII1BhSS0oZil26Lex+SU
	 7pBf61WwObpd+F3F/bt8I+YtpgvZqiVwaxvdNkUcLwsF64GlrQjnUdyl4OVVWDz+pM
	 IIf6g9fw7IC8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix out-of-bounds read of sk_protocol
 in bpf_sock_destroy()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260904094954.63447-1-jiayuan.chen@linux.dev>
References: <20260904094954.63447-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 10:19:57 +0000
Message-Id: <20260904101958.2BE741F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] bpf_sock_destroy bypasses socket locking for iterators that do not=
 pre-lock the socket, leading to data corruption and kernel panics.
- [High] Calling cond_resched() while holding rcu_read_lock() via bpf_sock_=
destroy() on TCP_LISTEN sockets.
--

commit 1a9df13e7482333dfb4a7ad04982dba6254ff808
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

bpf: Fix out-of-bounds read of sk_protocol in bpf_sock_destroy()

sk_protocol lives in struct sock, not in struct sock_common. A timewait
or request sock handed to bpf_sock_destroy() by the tcp iterator is
neither, so reading sk->sk_protocol runs past the object.

Closes: https://lore.kernel.org/bpf/20260702224519.800135-1-xmei5@asu.edu/

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 61940e7535523..a41cc60a401a5 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
[ ... ]
> @@ -12925,8 +12926,12 @@ __bpf_kfunc int bpf_sock_destroy(struct sock_com=
mon *sock)
>  	 * Supporting protocols will need to acquire sock lock in the BPF conte=
xt
>  	 * prior to invoking this kfunc.
>  	 */
> -	if (!sk->sk_prot->diag_destroy || (sk->sk_protocol !=3D IPPROTO_TCP &&
> -					   sk->sk_protocol !=3D IPPROTO_UDP))
> +	if (!sk->sk_prot->diag_destroy)
> +		return -EOPNOTSUPP;
> +
> +	if (sk_fullsock(sk) &&
> +	    sk->sk_protocol !=3D IPPROTO_TCP &&
> +	    sk->sk_protocol !=3D IPPROTO_UDP)
>  		return -EOPNOTSUPP;
> =20
>  	return sk->sk_prot->diag_destroy(sk, ECONNABORTED);

[Severity: High]
This is a pre-existing issue, but does this invoke the protocol's destroy
handler without proper locking?

The bpf_sock_destroy() kfunc can be called from iterators. It calls the
protocol's diag_destroy() handler:

net/core/filter.c:bpf_sock_destroy() {
    ...
    return sk->sk_prot->diag_destroy(sk, ECONNABORTED);
}

For TCP sockets, this resolves to tcp_abort(), which skips acquiring the
socket lock because has_current_bpf_ctx() is always true inside a BPF
program:

net/ipv4/tcp.c:tcp_abort() {
    ...
    if (!has_current_bpf_ctx())
        lock_sock(sk);
    ...
}

While some iterators pre-lock the socket, others (like sockmap iterators) do
not. Does this result in tcp_abort() running lockless and potentially
corrupting socket state?

Additionally, if a raw socket with IPPROTO_TCP is passed, raw_abort() is
invoked instead, which unconditionally calls lock_sock():

net/ipv4/raw.c:raw_abort() {
    ...
    lock_sock(sk);
    ...
}

Since iterators run under rcu_read_lock(), will this sleep in an atomic
context and trigger a BUG?

[Severity: High]
This is also a pre-existing issue, but can this call cond_resched() while
holding an RCU read lock?

When bpf_sock_destroy() processes a TCP socket in the TCP_LISTEN state,
it calls tcp_abort(), which then calls inet_csk_listen_stop():

net/ipv4/tcp.c:tcp_abort() {
    ...
    inet_csk_listen_stop(sk);
    ...
}

Inside inet_csk_listen_stop(), there is a loop that explicitly yields:

net/ipv4/inet_connection_sock.c:inet_csk_listen_stop() {
    ...
    cond_resched();
    ...
}

Since bpf_iter_run_prog() runs iterators under rcu_read_lock_dont_migrate(),
will calling cond_resched() from this atomic context trigger a "sleeping
function called from invalid context" BUG?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904094954.6344=
7-1-jiayuan.chen@linux.dev?part=3D1
