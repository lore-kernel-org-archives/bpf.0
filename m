Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A3251D53C
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788801259; cv=none; b=p2tmGa/Lfa6+R2OV7SIsS6FajPKerATD50GMbLDy1DbJGx/i8bGxKzPLZdUSkG05rAlQ7aNeRVbN8ZDLTux580SdRXec16vDStvF7elkVE01IAhOAFxQy13bkRePD+bOa5pJU0zjMVTzIitGM9r7mV4TlAQB0+m1zrqxXw5GxgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788801259; c=relaxed/simple;
	bh=/C6diKm3AvCNrAtgLNV4FW1ctWv1KG1asdrs+zzomUY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XJOsdZXY9HCPHxov3+CUBF422ZqEM0v5dZcezMGpgySZOMMGf/GslgxnJtP0IsyyJA8t3zc130Z4S0ZKD7aF50Ih6++FoXzCfWinjg6nUCHQPTPu/dliLssqjl4UR0JKaBWrVvPcNkFFxk0MApREosSolXLiwM+KDyZ/rcOpMt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D16Ezudz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D16Ezudz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559201F00A3A;
	Mon,  7 Sep 2026 17:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788801257;
	bh=YPNFv5NiwNqKetL1kLced8l9fgD3o0o3Qc/Za6UY1lQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D16Ezudz+HfiBrC2JB0xCwN3SBUhi46mE+/A+v+Q0oD0GNpCj9iLjsW+PiIKHIyE2
	 y8YNB1Ua3VAMvbOfd2kVkKCUZNMA4hppQHThBkdRQQDJ7UmIisIhKQIqmFbC1lsXhK
	 Xiy+56NoIU7peL8Pg/2zsUA+OnfSk7oa2mbqtnP8kbOlBNgZP6KRh3p4LL4Q+/uUQi
	 KaZ4Om8CzhqOyZNF4UDOzzEADJwrNRG0YPqjlHMAv0ikyuSClvD55QWKj075wjSXWw
	 ZlPr9VDsPfUmItmSJBMg18ZXTk+k42qggzQMXpNuNBxx8tvdWhYMs0JbymmZt3BEGc
	 eaWgMLazVC8Hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y] tcp: clear sock_ops cb flags before
 force-closing a child socket
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlndWVsIEdhenF1ZXogKFNjaG5laWRlciBFbGVjdHJpYyk=?= <miguel.gazquez@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260907-cve-2026-74268-v1-1-cacea38d7fb3@bootlin.com>
References: <20260907-cve-2026-74268-v1-1-cacea38d7fb3@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 17:14:16 +0000
Message-Id: <20260907171417.559201F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Calling tcp_clear_sock_ops_cb_flags() unconditionally on non-T=
CP sockets (like DCCP) causes an out-of-bounds write due to an invalid stru=
ct tcp_sock cast.
--

commit a1e4666cc30271c086f6d9e64c6ebfaddd6750ca
Author: Sechang Lim <rhkrqnwk98@gmail.com>

tcp: clear sock_ops cb flags before force-closing a child socket

A child socket inherits the listener's bpf_sock_ops_cb_flags via
sk_clone_lock(). If its setup fails in tcp_v4_syn_recv_sock() /
tcp_v6_syn_recv_sock(), the child is freed through put_and_exit, where
inet_csk_prepare_forced_close() drops the socket lock and tcp_done() runs
without it.

Link: https://patch.msgid.link/20260611092923.1895982-1-rhkrqnwk98@gmail.com

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 1cc25e0b3bdea..c472c1cdd3b83 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
[ ... ]
> @@ -2702,6 +2702,11 @@ static inline int tcp_call_bpf_3arg(struct sock *s=
k, int op, u32 arg1, u32 arg2,
>  	return tcp_call_bpf(sk, op, 3, args);
>  }
> =20
> +static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
> +{
> +	tcp_sk(sk)->bpf_sock_ops_cb_flags =3D 0;

[Severity: Critical]
Does this code perform an unsafe cast and memory write for non-TCP sockets?

This accesses an offset that exceeds the bounds of a dccp_sock when
invoked on DCCP sockets, which writes outside the slab allocation for the
socket structure.

> +}
> +
[ ... ]
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index 91dcdb7567ace..e0bd8e76fa781 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
[ ... ]
> @@ -1315,6 +1315,14 @@ void inet_csk_destroy_sock(struct sock *sk)
>  }
>  EXPORT_SYMBOL(inet_csk_destroy_sock);
> =20
> +void inet_csk_prepare_for_destroy_sock(struct sock *sk)
> +{
> +	/* The below has to be done to allow calling inet_csk_destroy_sock */
> +	tcp_clear_sock_ops_cb_flags(sk);

[Severity: Critical]
Can calling this unconditionally on non-TCP sockets cause memory regression=
s?

This generic connection socket destruction path in
inet_csk_prepare_for_destroy_sock() blindly invokes a TCP-specific helper,
passing it sockets (like DCCP) that are incompatible with the TCP socket
structure.

This can be triggered by a remote, unauthenticated attacker sending a
malicious or unroutable DCCP connection request to a listening DCCP port.

The regression is triggered on the failure path of DCCP connection setup,
for example when routing fails:

net/dccp/ipv4.c:dccp_v4_request_recv_sock()
   ...
   put_and_exit:
        ...
        inet_csk_prepare_forced_close(newsk);
            inet_csk_prepare_for_destroy_sock(newsk);
                tcp_clear_sock_ops_cb_flags(newsk); /* out-of-bounds write =
*/

> +	sock_set_flag(sk, SOCK_DEAD);
> +	this_cpu_inc(*sk->sk_prot->orphan_count);
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-cve-2026-7=
4268-v1-1-cacea38d7fb3@bootlin.com?part=3D1
