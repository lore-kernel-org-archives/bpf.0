Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889998;
	b=1n4RibDLnUAaDRS7/szNQbc28Q0Edc/rEVmq5OOOMGlm0jg4ED6XiWIKwKF6guVgvaBe
	 UvAdKhr4QgmnTRZk8bcT4Qh/mZclO3h1Dp+lQaT4qIFVxrLacdTsmtr6YXIXC7vv+gjB9
	 zbbgEXPLfsyxiG67sJdrHjAOD1Qct5Fn7Y656iOolH5mvluLj296BraDnM2nqbLcWjRRQ
	 Y43+DLR1OjQcY9QibcDd+OpgLzzljXYaSko7045CFSt4ECfUACaJBZhwPMdeRpjRwil23
	 H/asBDMiZ/KLHe0uOjjbu9FtJJN5hsEWSQ6SNNmUbaSr9UI6UjKSqkng/t1GvEWDwLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889998;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=sVQyqzffyPn/JePjwjFuckgqFqjcEu2veYv/4AtLt0w=;
	b=GTpIMqhiu839Jyd+K9+aKs5mnuRbblkYNvKzX4fNhdusKy8LSvcHnaUcm4v4svYBpWDi
	 K/TdSpWu3HL9OlvdFSNu9a/gapgyEeOCvnELFw7fIml/eiMmLt+VsnRHjqpFYFPFV3gOe
	 WxrTbsVD1EHU+BBEb+6L/+krrLZwnrKP+wJ5A6A7sSFqSTV1BO+eedAKQvqwdgmtOmhOW
	 ChntXLbtF+ZF1r2sb9X0ufdEDmp5xuUze9+Tgn1n9NDp5reMO7eV+uoaIQT5RgcNjZTht
	 rvez/Ft0pQ2Bi6CmX74VO7iol0cqLDamaaUuFmwtg0myGFPDwOqsgpcxJW9kfZb8gpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GI1pmYnj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F557606A31B;
	Thu,  5 Nov 2026 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GI1pmYnj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD6D1F000C1;
	Thu,  5 Nov 2026 14:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793889997;
	bh=sVQyqzffyPn/JePjwjFuckgqFqjcEu2veYv/4AtLt0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GI1pmYnjC8MmiJ8PDAJYDITXxyfWY5LRI4X58LyejJtpPRM1uX5REyLF5Cy7PFilB
	 orKyo+jKxW+L9WynsldKR/7T6Uat3azcd9Vhml9CyHQ3tTNaJQsPRwLq2fPHv0FFK6
	 7g5OPBzuOVGHRp19qOM8mlYLTX1R183sV8UrRSaJ/ZhWpdRTt03gjnkfdAvN2QAYS5
	 AscVW6QtIP2I0Ttjb52g5R1J6qnOXZIaeN1WJZ87jv9VRcSllvWkNaNpKaJUgf9x5F
	 k5rgymGZW7IzVPmOIDc86T1FltiDnuQmn1BVVrsJAS4I6ziDWfoVeKrr1D/FuveNbB
	 eybP58MbQstkg==
Date: Thu, 5 Nov 2026 14:46:29 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 5/5] mm/khugepaged: drop/reacquire mmap read lock if
 skipped enough VMAs
Message-ID: <auyMmGmrW-6WhF4p@gremlin>
References: <20261103-khugepaged-latency-fix-v1-0-a07ab16ac860@kernel.org>
 <20261103-khugepaged-latency-fix-v1-5-a07ab16ac860@kernel.org>
 <c05cb7a5-35b7-4364-9b7a-a87e54bf0ecf@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c05cb7a5-35b7-4364-9b7a-a87e54bf0ecf@kernel.org>

On Thu, Nov 05, 2026 at 11:28:47AM +0100, David Hildenbrand (Arm) wrote:
> On 11/3/26 09:27, Lorenzo Stoakes (ARM) wrote:
> >  mm/khugepaged.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 216c4b8d28c4..b9c72ee8b421 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -66,6 +66,12 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
> >
> >  static struct kmem_cache *mm_slot_cache __ro_after_init;
> >
> > +/*
> > + * The number of VMAs with nothing to scan to walk before dropping and
> > + * reacquiring the mmap_lock to relieve lock contention.
> > + */
> > +#define KHUGEPAGED_MAX_SKIP_BATCH 1024
>
> I don't quite enjoy this magic number.

Yeah, it's trying to find the least impactful way of saying 'we spent a lot of
time in this loop' more or less.

It was empirically figured out to be a good choice (and is very conservative,
obviously).

An alternative here would be to literally track how much time has been spent in
the loop and if exceeded drop/reacquire lock? That felt icky though.

Another option could be to check to see if cc->progress is, say, 1/4 of
khugepage_pages_to_scan, and then drop/reacquire them?

Since actual collapse drops the lock + exits the loop anyway that should work
OK.

>
> Besides it saying nothing about "VMAS", so the name it self is pretty unclear.

Ack.

>
> I was wondering whether we can give the "cc->progress += 1" a different weight.
> Skipping VMAs seems to be more expensive than we thought.

That could get tricky, the ineligible VMA rejections are all relatively quick
and in any case we don't even check the budget until we reach an eligible one.

The eligible ones being rejected potentially take longer but it could get
complicated.

>
>
> (Maybe we should also just say "skip after X" VMAs in general, whether we
> skipped them or not?)

Hmm yeah true, you might actually find an eligible VMA (spans a PMD) but then
for one of a bunch of different reasons skip it and only cc->progress++, even
though you maybe spent quite some time doing it.

Could keep it simple, something like:

	#define MAX_VMA_SCAN_BATCH	<whatever :)>

	unsigned long nr_vmas_batch = 0;

	...

	for_each_vma(vmi, vma) {
		unsigned long hstart, hend;

		if (nr_vmas_batch++ >= khugepaged_pages_to_scan / 4) {
			... drop + reacquire lock ...
			nr_vmas_batch = 0;
		}

		...
	}

Maybe? Could also potentially only drop the lock if
mmap_lock_is_contended()?

--
Cheers, Lorenzo
