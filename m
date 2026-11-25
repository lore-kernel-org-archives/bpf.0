Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578516;
	b=BR2WBrx/+7YHCpJ8HaUTxjiCTD4HyZoYuSX3enGJgXvem1BUL00lCN3dC2ToKgDQiz9S
	 gMV1QrOjg1eU8u564g1MhZFAykesLC/WLPZ2ruCcaPferwcYNpQQS4TLYnYRjV0OAQ58e
	 +LHQfJ0dPeS//YdUgZF4Kx7Y73OAcML89bCAbHywAPYsQaPgeHosJlcANhsFNmUxzzSCk
	 8qC37OqzRigsBcXEtZCT3+ZWaPFcaf9UWVgkyYRaH08ihRIBgKmjyJhrg61H4103v5Snu
	 2iXLtQZ1WrCb/e4ZR+FpVMyx1mUPy/e9LHWNfHZhH40737cidj1QPsZZfU9NE5eaeYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578516;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8Ttx7XCVkthCgqojx3GiZ18Ov1zXrMBznLrdGDtmANk=;
	b=AAiAEyV89lbdi57qS+p/pRofB9Coprj2JdD0ZKU5tRM+VOOlGt8jQbscyjaUgTyG1tyf
	 GKRgvzCwAYgvQmRD2cGwCS7di25XZb4dBh4lP2oRz19kzYHG2whSl6ihgBDQmaIY++nxA
	 XgJH9fsys+i/E3jFXM+HHsJvamfQKUB3GpvBElZ+yFIFTQLXCxVXUjMfsc8Gdol2GtQ0F
	 2kMIvyDDNDQEICy9iFQlxtWZI+/PDtFrNHZcCzgPjiG8nEFXqZHtsk8WQHILkMIpWZ3r3
	 Q2r+MBxITgqxZ5vGbCYvHg+zyW1iFbM8Uzt4REI9/m8DSjjSaj9DZARY/lkHP2B1lHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PK+QtqSv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304AF606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PK+QtqSv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3391F000C0;
	Wed, 25 Nov 2026 03:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795578516;
	bh=8Ttx7XCVkthCgqojx3GiZ18Ov1zXrMBznLrdGDtmANk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=PK+QtqSvRXJO0ud6wlkeeQmOv1r6QtbAFsCpM3mZyQr6jyU5K3sk69sN+VrcTLLVb
	 j3uBNCc9L8dLyS4eR0yRg0PXzfLlOnsUFyWMMw9S7u+K7gr4gb4wQVk5h6KDxAGxhD
	 sqB2Lv7ffjKl73wglDk4XJS2bVjMesyjK4f9CWJ76bMJgV9GnXrTncEry/7GuAfgB3
	 FD/KiQc/51ehcGngiSv2fe6BuUZd9KsoCI3hKLVyP3kqcVD5Q/LNPjOflB4Y4of3g5
	 ZRNy8udbd2EXWeMUXjEtr5KihO0oDEBYyFo/L3gpbvvhbCFS4kuXMyxHYLuXQmsWRE
	 m7cdnOxYG1pCA==
Message-ID: <sashiko-outbox-232511@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 22/47] bpf: Flush TLB when a page of arena replaces
 the scratch page
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261125032938.670542-23-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
 <20261125032938.670542-23-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 03:48:35 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] arm64/mm: ptep_try_set() undefined when CONFIG_ARM64_CONTPTE is
  disabled [1]
--

commit 4eb6b85f2fe787d069b3bed0effa2468a69cda9e
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Flush TLB when a page of arena replaces the scratch page

This commit flushes the TLB across all CPUs after dropping arena->spinlock
when a newly allocated arena page replaces the scratch page on architectures
without flush_tlb_before_set(), or fails and defers freeing the range when
the caller cannot sleep.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 2c6ddec747def..56bd02b783f98 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -149,6 +149,8 @@ struct apply_range_data {
>  	struct bpf_arena *arena;
>  	struct llist_head *pages;
>  	int i;
> +	bool can_flush;	/* the caller can flush TLB of all cpus after it drops =
the lock */
> +	bool flush;
>  };
> =20
>  struct clear_range_data {
> @@ -189,6 +191,12 @@ static int apply_range_set_cb(pte_t *pte, unsigned l=
ong addr, void *data)
>  			continue;
>  		if (WARN_ON_ONCE(pte_page(old) !=3D d->arena->scratch_page))
>  			return -EBUSY;
> +#ifndef flush_tlb_before_set
> +		/* The scratch page is in TLB, and it takes an IPI to flush it */
> +		if (!d->can_flush)
> +			return -EBUSY;
> +		d->flush =3D true;
> +#endif
>  		ptep_get_and_clear(&init_mm, addr, pte);
>  		flush_tlb_before_set(addr);
>  	}

[Severity: High]
This problem wasn't introduced by this patch, but on arm64 with
CONFIG_ARM64_CONTPTE=3Dn, aren't ptep_try_set() and flush_tlb_before_set()
left undefined [1]?

arch/arm64/include/asm/pgtable.h defines both helpers inside the
#ifdef CONFIG_ARM64_CONTPTE block even though they operate on init_mm and
do not depend on contiguous PTEs.  When CONFIG_ARM64_CONTPTE is disabled,
apply_range_set_cb() skips its #ifdef ptep_try_set path, while a kernel
fault on an unmapped arena address still reaches __do_kernel_fault() ->
bpf_arena_handle_page_fault() -> apply_range_set_scratch_cb(), which calls
the no-op ptep_try_set() stub in include/linux/pgtable.h, reports the
fault as handled without mapping the scratch page, and hangs the CPU in an
infinite page-fault loop.

[1] https://sashiko.dev/#/bug/linux-b7d0ea8c-0c63-439f-9b21-bfd45fea82bb

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125032938.6705=
42-1-alexei.starovoitov@gmail.com?part=3D22
