Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3EA3C276F
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 11:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778759839; cv=none; b=SA3IwogcLJFpAh7NB8O1DZGOKBkKkMphsYDId97/aeZdtD4otB0Htnh7MW4D1ydtcRUBL7AxsBoMzHyGDuS7/0gRzES1NAURdLqDg/WEbHasox5go3KJUxqW+WOBSXQP0/bHY3SlGhJmc/hzlgceozH14QpBaNSRZitajZejSwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778759839; c=relaxed/simple;
	bh=4Hygi6PFXGZJqMyDaZlHZd7iPy03/IUaFRqHJZpy8hE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NEYZwMDE/4PoqIZHvJUAOd1RUtvCYlpTCRtZUgosstQe2lXZ5ce1MMvHXRH5K0U170EFeWOBi6ZJYx7nBeIlN/9thRDFkDWR1x//E2DVuj/pVbeFZZfjEw32f1LZZHcLrp19UzyVrHdssssp1wZqpG9mPJ/lwQub2zn5DjmdMDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foTyOfBT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foTyOfBT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A662C2BCB3;
	Thu, 14 May 2026 11:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778759839;
	bh=4Hygi6PFXGZJqMyDaZlHZd7iPy03/IUaFRqHJZpy8hE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=foTyOfBTsBaku36TFWtW5X3l4Es5n78/l2IGiU2S8w0kpwWRqy0cfcH8IdI1YoyuV
	 Aoz8/gMSDjiFEkTRvwP7o5uiEzOnCInELtjosLs+fjDFpPnK8ifr8auN1P+vNeWukh
	 k2GHZzTGSANtS9XYzTVuSh62s7snYHqBzjRi8wtXsnOfWVizy+23btoPW/pdJ28uRZ
	 qbkiziRpv9SbgumjfUMDg+fQtVGCyEwUi9oIC6227ernZ++/xA+zCOZWllUWAkzAvg
	 WG0FTgrxhr2bfM87tUU0ouJeSedOpwHxOknRCHzfzomWNHWH/4svOiN7zO6QFkmIId
	 OEpra/ttgnCpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] selftests/bpf: Add test validating arena VMA
 tracking across fork
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Hodges" <git@danielhodges.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260513191322.21319-2-git@danielhodges.dev>
References: <20260513191322.21319-2-git@danielhodges.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 11:57:18 +0000
Message-Id: <20260514115719.3A662C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The test bypasses the intended VMA tracking logic because arena mm=
aps are created with VM_DONTCOPY, preventing the child from inheriting the =
VMA.
- [High] Double `munmap()` of libbpf-managed memory leads to potential sile=
nt memory corruption in concurrent test environments.
- [Medium] Flaky reliance on `usleep()` for RCU grace period synchronizatio=
n.
--

commit ee7a95885f283c6cd8d8ee4195aa3d4bcee4e6a6
Author: Daniel Hodges <git@danielhodges.dev>

selftests/bpf: Add test validating arena VMA tracking across fork
   =20
This commit adds a BPF selftest to validate that freeing arena pages does
not trigger a use-after-free when a forked child holds an inherited arena m=
map.

> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_fork_free.c b/t=
ools/testing/selftests/bpf/prog_tests/arena_fork_free.c
> new file mode 100644
> index 0000000000000..6a6e1d4197cf9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_fork_free.c

[ ... ]

> +	arena_area =3D bpf_map__initial_value(skel->maps.arena, &arena_sz);
> +	if (!ASSERT_OK_PTR(arena_area, "arena_area"))
> +		goto out;
> +	arena_sz =3D bpf_map__max_entries(skel->maps.arena) * PAGE_SIZE;
> +
> +	if (!ASSERT_OK(pipe(pipe_fds), "pipe"))
> +		goto out;
> +
> +	/* Step 2: fork =E2=80=94 child inherits arena mmap */
> +	child =3D fork();

Does the child actually inherit the arena mmap here?=20

The kernel's arena_map_mmap() sets VM_DONTCOPY on the arena VMA, meaning the
child process will not inherit it during fork() and arena_vm_open() will not
be called.

This causes the parent's munmap() to leave the tracking list empty, so when
bpf_arena_free_pages() triggers zap_pages(), it iterates over an empty list.
The test seems to pass without exercising the intended VMA tracking logic.

Could the test clear VM_DONTCOPY via madvise(..., MADV_DOFORK) before
calling fork()?

[ ... ]

> +	/* Parent continues */
> +	close(pipe_fds[0]);
> +	pipe_fds[0] =3D -1;
> +
> +	/* Step 3: munmap the arena in the parent */
> +	ret =3D munmap(arena_area, arena_sz);

Can this munmap() lead to a double munmap and silent memory corruption?

Because arena_area was obtained from bpf_map__initial_value(), it points to
libbpf's internal map->mmaped pointer. When the test completes and calls
arena_fork_free__destroy(skel), libbpf will unconditionally call munmap()
on this pointer again.

If another thread or parallel test mmaps memory in that address window
between this munmap() and the skeleton destruction, the second munmap()
will silently unmap the unrelated memory.

Would it be better for the test to mmap() the arena independently using its
FD instead of unmapping libbpf's internal pointer?

[ ... ]

> +	/*
> +	 * Step 4: free arena pages via BPF.
> +	 *
> +	 * Wait for the RCU grace period so the parent's VMA slab memory
> +	 * is actually freed (VMA freeing is deferred via call_rcu).
> +	 * This ensures KASAN can detect any stale VMA dereference in
> +	 * zap_pages().
> +	 */
> +	usleep(200000);

Is relying on a fixed timeout reliable for ensuring an RCU grace period
has elapsed?

Under heavy load in CI environments, the grace period might be delayed,
causing KASAN to miss the intended use-after-free because the VMA slab
memory hasn't actually been freed yet.

Could the test use kern_sync_rcu() from the BPF selftests framework to
deterministically wait for the grace period?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513191322.2131=
9-1-git@danielhodges.dev?part=3D2
