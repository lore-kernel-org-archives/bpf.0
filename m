Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C72A4279FA;
	Thu, 30 Apr 2026 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777555833; cv=none; b=EN/+aRBby96J1v9tuwZcODkpTyc19FnCtREwQFM/MPUggddjGn/ef4+ynPF5xZI+eUB3VojzpHJD3VaB6874cJgAWPhjB3y8EMigwWmVg3gPMPPOk743QQC19YEODnlkdNmDUiiYKC3gyuBeD/RL2FktreBAWD/DbelDhVAPGuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777555833; c=relaxed/simple;
	bh=skooFsp+/4GbOAuwrVnXAE8MeO/sNiwc6B6Hb4tb1cQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=f7jICPU8ceXqwCxxElm6VoQU4df6DbUpiAZBsfj3LHfx4uUUlfJTyDZmylt+n5U8Fosv1zZLg1s+oJmJhP4zGbjYt4xKZWblhyKo4WKzh//ojMSoU+LvV2/aYslbff/3M/E0E3qLSSyzqRsxpEkv3tTzyip4s9jsV4UPL4QPhm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9sdh+DH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9sdh+DH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FD3C2BCB3;
	Thu, 30 Apr 2026 13:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777555832;
	bh=skooFsp+/4GbOAuwrVnXAE8MeO/sNiwc6B6Hb4tb1cQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=m9sdh+DHnSNbP/yyTyMTdPwbWbkw3KJ67bx4FvicVup6RoeIVEL9PW8RDZDK+v0kB
	 a3Q/p3z3ovaVbmtXqgmOFrntlnMvs5cBCawshPu02bQg/xvkKoPz6SWCZNwYnoQEb6
	 lKcN2sCTeQSHPJxhLbWGv20LujYKCgX0Ifas4pc6SGdamEbB+rrKd7MtN9wKJVf9es
	 xsN+Ldf1ZuuhtH5kEUmaLouU546vK8HMG+zIfXXb0xOFcjd8JXJNb/ETvgBZg/vqt4
	 VEWrxtsyEFU93Awz3Ts4Y0zH0mcD8Wvw10OPk55VDnmq0bVKPyom0+ss/jZY8u5PAf
	 Ml+n57nvbfiQg==
Content-Type: multipart/mixed; boundary="===============6049219023370403133=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <deceeca5bb5e141c8ad07c5ed3754c6b2613fa0b99383614f1cfcc31bd09d39c@mail.kernel.org>
In-Reply-To: <20260430-selftests-bpf_misconfig-v10-7-cd302a31af16@suse.com>
References: <20260430-selftests-bpf_misconfig-v10-7-cd302a31af16@suse.com>
Subject: Re: [PATCH bpf-next v10 07/11] selftests/bpf: Skip tests whose objects were not built
From: bot+bpf-ci@kernel.org
To: rbm@suse.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,llvm@lists.linux.dev,alan.maguire@oracle.com,rbm@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 30 Apr 2026 13:30:28 +0000 (UTC)

--===============6049219023370403133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index cc14b13e23fe..7ba82974ee78 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c

[ ... ]

> @@ -2046,15 +2069,20 @@ int main(int argc, char **argv)
>  		struct prog_test_def *test = &prog_test_defs[i];
>
>  		test->test_num = i + 1;
> -		test->should_run = should_run(&env.test_selector,
> -					      test->test_num, test->test_name);
> +		test->selected = should_run(&env.test_selector,
> +					    test->test_num, test->test_name);
> +		test->should_run = test->selected;
>
> -		if ((test->run_test == NULL && test->run_serial_test == NULL) ||
> -		    (test->run_test != NULL && test->run_serial_test != NULL)) {
> +		if (test->run_test && test->run_serial_test) {
>  			fprintf(stderr, "Test %d:%s must have either test_%s() or serial_test_%sl() defined.\n",
>  				test->test_num, test->test_name, test->test_name, test->test_name);
>  			exit(EXIT_ERR_SETUP_INFRA);
>  		}
> +		if (!test->run_test && !test->run_serial_test) {
> +			test->not_built = true;
> +			test->should_run = false;
> +			continue;
> +		}
>  		if (test->should_run)
>  			test->should_tmon = should_tmon(&env.tmon_selector, test->test_name);
>  	}
> @@ -2106,9 +2134,18 @@ int main(int argc, char **argv)
>
>  	for (i = 0; i < prog_test_cnt; i++) {
>  		struct prog_test_def *test = &prog_test_defs[i];
> +		struct test_state *state = &test_states[i];
>
> -		if (!test->should_run)
> +		if (!test->should_run) {
> +			if (test->not_built && test->selected &&
> +			    !env.get_test_cnt && !env.list_test_names) {
> +				state->tested = true;
> +				state->skip_cnt = 1;
> +				env.not_built_cnt++;
> +				print_test_result(test, state);
> +			}
>  			continue;
> +		}

When test->should_run is false (which it is for unbuilt tests due to the
code above setting test->should_run = false), the continue statement skips
the env.get_test_cnt and env.list_test_names blocks that follow.

Won't this completely omit unbuilt tests from the output of --list (-l) and
--count modes? The code only prints unbuilt tests when !env.get_test_cnt &&
!env.list_test_names is true.

If CI systems use test_progs -l to discover and distribute tests across
parallel jobs, they won't be aware of unbuilt tests. Could this undermine
the stated goal of keeping unbuilt tests visible in CI results?

Reference: sashiko-bot raised this concern in v10 discussion at
https://lore.kernel.org/bpf/20260430131344.B40DDC2BCB3@smtp.kernel.org/

>
>  		if (env.get_test_cnt) {
>  			env.succ_cnt++;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25167006036
--===============6049219023370403133==--
