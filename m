Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD74B35CB73
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 18:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777661092; cv=none; b=jU9irpOAUU12u2A+IM6AgEHjhRrwvjQGacvKfG9q3hBJ24aayRGzwj8BMhluzWWZ5KuqFCkiSzfQeMwg8iodMWKiEO/dMpafgoXPHI8kHZGX0BmxeLTtwsq7DwdosN4eRcpRa7+jDx6iiUZ0XHsUFwMeEQ8tnSI0sI+VDLyVbP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777661092; c=relaxed/simple;
	bh=JQk4+GhFHFRJ4ZTW/0FqFjkzc8BKl8px4vdifRlWIRw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WdxX/J1wUmt3n1RUKRpv5F1IZo9WqsQZY42pin6kFa23pkuL94Q3H2qaIVGGiDBzg7YD3MRgMKrgseUL4Bg1SZsTPXzokXeYj2oxJLexePt7+5EtDwDKh48Z9w5C7/XEaeKgNBEF9O0SpDR/JuADE1xzqi2KFx9JW0Eltrj4p80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9nPqyS6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9nPqyS6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F46FC2BCB4;
	Fri,  1 May 2026 18:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777661092;
	bh=JQk4+GhFHFRJ4ZTW/0FqFjkzc8BKl8px4vdifRlWIRw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=j9nPqyS6ofMqrgs/CN0XVzJ7N4zOToE7SpvQ1G7gRutKxXEFuq4NA5fRyD9kYxrRj
	 4eDvrwnBtTTfY0YEVzNpAZWz6E90l0yyLBQr8vJ/xVIzWrq0iKSTIGaRyDDkLrOCgg
	 w8V0GF9Js/Mxko7CF1dJ+TFx4VaWT86Z4QOcNSoqfVf+kqY8DNYbrudqC3Xnw+2lgt
	 am54Eq/SKOeAjP+Y3nJ3TS6sCzeFy8Z7qaKQsZ+XPVyurt8VhQ0cb17Xy/vu3PgMsV
	 xoGM4iNV85qjmoG2CVkJEC8mbmZLs1EG/kWl0p0b863NMn5o0016eO3nZWtjQA4Z+V
	 s4z2rhWn799KQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 bpf 1/2] bpf: tcp: Fix type confusion in
 bpf_tcp_sock().
Reply-To: sashiko@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260430184405.1227386-2-kuniyu@google.com>
References: <20260430184405.1227386-2-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 18:44:51 +0000
Message-Id: <20260501184452.7F46FC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Incomplete fix: `sol_tcp_sockopt()` remains vulnerable to slab out=
-of-bounds access.
- [High] Missed vulnerability: `bpf_skc_to_tcp_sock()` and `bpf_skc_to_tcp6=
_sock()` suffer from the exact same type confusion.
- [High] Missed vulnerability: `bpf_mptcp_sock_from_subflow()` suffers from=
 the same type confusion and causes immediate OOB reads.
--

commit 72139ec7da09274112730adc692a99e89ef3eb2e
Author: Kuniyuki Iwashima <kuniyu@google.com>

bpf: tcp: Fix type confusion in bpf_tcp_sock().

This commit updates bpf_tcp_sock() to use sk_is_tcp(sk) instead of just
checking if the protocol is IPPROTO_TCP. This prevents RAW sockets from
causing out-of-bounds access to slab objects.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index bc96c18df4e03..cd88633f8dc14 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7475,7 +7475,7 @@ u32 bpf_tcp_sock_convert_ctx_access(enum bpf_access=
_type type,
> =20
>  BPF_CALL_1(bpf_tcp_sock, struct sock *, sk)
>  {
> -	if (sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP)
> +	if (sk_fullsock(sk) && sk_is_tcp(sk))
>  		return (unsigned long)sk;

Since ctx->sk evaluates to PTR_TO_SOCKET in a CGROUP_SOCKOPT program,
and is directly accepted by bpf_setsockopt() and bpf_getsockopt() via
ARG_PTR_TO_BTF_ID_SOCK_COMMON, does sol_tcp_sockopt() still remain
vulnerable?

Looking at sol_tcp_sockopt(), it appears to only check
sk->sk_protocol =3D=3D IPPROTO_TCP. Can a user create a RAW socket with
IPPROTO_TCP and directly pass ctx->sk to bpf_setsockopt(), bypassing
bpf_tcp_sock() entirely and triggering the same slab out-of-bounds
access?

Additionally, do bpf_skc_to_tcp_sock() and bpf_skc_to_tcp6_sock() suffer
from the same type confusion?

They appear to continue checking sk->sk_protocol =3D=3D IPPROTO_TCP without
verifying sk->sk_type =3D=3D SOCK_STREAM. Could a BPF program pass a RAW
socket with IPPROTO_TCP to these helpers and receive a valid BTF
pointer to struct tcp_sock, allowing out-of-bounds slab reads?

Finally, does bpf_mptcp_sock_from_subflow() in net/mptcp/bpf.c also need
a similar update?

It checks sk->sk_protocol =3D=3D IPPROTO_TCP and immediately evaluates
sk_is_mptcp(sk). Since sk_is_mptcp() indiscriminately casts the socket
to struct tcp_sock and accesses tcp_sk(sk)->is_mptcp, passing a RAW
socket could trigger an immediate out-of-bounds slab read.

If this memory happens to be non-zero, it might proceed to call
mptcp_subflow_ctx(sk)->conn, which would read a garbage pointer from
out-of-bounds memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260430184405.1227=
386-1-kuniyu@google.com?part=3D1
