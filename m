Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD833AFD16
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790027805; cv=none; b=Vhi9smuJbiz9H2jlIgNhrtCPmE+DkDIZ1gUge/iYvaNCL6zXw3Wj7APw+wxDJCQSOA/nebAyrw14HvisZpMzGE4Muy7X5FxxAgxpnwEtRrTqYrzA9GiCbLNz2C89+EfMehbOizsIuc2rJs9IU7KHpoHLi0CDjh3aztgswfrq7v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790027805; c=relaxed/simple;
	bh=wnX26qRjz/IZSwqT3nucbkbC5ifwBh5F0RmAuIWclBo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZA+qb6qyeYDmwQS9pDh/+bfQ1uNDVcg+pL0dNG1e5EdvIMOVzpd+18giACDwlksMcveqkGdx+h46ur3UmObk5q2EZJ734hmtjLtaz+tf+Pe5cvzR2l943jtA7vUAic1VRpBLxGckrhOwM6mQOmRCkxueZjdt1wYGhEKqZ0Ezew8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfkBJ3J/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfkBJ3J/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553DB1F000FF;
	Mon, 21 Sep 2026 21:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790027803;
	bh=QK+rtWC/kGXy381Hh3F76z4j82+qrLbYo/9LYN9F4TE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=GfkBJ3J/yk5SWsVO37K1RJ35plx78kCYCfy/KDR7wLgxOc2mXBGcpzBERrrKkd7JR
	 9kps18FPAk/DYLm0r6dG/7f4ue6z8ckzdgHHUavTeS6y7JvREO9Jrh1vemF2/6tgGI
	 axvJoiFnEXe4FjC5rCBj134LYhEXwOiuPeghlCdWxFjgjSbUNTWSSzuEYWtcByW+qd
	 UvNJZTH7BL0JCMI6DXYgvfaa7oUGzDzhR3gRESht74acf9SX2DM8cc7LvCT87STlRI
	 KTcSzHmVlxqSLylhE1wafAybbSF8jDV0faqwVyVwhlLQ6jv9KmLQqaY276s4Q/DHL5
	 dQRuchN/0ag7w==
Content-Type: multipart/mixed; boundary="===============1652680925608114801=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8e41c978495f9f21b81d1dcb6815e1ab5ba4a1485e544715e9baa1815eb64b82@mail.kernel.org>
In-Reply-To: <20260921210109.1719713-1-yonghong.song@linux.dev>
References: <20260921210109.1719713-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 07/20] bpf: Refuse exception cleanup shapes bpf_throw() cannot dispatch
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 21 Sep 2026 21:56:42 +0000 (UTC)

--===============1652680925608114801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
> index 67af78baa558..da8fa6eb7e4b 100644
> --- a/kernel/bpf/exception.c
> +++ b/kernel/bpf/exception.c
> @@ -3,12 +3,24 @@
>  #include <linux/bpf.h>
>  #include <linux/bpf_verifier.h>
>  #include <linux/btf.h>
>  #include <linux/btf_ids.h>
>  #include <linux/filter.h>
>  #include <linux/slab.h>
> +#include <linux/sort.h>

This isn't a bug, but is <linux/sort.h> used by anything in this patch,
or would it sit better in the later patch that adds the sort() call?

A scan of exception.c and exception.h at this commit finds no sort(),
sort_r(), cmp_func_t, cmp_r_func_t or swap_func_t. The first sort() call
in the file arrives three commits later, in 07c93d6858af ("bpf: Dispatch
exception cleanup pads from bpf_throw()"), which adds sort(at, cnt,
sizeof(*at), cmp_u32, NULL) without needing to touch the include block
because this patch already added the header.

[ ... ]

> @@ -29,12 +154,260 @@ static void cleanup_mark_kfunc_sites(struct bpf_verifier_env *env)
> +static int cleanup_mark_pad_bodies(struct cleanup_ctx *ctx)
> +{
> +	struct bpf_verifier_env *env = ctx->env;
> +	u32 i, sp = 0;
> +	int ret;
> +
> +	for (i = 0; i < env->cleanup_info_cnt; i++) {
> +		u32 pad = env->cleanup_info[i].landing_pad_off;
> +
> +		if (in_pad(env, pad))
> +			continue;
> +
> +		ret = cleanup_pad_is_catch(ctx, pad);
> +		if (ret < 0)
> +			return ret;
> +		if (ret) {
> +			verbose(env,
> +				"catch landing pad %u is not supported yet, only cleanup pads that resume\n",
> +				pad);
> +			return -EOPNOTSUPP;
> +		}
> +		env->insn_aux_data[pad].in_cleanup_pad = true;
> +		ctx->stack[sp++] = pad;
> +	}
> +
> +	while (sp) {
> +		u32 j = ctx->stack[--sp];
> +		enum cleanup_insn_kind kind;
> +		int next, target, sub;
> +		u32 start, end;
> +
> +		ret = cleanup_check_pad_insn(env, j);
> +		if (ret)
> +			return ret;
> +
> +		sub = cleanup_subprog_of(env, j);
> +		start = env->subprog_info[sub].start;
> +		end = env->subprog_info[sub + 1].start;
> +		kind = cleanup_succ(env, j, start, end, &next, &target);
> +
> +		if (kind == CLEANUP_INSN_CALL) {
> +			/* check_subprogs() registered every call target. */
> +			int callee = cleanup_subprog_of(env, j + env->prog->insnsi[j].imm + 1);

This isn't a bug, but the comment credits the wrong verifier pass.

check_subprogs() (kernel/bpf/verifier.c:3081-3146) does not register or
validate call targets at all - it explicitly skips them:

    if (BPF_OP(code) == BPF_CALL)
            goto next;

Its only jobs are setting has_tail_call/has_ld_abs/exit_idx and checking
that jump targets stay inside the containing subprog. The guarantee the
comment is reaching for actually comes from add_subprogs()
(verifier.c:2985-3053), which does

    ret = add_subprog(env, i + insn->imm + 1);

for every bpf_pseudo_call() insn, with add_subprog() rejecting off < 0 ||
off >= insn_cnt. That is what makes cleanup_subprog_of() unable to return
-1 here, so the code is correct - only the comment is wrong.

A reader who follows the comment to check_subprogs() finds the opposite of
what it claims, which is worse than no comment, since this is the
documented reason an array index is left unchecked. Could the comment say
"add_subprogs() registered every call target" instead?

> +
> +			if (env->subprog_info[callee].might_throw) {
> +				verbose(env,
> +					"cleanup landing pad calls subprog %d at insn %u, which can throw while an exception is in flight\n",
> +					callee, j);
> +				return -EINVAL;
> +			}
> +		}
> +
> +		if (next >= 0 && !in_pad(env, next)) {
> +			env->insn_aux_data[next].in_cleanup_pad = true;
> +			ctx->stack[sp++] = next;
> +		}
> +		if (target >= 0 && !in_pad(env, target)) {
> +			env->insn_aux_data[target].in_cleanup_pad = true;
> +			ctx->stack[sp++] = target;
> +		}
> +	}
> +	return 0;
> +}

[ ... ]

> @@ -154,12 +448,43 @@ int bpf_prepare_cleanup_exceptions(struct bpf_verifier_env *env)
> +static int cleanup_check_pad_insn(struct bpf_verifier_env *env, u32 i)
> +{
> +	struct bpf_insn *insn = &env->prog->insnsi[i];
> +
> +	if (bpf_helper_call(insn) && insn->imm == BPF_FUNC_tail_call) {
> +		verbose(env,
> +			"bpf_tail_call() at insn %u is in an exception cleanup landing pad\n",
> +			i);
> +		return -EINVAL;
> +	}
> +	/* A BPF_LD_[ABS|IND] can leave the frame through its epilogue. */
> +	if (BPF_CLASS(insn->code) == BPF_LD &&
> +	    (BPF_MODE(insn->code) == BPF_ABS || BPF_MODE(insn->code) == BPF_IND)) {
> +		verbose(env,
> +			"BPF_LD_[ABS|IND] at insn %u is in an exception cleanup landing pad\n",
> +			i);
> +		return -EINVAL;
> +	}
> +	if (is_stack_arg_st(insn) || is_stack_arg_stx(insn)) {
> +		verbose(env,
> +			"insn %u passes an on-stack call argument in an exception cleanup landing pad\n",
> +			i);
> +		return -EINVAL;
> +	}
> +	if (bpf_pseudo_kfunc_call(insn)) {
> +		struct bpf_call_summary cs;
> +
> +		if (bpf_get_call_summary(env, insn, &cs) &&
> +		    cs.arg_slot_cnt > MAX_BPF_FUNC_REG_ARGS) {
> +			verbose(env,
> +				"insn %u passes an on-stack call argument in an exception cleanup landing pad\n",
> +				i);
> +			return -EINVAL;
> +		}
> +	}
> +	return 0;
> +}

This isn't a bug, but would it be clearer to funnel both on-stack-argument
branches through a single labelled exit, or to differentiate the two
messages (e.g. mention the kfunc argument spill in the second one) so the
log says which shape was rejected?

Because the two messages are identical, the log does not distinguish which
of the two shapes was rejected, and a future edit to the wording has to be
applied in both places.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35656368472
--===============1652680925608114801==--
