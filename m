Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D615D3B42DB
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 19:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783454162; cv=none; b=Z8Ma3X10mfp5ehd8hYCBOi04yDM//Brh1aXmUAgi1mRZbxPsON5uSxLCpWxhn/N1Q5Nae6bo5xKjbv2cGU3yEl0qofCW3vZoyFc+qsdiG1vBB/MluAtJszBNorbY2zZfcvaQv/AxOa4cz8PsnroW6PCEJZarii3+1DhEwrElAx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783454162; c=relaxed/simple;
	bh=z9yl/7QqgFQNmIjjZlGhH0Pjzv7qPf4YfVFywr4SLVc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Az2N9Sg9Ko5GD+U/2UUw0Am5V232Pkjtb2Z9OLEjf7ITKUgWvYOUfpLSnfhYQcdjwiVmn72yrFixR9cJCP8IY2dxYU3bTICCP6MXyswOsmsCZYmgnv+m9MZy/ex01P/B+B6pRj+1W0MbOaLvyGFzOISWu/s1KRO0Jq8sTR7fnOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlY8hhMp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlY8hhMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2851F000E9;
	Tue,  7 Jul 2026 19:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783454160;
	bh=9WuchZmZ4b9MzR02+r+E5uuL90ZpHcC5VJaAz4bJowQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZlY8hhMpBdA+k+q8dxTkclDMpBMWTeUP60BZoRtsaLpDcGd/mBXIQTI0pr63ppqH5
	 zu5fFnjqF1e+K0p+8VJk+a+KGUCZ1L+Jq/7IOS/uOGG6eim96qMqvJnMQyg63ySkZL
	 IN5iLZCchDmY0hZem/FrgfZLrVTjUKUxQ+ykrh09WZ77DHznTGUS7pXsvLFbQ2+hkH
	 lNBz/W92/EaMW7/ipP3AISGateUiKYBmTSmcXvxvcSr5hLzsFW3RdxfRCi6tcub2rs
	 kEsC+ByOoKv4sfLhc7L5f73g4Oz8jaoRIxZ/+XlbFZYr72H9MjkWs2tSY8lXV53NpU
	 htBkz7QilCT0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 2/8] bpf: Verify signed loader metadata at
 load time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260707193104.350066-3-daniel@iogearbox.net>
References: <20260707193104.350066-1-daniel@iogearbox.net>
 <20260707193104.350066-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 19:55:59 +0000
Message-Id: <20260707195600.5C2851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A lockless synchronization race between map_freeze() and map_updat=
e_elem() allows a TOCTOU bypass of BPF signature verification.
--

--- Patch [2]: [PATCH bpf-next v5 2/8] bpf: Verify signed loader metadata a=
t load time ---
commit 5bc066f1169723d401bd2b1b6a80fa2ecfbca1a9
Author: Daniel Borkmann <daniel@iogearbox.net>
Subject: bpf: Verify signed loader metadata at load time

This patch introduces load-time BPF signature verification. It verifies the
signature over both the BPF instructions and the contents of any exclusive
metadata maps, relying on map->frozen to ensure the metadata cannot be
modified after verification.

Link: https://lore.kernel.org/bpf/2f71d6c03698eb17d51f7247efde777627ee578a.=
camel@HansenPartnership.com [0]
Link: https://lore.kernel.org/lkml/ecf0521ed302db672672ebfbc670ecfba36a6e00=
.camel@HansenPartnership.com [1]
Link: https://lore.kernel.org/bpf/88703f00d5b7a779728451008626efa45e42db3d.=
camel@HansenPartnership.com [2]
Link: https://lore.kernel.org/bpf/DJOFY21DYUI4.19WKQ3NPZ4H5R@gmail.com [3]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2e9e65297c706..462a1f8544b9d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19870,6 +19895,140 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn,
>  	return 0;
>  }
> =20
[ ... ]
> +static int bpf_prog_verify_signature(struct bpf_verifier_env *env,
> +				     union bpf_attr *attr, bool is_kernel)
> +{
[ ... ]
> +	for (i =3D 0; i < map_cnt; i++) {
> +		struct bpf_map *map =3D maps[i];
> +
> +		if (map->map_type !=3D BPF_MAP_TYPE_ARRAY ||
> +		    !map->ops->map_direct_value_addr) {
> +			verbose(env, "signed program metadata map '%s' must be an array\n",
> +				map->name);
> +			err =3D -EINVAL;
> +			goto out;
> +		}
> +		if (!READ_ONCE(map->frozen)) {

[Severity: High]
This is a pre-existing issue, but does the current map freezing mechanism
provide the absolute immutability required here?

In kernel/bpf/syscall.c:map_update_elem(), the code increments the write
count and checks permissions:

    bpf_map_write_active_inc(map);
    if (!(map_get_sys_perms(map, f) & FMODE_CAN_WRITE)) {

Because bpf_map_write_active_inc() uses atomic64_inc(), it does not imply a
memory barrier on weakly-ordered architectures (like ARM64). Could the
read of map->frozen inside map_get_sys_perms() be reordered to occur
before the writecnt increment is globally visible?

If so, could a sequence like this occur?

CPU0 (map_update_elem):
    bpf_map_write_active_inc(map); // no barrier
    // map->frozen read reordered here, sees false
    // blocks on user memory fault during kvmemdup_bpfptr()

CPU1 (map_freeze):
    // reads writecnt as 0, assumes no active writers
    sets map->frozen =3D true;

CPU2 (bpf_prog_verify_signature):
    reads map->frozen as true, verifies signature against benign data

CPU0 (map_update_elem):
    resumes from memory fault, completes update with new data since
    bpf_map_update_value() doesn't re-check map->frozen

Since this patch relies on map->frozen to guarantee the metadata cannot
change, does this lockless race allow bypassing the signature verification?

> +			verbose(env, "signed program metadata map '%s' must be frozen\n",
> +				map->name);
> +			err =3D -EPERM;
> +			goto out;
> +		}
> +		if (!map->excl_prog_sha) {
> +			verbose(env, "signed program metadata map '%s' must be exclusive\n",
> +				map->name);
> +			err =3D -EPERM;
> +			goto out;
> +		}
> +		data_sz +=3D map->value_size;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707193104.3500=
66-1-daniel@iogearbox.net?part=3D2
