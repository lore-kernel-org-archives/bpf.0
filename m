Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD8F2C181
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783442394; cv=none; b=B2NPVpl5PIJArbbXxUaQMevY9fSeD99E/8nE4gT6dK/wUsQ1ZIErOYUFpaZQn3dwtBve7XffOgriy3QWeZSW73x1OQQtCkoEn7MEpmPqDHzqQ2ht7vy+4R9kRbPg6zyaCt6uh3CObaZtf8KeGOJv8q6V72xA/uol/TPSHoqfnlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783442394; c=relaxed/simple;
	bh=beRjEhqO/h+H60xDf8EcfxOsBJoufs0jBTg8YSJI/U4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rOD919LD0x06MPp3atuWTYRuX3B4iv0Zd3f0los+kEjFbfTnohQrznF28Drn11tTEl/ldbWIxKaZestfsK7S9+waEdjdBuozOrKZ1MgE3Ir30Z1Bf60KkYtlkss5BlK6SsaWicLREzmIyT9gB6iKrm98c+8f8Ob6JEDWilGtwPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHJ6RimM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHJ6RimM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279CB1F000E9;
	Tue,  7 Jul 2026 16:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783442393;
	bh=u/B9HD7Ko1wQj7w2Q42ZfVN3sKZpYCBN1YlF8Ty2ljo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LHJ6RimM5JcMNkPac/udVuBY3yg8amtBhMhbIR2VoNCsp7fv61LDEb2X4boW6j5Du
	 RpEFfAAloQIWB4YeRF5xJJtIRTRZVwvtW8yHKBpu0CJ/UjWqoKq3KMEipthUbv3M+F
	 ZahDb+Bg/tFX6kvSz56M64MOOfYumQ4ZRPBlXwIGwIq9HnRoPtjy7PfhMTCf13TViT
	 yjI16EUS59mD0kPpwiNeRri+209YO+ohlAL25U1D4RXnlqhtGywWp594N6GeiBKoxm
	 N2aLE3CFe1l4YHz3EXRPd1n+q6e5VCHN+ADlJXBhXeSfp9STc8voxbyqClKkW/bGrD
	 X4s0x5wRuiQSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND bpf-next v2] selftests/bpf: veristat: Minimize
 map size during verification
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260707162012.8063-1-emil@etsalapatis.com>
References: <20260707162012.8063-1-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 16:39:52 +0000
Message-Id: <20260707163953.279CB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] veristat overrides BPF_MAP_TYPE_HASH_OF_MAPS max_entries to 1, c=
ausing map preparation to fail for declaratively initialized maps
--

--- Patch [1]: [PATCH RESEND bpf-next v2] selftests/bpf: veristat: Minimize=
 map size during verification ---
commit be52ac6965be2ec63632786bb06d60b4e6152bc6
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: veristat: Minimize map size during verification

This commit updates veristat to resize BPF maps where max_entries is
irrelevant to the verification process. By shrinking these maps to the
minimum size, it avoids -ENOMEM errors on memory-constrained systems.

> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -1248,6 +1248,30 @@ static void fixup_obj_maps(struct bpf_object *obj)
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

[Severity: Medium]
Will this cause map preparation to fail with -E2BIG if there are multiple
inner maps declaratively initialized?

In fixup_obj_maps(), if the outer map's max_entries is forcibly overridden =
to 1,
when libbpf later attempts to populate the slots via bpf_map_update_elem()
during bpf_object__prepare(), the first insertion succeeds, but subsequent
insertions fail because the hash map's capacity is constrained to 1.

Does this mean tests that declaratively initialize multiple inner maps
(such as test_btf_map_in_map.bpf.o) will fail to load with invalid map FDs,
subsequently causing the verifier to reject the programs?

> +		case BPF_MAP_TYPE_SOCKHASH:
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707162012.8063=
-1-emil@etsalapatis.com?part=3D1
