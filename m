Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE81017BB21
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 17:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940875; cv=none; b=ILwWv+fQh0n50Q79Jt5Z8KpiY93uQXOnXE1Zp17zquiAm3RXL/0zXhmT2H8u1iyUipsERQ05uu37gNTWR6jBLbz9Llv7zwBjSEVAYdTfVFoLx7pS6e4hURKWzlC966x3aK7lnVLomEZVCXwBwsw+oSwSovwPsUQpZTrpyQuJ8W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940875; c=relaxed/simple;
	bh=2iWcBneP/W+b6+2ICY9+1BTLZQLp8100UAQpMN0Af2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5AKwYUz5DyAeuNJj/cyO8bPRWPHDhRGJZ9LBfU3FqU3hnocC2HGsDe59kJTFFGJ2s4nMDKTmBXC4vLjby7f9rN9ujHunn55Asp6uy6sxQC6hY1LJpC4oQWC3NWvK6Iw4uTY5zBNhc21UxxH9l/t45XZEluTfcl+BF01sGr4j4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBYfZUuj; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBYfZUuj"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-660e9fef1d4so5248071d50.1
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 10:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780940873; x=1781545673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5cDk6XoW5J5KWPDBh5GrHee0O0wk0VMHKSl0srNllyg=;
        b=eBYfZUuj1RAT2zjoNEan+XHrtCaf8uekIDSBFfeRvG2Gjrtofg48SMOQosyXf4Ye8I
         qN2PTkhaE/yPh7+jqSA6o0oaY2iv1PPFNzhk2sYToe5hT50XmZ7UD9Fi/wYFD102X+6F
         nzgLIg9vogyR71bGCWjPU/h/yVRNbgCJ2863i4F8xh1qPv4dBz7fN1kZ0I23hpUo/LkO
         J4B5XEaevq2qmNUkXYDa4SmKGYSqt9BsvLEOgik68Fue8yPy4Ozw5WsOy2APqNhzJCLA
         fq3/kthhVdI+udO430xFAV4K14SQQfcsoQ6V/jsXKx1IZ3IhlriIp3XeW40F7LYMmCUg
         Tebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780940873; x=1781545673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cDk6XoW5J5KWPDBh5GrHee0O0wk0VMHKSl0srNllyg=;
        b=IRIphFPbUZJZS9fzVhGm/hSLvNWP1w3S47uM5KR3mqsF7NPopW5UT/SuhE7MC1N5zY
         x3ARVOVnoz8kEqqlTi7rjutuqOBYPWTEPX2Ulgw4bRkAeevPLtMv8U6ywBg61URXhcW3
         fqKO0WD013kf868XLVPjbjqsg5vM89nOTkauB0o+BrSt5Lpg5STmgE/moZt3GjMvKjgi
         60yoDvI7YIWnHqZqUusBP69E8a72ItX2Q4zr24OaQIQFHKFvGl50U1ufESgN/jabtnkJ
         6OwV7PeW6euHuKRFtoPfSQtt/FX8WRgLQ7YiLVbPrgJ/IJrxA8+uCTpvedzKNT+omwVL
         SbOg==
X-Gm-Message-State: AOJu0Yyg+pkIa/u28ECcO+Df0gWbO+2egm7JPQtlqbIPW7Onbm4WLur/
	j2n2wVSu9eXlkzY4QmU48pSplWu5ojD9SvCYlCBNWzcz1bFVDFvEnlwZgn166A==
X-Gm-Gg: Acq92OGSXHi73G0C/X/vYmqnXOJBh+DMZuWEUHK9rMQzKVDxnDhi/SOSHENMrc2LH8k
	Kmd/DlUpuNWKB0e9QE/ouRym76kADQWWK73nbgVJygvgzBtXC5DgmMInqZUXT49dj69OS+2NDOg
	biLTD8OfxQ7HEphoclJ8bS+wCGiit5Z5UC2acdMLhXHUFK/2ag275xYY9azVDRivMtUV4cN0Ktm
	mX/o8H7mpC+29cojtHriwyPHlCEaea6Hovw2NmbswUaDmr2o8hT5niD88gSaTd+VrB9Ni8kTwYE
	Npmao1V0LfdAecZN5b+xzlKYXiDKtFYJUhPl5LhBhNV1CSOdPqZLLHaOxMAVtnU0wkXepDqFFIA
	o0+QHE47cNMpAR6YY08kRqm3QzuF1JTf9ySRnCMJWegKTlHLkVO+aQIA4B2Ij0Tj7BgUdJrSIqg
	qfnCFBrha5uxBiASq8TeNghZnQh0c5vfXu/eMFe37zeGVpYw6DeQkbWD2ELVwBHDymWzUj
X-Received: by 2002:a05:690e:4386:b0:660:6780:f3fe with SMTP id 956f58d0204a3-66106f58c0cmr9627339d50.26.1780940872775;
        Mon, 08 Jun 2026 10:47:52 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:5176:5522:fd44:7a6a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d64ba680sm9735129d50.21.2026.06.08.10.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 10:47:52 -0700 (PDT)
Date: Mon, 8 Jun 2026 13:47:51 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, 
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 1/5] bpf: Treat non-iterator tracing progs as
 tracing
Message-ID: <aibxqG77bragcPos@zenbox>
References: <20260608144841.1732406-1-memxor@gmail.com>
 <20260608144841.1732406-2-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608144841.1732406-2-memxor@gmail.com>

On Mon, Jun 08, 2026 at 04:48:34PM +0200, Kumar Kartikeya Dwivedi wrote:
> The is_tracing_prog_type() predicate omitted BPF_PROG_TYPE_TRACING even
> though fentry, fexit, fmod_ret, raw_tp BTF and similar programs have the
> same execution-context concerns as the tracing program types already
> covered by the helper.
> 
> This matters for map compatibility checks that reject bpf_spin_lock,
> bpf_list_head and bpf_rb_root in tracing contexts. BPF_PROG_TYPE_TRACING
> programs can run from arbitrary instrumented contexts, including places
> where taking these locks or manipulating graph roots is not safe.
> BPF_TRACE_ITER is different: iterator programs run from task context, so
> we continue to exclude them.
> 
> This can reject existing fentry/fexit-style programs that use map values
> with these fields. Such programs were accepted only because the
> predicate missed this program type; their use depends on semantics the
> verifier already rejects for equivalent tracing hooks.
> 
> Move is_tracing_prog_type() checks from check_map_prog_compatibility()
> to points where the fields are actually used to avoid preemptively
> rejecting tracing programs that use maps with such fields but do not
> touch these fields.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
Thanks for sending this, looks pretty good to me.
>  kernel/bpf/verifier.c | 37 ++++++++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ed7ba0e6a9ce..26bfb4465725 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6967,6 +6967,11 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
>  	u32 spin_lock_off;
>  	int err;
>  
> +	if (is_tracing_prog_type(env->prog)) {
> +		verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
> +		return -EINVAL;
> +	}
> +
>  	if (!is_const) {
>  		verbose(env,
>  			"%s doesn't have constant offset. %s_lock has to be at the constant offset\n",
> @@ -12222,6 +12227,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  				return ret;
>  			break;
>  		case KF_ARG_PTR_TO_LIST_HEAD:
> +			if (is_tracing_prog_type(env->prog)) {
> +				verbose(env, "tracing progs cannot use bpf_{list_head,rb_root} yet\n");
> +				return -EINVAL;
> +			}
>  			if (reg->type != PTR_TO_MAP_VALUE &&
>  			    reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
>  				verbose(env, "%s expected pointer to map value or allocated object\n",
> @@ -12238,6 +12247,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  				return ret;
>  			break;
>  		case KF_ARG_PTR_TO_RB_ROOT:
> +			if (is_tracing_prog_type(env->prog)) {
> +				verbose(env, "tracing progs cannot use bpf_{list_head,rb_root} yet\n");
> +				return -EINVAL;
> +			}
>  			if (reg->type != PTR_TO_MAP_VALUE &&
>  			    reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
>  				verbose(env, "%s expected pointer to map value or allocated object\n",
> @@ -17664,9 +17677,11 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
>  	return __add_used_btf(env, btf);
>  }
>  
> -static bool is_tracing_prog_type(enum bpf_prog_type type)
> +static bool is_tracing_prog_type(const struct bpf_prog *prog)
>  {
> -	switch (type) {
> +	switch (resolve_prog_type(prog)) {
> +	case BPF_PROG_TYPE_TRACING:
> +		return prog->expected_attach_type != BPF_TRACE_ITER;
Seems reasonable to exclude this attach type as they run always in task
context as stated. This seems like the safest approach.

In practice, *most* tracing type programs will be unreachable from
NMI. But the edge cases are difficult to enumerate...

fentry / fexit are nearly impossible to exclude, since there's no
good way to answer "can this function be called from an nmi handler"
at verification time. Such a list would be unmaintainable.

Raw tracepoints are similar. Indeed, it would be *possible* to
specifically exclude the tracepoints that cannot be called from NMI. But
this would require maintaining a large list and would be brittle.

fmodify_return attach types are whitelisted to LSM hooks and
ALLOW_ERROR_INJECTION functions. A quick grep for ALLOW_ERROR_INJECTION
doesn't bring anything that looks obviously NMI-relevant, but again, I
think allowing it would be asking for trouble later.

So I think this is a good balance...
>  	case BPF_PROG_TYPE_KPROBE:
>  	case BPF_PROG_TYPE_TRACEPOINT:
>  	case BPF_PROG_TYPE_PERF_EVENT:
> @@ -17697,24 +17712,16 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
>  		return -EACCES;
>  	}
>  
> -	if (btf_record_has_field(map->record, BPF_LIST_HEAD) ||
> -	    btf_record_has_field(map->record, BPF_RB_ROOT)) {
> -		if (is_tracing_prog_type(prog_type)) {
> -			verbose(env, "tracing progs cannot use bpf_{list_head,rb_root} yet\n");
> -			return -EINVAL;
> -		}
> -	}
> -
>  	if (btf_record_has_field(map->record, BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK)) {
>  		if (prog_type == BPF_PROG_TYPE_SOCKET_FILTER) {
>  			verbose(env, "socket filter progs cannot use bpf_spin_lock yet\n");
>  			return -EINVAL;
>  		}
> -
> -		if (is_tracing_prog_type(prog_type)) {
> -			verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
> -			return -EINVAL;
> -		}
> +		/*
> +		 * Rejecting tracing progs accessing maps with bpf_spin_lock in
> +		 * them here would be too conservative; let's defer rejection
> +		 * until seeing first use.
> +		 */

In practice, I think most programs using those spinlocks w/ fentry
weren't broken.

They were saved only by nature of the fact that the particular
functions that attached to were uncallable / never were
called from NMI. Which is the case for 99% of those programs.

So this case is where fixing the other 1% of cases are going
to have consequences for the remainder.

This is a tough decision to have to make. There's options, but all of
them come with downsides.

1. (this patch) break tracing programs using bpf_spin_lock.
2. Somehow prevent NMI reentrancy of tracing progs on the same cpu. probably
by just ignoring the reentrant calls, much how we handle the recursive
tracepoint prevention for bpf. (complicated, may have side effects)
3. Inject a fixup runtime check for in_nmi for every tracing program
and tail callable program, exiting before executing anything
(still breakage, just at runtime now)

If breakage is acceptible here, the approach this patch takes is the
most *correct* way to do it, and the way it should have been done from
day one, but having users relying on the "broken" behavior makes it
harder to fix now.

This seems like a maintainer call.

Justin
>  	}
>  
>  	if ((bpf_prog_is_offloaded(prog->aux) || bpf_map_is_offloaded(map)) &&
> -- 
> 2.53.0
> 
