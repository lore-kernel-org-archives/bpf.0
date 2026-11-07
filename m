Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794025196;
	b=RT+Y7Mhu4q0JIZTJixUiOBuFkenUeBK5Yo0JmosRPpjq8FvIj5TCJdhSJoYClFk2KU1U
	 PYni7X/Z1d2JKXixFQC6fOKV9k6Km4DI6FDzraJt68ilZ18gf3WJjluFHn4CuDTZ0JpPN
	 2FwKRwm7kDHfrnhJN5vKOYZRXQrGqM7OI1iZxhacRWumhDxG6ZCAzVrmfnoVtpk9BJWDN
	 L4Zr21HneIOK62dnEFCuXjfR3cnMR1eLeA6X+4G73R3gdo4wrRBVnwiZPHa+lqgLxjSa1
	 gyMZox41CBSQnJA9j6mu9IC/X6KJhOQQK4hzLa2MSu8xRSH0hBRgq/Ii9tHrKXqrgjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025196;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=r2emuFZYn76ouMBTVctNNMnZffDet2VlBi+3myJvBdQ=;
	b=PBnGm0bcX19r+GlUaR+4+QvnTqmvkbYN6HdoeWutyINNN4vIbfbnE6pb6PCXllx+i5yU
	 AqJlwSY3dakLo01ba9l9FmAGFZayzy3AudSZwzI/yca/f/bPgR2NUEyWjFSAs/gbag9rm
	 R90+S+8WpNV2tUCUwSe7mVkzjv5rX8AZk2b7y6sr+uF6FY0X4v74X+0c5liaZ1Nd+nVNy
	 nM+AaCHsWCgvVZKOtVrspuoeZqkmrUqkzLqz8Q1oqUMxZPIKLjm3qKwXpZAUK06LYxZP+
	 BjgwX0Ha3aa0TAKx9dPs6CuVPOWrfT88qRj0jCDmdNmK4dmkNLWgomqig7TpVRu9fcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OshK7qXO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DC8606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 04:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OshK7qXO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0A21F0089F;
	Sat,  7 Nov 2026 04:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794025196;
	bh=r2emuFZYn76ouMBTVctNNMnZffDet2VlBi+3myJvBdQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OshK7qXOXY4HJSaKQ9sKWwFpoYe/Mv8LfKsMoKs0i9le1rqNnsrROHcAlgxxijahm
	 CihcM+XG0yBkOgBVwamJtRROT8g4U5DmYf1XA7kg8LXF+QH616AiAmHRpZB1ArDqKQ
	 uugQDl0FyC19rKH4ekCDF2+aDoHawfrGYpnebDy0SAxQZW3qL2rGwAGadzHW3rq2RY
	 XXgekUps42G1BxKMOyiF6eMfrtolkk3ZPuqY4KNbAwUtMKdiOF4QnMKkgYL4Ji8LQr
	 /T4q9m7+cEzHIpyJHMscTNVYqy/Y1yhXp24K1C6v25oKESGdZtJ40j765Kk9QiSOez
	 WCWL6ilQH4GUA==
Content-Type: multipart/mixed; boundary="===============4122638642188986766=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <b49929a77231e53e0342f6500c25d47f4ba01f9be6d91ed38d7690b40fcdf49c@mail.kernel.org>
In-Reply-To: <20261107033758.1547725-47-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-47-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v4 46/46] selftests/bpf: Test progs without bpf_for(), zero, can_loop and such
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  7 Nov 2026 04:19:55 +0000 (UTC)

--===============4122638642188986766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test progs without bpf_for(), zero, can_loop and such

TL;DR:
- Test issue: plain_c arena tests are not serial, so parallel runs on KASAN
  VMs may bring back OOM kills
- plain_c wakeup_source test may fail instead of skip where the kfuncs are
  missing (e.g. s390)

> diff --git a/tools/testing/selftests/bpf/prog_tests/plain_c.c b/tools/testing/selftests/bpf/prog_tests/plain_c.c
> new file mode 100644
> index 000000000000..b7305118a454
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/plain_c.c

[ ... ]

> +#define RUN(name) RUN_TESTS(plain_c_##name)

[ ... ]

> +void test_plain_c_arena_htab(void) { RUN(arena_htab); }
> +void test_plain_c_arena_htab_asm(void) { RUN(arena_htab_asm); }
> +
> +void test_plain_c_arena_list(void)
> +{
> +	RUN(arena_list);
> +	if (test__start_subtest("run"))
> +		arena_list_add_del();
> +}
> +
> +void test_plain_c_arena_race(void) { RUN(arena_race); }
> +void test_plain_c_arena_strsearch(void) { RUN(arena_strsearch); }

Should these arena tests be serial_test_plain_c_arena_htab(),
serial_test_plain_c_arena_htab_asm(), serial_test_plain_c_arena_list()
and serial_test_plain_c_arena_strsearch(), to match the tests they mirror?

As written they are test_*(), so test_progs runs them in the parallel
phase.  The same applies to test_plain_c_verifier_arena_large() below.

plain_c_arena_htab, plain_c_arena_htab_asm (it includes
plain_c_arena_htab.c), plain_c_arena_list, plain_c_arena_strsearch and
plain_c_verifier_arena_large all declare a BPF_MAP_TYPE_ARENA map.  Each
RUN() subtest opens and loads the object again, so each creates a new
arena, and the "run" subtest of test_plain_c_arena_list() creates one
more.

Every arena reserves a 4GB kernel VM area:

    arena_map_alloc() kernel/bpf/arena.c:
        kern_vm = get_vm_area(KERN_VM_SZ, VM_SPARSE | VM_USERMAP);

and alloc_vmap_area() populates the KASAN shadow for the whole area
right away:

    mm/vmalloc.c:
        ret = kasan_populate_vmalloc(addr, size, gfp_mask);

On a generic KASAN build that is about 512MB of shadow per live arena.

Commit a14f9ba080c1 ("selftests/bpf: Run arena tests serially") renamed
arena_list, arena_htab, arena_strsearch and the other arena_* tests to
serial_test_*() for this reason.  Its message says:

    When several arena tests run in parallel their shadow adds up,
    exhausts the memory of a small CI VM and trips the OOM killer during
    map creation.

It left verifier_arena* parallel only because those share RUN() suites,
which does not apply here, since each plain_c test is its own top-level
function.

The parallel dispatcher in test_progs.c skips only tests that have
run_serial_test:

    if (!test->should_run || test->run_serial_test)
        continue;

So with test_progs -j on a KASAN VM, several workers can be inside
plain_c_arena_* subtests at once, on top of the parallel verifier_arena*
tests.  Can this bring back the OOM kills that a14f9ba080c1 fixed?

[ ... ]

> +void test_plain_c_test_wakeup_source(void) { RUN(test_wakeup_source); }

[ ... ]

> +void test_plain_c_verifier_arena_large(void) { RUN(verifier_arena_large); }

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/plain_c_test_wakeup_source.c b/tools/testing/selftests/bpf/progs/plain_c_test_wakeup_source.c
> new file mode 100644
> index 000000000000..751a7157d7d3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/plain_c_test_wakeup_source.c

[ ... ]

> +struct bpf_ws_lock;
> +struct bpf_ws_lock *bpf_wakeup_sources_read_lock(void) __ksym;
> +void bpf_wakeup_sources_read_unlock(struct bpf_ws_lock *lock) __ksym;
> +void *bpf_wakeup_sources_get_head(void) __ksym;
> +
> +SEC("syscall")
> +__success __retval(0)
> +int iterate_wakeupsources(void *ctx)

A subsystem pattern flags this as potentially concerning: a selftest that
fails, rather than skips, when a feature or config option is missing.

bpf_wakeup_sources_read_lock(), bpf_wakeup_sources_read_unlock() and
bpf_wakeup_sources_get_head() live in drivers/base/power/wakeup.c, which
is built only with CONFIG_PM_SLEEP:

    obj-$(CONFIG_PM_SLEEP) += main.o wakeup.o wakeup_stats.o

PM_SLEEP needs SUSPEND || HIBERNATE_CALLBACKS, and s390 has neither
ARCH_SUSPEND_POSSIBLE nor ARCH_HIBERNATION_POSSIBLE.  The kfunc externs
are not __weak, so on such kernels libbpf fails the object load with
"extern (func ksym) '...': not found in kernel or module BTFs".

The driver is just:

    void test_plain_c_test_wakeup_source(void) { RUN(test_wakeup_source); }

so run_subtest() in test_loader.c takes the
!ASSERT_OK(err, "unexpected_load_failure") path for this __success prog,
and test_progs exits with EXIT_FAILURE.

The original driver, test_wakeup_source() in prog_tests/wakeup_source.c,
handles this case:

    id = btf__find_by_name_kind(btf, "bpf_wakeup_sources_get_head", BTF_KIND_FUNC);
    ...
    if (id < 0) {
        printf("%s:SKIP:bpf_wakeup_sources_get_head kfunc not found in BTF\n", __func__);
        test__skip();
        return;
    }

DENYLIST.s390x has no plain_c_test_wakeup_source entry either.

This is test-only code, and the prog itself matches the original.  Could
the plain C driver keep the same BTF probe and test__skip(), or could the
test be denylisted where the kfuncs cannot exist?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42335829855
--===============4122638642188986766==--
