Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FB2282F27
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 21:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776203125; cv=none; b=FM7ioAl7iWlf5X7NuvWbUUh8Uw8A9IbP0jje4Hl1FKlAQMFYEr7uawVL7MAMw60wRmeUbxtOXepGnEm77/Nt2heb73txrxO6/vIug1r2QAmKljQbmOmsTj4zVZhw9wpBO4qqLVpJ3/sfPZG/NnDqrwjla+5xoUpxpSrL/fqU1ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776203125; c=relaxed/simple;
	bh=s0m1acmZq3fDDIRlcVkpZHUQaRAVW4AIipVWAQdK8sc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uo8n+F3CUH1RTv0RWRiiRVDdqsKiUFQTLlFkSshe7oFitHXoqX9I79K/jvLAdDLygTOubBYmpryLSOWx+CVuJwg9F1R6Glc2xW0Fn39v+Y1JHLtc3cQs/UoqMkY4tutRhgtGKacZACsnzCiE6GQVmb9D4Lu6QfwtXk/WfSLUl0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZLvZmRP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZLvZmRP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589E8C2BCB6;
	Tue, 14 Apr 2026 21:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776203125;
	bh=s0m1acmZq3fDDIRlcVkpZHUQaRAVW4AIipVWAQdK8sc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=BZLvZmRPRzrfCRPZwxjwu6XqG2WFBlCuPSBHibQUjn4emMWg+lQ9WdINrU9TsBXQX
	 zpt3FK0MogEAhGMNSX4/vxOArUu68aITlKI+FNoLQJPENGrIB7rTOkvwpraz+/+Ua9
	 snQrP1MhTjmuV8mLdQOSY/qjdpTaIkvHQuB7phcQsIn98+YdEm7eRrmZMbNCHUQomO
	 wtvNzdP2iU+ziJqfuszJidb2GwbwtULTN3OoEO65ALgyxX4kbr0ywalmANnhEW+C5x
	 74X+W1FJOANWHblbPx8XnMhAf3kWCyGQObYnIJImfX4PUvd5RlodStg4qJS4i4yXeL
	 RFq3KbEnwAMKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 7/8] selftests/bpf: Add tests to verify
 global percpu data
Reply-To: sashiko@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260414132421.63409-8-leon.hwang@linux.dev>
References: <20260414132421.63409-8-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 21:45:24 +0000
Message-Id: <20260414214525.589E8C2BCB6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The tests use the raw CPU ID to index into the densely packed `p=
ercpu_data` array, which will cause an out-of-bounds read and test failures=
 on systems with sparse CPU masks.
--

commit a7c2685b539ebc816cdb05decab1d7a8a4e1328e
Author: Leon Hwang <leon.hwang@linux.dev>
   =20
selftests/bpf: Add tests to verify global percpu data
   =20
This commit adds new selftests to verify the behavior of global percpu data
by checking map initial values, struct pointers, and looking up elements fr=
om
global percpu data maps.

> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/=
tools/testing/selftests/bpf/prog_tests/global_data_init.c
> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c

[ ... ]

> +static void test_global_percpu_data_init(void)
> +{

[ ... ]

> +	err =3D bpf_map__lookup_elem(map, &key, sizeof(key), percpu_data,
> +				   elem_sz * num_cpus, 0);
> +	if (!ASSERT_OK(err, "bpf_map__lookup_elem"))
> +		goto out;
> +
> +	for (i =3D 0; i < num_online; i++) {
> +		if (!online[i])
> +			continue;
> +
> +		data =3D (void *)percpu_data + elem_sz * i;

Will this logic cause an out-of-bounds read on systems with sparse CPU mask=
s?

When reading a per-CPU map using bpf_map__lookup_elem(), the kernel packs t=
he
per-CPU values densely into the output buffer by iterating over the possible
CPU mask.

The test allocates num_cpus (the total count of possible CPUs) elements for
the output buffer, but then iterates over the raw CPU IDs using i and uses i
as an index into the densely packed array.

On systems with sparse CPU masks (for example, where CPUs 0 and 100 are
possible/online), num_cpus will be 2. When the loop reaches i =3D 100, it
appears it will attempt to access percpu_data + elem_sz * 100, reading past
the bounds of the allocated memory.

Could we maintain a separate index counter that increments only for possible
CPUs to match the kernel's dense packing behavior?

[ ... ]

> +static void test_global_percpu_data_lskel(void)
> +{

[ ... ]

> +	err =3D bpf_map_lookup_elem(map_fd, &key, percpu_data);
> +	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
> +		goto out;
> +
> +	for (i =3D 0; i < num_online; i++) {
> +		if (!online[i])
> +			continue;
> +
> +		data =3D (void *)percpu_data + elem_sz * i;

Does this loop have the same bounds checking issue as mentioned above?

If i is a raw CPU ID on a system with a sparse CPU mask, this calculation
could exceed the bounds of the percpu_data buffer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414132421.6340=
9-1-leon.hwang@linux.dev?part=3D7
