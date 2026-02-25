Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F8529D29E
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 04:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771993416; cv=none; b=dTnhQ/mmC+4zP5Jvg0N8tTAJ2OhVZcrF2uBMYPsqupB8ese7YqoGtvu9DdpEbIAYH1+K5984mkxY13xayW8yeJEmmKvBROmjd8SXW/akNZa9fl7VgHHCEMkjV6+C0Ws96T7BbglfQArbl6obUCT1APMirb+Qdzz1vbktJDJL+oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771993416; c=relaxed/simple;
	bh=01qj/azznl9SBXcWdRb19S1HHIKHfdjnyQHlLZyKlQM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=orzqXW84DBLF9z1YmnVAdjEectwsJyTMYIuGff/NOcEVuIA9cHtiotsFzc3RwDqJOioxGLnC6HwCVmuJjfaR38u9XSeisF6ko6SmlaehejhtjfFXRc8OvpMPpj/wPCGE3AH4jQbwdfXA+EGbYHf0cEeAYbtSzm7/D0VgkAWtKxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKwf7S3J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKwf7S3J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD87BC116D0;
	Wed, 25 Feb 2026 04:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771993416;
	bh=01qj/azznl9SBXcWdRb19S1HHIKHfdjnyQHlLZyKlQM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=vKwf7S3JNHdpf3zEbQhESZOeBwgYuSsQsFPCKc3WNNGWkKZBoLBNE1Vwqxe61RlN5
	 B5ysXK/SGa2FttutRe84R0ZkALOGQYWSpyD6GOvwNyZ5ozIWuknW5/pOdrfQScqdIT
	 lcPp8t01433G35AKZZ0Qhr0SBzpkPB0898L2+ND8FHo/AMp6FmRYtWTEqr8brPx+XM
	 jfVpu5lcqQVa6e3mI3QlMBoFD9qXGaRCzAme29a507keAWvuPC2tV74/2keG6JY3p6
	 dCO4Qi89mM6Ga9JwOloeKPdRbFcombUuVhwiEDBk8j6OwCR6r5vfd1PK802Q7DAfjs
	 lFqfivq/7UlCw==
Content-Type: multipart/mixed; boundary="===============3351788518922368568=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2409d3ff0161cdc45e6511e078c94df903113df01d3a879d134f6de82397d7e2@mail.kernel.org>
In-Reply-To: <20260225033356.518313-3-emil@etsalapatis.com>
References: <20260225033356.518313-3-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Separate bpf_throw() and bpf_exit() return value validation
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,martin.lau@kernel.org,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 25 Feb 2026 04:23:34 +0000 (UTC)

--===============3351788518922368568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +static int check_throw_return_code(struct bpf_verifier_env *env)
> +{
> +	const char *exit_ctx = "At program exit";
> +	const struct bpf_prog *prog = env->prog;
> +	struct bpf_reg_state *reg = reg_state(env, BPF_REG_1);
> +	struct bpf_retval_range range = retval_range(0, 1);
> +	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
> +	struct bpf_func_state *frame = env->cur_state->frame[0];
> +	const bool is_subprog = frame->subprogno;
> +	bool return_32bit = false;
> +	int err, ret;
> +
> +	/*
> +	 * BPF_LSM_CGROUP LSM programs must not modify the return value of a void program
> +	 * (see the logic in return_retval_range()).
> +	 */
> +	if (prog_type == BPF_PROG_TYPE_LSM && prog->expected_attach_type != BPF_LSM_CGROUP &&
> +			!prog->aux->attach_func_proto->type)
> +		return 0;

Is the comment above this condition a bit misleading?  It describes
why BPF_LSM_CGROUP programs need validation, but the condition
itself handles the opposite case -- non-CGROUP void LSM programs
that skip validation.

A reader would naturally associate the comment with the code that
follows it, and could be confused by the mismatch between the
comment mentioning BPF_LSM_CGROUP and the condition checking
!= BPF_LSM_CGROUP.

In the old check_return_code(), the per-case comment was:

    if (prog->expected_attach_type == BPF_LSM_CGROUP)
        /* See return_retval_range, can be 0 or 0-1 depending on hook. */
        break;

Would something like the following be clearer here?

    /*
     * Non-CGROUP LSM programs with void return type do not need
     * cookie validation.  BPF_LSM_CGROUP programs need validation
     * even for void hooks (see return_retval_range()).
     */

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22381317682

AI-authorship-score: low
AI-authorship-explanation: Standard refactoring suggested by reviewer Eduard Zingerman during patch review, with natural kernel coding patterns and commit message prose consistent with human authorship.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Misleading comment in new check_throw_return_code() describes BPF_LSM_CGROUP behavior before a condition handling non-CGROUP programs, creating readability confusion but no runtime impact.

--===============3351788518922368568==--
