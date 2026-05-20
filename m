Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228603A3E90
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 16:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294381; cv=none; b=kd8UAHUXzjHDQ/znIbIVsigdmqeuz5TatO89FYcbsEVlB3z8FyFfDRa4F9ksvsUqlb7YGhJI/+xKzlo8d4E7666ziOQGrsnFSvdD1ai6N83HdvTNAbIVe0/QrhoYbaUyiBjRKko4yxGv2ZUH8k7m+ZWofDKOE/dx+1qEqGfevr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294381; c=relaxed/simple;
	bh=kW9Xr7guDLrAipwM2bR3YgKTzYDIyaHPPjVvzmsmDCY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c9mEm0CffKl4+E39Wq18+Iw+oL0r3A7uwPprvD1hRE6y8UntufIprvp0oeSFn6/YNu7tDmcwPqSUQycqD/sdSfxThfOeYHKoEdR7v7gEh3qjxs6cbMkUWc8mVaITAO0Wu674ATfKLPG1+xt3DHAUVwyoQjtiK3Yf1fSWcFlM58k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fn1csG0H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fn1csG0H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BA41F00893;
	Wed, 20 May 2026 16:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779294379;
	bh=TcLoe8c2jIlADFsZezrjPxBUsG2nXMxJ5LR4GrXAugk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fn1csG0HR/VKLLBcxiLeiNQrePvkjbmfuxsT4+lTTjkMFmLexhannZpjXsWSKEpin
	 52A7xra9t4T15nxh3MKvUMGQ0frCSqUDlhj/SizI3OX4o3VSGcxQTb5ffCEXZ1YODL
	 WATHJVZJ2tF14dqopNUKmrgVfYYDXxWVRFDuOOqGEkfqjd5WaoODC1W+7EvN0x2/sp
	 23RkFWeEXVvBTiuiadswwFuy8GOndzABTLZH6luJtLluhhGqCw9Tb+4tZ/vUJx+dYd
	 /f3WpwwEi+tSiQTS+yQCWr2DU9Q+6U2Jxu6wfn1dz0GPmauGwfXwrly5c8FmfFwrbE
	 r0heGhbDzgKUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 10/20] unwind_user/sframe: Remove .sframe section on
 detected corruption
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520154004.3845823-11-jremus@linux.ibm.com>
References: <20260520154004.3845823-11-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 16:26:19 +0000
Message-Id: <20260520162619.A7BA41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Concurrent stack unwinds encountering an invalid .sframe section w=
ill trigger a WARN_ON_ONCE, allowing unprivileged users to cause kernel pan=
ics.

Pre-existing issues:
- [Critical] A TOCTOU race in sframe_remove_section leads to SRCU callback =
list corruption and memory leaks.
--

commit db7031336962bd6fc8db7c08a1c00d847ae5869b
Author: Josh Poimboeuf <jpoimboe@kernel.org>

unwind_user/sframe: Remove .sframe section on detected corruption

This commit updates the sframe unwinder to remove an .sframe section
if corruption is detected during the unwind process. It handles access
faults and invalid entries by calling sframe_remove_section() on the
corrupt section.

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> index f723c1a32f906..02331956009a0 100644
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c

[ ... ]

> @@ -360,16 +360,23 @@ int sframe_find(unsigned long ip, struct unwind_use=
r_frame *frame)
>  		return -ENOENT;
> =20
>  	if (!user_read_access_begin((void __user *)sec->sframe_start,
> -				    sec->sframe_end - sec->sframe_start))
> -		return -EFAULT;
> +				    sec->sframe_end - sec->sframe_start)) {
> +		ret =3D -EFAULT;
> +		goto end;
> +	}
> =20
>  	ret =3D __find_fde(sec, ip, &fde);
>  	if (ret)
> -		goto end;
> +		goto end_uaccess;
> =20
>  	ret =3D __find_fre(sec, &fde, ip, frame);
> -end:
> +end_uaccess:
>  	user_read_access_end();
> +
> +end:
> +	if (ret && ret !=3D -ENOENT)
> +		WARN_ON_ONCE(sframe_remove_section(sec->sframe_start));

[Severity: High]
Could this WARN_ON_ONCE be triggered concurrently by unprivileged users?

If multiple threads concurrently encounter an error while unwinding through
an invalid .sframe section, they might both jump to the end label. The
first thread will successfully remove the section and return 0. Subsequent
threads will fail to find the section since it was already removed, causing
sframe_remove_section() to return -EINVAL.

Since -EINVAL is non-zero, this would unconditionally trigger the
WARN_ON_ONCE. If panic_on_warn is enabled, could this allow a malformed
section to intentionally crash the system?

[Severity: Critical]
This is a pre-existing issue, but does sframe_remove_section() have a race
condition that can corrupt the srcu callback list?

Looking at sframe_remove_section(), it locklessly iterates mm->sframe_mt
using mt_for_each() to find the section pointer:

kernel/unwind/sframe.c:sframe_remove_section() {
    ...
    mt_for_each(&mm->sframe_mt, sec, index, ULONG_MAX) {
        if (sec->sframe_start =3D=3D sframe_start) {
            found =3D true;
            ret |=3D __sframe_remove_section(mm, sec);
        }
    }
    ...
}

If a concurrent thread erases the original section and inserts a new one
at the same text_start, mtree_erase() inside __sframe_remove_section()
would remove the new section. The code would then unconditionally call
call_srcu() with the old sec pointer.

Because the old section is already pending in the srcu callback list,
would double-queuing it corrupt the list and permanently leak the newly
erased section?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520154004.3845=
823-1-jremus@linux.ibm.com?part=3D10
