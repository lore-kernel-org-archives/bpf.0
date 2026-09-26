Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7524F547063
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 23:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790466412; cv=none; b=aG5SB+Reo22AV+5ANmKNXVHmifeRe3Sj/Pf09Bzo4RQV+EY/EuyaXHbaxVaaBE7Q50whGe4Wln3qNyQYjjRmXVWnDPSr/66+nBDsdI+u6pDp8lynFLwXzeVtMp1TnMBlQU8/Y9SOTxSzRFK4u8YJrw5cEaDxm9wkWdth8HmDCBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790466412; c=relaxed/simple;
	bh=Bj0wPan8wM8/jiMg+IOR36eD3u34oszSO2Ggg1hU2ic=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bGtCN8ua5Moi27a3iwGx6PqVl2Pl72VoTIux+4QEAcMckCvdM4eacpf76WpycrukpkjO8oWhKm3HCQtxP6b4Ic2nzkWrEw/2eq+chQ/VFAbvNzgd92/UIxyRp52whMndYXxB0u5XvigEqwzfrB8oharjT2Mma44m1noHq7FtojE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNbIfA3d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNbIfA3d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E609C1F000FF;
	Sat, 26 Sep 2026 23:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790466411;
	bh=U5nHmykuuqPZJ0T/JH9240XccEbBY75b0RXP6IEi9qY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nNbIfA3dMrngrKIkAj4J4j7CsEMZv3bK4VojXAEP0lMrjeRWlxAC63OpTgaDVyzoQ
	 gZ+elamWRYk1LlGioDNR1G4+KR9rS5tiuN4e0ECG8QEUPsUe94plXKSeGRvWCV5wRs
	 Kby2Eb+yqwRQvF2lkfLUWoNJpv8+AAO0qoEmAvEPiyyqNmVskiAOSZqb7m34Qjz9iJ
	 PHJ/ZnAm0yYqjtzdy3+ipKvQanif+yXi5jmqPjfF8TA01DOG4kXAqMvE2aCMaiqR8y
	 u4fU898F40Ggami7kDd2nk/ggBuhojYslki2zFzTSFSiF7/u9YKxqvg1RZhSQF4qld
	 /PGCRzd2QsfYg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 15/16] selftests/bpf: Test typed arena
 page allocation and release
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926233503.3114147-16-memxor@gmail.com>
References: <20260926233503.3114147-1-memxor@gmail.com>
 <20260926233503.3114147-16-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 23:46:50 +0000
Message-Id: <20260926234650.E609C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] bpf: physical pages freed before TLB flush in typed_arena_allo=
c_pages()
- [High] bpf: bpf_typed_arena_free_pages() frees adjacent chunks due to una=
ligned addr
--

commit 45f79d175e13ad1f2540fd16c264cce33991c839
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

selftests/bpf: Test typed arena page allocation and release

Allocate a page of typed arena objects, write one, reach it again through
an opaque copy of its address and its neighbour by arithmetic on that copy,
and check that the kfunc receives the registered typed arena in place of
the type ID. Take the chunk a value names and see the same chunk refused
twice, once for the chunk and once for a page inside it. Ask for one page
of an object that spans several and see the request rounded up to the
object's chunk, with the granted count written back. Release a chunk and
see it keep its objects and stay taken within the same invocation, since
the release is deferred behind a grace period.

Reject a use of the returned pointer without a NULL check, a struct without
special fields, and a map that is not the program's arena. Declare the two
kfuncs in bpf_experimental.h.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_typed_arena.c b/t=
ools/testing/selftests/bpf/progs/verifier_typed_arena.c
> index 808a65611d4ef..8ec75fd1f97bf 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_typed_arena.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_typed_arena.c
> @@ -1157,6 +1157,148 @@ int ptr_field_sanitize_on_one_path(void *ctx)
>  	return 0;
>  }
> =20
> +#define TYPE_ID(T) bpf_core_type_id_local(T)
> +
> +SEC("syscall")
> +__description("allocated pages hold real objects, reachable through any =
value that lands in them")
> +__success __retval(0)
> +__xlated("r2 =3D 0x{{[0-9a-f]+[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0=
-9a-f][0-9a-f][0-9a-f]}}")
> +__xlated("call kernel-function")
> +int pages_alloc(void *ctx)
> +{
> +	struct typed_obj *obj, *again, *next;
> +	void *opaque;
> +	__u32 cnt =3D 1;
> +
> +	obj =3D bpf_typed_arena_alloc_pages(&arena, TYPE_ID(struct typed_obj), =
NULL, &cnt,
> +					  NUMA_NO_NODE);

[Severity: Critical]
Is it possible for physical pages to be freed before the TLB flush occurs?

Looking at typed_arena_alloc_pages() in kernel/bpf/arena.c, when an
allocation fails midway:

kernel/bpf/arena.c:typed_arena_alloc_pages() {
    ...
			if (data.i)
				apply_to_existing_page_range(&init_mm, data.start,
							     (unsigned long)data.i << PAGE_SHIFT,
							     apply_range_clear_typed_cb, &cdata);
			free_pages_nolock(head, order);
			goto back_out;
    ...
}

If a concurrent page fault occurs, can this result in the physical pages be=
ing
returned to the allocator before the TLB flush in the back_out path?

> +	if (!obj)
> +		return 1;

[ ... ]

> +SEC("syscall")
> +__description("a released chunk keeps its objects and stays taken until =
the grace period has passed")
> +__success __retval(0)
> +int pages_free(void *ctx)
> +{
> +	struct typed_obj *obj;
> +	__u32 cnt =3D 1;
> +
> +	obj =3D bpf_typed_arena_alloc_pages(&arena, TYPE_ID(struct typed_obj), =
NULL, &cnt,
> +					  NUMA_NO_NODE);
> +	if (!obj)
> +		return 1;
> +	obj->value =3D 7;
> +	bpf_typed_arena_free_pages(&arena, TYPE_ID(struct typed_obj), obj, 1);

[Severity: High]
Does this code handle unaligned offset values correctly?=20

Looking at typed_arena_free_pages() in kernel/bpf/arena.c, when an unaligned
addr is passed, the calculation for the last chunk might spill over into the
next chunk:

kernel/bpf/arena.c:typed_arena_free_pages() {
	off =3D addr - base;
	if (page_cnt > (size - off) >> PAGE_SHIFT)
		return;
	first =3D off >> ta->chunk_shift;
	last =3D (off + ((unsigned long)page_cnt << PAGE_SHIFT) - 1) >> ta->chunk_=
shift;
    ...
}

Can this lead to unintentional freeing of adjacent chunks?

> +	if (obj->value !=3D 7)
> +		return 2;
> +	cnt =3D 1;
> +	if (bpf_typed_arena_alloc_pages(&arena, TYPE_ID(struct typed_obj), obj,=
 &cnt, NUMA_NO_NODE))
> +		return 3;
> +	return 0;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926233503.3114=
147-1-memxor@gmail.com?part=3D15
