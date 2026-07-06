Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EC935AC32
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 23:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783379021; cv=none; b=p+DUMlTmwH/4gQmjHwbV1tF8z+fC+U6XVLGOeMBi+nMV73EvGa/vbtHCtjqCiM5AgvtbBxFxZeUkrng2x5VG8MLmx350SNjWpH4zIXz/OIp9jExm2ySMGQ5bT8s4NYamnEgK/W87vBUP0MPkONV0jYlc+5h5M7aS3pkErx3u3HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783379021; c=relaxed/simple;
	bh=3jhGKH95UK7ABv0WV0absmvK1hU4ENWAjuxFgs8JgwA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pLP6aW1mwuxXwBi4gkgZsPR0w1Am3iP22Ud0/4ma7Id+eAyFtAw9rX4I5phR+M7DKXbSXiCuUnDRtJM5HD+Dr1ieY9d1Dax2QzyyKTatcSrLjOzxOEIC8IwvaG9UBFbEOV5EojfHmq/v6UIOhCrxycEOUCh5VFdqvcPXPeqh7So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQzJaT2c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQzJaT2c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A981F000E9;
	Mon,  6 Jul 2026 23:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783379019;
	bh=11KNDyIeoeZbPAB/n+gd/m/CNoTctSMU48HFm9g99WU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gQzJaT2c3OrWTWrmuqlD9TZO9gBQe+X4prMBfvQexVAHPWf5rKMf82fM0u8Nw5Lni
	 IPIe1HVHvP97n6aWx7y9Zx8smZSJOA66B//QIFLXBlYaE/5zvQoL3aEsYesMeVlQD4
	 EBhdm7P1rHb7Myt9uH3Z6BmCToJ+lOBOjdMBQMJluMRdMCz+DuYFC7nghplvwnvNFN
	 kZINh4CifaFXXpHeU0dClvhA5d9wmT8xo6aDt00vzP4+vVlkHzm2DETSjKAA0pu9Ju
	 wVXbsdIF8o0jm/SNGik+e2VVwMGjsRQiCAkrMmH1OZbwwbneicPtfu/lX+VHrJfJLc
	 KW5LYI2rW36fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: veristat: Minimize map size
 during verification
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260706225052.35543-1-emil@etsalapatis.com>
References: <20260706225052.35543-1-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 23:03:39 +0000
Message-Id: <20260706230339.A8A981F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Setting `max_entries` to 1 for `BPF_MAP_TYPE_RHASH` maps causes =
map creation to fail if `map_extra` > 1.
--

--- Patch [1]: [PATCH bpf-next] selftests/bpf: veristat: Minimize map size =
during verification ---
commit a11623d3f77bb05764867d10c3ff357f2a8a1403
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: veristat: Minimize map size during verification

The veristat tool loads objects and maps into the kernel to verify them.
This patch expands veristat to resize maps whose max_entries are not
relevant to verification to as low as possible to avoid -ENOMEM errors
on smaller test machines.

> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index a7db6f04f7e14..8d374e1406532 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
[ ... ]
> @@ -1248,6 +1263,37 @@ static void fixup_obj_maps(struct bpf_object *obj)
> =20
>  		/* fix up map size, if necessary */
>  		switch (bpf_map__type(map)) {
> +		/*
> +		 * if the verifier doesn't use max_entries
> +		 * then set to 1 to avoid -ENOMEM
> +		 */
> +		case BPF_MAP_TYPE_HASH:
> +		case BPF_MAP_TYPE_PERCPU_HASH:
> +		case BPF_MAP_TYPE_LRU_HASH:
> +		case BPF_MAP_TYPE_LRU_PERCPU_HASH:
> +		case BPF_MAP_TYPE_HASH_OF_MAPS:
> +		case BPF_MAP_TYPE_RHASH:
> +		case BPF_MAP_TYPE_SOCKHASH:
> +		case BPF_MAP_TYPE_DEVMAP_HASH:
> +		case BPF_MAP_TYPE_LPM_TRIE:
> +		case BPF_MAP_TYPE_QUEUE:
> +		case BPF_MAP_TYPE_STACK:
> +		case BPF_MAP_TYPE_BLOOM_FILTER:
> +		case BPF_MAP_TYPE_STACK_TRACE:
> +			bpf_map__set_max_entries(map, 1);
> +			break;

[Severity: Medium]
Will setting max_entries to 1 cause map creation to fail for
BPF_MAP_TYPE_RHASH maps that have map_extra set to greater than 1?

The kernel's rhtab_map_alloc_check() enforces that map_extra must be less
than or equal to max_entries. If a BPF program legitimately uses an RHASH
map with a map_extra preallocation hint greater than 1, this unconditional
minimization will cause an -EINVAL load failure, making veristat erroneously
report a verification failure.

Does veristat also need to adjust map_extra when reducing max_entries for
RHASH maps?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706225052.3554=
3-1-emil@etsalapatis.com?part=3D1
