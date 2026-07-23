Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED75456E01
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823629; cv=none; b=I/V4wCuFA0iLZrkuhTUri99Xo1IqNXpeiUxIPlJKG+Ym8PhbO4Svx1ADnOi8TgrKWVgbartqysX8y6tEQeBDTMkzU+iZUANMIcNxZGjh+LNnnlNkG7DsFm1lq+PuB8f472IoN18lxBH9XI+0UZtLjKpbPYoZw1JfONRFF0NfqZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823629; c=relaxed/simple;
	bh=MezP9+dGwbnDz6GmYRykvvKRowAUHjfwgfyXpefNFUI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BodlbWef+tDhpvoPdXUpLwzf6OX23YivlwAjm4/dNw/XwIzWK1lwqcxqoR6xqG+6Q9/oc4UP+BgMmGsOCAAaTkqi2pVSf/l+1+zN/1VepBBzBPeXurefuHnOc2vxGFOaL26ezw75kBOpEtwfO3q8g1FvMYQ+Lt5UFTKBR1QESiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLxEoNJa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLxEoNJa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB4D1F000E9;
	Thu, 23 Jul 2026 16:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784823621;
	bh=YX3xyTrAHou0gVB9rPxOezrjw+rTfTw5L1BREdKdjBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RLxEoNJaHO60QpjHdaAnWCa5oVagCx9MUAUg4ndpFNvmGdtJ0UJjZkboA/DDHZWgo
	 VM6yPxcpLMNRvpxMK+ESphsfPslas+k2Kr6+Lev0BdvkQ1S72fCKRol/FDSxyopXqS
	 GYNBPkrw8By+qLb134QhPmawTUBLF0kzgwkWUGQqOnWhxCyuvJqdgnZees4oGlOCaB
	 eTlxA01cBHu0R+1zrziuqcLXlQp7nRX9le+0zVUTs+nLhO4Ub6LMBDyDDGuwZPHFIl
	 4w2W1DM7VoqFUAuYQvUh8QZxfFbctSOmo9HXhVJ/vuY4D0SkIIAWLqP2LNIIt6T/y3
	 mdpifrj5mby0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 3/3] bpf: Unconditionally take socket references in
 lookup helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260723-sockmap-lookup-tcp-leak-v1-3-1bbdc58ce514@rbox.co>
References: <20260723-sockmap-lookup-tcp-leak-v1-0-1bbdc58ce514@rbox.co>
 <20260723-sockmap-lookup-tcp-leak-v1-3-1bbdc58ce514@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 16:20:20 +0000
Message-Id: <20260723162021.3BB4D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] bpf_sk_assign() and sock_pfree() are vulnerable to the exact same =
reference leak via SOCK_RCU_FREE state transition that this patch fixes for=
 bpf_sk_release().
--

--- Patch [3]: [PATCH bpf 3/3] bpf: Unconditionally take socket references =
in lookup helpers ---
commit a73ae21a3d81c1ea14d30abf4a0636c703e1fcfa
Author: Michal Luczaj <mhal@rbox.co>

bpf: Unconditionally take socket references in lookup helpers

This commit addresses a socket reference leak in BPF lookup helpers.
A socket refcounted at acquire time can gain SOCK_RCU_FREE before release,
causing the release to skip the put. The patch makes acquire and release
unconditional to fix this issue.

Closes: https://lore.kernel.org/bpf/20260701235552.2B0AA1F00A3F@smtp.kernel=
.org/

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 403aba3ce8913..4bc0b59668fae 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
[ ... ]
> @@ -7273,7 +7284,7 @@ static const struct bpf_func_proto bpf_tc_sk_lookup=
_udp_proto =3D {
> =20
>  BPF_CALL_1(bpf_sk_release, struct sock *, sk)
>  {
> -	if (sk && sk_is_refcounted(sk))
> +	if (sk)
>  		sock_gen_put(sk);
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but bpf_sk_assign() and sock_pfree() appear to
be vulnerable to the exact same reference leak via SOCK_RCU_FREE state
transitions that this patch fixes for bpf_sk_release().

If a BPF program calls bpf_sk_assign() on an unbound or established socket,
it conditionally acquires a reference:

net/core/filter.c:bpf_sk_assign() {
	...
	if (sk_is_refcounted(sk) &&
	    unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
		return -ENOENT;

	skb_orphan(skb);
	skb->sk =3D sk;
	skb->destructor =3D sock_pfree;
	...
}

Before the skb is freed, if the application calls listen() on the socket,
granting it the SOCK_RCU_FREE flag, what happens during destruction?

When the skb is destroyed, sock_pfree() dynamically re-evaluates
sk_is_refcounted(sk), which would now return false:

net/core/sock.c:sock_pfree() {
	...
	if (!sk_is_refcounted(sk))
		return;

	...
	sock_gen_put(sk);
}

Would this cause sock_pfree() to return early and permanently leak the
reference acquired in bpf_sk_assign()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-sockmap-lo=
okup-tcp-leak-v1-0-1bbdc58ce514@rbox.co?part=3D3
