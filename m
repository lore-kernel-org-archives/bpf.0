Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507AB495037
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194332; cv=none; b=T6ALXfnrj2rPICKwcd2T6myaip4RgHQp1+LZ3hl6CFvI0jvl0GW+hTNnuYCC7AA3mnJmj3PfBfTyv80ZpQW5ULNMVnvH6xQdMbulH8qFeqv82kh7FtwTGQxif434FTy6ERA6gJeSwqjPsh/ubBAQDZHErENT5ZaFInlnB85kHek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194332; c=relaxed/simple;
	bh=AD2wE4PTqDm6eLDXYXOPPgV6yla7manvOGQvB/Cm6AU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rXW16TdSSCkXAeL2+Rkw5V8S7infmhaZQfGPqj06SMzHquBdReLOrNd4QhJxLR91xafoTUuR0/oV8ul9nL1zdcaTH5PRRNgNBxgBgabvE3JVfK37No6vAu68HQbX0QLkZGP0sNHburN+RWnrJ5WMOUhfrFBn6osjEFtxk95J+18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvidlqTy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvidlqTy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9D91F00898;
	Wed, 23 Sep 2026 20:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790194323;
	bh=SxB9q5BLBX+XtQj8QPHRSELvGxZ2l4qtkDba/Ib0aCw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZvidlqTyQaT1//V/i9RpUCOwlsJo98mYnTkkhY9OyHzHfhAQ5vErUJajlbCYZX/t7
	 iLzC8ap/0WW9A8waz/Jk1w5BLsEng2jEOCAeezWZ8nRKz4j5eKy6z4czJbxKqcMKLe
	 bQl+4pvPEihJgAQMWU8A/Xkq6R2BzQAFNbL72zlcj2LFj0kGoRcjksBMABL3VIWW7z
	 MehDGmO8jLK4trh25BMGCiGD0dsEjD4QuVVsM4dfjLj8riwzWJCK03kKiWtxsZk3x/
	 68wUPjoipkAqHEpxEEdOxrCu9BULUbxoWg3Y9n0okWvNZmuoxwoW4kkTFoy2wopjPL
	 A9FFInCt+iD+w==
Content-Type: multipart/mixed; boundary="===============8260412153300754749=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0ecbcd8adf69fd384fc37b146e32c70506171323fbac46359bb52df77d5e0a5e@mail.kernel.org>
In-Reply-To: <20260923191125.5311-7-emil@etsalapatis.com>
References: <20260923191125.5311-7-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v3 6/6] selftests/bpf: Add arena allocation race tests
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 20:12:01 +0000 (UTC)

--===============8260412153300754749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_race.c b/tools/testing/selftests/bpf/prog_tests/arena_race.c
> new file mode 100644
> index 0000000000000..c2da611421f3a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_race.c

[ ... ]

> @@ -0,0 +1,270 @@

[ ... ]

> +static struct arena_race *setup_arena(__u64 **addr, bool trace_flush)
> +{
> +	struct arena_race *skel;
> +	size_t arena_sz;
> +	char *base;
> +	int err;
> +
> +	skel = arena_race__open();
> +	if (!ASSERT_OK_PTR(skel, "open"))
> +		return NULL;
> +	err = bpf_program__set_autoload(skel->progs.trace_flush, trace_flush);
> +	if (!ASSERT_OK(err, "trace_flush_autoload"))
> +		goto err_out;
> +
> +	err = arena_race__load(skel);
> +	if (!ASSERT_OK(err, "load"))
> +		goto err_out;
> +	err = arena_race__attach(skel);
> +	if (!ASSERT_OK(err, "attach"))
> +		goto err_out;
> +
> +	if (run_prog(skel->progs.alloc_old, "alloc_old"))
> +		goto err_out;
> +	if (skel->bss->skip) {
> +		test__skip();
> +		goto err_out;
> +	}

A subsystem pattern flags this as potentially concerning: when the BPF
object was built without arena address-space-cast support, alloc_old
in progs/arena_race.c sets `skip = true`. setup_arena() then calls
test__skip() without printing why.

Both subtests go through setup_arena(), so on such a toolchain every
subtest is marked SKIP with no explanation. The neighbouring arena
tests print a reason before skipping for the same condition. For
example, prog_tests/arena_list.c prints:

    printf("%s:SKIP:compiler doesn't support arena_cast\n", __func__);
    test__skip();

The other skip in this file (in test_free_before_flush) already prints
"flush_tlb_kernel_range is not an fentry target". Should this skip
include a similar reason?

> +
> +	base = bpf_map__initial_value(skel->maps.arena, &arena_sz);
> +	if (!ASSERT_OK_PTR(base, "arena_base"))
> +		goto err_out;
> +	*addr = (__u64 *)(base + getpagesize());
> +	if (!ASSERT_EQ((unsigned long)skel->bss->ptr, (unsigned long)*addr,
> +		       "arena_ptr"))
> +		goto err_out;
> +	return skel;
> +
> +err_out:
> +	arena_race__destroy(skel);
> +	return NULL;
> +}

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/arena_race.c b/tools/testing/selftests/bpf/progs/arena_race.c
> new file mode 100644
> index 0000000000000..56ebfd7273247
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/arena_race.c

[ ... ]

> +SEC("syscall")
> +int free_page(void *ctx)
> +{
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST) || defined(BPF_ARENA_FORCE_ASM)
> +	__u64 __arena *p;
> +	__u64 marker;
> +
> +	if (!ptr)
> +		return 1;
> +	bpf_arena_free_pages(&arena, ptr, 1);
> +	if (!realloc_after_free)
> +		return 0;
> +
> +	marker = new_marker + ++marker_seq;
> +	realloc_ptr = bpf_arena_alloc_pages(&arena, ptr, 1, NUMA_NO_NODE, 0);
> +	if (realloc_ptr)
> +		ptr = realloc_ptr;
> +	else
> +		realloc_ptr = ptr;
> +	p = (__u64 __arena *)ptr;
> +	*p = marker;
> +	current_marker = marker;

Can the write to *p cause spurious test failures when the realloc
fails?

When bpf_arena_alloc_pages() fails, the code falls through to write the
marker through the old ptr. That only works if the failure means
fault_reader_thread already faulted the page back in.

However, there is a second way to reach the failed realloc: the free
itself can be deferred. The reader thread's fault reserves the range
for a short time while it installs the user PTE. In arena_vm_fault()
it calls range_tree_set_unavail() before vmf_insert_page() and
range_tree_remove_unavail() after it.

If the next iteration's bpf_arena_free_pages() starts inside that
window, arena_free_pages() gets -EAGAIN and defers the free:

kernel/bpf/arena.c:arena_free_pages() {
    unavail_node = range_tree_set_unavail(&arena->rt, pgoff, page_cnt);
    if (IS_ERR(unavail_node)) {
        ...
        /*
         * For -EAGAIN: An overlapping fault reserves
         * the range before installing its PTE.
         */
        if (ret == -ENOMEM || ret == -EAGAIN)
            goto defer;

The page is still allocated at that point, so the realloc fails:
is_range_tree_set() returns -ESRCH, or range_tree_clear() returns
-EAGAIN. The program then writes the marker into the old page and sets
current_marker.

Then arena_free_worker(), queued via irq_work and schedule_work on the
same CPU, clears the kernel PTE, zaps the user PTE and frees that page.

When the userspace loop reads *addr afterwards, arena_vm_fault() maps
a fresh zeroed page because the range is available again, so

    ASSERT_EQ(value, expected, "marker_after_realloc")

in test_fault_free_realloc() sees 0 instead of the marker.

A variant: if the deferred span runs only after the next iteration's
synchronous free and successful realloc at the same address, the worker
tears down the newly reallocated page, and the same assertion fails.

The kernel is doing what it is designed to do here; the program is
writing to a page it just freed. The test's assumption that a failed
realloc always means the page was faulted back in does not hold, so
the 1000-iteration loop can fail spuriously in CI, most easily on VMs
where the reader thread's vCPU can be delayed between vmf_insert_page()
and range_tree_remove_unavail().

Possible fixes: have free_page return a distinct retval or flag when
the realloc fails and the page may be pending release, or make
userspace retry or skip the marker check in that case.

> +#endif
> +	return 0;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35908471084
--===============8260412153300754749==--
