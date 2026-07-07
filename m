Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BA73BED79
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 19:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453784; cv=none; b=AKwxjcLaVPICzvC3CZgv2FNdxWXrCt2gOV5PlSpeQjL5/9hjCgCT5nPGGMV1aLTvhhseZR9AFuf1jNly+b/xiIMstHJj3gcLffyiV2k3pPDaukzbqj+i9p5oKM9i55JvUOZyTRnKmGwP7EY2uMrPPl0mu70Dm3t8uMRqwN/8OF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453784; c=relaxed/simple;
	bh=+Y7QYBcmtoo7c+mnzHmB8KBiIlt+tDSdfuNq9e8ylXY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZWbnZsJU0ArcZxgoA1s4nGs1cHdzUTr1XUDo3Tz1cPCAhkrfH0xUu57cw0yGWM4nn76yBkPii9kfGAHnsGyxvonkt6cLYKrcAM1M+KHuLxyOoVD9tLZkiF9rdoyHJvoD7GsJdejLo4lV76K/PhTFFl2+7qA2HkUEKKC+S3yYrgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sc9zJoX1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sc9zJoX1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A391F000E9;
	Tue,  7 Jul 2026 19:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783453783;
	bh=p9gA514ZMATBSGmcit8AYAtRbEvltc2/E89vb2NIQa4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sc9zJoX1F/dA5pcMDHL7IaDhVcKrUtEFD6IxJ5udTKbCM/82Ru4TbDRx6Qg8d8QXV
	 SSvwRS4NH+S7btqtwXPjkd2qN2m8BfwxOpNGe9/wOI79mSEe3VPr0lN2t/uXifE6OQ
	 o0Bauff3P1yLWs1DI5D2rpjgxKKrG36egV0bw/NmARN7ADisUoHcIK1hqMnCRirwJe
	 aSNtL/Dw8k1u+eNEr/zP3lXcWsaQ3lWYCa8zBWH2s8NVYswlAfVu1+HjJa/2F2FM2E
	 pa9uLxpiAS6fM7LX6M9UQMJISIcw7imYmmxDVH7fL8T3f3inpD9ZEJeSVTlyMCm0gt
	 4ppuSXrZ6P7Fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 2/4] binfmt_misc: add binfmt_misc_ops bpf
 struct_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260707-work-bpf-binfmt_misc-v1-2-74b995c84ec1@kernel.org>
References: <20260707-work-bpf-binfmt_misc-v1-0-74b995c84ec1@kernel.org>
 <20260707-work-bpf-binfmt_misc-v1-2-74b995c84ec1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 19:49:42 +0000
Message-Id: <20260707194942.E7A391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] TOCTOU race in bpf_binprm_set_interp allows bypassing the absolu=
te path check.
--

--- Patch [2]: [PATCH RFC POC 2/4] binfmt_misc: add binfmt_misc_ops bpf str=
uct_ops ---
commit dcb835dea31af56f46fb0ad454883c437389225a
Author: Christian Brauner <brauner@kernel.org>

binfmt_misc: add binfmt_misc_ops bpf struct_ops

This commit adds a BPF struct_ops backend for binfmt_misc. It allows
computing the interpreter programmatically for matching binaries instead of
relying on fixed strings.

Link: https://lore.kernel.org/20260704211409.1978485-1-farid.m.zakaria@gmai=
l.com

> diff --git a/fs/binfmt_misc_bpf.c b/fs/binfmt_misc_bpf.c
> new file mode 100644
> index 0000000000000..72da0964d9491
> --- /dev/null
> +++ b/fs/binfmt_misc_bpf.c
[ ... ]
> +__bpf_kfunc int bpf_binprm_set_interp(struct linux_binprm *bprm,
> +				      const char *path, size_t path__sz)
> +{
> +	size_t len;
> +	char *interp;
> +
> +	if (!path__sz)
> +		return -EINVAL;
> +	len =3D strnlen(path, path__sz);
> +	if (len =3D=3D path__sz)
> +		return -EINVAL;
> +	if (path[0] !=3D '/')

[Severity: Medium]
Does this create a Time-of-Check to Time-of-Use (TOCTOU) race if path
points to a BPF map value?

If a BPF program passes a pointer to a map value as the path argument,
userspace could concurrently modify that map value after this check for '/'
but before the path is copied below. This would allow bypassing the
absolute path validation.

Should the string be copied via kmemdup_nul() first, and then the
absolute path check performed on the newly allocated interp buffer?

> +		return -EINVAL;
> +	if (len >=3D PATH_MAX)
> +		return -ENAMETOOLONG;
> +
> +	interp =3D kmemdup_nul(path, len, GFP_KERNEL);
> +	if (!interp)
> +		return -ENOMEM;
> +
> +	kfree(bprm->bpf_interp);
> +	bprm->bpf_interp =3D interp;
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-work-bpf-b=
infmt_misc-v1-0-74b995c84ec1@kernel.org?part=3D2
