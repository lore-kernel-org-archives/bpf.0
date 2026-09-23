Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDD7318EFF;
	Wed, 23 Sep 2026 00:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790124982; cv=none; b=SSK24WImCLaYkX79RLCcgkbRB1t1/In2IU2xpBNEtTxOW+blEGNSExyDcWYW3eKtApsi3YbAVOB+iJUhZR6RnJjO7jfs61Fy8UtJo0rgiJcrKoY+5CDxoDF/XY0JGz2qia/9Zvhgo3L2mNiTsYA57+Fq7QFNIy7vNk9JuQxfprk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790124982; c=relaxed/simple;
	bh=RCu65nTkQnj76zhgyrdUviMiADSeaid5QCzfmZbNP38=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LlsXUedMb1uWvKJBFe+0DAW/n9DnImyzvCbrwBXfegJo9oHTISrXQaFD0QGhS+G9Q9LDiZopRp4SmilCcjmth8gO5J0zQVFYfD+ssXBAlcLIObFb+Ne7pXDxvI+qPpPcU7JK12YRB/K59zUa8E6wwo98j9HCGOWGFFPZzgWcK2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQZdeG8A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQZdeG8A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C301F000FF;
	Wed, 23 Sep 2026 00:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790124980;
	bh=xVe6eZVsM2VaZORoW6oADEFcC35xw7e3lHiorJq7vJs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TQZdeG8ACsA2HZWQZNe957zHdNRBCDH8LEI8lX7RxKdGPPtg3HjuE7AeSjOm2blkU
	 TPMcFSwPCPqVjB1OU28DaJot9R0LYFOyHhzOFbCM5CbxCWw8TCh/I6Sf7InEYDWiuI
	 CVXWotfC7p0yGFcKKBb9e30ax3lAIM+8BjsgriwrYeEZdVrJHXcsk45ZoMp41PianS
	 mOwGCsozufI9DgzrTbRER6BVfa22T0SJTyg5kmtX8cfxiuwgR/PC4yUawfJHz77seR
	 9vLl3mkW61VgOWu8iirFZGBiS0UTqrTOTewttfB6KTN75LlRJ+QZPrmdC4pDT1MwtV
	 34D9oLXKDzw6A==
Content-Type: multipart/mixed; boundary="===============8622471367442830940=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3d31f180b472adb3b215571fa73ba38641cc93a33ea2e8e82413f37957c2d99a@mail.kernel.org>
In-Reply-To: <20260923000801.1764758-3-donggeunyoo.kernel@gmail.com>
References: <20260923000801.1764758-3-donggeunyoo.kernel@gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Test per-cpu initialization of a BPF_F_CPU created element
From: bot+bpf-ci@kernel.org
To: donggeunyoo.kernel@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,leon.hwang@linux.dev,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,donggeunyoo.kernel@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 00:56:18 +0000 (UTC)

--===============8622471367442830940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
> index a72ae0b29f6e..f853f97bb882 100644
> --- a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c

[ ... ]

> @@ -350,6 +350,80 @@ static void test_lru_percpu_hash_cpu_flag(void)
>  	test_percpu_map_cpu_flag(BPF_MAP_TYPE_LRU_PERCPU_HASH);
>  }
>
> +/*
> + * A BPF_F_CPU update that creates an element must zero the value on the other
> + * cpus, rather than leave them holding whatever the recycled element last
> + * contained. max_entries is 1 so the second key can only reuse the element
> + * the first one released.
> + */
> +static void test_percpu_map_cpu_flag_create(enum bpf_map_type map_type, __u32 map_flags)
> +{
> +	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = map_flags);
> +	const u32 stale = 0xDEADC0DE, fresh = 0xC0FFEE;
> +	int nr_cpus, cpu, map_fd, err, key;
> +	u32 value;
> +	u64 flags;
> +
> +	nr_cpus = libbpf_num_possible_cpus();
> +	if (!ASSERT_GT(nr_cpus, 0, "libbpf_num_possible_cpus"))
> +		return;
> +
> +	if (nr_cpus < 2) {
> +		test__skip();
> +		return;
> +	}
> +
> +	map_fd = bpf_map_create(map_type, "cpu_flag_create", sizeof(key), sizeof(value), 1, &opts);
> +	if (!ASSERT_GE(map_fd, 0, "bpf_map_create"))
> +		return;
> +
> +	key = 1;
> +	value = stale;
> +	err = bpf_map_update_elem(map_fd, &key, &value, BPF_F_ALL_CPUS);
> +	if (!ASSERT_OK(err, "bpf_map_update_elem all_cpus"))
> +		goto out;
> +
> +	err = bpf_map_delete_elem(map_fd, &key);
> +	if (!ASSERT_OK(err, "bpf_map_delete_elem"))
> +		goto out;
> +
> +	key = 2;
> +	value = fresh;
> +	flags = BPF_F_CPU;
> +	err = bpf_map_update_elem(map_fd, &key, &value, flags);
> +	if (!ASSERT_OK(err, "bpf_map_update_elem specified cpu"))
> +		goto out;
> +
> +	for (cpu = 0; cpu < nr_cpus; cpu++) {
> +		value = 0;
> +		flags = (u64)cpu << 32 | BPF_F_CPU;
> +		err = bpf_map_lookup_elem_flags(map_fd, &key, &value, flags);
> +		if (!ASSERT_OK(err, "bpf_map_lookup_elem_flags specified cpu"))
> +			goto out;
> +		if (!ASSERT_EQ(value, cpu ? 0 : fresh, "value on specified cpu"))
> +			goto out;
> +	}
> +
> +out:
> +	close(map_fd);
> +}
> +
> +static void test_percpu_hash_cpu_flag_create(void)
> +{
> +	test_percpu_map_cpu_flag_create(BPF_MAP_TYPE_PERCPU_HASH, 0);
> +}
> +
> +static void test_percpu_hash_cpu_flag_create_malloc(void)
> +{
> +	test_percpu_map_cpu_flag_create(BPF_MAP_TYPE_PERCPU_HASH, BPF_F_NO_PREALLOC);
> +}

Can this test give false negatives on the BPF_F_NO_PREALLOC variant?

For preallocated maps, the comment's reasoning holds: max_entries 1 means
there's a single struct htab_elem whose per-cpu area is allocated once and
never freed. When the test deletes key 1, the element goes back to the
freelist with stale 0xDEADC0DE still in its per-cpu area. Creating key 2
gets that same element back, so if pcpu_init_value() is broken, cpu 0 will
see 0xC0FFEE but other CPUs will still see 0xDEADC0DE.

With BPF_F_NO_PREALLOC, the per-cpu area uses bpf_mem_alloc:

kernel/bpf/hashtab.c:htab_elem_free()
    bpf_mem_cache_free(&htab->pcpu_ma, l->ptr_to_pptr)

which does unit_free() and pushes to the *current* CPU's free list. The
subsequent create calls bpf_mem_cache_alloc(), which does unit_alloc() and
pops from whatever CPU the second syscall runs on.

If the thread migrated between the delete and the create, unit_alloc() gets
a prefilled zero object from __alloc_percpu_gfp() rather than the
just-freed stale one, so the test passes even on a broken kernel. Only when
both syscalls run on the same CPU does the LIFO allocator return the stale
object and trigger the assertion.

Should this arm either pin the thread with sched_setaffinity() around the
delete/create pair, or loop over all CPUs to make the result deterministic?

> +
> +static void test_lru_percpu_hash_cpu_flag_create(void)
> +{
> +	/* lru without prealloc is -ENOTSUPP, so there is no malloc variant */
> +	test_percpu_map_cpu_flag_create(BPF_MAP_TYPE_LRU_PERCPU_HASH, 0);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35801690900
--===============8622471367442830940==--
