Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504647;
	b=PjCi7AFFWeyVgsbYrEfTJ2QsQWZrLvGKLM2TTHcUVcJ3ZhbLFEbRr/3HvgnwvkDixQpl
	 pYFqpv2GoBiGJrCKR5OLlBUHOc/4FoOW3wju7Am8TABOQXqV3f5LUB3WzOyUxvJ7ujHLa
	 T+lTZlELA55xAZtKUfbuECI8GTKUlMdWrFH0cS4CYxRNrn1rxF6DYpGqCNgxiYLRlc2HS
	 amfojGymsI6lAIZmaVorO7yXqxZRLDPFKJlJzmQp3wNBl40AkQ6CGjpECuPkgAhu5Byfk
	 n3+dAOyaKHRwQuwxineBRQu+AAr7/eIvr06HXmo8d1rYxC8b/ZGpWm0kXKmvmXRREAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504647;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=a/Me5Y6HF/VtoKt97MMtAjJt+DhVNNIv+fWtI37yBSU=;
	b=5n+tC7xze1Mkcz898JS1l93lSHskEymHvza4TfieKCnoBCe0yNIz6fuCfBTE3VJA6trF
	 2/GvzroqeH8ssRj8zdRQpS4djtT19WCwnO9BYyR7sT3shHBFchrshL8lr89E9g4rZIkpY
	 2M1bP1DDn9EW4F5LHCYL56evAwCHkNdlxcMYh6+xzmfqushBGfQ+jr77D2ENmKTEj7g4e
	 uplYe+hP4m2FWHX4ElUDp/LFXHtP7GmNI9+glhmCkyhEk3J1x5hWw7JY808L8oBEdgkpa
	 7zwyxSv8aq2r981KNpDU4GqTBp4ZihhRGz9oblxEiXNxmNLm23QHEGPUf5kean5TWXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=okYMfWml;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A55D606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=okYMfWml
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2C41F000C4;
	Tue, 20 Oct 2026 13:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792504646;
	bh=a/Me5Y6HF/VtoKt97MMtAjJt+DhVNNIv+fWtI37yBSU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=okYMfWml2vHYVCL0z1ks6GbSm/wSmhtDidTgX9ij3sTVVYaV63EOqEfFY7cBm+HgC
	 cwF4bNsCs9M6oSj64wuYTv1InCaBokXn7iupmYttCk6EhAhG41XJhD97QNDw1u7PO9
	 IZHIGPfcBoEfZqwC2NCHoz1FvEolHPo7z6uItsIiC4W4jQhYp7wLnsGh7lp5wRlacQ
	 3JzeUCHWrgCItnH/JMv5q3bQFSYFItZvUIPXuHsMdnjIQ5fWjEu4CzdyYIlTEz7TEx
	 iXY2m5FTyjlXTbCGvzN4b4yeEFaA/SZnMUZuFGEGiwvc9KUWWYaZRvbV3rjIi+kErJ
	 E8m1KbvmTslkw==
Message-ID: <sashiko-outbox-179062@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 15/16] selftests/bpf: Add test for mixed arena
 percpu object
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>, bpf@vger.kernel.org
In-Reply-To: <a36e6a008493b367af5d9c338cf707fadfc8a632.1792503001.git.xukuohai@huawei.com>
References: <cover.1792503001.git.xukuohai@huawei.com>
 <a36e6a008493b367af5d9c338cf707fadfc8a632.1792503001.git.xukuohai@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 13:57:26 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/bpf: unreachable err > 0 branch and silent test bypass=
 in test_arena_percpu_mixed()
--

commit df1443ad7be8c02167841960847603cc924444f9
Author: Xu Kuohai <xukuohai@huawei.com>

selftests/bpf: Add test for mixed arena percpu object

This commit adds a selftest subtest and BPF program to exercise mixing
per-CPU arena variables and a regular global arena variable within the
same BPF arena map.

> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_percpu.c b/tool=
s/testing/selftests/bpf/prog_tests/arena_percpu.c
> index 27d4721c7ae9a..b450be5f2b36c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/arena_percpu.c
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_percpu.c

[ ... ]

> @@ -137,6 +138,99 @@ static void test_arena_percpu_only(void)
>  	restore_affinity();
>  }
> =20
> +static void test_arena_percpu_mixed(void)
> +{
> +	struct arena_percpu_mixed *skel;
> +	struct bpf_map *arena, *bss_map;
> +	bool *possible =3D NULL, *online =3D NULL, *written =3D NULL;
> +	int possible_cpus, online_cpus, nr_written =3D 0, cpu, err;

[ ... ]

> +	for (cpu =3D 0; cpu < online_cpus; cpu++) {
> +		if (!online[cpu] || cpu >=3D CPU_SETSIZE || !CPU_ISSET(cpu, &affinity_=
save))
> +			continue;
> +
> +		err =3D run_on_cpu(cpu, skel->progs.arena_percpu_mixed_write, "write");
> +		if (err < 0)
> +			goto out;
> +		if (err > 0)
> +			continue;
> +		written[cpu] =3D true;
> +		nr_written++;
> +	}
> +	if (!ASSERT_GE(nr_written, 1, "cpus_exercised"))
> +		goto out;

[Severity: Medium]
Can the err > 0 branch ever be reached here? Looking at run_on_cpu() in
tools/testing/selftests/bpf/prog_tests/arena_percpu.c:

static int run_on_cpu(int cpu, struct bpf_program *prog, const char *name)
{
	LIBBPF_OPTS(bpf_test_run_opts, opts);
	int err;

	if (pin_to(cpu))
		return -1;

	err =3D bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);

	if (!ASSERT_OK(err, name))
		return -1;
	if (!ASSERT_OK(opts.retval, name))
		return -1;
	return 0;
}

run_on_cpu() only returns -1 or 0, so the err > 0 check is dead code.

Furthermore, if pin_to(cpu) fails (for example, if a CPU cannot be pinned or
goes offline), run_on_cpu() returns -1 without recording an assertion
failure. In test_arena_percpu_mixed(), that triggers goto out, bypassing
ASSERT_GE(nr_written, 1, "cpus_exercised") and all subsequent arena checks
while allowing the subtest to pass silently.

Was run_on_cpu() intended to return a positive value when pin_to(cpu) fails
so the loop can skip that CPU and still enforce nr_written >=3D 1?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792503001.gi=
t.xukuohai@huawei.com?part=3D15
