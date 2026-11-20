Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163146;
	b=E+6WI19HQYDSbfB7MT+w7qeeswVHJzFg7gHEeKcgZOnycRdiMQH/NndXYf525APEfzb+
	 TKdAHYpKP2ltSVWGT7LN2gXL5swxiz2LYu0V61HLmHfb0nIulDNWXJcgmRS8hW+Poa2Ii
	 1pmH7tUrPra0fniX0CMZqRGLBRfS57SgOb3U98WCEvad5GtVh2D/yK4UXp395Zf7Qcq+g
	 7ksTUz+ycBfiDpC6JDQFDSOjVWwj2+GAwi9K2tlHQdlqp+hMFlheggycwV6bhyZN0t/SR
	 rvA1Qdyb2PH5vPO5ewwLvi44ezBsxZNNeDG3gDSTk7k6gj3NE0TeggjOn7h4uLba8Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163146;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=nYYlXSHXWNOrinuW+T0wqqe0RKD4kpMIYhmkaRb+/kA=;
	b=0udCcTmycemduPBmzaSoQKLuV/ai1UZ+ObHbiPS3HIbqpueJXnUsRP9vPuy/plDUQnQT
	 47GLp1m0zKCqpinjDFmIkP1uFd9qtXGPoxZ6h33V0ENd8METRkppwK+M9VJqnsvxRPEiz
	 0p9HMg/Mjun2FJ9git3csBYmQG9oKY70HyXhmh/dtOH+chsNZP0dmnjzVuZlNj8pYkOjV
	 oAaEikpnACL0yu8SCuUKG9hgDu8BnwOfqMPpx82dXznGrACUN3Ml81mh+l2/3jp7ObfE3
	 u6B6Px6RdT0b8cHm1YNXQ0B3Yzhl+zyVj86HY7ZwOn6CxUvqa+dfEKgFwpIza0kvzBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dju4ZOYD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B908606A330
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dju4ZOYD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3F61F000CA;
	Fri, 20 Nov 2026 08:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795163145;
	bh=nYYlXSHXWNOrinuW+T0wqqe0RKD4kpMIYhmkaRb+/kA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Dju4ZOYD78zb0ndbN542qoEsFo0J+YvTololAj3BZB/Z+lExC/G7I5OCppzVIfM8Y
	 zoa12xJNBdPG1yeXy9exQBGVLQkmb2QXhBkS3H8s3srU8yzigtz6NrKrpCZh2U6DWJ
	 uv7qsEj1qVnRjVZCWZjQ53VX+N57Eh1JWBLwO1DyhtWfHmdh90FqotMadqjfm1YRkG
	 qfasaH3qMLUaoDYwVYutW1KgdFqYheAvfeOBg/f5dkiK0jIa1HUiNR0cFfnXt+S8MB
	 AzG4WFSbCUGVAcCid788DVXUyqrLzWTcrKDNc+uA6K25XV2nMs8HYFJbF5k95Ip9Gf
	 2DVP7evDFHV+g==
Content-Type: multipart/mixed; boundary="===============2634495333271943596=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <8079e6ab26fc91cbc3a2d1f4547116950a770cecaf6ebc414d3def2dd0aa375a@mail.kernel.org>
In-Reply-To: <20261120074430.2704488-20-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-20-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 19/49] bpf: Make equations from ALU, spill, fill and call insns
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 08:25:44 +0000 (UTC)

--===============2634495333271943596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Make equations from ALU, spill, fill and call insns

TL;DR:
- Build breaks in equation.c: undefined clean_sym_cnt and
  bpf_equations_clean() (added by next patch), hurting bisection
- Undeclared 'i' in add_divmod_equation(), also fixed only in the next patch

> diff --git a/kernel/bpf/equation.c b/kernel/bpf/equation.c
> --- a/kernel/bpf/equation.c
> +++ b/kernel/bpf/equation.c

[ ... ]

> +/* Note the operands. Delete the equations of the registers that the insn writes. */
> +void bpf_equations_before_insn(struct bpf_verifier_env *env)
> +{

[ ... ]

> +	if (!eq_env)
> +		return;
> +	if (st->speculative || eqs->sym_cnt > 2 * eqs->clean_sym_cnt + MAX_BPF_REG)
> +		bpf_equations_clean(env, st);

Does this build?  struct bpf_equations has no clean_sym_cnt member at this
commit, and bpf_equations_clean() is neither declared nor defined anywhere,
so this should fail with "no member named clean_sym_cnt" and an implicit
declaration error for bpf_equations_clean().

kernel/bpf/Makefile builds equation.o under CONFIG_BPF_SYSCALL, so every
BPF-enabled config is affected and bisection breaks.

The next commit, a50a112fb866 ("bpf: Delete the equations that say
nothing"), adds 'u32 clean_sym_cnt;' to struct bpf_equations, the
prototype in bpf_verifier.h and the definition of bpf_equations_clean().
Should those move into this patch, or this call move into that one?

The commit message says "A speculative state gets no equations", but that
behavior lives entirely in the missing bpf_equations_clean(), so it is not
implemented by this patch alone.

[ ... ]

> +/* @expr = @divisor * quot + rem. Returns the expr of a new sym: @quot or @rem. */
> +static bool add_divmod_equation(struct bpf_verifier_env *env, struct expr *expr, u64 divisor,
> +				const struct scalar *quot, const struct scalar *rem, bool want_quot)
> +{
> +	struct bpf_equations *eqs = &env->cur_state->equations;
> +	struct bpf_sym_equation sym_eq = { { -1, expr->coef, -divisor }, { 0, expr->var },
> +					     env->eq_env->insn_idx, expr->off };

[ ... ]

> +	for (i = 0; i < 3; i++)
> +		if (sym_eq.coef[i])
> +			env->eq_env->scratch[sym_eq.sym[i]].refined_sweep = 0;

Where is 'i' declared here?  The only locals in add_divmod_equation() are
eqs and sym_eq, and there is no file-scope 'i', so this looks like an
"'i' undeclared" compile error.

The same a50a112fb866 commit adds 'int i;' to this function.  Could the
declaration be added in this patch so it builds on its own?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44698144269
--===============2634495333271943596==--
