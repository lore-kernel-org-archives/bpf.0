Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F103932ED
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561020; cv=none; b=pqoW8/toS6rocx3vMX+o8UPSwwqdiJFpgH1MfG3Pjy3RjicP3DQf6YzFli4h+VlDmlDkN9kTLhphIUyVYIvdaAQs42rimJjbiJMQqajpMtyNYrKyM1NeFtZc2KLbZaVnNFQizxbNHOpqfbRFgRoO6ZkhMPKKhsxnPuOdcFrq5WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561020; c=relaxed/simple;
	bh=IZlluNV1R2Hv+vPfzDouEWanDxn7Psbmlgp6fb9wi0Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oy7gej/VqzlcIAvt4ZokBLL/Ypd5wpATIl/A+s6lXmhVIKVxJoI9Ln+u8sMAj7Bb6T6o7cty7pLcaxaEGyGXcat4RTA5TlF8HnbMcsgwpWh78jQ1fHZpRY3snDaEbyGho7Ua541lxEEUOt4PYYbHXrIrWSEG3lFI+0bsxZXjb3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMrhHwQZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMrhHwQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0A31F00A3A;
	Mon, 24 Aug 2026 08:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787561018;
	bh=GR7J8ntx38W8ynoQQBv7W8THJjArZ/UCBrbYwOR815Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AMrhHwQZYp60Yn2Zn9wJ1AT6avTLqegXVmr36LNaXoOwNOZPA4UpBo2UNc0XojC0q
	 /RtSYykw/hRvDuU7gC+NqOjSt77wvvKFTcBzuXajUSFUl802bYBoGwAGFsEaNdDK5G
	 slEe2PgOFm8+6spv8gDcc1RAW1lZJaCxPHUWePmg1xItWgu/dMuH7+IfEdzMAv26uS
	 +Rz/3tHAS+FNDoTBOjIJTHeDUnUFGYeEl68ULILZeowJGqrbq04JL5xn2t6+b43u5a
	 WE3NddVcXhWRvxeJIOCDbZtiog4/ceOV0mBx0o/K6/sBTxFZa9onpBWjPkNNoSBF1Z
	 kFipwI/pVxubg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v4 2/2] selftests/bpf: Add regression test for
 queue/stack map size limit
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260824083327.1708560-3-chenyuan_fl@163.com>
References: <CAEf4BzbGe74OuUKiDz7oBrWzQCD54JVhYuCTQEWNHOHmnBEtbQ@mail.gmail.com>
 <20260824083327.1708560-1-chenyuan_fl@163.com>
 <20260824083327.1708560-3-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 08:43:38 +0000
Message-Id: <20260824084338.AA0A31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Massive memory leak and file descriptor leak in the test runner =
on unpatched kernels.
--

--- Patch [2]: [PATCH bpf v4 2/2] selftests/bpf: Add regression test for qu=
eue/stack map size limit ---
commit b01042556c787abab943d9e6059710f436274dbe
Author: Yuan Chen <chenyuan@kylinos.cn>

selftests/bpf: Add regression test for queue/stack map size limit

This commit adds a regression test to verify that queue/stack maps whose
element storage overflows the u32 head/tail index multiplication are reject=
ed
at creation time. It also checks that max_entries =3D=3D U32_MAX is rejecte=
d.

> diff --git a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c b/t=
ools/testing/selftests/bpf/prog_tests/queue_stack_map.c
> index 41441325e1794..efe808eedd9a8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
> +++ b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
[ ... ]
> @@ -101,8 +103,43 @@ static void test_queue_stack_map_by_type(int type)
>  	bpf_object__close(obj);
>  }
> =20
> +static void test_queue_stack_map_alloc_check(void)
> +{
> +	LIBBPF_OPTS(bpf_map_create_opts, opts);
> +	const __u32 big_value =3D 1 << 20; /* 1MB */
> +	int fd;
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
> +	ASSERT_EQ(fd, -E2BIG, "queue_oversize");
> +
> +	/*
> +	 * max_entries =3D=3D U32_MAX would make the u32 capacity counter
> +	 * qs->size (max_entries + 1) wrap to 0, permanently breaking the
> +	 * map, so it must be rejected as well.
> +	 */
> +	fd =3D bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, 1, U32_MAX, &opts);

[Severity: Medium]
If this test runs on an unpatched kernel, the previous bpf_map_create()
call might unexpectedly succeed and return a valid file descriptor.

Because ASSERT_EQ() doesn't abort the test upon failure, won't this next
bpf_map_create() call overwrite the 'fd' variable without closing the previ=
ous
one?

This could leak the map file descriptor and the large amount of memory
(up to 8GB) allocated by the map, potentially triggering the OOM killer and
crashing the test environment.

Should we check if 'fd >=3D 0' and close it after the ASSERT_EQ() for each =
of
these expected-to-fail allocations?

> +	ASSERT_EQ(fd, -E2BIG, "queue_u32max");
> +
> +	fd =3D bpf_map_create(BPF_MAP_TYPE_STACK, NULL, 0, big_value, 8192, &op=
ts);
> +	ASSERT_EQ(fd, -E2BIG, "stack_oversize");
> +
> +	/* A normal-sized map must still be created successfully. */
> +	fd =3D bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, 64, 100, &opts);
> +	ASSERT_GE(fd, 0, "queue_normal");
> +	if (fd >=3D 0)
> +		close(fd);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824083327.1708=
560-1-chenyuan_fl@163.com?part=3D2
