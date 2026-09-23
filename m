Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0DF3BFE47
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790207026; cv=none; b=OtHnkW9H67S/0ZLUNjMizkNeJyigRSoZWWe1m1ajeInO1/wjzI/XX7wQNZTVLFoF5Ym1pKQmcTeSNndBSSGfl2C4HNhvWrCNt7frvbQ7Nw+/0PCSRqBiN9utNCFa9AWgUGL2daB3RmMXXXgxMaWNrA/g1NyR6UvlhIcLZ7UABlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790207026; c=relaxed/simple;
	bh=0SgGuOB1H5E1ACfDJ7KsEp2aLwaMmB0X3k/hV7jzhIE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Me+Xfr2ztHdzN98GkD6w4S3xukJ4NDd5UYhXiA+MDwUHcWu49rbvzd6Ov7rQX39yl9cZ21RwfUpskGF3h+l+SjrSNLIFOCeULpXfXWc0q5SKMpVcwf3gOU/CTF8xAcGqp4CGw/wTMCSoHRrq8k1pPFOgv9RdnXmtNwuZaA6iYMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNj4AZ31; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNj4AZ31"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66761F000FF;
	Wed, 23 Sep 2026 23:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790207025;
	bh=keBatZT+tX7jqaE4JGA/K2ZeazbKkgp9ngFGu5Wbc+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KNj4AZ319igW9QRnQSMiiEKupynTUKW7mSzObe2HmyEx3NJJCRUCQCRVS0+nuiMTN
	 6/ajfNz59KfiqU68WhGClmVpsp6EeyHuZQ/JnHNkH0VFd7pBun3yLyZG0EraTWeaW4
	 HjtiajyAKniQxIOhMh8imVGg6Gkf0jKlKEg26NEy3wfpBZAP3VpK+HqLsJGpnPiPwx
	 bjoYha1rt6XpGIONDdQQvAClTyMeVqoFNQCX2bRDvgdJcjZ6WBOtietoRiq1jNN4e8
	 zoeg6Jiptd6ezRwNvsYiLkYu3ihotaz9mnUK5It9Vnezw3gxd34J5wW0I8ogLRPfzj
	 +uAkE2FkCO89g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 2/8] libbpf: BPF programs manual loading and
 attaching
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260923232939.1886328-3-andrey.grodzovsky@crowdstrike.com>
References: <20260923232939.1886328-1-andrey.grodzovsky@crowdstrike.com>
 <20260923232939.1886328-3-andrey.grodzovsky@crowdstrike.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 23:43:44 +0000
Message-Id: <20260923234344.C66761F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] bpf: missing early validation for MANUAL programs in PROG_ARRAY maps
- [Low] bpf: commit message claims do not match the implemented API names
--

commit ffe6da53cfeec9f1860cfd6d78324b171ee2b1d5
Author: Slava Imameev <slava.imameev@crowdstrike.com>

libbpf: BPF programs manual loading and attaching

This commit introduces manual loading and attaching strategies for BPF
programs, allowing programs to be selectively loaded and unloaded multiple
times without requiring all object programs to be auto-loaded.

> A manual-strategy program is loaded via bpf_program__load_manually()
> and unloaded via bpf_program__unload_manually(), gated on

[Severity: Low]
The commit message mentions bpf_program__load_manually() and
bpf_program__unload_manually(), but the code actually implements
bpf_program__load() and bpf_program__unload(). Should the commit message
be updated to match the implemented API names to fix this regression?

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
[ ... ]
> @@ -15375,10 +15431,69 @@ void bpf_object__destroy_skeleton(struct bpf_ob=
ject_skeleton *s)
[ ... ]
> +		/*
> +		 * struct_ops programs are incompatible with manual loading:
> +		 * bpf_map_prepare_vdata() bakes each member's fd into kern_vdata
> +		 * automatically during bpf_object__load(), before a MANUAL member
> +		 * could ever be loaded, and nothing re-bakes it afterwards.
> +		 */
> +		if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS)
> +			return libbpf_err(-EINVAL);

[Severity: Low]
A check exists here in bpf_program__set_load_strategy() to reject struct_op=
s,
but does this code miss validation for prog_array maps?

If a user configures a prog_array map to hold a reference to a BPF program
and sets that program's load strategy to manual, the object load will fail
later with -EBADF during the kernel map update when init_prog_array_slots()
calls:

fd =3D bpf_program__fd(targ_prog);
err =3D bpf_map_update_elem(map->fd, &i, &fd, 0);

Can this regression occur because the manual program has not been loaded ye=
t,
meaning it will have an invalid file descriptor? Could we add an early
validation here similar to the struct_ops check to prevent this later
failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923232939.1886=
328-1-andrey.grodzovsky@crowdstrike.com?part=3D2
