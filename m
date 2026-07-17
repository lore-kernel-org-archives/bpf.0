Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860CF3E5EF5
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 11:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784289221; cv=none; b=SW0FzOn7nKJ/DBKcQqnzXY+mS6opbTkqke/gnfZWCYANewe2SNd7+Y9eWFYaQdFyYbt+1ZmrwJq1lp8JumkS2T/UcSseYov6Lqpe9glOacPRozD1hLGh0xFKgjLNnR/QGlP153olg3G1lKtLO1z6XAmZzJI04qdxsf2T3PREXEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784289221; c=relaxed/simple;
	bh=csW3tvjYaqkvjHjb0FuwdBIV4ltAIT/KF9hokiJqUVo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g3AqtuEG8BC2r5u34EPrR/NwGgfTB1ogcwR73DQyDKle4LQLpPfOsRJXQrzdfQOTKZBz3+abCTlMZvZHSYV+bMu/Iz9KbUalJmUNoNWeL6wwBcE8iKW9cQ7oZ64KvdhSypNydBG9NaGZ5N2yeY6xnXX1GNGHeFsjkuSzb/CygMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCnPGAbl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCnPGAbl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78DC1F000E9;
	Fri, 17 Jul 2026 11:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784289216;
	bh=sz65C5TfgPEaW01qAu9bzLfE1ZJQMQgSLajFfx+X02o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XCnPGAbl4q4Q/BMJ+MtX9ijKiv4fxpsFaV6YQmnFZzXras+f6By1CU73fRbEFQRlW
	 akcw5i/Vcc4jLYML/KCpkuBD+gBmiZxWux1NFE+iBDPdC/qTJtla5T2oYqppFpf24M
	 n1jVCfcRdTCbQntB1By2uwRxoaCdpAr0MmlH7JfDHWyGRoasuAXIcQIzGtEb1DUrUF
	 965+xlR1QfjrMHPcuZ31EupAuQJkUDrznO+4+wN6yarx0kkM44X8puYJt9b/628blh
	 tDq74j1Rw4MJKaZNF1aubbkqnU/hZb1WuJ6Agj177yxdwQ99xHvnSYB2s823ClNGea
	 DO/bg+9o/tXlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 4/4] selftests/bpf: Add tests for memory
 usage for arena
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260717114117.350851-5-jiayuan.chen@linux.dev>
References: <20260717114117.350851-1-jiayuan.chen@linux.dev>
 <20260717114117.350851-5-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 11:53:36 +0000
Message-Id: <20260717115336.A78DC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incorrect use of ASSERT_OK_PTR to check for a NULL pointer read =
from BPF userspace memory, breaking intended error handling.
--

--- Patch [4]: [PATCH bpf-next v2 4/4] selftests/bpf: Add tests for memory =
usage for arena ---
commit b8bd79585d9f7cbf2a83d5381d0df2c316e65ed7
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

selftests/bpf: Add tests for memory usage for arena

This patch adds a selftest to verify memory usage tracking for BPF arenas.
It allocates and frees arena pages both from BPF and user-space and checks=
=20
the map's memlock value via fdinfo to ensure it tracks populated pages.

> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_mem_usage.c b/t=
ools/testing/selftests/bpf/prog_tests/arena_mem_usage.c
> new file mode 100644
> index 0000000000000..14c2d1a1d673c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_mem_usage.c

[ ... ]

> +void serial_test_arena_mem_usage(void)
> +{
> +	struct arena_mem_usage *skel;
> +	const long ps =3D PAGE_SIZE;
> +	char *base;
> +	size_t sz;
> +	int fd, i;
> +
> +	skel =3D arena_mem_usage__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_load"))
> +		return;
> +	fd =3D bpf_map__fd(skel->maps.arena);
> +
> +	/* Fresh arena: no data pages, and the scratch page is not counted. */
> +	ASSERT_EQ(map_memlock(fd), 0, "initial");
> +
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

[Severity: Medium]
Will this check actually catch a NULL pointer when bpf_arena_alloc_pages()
fails?

When skel->bss->ptr is NULL, ASSERT_OK_PTR() evaluates libbpf_get_error(NUL=
L),
which returns -errno. Since the userspace errno is likely 0 following a=20
successful bpf_prog_test_run_opts() ioctl call, ASSERT_OK_PTR silently
evaluates to true (success).

This would cause the goto out to be skipped, and the test to proceed to
evaluate ASSERT_EQ(map_memlock(fd), 17 * ps). This subsequent check would
then fail, emitting the exact counting bug error the comment mentions trying
to avoid.

Should this use a different macro, like ASSERT_NEQ(skel->bss->ptr, NULL), to
correctly verify the userspace pointer?

> +		goto out;
> +	ASSERT_EQ(map_memlock(fd), 17 * ps, "after_alloc");

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717114117.3508=
51-1-jiayuan.chen@linux.dev?part=3D4
