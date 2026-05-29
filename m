Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AE73451B5
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780094349; cv=none; b=L5SeTUrFvgMR/4vcbcJWjEdjq6Rqzcq3sBu79ghH2vepI8tmYcqgzSh4ZvtZRW9ffy3UIB9zI5dY2vwKEudCrM3mXj6zXfpJO3ueiyooSeLH8dFerp5K6/Le/LjSwugzlUipFMbVFib4R95MVnhsBhqUgX/Dn5qOYraXCwIMQlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780094349; c=relaxed/simple;
	bh=pZc4fqzAPoKP7Kb3oOEY9mjTGEdT2ApiEX/Ma6DobTg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D4wDHw5kudoWmceYvpkrSyjyLUNb2JUUPlUxG1CEu6lMO9URzeMWqyDOSDxmmdYXSN+3Dz6AR2zAi9Oga/O7uOSLEw5pblnIIyK+Te+eWFt72rku52eSt5ElE4qXPagjGWG44rUlhRySpc46Cu+jrrWggchhjHQjBsnDaZkljOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixEp7HVc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixEp7HVc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25251F00893;
	Fri, 29 May 2026 22:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780094347;
	bh=yrpZkE8Zvz3+4yxGjDD0u8hlJeQKnb++pAkvnGlIX4o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ixEp7HVcfuS4RiE+ApgfE/6Kp49QmD7JIIqTtxv+eN6XKcFejbNy06eRzzWL5WjeK
	 7nBIAzzWS8s6PdetZuvfCWSfHy4TIMycwf35o9+5IA1EwVluRVO3avlhME2M9+5LQD
	 AfH6UR7N9f/7OAb6I1sKcUoueRISSGbdmaOJR9kRK++1+Mht8a6LoV+Z8H7ASOTIHw
	 RabwGCLDs/IZonkIMD/IaSPAOMCgw1eFCY9YDJ+bELIZSWmkFsvMsK2OCgvIOZ9ipR
	 23CmBJ2229IvWCypCuXSYe75ZHpJwrioE043SU9m09RKLxn1ghTcdlv66n8i5if+l6
	 v+Tps8XA446vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Add tests for arena
 slub-backed allocator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260529202438.16408-5-alexei.starovoitov@gmail.com>
References: <20260529202438.16408-5-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 22:39:07 +0000
Message-Id: <20260529223907.B25251F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `arena_slab_freeptr_stale_pcs` selftest will reliably fail o=
n architectures with a page size larger than 4K (e.g., ARM64 with 64K pages=
) due to hardcoded assumptions about SLUB slab page capacities.
--

commit 307042b1f4f8cca55cad67f2c12869bf67a9f7c2
Author: Alexei Starovoitov <ast@kernel.org>

selftests/bpf: Add tests for arena slub-backed allocator

This commit adds end-to-end selftests covering the SLAB_BPF_ARENA path.
It includes smoke tests for basic alloc/free kfuncs and exercises corrupted
in-object freepointers to validate get_freepointer() clamping.

> diff --git a/tools/testing/selftests/bpf/progs/arena_slab_freeptr_stale_p=
cs.c b/tools/testing/selftests/bpf/progs/arena_slab_freeptr_stale_pcs.c
> new file mode 100644
> index 0000000000000..4d23d75419d61
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/arena_slab_freeptr_stale_pcs.c

[ ... ]

> +	victim =3D objs[TARGET_IDX];
> +
> +	/*
> +	 * The 4096-byte bucket has one object per slab and a 4-object sheaf.
> +	 * Free @victim while the sheaf is full, then turn its encoded NULL
> +	 * freepointer into any non-NULL decoded value. The arena clamp keeps
> +	 * non-NULL decoded values in the same slab and object-aligned, so this
> +	 * becomes a freelist self-cycle back to @victim.
> +	 */

[Severity: Medium]
Is this assumption valid on architectures with page sizes larger than 4K?

On a system with 64KB pages, a 4096-byte bucket would hold multiple objects
per slab page instead of just one.

[ ... ]

> +	/*
> +	 * The sheaf is full of duplicate victim pointers now. Free the four
> +	 * filler objects plus one extra object directly to SLUB, leaving enough
> +	 * partial slabs that the next target-slab zero-inuse transition discar=
ds
> +	 * the target page instead of keeping it on the partial list.
> +	 */
> +	for (i =3D 0; i < SHEAF_FILL; i++)
> +		bpf_arena_free(&arena, objs[i]);
> +	bpf_arena_free(&arena, objs[EXTRA_IDX]);
> +
> +	bpf_arena_free(&arena, victim);
> +
> +	p =3D bpf_arena_alloc(&arena, OBJ_SIZE);
> +	if (!p)
> +		stale_alloc_null =3D 1;

[Severity: Medium]
Will this logic successfully discard the target page on architectures like
arm64 configured with 64K pages?

Since 64KB pages can hold multiple 4096-byte objects, all these allocations
might be placed into the exact same order-0 slab page. Freeing the filler
objects would merely drop the inuse count of that single slab page rather
than creating multiple empty slab pages to fill the partial list.

When the victim object is freed, wouldn't SLUB retain the page instead of
returning it to the OS, causing the final allocation to succeed and
stale_alloc_null to remain 0, thus failing the test?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529202438.1640=
8-1-alexei.starovoitov@gmail.com?part=3D4
