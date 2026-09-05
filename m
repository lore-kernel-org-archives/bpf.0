Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24CC3BCD3A
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 22:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788648291; cv=none; b=agWKKscs7K4sVsKByr4W2OfLc02UIvKfO5sr+NCJqDvBrKr8I3JfBXtn6giKRdhhmGUtagm2rEU95foxdKmo5zt8QKzB5eo+1p16xos0L4IV5NoeHakizeBdkRnzfdgvg1o+3B+a0Ya6Gr+OHYlL6pqHDzp9MfChgrili5bPOMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788648291; c=relaxed/simple;
	bh=lHo2bsoF6V/SO+U6Ctk7hpmRalXhUKN9Rei5h6MkOhA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tL7I0qJYCKwur2t3wIBeOxzXaenTrMaLDjSj2apnE3dQnYxlt00i7KjidnWes/XHt7u6sLIh8HJrQcfZUSw2+GQAjKeKXtlk7PUuCL+D1ZM3ndT4zQY9NYP9oMDAmyxRwP2/VATaxvprkJuJbQx41BFuV2GwlfyFwd1OORSi2Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hbu5cl6P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hbu5cl6P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1C71F00A3A;
	Sat,  5 Sep 2026 22:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788648289;
	bh=zgBCz2GaqBIa5S46RZIHjLm/HGdy5q+LEEk3JJdq2wY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Hbu5cl6PEGZVRHNZImhEPcQQKiUaVqhA2RwXZGIZDiPTgsxngITtQ3JRwzlSCDsBO
	 CkN/LMq0cQkCOuM9eWajmYlcYflc9SlPgNNfBeQ2aIG1B/9POV2ryOEpzecGUHeye1
	 U1+6UCUM0XhIINIGAYp4HLIze7Y3EbaEi4g/gTAX/9WqMzebrthn7ub3KVRyaquX4z
	 yorTAU2gQC4onIYYi7Foj67jYhk44L8yTN1nUjwHTauDmB1s2ds1OMHzuzLuNVnznu
	 4QNKBozEuP09FN5SBteaLr9Cd0Afx3VEGvjZz4/1FrfCVCsug8S1KEZFEhujMOoBY4
	 66v1VIxxvNq5Q==
Content-Type: multipart/mixed; boundary="===============7907976407529717421=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fb717f148b0a06cb1d66b10fb395a233be362c2989dcbaab918e05e781c435c8@mail.kernel.org>
In-Reply-To: <20260905220117.922028-9-ameryhung@gmail.com>
References: <20260905220117.922028-9-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v1 08/22] bpf: Classify kfunc arguments the verifier ignores
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 22:44:48 +0000 (UTC)

--===============7907976407529717421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     bpf: Classify kfunc arguments the verifier ignores
>
>     The verifier does not inspect __ign arguments or the implicit
>     arguments of a KF_IMPLICIT_ARGS kfunc. get_kfunc_arg_type() leaves
>     them unclassified, so gen_kfunc_arg_proto() skips them and
>     check_kfunc_args() repeats the same BTF predicates for every call.
>
>     Add ARG_IGNORE and classify both cases in get_kfunc_arg_type(). The
>     generated prototype can then record every argument, and the call site
>     can consume the recorded type without deriving the classification
>     again.
>
>     No functional change.
>
>     Signed-off-by: Amery Hung <ameryhung@gmail.com>

Does the "No functional change." line accurately describe this patch?

Looking at the parent commit 654bdd813138, the gen_kfunc_arg_proto() loop
began with:

kernel/bpf/verifier.c (at 654bdd813138):
    for (i = 0; i < nargs; i++) {
        if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, i))
            continue;

        arg_type = get_kfunc_arg_type(env, meta, args, i, nargs);
        ...
    }

So get_kfunc_arg_type() was never called for any prog_aux argument, since
prog_aux arguments are always implicit. The proto->arg_type[aux_idx] stayed
ARG_UNUSED (0) and could never become ARG_PTR_TO_PROG_AUX.

Then check_kfunc_args() reads this proto:

kernel/bpf/verifier.c (at 654bdd813138):
    enum bpf_arg_type arg_type = meta->fn->arg_type[i];
    ...
    if (arg_type == ARG_PTR_TO_PROG_AUX) {
        cur_aux(env)->arg_prog = regno;
        continue;
    }

With ARG_UNUSED recorded, arg_prog stayed 0.

The fixup in kernel/bpf/fixups.c is gated on aux->arg_prog:

kernel/bpf/fixups.c:
    if (aux->arg_prog) {
        insn_buf[0] = BPF_LD_IMM64(aux->arg_prog, (long)prog->aux);
        ...
    }

So no BPF_LD_IMM64 was emitted and the kfunc was called with an uninitialized
register in place of prog->aux.

This patch fixes that by testing is_kfunc_arg_prog_aux() before the new
ARG_IGNORE test in get_kfunc_arg_type():

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 22f5aff76b40..7416f1e16aa9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12086,6 +12088,9 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
>  	if (is_kfunc_arg_prog_aux(meta->btf, &args[arg]))
>  		return ARG_PTR_TO_PROG_AUX;
>
> +	if (is_kfunc_arg_ignore(meta->btf, &args[arg]) || is_kfunc_arg_implicit(meta, arg))
> +		return ARG_IGNORE;
> +
>  	t = btf_type_skip_modifiers(meta->btf, args[arg].type, NULL);

and dropping the continue from gen_kfunc_arg_proto():

> @@ -12215,7 +12220,6 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
>  static int gen_kfunc_arg_proto(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
>  			       struct bpf_func_proto *proto)
>  {
> -	const struct btf *btf = meta->btf;
>  	const struct btf_param *args;
>  	u32 i, nargs;
>  	int arg_type;
> @@ -12234,9 +12238,6 @@ static int gen_kfunc_arg_proto(struct bpf_verifier_env *env, struct bpf_call_arg
>  	}
>
>  	for (i = 0; i < nargs; i++) {
> -		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, i))
> -			continue;
> -
>  		arg_type = get_kfunc_arg_type(env, meta, args, i, nargs);
>  		if (arg_type < 0)
>  			return arg_type;

so ARG_PTR_TO_PROG_AUX is again recorded in the generated prototype and
arg_prog/BPF_LD_IMM64 are emitted.

This affects bpf_wq_set_callback(), bpf_task_work_schedule_signal()/_resume(),
bpf_stream_vprintk(), bpf_stream_print_stack() and all scx_bpf_* sched_ext
kfuncs.

Should this patch either be squashed with 654bdd813138 or have the "No
functional change." line qualified, since it repairs a bug where kfuncs with a
prog_aux argument were called with an uninitialized register?

Also, the ordering is load-bearing: swapping the two tests in
get_kfunc_arg_type() would silently reintroduce the broken code generation,
since prog_aux arguments are always implicit. Should a comment note that the
prog_aux test must stay ahead of the ARG_IGNORE test?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33995442755
--===============7907976407529717421==--
