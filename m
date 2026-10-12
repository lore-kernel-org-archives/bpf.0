Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FB436404D
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812691; cv=none; b=k6I39GObxA3AAA/X/GhETi/ZNihk718pmhQaC+OCxfXNAFp5IWHMGjcLpIdEi0+a6Ne30oVO4Iiq0+N9rAce81eEj2BMTzc08zbGrtW76SwjFekOxA+6vCEherwROPGPIS4DXitu11Po/irrOB2FKTyiXqFFaxcmcVSXa/UXgpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812691; c=relaxed/simple;
	bh=oiYuXAHjdTsjx/538VT2HaXeV3cGECiPzdtrH0dFBbU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=KMdSsbrqx1YcPhNOtb7PhuQsop0YDJtiqr02T8rlCn81MFEVGx+dvsGS7Dc26TEh4U65LVVxhaQiVU6lkZbL/T3FPjqvoMue1CJaaYbO5qrP0nzemhb9VGCVvQUcn5+VLA26HiFRHIT0XN0Px9YQ8OT0jcx0NvGVPIssc4F8T7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHIBAgT7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHIBAgT7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBEF1F0089B;
	Mon, 12 Oct 2026 13:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791812689;
	bh=jAB/8eal+vyVRzWBGOcbgOu1O99aPlB1A9KVuYD7MJ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fHIBAgT7Twvsnm7lJIPa2IJTpfJ3hU9RsExMGqjaiLBgJQrBJBDKL6/NUu2B75p/X
	 buVd9oJKiPjKMChgtbhhZn4U+PtyCCorcMg0pBD/03O/E5zAbO5FW1ierknpM8Rknb
	 83IPAlIdk0ZkiGy6qmU1u9c6AG5X5JM/6Vq2fxaoDlBCAdDLNCzeazqam48IGEy9r6
	 W9BJT5WtdANC2987T6kU6R0hKc/lHvwH/jlUd/biBN4FjAQ1rJC/6aB+1wvWHzIk4V
	 x9i5v30HG93dDNrFXUN4PaFRAZZAEPgtsZEPosdNQSsc/dWIVjWpd13s6j7WCXgzGX
	 4HDN4VDh7qNMw==
Message-ID: <sashiko-outbox-168206@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 07/10] selftests/bpf: Test arena binding by
 libbpf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261012133711.4030594-8-memxor@gmail.com>
References: <20261012133711.4030594-1-memxor@gmail.com>
 <20261012133711.4030594-8-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:44:49 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests/bpf: uninitialized stack memory read in assert_prog_map()=
 on test failure
--

commit 2eeeb2c231d34a25c0bfb615692f8a717edbdc53
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

selftests/bpf: Test arena binding by libbpf

This commit introduces a test to ensure libbpf correctly binds an arena
to all programs in an object, even if they don't explicitly refer to it.
It also relocates programs that were previously expected to fail without
an arena to a new object without an arena map to preserve their negative
tests.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena=
.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
> index 1a7fe0d6c5a4c..a45b360b4c65d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
[ ... ]
> @@ -144,6 +145,50 @@ static void arena_member(void)
>  	struct_ops_arena_member__destroy(skel);
>  }
> =20
> +/* @prog_fd lists exactly one map, the one with @map_id. */
> +static void assert_prog_map(int prog_fd, __u32 map_id, const char *name)
> +{
> +	__u32 map_ids[2], len =3D sizeof(struct bpf_prog_info);
> +	struct bpf_prog_info info =3D {
> +		.nr_map_ids =3D ARRAY_SIZE(map_ids),
> +		.map_ids =3D ptr_to_u64(map_ids),
> +	};
> +	int err;
> +
> +	err =3D bpf_prog_get_info_by_fd(prog_fd, &info, &len);
> +	if (!ASSERT_OK(err, name))
> +		return;
> +	ASSERT_EQ(info.nr_map_ids, 1, name);
> +	ASSERT_EQ(map_ids[0], map_id, name);

[Severity: Low]
Does this read uninitialized stack memory on test failure?

If bpf_prog_get_info_by_fd() successfully returns but the program has 0 map=
s,
it will set info.nr_map_ids =3D 0 and leave the map_ids array unwritten.
Since ASSERT_EQ() does not abort the test on failure, execution will contin=
ue
to the next assertion, which evaluates map_ids[0].

Could we return early if info.nr_map_ids !=3D 1, or initialize the map_ids
array to zero?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012133711.4030=
594-1-memxor@gmail.com?part=3D7
