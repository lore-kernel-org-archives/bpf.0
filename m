Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6E3476045
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787763007; cv=none; b=cVMpHR8xYrcnFTI6eMUFoKBNbWpQYBZ8IZQXEN1iiaz2XCQI3XORr6IPeDtfVUmCzz2D2bz8iW70QIrq512Ge1TtfAyUYl7sENwjPpCPFkuaSL2hfCXaUYmERfZHLQpaNAMEbqx5SnWqqFxUteOaHwIWnEKElUxPcB7MgmlSO2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787763007; c=relaxed/simple;
	bh=gyAGShIU3iQTYDNyBDu4boa6MbRI636k3dQ/B+YQym8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GCsXEjjIqVTFypJ47AEOGQBlhZ+QdKmGyg3W8jMZ1YppVHc9UC03laGvr/pqQgGpf0sZnLSqE7B8dGcELR4dHA53mtpfTS2nPR5EC/SoxhkGcFD02PDNF2uS4UvEFXM/eqCjuci6cKexAS4HKdFzAxfVnAPj4yje6tSqlDe1ujM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUT4tqJ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUT4tqJ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278A51F00A3A;
	Wed, 26 Aug 2026 16:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787762989;
	bh=g5+gq/QA//eLWjkv2eBh4wh6EYwfb0CycHWwCROlvBA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QUT4tqJ2ntsTysFmBe8D+rPdLX8McC4UYImFpXBKdm4i3umEC4ERvXnNve4xCG6wk
	 0vygXPAI1/aFCFnt90Ovsnfggoe7gy0xGphxexisqCAkhdR9IWEEgdZosVcpyThgO+
	 C76AWfDYp9S0z2qiHV5AYdJlUmyjopfLESP30YiCJoj5Ypb81qnK4BOher4aTgck5+
	 eeu7NSRgfxDVizC1hK0osvdgLoDlOTCZpcwjdl9gkZiLvZ6NIt1m41GTQhu6GPZMyt
	 U/AAHS7IFG+qdHEsu1pNSsKOjHGgBmtjJ6/W8mEiwHOJN5jQNfT+xRBYZR+mZe75pp
	 p1QombcQWSabw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] mm/secretmem: properly account locked pages
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260826-secretmem-accounting-v3-1-94cb04399510@kernel.org>
References: <20260826-secretmem-accounting-v3-1-94cb04399510@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 16:49:48 +0000
Message-Id: <20260826164949.278A51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] __secretmem_account_pages() validates the faulting process's RLIMI=
T_MEMLOCK but charges the file creator's locked_vm, allowing limit bypass a=
nd privilege escalation.
- [High] Secretmem folios evicted from the page cache via posix_fadvise per=
manently leak locked_vm charges during the file's lifetime, leading to unbo=
unded double-accounting.
- [Medium] The removal of proactive RLIMIT_MEMLOCK checks during mmap() cha=
nges the error behavior from -EAGAIN to a fatal SIGBUS during page faults, =
breaking userspace API semantics.
--

commit 40e3e15f3a115ea49fb48575254bb19c8bf4d03e
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>

mm/secretmem: properly account locked pages

secretmem accounts folios by treating memory as if it were mlock()'d and
thus limited by the RLIMIT_MEMLOCK limit.

> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index d29865075b6ea..384f5cfc457f9 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
[ ... ]
> +static bool __secretmem_account_pages(struct user_struct *user,
> +		unsigned long nr_pages)
> +{
> +	unsigned long page_limit, cur_pages, new_pages;
> +
> +	if (!nr_pages)
> +		return true;
> +
> +	page_limit =3D rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> +
> +	cur_pages =3D atomic_long_read(&user->locked_vm);
> +	do {
> +		new_pages =3D cur_pages + nr_pages;
> +		if (new_pages > page_limit)
> +			return false;
> +	} while (!atomic_long_try_cmpxchg(&user->locked_vm,
> +					  &cur_pages, new_pages));
> +	return true;
> +}

[Severity: High]
Does this code check the faulting task's limit but charge the file creator's
locked_vm?

If an unprivileged user creates a secretmem fd and passes it to a privileged
process which then faults the memory, it appears rlimit(RLIMIT_MEMLOCK)
resolves to current (the privileged task), while the pages are charged to
state->user->locked_vm (the unprivileged creator).

Can this bypass the creator's constraints and permanently inflate their
locked memory footprint until the file is closed?

[ ... ]
> @@ -72,8 +133,15 @@ static vm_fault_t secretmem_fault(struct vm_fault *vm=
f)
>  			goto out;
>  		}
> =20
> +		if (!secretmem_account_folio(state, folio)) {
> +			folio_put(folio);
> +			ret =3D VM_FAULT_SIGBUS;
> +			goto out;
> +		}
> +

[Severity: High]
If a user unmaps the page and calls posix_fadvise(POSIX_FADV_DONTNEED) on t=
he
fd, the clean folio is evicted and mapping->a_ops->free_folio
(secretmem_free_folio) is invoked.

Since secretmem_free_folio() isn't updated in this patch to unaccount the
pages, does this permanently leak locked_vm charges?

Could a user loop this (access page, unmap, posix_fadvise) to exhaust their
RLIMIT_MEMLOCK limit without actually using physical memory, denying them t=
he
ability to use locked memory until the file is closed?

[ ... ]
>  static int secretmem_mmap_prepare(struct vm_area_desc *desc)
>  {
> -	const unsigned long len =3D vma_desc_size(desc);
> -
>  	if (!vma_desc_test_any(desc, VMA_SHARED_BIT, VMA_MAYSHARE_BIT))
>  		return -EINVAL;
> =20
> -	vma_desc_set_flags(desc, VMA_LOCKED_BIT, VMA_DONTDUMP_BIT);
> -	if (!mlock_future_ok(desc->mm, /*is_vma_locked=3D*/ true, len))
> -		return -EAGAIN;
> +	vma_desc_set_flags(desc, VMA_DONTDUMP_BIT);
>  	desc->vm_ops =3D &secretmem_vm_ops;
> =20
>  	return 0;

[Severity: Medium]
Does removing the proactive mlock_future_ok() check during mmap() break
userspace API semantics for applications managing memory constraints?

Applications relying on mmap() failing gracefully with -EAGAIN when limits
are exhausted will now see mmap() succeed, but will unexpectedly crash with=
 a
SIGBUS signal during normal memory access in secretmem_fault().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-secretmem-=
accounting-v3-1-94cb04399510@kernel.org?part=3D1
