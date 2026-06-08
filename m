Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4125A3F58CD
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932030; cv=none; b=WaC6pkJLH7YXfC1wFSFNdDBrqcZLjKHsSzJlwBmvvaCZpjJuIBzA+PaxbhcDQExufI6e0aidFrT6zUAM/3m45hcNmsibo7bQh+b1A28kgikY5bYxyY++aJM2tK1IZKgNNyVeZmEDH8NmoohuP60I0L7J8Mg9tKh1JWU0FCqZfLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932030; c=relaxed/simple;
	bh=yCiTJUs0bVnPxISEIXYhwgOLIybFQ9lMPqIFIZQ1cyU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=az2Pvs551vBMd78+BuY5v0dQMqYiW5+YXB4kZuWFTTFXTq/ouSljYRz7eheN5Q8wMDmN6vCqqn1ZINaTNbkRn43nkYqDVCLvEY7k2nksFeSbFjfMa4hIE++BCiYEpLLDN6ZZ1rqXtNBny5T1eEQivoWkLRECdfjUdPx3rXIyAds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=if968JkW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="if968JkW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D1F1F00893;
	Mon,  8 Jun 2026 15:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780932028;
	bh=Ec8Gz+RJj6kKajACevIQJlEc4zzJv8Uqh5QYrArPiw4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=if968JkWqIu6BpUFcT1ESagmZvsdfbj1CoodUa483udp1SfAKWCd1yti0LtZQ+bC/
	 TFJ9YkOnTU9PUhr0Dalp7MvvGXStk2MILSBiAxD2RTM1lf5aKvH18XYr52t1AA9wnq
	 lcBO137YHZD7ADWIW3c1iXFN6ceOmMXBTjP5MnaXnBPNhq973AYWQDJgwBQu0FYnyl
	 Bql70/ateXiUX7Z11IAo7Zq6K/rjbgKbMrGyHZOFGtTPQ0NW8PAj664Uz4umZTJcIP
	 x39ZeN2XRVQxAUIKpRp6ynOlYbhehhPYO51lxxv5jwTakggRuM6K7M1hBFcP4Hpunj
	 XZkgIe9M2HzQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 6/9] selftests/bpf: Add tests to verify
 global percpu data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608145113.65857-7-leon.hwang@linux.dev>
References: <20260608145113.65857-7-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 15:20:28 +0000
Message-Id: <20260608152028.93D1F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unnecessary and incorrect roundup of `value_sz` for single-CPU m=
ap lookup makes test brittle.
--

commit b029e57f81ce93314bf885c351d6b7e8fe5bd177
Author: Leon Hwang <leon.hwang@linux.dev>

selftests/bpf: Add tests to verify global percpu data

This commit adds new test cases to verify global percpu data handling in the
BPF subsystem. It tests initialization, lookups, and direct data pointers
using both full and light skeletons.

> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/=
tools/testing/selftests/bpf/prog_tests/global_data_init.c
> index 8466332d7406f..5abdb0b8b8b33 100644
> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c

[ ... ]

> @@ -60,3 +63,196 @@ void test_global_data_init(void)
> +static void test_global_percpu_data_init(void)
> +{
> +	struct test_global_percpu_data__percpu *init_data, *data =3D NULL;
> +	struct test_global_percpu_data__percpu init_value =3D {};
> +	int key, prog_fd, err, num_cpus, num_online, i;
> +	struct test_global_percpu_data *skel =3D NULL;
> +	__u64 args[2] =3D {0x1234ULL, 0x5678ULL};
> +	size_t elem_sz, init_data_sz;
> +	struct bpf_map *map;
> +	bool *online;

[ ... ]

> +	elem_sz =3D roundup(sizeof(*data), 8);

[ ... ]

> +	/* run on every CPU */
> +	for (i =3D 0; i < num_online; i++) {
> +		__u64 flags;
> +
> +		if (!online[i])
> +			continue;
> +
> +		topts.cpu =3D i;
> +		topts.retval =3D 0;
> +		err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> +		ASSERT_OK(err, "bpf_prog_test_run_opts");
> +		ASSERT_EQ(topts.retval, 0, "bpf_prog_test_run_opts retval");
> +
> +		flags =3D ((__u64) i << 32) | BPF_F_CPU;
> +		err =3D bpf_map__lookup_elem(map, &key, sizeof(key), data, elem_sz, fl=
ags);

[Severity: Medium]
When looking up a per-CPU map element for a specific CPU using the BPF_F_CPU
flag, libbpf's validate_map_op() strictly requires that value_sz exactly ma=
tches
map->def.value_size.

By rounding up sizeof(*data) to a multiple of 8 and passing it as elem_sz
here, doesn't this make the test brittle?

It currently passes because the underlying .percpu section happens to be
exactly 72 bytes (a multiple of 8). If the variables in the BPF program were
changed such that the section size was 76 bytes, the roundup would yield 80,
which wouldn't match map->def.value_size and would cause
bpf_map__lookup_elem() to fail with -EINVAL.

Could we use the un-rounded size here instead?

> +		if (!ASSERT_OK(err, "bpf_map__lookup_elem"))
> +			goto out;
> +
> +		ASSERT_EQ(data->data, 1, "data->data");

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608145113.6585=
7-1-leon.hwang@linux.dev?part=3D6
