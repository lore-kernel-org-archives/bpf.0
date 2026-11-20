Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795211491;
	b=EP7hBNiw+PjhMepAlqv9B140+fL+dW9Jm0tpKsCA62McZx7OkhkPAmgGv/t9LExLaUQc
	 pN/TpTyce55JkA7ac8/gjH1LuUtCUqHAYFASH8KivmXF3cY3GcoPzdy6MYFOfqy4YsiyY
	 0vQtjcgwR6uu0rEoozLQai8atQ0ygi5Ni8NyFLmBC8g9XN8aQ+uQ3eexkvHf7WNWMcffR
	 1SxKOw2M03Hnn08vyDDAVmG53HAt5EEMat4+Se2WEYoWpNn2eFEOq3VqD/Ra3lrofH9mn
	 KOrlLgUsc9YFNm7kBkLrtRgZ6gsfutL9h9rzwsS6jzCREuJlQ0+/Htunke6T8Z4VF/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795211491;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=nM3Nmn52ZDiOwkbaLSEgzTWLmapDaltQ9GbSixJztpg=;
	b=C2C7nv5JEP9k1Aueo5dlKdLyvo82Pz92xZg0igKLnvF1zPwcUz0fkQIQPWIm9GUyHyDk
	 hiJSpX+XhEm4bT06sxWUyn5IIUYvZUdyn6EnVdsPDxwKfbE5UWTdWvG6YgaiWrZjEwvEX
	 2CQtVF4/f6fLa52M8KviNhocz0Qvm73PBGCedvXcviLJP4vCs3tkmUFt2BLU5PD70IiuF
	 t3lU93PHME56y05ODTYVqPshDdFPcQKSetLEklq666XxRRzwcVJ0/SY77ngBRJqD1ag5Q
	 ozeTJRNEL+nvi0l4/wsIV8lvIPpAis0WwPKLiA5Tu9g2BKmeezlCjKjNE4WhaNnthiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BNQpG71s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7E7606A698
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 21:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BNQpG71s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E56A1F000D8;
	Fri, 20 Nov 2026 21:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795211490;
	bh=nM3Nmn52ZDiOwkbaLSEgzTWLmapDaltQ9GbSixJztpg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BNQpG71s56k4m09Ao7hhOBPOEDwvIfqgOeQm2tR6eZKApANPmg7IeVtdnaf7s8yp0
	 IcZiKr/nG+fhcn4TReG0Lhd13dA4mhZkJiUisKRfqJQUVXD0HferGzJEMQG/KBRdWO
	 ghGXjWP6ZE68F05ImcOvkm+39ZGBDQc8XMzXWvsIoLYWqySXgxIbRhV+ELUTWlZ/gH
	 Kp0I1Qu/mH7FK32b5zI9RVrj/x4Hioc7juIzLKiJHmI4w7SF2wqRrr7aVJXqDaZhQK
	 0DZ2F5+l+zn+9hMaRFSRYk2e2oFSIuizfqhr+9o7sk2IL7bxmishSVU9/mm8G/5AvT
	 +tAI+XgxibKaQ==
Content-Type: multipart/mixed; boundary="===============5268671812201052630=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <4264782ed6e94977ca6c4317a85bee1ec117f4cea2746784680121176a8e513a@mail.kernel.org>
In-Reply-To: <20261120204959.614908-24-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-24-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 23/49] bpf: Find the xregs that an unproven insn depends on
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 21:51:28 +0000 (UTC)

--===============5268671812201052630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Find the xregs that an unproven insn depends on

TL;DR:
- Possible NULL env->precision dereference in bpf_xreg_in_deps() via
  cut_range() on ordinary programs, breaking bisection
- New functions have no callers, so unused-function warnings may fail -Werror
  builds

> diff --git a/kernel/bpf/precision.c b/kernel/bpf/precision.c
> --- a/kernel/bpf/precision.c
> +++ b/kernel/bpf/precision.c

[ ... ]

> +bool bpf_xreg_in_deps(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
> +		      u32 fr, u32 xregno)
> +{
> +	unsigned long data_deps[XREG_WORDS], control_deps[XREG_WORDS];
> +
> +	if (!env->precision->data_deps ||
> +	    xregno >= bpf_frame_mask(env, env->precision->data_deps, st, fr, data_deps))
> +		return false;

Can env->precision be NULL here?  At this commit nothing allocates it:
env is created with kvzalloc_obj() in bpf_check() and no code assigns
env->precision.  env->path_sensitive is never set either, so cut_range()
always reaches this call:

    if (!env->path_sensitive && !bpf_xreg_in_deps(env, st, st->curframe, regno))
            return 0;

The path is bpf_check() -> do_check_all() -> do_check_block() ->
do_check_insn() -> check_cond_jmp_op() -> cut_range() ->
bpf_xreg_in_deps().  It runs for an undecided conditional jump on a scalar
whose range wraps the end of the compare order, for example a sign-extended
byte in [-128, 127] compared with an unsigned 'if r1 > 10'.  That would
dereference NULL + offsetof(struct bpf_precision, data_deps) while loading
an ordinary program.

The parent commit 71c3255177f2 ("bpf: Continue a pass after an unproven
insn") added the cut_range() call without a definition, so it does not
link.  This commit adds the definition, which turns the link failure into a
runtime NULL dereference.

env->precision is allocated by bpf_precision_init() added in 61b3482f7d0f
("bpf: Partition the states after an error"), but nothing calls it until
02e7abee2ca0 ("bpf: Verify in passes"), 14 commits after this one.  Every
commit in between can oops in the verifier, which breaks bisection.

Should env->precision be allocated (or checked for NULL) in this patch, or
should the cut_range() call move to the patch that allocates it?

[ ... ]

> +static int find_calls_to_unproven(struct bpf_verifier_env *env)
> +{

[ ... ]

> +static int compute_deps_of_unproven(struct bpf_verifier_env *env)
> +{

[ ... ]

> +static int alloc_masks(struct bpf_verifier_env *env)
> +{

This isn't a bug at runtime, but find_calls_to_unproven(),
compute_deps_of_unproven() and alloc_masks() have no callers in the tree at
this commit.  Won't each of them give a 'defined but not used
[-Wunused-function]' warning from precision.c?

With CONFIG_WERROR=y (the default under COMPILE_TEST, so allmodconfig),
those warnings are errors and kernel/bpf/precision.c would not build.

find_blocks(), find_control_seeds(), add_control_deps(), may_not_return()
and add_masks() are reachable only from these unused functions.  That seems
to be the only reason the call to bpf_flow_is_bb_start() (declared here,
first defined in 8514cc01b0e8 "bpf: Prune or join each state that arrives")
does not fail at link time.

The commit message mentions the late bpf_flow_is_bb_start() but not the
missing callers.  The callers arrive ten commits later in 61b3482f7d0f
("bpf: Partition the states after an error"), which adds
'ret = prec->data_deps ? 0 : alloc_masks(env);' and
'return find_calls_to_unproven(env) ?: partition_next(env);' in
bpf_partition_more(), and calls compute_deps_of_unproven() from add_deps()
and add_transitive_deps().

Could these functions be moved into 61b3482f7d0f, the commit that first
calls them?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44817467639
--===============5268671812201052630==--
