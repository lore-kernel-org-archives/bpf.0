Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793561913;
	b=u+J3NynxatW8tsQ2dNS2FAQGoH7vVaxDeEhxbhu8HR79v0vurSOBzlgtjb6B8Rr2dRCs
	 uDA2dcxBeficzCocwrnQJ4vCoxjaZSKhju1MKe+gTz2lw3/vL2ZbN9rabqHtwicxVooMx
	 cTcWrAC3YQ/SXKif38h4sN6sV9/SjU4E06sPyq5XWjFVxhQqAO4O71u+qUxBO9ofqpF2E
	 A8LOG/1fwN6DImqbd+Dy1yJhBJj3SvvjG9CKEous/V0ETJEhMZOh9rHZYCG2Pr4uUxhPO
	 CLzlDe/f5ZX2U8EkeFf80uIIcOtqcBrNTpurTs50JLBqN+LVDCXkiq9tyXmicpaDvTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793561913;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=GT6vgwTrYol4454CbnxMyJB6KODx35Q86IflyFsmnUQ=;
	b=Dj4KRjXdACJkZoB+egQtTW1sinjxb2eFLSps+XVewIRZaJkkM85nu9rfpnBhvGCiRLxE
	 AxMkDOCvHWZLwgGplJXJaZqtIXcaQ71hpA+si1xjPBcq0WTknMQq61oSzWyQLRqdREp5d
	 hxHjMlBN9ANHResnbUj3/UExrHsIwB0jbi+reH7JdR33EvVjv/Hq0kRNEFCj1cxVJwUp9
	 baVmUs6+/FgQTjomqqLx/cN++/37JAM12dVDa0bbgGsFZA3UEpP29hcVWYObtehNcwHZh
	 B6RJMF+nwIdcQvlbBBzXkKV/WKi2c8GvHwAxjv7fpCz2dwm4F9rmJgiIB+rHwXaaQHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cTx1HPxM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A48606A32C
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cTx1HPxM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE0F1F00919;
	Sun,  1 Nov 2026 19:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793561912;
	bh=GT6vgwTrYol4454CbnxMyJB6KODx35Q86IflyFsmnUQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cTx1HPxMvbAwEVv3Az2YKhFppwg+miSSgrcKR+dfwJzNqnRO7khpxZV3/eSbPvBwP
	 8eHLnUz4+Wd7n29Ec8O6YJB7BtbRXhHI5Sd1JjmtPjpW50V86jh0BvoAuwg4HsbuSl
	 bIZ/KNJ0nFJHPPMy0On7JMHwHaLiWOChhBPdIUlTeDXom7Vzqld9YkHFUMkWXxA0RV
	 D78W/KzIXdslBV76EPrmzrVKVz5mdyZ9mxNbjCv/mojYMfNzP8+x7P8wRt0AiUGuvU
	 R7I7bhGviSf1aJdTi/lg4PgHJsdLwDLBiC2ufB42En4F9UzwM63TrR4BuFp3eLyBa6
	 +4puE3ifIqaEQ==
Content-Type: multipart/mixed; boundary="===============3748507721609041167=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <f7e09bd07e87dd8aecb42f3c8ff24e7a9f6118d8213de7d7abd2fa2461e8414d@mail.kernel.org>
In-Reply-To: <20261101190535.1454146-8-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-8-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 07/27] selftests/bpf: Test the length and the address of an arena mmap()
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,josef@toxicpanda.com,mason@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  1 Nov 2026 19:38:32 +0000 (UTC)

--===============3748507721609041167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test the length and the address of an arena mmap()

TL;DR: Test issue only: the new arena_mmap selftest may need to be
serial_test_arena_mmap(), like other arena tests, since parallel arena
creation under test_progs -jN can exhaust KASAN shadow memory on small CI VMs.

> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_mmap.c b/tools/testing/selftests/bpf/prog_tests/arena_mmap.c
> new file mode 100644
> index 000000000000..2babc9ecf182
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_mmap.c

[ ... ]

> +static void test_refused(int pages, int flags, int err)
> +{
> +	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_MMAPABLE);
> +	void *area;
> +	int fd;
> +
> +	fd = bpf_map_create(BPF_MAP_TYPE_ARENA, "arena", 0, 0, ARENA_PAGES, &opts);

[ ... ]

> +void test_arena_mmap(void)
> +{
> +	if (test__start_subtest("long"))
> +		test_refused(ARENA_PAGES + 1, 0, E2BIG);
> +	if (test__start_subtest("address_0"))
> +		test_refused(ARENA_PAGES, MAP_FIXED, EINVAL);
> +}

This isn't a regression in the mmap() checks themselves, but should this
entry point be serial_test_arena_mmap() instead of test_arena_mmap()?

Each subtest creates its own BPF_MAP_TYPE_ARENA map through
bpf_map_create(), and arena_map_alloc() reserves KERN_VM_SZ (SZ_4G +
GUARD_SZ) of vmalloc space for every arena with get_vm_area().

The other dedicated arena tests (arena_atomics, arena_direct_value,
arena_htab, arena_list, arena_spin_lock, arena_strsearch, arena_race,
arena_memcg, arena_mem_usage, libarena, libarena_asan) are all defined as
serial_test_*().  Commit a14f9ba080c1 ("selftests/bpf: Run arena tests
serially") made them serial because several arena tests running in parallel
add up their KASAN shadow memory and can exhaust a small CI VM during map
creation.

With the plain test_ prefix, test_arena_mmap() runs in the parallel phase of
test_progs -jN and adds two more arena creations alongside the other arena
tests.  Would renaming it to:

void serial_test_arena_mmap(void)

keep it consistent with the rest of the arena tests?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41340841959
--===============3748507721609041167==--
