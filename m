Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB232D5436
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644776; cv=none; b=mUDZS9RPLkJbg1OKXDC+5UpCNz9Q4muQybaap/x6nqWxUJ32h8zRfX9sVQFiTB7Ju3m0Rqd4qovh6z7l1ih1Nn0ydf6j9JOAsf+kr9oO3BjgSzT//Ps56Xp0PrWwTE138kSKw0lDc5tD1B7BXBDVTCZ692SETuM208MXTfbSakc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644776; c=relaxed/simple;
	bh=HIXM1uViDdV6dmUtGmosG0Za7+GDt3/IjHh0IWPh+Q0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F3xSHYl3P8T+shBGKU4puo0OoF+LclUAPi6hR5Z67kdfdrXWB7aEqmYSklCNNbUWQW1NtBTD6bPoZMfAmO5k8Jt9B/pcrOvME8g6niyBisI2Cngj380AXc3ncPS6IcnCzzY+Z0jNvkT/iKQGU8FBd9E7pdccJb6s7RQgmyj/3/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZiGMKRz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZiGMKRz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A5E1F000E9;
	Tue, 21 Jul 2026 14:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784644775;
	bh=Q710nzUtGAumqjA4ZPDQMJcJCkxGx8z9ls7JAaK/KoI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VZiGMKRzKywYronAM2sSVj3LLlFL0NEr5PTVk5pkpqfUs10j2x6Yq8Zj58xFlBt16
	 0/rh2WE4MFepaHvRQ91UhQOkl2ypyBwJywT2gTn0KFH7mEbW8u2X60nM5DMAMuKRD9
	 MuHccV+H/9LW+pKQYTd/GjO0s7JcyDcotlZOkwxhLqRLmpsEFXViT2QTEDsYMYVPao
	 QKzAjWpsYKiFJ6rVAWNz5EQgtO7s3a/rqZK8NHtYUzqlhFnoQrakGJv95uNipfXXj7
	 +kOGJy9BX3Etr9kpfXfL+Gp/xickLrsf73zdpfm9x9F9NRJIFRYY1mKv+Q+ans+ox2
	 JnTNFD4JlWp0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/21] binfmt_misc: add a static transparent flag 'T'
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260721-work-bpf-binfmt_misc-ptinterp-v2-11-e57866e4ae0f@kernel.org>
References: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
 <20260721-work-bpf-binfmt_misc-ptinterp-v2-11-e57866e4ae0f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 14:39:34 +0000
Message-Id: <20260721143934.E2A5E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Unprivileged users can spoof `/proc/pid/exe` of arbitrary syst=
em binaries to bypass path-based security mechanisms (like Polkit) using th=
e new `T` (transparent) flag in a user namespace `binfmt_misc` mount.
--

--- Patch [11]: [PATCH v2 11/21] binfmt_misc: add a static transparent flag=
 'T' ---
commit b5f0e2f272e45d606e37bd2e4e198bd848f87a56
Author: Christian Brauner <brauner@kernel.org>
Subject: binfmt_misc: add a static transparent flag 'T'

This commit adds a 'T' flag to binfmt_misc registrations to allow
transparent dispatch. The matched binary keeps its argument vector and is
sent to the interpreter through AT_EXECFD, with the process identity set
to the binary's identity rather than the interpreter's.

> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index e5a17ca935cad..71833b976131b 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
[ ... ]
> @@ -764,6 +765,11 @@ static struct binfmt_misc_entry *create_entry(const =
char __user *buffer,
>  	if (test_bit(MISC_FMT_BPF_BIT, &e->flags) && p !=3D flags)
>  		return ERR_PTR(-EINVAL);
> =20
> +	/* Transparency preserves the whole argv, argv[0] included. */
> +	if ((e->flags & MISC_FMT_TRANSPARENT) &&
> +	    (e->flags & MISC_FMT_PRESERVE_ARGV0))
> +		return ERR_PTR(-EINVAL);
> +

[Severity: Critical]
Does this code allow an unprivileged user to spoof /proc/pid/exe for arbitr=
ary
system binaries?

Since binfmt_misc supports unprivileged user namespace mounts, could a local
user mount it and register a handler using the new 'T' flag to match a
privileged system binary?

If the 'C' flag is omitted, the execution wouldn't fail suid checks and the
interpreter would run with unprivileged credentials. However, the transpare=
nt
flag unconditionally sets BINPRM_FLAGS_TRANSPARENT_INTERP in load_misc_bina=
ry(),
which later triggers execution paths where the privileged system binary bec=
omes
the identity file:

fs/exec.c:bprm_identity_file() {
    ...
    if (bprm->interp_flags & BINPRM_FLAGS_TRANSPARENT_INTERP)
        return bprm->executable;
    ...
}

fs/exec.c:begin_new_exec() {
    ...
    retval =3D set_mm_exe_file(bprm->mm, bprm_identity_file(bprm));
    ...
}

Could this bypass path-based authorization checks in system services like P=
olkit
by masquerading the unprivileged interpreter as a trusted system binary,
essentially circumventing the capable(CAP_SYS_RESOURCE) check normally requ=
ired
to change mm->exe_file?

>  	if (*p =3D=3D '\n')
>  		p++;
>  	if (p !=3D buf + count)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-work-bpf-b=
infmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org?part=3D11
