Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624962D6E44
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 20:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781554372; cv=none; b=LyfGGPj3c3uH+VPFTECaexXkX4qcZHi2YX8oMz9tVqI4sarUZBa4mkjDw57kTMXoMvU6B0BvvOA4XDgGmjGDwn1tOZxArfxV7cZph4Wsp6pc9/1dalBfend9+9pdTYAsg34lmurctbkbeXH6t26P+tAN6x0IxWqe3XGguKtvozs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781554372; c=relaxed/simple;
	bh=uLXQ5KIsxmiRoPYOYcg7+g0W3RxwIJwkaYixkaNUoiI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lXs0mgqwgSrIOx5/iaGnAbpWF6i1jEpnR6NJxXzF/QmgTtxMlMF7YdJVOV8i/Ps/m0gAYXQ1xLEkb50Gaxes7/aXlAIyzT1fmEv0WWjgndIgD243kEKhG8tC1kaaux0DRBvLhz5dxWdkt7gjr9gcJOl6wbG/H/Cdy88s/gq7K7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnqVw6XC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnqVw6XC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B0C1F000E9;
	Mon, 15 Jun 2026 20:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781554371;
	bh=IKcZMKrklpoAlAHBqEyeG5F/zr4bDTGVJjCyLZKRtcA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cnqVw6XC1i3qcVdNWDNNlU9LntzY9c+ktYIT9xuWYLX3DiVNy9ssE6YLt1OPYNipW
	 JsIa9hURotU2qTTxxrpMySh+a2fSu7QRnLklWmY33waAL72Nzy51nni2STK2k1Ep5I
	 GJq3hK2NFqn8GZYDUFnJMVtwq/VbEfcksHM1N3FBl6qPfmS142mRrIzXN3Vb+MS+Qc
	 LOMC/ZiC61bVBH2oPBDsy9gxDvMFzOHAwiN5+6CLupUki5ZkZJNsvRLxzbNkIPl3VH
	 Zb8vOUvPi06U00VpbcvzhdlA3s5DZvA3aVQ2WrgVNeYS9RGOf9GHb+9mW5pNz9UO7+
	 Cr5HWXnhUWYSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3] bpf: Better build_id caching in
 stack_map_get_build_id_offset()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260615195536.1065107-1-ihor.solodrai@linux.dev>
References: <20260615195536.1065107-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 20:12:50 +0000
Message-Id: <20260615201250.D2B0C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The non-sleepable path uses `find_vma()` without verifying if the =
requested `ip` actually falls within the returned VMA, leading to bogus fil=
e offsets and leaking the build ID of adjacent mappings.
--

commit 61bb9d39eaa120b04f78291638b9b3dcc5b364d9
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

bpf: Better build_id caching in stack_map_get_build_id_offset()

This patch refactors the build ID caching logic in
stack_map_get_build_id_offset and its sleepable variant into a shared
structure. It uses two independent slots to cache the last resolved and
unresolved VMAs, avoiding cache eviction when alternating between regions.

Link: https://lore.kernel.org/bpf/20260525223948.1920986-1-ihor.solodrai@li=
nux.dev/
Link: https://lore.kernel.org/bpf/CAEf4Bza2fRDGhLQoPE-EzM7F34xaEJfi5Exmxb-i=
WVUN3F06=3Dg@mail.gmail.com/
Link: https://lore.kernel.org/bpf/CAEf4BzZXJFr=3D1iiVx937ht=3D4PYQkQHg=3DeF=
k810zhMDzXQG3ihw@mail.gmail.com/

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c

[ ... ]

> @@ -365,27 +439,30 @@ static void stack_map_get_build_id_offset(struct bp=
f_stack_build_id *id_offs,
> =20
>  	for (i =3D 0; i < trace_nr; i++) {
>  		u64 ip =3D READ_ONCE(id_offs[i].ip);
> =20
> -		if (prev_build_id && range_in_vma(prev_vma, ip, ip)) {
> -			vma =3D prev_vma;
> -			offset =3D stack_map_build_id_offset(vma->vm_pgoff, vma->vm_start, ip=
);
> -			stack_map_build_id_set_valid(&id_offs[i], offset, prev_build_id);
> +		if (!stack_map_build_id_set_from_cache(&cache, &id_offs[i], ip))
>  			continue;
> -		}
> +
>  		vma =3D find_vma(current->mm, ip);
>  		if (!vma || vma_is_anonymous(vma) ||
>  		    fetch_build_id(vma, id_offs[i].build_id, may_fault)) {

[Severity: High]
This isn't a bug introduced by this patch, but does the use of find_vma()
here without a bounds check allow an unmapped ip to underflow the offset?

find_vma() returns the first VMA whose vm_end > ip, but it does not
guarantee that ip >=3D vma->vm_start.

If an unmapped ip is queried, could find_vma() return the next adjacent VMA,
causing the offset calculation ip - vma->vm_start to underflow? This appears
like it would report a bogus file offset and leak the build ID of the
adjacent mapping.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615195536.1065=
107-1-ihor.solodrai@linux.dev?part=3D1
