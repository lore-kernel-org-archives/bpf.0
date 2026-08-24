Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9144374A0A
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560743; cv=none; b=Gnj539u/5o2b34d8FKLVmtUMpVm0Y/zgLBaDyHN/2b7ix6DXSrUafDQqPrmm3Zc+xwlYgjSuGWVnrIEJJT0E30uVUNbC9dsP1DIipivfUW/4utT6OKZm8z6DF941T6ZPv1SRAwAFbaUHS3RycJnxSmGSUn+SpY/YDiQphE6U/H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560743; c=relaxed/simple;
	bh=dX7g03rTv07MBAuNCZzxzTo2OF9BjWJcr96jvC4y72c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XRMOZzlOx7D19KMgvMTicQThtyQUnhu3gTlpV72RBiJwfX2X9ccsLB+W0YGPdyyTD46qCCCtHoA2jWq1KCOPA4YgSl9eoICKIiRsCGEUxE1BHdODvcaqOjPYvIxxwIUUEAXUPfrfqpmbqjDfuRXj33r+kNqJiFr2VMDl0geTp/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIfUcQnh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIfUcQnh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3911F000E9;
	Mon, 24 Aug 2026 08:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787560741;
	bh=Oz8OiOmYM2gimO/XWDqWZ+oMNOUZ47o/PF/ijxjlHxc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HIfUcQnhUTRY7fpthG1JHH1Ad2sR2ooV01eA7xUWkI1vI1uBktGKzRYpS1kNihzfg
	 EZQuyjsdPxikS5M0jaiSYNnPhitL2TP5qsRvi+fgTzdvVda1r0vra7FAxA0LMIZauI
	 6QS5awr0ROQalL+L70nNdD579VWRsU8lCuLxAI/GiJ21HiP1jpfIcDBIJFeh/91vPF
	 u4MBfUA5JEbjBL8iJb6bn/RgqL2SFZ7GKGp7xz670PxKXi/uLKPZT7FigrfeCmOGBo
	 4kgV0RTlZXXlBQFfVbmnmWp+UULm5pwzUArsI6x7mqOsl+AuvgU3yt+YcYp5lKa2aX
	 TBqOTgHLgiPbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] selftests/bpf: Test large allocations for both
 sleepable/nonsleepable arena users
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260824082530.47553-4-emil@etsalapatis.com>
References: <20260824082530.47553-1-emil@etsalapatis.com>
 <20260824082530.47553-4-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 08:39:00 +0000
Message-Id: <20260824083901.4A3911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The validation loop's error path incorrectly returns the loop in=
dex `i`, meaning a memory validation failure on the first page (`i =3D=3D 0=
`) will falsely report as a successful test.

Pre-existing issues:
- [High] Hard lockup (watchdog timeout) in `arena_alloc_pages_non_sleepable=
` due to a massive page allocation loop executing with local interrupts dis=
abled.
--

--- Patch [3]: [PATCH 3/3] selftests/bpf: Test large allocations for both s=
leepable/nonsleepable arena users ---
commit 97b45503d1d3323d8eb083b751d71f1bec8430fe
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: Test large allocations for both sleepable/nonsleepable arena=
 users

We now use different code paths in the internal allocator when
allocating arena memory, depending on whether the caller is sleepable
or not. These paths mostly differ functionally for large allocations,
so add extra testing for that case.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/t=
ools/testing/selftests/bpf/progs/verifier_arena_large.c
> --- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c

[ ... ]

> @@ -300,7 +301,31 @@ int big_alloc3(void *ctx)
>  	 */
>  	pages =3D bpf_arena_alloc_pages(&arena, NULL, 2051, NUMA_NO_NODE, 0);

[Severity: High]
This is a pre-existing issue, but does this allocation of 2051 pages trigger
a hard lockup in the underlying allocator?

Looking at arena_alloc_pages_non_sleepable() in kernel/bpf/arena.c, the code
disables interrupts and runs a batch allocation loop:

kernel/bpf/arena.c:arena_alloc_pages_non_sleepable() {
    ...
    while (remaining) {
        long this_batch =3D min(remaining, alloc_pages);
        memset(pages, 0, this_batch * sizeof(struct page *));
        ret =3D bpf_map_alloc_pages(&arena->map, node_id, this_batch, pages=
);
        ...
        ret =3D apply_to_page_range(&init_mm, ...);
    }
    ...
}

Since this path is executed with a raw spinlock held and local interrupts
disabled, could a large page_cnt like 2051 cause a watchdog timeout?

>  	if (!pages)
> -		return 0;
> +		return 1;
> +
> +	bpf_for(i, 0, 2051)
> +			pages[i * PAGE_SIZE] =3D 123;
> +	bpf_for(i, 0, 2051)
> +			if (pages[i * PAGE_SIZE] !=3D 123)
> +				return i;

[Severity: Medium]
Does this error path mask validation failures on the first page?

Since the program expects 0 for success (__success __retval(0)), if the=20
validation fails on the first page (i =3D=3D 0), the loop returns 0. This
perfectly aliases the expected success code and completely masks the failur=
e.

Additionally, failing on the second page (i =3D=3D 1) returns 1, which alia=
ses
the allocation failure code above.=20

Could this return a distinct error code instead of the loop index?

> +
> +	bpf_arena_free_pages(&arena, pages, 2051);
> +#endif
> +	return 0;
> +}
> +
> +/* SYSCALL programs are always sleepable. */
> +SEC("syscall")
> +__success __retval(0)
> +int big_alloc4(void *ctx)
> +{
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> +	char __arena *pages;
> +	u64 i;
> +
> +	pages =3D bpf_arena_alloc_pages(&arena, NULL, 2051, NUMA_NO_NODE, 0);
> +	if (!pages)
> +		return 1;
> =20
>  	bpf_for(i, 0, 2051)
>  			pages[i * PAGE_SIZE] =3D 123;
> +	bpf_for(i, 0, 2051)
> +			if (pages[i * PAGE_SIZE] !=3D 123)
> +				return i;

[Severity: Medium]
Similarly, does returning the loop index here falsely report success if the
first page fails validation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824082530.4755=
3-1-emil@etsalapatis.com?part=3D3
