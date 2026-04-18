Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCE82D46C0
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776534135; cv=none; b=cX3vrsInwoo5aZqbfcSRvjsleTL1cTsGr9OVXCsLf9C2CaXBeypU35TSb+COdhyPLfja9t/1IVO6MuJ86ZdlVj3ACl4bm4Na5n/yIzkho6FczmtJMhRLhM6AKh/sjXo8qC5n1osjLhFJT5yfC9vz+uVVXiThZm4lRf65DVG6Df0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776534135; c=relaxed/simple;
	bh=sIVYyF80pYJnY5u5XstEH81Gw6YWhvoFQ0Pr7pnmsCE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lpuF8Ndvazy4znt0HaKFLcS+Yqj8AD4XpcpgxhsQMWOY9Vfp2FkBNBBii/tMMyNTSF9Llgg4sc24mH5IXG2Hsv+3a/yqqcnaUKfDFJDMOa63R5ffSYD/6Re5wLbC0a8Iy/XOcVOEwfpV5GBSDovVStNeM7C5WfqLRReG4/pJeyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z80PbQip; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z80PbQip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A764C19424;
	Sat, 18 Apr 2026 17:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776534134;
	bh=sIVYyF80pYJnY5u5XstEH81Gw6YWhvoFQ0Pr7pnmsCE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Z80PbQipHnfMIJFcSZJzEXCf0Uqlo9BWvfdms81vry9Jl7rj6T5bGcl2UJzUfScoO
	 dC5bg+41h2KQ5Jb4N2eW04VGT4XmVnrEsT+HcTor1rgOgHdNVFN/UXlWhPUVAjOL6j
	 UB9B4eH4iSWefNLQFy0UgmYIh4+pqmzscm/wMg/zaOvWGpWhQF10RHjeziZehIHemK
	 J6SPgsAAFlUZjKgx/SCSbhXm4G8uSIjyKmdlCbrADmPw5GBCbuF6p4lVK0pFh1tb8i
	 ipLgppNZ6vjo8i0sj+MjaWOFPWCperBKYTC7MX11AOnx0nKB3S5C7TB6nSHzfjiwhA
	 N9pQd/vhNWaEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 1/4] bpf: Add support for verifier warning
 messages
Reply-To: sashiko@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260418171701.610025-2-memxor@gmail.com>
References: <20260418171701.610025-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Apr 2026 17:42:13 +0000
Message-Id: <20260418174214.1A764C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Unused static function `warn()` breaks the build and bisection.
- [High] Disabling log reset completely after a warning leads to log buffer=
 explosion and overwrites the warning when combined with `BPF_LOG_LEVEL1`.
--

commit 35e5ff3f696c81863084f9e6fb58225f8242f3e0
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Add support for verifier warning messages

This commit adds a mode where log_level 16 can be used to receive warnings
and have an associated log buffer. It introduces a warn function and
aggregates warnings to decide whether to reset the log.

> Add a warn() macro that emits messages to log
> buffer without any restrictions, aggregate the warnings emitted, and

This isn't a bug, but the commit message states it adds a warn() macro
when a static function is actually added.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 69d75515ed3f7..8de2a4e5f5de2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -282,6 +283,20 @@ __printf(2, 3) static void verbose(void *private_dat=
a, const char *fmt, ...)
>  	va_end(args);
>  }
> =20
> +__printf(2, 3) static void warn(void *private_data, const char *fmt, ...)
> +{
> +	struct bpf_verifier_env *env =3D private_data;
> +	va_list args;
> +
> +	if (!bpf_verifier_warn_needed(&env->log))
> +		return;
> +
> +	va_start(args, fmt);
> +	bpf_verifier_vlog(&env->log, fmt, args);
> +	va_end(args);
> +	env->warnings =3D true;
> +}

Is this static function called anywhere in this patch?

Unused static functions trigger a -Wunused-function compiler warning, which
can break builds when CONFIG_WERROR is enabled.

[ ... ]

> @@ -1683,7 +1698,8 @@ static int pop_stack(struct bpf_verifier_env *env, =
int *prev_insn_idx,
>  		if (err)
>  			return err;
>  	}
> -	if (pop_log)
> +	/* Preserve warning output across branch explorations. */
> +	if (pop_log && !(env->warnings && bpf_verifier_warn_needed(&env->log)))
>  		bpf_vlog_reset(&env->log, head->log_pos);
>  	if (insn_idx)
>  		*insn_idx =3D head->insn_idx;

Can this completely disable log resets once a warning is emitted?

If a user requests both standard logging and warning logging, both verbose()
and warn() will actively write to the log buffer.

If log pruning is permanently disabled after the first warning, will the
verifier dump the state of every successfully verified instruction into the
log for all subsequent branch explorations?

Because the log buffer acts as a rotating buffer by default, could this
flood of output wrap around and overwrite the warning that was meant to be
preserved?

Would it be better to track the log position of the warning and reset to
the maximum of head->log_pos and the warning position?

[ ... ]

> @@ -18803,7 +18819,8 @@ static int do_check_common(struct bpf_verifier_en=
v *env, int subprog)
> =20
>  	ret =3D do_check(env);
>  out:
> -	if (!ret && pop_log)
> +	if (!ret && pop_log &&
> +	    !(env->warnings && bpf_verifier_warn_needed(&env->log)))
>  		bpf_vlog_reset(&env->log, 0);
>  	free_states(env);
>  	return ret;

Could the same log buffer wrapping issue happen here when log resets are
disabled after a warning?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260418171701.6100=
25-1-memxor@gmail.com?part=3D1
