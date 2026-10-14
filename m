Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922B3450415
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 10:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791974365; cv=none; b=rqr0z1Y/LAZxlDKuG2d/f2qeOS8vPBxCKtClp8iPXeAqw512tYFk+2gZjaSfC0CwnGp3BNvcm9pPSb9XX/O50K0OItnMo3bP0cDfhwGvKmni+Qg7fXPZ0RO5a6QTCXWu7b3Uhj6Mrl4iMLJdhyQzrZg75g5G4sH1aC2QU3u3oFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791974365; c=relaxed/simple;
	bh=cJx+IdEUu8yh4fLjqkD0IluljpwFkPnxObVaaS2yr8Y=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=JsaWqnLFhmlkwOTQ4bNGN/QS3oGkbrTZDvkJ4yxWEZdA15l6fIMa4YlNEQDsPyqXnNFCdRnmVdcw9sinwWnCIOPa2K/Cl3nEXgy1g7h/HK770VwI65tC+8OPo3ouSHHEKB7fhOcUMaIcjIjDWhyd73/HBgjeXcDoM7AKuEMjM3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqLK8fF4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqLK8fF4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D4C1F00893;
	Wed, 14 Oct 2026 10:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791974364;
	bh=bvozk3r+DlQO0juGxWTv3O0K0VuoeeLH+uKVBCADwIc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MqLK8fF4zKUXwO3KAJ4mraxItqStAbi6/2fvCiKbhdD0vS6tcMfi5HRyZryNPKVNA
	 hobCrNCQlPabpEcrS0ziNydyCOghgWJFH83AHuDp9NQAPyHERG9FBtw2A1/d87TQFA
	 2nbSEgYFT+5MTmyTf9s6g8Bzx2/zmOWEeb5osl+8R/620izmP77yoK6TTPMbtUoD2k
	 0RU1uVHtiG2QkdPBKDuWA41Y/VgNjodKYTjIPr3ok371qzfe4+FSsycKTTMXU7Rz0Q
	 uDnZ5ew7vAMCGvGOHlyrWHKoDf5ISI5IECZrFB0/WCMD71pPu55s8UV85CiwmP4zHu
	 RHBwEahZynHog==
Message-ID: <sashiko-outbox-171147@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH net-next 3/4] tcp: add TCP_TS_ID socket option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Willem Ferguson" <wferguson@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261013103906.2660384-4-wferguson@cloudflare.com>
References: <20261013103906.2660384-1-wferguson@cloudflare.com>
 <20261013103906.2660384-4-wferguson@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 10:39:23 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] tcp: lockless data race in do_tcp_getsockopt for TCP_TS_ID
--

commit 7c66b48d6e891deb8097ef54e673d4be713fb65b
Author: Willem Ferguson <wferguson@cloudflare.com>

tcp: add TCP_TS_ID socket option

Add a read-only TCP_TS_ID socket option so applications and tests can see
which TSval identifier was assigned to a connection. The value packs the
identifier width and the identifier itself, chosen by BPF when the SYN
arrives.

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index af994edde7f73..5991b16396b9f 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4711,6 +4711,9 @@ int do_tcp_getsockopt(struct sock *sk, int level,
>  		else
>  			val &=3D ~1;
>  		break;
> +	case TCP_TS_ID:
> +		val =3D ((u32)tp->ts_id_bits << TCP_TS_ID_BITS_SHIFT) | tp->ts_id;
> +		break;

[Severity: Low]
Is it possible for tp->ts_id and tp->ts_id_bits to be concurrently modified
here without the socket lock?

Looking at do_tcp_getsockopt(), these fields are read locklessly.
If the socket is concurrently disconnected (for example, by calling
connect() with AF_UNSPEC, which calls tcp_disconnect()), the fields are
zeroed out:

net/ipv4/tcp.c:tcp_disconnect() {
    ...
    tp->ts_id =3D 0;
    tp->ts_id_bits =3D 0;
    ...
}

Could this concurrent modification trigger a KCSAN data race warning or
result in returning an inconsistent or torn value to userspace?

Other locklessly accessed fields in this switch statement use READ_ONCE(),
like tp->notsent_lowat right below this. Would it make sense to use
READ_ONCE() here and WRITE_ONCE() in tcp_disconnect() to prevent this?

>  	case TCP_NOTSENT_LOWAT:
>  		val =3D READ_ONCE(tp->notsent_lowat);
>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013103906.2660=
384-1-wferguson@cloudflare.com?part=3D3
