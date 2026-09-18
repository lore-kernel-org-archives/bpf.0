Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABEA48C41A
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 06:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713339; cv=none; b=sIo8sMBU/SnJo8zBiLJKVCjCl7FksQ4FGPNHsVJWf+zzReqyt7r8HEDMNc0d409yIoGTnxawCbT2Q9dPsmz/ELXf3ew6KzZGfzGn6LgqRpHGwY2/Z1yB3typG/nuTLYcTQT8vcYkF0Q1j9TohxPKW044wlkyPRUT9tzS9z8me34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713339; c=relaxed/simple;
	bh=hb1oRBZjvT9KOQm7KpyL+INEUM+PbN/l0HcYXQbnEQA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ssXA4wbDrlH7LPoe6b6rGwtxn8MxXbhtCpQoc1t959MesInsIj20TUvDDu17V2fPS0cp8f+xKpMcLT/lNril+U7vr/2MXN0NxmBDJ5f5Ze5FgrZhqRQliqULvcDF3KZMUP0LU1KpFYpJYudRjUcl6taAtZ33jZcgInyKKlS6tUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhnCx0EK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhnCx0EK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503D91F00893;
	Fri, 18 Sep 2026 06:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789713337;
	bh=IaPG8+902phrNKrnid5V2UHEHYehjuORcqI+V0wyzlg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IhnCx0EKG2COQssGaxDJfvfUdNTlq9duF5Ab4g8roMtZrDd+P/68SHx2JpIIHdrmK
	 ghvk+ZwlGlmpSrGODrhFBK4N73HCdslTN6taIXmYvYZaHfkIMhYWg6MOTDD70V5F7W
	 3iW6mvkqvvsNXkI2+sGxGdcwLsIZJZsmz4rYaKNLEiqjFEbChzIjjnYX5/uREdzrSX
	 VEjJmebrPEudq8w48WD+E3QAaNqRb6beXSYnCURdoZ42rBVahYFPDAwaA8nZGurUWM
	 7RLkvdYd6PsNIWcGK9Gw6h6h4c/1TqyykvrFMbD8z3nkBvmNlP5PtRZrqJpStoIMSf
	 4WKwSBYwcRuIA==
Content-Type: multipart/mixed; boundary="===============7561015491005450309=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0ddd64a1da65d48b189f5a88ccee3d5544fb503c715d4881bc63b8176cb27a54@mail.kernel.org>
In-Reply-To: <20260918052906.12226-3-memxor@gmail.com>
References: <20260918052906.12226-3-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Record raw memory arguments during argument checking
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,emil@etsalapatis.com,tj@kernel.org,ameryhung@gmail.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 18 Sep 2026 06:35:36 +0000 (UTC)

--===============7561015491005450309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6c6b8d8520cdf..1d5e4ee64fc00 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -7215,7 +7215,8 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
>  	 * raw mode so that the program is required to initialize all
>  	 * the memory that the helper could just partially fill up.
>  	 */
> -	if (!tnum_is_const(size_reg->var_off))
> +	if (!tnum_is_const(size_reg->var_off) &&
> +	    meta->arg_raw_mem.regno == reg_from_argno(mem_argno))
>  		meta->arg_raw_mem.regno = 0;

This isn't a bug, but would it help to say which helpers this actually
changes (bpf_strtol/bpf_strtoul/bpf_kallsyms_lookup_name, where the
unrelated variable-length input is checked before the output is recorded)
and that the effect is to stop withdrawing raw mode from their output
buffer?

The commit message states that an unrelated memory argument must not
discard the output's identity after its initialization size has been
recorded. Scanning the existing helper protos, the three that have both
an unrelated variable-size pair and a MEM_UNINIT output all place the
variable-size input before the output:

  bpf_strtol_proto / bpf_strtoul_proto (kernel/bpf/helpers.c)
  bpf_kallsyms_lookup_name_proto (kernel/bpf/syscall.c)
    .arg1_type = ARG_PTR_TO_MEM | MEM_RDONLY,
    .arg2_type = ARG_MEM_SIZE[_OR_ZERO],
    .arg4_type = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | ...

So the observable effect today is the opposite ordering: a variable
buf_len / name_sz no longer withdraws raw mode from the arg4 output
buffer.

[ ... ]

> @@ -8929,6 +8930,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
>  	if (err)
>  		return err;
>
> +	if (!meta->btf && (arg_type & MEM_UNINIT) &&
> +	    (base_type(arg_type) == ARG_PTR_TO_MEM ||
> +	     base_type(arg_type) == ARG_PTR_TO_MAP_VALUE))
> +		meta->arg_raw_mem.regno = slot + 1;

This isn't a bug, but could this reuse arg_type_is_raw_mem() (defined at
verifier.c:8155) so the recording site and check_raw_mode_ok() share one
definition of a raw memory argument, or are the two predicates meant to
diverge later in the series?

The new predicate is term-for-term the body of arg_type_is_raw_mem():

  static bool arg_type_is_raw_mem(enum bpf_arg_type type)
  {
      return (base_type(type) == ARG_PTR_TO_MEM ||
              base_type(type) == ARG_PTR_TO_MAP_VALUE) &&
             type & MEM_UNINIT;
  }

which is still used by check_raw_mode_ok().

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35311871659
--===============7561015491005450309==--
