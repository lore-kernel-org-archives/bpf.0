Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FDA285CAD
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 07:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583305; cv=none; b=a/twxfoXU18FAeTv8Jz30WOjFVlZsxYXDA9w07DhSX+D9mzz+TJZIO4+PV+Ow8Zz4PTcwNRL3yG15FdiyHBLNeuyr898v7W+kdBaJjxcccsdB3jnmaZMnUcT/Ow0BPhMdRKvaRP0dqrU2yR7tewZywBU+iZ6y9DSzbPPvAr8y3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583305; c=relaxed/simple;
	bh=jnzahiFZnYDNS1oQkLLOB6imI4HZwC5VHCneX2u0gHU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TGFPYjobXbprUeiOTe0bcYz+sogy+1QrPknEVQagfKlat4LkcQF/0zi/QCtnc8UkAVXK22hlbTQeihhifeEFE+dw483090NLHE99HO8LYaN3eKlhP+DYZrQQZ46x39aueYOJmOy/nXjJNgfcN1Bx23Kgl01jZOB2ql3tSuEP8W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INb/srcV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INb/srcV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E381F000E9;
	Thu,  9 Jul 2026 07:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783583304;
	bh=nkxa4dGtodvmgqJ4TwPAqgStsTpse2YYdZCvUhyvhQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=INb/srcVK8XlA+weSBFenTg9+qs/UjqBAxBU9Z2c1U97wa90eXuKs7CGm0X9/bYyB
	 FEw99uE0rECIL9ONxsqhONP5zEFIZOyCJTCjOsMXpmyAZGHBEWl+SKnYuO2wYbbdtk
	 TqaK7qKMW7Ac7hKHvwvFdiRgnjblCT/Lwk3lzny/ZdxdZKujAPvc4UF70X8l8MSGtr
	 bqXe92KdqtTL8W8UQbiSanP+QcYeVy0SWBlazVq8umEjjdSRwsWzBjmhrt4UEkwxrm
	 TWocFgcOgHhUzXzOre9gOXSuujG6m3pRTdVv7Eu3g1bkDvwZWKe15qIgOvabvn+uat
	 ijWgXG6GraEHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf: Fix security_bpf_map_create error
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260709073422.379247-1-daniel@iogearbox.net>
References: <20260709073422.379247-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 07:48:23 +0000
Message-Id: <20260709074823.C1E381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Incomplete fix: the double LSM hook invocation bug fixed for map=
s also exists in the BPF program load path.
--

--- Patch [1]: [PATCH bpf-next] bpf: Fix security_bpf_map_create error hand=
ling ---
commit cf9b2144a32439abed11faad9a9b189d6b3f71f7
Author: Daniel Borkmann <daniel@iogearbox.net>

bpf: Fix security_bpf_map_create error handling

This commit prevents the security_bpf_map_free() hook from being called
twice when map creation is denied. It routes the map_create() denial
path to free_map instead of free_map_sec.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1649,7 +1649,7 @@ static int map_create(union bpf_attr *attr, bpfptr_=
t uattr, struct bpf_common_at
> =20
>  	err =3D security_bpf_map_create(map, attr, token, uattr.is_kernel);
>  	if (err)
> -		goto free_map_sec;
> +		goto free_map;
> =20
>  	err =3D bpf_map_alloc_id(map);
>  	if (err)

[Severity: Medium]
This isn't a bug introduced by this patch, but since you are fixing the
double invocation for maps, does the exact same issue also exist in the
BPF program load path?

Looking at the program load path, security_bpf_prog_load() cleans up the
LSM state internally upon denial:

security/security.c:security_bpf_prog_load() {
    ...
	if (unlikely(rc))
		security_bpf_prog_free(prog);
    ...
}

However, the error path in bpf_prog_load() eventually initiates an
unconditional program teardown:

kernel/bpf/syscall.c:bpf_prog_load() {
    ...
free_used_maps:
	/* In case we have subprogs, we need to wait for a grace
	 * period before we can tear down JIT memory since symbols
	 * are already exposed under kallsyms.
	 */
	__bpf_prog_put_noref(prog, prog->aux->real_func_cnt);
    ...
}

Which then unconditionally calls the free hook again:

kernel/bpf/syscall.c:__bpf_prog_put_rcu() {
    ...
	security_bpf_prog_free(aux->prog);
    ...
}

Could this lead to double invocations for denied programs (or unbalanced
invocations if verification fails before reaching the LSM load hook),
creating unexpected states for BPF LSM programs attached to bpf_prog_free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709073422.3792=
47-1-daniel@iogearbox.net?part=3D1
