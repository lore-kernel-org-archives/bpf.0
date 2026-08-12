Received: from mta1.migadu.com (out-205.mta1.migadu.com [95.215.58.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA8C3A63EF
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 20:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786567798; cv=none; b=fvBeZzuA0nd6Z7w38CinSvoK5uIJnrKEaL2ZFbqdGs/kV0iaAxYW1LeowkQPeaSkI9YKgNOSkwbHqG4ujzLBETP7DMG6qSIyx3RLPm1q6XV7/dKJaF2lq4WmtwMX0IsOvwyafpq/a5k2pGb6Kclp1707NxXqqf9Y0aUXx5xkO84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786567798; c=relaxed/simple;
	bh=d8nZt6A5s/fYGm20xQB554z510voRJck0TpQNf8KGDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dKY10u/nR8cJemi9T/LGUQQYtYSaHBiGj/XBXBVLLglEwLi/uueNvH2gyXGYBzP29KH0PhbXH4bkaRKqszYUUFpiiYtuwfcUzgK7t0JIEb8MRuAI/07OyU9M1Put+SM3deXo3swp7R2vhhwgx6HCXRcGXWjBbiZbkl/ERUJdHn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tZnbaoKA; arc=none smtp.client-ip=95.215.58.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tZnbaoKA"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=d8nZt6A5s/fYGm20xQB554z510voRJck0TpQNf8KGDU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786567793; v=1; x=1787172593;
 b=tZnbaoKAd1wm/Oo+JA5pT1zaCaXXuwMHgcekms7eNmJzkEXqss2pT4xZlewQ2CLYvamWBFzB
 glX7hSiXljIeaxkjqCh0NuQQ3qDEjWN+Y7r281DIZ1gBIoJU4AA3RvfdjKIa30jipFX8qG02TbA
 5j3RUALcRS9dyR6ebsVFmOCY=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:cd95)
	by smtp.migadu.com with ESMTPS id da09fec9e21f9d6b;
	Wed, 12 Aug 2026 20:49:53 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <3bf69928-8460-4dd6-a2fa-5d5ff263dc35@linux.dev>
Date: Wed, 12 Aug 2026 13:49:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 10/13] selftests/bpf: Add C tests for 16-byte
 returns in R0:R2
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260811001002.2383554-1-yonghong.song@linux.dev>
 <5a9b7e041b501172e1990cb6b6588be45f508972dfdcf7427d0c5d23db63e20f@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <5a9b7e041b501172e1990cb6b6588be45f508972dfdcf7427d0c5d23db63e20f@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/10/26 6:24 PM, bot+bpf-ci@kernel.org wrote:
>> A register-pair return from a BPF subprogram needs no JIT support, so
>> the remaining subtests run everywhere.
> Can the remaining subtests run everywhere? Looking at the same series,
> kernel/bpf/verifier.c makes a register-pair subprogram return JIT-only.
>
> In check_func_call() for global subprogs:
>
>      nregs = bpf_ret_reg_pair(env, subprog) ? 2 : 1;
>      /* The R0:R2 return convention is only implemented in the JIT ... */
>      if (nregs > 1)
>          env->prog->jit_required = 1;
>
> and in prepare_func_exit() for static subprogs:
>
>      nregs = bpf_ret_reg_pair(env, callee->subprogno) ? 2 : 1;
>      if (nregs > 1)
>          env->prog->jit_required = 1;
>
> Then kernel/bpf/fixups.c rejects such a program outright when the JIT did
> not run:
>
>      #ifndef CONFIG_BPF_JIT_ALWAYS_ON
>          if (prog->jit_required) {
>              verbose(env, "program requires BPF JIT compiler but it is not available\n");
>              return -EINVAL;
>
> So on a kernel built with CONFIG_BPF_JIT=y but with
> net.core.bpf_jit_enable=0, or with no eBPF JIT at all, would
> aggregate_ret_int128_c__open_and_load() fail with -EINVAL?

I missed this case (net.core.bpf_jit_enable=0). Let me add this matrix
for selftest run.

>
> Both kfuncs are restricted to x86_64 and arm64, and the two subtests
> report a skip elsewhere. pahole only BTF-encodes a function whose
> declared arguments sit in the ABI's argument registers, and an
> architecture that returns a value larger than 8 bytes through a hidden
> pointer (sret) shifts every one of them by a register. s390x is such an
> architecture: there pahole drops the function, resolve_btfids leaves the
> kfunc ID at 0, and register_btf_kfunc_id_set() then fails at module init,
> so bpf_testmod does not load at all and every test that needs it fails.
> This is not a property of the compiler -- __SIZEOF_INT128__ is defined by
> gcc on s390x, and a by-value struct return has nothing to do with
> __int128 in the first place -- so the guard is on the architecture.
> prog_tests/tracing_failure.c already restricts a __int128 return the same
> way.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
>> new file mode 100644
>> index 0000000000000..bd18bad17472a
> [ ... ]
>
>> +static void test_int128_c(void)
>> +{
>> +	struct aggregate_ret_int128_c *skel;
>> +
>> +	skel = aggregate_ret_int128_c__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "skel_int128_c_open_load"))
>> +		return;
>> +
>> +	run_subtest("int128_c", skel->progs.aggregate_ret_int128_c_test,
>> +		    skel->rodata->has_reg_pair_ret);
>> +
>> +	aggregate_ret_int128_c__destroy(skel);
>> +}
> Following up on the commit-message question: the four non-kfunc subtests
> (test_int128_c, test_struct_c, test_union_c with five run_subtest calls
> total) gate only on skel->rodata->has_reg_pair_ret, the compiler flag.
>
> Where the kernel has CONFIG_BPF_JIT=y but net.core.bpf_jit_enable=0, or
> no JIT at all, wouldn't aggregate_ret_int128_c__open_and_load() fail with
> -EINVAL because fixups.c rejects prog->jit_required, causing the
> !ASSERT_OK_PTR check to fire? That would be a hard test failure rather
> than a skip, and because it happens before test__start_subtest() the
> subtest wouldn't even register.
>
> The test already has is_jit_enabled() available (declared in
> testing_helpers.h and cached in env.jit_enabled), so folding that into
> the 'supported' argument of run_subtest() would turn these into skips.
>
> test_struct_c() and test_union_c() have the same shape.

Okay, I will check net.core.bpf_jit_enable=0 and env.jit_enabled.
I missed net.core.bpf_jit_enable case.

>
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_union_c.c b/tools/testing/selftests/bpf/progs/aggregate_ret_union_c.c
>> new file mode 100644
>> index 0000000000000..5547fa6cbd495
> A subsystem pattern flags this as potentially concerning: a new selftest
> file added for a narrow variant (union vs struct return) of behavior an
> existing test already covers. The union and struct objects are both added
> in this commit and follow identical scaffolding (same compiler-version
> split, same has_reg_pair_ret flag, same MIX_A/MIX_B constants, a pair
> type, a make_pair() helper, one SEC("tc") program plus stub).
>
> On the kernel side bpf_compute_subprog_ret_regs() keys off
> btf_type_is_struct(), which covers BTF_KIND_UNION and BTF_KIND_STRUCT
> alike, so the verifier path is shared. aggregate_ret_struct_c.c already
> hosts two programs behind one has_reg_pair_ret flag.
>
> Would the union case fit as a third SEC("tc") program in the struct
> object, or does it benefit from being separate? The kfunc object has a
> stated reason to be separate (its load can fail with -EOPNOTSUPP), but
> the union vs struct distinction is less clear.

Okay, I will move union case to struct case. So we just do struct case
collectively (where union cases will be in).

>
>> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> index a6133f7521f34..242d3e2913dc5 100644
>> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> @@ -939,6 +939,34 @@ __bpf_kfunc int bpf_kfunc_call_test5(u8 a, u16 b, u32 c)
>>   	return 0;
>>   }
>>
>> +/*
>> + * A kfunc is only usable where the ABI hands its return value back in
>> + * registers. s390x, for example, returns a by-value struct or union through a
>> + * hidden pointer argument (sret) whatever its size. That pointer shifts every
>> + * declared argument by one register, and pahole, which maps parameters to
>> + * registers positionally, then skips the function with "unexpected register
>> + * usage for parameter". resolve_btfids reports "no BTF func for kfunc" and
>> + * leaves the ID at 0, which makes register_btf_kfunc_id_set() fail at module
>> + * init, so the module does not load at all.
>> + *
>> + * Restrict these kfuncs to the architectures where the return value comes back
>> + * in registers. A kfunc taking no argument has nothing for the sret pointer to
>> + * displace and needs no guard, whatever it returns.
>> + */
>> +#if defined(__x86_64__) || defined(__aarch64__)
>> +__bpf_kfunc __int128 bpf_kfunc_call_test_i128(u64 a, u64 b)
>> +{
>> +	return (__int128)(((unsigned __int128)(a + b) << 64) | (a - b));
>> +}
>> +
>> +__bpf_kfunc struct prog_test_ret_pair bpf_kfunc_call_test_ret_pair(u64 a, u64 b)
>> +{
>> +	struct prog_test_ret_pair r = { .hi = a + b, .lo = a - b };
>> +
>> +	return r;
>> +}
>> +#endif /* __x86_64__ || __aarch64__ */
> The comment states the criterion as "Restrict these kfuncs to the
> architectures where the return value comes back in registers", but the
> guard implements a two-entry allowlist. Does riscv64 also meet this
> criterion?
>
> The LP64 RISC-V ABI returns a 16-byte two-integer aggregate (and an
> __int128) in a0:a1, so nothing displaces the declared u64 arguments and
> pahole would encode the function. In this same series,
> arch/riscv/net/bpf_jit_comp64.c:2114 already opts in:
>
>      bool bpf_jit_supports_kfunc_ret_reg_pair(void)
>      {
>          return true;
>      }
>
> On riscv64 the module does not define these two kfuncs, so
> has_ret_pair_kfuncs() returns false and both kfunc subtests skip. That
> means the one architecture whose R0:R2 kfunc path the series describes as
> untested ("The riscv path is expected to work by the same
> register-mapping reasoning as arm64 but has not been tested") is also the
> one the new coverage silently never reaches.
>
> Either the comment should explain why the allowlist is narrower than the
> stated criterion (e.g. only the arches the pair return has been tested
> on), or __riscv (with a 64-bit pointer-width check if needed) should be
> added so the new subtests actually exercise the riscv JIT path.

Okay, I will skip riscv64 for now.

>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31446101762

