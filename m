Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0083ACEF9
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 23:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790466653; cv=none; b=SCElOxE9qdBty37S+R9JL347Bnyz8QAzga3gNZRhX7gDg/DiFBdeVtdCFYOe2SkV7meeWDzw6at6YgEmYZbF6pRw8Ekz9BdZOqpXSBCgtLDjJx52m4fi9cfichtZuj/78sna7kvfLQhk7tPKXNKNyxdUprmb8j6yduHsWIlrKUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790466653; c=relaxed/simple;
	bh=qItbywAmnert4WcySlgWTAszSvvggGwKuVVP32Rb62o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F8dMGuhiw5BTAACaskDN7LqSC7ZNjRk/JxPPEjbmcCct3MEBVuWbgxgJvAT3xOXtoFFnPfaKRSssGK9qjUbk4Fd/Y18eGdahfCDUhZrOZE5inFkcXSz4UMYWaYnIaySgyAUHAc7ll/mINZ8HJkXI34PyqD3j8s6/jRhgr561wjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOQA8Lqc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOQA8Lqc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1F81F000FF;
	Sat, 26 Sep 2026 23:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790466643;
	bh=aApkbFCPwV+ddx8Rny1ys2Plv+S0b5Yx4FTp1m7hkm0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EOQA8Lqc2lb3fPY1Dz0DMw9tQ17GVRwRkj6eFuAbEJqjFHcNwGa/c5VuD9uNhs3Lv
	 fgu8BRAXYP6Dcz7CrNT0VHoKcYHVdGR5ytZM5mK1ezg5U5ek1oqN8yBPo/xYWH9xHT
	 P1xNUSbccl26VG0xOHDUHBimEmcDoWu/xaN7vPfgMwA+Lmt37zmQXTwif0ffOB9nLr
	 AJOlHuhpcUJXLzITS7Nr35ZhzgaZq37GbqmpSbYwQfMG4UhMBbjvPvDxeRZfdZr0r9
	 EaQCL5XpPe8P9O8cg7XEC2z20CmgFIR7nkhhfuzrS1+OkdvBWAD8XTk/mGHyHqHVym
	 plYvHodrXOJ1w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 16/16] selftests/bpf: Exercise typed
 arenas at run time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926233503.3114147-17-memxor@gmail.com>
References: <20260926233503.3114147-1-memxor@gmail.com>
 <20260926233503.3114147-17-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 23:50:42 +0000
Message-Id: <20260926235042.DE1F81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/bpf: test_release_bounds unconditionally fails due to =
logic error in alloc_at expectation
--

commit a5c65698dd674c11891a999b72347849ae68ce84
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

selftests/bpf: Exercise typed arenas at run time

Drive typed arenas from user space through a skeleton, testing map memory
usage, chunk allocation, release, multipage allocations, bounds checking,
and pointer fields.

> diff --git a/tools/testing/selftests/bpf/prog_tests/typed_arena.c b/tools=
/testing/selftests/bpf/prog_tests/typed_arena.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/typed_arena.c

[ ... ]

> +static void test_release_bounds(void)
> +{
> +	long ps =3D PAGE_SIZE, base, nr =3D OBJ_ARENA_SIZE / PAGE_SIZE;
> +	struct typed_arena *skel;
> +	int fd;
> +
> +	skel =3D typed_arena__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_load"))
> +		return;
> +	fd =3D bpf_map__fd(skel->maps.arena);
> +	base =3D map_memlock(fd);
> +
> +	/* Fill the typed arena, so that a scan of its bitmap for a free chunk =
runs to the end. */
> +	skel->bss->ptr =3D NULL;
> +	skel->data->page_cnt =3D nr;
> +	if (run(skel->progs.alloc_at, "fill"))
> +		goto out;

[Severity: Medium]
Will this unconditionally abort the test?

When skel->bss->ptr is set to NULL in test_release_bounds(), the BPF program
alloc_at() executes with its hint variable as NULL. If the allocation is
successful, o will be non-NULL, which makes the condition o !=3D hint evalu=
ate
to 1 (true):

tools/testing/selftests/bpf/progs/typed_arena.c:alloc_at() {
    ...
	hint =3D ptr;
	o =3D bpf_typed_arena_alloc_pages(&arena, TYPE_ID(struct obj), hint, &page=
_cnt, NUMA_NO_NODE);
	if (!o)
		return 1;
	return o !=3D hint;
}

The run() helper wraps ASSERT_OK(ret), which expects a return value of 0.
Since it receives 1, the assertion fails and the test executes goto out,
leaving the rest of test_release_bounds() unexecuted.

Could the return logic in alloc_at() be adjusted when hint is NULL, or
should this test use a different program or helper to fill the arena?

> +	ASSERT_EQ(map_memlock(fd), base + nr * ps, "full");
> +
> +	skel->data->page_cnt =3D nr + 1;
> +	if (run(skel->progs.free_pages, "free_oversized"))
> +		goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926233503.3114=
147-1-memxor@gmail.com?part=3D16
