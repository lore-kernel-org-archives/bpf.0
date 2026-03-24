Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E372C3DD506
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 09:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774343296; cv=none; b=pvr53cqPw8ncUTVLPOiM+10hNu2jJq0fVuNT2O9QHKY+ksUow8ck63e7hZGIN0ft5fNpjsUl7I+Vw3UUHpZ1dhuxItPXLg7uk/bbDcloK4eUrV+gZdEogRufDcFLyHXH8uDvRJoLn7lqJOV1XRgrwY/PtpqjpcynUoavFccluqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774343296; c=relaxed/simple;
	bh=e+gA50E2IBb9u8S3bLxNlVFF+W6SP0VGja3mMkQZ1yk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kI6Fy8smI8VhZgzedI+JlJfSWuyad05vFY2kTt/jq8YxbCK9bpuFuLaZ0+Pwnhj9nqP2LBMcCGsnWECLOeu5NtsAk+5amG3tGlVcfZnhjQKagJiFp/rR2CDcmsWxaz9jvEUGTQhApEapP2TowyxjYat0sFyge5hoFcISeADbof0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkDQu2Dc; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkDQu2Dc"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-486ff201041so30974365e9.1
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 02:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774343293; x=1774948093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tOIaXalNJRsxZ2Q3yvQOO8yVa019WmjP8IC81VGJS5k=;
        b=gkDQu2Dcd2KtlJNRRb1lVV8BgyGkFZr6aY0pFNTe26jT+FCHp9iKNiKyS3so3jS7DI
         sjlT01maN3RuLs862lnLZR65f9p9737Pv0uoRQY8szQzXG+Z6AoWdhDhP/6+Bq646lM+
         xtWh5HwednEgEJEZPyI9jnXtgAFqsFecdaLD7xKnACTpMvQA6nlgXtdsEms9jUzw9S8q
         rgFmA7/oz1QJrJDiZlqhn8lMAMIhDkrBsPIxIEPnByty01i7DPyAK29ccUfURiIqYyTo
         M+xtmIiieBmR9+8r44BzL7RKJRekP1FKHwTBxdBxWqJekhiq74d48M+VnoX4yVHB3oi0
         daIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774343293; x=1774948093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOIaXalNJRsxZ2Q3yvQOO8yVa019WmjP8IC81VGJS5k=;
        b=TkDjL/pKV4ZyniCtphcpU5yiS0dq6hxTFKc9LcdYzms4dB17zdsFPfoMOTGGY3CKlS
         xaj6f+7ZkANQy0Co4Qm8OxtH8Nv/PnbC/TjUMY1G9mZ5K4Vxtiy3LtKN7RQedg5Cg3VN
         h8tTXHRWF0NawVo8kGu7mrIoCKGP2Pzf2puDjZzdf6ofLvoxHMhh5/HZmTBubI6aIZAH
         KQqCOUwnyKDOSxDsbIlN+0pVGEDoUt7uAgFFGJmCtlhS/mhxaI9A8Jo1Pt9UqPWcd8Zd
         EsQPOzL1BGQXYeq68FylvgtLe0pss6e06Z0ZGU2owIFkMaWvOjpk1YAgAIb3CU4YyrgP
         WcIQ==
X-Gm-Message-State: AOJu0YwdDcZ6f/lvWsYTRvZH07jgV5HytNvog1xHMBg4O+fVdAHROMsp
	a9qUFOmDoYzkfkk2zqgQquZIgBCGiFzrEAtUNsMvfawNgSavXYdvXtC4TtytOCXZ0Gk=
X-Gm-Gg: ATEYQzw3wd1HNm50YE0co7sc/8oA1sUdvXijlUp/rNbhCieijME4B41h112yAbGPq6B
	N345gDmcgNPUD4cGFYtP8JjDs1l1QnUKWft4X8Gf6jUt35wF01jv1XOWMft8vW11xALsvDY1GAG
	w6Tu8AsPv5WdN7Ma3RRnyfKT5+q4246P1MlprE22Je0Mgnhtck/q4oarGQex7lBlGAbfPsZds7I
	81KxHs6E+o2Bh0J2CkvmAw5rK5quu6ztSuqDTnyniPcMosqotmjqUhuiN5lE4SajqxgklQzuEvB
	6aIpQUeWEQqpk5rQBMzsw+X92TATQ+IGpJvUXsSsSHLdHNW+0BflG8HF5kh1mEUvJUswq0bV0KS
	NsRlMsRWpe8/fCObin14eC/HicRdWW4PwxniDGKQNT1SdVaJ4okMXvhIclUTpxkEA0PomqOuq
X-Received: by 2002:a05:600c:548e:b0:47e:e2ec:9947 with SMTP id 5b1f17b1804b1-486ff029336mr206230835e9.33.1774343293046;
        Tue, 24 Mar 2026 02:08:13 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae37dsm37201900f8f.2.2026.03.24.02.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 02:08:12 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 24 Mar 2026 10:08:10 +0100
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	shuah@kernel.org, paul.chaignon@gmail.com,
	mykyta.yatsenko5@gmail.com, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] selftests/bpf: move trampoline_count to dedicated
 bpf_testmod target
Message-ID: <acJUehe8C0Sv1TmV@krava>
References: <20260324044949.869801-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324044949.869801-1-sun.jian.kdev@gmail.com>

On Tue, Mar 24, 2026 at 12:49:49PM +0800, Sun Jian wrote:
> trampoline_count fills all trampoline attachment slots for a single
> target function and verifies that one extra attach fails with -E2BIG.
> 
> It currently targets bpf_modify_return_test, which is also used by
> other selftests such as modify_return, get_func_ip_test, and
> get_func_args_test. When such tests run in parallel, they can contend
> for the same per-function trampoline quota and cause unexpected attach
> failures. This issue is currently masked by harness serialization.
> 
> Move trampoline_count to a dedicated bpf_testmod target and register it
> for fmod_ret attachment. Also route the final trigger through
> trigger_module_test_read(), so the execution path exercises the same
> dedicated target.
> 
> This keeps the test semantics unchanged while isolating it from other
> selftests, so it no longer needs to run in serial mode. Remove the
> TODO comment as well.
> 
> Tested:
>   ./test_progs -t trampoline_count -vv
>   ./test_progs -j$(nproc) -t trampoline_count -vv
>   ./test_progs -j$(nproc) -t \
>     trampoline_count,modify_return,get_func_ip_test,get_func_args_test -vv
>   20 runs of:
>     ./test_progs -j$(nproc) -t \
>       trampoline_count,modify_return,get_func_ip_test,get_func_args_test
> 
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
> 
> Link: https://lore.kernel.org/bpf/20260320074150.628094-1-sun.jian.kdev@gmail.com/
> 
> v4:
> - simplify the dedicated trampoline_count target and its trigger path
> - simplify the associated fentry/fmod_ret/fexit test program signatures
> - reduce the final trigger to a plain ASSERT_OK()
> - drop Suggested-by per Jiri
> 
> v3:
> - route the final trigger through trigger_module_test_read() and make
>   bpf_testmod_test_read() call the dedicated trampoline_count target
> 
> v2:
> - rewrite the subject to describe the change
> - resend with the correct patch content
> 
>  .../bpf/prog_tests/trampoline_count.c          | 17 +++--------------
>  .../bpf/progs/test_trampoline_count.c          | 12 ++++++------
>  .../selftests/bpf/test_kmods/bpf_testmod.c     | 18 ++++++++++++++++++
>  3 files changed, 27 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
> index 6cd7349d4a2b..7321850db75f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
> +++ b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
> @@ -30,16 +30,14 @@ static struct bpf_program *load_prog(char *file, char *name, struct inst *inst)
>  	return prog;
>  }
>  
> -/* TODO: use different target function to run in concurrent mode */
> -void serial_test_trampoline_count(void)
> +void test_trampoline_count(void)
>  {
>  	char *file = "test_trampoline_count.bpf.o";
>  	char *const progs[] = { "fentry_test", "fmod_ret_test", "fexit_test" };
> -	int bpf_max_tramp_links, err, i, prog_fd;
> +	int bpf_max_tramp_links, i;
>  	struct bpf_program *prog;
>  	struct bpf_link *link;
>  	struct inst *inst;
> -	LIBBPF_OPTS(bpf_test_run_opts, opts);
>  
>  	bpf_max_tramp_links = get_bpf_max_tramp_links();
>  	if (!ASSERT_GE(bpf_max_tramp_links, 1, "bpf_max_tramp_links"))
> @@ -80,16 +78,7 @@ void serial_test_trampoline_count(void)
>  		goto cleanup;
>  
>  	/* and finally execute the probe */
> -	prog_fd = bpf_program__fd(prog);
> -	if (!ASSERT_GE(prog_fd, 0, "bpf_program__fd"))
> -		goto cleanup;
> -
> -	err = bpf_prog_test_run_opts(prog_fd, &opts);
> -	if (!ASSERT_OK(err, "bpf_prog_test_run_opts"))
> -		goto cleanup;
> -
> -	ASSERT_EQ(opts.retval & 0xffff, 33, "bpf_modify_return_test.result");
> -	ASSERT_EQ(opts.retval >> 16, 2, "bpf_modify_return_test.side_effect");
> +	ASSERT_OK(trigger_module_test_read(256), "trigger_module_test_read");
>  
>  cleanup:
>  	for (; i >= 0; i--) {
> diff --git a/tools/testing/selftests/bpf/progs/test_trampoline_count.c b/tools/testing/selftests/bpf/progs/test_trampoline_count.c
> index 7765720da7d5..02f52806b1b2 100644
> --- a/tools/testing/selftests/bpf/progs/test_trampoline_count.c
> +++ b/tools/testing/selftests/bpf/progs/test_trampoline_count.c
> @@ -3,20 +3,20 @@
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>  
> -SEC("fentry/bpf_modify_return_test")
> -int BPF_PROG(fentry_test, int a, int *b)
> +SEC("fentry/bpf_testmod_trampoline_count_test")
> +int BPF_PROG(fentry_test)
>  {
>  	return 0;
>  }
>  
> -SEC("fmod_ret/bpf_modify_return_test")
> -int BPF_PROG(fmod_ret_test, int a, int *b, int ret)
> +SEC("fmod_ret/bpf_testmod_trampoline_count_test")
> +int BPF_PROG(fmod_ret_test, int ret)
>  {
>  	return 0;
>  }
>  
> -SEC("fexit/bpf_modify_return_test")
> -int BPF_PROG(fexit_test, int a, int *b, int ret)
> +SEC("fexit/bpf_testmod_trampoline_count_test")
> +int BPF_PROG(fexit_test, int ret)
>  {
>  	return 0;
>  }
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index e62c6b78657f..9caf9ffa1bb0 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -470,6 +470,11 @@ noinline void bpf_testmod_stacktrace_test_1(void)
>  
>  int bpf_testmod_fentry_ok;
>  
> +noinline int bpf_testmod_trampoline_count_test(void)
> +{
> +	return 0;
> +}
> +
>  noinline ssize_t
>  bpf_testmod_test_read(struct file *file, struct kobject *kobj,
>  		      const struct bin_attribute *bin_attr,
> @@ -548,6 +553,8 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
>  			21, 22, 23, 24, 25, 26) != 231)
>  		goto out;
>  
> +	bpf_testmod_trampoline_count_test();
> +
>  	bpf_testmod_stacktrace_test_1();
>  
>  	bpf_testmod_fentry_ok = 1;
> @@ -1843,6 +1850,16 @@ struct bpf_struct_ops testmod_multi_st_ops = {
>  
>  extern int bpf_fentry_test1(int a);
>  
> +BTF_KFUNCS_START(bpf_testmod_trampoline_count_ids)
> +BTF_ID_FLAGS(func, bpf_testmod_trampoline_count_test)
> +BTF_KFUNCS_END(bpf_testmod_trampoline_count_ids)
> +
> +static const struct
> +btf_kfunc_id_set bpf_testmod_trampoline_count_fmodret_set = {
> +	.owner = THIS_MODULE,
> +	.set = &bpf_testmod_trampoline_count_ids,
> +};
> +
>  static int bpf_testmod_init(void)
>  {
>  	const struct btf_id_dtor_kfunc bpf_testmod_dtors[] = {
> @@ -1859,6 +1876,7 @@ static int bpf_testmod_init(void)
>  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_testmod_kfunc_set);
>  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_testmod_kfunc_set);
>  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_testmod_kfunc_set);
> +	ret = ret ?: register_btf_fmodret_id_set(&bpf_testmod_trampoline_count_fmodret_set);
>  	ret = ret ?: register_bpf_struct_ops(&bpf_bpf_testmod_ops, bpf_testmod_ops);
>  	ret = ret ?: register_bpf_struct_ops(&bpf_testmod_ops2, bpf_testmod_ops2);
>  	ret = ret ?: register_bpf_struct_ops(&bpf_testmod_ops3, bpf_testmod_ops3);
> 
> base-commit: 8a30aeb0d1b4e4aaf7f7bae72f20f2ae75385ccb
> -- 
> 2.43.0
> 
