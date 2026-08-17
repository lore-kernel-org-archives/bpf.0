Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DC73B0582
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 19:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994915; cv=none; b=MEbXUniSSXjB2OAf64gFf6aUWWLrE1VkEsdsk+GB6kOV9RVX10MxjS2USHrMABpZeFtWUnra1jiTOi9lvGXrnd+ydRxoDD4brGfsqbaCIVQkHKsW8oMYY0r1NkmdNlcP/4mIGhH7+Tu0ZOsrfQi3AlJZDtcxr2RTRAJTv5nOXhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994915; c=relaxed/simple;
	bh=VTa5HBySe0LPxCRU53Va6tuUEjaakrDfZdhQjN0dSDc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GnTuXnDv6DYdj+E83DdXXHio1R/3FXGQWDL/yWAoNTLpyGMYMIgBpvKM7+DRH8UxWGGZiiGrfGKepgh3IeGEXYnkrEw8g6b+YQC+yorxfFHbsSHe7NOG6Pf5TsiEPjYQe8fOADopRA0oBXxDT5CNNHO2w6yG8XjiZdAcjonZqn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuB+SlmJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuB+SlmJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B111F000E9;
	Mon, 17 Aug 2026 19:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786994913;
	bh=SH9gBiw8ZvmDxn5uGXw022ULV+AeavwEs5zCpGKJ5fY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FuB+SlmJn8IOXbhs39J7AjlN0nil+c2ta19dYi2kKG+LpYn4GfVYHmGQB4PBdoH9l
	 EmOxuCww4QdU9G2JjBHOwNREko5FQTOc/Eqjy3ODkvPMMoOjjhsVPCeH248L/jrb7I
	 P4yHja49anNzrtcMqap3DlTEhZLMEr9jrPsgeQ8ohv6xEYFY7cs6lz2CfBtyomDqVk
	 hk2bSwrqQdagTtExGYkJJyC4JNxSjz4PiVp3zVnmewWUVC+xHCGg+Y2SyK9GxYOSXw
	 3qKNmGhpuH9c+ZuyJNNDxKUXcabO4jRbtAqlWz8ouEgbrzvfPh9IqVh9WKNkNqEywS
	 PCJQ7E7sb7rJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] selftests/bpf: libarena: Disable IRQs during
 allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260817191616.11071-4-emil@etsalapatis.com>
References: <20260817191616.11071-1-emil@etsalapatis.com>
 <20260817191616.11071-4-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 19:28:32 +0000
Message-Id: <20260817192833.63B111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unhandled lock failure path in `buddy_alloc` and `buddy_alloc_from=
_new_chunk` leaks newly allocated memory chunks.
--

--- Patch [3]: [PATCH 3/6] selftests/bpf: libarena: Disable IRQs during all=
ocation ---
commit 33cf3ed979bbaa281367dbd5d393dc12a91a1af9
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: libarena: Disable IRQs during allocation

This commit updates the buddy allocator in libarena to use IRQ-saving
spinlocks to prevent ABBA deadlocks. These deadlocks were observed with
sched_ext schedulers when an IRQ interrupts an allocation and subsequently
attempts to take runqueue locks.

> diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools=
/testing/selftests/bpf/libarena/src/buddy.bpf.c
> index c674ee5cfcc1d..2490ab1396de0 100644
> --- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c

[ ... ]

> @@ -730,9 +727,10 @@ static u64 buddy_alloc_from_existing_chunks(struct b=
uddy __arena *buddy, int ord
>   */
>  static u64 buddy_alloc_from_new_chunk(struct buddy __arena *buddy, struc=
t buddy_chunk __arena *chunk, int order)
>  {
> +	unsigned long flags;
>  	u64 address;
> =20
> -	if (buddy_lock(buddy))
> +	if (buddy_lock(buddy, flags))
>  		return (u64)NULL;

[Severity: High]
This isn't a bug introduced by this patch, but does this leak the newly
allocated arena chunk if the lock acquisition fails?

When buddy_alloc() needs more memory, it allocates a chunk and passes it
here:

buddy_alloc()
  chunk =3D buddy_chunk_get(buddy);
  if (chunk)
    address =3D buddy_alloc_from_new_chunk(buddy, chunk, order);

If buddy_lock() fails in buddy_alloc_from_new_chunk() (for example, returni=
ng
an error like -ETIMEDOUT under heavy contention), it returns NULL without
linking the new chunk to buddy->first_chunk.=20

The NULL return then propagates up to buddy_alloc(), which discards the chu=
nk
pointer completely without freeing it. Since BPF MCS spinlocks can fail und=
er
heavy task load, could this predictably exhaust arena memory?

Should this error path call bpf_arena_free_pages() on the orphaned chunk
before returning?

> =20
> =20
> @@ -745,7 +743,7 @@ static u64 buddy_alloc_from_new_chunk(struct buddy __=
arena *buddy, struct buddy_
> =20
>  	address =3D buddy_chunk_alloc(buddy->first_chunk, order);
> =20
> -	buddy_unlock(buddy);
> +	buddy_unlock(buddy, flags);
> =20
>  	return (u64)address;
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817191616.1107=
1-1-emil@etsalapatis.com?part=3D3
