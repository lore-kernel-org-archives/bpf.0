Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25AF4071CE
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780739415; cv=none; b=LfWSO4ef9L3/avni/s98Ai5GRLxcmaGzZQD81Yq6VtQZAAEaLA0UNzCZYxqKaCJaoLn7y3RJ9KN3wGcK1FdbpjROeCWCU++VlxKEzuBcMFX8eVXJ8V3bhc0p/wnzkoy118Un8TpE/G5y6X8C0DB9orZoDYNtGvyYTrnfYwRRkyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780739415; c=relaxed/simple;
	bh=RlHLtb2FCPE3urLWvY6XLS54lrbWLvXXCjox8oRj9OM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SjYKFN7FR6o57izHJWmHdCRipfX/EamhFbwXBpxb6nrPb2Qq5MzhAweH8RPQfm3ZoGOV7eJIs7idev6iLGpZczAl7Hm8fRxJNDUQUhntDq3ub/y2/IGYgtJDM7MpyYZyTU1GOjMoj6F52QGcIV5HLJx3YsZ2nQ1Vpy+g8feTDSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNicfvIQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNicfvIQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2531B1F00893;
	Sat,  6 Jun 2026 09:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780739414;
	bh=+OUiEJMaOvdA+efAiM4aWGlyhSXS11dFuJCys+MWlug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JNicfvIQjJUuntI5ef2q0L+0CmyNfU5j0r+g+P6Hy6GIbRgtoikZtwzFYMuBUYEAQ
	 rj4xAgoQoFdge7MWuy/HXJqfte5G4x8cB9HItrHsD5YvMCNdiQ43brsX513YQW+MSY
	 3YBRQoRWylaxE3Z2Y7oiOGwCJc6XtQH33h1McbLALedLe5yms/0HWCAUcXjcm5Yo14
	 Bbmw6hb3NdJFEjJtTf3wKPIXkDKSx+/ik5SRnLLmVsaUdmbJkixNLLOSFNnW7H0OjD
	 sb5X/+tsYkNZlrgCtxFovhkihEYNM+GKK9QNnQdasWX1jp2ZNSHzVJlaeCAoNTHMNg
	 dmIEQ09BnJ74Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] tcp: clear sock_ops cb flags before force-closing a
 child socket
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605094954.1374489-1-rhkrqnwk98@gmail.com>
References: <20260605094954.1374489-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 09:50:13 +0000
Message-Id: <20260606095014.2531B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] If a child socket setup fails before `tcp_ca_openreq_child()` =
is called, destroying the socket causes a congestion control module refcoun=
t underflow.
- [High] The exact same lockdep warning (`sock_owned_by_me`) remains unfixe=
d in the `chtls_recv_sock` error path in the Chelsio TLS driver.
- [Medium] MPTCP subflow teardown fails to clear `bpf_sock_ops_cb_flags`, c=
ausing unintended BPF callbacks to execute on an unestablished child socket.
--

commit b448fd7ed4a1cfbee891642b3982415ce61f7c83
Author: Sechang Lim <rhkrqnwk98@gmail.com>

tcp: clear sock_ops cb flags before force-closing a child socket

This commit fixes a lockdep warning by clearing the inherited
bpf_sock_ops_cb_flags in the IPv4 and IPv6 syn_recv_sock error paths
before force-closing the child socket.

> The child is freed before it is ever established, so it should run no
> sock_ops callback. Clear its cb flags before the forced close.

[Severity: High]
This is a pre-existing issue, but does the Chelsio TLS driver also need
this fix?

Looking at chtls_recv_sock() in
drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c, the free_sk
error path uses the exact same sequence without clearing the flags:

free_sk:
	inet_csk_prepare_forced_close(newsk);
	tcp_done(newsk);

Since the socket lock is dropped by inet_csk_prepare_forced_close(),
wouldn't tcp_done() trigger the exact same lockdep warning if
BPF_SOCK_OPS_STATE_CB_FLAG was inherited?


[Severity: Medium]
This is also a pre-existing issue, but does MPTCP subflow teardown need
to clear these flags to match the intent that embryonic sockets should
not run BPF callbacks?

In net/mptcp/subflow.c:subflow_syn_recv_sock(), the dispose_child path
calls tcp_done() on the child socket without clearing the inherited flags:

dispose_child:
	mptcp_subflow_drop_ctx(child);
	tcp_rsk(req)->drop_req =3D true;
	inet_csk_prepare_for_destroy_sock(child);
	tcp_done(child);

While inet_csk_prepare_for_destroy_sock() maintains the socket lock
(avoiding the lockdep warning), it still allows tcp_done() ->
tcp_set_state() to execute BPF callbacks on the unestablished socket.

> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index fdc81150ff6cf..7748668dba829 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
[ ... ]
> @@ -1783,6 +1783,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock=
 *sk, struct sk_buff *skb,
>  	return NULL;
>  put_and_exit:
>  	newinet->inet_opt =3D NULL;
> +	tcp_clear_sock_ops_cb_flags(newsk);
>  	inet_csk_prepare_forced_close(newsk);
>  	tcp_done(newsk);
>  	goto exit;

[Severity: Critical]
This is a pre-existing issue, but could this error path cause a congestion
control module refcount underflow?

When a child socket is cloned via sk_clone_lock(), it inherits the
listener's icsk_ca_ops via a shallow copy, but the module reference count
is not incremented at that time. The refcount is incremented later during
tcp_ca_openreq_child().

If an error occurs before tcp_ca_openreq_child() is reached, such as
inet_csk_route_child_sock() failing earlier in this function:

	dst =3D inet_csk_route_child_sock(sk, newsk, req);
	if (!dst)
		goto put_and_exit;

We jump to put_and_exit. The teardown path (tcp_done() ->
tcp_v4_destroy_sock() -> tcp_cleanup_congestion_control()) will then
unconditionally call:

	bpf_module_put(icsk->icsk_ca_ops, icsk->icsk_ca_ops->owner);

Does this drop a module reference that was never acquired?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605094954.1374=
489-1-rhkrqnwk98@gmail.com?part=3D1
