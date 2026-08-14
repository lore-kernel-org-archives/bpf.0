Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0BD61FCE
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713525; cv=none; b=jwZ2LTk51XeBvroiQ1l+K0kojIGpScl0fGxhGpm/a/PCFMOFg8asKk8rI2YiSQOdvg7Jee9WpLkrJWVk+a0QDRE+X/WVSIja8hp5A80mxASz5fYZt7FfnKav1b8xHbz8PKKnd0FRIWA0OKFxenx5d2IClCsavsqido5TtcQR6SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713525; c=relaxed/simple;
	bh=4AtAXL4E79obY9lF17YzBLoAkQLBGrq4PN88UIveZSA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c7KZZfOgszWwivlTD5uVQt+p0QhDKPX2NtQWdmovUkHR3UqRD2QuTMt4otskSYkYlNVVZKpXpPFcclfwG1hCfoj3tfo9nTlvKArL1uyKLMvzLlEpm2YSveQGgma50jfSqVoO+QZn3Kwxg4QXRP4F78s8UfYcsBSDfsSqD8AHvDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMqHuub2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMqHuub2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A45B1F000E9;
	Fri, 14 Aug 2026 13:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786713523;
	bh=Cpaodk1Nvie2kkmyQwhqdJGemKXJkNG9SuRy2OLWk64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QMqHuub2YHQwomf6QG2/NVIfEnu6k0ewSVOsxUU2Nkj+teLQ2b9Gw6mLk+M56mZM8
	 g0HDA5EEgcUvyM/KCv3Z++GtXrjBl/Uu8ajX+1tKnJoFfCjELv3WkoxerL9t//Ddu9
	 fhpcn1eeR9IXDtUFyhfoIs4QAouF/F4tu8JpQKXOMiyrxhMB3FcFuOxwEMFGcDJSX0
	 GBCoEvcbsIQzfL6FfsjaXhgDZ+5oV4y3Y3YU1rtwG1ikgz8GscQxHuGrcXVsE9t9fP
	 zQpN92c1pd7iPTstbgBG3XhSPQ837cztDRlfPBRSP8tNd71qo6MCv6mhEa18yQOHFJ
	 f1XiFaLON8LvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: Enforce cgroup storage map consistency for
 freplace attach
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aohan Mei" <3472274613@qq.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_2EB11B9074207E825BE3ACC0AF1F09DE0108@qq.com>
References: <tencent_2EB11B9074207E825BE3ACC0AF1F09DE0108@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 13:18:42 +0000
Message-Id: <20260814131843.6A45B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] State corruption in bpf_freplace_check_tgt_prog() leaking aux->is_=
extended =3D true on validation failure.
--

--- Patch [1]: [PATCH bpf] bpf: Enforce cgroup storage map consistency for =
freplace attach ---
commit 25f8d74e87a11313024cd3ea152a45bd57843da3
Author: Aohan Mei <henrymei@tencent.com>
Subject: bpf: Enforce cgroup storage map consistency for freplace attach

This commit adds a consistency check for cgroup storage maps when attaching
an extension program. It rejects the attach with -EINVAL if the extension
and target programs reference mismatched cgroup storage maps, preventing
potential out-of-bounds access.

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
[ ... ]
> @@ -821,6 +823,20 @@ static int bpf_freplace_check_tgt_prog(struct bpf_pr=
og *tgt_prog)
>  		return -EBUSY;
> =20
>  	aux->is_extended =3D true;
> +
> +	/* At runtime the extension program inherits the target program's
> +	 * cgroup storage context (via prog_item->cgroup_storage), while the
> +	 * verifier bounds its accesses by its own map's value_size. A
> +	 * value_size mismatch leads to slab out-of-bounds access.
> +	 */
> +	for_each_cgroup_storage_type(i) {
> +		struct bpf_map *tgt_map =3D tgt_prog->aux->cgroup_storage[i];
> +		struct bpf_map *prog_map =3D prog->aux->cgroup_storage[i];
> +
> +		if (prog_map && (!tgt_map || prog_map->value_size !=3D tgt_map->value_=
size))
> +			return -EINVAL;

[Severity: High]
If this check fails and returns -EINVAL, does it leave aux->is_extended
permanently set to true?

Because aux->is_extended is set to true just before this loop, returning
an error here without reverting it might permanently prevent the target pro=
gram
from being used as a tail callee, since prog_fd_array_get_ptr() strictly
rejects programs with is_extended =3D=3D true.

Should this error path revert aux->is_extended to false?

> +	}
> +
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_2EB11B90742=
07E825BE3ACC0AF1F09DE0108@qq.com?part=3D1
