Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BA01A267
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375908; cv=none; b=auFCPXujYc6hCMbuuQK76pS4uAyvFvn7FCciNPIVL1sDvkagWwGkAOjK/TEsDrMEI+dIMH0SUAQyhc8s+e7rBea2zdS0edTqZcttaM4WdSKml+kQB91rwxq1IF4+f/Bn1Z+wub0eBf6M3jB/4Z2Y+Uuc+xTCtoWsYO2FzfeWwi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375908; c=relaxed/simple;
	bh=dsus2O+dZzpXr2Er3C+bim//4WX+zaW05jdCTmiytUc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hdziV2zeesP8w0W4DMqPPmkimK701NZnK9jsPOqHwIgRrGHbOj+0chgyH35BEQlyE6pnc19f6yEZ4344UrVVQwhfrZ2dHURkRY34AnONJslrhk4M24ePIQJm+i5ubSDZj6szPKPKJC5Z+eKeX+InImypjz6/qI25f2ch/AcfWLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwf8+jLY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwf8+jLY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1088A1F000E9;
	Thu, 21 May 2026 15:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779375907;
	bh=+Bk0ZN8k624SltLfaoVkOnhuEbjCWOGK9o8LnZWFqKI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fwf8+jLYpm9kZpI5J9ZZXZhpnaPFD1UafExymEPFU+mGY6E4rFB784KHpXOzbVyiL
	 MS+dhEkU0uq3jUs4hGIZXvDfm7i9mIJ41XJdBLKxx7RSw2blmUi6yQSSm3v4+DMoTt
	 hKtirOGA+fq1Jft3xYg2eUncM1ErLyBWKhehlOKcHazDoiLUT+7OPxkEFKdKlBhQe0
	 ySMz3OLBlF8c+BArrdaX//lex87pjMjSBkYBEkIlMV66Bw4NOGxmt1FBipcLEbOKIZ
	 khrkdHDkTrituJ/seBwKkaMl+4VUcYsHA6ZZqD6Znge6K/nfb3SW8dZ2crGFzp8mdw
	 HXHIJzrLa6fXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 11/20] unwind_user/sframe: Show file name in debug
 output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521142546.3908498-12-jremus@linux.ibm.com>
References: <20260521142546.3908498-12-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 15:05:06 +0000
Message-Id: <20260521150507.1088A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] VMA Classification Bug in `dbg_init()`

Pre-existing issues:
- [High] Calling `sframe_remove_section()` upon `-EFAULT` causes a deadlock=
 in NMI context.
- [High] User-triggerable WARN_ON_ONCE in `sframe_find()` due to concurrent=
 removal of malformed `.sframe` sections.
--

commit fff3b1ad1d5f40f0ff8ee5d6dd0af4160fc5f674
Author: Josh Poimboeuf <jpoimboe@kernel.org>

unwind_user/sframe: Show file name in debug output

This commit enhances sframe debugging by prefixing debug output strings
with the file name corresponding to the .sframe section.

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> index e0eb2adf5a074..2cfa274cd8dcf 100644
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c

[ ... ]

> @@ -372,8 +372,10 @@ int sframe_find(unsigned long ip, struct unwind_user=
_frame *frame)
>  	}
> =20
>  end:
> -	if (ret && ret !=3D -ENOENT)
> +	if (ret && ret !=3D -ENOENT) {
> +		dbg_sec("removing bad .sframe section\n");
>  		WARN_ON_ONCE(sframe_remove_section(sec->sframe_start));

[Severity: High]
This is a pre-existing issue, but can this error path cause a deadlock in
NMI context?

sframe_find() is a core unwinder function frequently invoked by perf PMU
interrupts, which execute in NMI context. If reading the user memory
fails, scoped_user_read_access_size() returns -EFAULT. This handler treats
it as a corrupted section and calls sframe_remove_section(), which
eventually calls mtree_erase() and acquires the maple tree spinlock.

Taking a non-irqsafe spinlock in NMI context violates kernel locking rules
and will immediately deadlock if the interrupted thread holds the same lock.
Could an unprivileged user exploit this to trigger a local denial of servic=
e?

[Severity: High]
This is also a pre-existing issue, but is it safe to unconditionally call
WARN_ON_ONCE(sframe_remove_section(...)) here?

If multiple threads concurrently trigger unwinding on a malformed or recent=
ly
unmapped .sframe section, they could all reach this error path simultaneous=
ly
under the SRCU read lock.

The first thread successfully removes the section, but subsequent threads w=
ill
fail to find it, causing sframe_remove_section() to return an error like
-EINVAL. This triggers the WARN_ON_ONCE, which can trivially panic the syst=
em
on kernels with panic_on_warn enabled.

> +	}
> =20
>  	return ret;

[ ... ]

> diff --git a/kernel/unwind/sframe_debug.h b/kernel/unwind/sframe_debug.h
> index 36352124cde81..a63e75cccc700 100644
> --- a/kernel/unwind/sframe_debug.h
> +++ b/kernel/unwind/sframe_debug.h

[ ... ]

> +static inline void dbg_init(struct sframe_section *sec)
> +{
> +	struct mm_struct *mm =3D current->mm;
> +	struct vm_area_struct *vma;
> +
> +	guard(mmap_read_lock)(mm);
> +	vma =3D vma_lookup(mm, sec->sframe_start);
> +	if (!vma)
> +		sec->filename =3D kstrdup("(vma gone???)", GFP_KERNEL_ACCOUNT);
> +	else if (vma->vm_file)

[Severity: Low]
Does this correctly classify file-backed VMAs?

The MM subsystem guidelines state that vma->vm_file shouldn't be used as a
proxy for file-backed classification, because anonymous mappings (like priv=
ate
mappings of /dev/zero created by some drivers) can still have vm_file set.

Should this use !vma_is_anonymous(vma) instead?

> +		sec->filename =3D kstrdup_quotable_file(vma->vm_file, GFP_KERNEL_ACCOU=
NT);
> +	else if (vma->vm_ops && vma->vm_ops->name)
> +		sec->filename =3D kstrdup(vma->vm_ops->name(vma), GFP_KERNEL_ACCOUNT);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521142546.3908=
498-1-jremus@linux.ibm.com?part=3D11
