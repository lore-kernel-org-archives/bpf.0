Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F67485CD2
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787670825; cv=none; b=KYBMGF8vEoi2LAVKZ0pYVK24BWaEOA5pWWr0FeDVrzyoi9KJ4yEm+en5B7ng072fin9idWmSPlMUQfTqYTv6cd6ujMCaFLz4j19wtPGc5LrzzKN2dU3EPHhNtGqalEHjsCrGzcsfccZOGtTIh7vrXq9fQxWUAA1HKAC4z/zi9Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787670825; c=relaxed/simple;
	bh=6y/ltxeE5jXoYONL6ffwOwVvoiQ7hz3mWlNOWe8JJmc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ROQItGSWNabK1+Jii3rclwQbohk1gCHW1hkcXM1xTNrvJYx2TpgdBxi9rrpjOVM85BYhAgfNcAEjVD6tZdKcR9Hw7MEZ89KB4bkR8nKOfbDS4AevQHz3Xpn17q1H2R3dE0tZsGvRwn7yNPZaVg6DAl0kiYZ8mtkBIJIxso3O8do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctzNigvf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctzNigvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A601F000E9;
	Tue, 25 Aug 2026 15:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787670823;
	bh=aOMTQqEnoqEk8TbYbnkNh139wHpbAv4xdSXf/NzoOHo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ctzNigvf0HzObZSLUn0w5iJqcRu5dRZkyjehWp+W71Hv55wlbXgQm1ANcY7nXtEat
	 m9LEk6z6GoEDQeJrw+HD3gGY7oA7/c7fjEcUNAvKwFKetKnf+LasfshKvSfFy2ljlh
	 bXYnba4+LVW/FhvU7bCUaqFNnEIMy5DQIYCo4XEdloidvEAYVD6CBGAUSbYSMGOeCo
	 xANpI3gVnFeoVQZe/MND9pbAgvD5wZ2CaBY+kgw3bYifdwRKhCernTw7kn8X+/vOHt
	 BFp4ek3mkgV4FM/Pwb8aOVFKkTBxAEi9VVtbtXuyVQBznLZbGF7j4XGlhvrI6+nNo9
	 joppyoHMc5GQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add test for usdt probe with
 page-crossing nop10
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260825150444.31603-2-jiayuan.chen@linux.dev>
References: <20260825150444.31603-1-jiayuan.chen@linux.dev>
 <20260825150444.31603-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 15:13:42 +0000
Message-Id: <20260825151342.F3A601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The search loop limit `2 * page_sz` for locating the USDT probe =
can cause the test to falsely fail if the compiler generates a prologue of =
11 bytes or larger.
--

--- Patch [2]: [PATCH bpf v2 2/2] selftests/bpf: Add test for usdt probe wi=
th page-crossing nop10 ---
commit 3ab03ec0febc59ef7c61c7f1449047ef827d5e7b
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

selftests/bpf: Add test for usdt probe with page-crossing nop10

This commit adds a USDT probe layout where the nop10 crosses a page boundar=
y.
It verifies that attaching to it succeeds and the probe fires without the
uprobe being shifted onto the nop10 incorrectly.

> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testin=
g/selftests/bpf/prog_tests/usdt.c
> index 8004c9568ffa5..eff1e57ab13c0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
[ ... ]
> @@ -342,6 +343,57 @@ static void subtest_optimized_attach(void)
>  	test_usdt__destroy(skel);
>  }
> =20
> +/*
> + * Test attachment to a USDT probe whose nop10 crosses a page boundary.
> + * The kernel can't optimize such nop10, so libbpf keeps the uprobe on
> + * the preceding 1-byte nop. Do not assume any particular placement
> + * here, though: however the probe ends up attached, the attachment
> + * must succeed and the probe must fire.
> + */
> +static void subtest_optimized_attach_cross_page(void)
> +{
> +	long page_sz =3D sysconf(_SC_PAGESIZE);
> +	struct test_usdt *skel;
> +	__u8 *addr =3D NULL;
> +	long i;
> +
> +	/* combo is placed up to a page of padding after the function start */
> +	for (i =3D 0; i < 2 * page_sz; i++) {

[Severity: Medium]
Will this loop bound of 2 * page_sz (8192) cause the test to falsely fail on
builds with larger compiler prologues (like ASAN builds or those with frame
pointers enabled)?

If the compiler generates a prologue of size P, the offset to the probe is
P + align_padding (up to 4095) + skip_padding (4086) =3D P + 8181.

If P is 11 bytes or larger, the offset reaches 8192, which would exceed
this i < 2 * page_sz search bound and cause a spurious ASSERT_OK_PTR
failure.

> +		if (!memcmp((void *)usdt_2_cross_page + i, nop1_nop10_combo, 11)) {
> +			addr =3D (void *)usdt_2_cross_page + i;
> +			break;
> +		}
> +	}
> +	if (!ASSERT_OK_PTR(addr, "find_nop1_nop10_combo"))
> +		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825150444.3160=
3-1-jiayuan.chen@linux.dev?part=3D2
