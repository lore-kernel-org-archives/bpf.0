Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53DC311C3E
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784216444; cv=none; b=Fs4wvaMVM+NhY8kWUskOTOoN36ZFILDpMUH1kfnJaodhJ2Xa0nL0c6IIhD1CY8YQv3plsfWs/0MicmlkBPn3IEbMabSi8QMc/zhmb3jbvixmbJU/WFizrwe1bpJrT0yA4khPwl9I50Idpt6AL9wHT6w0j6fL1L6oRsXamZ4OVA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784216444; c=relaxed/simple;
	bh=dFJUIk9vYeWKzXUGP1j+MChS/lMx2e9Si4kIb8GlC00=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IBAbHx4wF8HAUgMRb/HtN+hRnm047gSOpyMPdtcTxCikXmaf3KJrJ8cyVRfX588e/BjOq+20dAXkZ50D9UvKtEsOx7R8D3q/LR6yN35gly7KFDJv6gcgtf/twCMqHfmg3SI7yxH+zCxB2pSvMZILqppGzhCYn2Wyis4PtbwWtIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGgDZ7hm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGgDZ7hm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440941F00A3A;
	Thu, 16 Jul 2026 15:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784216442;
	bh=e4F0Rse6BWpicNP46vGxLr6zJgN+uFP0AHfIP3Bz3lM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lGgDZ7hmGTdxVbCsTqF3sHt0ghh+P2+3VkaXYA6AlrPYjfQCK3OYDnkRUNst88pHs
	 Njk1snnIy3QyP2pzTBkOpiKgkkvPIVBIe+vEIjKUqukxdMLsqm00vW4m6NvZ3TzU6X
	 BudSf6euagO1vxkvTIzk7tChVgPDCkVeTZv+8q5+ZvMyAm3vkopbsZNsrrI8SbY/iQ
	 7DJAujNYbKAUuBhw0NmRtFH6qjPxtIH4PYvuItKZ0QUoBFi4ROvYs/jdrqtOj7/8Td
	 05cvI60aj2YzdLGC4c99ykBppTRoiH/6zx7Mxi9UY/Q2cJHt1jvVzwn01cp5VZzvMO
	 ayEzS/2vIWsRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add tests for memory usage
 for arena
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260716142746.8794-3-jiayuan.chen@linux.dev>
References: <20260716142746.8794-1-jiayuan.chen@linux.dev>
 <20260716142746.8794-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 15:40:41 +0000
Message-Id: <20260716154042.440941F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test logic unintentionally bypasses the explicit check for a=
llocation failure, defeating its documented purpose to distinctly flag memo=
ry pressure CI failures.
--

--- Patch [3]: [PATCH bpf-next 3/3] selftests/bpf: Add tests for memory usa=
ge for arena ---
commit f5d331845302b77cab3c4b06daa82ffb16675b30
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

selftests/bpf: Add tests for memory usage for arena

This commit adds tests to verify that memory usage for BPF arenas is tracked
correctly in the map's fdinfo memlock field. It allocates and frees arena
pages from both BPF and user-space fault-in paths.

> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_mem_usage.c b/t=
ools/testing/selftests/bpf/prog_tests/arena_mem_usage.c
> new file mode 100644
> index 0000000000000..14c2d1a1d673c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_mem_usage.c

[ ... ]

> +static int run(struct bpf_program *prog, const char *name)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	int err =3D bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
> +
> +	if (!ASSERT_OK(err, name))
> +		return -1;
> +	if (!ASSERT_OK(opts.retval, name))
> +		return -1;
> +	return 0;
> +}

[ ... ]

> +void serial_test_arena_mem_usage(void)
> +{

[ ... ]

> +	/* BPF-side allocation of 17 pages. */
> +	skel->bss->alloc_cnt =3D 17;
> +	if (run(skel->progs.alloc, "alloc"))
> +		goto out;
> +	/*
> +	 * A NULL ptr means bpf_arena_alloc_pages() itself failed (e.g. the host
> +	 * is under memory pressure), not a miscount -- flag it distinctly so a
> +	 * red CI run is not mistaken for a counting bug.
> +	 */
> +	if (!ASSERT_OK_PTR(skel->bss->ptr, "arena_alloc_pages"))
> +		goto out;

[Severity: Medium]
Does this logic inadvertently bypass the explicit check for allocation fail=
ure?

Looking at the alloc() BPF program in arena_mem_usage.c, it returns 1 on
failure:

SEC("syscall")
int alloc(void *ctx)
{
        ptr =3D bpf_arena_alloc_pages(&arena, NULL, alloc_cnt, NUMA_NO_NODE=
, 0);
        return ptr ? 0 : 1;
}

Because of this, if bpf_arena_alloc_pages() fails, opts.retval will be 1,
causing run() to assert and return -1.

The test will then take the "goto out" path immediately after run(), making
the ASSERT_OK_PTR() check unreachable and defeating its documented purpose
to distinctly flag memory pressure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716142746.8794=
-1-jiayuan.chen@linux.dev?part=3D3
