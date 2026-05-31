Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EBD3911CD;
	Sun, 31 May 2026 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780247335; cv=none; b=txvD+YQBFygIKpqOkn8BkZ2GjnEtkYHV/FQg9kkk+QVakfkrG1xw+zMOTNNcPmihgbWyavwoMyKJCxeQb9c52ByfBQ6G4pbIQiMFoDrtNH/Wu4K6MSmMrK22mw38SJl1y1/vlW62nwqgF4owx37KN7Y1RRO0M+6ZVPoBaN2fgq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780247335; c=relaxed/simple;
	bh=Sd0q98U25/qaaQ7ZUjikS5QwrJRiAqTys/rf5+m6XNM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ObuJ8Bkv2pR5xTY3QtsST0gfjl/Ll5YYleE5mCJ8Y27HczCVMIGUSFTn5hTVY2BnXc9KACsU8/MgqSKKSf3/DM5dXRZsnJjZAcEcj67wXrLbTkrK9TFK84JBhIueRzUGyVjsR/e85dQ5vOsvcsjf+43GSxjl0Ster213iH50Fe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCDIpzR5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCDIpzR5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EA51F00893;
	Sun, 31 May 2026 17:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780247334;
	bh=BCQy+Kt7Z3uT0ciaB5lvJ7scfLo+Tg/HlLQASP5TF1A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iCDIpzR5PFUPvWBhZQ1Xkx23GcJiAxYosHxSqwsPw6dxM592VOPlgSqfmyGWavRqp
	 zaONTcK2ditbRjU2o/K+JAKbMS7M5m4RTzAjiCe7tqld76afN5aFoiwPBS6UceiC71
	 yhXS8GH26TA7hYkj5JS9/rywIQNMwkXmK7UAaBIqBggUIcrOnwnHAh9x7yVI7QDHjs
	 E28MGJpe00himQytXPkZxRQScDW6KZraJEHzC8c5GoiHrxDeEZBfoYXyWgm7ePRaio
	 1SAV+S7+rY+r8/J1vh83sctipXl9deIos6foX3EYWrLD5pISgc5yE6BGDTRFBk+ISm
	 62Wf78LmOZcxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf: Overwrite scratch PTE when allocating
 arena pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: bpf@vger.kernel.org, sched-ext@lists.linux.dev
In-Reply-To: <20260531165852.555930-1-tj@kernel.org>
References: <20260531165852.555930-1-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 17:08:53 +0000
Message-Id: <20260531170854.31EA51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Overwriting a present PTE (the scratch page) with a new page v=
ia set_pte_at() without first clearing it and flushing the TLB violates Bre=
ak-Before-Make (BBM) architecture rules and causes silent data corruption v=
ia stale TLB translations.
--

commit f66bc91b18a1403f8777f0486173da0584f46ca3
Author: Tejun Heo <tj@kernel.org>

bpf: Overwrite scratch PTE when allocating arena pages

apply_range_set_cb() previously returned -EBUSY when encountering a
populated PTE. This patch removes that check to allow unconditionally
overwriting the scratch page left behind by kernel-fault recovery during
new arena allocations.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index a641b19255aad..9e0b9f2170204 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -157,15 +157,13 @@ static int apply_range_set_cb(pte_t *pte, unsigned =
long addr, void *data)
> =20
>  	if (!data)
>  		return 0;
> -	/* sanity check */
> -	if (unlikely(!pte_none(ptep_get(pte))))
> -		return -EBUSY;
> =20
>  	page =3D d->pages[d->i];
>  	/* paranoia, similar to vmap_pages_pte_range() */
>  	if (WARN_ON_ONCE(!pfn_valid(page_to_pfn(page))))
>  		return -EINVAL;
> =20
> +	/* May be none or the scratch page, overwrite either way */
>  	set_pte_at(&init_mm, addr, pte, mk_pte(page, PAGE_KERNEL));

[Severity: Critical]
Does unconditionally overwriting a present PTE with set_pte_at() without
first clearing it violate Break-Before-Make architecture rules?

On architectures like arm64, overwriting a valid, present PTE without a
sequence like ptep_get_and_clear() can trigger hardware TLB conflict aborts
or panics.

Additionally, since this changes the PFN of a present PTE (the scratch page=
),
doesn't this require a TLB flush?

Looking at the caller arena_alloc_pages(), it appears to only invoke
flush_vmap_cache() after the apply_to_page_range() loop:

	ret =3D apply_to_page_range(&init_mm,
				  kern_vm_start + uaddr32 + (mapped << PAGE_SHIFT),
				  this_batch << PAGE_SHIFT, apply_range_set_cb, &data);
	...
	flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);

Since flush_vmap_cache() flushes data caches and not the TLB, could CPUs
retain stale TLB mappings to the scratch page? If so, subsequent accesses
might hit the shared scratch page instead of the newly allocated page,
bypassing memory isolation.

>  	d->i++;
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531165852.5559=
30-1-tj@kernel.org?part=3D1
