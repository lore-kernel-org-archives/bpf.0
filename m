Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178A43A6B8E
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786354769; cv=none; b=ZPCVeQNLYHant/9iDRbL2B16sl/++fST5LASsggrudOky2XcZRaAZXuoKdrmow1jRiT9PaNi40xiicv6Ovw33xjYJzuTtRF4tO2WW1GnI9ozM+vaZdL8BXT9tHyuXzoXRL1zY1wa6UezVJLLrwS+N9VepF/8c9wj6pkFDdMjzOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786354769; c=relaxed/simple;
	bh=aYr5iPcJ8EIi4KH5ATDpY2cGgQrebn0u3X+3hxWPLiE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zb2EgkWzRfMIiAqzMytXZoI5nekB9KtcrVJwXYv5s9lkXwYSFg/AVHhOP0lCE7wCQWysa9kx3RJjJZIHO//w+SwE0iM9oSfdxsirpB/cKwB/f+9GPBDG0c46x+uNpgJsuwPHRWAHAd8U4ZeQ9i2wfV3IkWjklmp44NUUs9tezUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lF+S6/H/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lF+S6/H/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934E61F000E9;
	Mon, 10 Aug 2026 09:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786354767;
	bh=ieqGrJNFdMyktGoQaUQ+o5i0/rhc0y9p1rq3BpOeEv4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lF+S6/H/4MbcnCxZ9dfIfp/5Rk5bUczDbJ9uZ/awfgi00eA295Mi7esXeg0no4K5M
	 QW7a9r1AGyyySnHu3/k8+/R+XVKNUJs22qs8lbBBc2CodFADhxWI88p5J84hojwKj1
	 7C+QQuFtZ0v82+i471l3AnF8bHCc/tMYAX9MEmDfyPR4U5uuXPcYjr3G4iHeFyWlcu
	 Rj07Mm/KzSyZzFMFARiBptpvsXqEjUtXjujH5us1AN16/gfFwUxzsa++lkb4VvRxDx
	 vdhvfIDlgi2+HMRrA3exF7e8uZY40pqrskxNQLWgh0rxMayGf6F6cnyC7P/A996zhb
	 ybmFga9KYqgDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add regression test for
 queue/stack map size limit
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260810092814.2698521-3-chenyuan_fl@163.com>
References: <20260810092814.2698521-1-chenyuan_fl@163.com>
 <20260810092814.2698521-3-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 09:39:27 +0000
Message-Id: <20260810093927.934E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing file descriptor cleanup on the test failure path for the fi=
rst bpf_map_create call.
--

--- Patch [2]: [PATCH bpf v2 2/2] selftests/bpf: Add regression test for qu=
eue/stack map size limit ---
commit 25c3a9fe96d53115b495649d174f217a4729daca
Author: Yuan Chen <chenyuan@kylinos.cn>

selftests/bpf: Add regression test for queue/stack map size limit

This commit adds regression tests to ensure that queue and stack maps whose
element storage would overflow the u32 head/tail index multiplication or
wrap the u32 capacity counter are properly rejected at creation time.

> diff --git a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c b/t=
ools/testing/selftests/bpf/prog_tests/queue_stack_map.c
> index 41441325e1794..8ab07ea777759 100644
> --- a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
> +++ b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
[ ... ]
> @@ -101,8 +101,53 @@ static void test_queue_stack_map_by_type(int type)
>  	bpf_object__close(obj);
>  }
> =20
> +static void test_queue_stack_map_alloc_check(void)
> +{
> +	LIBBPF_OPTS(bpf_map_create_opts, opts);
> +	const __u32 big_value =3D 1 << 20; /* 1MB */
> +	int fd, saved_errno;
> +
> +	/*
> +	 * Regression test for the u32 index overflow in queue/stack maps:
> +	 * a map whose element storage (max_entries * value_size) exceeds
> +	 * U32_MAX bytes must be rejected at creation time, otherwise the
> +	 * u32 head/tail index multiplication wraps and push/peek/pop
> +	 * address the wrong element. 8192 * 1MB =3D 8GB > U32_MAX.
> +	 */
> +	fd =3D bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, big_value, 8192, &op=
ts);
> +	saved_errno =3D errno;
> +	ASSERT_LT(fd, 0, "queue_oversize_fd");
> +	ASSERT_EQ(saved_errno, E2BIG, "queue_oversize_errno");

[Severity: Low]
Should this test block include a close() call in case bpf_map_create()
unexpectedly succeeds?

If the kernel fails to reject the oversized map, fd will be a non-negative
value. Since ASSERT_LT logs the test failure but doesn't abort execution,
fd is overwritten in the very next bpf_map_create() call without being
cleaned up.

The subsequent tests in this function include a check to close the file
descriptor on the failure path:

> +
> +	/*
> +	 * max_entries =3D=3D U32_MAX would make the u32 capacity counter
> +	 * qs->size (max_entries + 1) wrap to 0, permanently breaking the
> +	 * map, so it must be rejected as well.
> +	 */
> +	fd =3D bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, 1, U32_MAX, &opts);
> +	saved_errno =3D errno;
> +	ASSERT_LT(fd, 0, "queue_u32max_fd");
> +	ASSERT_EQ(saved_errno, E2BIG, "queue_u32max_errno");
> +	if (fd >=3D 0)
> +		close(fd);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810092814.2698=
521-1-chenyuan_fl@163.com?part=3D2
