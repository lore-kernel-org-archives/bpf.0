Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110903AB28D
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 06:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788937066; cv=none; b=CrDjGJSXBejqz3fFBSTmt2WWU18j+HAXTTFjmhHPsEg1+bHqWm6KgNt+7XBuX3S/EXJE285wprMSdB56NyXlKfmbfHWi9YNpEYea6JpEJEbuTrVSphu7V24FHAUH1HMyqKErpVafrbE6kqJ0aqzqVWxVQKM5n4PCY9RsTOZ+DXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788937066; c=relaxed/simple;
	bh=KlWKlIP500+Cphum5eXH7pELvy5cixqPU+O+NJN94NY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kamzKIrctsO1v4jbKt41Zr3q3Hchcny4qzt5/+E1kPfs7JuM6a4zEdzfTj4RjRu9N/NM6xMpuZfwjZWeEixSHtCGMCh6TXIHpgl6ZxdeinuD3IChlULCoG1nGDOQdozeMqxspfvjpnz7EjGC47ajjNePDKWr194dxxZaZ0P5DBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liR/1L+5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liR/1L+5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFDC1F00A3A;
	Wed,  9 Sep 2026 06:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788937064;
	bh=yzK22K0w34+OZ3j+IPlTcnEdUp3k9JAIHCDB6e73ETw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=liR/1L+5OMJX/14Sam1sehmwXKaQIiUOpPswINaqVzteLWVO9XC3Y6WPJ6rN5pnTy
	 ptbcS0kKwTwmBsO71g6O/dg5ZdISPAtKAd10I0UNPqOCWyrB+NOGuQIR2Op9UoQm1u
	 NhcTAFdqwgWN+yZJcPR8Q00/q7TT0Qducb8o0aDEueypCTSZUvouT8twaBICquFuY+
	 YdBHDB5aRnZNDDvTNJIQPB0LPyOEVIKP5E02jeptItmpGy94Xe9RguyZUIUgaikQd9
	 r6opDE2nBSSzMoR3DwlpGN3/L7wNZ78nQyfTp1U/L7QRm5iF7lb2JIJ1Fgau6byUMI
	 +uydc2KLejZVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/nommu: Reject wrapping ranges in access_remote_vm()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anastasios Papagiannis" <tasos.papagiannnis@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260909064231.18693-1-tasos.papagiannnis@gmail.com>
References: <20260909064231.18693-1-tasos.papagiannnis@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 06:57:43 +0000
Message-Id: <20260909065744.3AFDC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Using `vma->vm_file` as a proxy to check whether a VMA is anonymou=
s or file-backed.
--

commit 35aeff0bf93ec8eeae453b43c1f6540a0d793165
Author: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>

    mm/nommu: Reject wrapping ranges in access_remote_vm()
   =20
    The NOMMU implementation of access_process_vm() rejects address ranges
    whose end wraps around, but access_remote_vm() bypasses this check even
    though both functions delegate to __access_remote_vm().
   =20
    Move the wraparound check into __access_remote_vm() so it applies to
    both entry points.

    Link: https://lore.kernel.org/bpf/4ef240a5bea36ff84df958967136783286079=
5159386a4c8fba546a0fa8b786f@mail.kernel.org/

> diff --git a/mm/nommu.c b/mm/nommu.c
> index 498e01ee40b05..ed44510e37707 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c

[ ... ]

This isn't a bug introduced by this patch, but while reviewing mm/nommu.c,
I noticed a pre-existing issue regarding VMA classification:

> 	/* clear anonymous mappings that don't ask for uninitialized data */
> 	if (!vma->vm_file &&
> 	    (!IS_ENABLED(CONFIG_MMAP_ALLOW_UNINITIALIZED) ||
> 	     !(flags & MAP_UNINITIALIZED)))
> 		memset((void *)region->vm_start, 0,
> 		       region->vm_end - region->vm_start);

[Severity: High]
Does this code in do_mmap() rely on vma->vm_file to check if a VMA is
anonymous?

If a driver sets the VMA as anonymous (e.g., via vma_set_anonymous()) but
leaves vma->vm_file set, the check relying on !vma->vm_file will fail. Could
this skip the memset and leave kmalloc'd memory uninitialized, exposing
kernel memory to userspace?

The MM VMA guidelines suggest the correct test is vma_is_anonymous(vma).

This same pre-existing pattern appears in split_vma():

> 	/* we're only permitted to split anonymous regions (these should have
> 	 * only a single usage on the region) */
> 	if (vma->vm_file)
> 		return -ENOMEM;

[Severity: High]
Could this incorrectly prevent the splitting of anonymous VMAs that happen =
to
have a vm_file set by returning -ENOMEM?

And similarly in do_munmap():

> 	/* we're allowed to split an anonymous VMA but not a file-backed one */
> 	if (vma->vm_file) {
> 		do {
> 			if (start > vma->vm_start)
> 				return -EINVAL;

[Severity: High]
Does this incorrectly classify the VMA during unmap, applying file-backed
rules to anonymous VMAs that still have a vm_file, leading to -EINVAL error=
s?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909064231.1869=
3-1-tasos.papagiannnis@gmail.com?part=3D1
