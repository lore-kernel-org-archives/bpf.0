Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695767;
	b=kXFUOTT+PK7dzqfzF0XKs5/Ts0KYIIJ9d+HGV7MpnVt3W/laYTiGIZLbzRPG1LUMRPs8
	 M7T7k6Vf7ZFq//74UUwC6vXzM7hVceUCXvUJB0tEC1oZVfBJoL+Z1zlXXmQHvctqH9Sy6
	 2br80UFc6Z28Fls2rqUYB1dlIBHusdobpcrGYbYUs4/PeI1263wnzkxmcORKFTVS5OiX7
	 m91nCtVKC2y6iFZr4n/Zd8RGaLKOZDhotw3BNK6PQQc/I59UmzLWx0apIks4FcnBfBv7H
	 WZL9h2vYbbupRtYHSh8UziV6BL8HCR9DNID2yN30/cb3mYLIjO+9VZE48Opb5WxG65w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695767;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kKjb1wbG/EIzIWyCjCRnYVp4ON/5x4pkyYmDZcd6O6w=;
	b=vhDykIq+G3/GsOf+H9Fmym2/aRKUXkz4GxJOHiMFLmW+05XetXvqIENl9QS/tmIt5Kfj
	 2iQIl9DJvksKDh+QMHPh4uiqR3FMI52bHojUtpabw6WkP6CkoemktZNoL7JvHH5HmdCS0
	 MwDnb+3hkONno5wvUVO2tT2CEmrWaAsP2ja0vE/OIkCh88HiMlFiijsWrph3Qpw2pAJZn
	 nzVB3q9X8vf+z0ts6pxSLPLmUUlZwzgGsTOhg8k3aYJcgH7dtqoQFxHdkrSKyjNblu2m0
	 yuL72ULaS8vZBB2bZDf185d9YYN1hLkMM/Eumiv4TTe1e3e7z8zfKzvddRjFN01BmBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GeMrxnvQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8879F606A329
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 08:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GeMrxnvQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50731F000C1;
	Tue,  3 Nov 2026 08:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793695767;
	bh=kKjb1wbG/EIzIWyCjCRnYVp4ON/5x4pkyYmDZcd6O6w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GeMrxnvQGkybuXNxCBv0Hnl/0BBEzMYf4btC4ksy6vF/o6TGUw0bgsUR6h/CfdtAr
	 VrbpEPrR7Od3oFy0p8FYVdtu9l0DO49MISFMYk1hlI2WX6rphaqpeFkN5Aua89ea77
	 btAr3+HQt+iKHhcNtPe+YwsPcMyjcpAImxnelWhgoVCuQMMxWr7E+av/4ZPKNhc9JP
	 HOz/M4eFp5nKh3Uk32jqhecBuQe8aF8s0U0Z5GaGp/0FKm6ckvcmVs3Pf7qsbRLD5m
	 Txw75WkYgAWGvY5L+dluQiHWeVQCg1prg2hhmGVAqALTp83hNBqot9gfk0EXCizSkb
	 Bl3/rS5xkpOUg==
Message-ID: <sashiko-outbox-194883@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] mm/khugepaged: drop/reacquire mmap read lock if
 skipped enough VMAs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "Zi Yan" <ziy@nvidia.com>, "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Liam
 R. Howlett" <liam@infradead.org>, "Nico Pache" <nico.pache@linux.dev>, "Ryan
 Roberts" <ryan.roberts@arm.com>, "Dev Jain" <dev.jain@arm.com>, "Barry Song" <baohua@kernel.org>, "Lance
 Yang" <lance.yang@linux.dev>, "Usama Arif" <usama.arif@linux.dev>, "Kiryl
 Shutsemau" <kas@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>, "Will
 Deacon" <will@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Waiman Long" <longman@redhat.com>, "Suren
 Baghdasaryan" <surenb@google.com>, "Vlastimil Babka" <vbabka@kernel.org>, "Shakeel
 Butt" <shakeel.butt@linux.dev>, "Yonghong Song" <yonghong.song@linux.dev>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song
 Liu" <song@kernel.org>, "Jiri Olsa" <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>
Cc: linux-mm@kvack.org, bpf@vger.kernel.org
In-Reply-To: <20261103-khugepaged-latency-fix-v1-5-a07ab16ac860@kernel.org>
References: <20261103-khugepaged-latency-fix-v1-0-a07ab16ac860@kernel.org>
 <20261103-khugepaged-latency-fix-v1-5-a07ab16ac860@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 08:49:25 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mm/khugepaged: vm_end ALIGN() overflow rewinds vmi in collapse_sca=
n_mm_slot()
- [Medium] mm/khugepaged: sub-PMD VMAs bypass skip batching in collapse_sca=
n_mm_slot()
--

commit 0a737288374fc8ce4ac1b20ac082b7190ad6db37
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>

mm/khugepaged: drop/reacquire mmap read lock if skipped enough VMAs

This commit drops and reacquires the mmap read lock using
mmap_read_lock_nosteal() in collapse_scan_mm_slot() after skipping
KHUGEPAGED_MAX_SKIP_BATCH ineligible VMAs to reduce mmap_lock hold times and
relieve writer contention.

> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 216c4b8d28c40..b9c72ee8b4211 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c

[ ... ]

> @@ -2910,6 +2916,7 @@ static void collapse_scan_mm_slot(unsigned int prog=
ress_max,
>  	struct mm_struct *mm;
>  	struct vm_area_struct *vma;
>  	unsigned int progress_prev =3D cc->progress;
> +	unsigned int skipped =3D 0;
> =20
>  	lockdep_assert_held(&khugepaged_mm_lock);
>  	*result =3D SCAN_FAIL;
> @@ -2951,6 +2958,14 @@ static void collapse_scan_mm_slot(unsigned int pro=
gress_max,
>  			/* Unable to collapse, skip to the next candidate. */
>  			mm_slot->address =3D ALIGN(vma->vm_end, HPAGE_PMD_SIZE);
>  			cc->progress++;
> +			if (++skipped >=3D KHUGEPAGED_MAX_SKIP_BATCH) {
> +				/* Skipped a lot of VMAs, so wait for writers. */
> +				mmap_read_unlock(mm);
> +				cond_resched();
> +				mmap_read_lock_nosteal(mm);
> +				vma_iter_set(&vmi, mm_slot->address);
> +				skipped =3D 0;
> +			}

[Severity: High]
Can mm_slot->address overflow to 0 here and cause vma_iter_set() to rewind
vmi back to the start of the address space?

On architectures where TASK_SIZE extends into the final PMD range of the
unsigned long address space, such as 64-bit s390 in
arch/s390/include/asm/processor.h:

#define TASK_SIZE		(TASK_SIZE_MAX)
#define TASK_UNMAPPED_BASE	(_REGION2_SIZE >> 1)
#define TASK_SIZE_MAX		(-PAGE_SIZE)

a user process can map VMAs with vma->vm_end > (ULONG_MAX & HPAGE_PMD_MASK).
When collapse_scan_mm_slot() skips such a VMA,
ALIGN(vma->vm_end, HPAGE_PMD_SIZE) wraps around to 0.

If ++skipped >=3D KHUGEPAGED_MAX_SKIP_BATCH triggers on that VMA,
vma_iter_set(&vmi, mm_slot->address) resets the VMA iterator to address 0.
Because the !collapse_possible_orders() path does not check
cc->progress >=3D progress_max, if the mm contains no eligible PMD-spanning
VMAs (for example, 1024 ineligible VMAs ending in the top PMD range),
wouldn't for_each_vma(vmi, vma) restart from address 0 and loop
indefinitely inside collapse_scan_mm_slot() until the process exits or THP
is disabled?

>  			continue;
>  		}
>  		hstart =3D ALIGN(vma->vm_start, HPAGE_PMD_SIZE);

[Severity: Medium]
Should the skip batching and progress accounting also cover VMAs that pass
collapse_possible_orders() under sub-PMD mTHP but do not span a full PMD?

In mm/khugepaged.c, collapse_possible_orders() checks all enabled anonymous
mTHP orders when called with TVA_KHUGEPAGED:

static unsigned long collapse_possible_orders(struct vm_area_struct *vma,
		vm_flags_t vm_flags, enum tva_type tva_flags)
{
	unsigned long orders;

	/* If khugepaged is scanning an anonymous vma, allow mTHP collapse */
	if ((tva_flags =3D=3D TVA_KHUGEPAGED) && vma_is_anonymous(vma))
		orders =3D THP_ORDERS_ALL_ANON;
	else
		orders =3D BIT(HPAGE_PMD_ORDER);

	return thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
}

When a sub-PMD anonymous mTHP order is enabled, a faulted anonymous VMA
smaller than HPAGE_PMD_SIZE passes collapse_possible_orders(), bypassing
the !collapse_possible_orders() block in collapse_scan_mm_slot() and
falling through to:

		hstart =3D ALIGN(vma->vm_start, HPAGE_PMD_SIZE);
		hend =3D ALIGN_DOWN(vma->vm_end, HPAGE_PMD_SIZE);
		if (mm_slot->address > hend) {
			cc->progress++;
			continue;
		}
		if (mm_slot->address < hstart)
			mm_slot->address =3D hstart;
		VM_WARN_ON_ONCE(mm_slot->address & ~HPAGE_PMD_MASK);

		while (mm_slot->address < hend) {

For these sub-PMD VMAs, hstart >=3D hend:
- When mm_slot->address > hend, it increments cc->progress and continues
  without incrementing skipped or dropping mmap_lock.
- When mm_slot->address <=3D hend (for instance, when a sub-PMD VMA starts =
on
  a PMD boundary so hstart =3D=3D hend =3D=3D mm_slot->address, or on the f=
irst
  unaligned sub-PMD VMA in a PMD range where mm_slot->address =3D=3D hend <
  hstart), both mm_slot->address > hend and mm_slot->address < hend are
  false, so neither skipped nor cc->progress is incremented.

As a result, if an mm has a large number of small faulted anonymous VMAs
while sub-PMD mTHP is enabled, wouldn't collapse_scan_mm_slot() still walk
all of them without ever reaching KHUGEPAGED_MAX_SKIP_BATCH and dropping
mmap_lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-khugepaged=
-latency-fix-v1-0-a07ab16ac860@kernel.org?part=3D5
