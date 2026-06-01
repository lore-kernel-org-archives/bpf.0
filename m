Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC37539A054
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780334254; cv=none; b=Sp7F0IOKaiirRObrAFRCbW5Odane87Spu6OKF/neppgdmZ0pI93j104eaLjBYnbNHGdDZyVntF2MAjtqQL27Km7DDB47jbu7ospz3OLHhmNYfKc6K9N6EKrnBN5AxjVCJyajjAewqCyJUnwRn3Rf5KeC7NCaTPh4wCI0dkPPE5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780334254; c=relaxed/simple;
	bh=bsXrSnauv9ups/4b26R9eK2B15OOE97lVX5vR24WB80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TNqcI8pQt3xWtDPoEJtolTIZkGgfs7kZPTRfFcAv7q+jxFeCpRgE8t2udxmel+NoUgl2852HDioKWm2cqhOskWOVTlPYWgHZ3No/MDRXBNzcNPNS2635hGHC0KWuFRcn51cMtlZKDHyTUq8u7lqM9rC9M128JkxnuIB+V+MZ0AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YrpiJlJD; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YrpiJlJD"
Message-ID: <9cc9ce47-c45e-4878-ad3a-6e6967399ab9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780334241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0nuxZFxrS7HnIeE5D1Dd/DCsh6KOQBz/XuKi60RsdmY=;
	b=YrpiJlJDDMxiuMsrA2nxOLkAuDtecId4n/+BiAE2qXR9KnqFUXKN4g71TYTi9OdkKY1Ysh
	g4uJf4i/7vS47k9+RCO+hbkiTJ/D1nnhrZ4LKkq6VtLWedP6MSU80hdoPFmQzvHKrQu7s/
	woTZVsNKidmYFrW+3O24AfQfozM5ccs=
Date: Mon, 1 Jun 2026 10:17:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add regression test for kfunc
 implicit arg injection with stale register
Content-Language: en-GB
To: chenyuan_fl@163.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 chenyuan@kylinos.cn, daniel@iogearbox.net, eddyz87@gmail.com,
 jolsa@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 memxor@gmail.com, song@kernel.org
References: <20260407080900.551797-1-chenyuan_fl@163.com>
 <20260601064611.807637-1-chenyuan_fl@163.com>
 <20260601064611.807637-3-chenyuan_fl@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260601064611.807637-3-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/31/26 11:46 PM, chenyuan_fl@163.com wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
>
> The preceding patch fixes a bug where the BPF verifier failed to detect
> an implicit struct bpf_prog_aux * argument in a module kfunc, causing
> the kernel to dereference a stale register value as a pointer and crash.
>
> Add a selftest that deliberately contaminates BPF R2 (the register slot
> for the 2nd kfunc argument, which maps to the implicit bpf_prog_aux *)
> with a known magic value 0xDEAD via inline assembly, then calls a
> KF_IMPLICIT_ARGS kfunc that validates whether injection occurred:
>
>    - If the kernel correctly injects env->prog->aux into R2, the kfunc
>      receives a real bpf_prog_aux pointer (≠ 0xDEAD) and returns the
>      caller-supplied marker value.
>
>    - If injection is skipped (the original bug), the kfunc receives the
>      stale 0xDEAD value and returns -EINVAL, which the BPF program
>      detects as a test failure.
>
> The magic value 0xDEAD is chosen with bit 31 clear to avoid BPF ALU64
> sign-extension when used as a 32-bit immediate, ensuring the comparison
> in the kfunc matches the actual register value.  The kfunc is associated
> with a struct_ops map to exercise the exact call path (struct_ops →
> kfunc with KF_IMPLICIT_ARGS → bpf_prog_aux dereference) that triggered
> the original crash.

Not sure whether this patch makes sense or not. The CI has pahole 1.31
so the test will always succeed.

>
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>   .../bpf/prog_tests/test_struct_ops_assoc.c    |  5 +++
>   .../selftests/bpf/progs/struct_ops_assoc.c    | 40 +++++++++++++++++++
>   .../selftests/bpf/test_kmods/bpf_testmod.c    |  9 +++++
>   .../bpf/test_kmods/bpf_testmod_kfunc.h        |  1 +
>   4 files changed, 55 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
> index 461ded722351..123bd2c7a292 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
> @@ -35,6 +35,10 @@ static void test_st_ops_assoc(void)
>   					    skel->maps.st_ops_map_b, NULL);
>   	ASSERT_OK(err, "bpf_program__assoc_struct_ops(sys_enter_prog_b, st_ops_map_b)");
>   
> +	err = bpf_program__assoc_struct_ops(skel->progs.sys_enter_prog_test_aux_inject,
> +					    skel->maps.st_ops_map_a, NULL);
> +	ASSERT_OK(err, "bpf_program__assoc_struct_ops(sys_enter_prog_test_aux_inject, st_ops_map_a)");
> +
>   	/* sys_enter_prog_a already associated with map_a */
>   	err = bpf_program__assoc_struct_ops(skel->progs.sys_enter_prog_a,
>   					    skel->maps.st_ops_map_b, NULL);
> @@ -52,6 +56,7 @@ static void test_st_ops_assoc(void)
>   
>   	ASSERT_EQ(skel->bss->test_err_a, 0, "skel->bss->test_err_a");
>   	ASSERT_EQ(skel->bss->test_err_b, 0, "skel->bss->test_err_b");
> +	ASSERT_EQ(skel->bss->test_err_inject, 0, "skel->bss->test_err_inject");
>   
>   	/* run syscall_prog that calls .test_1 and checks return */
>   	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.syscall_prog_a), NULL);
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_assoc.c b/tools/testing/selftests/bpf/progs/struct_ops_assoc.c
> index 68842e3f936b..dd322d43ff5e 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_assoc.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_assoc.c
> @@ -103,3 +103,43 @@ SEC(".struct_ops.link")
>   struct bpf_testmod_multi_st_ops st_ops_map_b = {
>   	.test_1 = (void *)test_1_b,
>   };
> +
> +/* Test for aux injection with stale register contamination.
> + *
> + * This test reproduces the scenario where the BPF verifier fails to
> + * inject the implicit bpf_prog_aux pointer for kfuncs with
> + * KF_IMPLICIT_ARGS.  The program uses inline assembly to explicitly
> + * set R2 (the register for the 2nd kfunc argument, which maps to
> + * the implicit bpf_prog_aux *) to a known magic value (0xDEAD,
> + * chosen with bit 31 clear to avoid BPF ALU64 sign-extension):
> + *
> + *   asm volatile("r2 = %[magic]" :: [magic] "ri"(0xDEAD) : "r2");
> + *
> + * Then bpf_kfunc_aux_inject_stale() is called.  The kernel verifier
> + * should inject the real bpf_prog_aux into R2, overriding the magic
> + * value.  The kfunc compares aux against 0xDEAD:
> + *
> + *   - aux == 0xDEAD  → kernel failed to inject aux → test fails
> + *   - aux != 0xDEAD  → kernel correctly injected aux → test passes
> + */
> +int test_err_inject;
> +
> +SEC("tp_btf/sys_enter")
> +int BPF_PROG(sys_enter_prog_test_aux_inject, struct pt_regs *regs, long id)
> +{
> +	struct task_struct *task;
> +	int marker = 0x5A5A;
> +	int ret;
> +
> +	task = bpf_get_current_task_btf();
> +	if (!test_pid || task->pid != test_pid)
> +		return 0;
> +
> +	asm volatile("r2 = %[magic]" :: [magic] "ri"(0xDEAD) : "r2");
> +
> +	ret = bpf_kfunc_aux_inject_stale(marker);
> +	if (ret != marker)
> +		test_err_inject++;
> +
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index 0be918fe3021..da95a6de3bbf 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -1316,6 +1316,7 @@ __bpf_kfunc int bpf_kfunc_multi_st_ops_test_1_assoc(struct st_ops_args *args, st
>   __bpf_kfunc int bpf_kfunc_implicit_arg(int a, struct bpf_prog_aux *aux);
>   __bpf_kfunc int bpf_kfunc_implicit_arg_legacy(int a, int b, struct bpf_prog_aux *aux);
>   __bpf_kfunc int bpf_kfunc_implicit_arg_legacy_impl(int a, int b, struct bpf_prog_aux *aux);
> +__bpf_kfunc int bpf_kfunc_aux_inject_stale(int marker, struct bpf_prog_aux *aux);
>   
>   /* hook targets */
>   noinline void bpf_testmod_test_hardirq_fn(void) { barrier(); }
> @@ -1399,6 +1400,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1_assoc, KF_IMPLICIT_ARGS)
>   BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg, KF_IMPLICIT_ARGS)
>   BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg_legacy, KF_IMPLICIT_ARGS)
>   BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg_legacy_impl)
> +BTF_ID_FLAGS(func, bpf_kfunc_aux_inject_stale, KF_IMPLICIT_ARGS)
>   BTF_ID_FLAGS(func, bpf_kfunc_trigger_ctx_check)
>   BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
>   
> @@ -1916,6 +1918,13 @@ int bpf_kfunc_implicit_arg_legacy_impl(int a, int b, struct bpf_prog_aux *aux)
>   	return bpf_kfunc_implicit_arg_legacy(a, b, aux);
>   }
>   
> +int bpf_kfunc_aux_inject_stale(int marker, struct bpf_prog_aux *aux)
> +{
> +	if ((unsigned long)aux == 0xDEAD)
> +		return -EINVAL;
> +	return marker;
> +}
> +
>   static int multi_st_ops_reg(void *kdata, struct bpf_link *link)
>   {
>   	struct bpf_testmod_multi_st_ops *st_ops =
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> index 2edc36b66de9..c18791e96b21 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> @@ -192,6 +192,7 @@ int *bpf_kfunc_ret_rcu_test_nostruct(int rdonly_buf_size) __ksym;
>   #ifndef __KERNEL__
>   extern int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id) __weak __ksym;
>   extern int bpf_kfunc_multi_st_ops_test_1_assoc(struct st_ops_args *args) __weak __ksym;
> +extern int bpf_kfunc_aux_inject_stale(int marker) __weak __ksym;
>   #endif
>   
>   struct prog_test_member *bpf_kfunc_get_default_trusted_ptr_test(void) __ksym;

