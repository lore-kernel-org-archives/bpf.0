Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310842459C5
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 01:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781487685; cv=none; b=oI/TPNdD8bZD1pjoSGWl70xaCrtHMdNwjI3/TWkm3qsxiTVcRcVnL1rZJMK8dvYIWpEIBgCaPIBfkMoptz6+wjBdhppWLvYB65wxKLH1a5a//9yXZESUGtJssmp6dl0DAdqA61abIxsq/zP/NgewcM5ksuwsv3DQ62VoO0Zs3zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781487685; c=relaxed/simple;
	bh=R8i5XWLC7qRkJ/M2VFpHtjQsEPiRV5btngrp8QxckaU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QHxxCwa1FC4vq/OJNZmBaszzLz0SJCZcJimgiLGy4Fx24Zj/pvMg2ue0ScEOlAMw2mUBjz3f72K2YGFBG+iLvHCC9YdW+Gm1XMnpuHFvsprUUaPxLKZ9a+3d86090e0j5/yI60UzcYBjhEtfyHlz3nRZ2nwiHOjwByz2+2J6MFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcD7XJMO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcD7XJMO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC871F000E9;
	Mon, 15 Jun 2026 01:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781487683;
	bh=7eS+QnheZ9F2E5MGCeQHz54pAWNHz5kUsBJla3ISqoQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fcD7XJMOy+RDnNaPy88sc48RnP7q2KRBEaOb8DIWGUx/LkcNEe0rPF51folMakPdR
	 kytzJAtMqGEes+KzgeTjTtKzlt1/B18P8a1p18iNUPsf4XRNLuq22YAEAk+yDvJ2bc
	 +IuZKhGenrxyhku/6Lu8dZ64cZ3alo7USGcrAZmPAqHmNf1f9IcgzqtmQu8AV7tMhe
	 QYNq/Ywm9682TNCV1BYEYGc7Pb9qrSJJuzOJOGkZz4MK3y9J9pE22KCI8uqga7u8KX
	 cNBuE8LymbQL3nIEOjm4hj4FchL+Wf9pJcyztOjOJ+4E3YiqbYOdvr1NPTyVl4s3EJ
	 i3+c98lMyUO+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 1/5] tls: reject the combination of TLS and
 sockmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260614014102.461064-2-kuba@kernel.org>
References: <20260614014102.461064-2-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 01:41:23 +0000
Message-Id: <20260615014123.9EC871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch attempts to reject the combination of TLS and sockma=
p during key configuration, but leaves a critical vulnerability where attac=
hing the TLS ULP to a socket already in a sockmap causes global protocol st=
ate corruption, infinite loops in unrelated sockets, and silently bypasses =
BPF sk_msg policies.
--

commit 12fd2fff4db720c6f124011a38950efdbcd77414
Author: Jakub Kicinski <kuba@kernel.org>

tls: reject the combination of TLS and sockmap

This commit attempts to reject the combination of TLS and sockmap by
returning -EINVAL in do_tls_setsockopt_conf() if a psock is attached.
The goal is to prevent latent bugs while removing dead code.

> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index 13c88a7b8787d..8e7ba018988d2 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -643,6 +643,17 @@ static int do_tls_setsockopt_conf(struct sock *sk, s=
ockptr_t optval,
[ ... ]
>  	int rc =3D 0;
>  	int conf;
> =20
> +	/* TLS and sockmap are mutually exclusive. A socket already in a
> +	 * sockmap (i.e. with a psock attached) cannot be upgraded to TLS.
> +	 * sockmap rejects TLS sockets already (see sk_psock_init()).
> +	 */
> +	rcu_read_lock();
> +	if (sk_psock(sk)) {
> +		rcu_read_unlock();
> +		return -EINVAL;
> +	}
> +	rcu_read_unlock();
> +
[Severity: Critical]
This isn't a bug introduced by this patch, but does this check happen too
late to prevent global protocol state corruption?

If an unprivileged user adds an established TCP socket to a sockmap, the
socket's sk_prot is changed to tcp_bpf_prots. If they then attach the TLS U=
LP,
tls_init() executes and immediately calls tls_build_proto() before this
key configuration check is ever reached:

net/tls/tls_main.c:tls_init() {
    ...
    tls_build_proto(sk);
    ...
}

This function reads the socket's current sk_prot and uses it to rebuild the
global tls_prots array:

net/tls/tls_main.c:tls_build_proto() {
    ...
    struct proto *prot =3D READ_ONCE(sk->sk_prot);
    ...
    build_protos(tls_prots[TLSV4], prot);
    ...
}

Because sk_prot is tcp_bpf_prots, the unhash handler in the tls_prots array=
=20
is permanently overwritten with sock_map_unhash.

Any subsequent normal TLS socket will inherit this corrupted global array.
When the normal TLS socket is closed, sock_map_unhash() is invoked. Since
the normal socket has no psock, it attempts to fall back to the original
unhash function, leading to an infinite retry loop:

net/core/sock_map.c:sock_map_unhash() {
    ...
    saved_unhash =3D READ_ONCE(sk->sk_prot)->unhash;
    if (unlikely(saved_unhash =3D=3D sock_map_unhash))
        goto retry;
    ...
}

Because sk->sk_prot points to the corrupted tls_prots array, it reads
sock_map_unhash again, causing a kernel hard lockup.

Could a check be placed in tls_init() or tcp_set_ulp() instead, to prevent
ULP attachment entirely before tls_build_proto() is called?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260614014102.4610=
64-1-kuba@kernel.org?part=3D1
