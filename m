Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996AC43E9D8
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207447; cv=none; b=oMyRuIgmffgRE8fWdqrG+3N801U/z4TIMCeoi6ycKgfQQACOwOUg5lPExKYEs0U5gOBIJgFKIXgbPneeJ8mqEACzG9CBho60qRHLCQFxxhB3TZFWEXr9X9Jy/rJEpWDN1QuWBGA3F/yUSbtX5O2Oaa2ITD8TlK+JzC+TBNUEi64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207447; c=relaxed/simple;
	bh=MLkA3qEqhHGNlgjq9f66SVAh7DEJ6JhyUooOKM9vQ4U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VKYZu5+KmMOoCPoz9fmEANsXggu3kQGFQQv+0UUXnkftTugjaiorFQDRjflhqgXzhRcoCy0haFHDoo25kEv17JZySCtVII+qvzJMvdChogACti9ESKOtO8+c8Ay9gY6Erfy4DkcTPUZT1Ik5JGx5mXNLa/rBdcYzpJTbNcO3jZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=qEBsZjwC; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="qEBsZjwC"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-899ba9a699cso12795696d6.2
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 07:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772207442; x=1772812242; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgyLFJFx45R9Tx2zeV1jBQm6wqAlhI4vWuYhi09yi1s=;
        b=qEBsZjwCVdi7XG7iPb5uJF3cKpNw0t+jNjbYIb2F+kBEhukVV4axBQ5PVNjf9guLV0
         ogWprINFIdpTF6WcZoxB+kGza8Au7sffPWdVF96zPfO7iRwroBoNDpusipDIPhlna+0G
         kKXj+yQoVINDY0KsZktN3N3tcNoyaZfWIH68kkNXLbbobkLme4Jl65fWWIsurP6STk1f
         FSLwRr6RaJLSg8cBkcuBvX3waRlk6Mmurg1BPxwHhAjTTSd5uo3zlM+YmFFb7+Xy5B41
         QD0FCb195ccHGSMEFrMahNwveXCplSA3cS2MW3di9HuxkFcQycWsksi47ycXQOcoGGPA
         pXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772207442; x=1772812242;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bgyLFJFx45R9Tx2zeV1jBQm6wqAlhI4vWuYhi09yi1s=;
        b=QWPbH9O9jC2QCJXZ0+Cqrhc/4FKvSPCG3ZMrdNEInuR5MLj0chL1mxY40f7d0TsnNU
         L+tAPcAYT4pMD8t3ixpzVy3m+81MTngFLJRobu4TVZYyCXQn/QhP5z0AkETLFbJzS32p
         a0PRBGGKjlt5pcpySNv5EPUzcp0uWYHlCcZusJe9pVMEpd4ge4vgTeGLEC0PymnXdgDQ
         BjC6KGEZCNWlJf1vGq2oTESR9IlaNuhcMQGeBLJhYhF9fXYhTk+a10h1x7gKZ8jnMiAh
         FlE9l+60vIDJ/993UQL8Mwj9CFCj7Y+HggXLdSqs05z6iqhngOyGbD3yvO4L77mzHlZr
         /Zbg==
X-Forwarded-Encrypted: i=1; AJvYcCWaq6XApDYbSqzmeTnhUXAe1AtDTLfXAOtv3VyE+KqVLkCmv+Qg3vPPzMCISkbwv8UtleU=@vger.kernel.org
X-Gm-Message-State: AOJu0YymBGPIFIS+xwIuxn1K2Pmy42AH/YEaskQOlZV4HUfWfO6MpZ93
	tzNC1VuO0vIY/nVvqF6nnfWxbvg9piWb14z8O4FLyB7Yh4owk14AhmR0PIrIZtHmIQc=
X-Gm-Gg: ATEYQzxl2aS5XqEBLfxWbTK77IIx9mpBwTJMd1OCmAW2KZZU4R+T37Pr8cbuKT5rb3n
	7VsPpd54VwD/X+Btj8C2UdeWhvt6E0y/itH+lIMLkj0ENV4d6xJ6PhLJJc5xb//B+flS6s0mXxc
	7VpYbMJ12gUQBw6tfOaetwqRYbSUs+AQBnhLx3ITZwsJc8SsSlJAw4yNd/q+ozPXVAEZ9cLPBrG
	B/nOarG7yPJlOjY/ZUg3dIcV0IJSH06Wfs5x8iJQLxhoHYlOwauDc5qm/dFKOVfqqBJE5zdCzBA
	VEA0Y0jJTGn/gvKTzTRGrY7c0JY44+vEY0zXji278xFLmgi5wtJ7REz7wCHo7fRmLqNps+pQGsV
	8IRxOCBVdU/DiiV3hXSK9iUeibLwkQ4QKa1743YtAAnJgzIq945MnMLIJ5rsRuoMTZqsn+aaR4O
	4Y92mGfysPbIQ36FESDeG5tqNfoE/jASs6xg==
X-Received: by 2002:a05:6214:e86:b0:880:48bc:e08f with SMTP id 6a1803df08f44-899d1e346cfmr52683106d6.40.1772207442124;
        Fri, 27 Feb 2026 07:50:42 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c7159b44sm43706456d6.9.2026.02.27.07.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 07:50:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Feb 2026 10:50:40 -0500
Message-Id: <DGPV3UPSTRSK.1QB5KADDS30GS@etsalapatis.com>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <martin.lau@kernel.org>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 1/5] bpf: Factor out program return value
 calculation
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260227154616.6846-1-emil@etsalapatis.com>
 <20260227154616.6846-2-emil@etsalapatis.com>
In-Reply-To: <20260227154616.6846-2-emil@etsalapatis.com>

On Fri Feb 27, 2026 at 10:46 AM EST, Emil Tsalapatis wrote:
> Factor the return value range calculation logic in check_return_code
> out of the function in preparation for separating the return value
> validation logic for BPF_EXIT and bpf_throw().
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  include/linux/bpf_verifier.h |   1 +
>  kernel/bpf/verifier.c        | 225 +++++++++++++++++++----------------
>  2 files changed, 126 insertions(+), 100 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index ef8e45a362d9..0e639613d8cf 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -266,6 +266,7 @@ struct bpf_reference_state {
>  struct bpf_retval_range {
>  	s32 minval;
>  	s32 maxval;
> +	bool return_32bit;
>  };
> =20
>  /* state of the program:
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index edf5342b982f..6cf2270c343c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2925,7 +2925,11 @@ static void init_reg_state(struct bpf_verifier_env=
 *env,
> =20
>  static struct bpf_retval_range retval_range(s32 minval, s32 maxval)
>  {
> -	return (struct bpf_retval_range){ minval, maxval };
> +	/*=20
> +	 * return_32bit is set to false by default and set explicitly
> +	 * by the caller when necessary.=20
> +	 */
> +	return (struct bpf_retval_range){ minval, maxval, false };
>  }
> =20
>  #define BPF_MAIN_FUNC (-1)
> @@ -11146,10 +11150,9 @@ static bool in_rbtree_lock_required_cb(struct bp=
f_verifier_env *env)
>  	return is_rbtree_lock_required_kfunc(kfunc_btf_id);
>  }
> =20
> -static bool retval_range_within(struct bpf_retval_range range, const str=
uct bpf_reg_state *reg,
> -				bool return_32bit)
> +static bool retval_range_within(struct bpf_retval_range range, const str=
uct bpf_reg_state *reg)
>  {
> -	if (return_32bit)
> +	if (range.return_32bit)
>  		return range.minval <=3D reg->s32_min_value && reg->s32_max_value <=3D=
 range.maxval;
>  	else
>  		return range.minval <=3D reg->smin_value && reg->smax_value <=3D range=
.maxval;
> @@ -11193,7 +11196,7 @@ static int prepare_func_exit(struct bpf_verifier_=
env *env, int *insn_idx)
>  			return err;
> =20
>  		/* enforce R0 return value range, and bpf_callback_t returns 64bit */
> -		if (!retval_range_within(callee->callback_ret_range, r0, false)) {
> +		if (!retval_range_within(callee->callback_ret_range, r0)) {
>  			verbose_invalid_scalar(env, r0, callee->callback_ret_range,
>  					       "At callback return", "R0");
>  			return -EINVAL;
> @@ -17837,6 +17840,115 @@ static int check_ld_abs(struct bpf_verifier_env=
 *env, struct bpf_insn *insn)
>  	return 0;
>  }
> =20
> +
> +static bool return_retval_range(struct bpf_verifier_env *env, struct bpf=
_retval_range *range)
> +{
> +	enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
> +
> +	/* Default return value range. */
> +	*range =3D retval_range(0, 1);
> +
> +	switch (prog_type) {
> +	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
> +		switch (env->prog->expected_attach_type) {
> +		case BPF_CGROUP_UDP4_RECVMSG:
> +		case BPF_CGROUP_UDP6_RECVMSG:
> +		case BPF_CGROUP_UNIX_RECVMSG:
> +		case BPF_CGROUP_INET4_GETPEERNAME:
> +		case BPF_CGROUP_INET6_GETPEERNAME:
> +		case BPF_CGROUP_UNIX_GETPEERNAME:
> +		case BPF_CGROUP_INET4_GETSOCKNAME:
> +		case BPF_CGROUP_INET6_GETSOCKNAME:
> +		case BPF_CGROUP_UNIX_GETSOCKNAME:
> +			*range =3D retval_range(1, 1);
> +			break;
> +		case BPF_CGROUP_INET4_BIND:
> +		case BPF_CGROUP_INET6_BIND:
> +			*range =3D retval_range(0, 3);
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	case BPF_PROG_TYPE_CGROUP_SKB:
> +		if (env->prog->expected_attach_type =3D=3D BPF_CGROUP_INET_EGRESS)
> +			*range =3D retval_range(0, 3);
> +		break;
> +	case BPF_PROG_TYPE_CGROUP_SOCK:
> +	case BPF_PROG_TYPE_SOCK_OPS:
> +	case BPF_PROG_TYPE_CGROUP_DEVICE:
> +	case BPF_PROG_TYPE_CGROUP_SYSCTL:
> +	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
> +		break;
> +	case BPF_PROG_TYPE_RAW_TRACEPOINT:
> +		if (!env->prog->aux->attach_btf_id)
> +			return false;
> +		*range =3D retval_range(0, 0);
> +		break;
> +	case BPF_PROG_TYPE_TRACING:
> +		switch (env->prog->expected_attach_type) {
> +		case BPF_TRACE_FENTRY:
> +		case BPF_TRACE_FEXIT:
> +		case BPF_TRACE_FSESSION:
> +			*range =3D retval_range(0, 0);
> +			break;
> +		case BPF_TRACE_RAW_TP:
> +		case BPF_MODIFY_RETURN:
> +			return false;
> +		case BPF_TRACE_ITER:
> +			break;
> +		default:
> +		}
> +		break;
> +	case BPF_PROG_TYPE_KPROBE:
> +		switch (env->prog->expected_attach_type) {
> +		case BPF_TRACE_KPROBE_SESSION:
> +		case BPF_TRACE_UPROBE_SESSION:
> +			break;
> +		default:
> +			return false;
> +		}
> +		break;
> +	case BPF_PROG_TYPE_SK_LOOKUP:
> +		*range =3D retval_range(SK_DROP, SK_PASS);
> +		break;
> +
> +	case BPF_PROG_TYPE_LSM:
> +		if (env->prog->expected_attach_type !=3D BPF_LSM_CGROUP) {
> +			/* no range found, any return value is allowed */
> +			if (!get_func_retval_range(env->prog, range))
> +				return false;
> +			/* no restricted range, any return value is allowed */
> +			if (range->minval =3D=3D S32_MIN && range->maxval =3D=3D S32_MAX)
> +				return false;
> +			range->return_32bit =3D true;
> +		} else if (!env->prog->aux->attach_func_proto->type) {
> +			/* Make sure programs that attach to void
> +			 * hooks don't try to modify return value.
> +			 */
> +			*range =3D retval_range(1, 1);
> +		}
> +		break;
> +
> +	case BPF_PROG_TYPE_NETFILTER:
> +		*range =3D retval_range(NF_DROP, NF_ACCEPT);
> +		break;
> +	case BPF_PROG_TYPE_STRUCT_OPS:
> +		*range =3D retval_range(0, 0);
> +		break;
> +	case BPF_PROG_TYPE_EXT:
> +		/* freplace program can return anything as its return value
> +		 * depends on the to-be-replaced kernel func or bpf program.
> +		 */
> +	default:
> +		return false;
> +	}
> +
> +	/* Continue calculating. */
> +
> +	return true;
> +}
> +
>  static int check_return_code(struct bpf_verifier_env *env, int regno, co=
nst char *reg_name)
>  {
>  	const char *exit_ctx =3D "At program exit";
> @@ -17845,7 +17957,7 @@ static int check_return_code(struct bpf_verifier_=
env *env, int regno, const char
>  	struct bpf_reg_state *reg =3D reg_state(env, regno);
>  	struct bpf_retval_range range =3D retval_range(0, 1);
>  	enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
> -	int err;
> +	int ret, err;
>  	struct bpf_func_state *frame =3D env->cur_state->frame[0];
>  	const bool is_subprog =3D frame->subprogno;
>  	bool return_32bit =3D false;
> @@ -17856,7 +17968,7 @@ static int check_return_code(struct bpf_verifier_=
env *env, int regno, const char
>  		switch (prog_type) {
>  		case BPF_PROG_TYPE_LSM:
>  			if (prog->expected_attach_type =3D=3D BPF_LSM_CGROUP)
> -				/* See below, can be 0 or 0-1 depending on hook. */
> +				/* See return_retval_range, can be 0 or 0-1 depending on hook. */
>  				break;
>  			if (!prog->aux->attach_func_proto->type)
>  				return 0;
> @@ -17914,101 +18026,14 @@ static int check_return_code(struct bpf_verifi=
er_env *env, int regno, const char
>  		return 0;
>  	}
> =20
> -	switch (prog_type) {
> -	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
> -		if (env->prog->expected_attach_type =3D=3D BPF_CGROUP_UDP4_RECVMSG ||
> -		    env->prog->expected_attach_type =3D=3D BPF_CGROUP_UDP6_RECVMSG ||
> -		    env->prog->expected_attach_type =3D=3D BPF_CGROUP_UNIX_RECVMSG ||
> -		    env->prog->expected_attach_type =3D=3D BPF_CGROUP_INET4_GETPEERNAM=
E ||
> -		    env->prog->expected_attach_type =3D=3D BPF_CGROUP_INET6_GETPEERNAM=
E ||
> -		    env->prog->expected_attach_type =3D=3D BPF_CGROUP_UNIX_GETPEERNAME=
 ||
> -		    env->prog->expected_attach_type =3D=3D BPF_CGROUP_INET4_GETSOCKNAM=
E ||
> -		    env->prog->expected_attach_type =3D=3D BPF_CGROUP_INET6_GETSOCKNAM=
E ||
> -		    env->prog->expected_attach_type =3D=3D BPF_CGROUP_UNIX_GETSOCKNAME=
)
> -			range =3D retval_range(1, 1);
> -		if (env->prog->expected_attach_type =3D=3D BPF_CGROUP_INET4_BIND ||
> -		    env->prog->expected_attach_type =3D=3D BPF_CGROUP_INET6_BIND)
> -			range =3D retval_range(0, 3);
> -		break;
> -	case BPF_PROG_TYPE_CGROUP_SKB:
> -		if (env->prog->expected_attach_type =3D=3D BPF_CGROUP_INET_EGRESS) {
> -			range =3D retval_range(0, 3);
> -			enforce_attach_type_range =3D tnum_range(2, 3);
> -		}
> -		break;
> -	case BPF_PROG_TYPE_CGROUP_SOCK:
> -	case BPF_PROG_TYPE_SOCK_OPS:
> -	case BPF_PROG_TYPE_CGROUP_DEVICE:
> -	case BPF_PROG_TYPE_CGROUP_SYSCTL:
> -	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
> -		break;
> -	case BPF_PROG_TYPE_RAW_TRACEPOINT:
> -		if (!env->prog->aux->attach_btf_id)
> -			return 0;
> -		range =3D retval_range(0, 0);
> -		break;
> -	case BPF_PROG_TYPE_TRACING:
> -		switch (env->prog->expected_attach_type) {
> -		case BPF_TRACE_FENTRY:
> -		case BPF_TRACE_FEXIT:
> -		case BPF_TRACE_FSESSION:
> -			range =3D retval_range(0, 0);
> -			break;
> -		case BPF_TRACE_RAW_TP:
> -		case BPF_MODIFY_RETURN:
> -			return 0;
> -		case BPF_TRACE_ITER:
> -			break;
> -		default:
> -			return -ENOTSUPP;
> -		}
> -		break;
> -	case BPF_PROG_TYPE_KPROBE:
> -		switch (env->prog->expected_attach_type) {
> -		case BPF_TRACE_KPROBE_SESSION:
> -		case BPF_TRACE_UPROBE_SESSION:
> -			range =3D retval_range(0, 1);
> -			break;
> -		default:
> -			return 0;
> -		}
> -		break;
> -	case BPF_PROG_TYPE_SK_LOOKUP:
> -		range =3D retval_range(SK_DROP, SK_PASS);
> -		break;
> +	if (prog_type =3D=3D BPF_PROG_TYPE_STRUCT_OPS && !ret_type)
> +		return 0;
> =20
> -	case BPF_PROG_TYPE_LSM:
> -		if (env->prog->expected_attach_type !=3D BPF_LSM_CGROUP) {
> -			/* no range found, any return value is allowed */
> -			if (!get_func_retval_range(env->prog, &range))
> -				return 0;
> -			/* no restricted range, any return value is allowed */
> -			if (range.minval =3D=3D S32_MIN && range.maxval =3D=3D S32_MAX)
> -				return 0;
> -			return_32bit =3D true;
> -		} else if (!env->prog->aux->attach_func_proto->type) {
> -			/* Make sure programs that attach to void
> -			 * hooks don't try to modify return value.
> -			 */
> -			range =3D retval_range(1, 1);
> -		}
> -		break;
> +	if (prog_type =3D=3D BPF_PROG_TYPE_CGROUP_SKB && (env->prog->expected_a=
ttach_type =3D=3D BPF_CGROUP_INET_EGRESS))
> +		enforce_attach_type_range =3D tnum_range(2, 3);

Note: I've kept the range and subsequent check as-is, but it's not actually
correct - the check below does tnum_in(enforce_attach_type_range,
var_off) when it should be tnum_overlap(). I will fix this in a separate
series since it definitely needs a selftest and is unrelated to void
globals.

> =20
> -	case BPF_PROG_TYPE_NETFILTER:
> -		range =3D retval_range(NF_DROP, NF_ACCEPT);
> -		break;
> -	case BPF_PROG_TYPE_STRUCT_OPS:
> -		if (!ret_type)
> -			return 0;
> -		range =3D retval_range(0, 0);
> -		break;
> -	case BPF_PROG_TYPE_EXT:
> -		/* freplace program can return anything as its return value
> -		 * depends on the to-be-replaced kernel func or bpf program.
> -		 */
> -	default:
> +	if (!return_retval_range(env, &range))
>  		return 0;
> -	}
> =20
>  enforce_retval:
>  	if (reg->type !=3D SCALAR_VALUE) {
> @@ -18021,7 +18046,7 @@ static int check_return_code(struct bpf_verifier_=
env *env, int regno, const char
>  	if (err)
>  		return err;
> =20
> -	if (!retval_range_within(range, reg, return_32bit)) {
> +	if (!retval_range_within(range, reg)) {
>  		verbose_invalid_scalar(env, reg, range, exit_ctx, reg_name);
>  		if (!is_subprog &&
>  		    prog->expected_attach_type =3D=3D BPF_LSM_CGROUP &&

