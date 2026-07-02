Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B6534844C
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 23:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783033505; cv=none; b=gNsn7smPLJStNbwZI/hslXmduBrfRUVeSEQkiQubCYSL0iJ7pdYbRyq+Hry/enxza/9bF+ekcOiuvS7kXOz/3i8Ayv7Xy9XIUgL0nM4SJym40ASZbm0GqYYn8TGtwr/zIr0310Kj9vQRSqdo+O7YLUTaD1nvt5EK2/ihXuzIUOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783033505; c=relaxed/simple;
	bh=H5mgFl2LCuOqwp/U5iynsD2QG6RV9g7gzpZ9WA8BfJ4=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S2fqsLg+ARk7SjqQy8Vtk/R2oAzSjqGleX7Km3RSyGq/gIM9+8EujzmKRtDoqlHrfs/od6GBD8WyYWp72jvxLXemSefNrTO2ImEOchBtIRBDt5Kk8zUVjjf6yczEsRSDOcEmyqjTY8DXTCA/m4xBvVwIXl23McwojwKx3d/CAYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZrztpaD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZrztpaD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E65E1F000E9
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 23:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783033504;
	bh=S9xN5YUJS1DiysmzH/dJ17eoC1oih3pKcwXfQ9IKoJ0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=PZrztpaD4NlTWzWDFYdIQxGhW97VQhSPNZn+bsoqtsiuG7WoqK4WUsmPDyxwGBpZJ
	 8Nshw8crYr6cPh6qy//PN8hea1ZpPpBuiQcci3zlyOmkP0+ormuj/a1lbYsh3UDjru
	 hO7Dryu+KKVn3TqoS9UDK/J/lUNaG2T1qozxZdb1Z1As/amwI9jLjQfSB4/E20watJ
	 plJEStNVTnXd8He64AzOqGUNpsEi8kQiGQHzsRdujL/qiIDHFc0ctyG77PU7y72rMT
	 tHG+kdBov7Ebe4ZGwNEHkdBt8bkM1HwY86a1ATZ5EBXWdKoQvrRYC2oCcT6WnP4NbG
	 CTyXT5GYKLEHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: reject mini-sockets in bpf_sock_destroy()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <20260702224519.800135-1-xmei5@asu.edu>
References: <20260702224519.800135-1-xmei5@asu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 23:05:03 +0000
Message-Id: <20260702230504.0E65E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch causes a functional regression by completely disabling b=
pf_sock_destroy() for TCP mini-sockets (TIME_WAIT and NEW_SYN_RECV).

Pre-existing issues:
- [High] The helpers bpf_tcp_check_syncookie and bpf_tcp_gen_syncookie suff=
er from the same type confusion and out-of-bounds read as bpf_sock_destroy,=
 but remain unfixed.
--

commit cf46da8728e7f1fca4584ccdb089c82b7fd3061f
Author: Xiang Mei (Microsoft) <xmei5@asu.edu>

bpf: reject mini-sockets in bpf_sock_destroy()

The patch tries to fix a KASAN slab-out-of-bounds read in
bpf_sock_destroy() by checking sk_fullsock(sk) before accessing
sk->sk_protocol. It casts sock_common to sock and early exits if it is
a mini-socket.

Fixes: 4ddbcb886268 ("bpf: Add bpf_sock_destroy kfunc")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>

> diff --git a/net/core/filter.c b/net/core/filter.c
> index b446aa8be5c37..3e70c8ab5aab1 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12665,6 +12665,9 @@ __bpf_kfunc int bpf_sock_destroy(struct sock_comm=
on *sock)
>  {
>  	struct sock *sk =3D (struct sock *)sock;
> =20
> +	if (!sk_fullsock(sk))
> +		return -EOPNOTSUPP;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^
[Severity: High]
Does this unconditionally reject mini-sockets?

The commit message states that mini-sockets have no diag_destroy() handler,
but as documented in the original commit 4ddbcb886268, request sockets are
explicitly supported because their protocol diag_destroy handler
(tcp_abort) correctly handles TCP_TIME_WAIT and TCP_NEW_SYN_RECV states.

If we unconditionally reject non-full sockets, wouldn't this break BPF
programs that rely on bpf_sock_destroy() to forcefully terminate pending
connections or TIME_WAIT sockets?

[Severity: High]
This is a pre-existing issue, but does this same type confusion exist
in bpf_tcp_check_syncookie() and bpf_tcp_gen_syncookie()?

Both of those helpers take ARG_PTR_TO_BTF_ID_SOCK_COMMON and cast it to
a full struct sock *. They then immediately dereference sk->sk_protocol
without an sk_fullsock() check:

net/core/filter.c:bpf_tcp_check_syncookie() {
    ...
	if (sk->sk_protocol !=3D IPPROTO_TCP || sk->sk_state !=3D TCP_LISTEN)
		return -EINVAL;
    ...
}

If an XDP or TC BPF program passes a tw_sock or req_sock from
bpf_skc_lookup_tcp(), won't this result in the same KASAN
slab-out-of-bounds read since sk_protocol resides outside the bounds
of struct sock_common?

> +
>  	/* The locking semantics that allow for synchronous execution of the
>  	 * destroy handlers are only supported for TCP and UDP.
>  	 * Supporting protocols will need to acquire sock lock in the BPF conte=
xt

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702224519.8001=
35-1-xmei5@asu.edu?part=3D1
