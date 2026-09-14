Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007A748124F
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397109; cv=none; b=apEZVyVAyDRYQciW5KH9yqgqLSJ5Lnc6et35ATIFhXd1YFeR3Oo2chi/TmGW70veD4k+XX3yFnU7OJsEyXR+7nKHUi435DIwTSEKuPYsDMEZd6GHV9UGSnIxHikD5JSmYrcNKv/8Jo5nm1trHkfs+0p9uvfJ1TMW2awTOHl6+/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397109; c=relaxed/simple;
	bh=G+4RrUV9vsVqrZboFsfWJdDx/Y+HcTXZ6oX9WV3//kE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dqE9EMivn7fL2jxO83vAvKuzV5uB9F9aWUivfHo3qMRrsx5vc/oQagDCz+7UyGHn70VDOTch2Oixo183eN6VM9Djp67Zx23JwFnET/JFYfDlQLe8EZuITvBc7KOffGqeyLzT6HSeEZpHwGmVIwuOduMaSWWjnsq86snRsxzBTC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJY3CNJa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJY3CNJa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30D91F000FF;
	Mon, 14 Sep 2026 14:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789397107;
	bh=PPfPtohffB0BEY+i9eAYZLoH3dV7uBDaEadKYp32e/c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jJY3CNJaHdGGBkpHEyD4Vtqv1tFwqfxM60mvWSbnRRluUbdCPb+Q9ovkBL9PZnTw2
	 hJ5h7nDr3ZpXqpuK8fFVl2fOfHmNMJb+njT/u6lx81jyn5ZxM9nGt2FJy3NiXDJr8s
	 z+nCkaRpYRACttIahdsA2dQNmZuVQnBrplV7OZFOwIWB4/3tKrHYI0s+Vsc5fOGYxG
	 ALksMcii2ag7uSF6Ni+qG6rF9CZ4F1EYaZuk/UxV91/k6TXhyX05QawCj9T8N3y6U3
	 uCmXASvemuVcqcsAPbMmu2GIOq9gTWXi57P0ljBgz89cQS3iRCwKGqaJHvTPQSHyrG
	 eeD6gqLGilFKA==
Content-Type: multipart/mixed; boundary="===============7213034664090261334=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ed06a28cd2a5d73d8b5c9b35401c0e85cf2d350d9a29f1d5d33759dcf0cb33a1@mail.kernel.org>
In-Reply-To: <20260914131701.2529725-8-memxor@gmail.com>
References: <20260914131701.2529725-8-memxor@gmail.com>
Subject: Re: [PATCH bpf v3 7/7] selftests/bpf: Check callback map value lock identity
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,npc@anthropic.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 14 Sep 2026 14:45:06 +0000 (UTC)

--===============7213034664090261334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/cb_refs.c b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
> index 78566b817fd70..490e15e7126d9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cb_refs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cb_refs.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/spin_lock.c b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
> index 5c3579438427d..d49f52a8f8223 100644
> --- a/tools/testing/selftests/bpf/prog_tests/spin_lock.c
> +++ b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
> @@ -10,8 +10,8 @@ static char log_buf[1024 * 1024];
>
>  static struct {
>  	const char *prog_name;
> -	const char *err_msg;
> -} spin_lock_fail_tests[] = {
> +	const char *err_msg; /* NULL if loading should succeed. */
> +} spin_lock_tests[] = {

[ ... ]

> @@ -54,6 +54,22 @@ static struct {
>  	{ "lock_global_sleepable_helper_subprog", "global function calls are not allowed while holding a lock" },
>  	{ "lock_global_sleepable_kfunc_subprog", "global function calls are not allowed while holding a lock" },
>  	{ "lock_global_sleepable_subprog_indirect", "global function calls are not allowed while holding a lock" },
> +	{ "callback_value_lock_identity", "bpf_spin_unlock of different lock" },
> +	{ "callback_inner_map_value_lock_identity", "bpf_spin_unlock of different lock" },
> +	{ "callback_value_lock_identity_same", NULL },
> +	{ "callback_single_value_lock_identity_same", NULL },
> +	{ "lock_id_timer_preserve",
> +	  "R1=map_value(id=[1-9][0-9]*,map=async_lock_map,[^\n]*\n"
> +	  "[0-9]\\+: (85) call bpf_this_cpu_ptr#154\n"
> +	  "R1 type=map_value expected=percpu_ptr_" },
> +	{ "lock_id_wq_preserve",
> +	  "R1=map_value(id=[1-9][0-9]*,map=async_lock_map,[^\n]*\n"
> +	  "[0-9]\\+: (85) call bpf_this_cpu_ptr#154\n"
> +	  "R1 type=map_value expected=percpu_ptr_" },
> +	{ "lock_id_task_work_preserve",
> +	  "R1=map_value(id=[1-9][0-9]*,map=async_lock_map,[^\n]*\n"
> +	  "[0-9]\\+: (85) call bpf_this_cpu_ptr#154\n"
> +	  "R1 type=map_value expected=percpu_ptr_" },
>  };

This isn't a bug, but could the three-line regex pattern for the async
lock tests be extracted into a shared define? The three entries repeat
the same literal character-for-character.

> @@ -74,7 +90,7 @@ static int match_regex(const char *pattern, const char *string)
>  	return rc == 0 ? 1 : 0;
>  }
>
> -static void test_spin_lock_fail_prog(const char *prog_name, const char *err_msg)
> +static void test_spin_lock_prog(const char *prog_name, const char *err_msg)
>  {

[ ... ]

> @@ -94,6 +110,10 @@ static void test_spin_lock_fail_prog(const char *prog_name, const char *err_msg)
>  	bpf_program__set_autoload(prog, true);
>
>  	ret = test_spin_lock_fail__load(skel);
> +	if (!err_msg) {
> +		ASSERT_OK(ret, "test_spin_lock_fail__load");
> +		goto end;
> +	}
>  	if (!ASSERT_ERR(ret, "test_spin_lock_fail__load must fail"))
>  		goto end;

This isn't a bug, but the table and helper were renamed from _fail to
accommodate success cases, while the skeleton calls, assertion tags,
and BPF object filename all keep the _fail naming. Is the partial
migration intentional?

> @@ -166,10 +186,9 @@ void test_spin_lock(void)
>
>  	test_spin_lock_success();
>
> -	for (i = 0; i < ARRAY_SIZE(spin_lock_fail_tests); i++) {
> -		if (!test__start_subtest(spin_lock_fail_tests[i].prog_name))
> +	for (i = 0; i < ARRAY_SIZE(spin_lock_tests); i++) {
> +		if (!test__start_subtest(spin_lock_tests[i].prog_name))
>  			continue;
> -		test_spin_lock_fail_prog(spin_lock_fail_tests[i].prog_name,
> -					 spin_lock_fail_tests[i].err_msg);
> +		test_spin_lock_prog(spin_lock_tests[i].prog_name, spin_lock_tests[i].err_msg);
>  	}
>  }

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34849913056
--===============7213034664090261334==--
