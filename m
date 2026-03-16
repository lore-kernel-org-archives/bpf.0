Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F40450F2
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680489; cv=none; b=uxjHMH4m7IA+pcCm46tJOt51lzBKyWVv8fQiD5DiMuQ6sHinZ551wQQpO3rm86luKNfMeGcTn8AFjCLAGGhlzIYuJlTHTqlnmjVJBxd5RO4/DU5+6I5OUhxUidajl3zE1oFo/OdzFRTacnBwUpV9vTp1C65SFOrXEACI6rBfCa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680489; c=relaxed/simple;
	bh=389HUKmaEqYuuzVAGJ+9MDnMNqEtLbY4KqV2k1lMN2g=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bDd3Om7cwrd+1yyiaRwSLqGhx9UROjwOshZW7un5ZeuvEbxRrC5uBMReG3yUMjxA8EhdUqnYF4PambF0jt2mNko82/MxtmK23MJhCDjU/qGvO0kvNzEsrFo9T+3DMufBUEb0Oh7Xl0ub/iaIZcSz+3KH1K0oABsUdYy7BwaQ7Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1D+Ax3r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1D+Ax3r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF88C19421;
	Mon, 16 Mar 2026 17:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773680489;
	bh=389HUKmaEqYuuzVAGJ+9MDnMNqEtLbY4KqV2k1lMN2g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=q1D+Ax3ripefYMhDyO3PuoyciojxdR6/aZM1/NeIIzjQJnR5sLA3502eZhpzj8HGg
	 XdRRlnDfRR52gWY9NA2oNPR53f3tWLUYaNxKxPHGovm/k+b6i6nj1WSXVr62JJ95Ui
	 57nAkreXRRVc2Fqugyowc6gGuQYyP+QfvZMOhAHat2zF64qi8jE0F0p0mCQHVGsu00
	 7QqpfZE7c/ekoQBj5gtEbeixnvQEPirJNOUuD+5N/e3sG2zO0KW4D2pEUvOVzIJX5l
	 rs9Uzw2Xv9CHIYc7/dDYwtXU1CxqTOZMA1NNSvkNpYTYtOLdaa3ATOsiWc7F9/f9Hj
	 KSEMWxkjOrZJw==
Content-Type: multipart/mixed; boundary="===============0903000313604373834=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <65e11260b42493b1261ff79a8d2c408cdbe8a68038bea605e1794f75ff406594@mail.kernel.org>
In-Reply-To: <20260316161225.128011-2-emil@etsalapatis.com>
References: <20260316161225.128011-2-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v6 1/2] bpf: Only enforce 8 frame call stack limit for all-static stacks
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,martin.lau@kernel.org,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,emil@etsalapatis.com,yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 16 Mar 2026 17:01:28 +0000 (UTC)

--===============0903000313604373834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e29f15419fcb..01c18f4268de 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -6854,7 +6854,16 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,

[ ... ]

> -		frame++;
> +		frame = subprog_is_global(env, idx) ? 0 : frame + 1;
>  		if (frame >= MAX_CALL_FRAMES) {
>  			verbose(env, "the call stack of %d frames is too deep !\n",
>  				frame);

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/test_global_func3.c b/tools/testing/selftests/bpf/progs/test_global_func3.c
> index 142b682d3c2f..974fd8c19561 100644
> --- a/tools/testing/selftests/bpf/progs/test_global_func3.c
> +++ b/tools/testing/selftests/bpf/progs/test_global_func3.c

[ ... ]

>  SEC("tc")
> -__failure __msg("the call stack of 8 frames")
> +__failure __msg("the call stack of 9 frames")
>  int global_func3(struct __sk_buff *skb)
>  {
>  	return f8(skb);

Should the expected message here be "the call stack of 8 frames"
rather than 9?

The test has 9 functions total (global_func3 plus f1 through f8),
but only 8 call transitions, and frame starts at 0. Each static
call increments frame by one:

    frame = subprog_is_global(env, idx) ? 0 : frame + 1;
    if (frame >= MAX_CALL_FRAMES) {
        verbose(env, "the call stack of %d frames is too deep !\n",
            frame);

With 8 static calls (global_func3 -> f8 -> f7 -> ... -> f1),
frame reaches 8 which triggers the check since MAX_CALL_FRAMES
is 8. The verifier would print "the call stack of 8 frames is
too deep" and the __msg substring match for "9 frames" would not
match, causing the test to fail.

The old test with global functions also had 8 call transitions
and expected "8 frames", since frame++ produced the same value
of 8 at the limit.

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23154616737
--===============0903000313604373834==--
