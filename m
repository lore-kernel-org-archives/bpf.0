Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B884730BB9B
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 09:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781601888; cv=none; b=ojp7GuDfEMCgXtyNVuKqqAfOVA3OrjMNrJ9TpEPiXxuKFlWn1cSrGF8avFB89xcn0Tzh8s6V+tjGK9fCROvkEhyJiN02zLDBQnO0MRkMRfFyV/HMLg1F7AuwBMJmoaLWebtW2spRYPtP5Y6tNGzL9BNhKvjBoAYo2rHioVUn3pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781601888; c=relaxed/simple;
	bh=E8aE+jQ5bIPXEVOw1nfqzvryyrOMRddKUGBQE7u+lRI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AIJk5MBBqyJJvU7gyWmcracHP2lEp/2lMEb5s1KaXLTU/OpfauO2eYxROq3tw88bhShNKMtPUiR+/xe/duqsyE0OFU2vNnrcV3cTFEPZfvWzgNtV9cHfwweI3q8lyNyXL7vkQ6Jv66evQvrUJnAmtZjuIG9U23e+FmF58LcptyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mud/tzRZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mud/tzRZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6891F000E9;
	Tue, 16 Jun 2026 09:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781601887;
	bh=oz/JUHCYhnVL72ncGnLIXDNqypQ4bgdjGCZrdTNaWlI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mud/tzRZTqE9sakGN5inLPwF6kZFuoLPG2a6cXgMtpZLfakzScy33fgcM/72xu6Qe
	 f8b23lmo7agzmkN/B2JmPKImLBbzQuQgapTGbI74kV3nzkYR9MUvy9ERl8wB+cZTQi
	 v9kPuaNIWQAIMCWpvvjQdtRD0ARdWhx8BCqKp9tzEA5Glv9oHgGGO7zbjH/Qp0meQa
	 0DgHif67wzv2cFMphLXFn2WdDw37XHq1P6EmRhqGFmBpyyKq1/apO4gNP7t3g4GO3D
	 QsKEaSlQU0cTD+opMvUBXPI9swhbN2wzf/ednJOrfNoFQ3amzW+F67PAohK/UEnQuo
	 gSfUBW1GYlyZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: fix lock inversion between stab->lock
 and sk_callback_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260616091153.2966617-1-rhkrqnwk98@gmail.com>
References: <20260616091153.2966617-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 09:24:46 +0000
Message-Id: <20260616092447.1B6891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch resolves a circular locking dependency between `stab->lo=
ck` and `sk_callback_lock` for `sockmap`, but completely misses the identic=
al circular locking dependency between `bucket->lock` and `sk_callback_lock=
` for `sockhash`.
--

commit ca126c8c2f5577ef6bb462f6d0bbf16156b6795a
Author: Sechang Lim <rhkrqnwk98@gmail.com>

bpf, sockmap: fix lock inversion between stab->lock and sk_callback_lock

This patch resolves a circular locking dependency between stab->lock and
sk_callback_lock in the sockmap code. It prevents a deadlock by releasing
stab->lock prior to calling sock_map_unref() during element updates and
deletions.

> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 99e3789492a09..390bd5ee46d44 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
[ ... ]
> @@ -505,9 +505,10 @@ static int sock_map_update_common(struct bpf_map *ma=
p, u32 idx,
> =20
>  	sock_map_add_link(psock, link, map, &stab->sks[idx]);
>  	stab->sks[idx] =3D sk;
> +	spin_unlock_bh(&stab->lock);
> +
>  	if (osk)
>  		sock_map_unref(osk, &stab->sks[idx]);
> -	spin_unlock_bh(&stab->lock);
>  	return 0;
>  out_unlock:
>  	spin_unlock_bh(&stab->lock);

[Severity: High]
This is a pre-existing issue, but while fixing the lock inversion for sockm=
ap,
does the identical circular locking dependency still exist for sockhash bet=
ween
bucket->lock and sk_callback_lock?

Looking at sock_hash_delete_from_link() in net/core/sock_map.c,
sock_map_unref() is called while the bucket lock is still held:

		hlist_del_rcu(&elem->node);
		sock_map_unref(elem->sk, elem);
		sock_hash_free_elem(htab, elem);
	}
	spin_unlock_bh(&bucket->lock);

This pattern is also present in sock_hash_delete_elem() and
sock_hash_update_common() in the same file.

Could this lead to the same ABBA deadlock if a thread updates or deletes an
element in a SOCKHASH map (acquiring bucket->lock and then sk_callback_lock=
 via
sock_map_unref), while concurrently a stream parser holds sk_callback_lock =
for
read and a TC program triggers bpf_map_delete_elem() on the same bucket?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616091153.2966=
617-1-rhkrqnwk98@gmail.com?part=3D1
