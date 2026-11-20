Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163136;
	b=MFqfNXrVnUIMf7hfEYmSL6/qLkVXfeoOcGmXrL7BBZgXQ3M8sOUWoTNe2fD82q3X+YRK
	 WPmlaqWurETQy458lF045Ub/I19qVXdZlMnZPsY43CrMIAX5Nu0QOWi8YC3YA/XDoOEjX
	 TNgwKie9YXxv57adoJtgC1OFM1mDdRpow31QBRRs0wDomYk42CtAvEi7LCQsOiQQ5h06D
	 eSnf9JOSG9EF01JRAODSE77Br0F1dRxzyynE3Tbf4OeFoNMaDkyFGBZAgdTHXi2A2Rj80
	 G1DRQXlwkNytaRc7KJxXHxjie3jpLiPgSUljCfuv0jc6p1ivQGbF2EYUK4+z3B17Fhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163136;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=ePXs9U4K5V0qPQ9gzKVIF3hqDASYxUdnGbfz2OOefm8=;
	b=cNJxDkwQOIrZ7hPmnGNL+X6qkCCX1twEAOHJxRctASZ2Zen+3enTs6g4P8/qB8X8rzTJ
	 aW7PU++7YCFnw5jho4w/atmYCJ6ooLeRcEZv6oBbbZGxFbnQ7ABY2yHe/WdkfmGp08A+Z
	 6hfsEqZ/K8OokZcEYD/rX+tO79hZRC20EApEg+N+c6+NBb1cqyHv/wHcfMlWzzTLUIjKG
	 vWyqRQEEUwb+ywuk+ez7VgXlnZpJmZvanQMceMmDhPCOdpQE8wY8a9igu+xdDRO2TrgBP
	 HbazQRw5w257xizoR62tA/DoVRj1tKmlF6lSBO3A51D4R99MN8T+goJKBlE2Ml46VXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dAskcp8V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326B7606A326
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dAskcp8V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DC81F000C4;
	Fri, 20 Nov 2026 08:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795163136;
	bh=ePXs9U4K5V0qPQ9gzKVIF3hqDASYxUdnGbfz2OOefm8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=dAskcp8VC3mkDSp8FLWsOmwFOrMYE+sbWp9kvOvMHQCJ8gg/POxi7hBx4oGpBvtos
	 PWaH7swVCG03ymND31XYWmxcfe9zl/8SG32WiObqPWCjnbm3xbCiMcBvdRgZ747TYw
	 z4wgcmYS347sxWp9NfjV0zGdtewShdZ5d0+TOa9Zz0RR3qz+HfGzjemRZukf1sC0cg
	 IODeSaTJWe1zzxOjZ301v+ymPr1L8Scv6E9AnzU66nlJfGEc4hF2dY7LX7rL73JNFM
	 DrKOVky8bdInmA43SpH3KI6c8E5yDu5C4bn0ba2YkDDIP91we/0U0+8GfXujDh5ZkJ
	 JwpTQ0U2hZrqw==
Content-Type: multipart/mixed; boundary="===============3797737615928714366=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <fca1e9490af520c8e6518b8a2e2b9315fdc329545851899dac3ac7d56eb37653@mail.kernel.org>
In-Reply-To: <20261120074430.2704488-21-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-21-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 20/49] bpf: Delete the equations that say nothing
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 08:25:34 +0000 (UTC)

--===============3797737615928714366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Delete the equations that say nothing

TL;DR:
- Previous commit likely fails to build, using clean_sym_cnt and
  bpf_equations_clean() added only here, breaking bisection
- Previous commit likely also lacks the "int i;" declaration in
  add_divmod_equation()

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -555,6 +555,7 @@ struct bpf_equations {
>  	bool normalized;	/* see normalize_equations() */
>  	bool infeasible;	/* the equations cannot hold: the program does not get here */
>  	bool needs_refine;	/* widened: the equations are not applied, see bpf_flow_next() */
> +	u32 clean_sym_cnt;	/* after the last bpf_equations_clean() */
>  };

[ ... ]

> @@ -2321,6 +2322,7 @@ void bpf_equation_env_free(struct bpf_verifier_env *env);
>  int bpf_equations_copy(struct bpf_verifier_env *env, struct bpf_equations *dst,
>  		       const struct bpf_equations *src);
>  void bpf_equations_free(struct bpf_equations *eqs);
> +void bpf_equations_clean(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
>  s64 bpf_equations_max_sum(struct bpf_verifier_env *env, int regno1, int regno2);

Does the previous commit in the series, 0462c546cfe6 ("bpf: Make equations
from ALU, spill, fill and call insns"), build without this field and this
prototype?

bpf_equations_before_insn() at that commit already does:

    if (st->speculative || eqs->sym_cnt > 2 * eqs->clean_sym_cnt + MAX_BPF_REG)
            bpf_equations_clean(env, st);

but neither clean_sym_cnt nor bpf_equations_clean() exists until this
commit, and the code is not under an #if.  With CONFIG_BPF_SYSCALL=y,
kernel/bpf/equation.c should fail there with "no member named
clean_sym_cnt" and an implicit declaration of bpf_equations_clean(), which
breaks bisection.

Could the clean_sym_cnt check and the bpf_equations_clean() call be moved
into this commit, or the field, prototype and function into a commit before
0462c546cfe6?

[ ... ]

> diff --git a/kernel/bpf/equation.c b/kernel/bpf/equation.c
> --- a/kernel/bpf/equation.c
> +++ b/kernel/bpf/equation.c

[ ... ]

> @@ -1195,6 +1196,7 @@ static bool add_divmod_equation(struct bpf_verifier_env *env, struct expr *expr,
>  	struct bpf_equations *eqs = &env->cur_state->equations;
>  	struct bpf_sym_equation sym_eq = { { -1, expr->coef, -divisor }, { 0, expr->var },
>  					     env->eq_env->insn_idx, expr->off };
> +	int i;
>  
>  	sym_eq.sym[0] = bpf_new_sym(env, eqs, rem);
>  	sym_eq.sym[2] = bpf_new_sym(env, eqs, quot);

Is this declaration of i meant to be part of the previous commit?

At 0462c546cfe6 add_divmod_equation() already has:

    for (i = 0; i < 3; i++)
            if (sym_eq.coef[i])
                    env->eq_env->scratch[sym_eq.sym[i]].refined_sweep = 0;

but i is not declared anywhere in the function, so that commit should not
compile.  Moving "int i;" into 0462c546cfe6 would let every prefix of the
series build.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44698144269
--===============3797737615928714366==--
