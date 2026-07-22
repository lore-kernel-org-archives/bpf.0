Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95ED23C503
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 07:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784703949; cv=none; b=KtTBGh+EmUlI1/TKQKQf4Y83aN31yqVDBB2ZRiB32kl6t2gMH8GXfV/A0EcMV0Lscv9u9Zm4UzdOLrDQZpqy7rby7GGTg50vqsIx4kjlkKo6J//6dSUQnMM4Q3LG+o07rWi6rB9bQ8+EedySIT6EUM852A3KFIfiNuFayorlMgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784703949; c=relaxed/simple;
	bh=u2J4QkjjH0P9I52dCCDItU+o2mj/JGnsgpKZk6+mLxw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qdVcwOY04SPukbTWDa8cO9AtQAlF7vXpOt8AMGI1Y0zs0W3bhNZsmUFThAfModRk1ZGvlL65q3WndG8q0Q296iiO6BtjWrSr2Oyt6ofaxJyf4eQbvu3F5mkJA1KvfIWwhjPXbxRYbjT6lxIHHQFCVHphk1iCRzOCynhRT63rSg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKOIii7f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKOIii7f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F5C1F000E9;
	Wed, 22 Jul 2026 07:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784703948;
	bh=zpq/25rKYYhpsmjJbRYxQEMbFogPHNq9epkY2eUJ/Sg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MKOIii7fbCiRnza8/dVKb7x3fdqhRp+dteYB7EYFXhqXRa0QhlWCsMS4I6mIZfWS7
	 FlB/3pBX6YGvvLpG/DxIyN6+d8igD8m8eTt4SE9AgQ6jikJEgixZKtw/TJ+viKRQFI
	 iD6EIucEjgT1RZrtw3LdiU4t+J7TVKJBTc66uE3L+n81H90mX+NR9Nk5rccgWlfQ1A
	 9WlasAkk6K7jeCMgi54IoPKVTEDagQHgUmPJEaPzQgybHN2xy2KTLz2paE/lANWe3+
	 +lg6znZHuooWns86dnQslwDUvNAlJERt99OrMwipJ7+bex7sHAyblxAUchL6wzqvCO
	 ErSolBc5hy9xA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add mmap/munmap benchmark
 for array maps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260722065308.4116186-3-song@kernel.org>
References: <20260722065308.4116186-1-song@kernel.org>
 <20260722065308.4116186-3-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 07:05:47 +0000
Message-Id: <20260722070547.D5F5C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Mutating `env.producer_cnt` inside `validate()` causes a heap bu=
ffer overflow in the core benchmark runner framework.
--

--- Patch [2]: [PATCH bpf-next 2/2] selftests/bpf: Add mmap/munmap benchmar=
k for array maps ---
commit 39f3ece9fcc36c46f5da11156d115c4340de663c
Author: Song Liu <song@kernel.org>

selftests/bpf: Add mmap/munmap benchmark for array maps

Add a benchmark that repeatedly mmap()s and munmap()s an mmap-able BPF
array map (BPF_F_MMAPABLE) from a configurable number of threads. Both
the number of worker threads and the size of the map are tunable via
--nr-threads and --map-size, defaulting to 16 threads and 8MiB.

> diff --git a/tools/testing/selftests/bpf/benchs/bench_arraymap_mmap.c b/t=
ools/testing/selftests/bpf/benchs/bench_arraymap_mmap.c
> new file mode 100644
> index 0000000000000..356d80a85cf01
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/bench_arraymap_mmap.c
> @@ -0,0 +1,146 @@
[ ... ]
> +static void validate(void)
> +{
> +	if (env.consumer_cnt !=3D 0) {
> +		fprintf(stderr, "benchmark doesn't support consumer!\n");
> +		exit(1);
> +	}
> +
> +	/*
> +	 * The number of worker threads is controlled by --nr-threads and
> +	 * drives the framework's producer machinery, so per-producer stats
> +	 * are reported correctly.
> +	 */
> +	env.producer_cnt =3D args.nr_threads;
> +}

[Severity: Medium]
Does mutating env.producer_cnt inside validate() cause a heap buffer overfl=
ow?

The state.producers array is allocated in setup_benchmark() based on the
initial env.producer_cnt:

tools/testing/selftests/bpf/bench.c:setup_benchmark() {
    ...
    state.producers =3D calloc(env.producer_cnt, sizeof(*state.producers));
    ...
}

When this validate callback overwrites env.producer_cnt with args.nr_threads
(which defaults to 16), the core framework later iterates over the new count
when spawning threads:

tools/testing/selftests/bpf/bench.c:setup_benchmark() {
    ...
    for (i =3D 0; i < env.producer_cnt; i++) {
        ...
        err =3D pthread_create(&state.producers[i], NULL,
                             bench->producer_thread, (void *)(long)i);
    ...
}

This will write out of bounds since the array was originally sized for the
unmodified env.producer_cnt.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722065308.4116=
186-1-song@kernel.org?part=3D2
