Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3D62E3FE;
	Wed,  8 Jul 2026 04:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783485741; cv=none; b=SgZTWEXgHFgLh03nv//03yrDSAHSGRAtJSn55WMuIVWlnG8hvDd3JzsszJN8ogN/TOx7RmCyj7lalXcskqihd+3bJ7HYiqYklmu2Af5Yl1++SRaKtqoHj31ceK7qUxPxnfOOO56wbqT0Fsu4s9A9EZsicHtBLjOCWqEzipeMrTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783485741; c=relaxed/simple;
	bh=79+ex2c9Pieqbb0+NMiFAeBJ3A5sW2moAM2XWxYkstw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Dd4PBwpnc/tjwlUXSIibLSlWZZyw/QxplwfaKrMkGWibjgKqD2WmtJUkVRmQb54kgZ1KDCc17k0vT5EjdDIIZUsUHt27WaXkH4N1s19qAJecJbQMLl4vNCuuL34e5thb8ud1+uKgDgyxavq6kfbDSY7ZdfKe0KsiP3LxDVzkgjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gykc6LN6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gykc6LN6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DD91F000E9;
	Wed,  8 Jul 2026 04:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783485740;
	bh=MYjFR9jcIYhbAm1/GxFAGaXfO/W0gwVDGYlJBACcg4g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Gykc6LN6C7pwlaKxSHNeHiSIyt1+KMoEOWZ2Sggz9XkvsdcVdJ4gD/M4SQhVLIIHc
	 d+84VVHy5lPVl5aBsP928Km0ebCSXlHDoddir1SIGCI5qyCdos/AL/Hd6bLXU3fehm
	 mhRNfKgZ3l0EzyjIqyaHBSMq5SAEu+cPpMcSC/6eYGDbE70jqpf0iq5VjKK8+W+DHC
	 FT7gAV9+dKkSWtJDz8ZaxqCUduw49LvO5Tv4DqRj0Rse7hTTZWj6AEZi7kayvsUfJ2
	 6QOsz12uawXb4lrJgUakSqY6GAMes+Dc97XOA9g4vCFZkzOV8VKegnDd6uKNrOpqgm
	 LLhkE+Eaz2Sng==
Content-Type: multipart/mixed; boundary="===============7892239390717537072=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <43f29a2271718165322087a79c7e81f2b9ee4ad25581ad37c9c87e8348fd6df3@mail.kernel.org>
In-Reply-To: <20260708040715.116680-2-sun.jian.kdev@gmail.com>
References: <20260708040715.116680-2-sun.jian.kdev@gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: Reject negative const offsets for buffer pointers
From: bot+bpf-ci@kernel.org
To: sun.jian.kdev@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,mmullins@fb.com,shung-hsi.yu@suse.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,sun.jian.kdev@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  8 Jul 2026 04:42:20 +0000 (UTC)

--===============7892239390717537072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> The verifier rejects variable offsets for PTR_TO_TP_BUFFER and PTR_TO_BUF
> accesses, but it currently accepts a constant negative offset produced by
> pointer arithmetic.
>
> For example, a raw tracepoint writable program can load ctx[0] as a
> PTR_TO_TP_BUFFER, move it by -8, and then access the adjusted pointer.
> The access is before the tracepoint writable buffer base and should be
> rejected.
>
> Keep rejecting negative instruction offsets explicitly. Once the register
> offset is known to be constant, reject const var_off values outside the
> same +/-BPF_MAX_VAR_OFF range used by other verifier pointer offset
> checks before computing the effective access range.
>
> Fixes: 9df1c28bb752 ("bpf: add writable context for raw tracepoints")
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>

The Fixes: tag points at 9df1c28bb752 ("bpf: add writable context for
raw tracepoints"), but does that commit actually have this bug?

The code it introduced rejected any non-zero offset with:

	if (!tnum_is_const(reg->var_off) || reg->var_off.value)

and a negative constant offset from pointer arithmetic was tracked in
reg->off and caught by the off < 0 check.

The constant negative offset became accepted later when
022ac0750883 ("bpf: use reg->var_off instead of reg->off for pointers")
folded static and varying offsets into reg->var_off and dropped the
|| reg->var_off.value guard, leaving:

	if (!tnum_is_const(reg->var_off))

so a constant negative offset now stored in reg->var_off.value is no
longer rejected. Should the tag instead be:

  Fixes: 022ac0750883 ("bpf: use reg->var_off instead of reg->off for pointers")

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6515d4d3c003..7bcbcd43cc37 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5326,14 +5326,19 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
>  static int __check_buffer_access(struct bpf_verifier_env *env,
>  				 const char *buf_info,
>  				 const struct bpf_reg_state *reg,
> -				 argno_t argno, int off, int size)
> +				 argno_t argno, int off, int size,
> +				 u32 *access_end)
>  {
> +	s64 start, var_off;
> +	u64 end;
> +
>  	if (off < 0) {
>  		verbose(env,
>  			"%s invalid %s buffer access: off=%d, size=%d\n",
>  			reg_arg_name(env, argno), buf_info, off, size);
>  		return -EACCES;
>  	}
> +
>  	if (!tnum_is_const(reg->var_off)) {
>  		char tn_buf[48];
>
> @@ -5344,6 +5349,36 @@ static int __check_buffer_access(struct bpf_verifier_env *env,
>  		return -EACCES;
>  	}
>
> +	var_off = (s64)reg->var_off.value;
> +	if (var_off >= BPF_MAX_VAR_OFF || var_off <= -BPF_MAX_VAR_OFF) {
> +		verbose(env, "%s %s buffer offset %lld is not allowed\n",
> +			reg_arg_name(env, argno), buf_info, var_off);
> +		return -EACCES;
> +	}
> +
> +	start = var_off + off;
> +	if (start < 0) {
> +		verbose(env,
> +			"%s invalid negative %s buffer offset: off=%d, var_off=%lld\n",
> +			reg_arg_name(env, argno), buf_info, off, var_off);
> +		return -EACCES;
> +	}
> +
> +	if (size < 0) {
> +		verbose(env, "%s invalid %s buffer access: off=%lld, size=%d\n",
> +			reg_arg_name(env, argno), buf_info, start, size);
> +		return -EACCES;
> +	}
> +
> +	end = (u64)start + (u64)size;
> +	if (end > U32_MAX) {
> +		verbose(env, "%s invalid %s buffer access: off=%lld, size=%d\n",
> +			reg_arg_name(env, argno), buf_info, start, size);
> +		return -EACCES;
> +	}

Now that var_off is bounded within +/-BPF_MAX_VAR_OFF and start is
checked to be non-negative, can end > U32_MAX ever be true here?

With off capped at S16_MAX and size at 8, start + size stays well below
U32_MAX, so is the end > U32_MAX check reachable?  This is the same
point raised in review of an earlier version, and the BPF_MAX_VAR_OFF
bound was added while this overflow check was kept.

> +
> +	*access_end = (u32)end;
> +
>  	return 0;
>  }

[ ... ]

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28916895865
--===============7892239390717537072==--
