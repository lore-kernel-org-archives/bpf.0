Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AD92D5436
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644740; cv=none; b=NGhFvP/dYgplOvnSdGvi/sfXrSy42gPri0/8LMEgAJAzS2CIMdI64yVL/weY0E757hK/Ejuf+FYDtP8jIz0x+bYbtHZBmUx0jfcRhO3FMWPkPYXIohaDg/kSwI1w/HUsKeq3lsdFHlV7VBt1Yf0/5SZuFwNt02kgYqYcsUwQbrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644740; c=relaxed/simple;
	bh=7YiPVL0nZ3VU5vaAicRoMuisfVb3QW43rs7wuU9qZXs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GjYSjtTeTzRCc4uCOtJA1akOeutRTSoyE9Cfebneu/xbKBw2wY8nKM1gePMypMpjBzJdvQArFikCLWPToiO6fQ4lvDfL6IVmfdiCH49xLlF/g9domzHZ54VYjBGauUqge5892WW5WsXGUcpU+A313ZIDDsOsOMuJ8RQRvvlBnI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CffvyykK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CffvyykK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE431F00A3A;
	Tue, 21 Jul 2026 14:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784644739;
	bh=biL9uzTlRR1A9JgAenptqQbvgyqtjJfbELk9f+OVxC8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CffvyykK74hkek5nyS1sLaWdH1e8+a8R3M9mBoNMb/gPSlZEIG6xN3O+f/ZGLe7xy
	 S/6xLXotGZ0fYS2lewFAvgcy/e2CTqg7uQYazDcQ/2Zowm6mkhvbooZgKoCECsW04l
	 QwvGjNwFt79lXATg/5T6HDsZ1ov27945xbvFJb0vPHcYgUTeeIig9Vj6fpS5IIHSgi
	 xWqH83RJUGqDorNi4kUq04a4GXnGaLWDjK0P5fZpjcW2MgzhkJ0UPRvCXab+H3Az0y
	 txpucTmVWwMrUuT5VKc2OOMp+bojkaLJnFw8hMBS85/dl2Wg/yhDPXKlu5hlZaGAru
	 PP5uZTWAjYTpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/21] binfmt_elf: consume a stashed PT_INTERP
 substitute
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260721-work-bpf-binfmt_misc-ptinterp-v2-16-e57866e4ae0f@kernel.org>
References: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
 <20260721-work-bpf-binfmt_misc-ptinterp-v2-16-e57866e4ae0f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 14:38:58 +0000
Message-Id: <20260721143858.EBE431F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `load_elf_binary` consumes `bprm->loader` but can later return `=
-ENOEXEC`, defeating the `begin_new_exec` safety net for fallback formats.
--

--- Patch [16]: [PATCH v2 16/21] binfmt_elf: consume a stashed PT_INTERP su=
bstitute ---
commit 1d03dfaf1de4f305ec2f86af4a17c4c21f4a7858
Author: Christian Brauner <brauner@kernel.org>

binfmt_elf: consume a stashed PT_INTERP substitute

When a binfmt_misc loader entry stashes bprm->loader, use it instead of
opening the path named in PT_INTERP. A binary without PT_INTERP drops
the override and is loaded natively.

> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
[ ... ]
> @@ -932,6 +932,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  		goto out_free_ph;
>  	}
> =20
> +	/* No PT_INTERP to substitute for: the override does not apply. */
> +	bprm_drop_loader(bprm);
> +
>  	elf_ppnt =3D elf_phdata;

[Severity: Medium]
If load_elf_binary() consumes bprm->loader here (or earlier in
bprm_open_interpreter()) but later returns -ENOEXEC, does this defeat the
safety net for fallback formats?

For example, if parse_elf_properties() fails later in the function:

	retval =3D parse_elf_properties(interpreter ?: bprm->file,
				      elf_property_phdata, &arch_state);
	if (retval)
		goto out_free_dentry;

If this returns -ENOEXEC, load_elf_binary() will exit after the loader has
been consumed (bprm->loader is now NULL).

Would this allow search_binary_handler() to fall back to the next format
(like binfmt_elf_fdpic) which could then successfully execute the file
natively, bypassing the intended loader override?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-work-bpf-b=
infmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org?part=3D16
