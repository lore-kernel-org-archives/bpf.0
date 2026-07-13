Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922C72C21EE
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957884; cv=none; b=qP0v6eU8DKe1UI9irfbCTIwrHBTrG5qpUwmtuBTDCXM3/BQb480MWQq0ZRy+BWMxp8VEoNMcEVzj351ZnvFOnRzrNjkb7zBijgvuZsLekCTSgROKqIPvNhcHvOPHPhTKN5bftENx4eV6jbkYpZ9NxOBeNysRGFE03vyrk+jK02c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957884; c=relaxed/simple;
	bh=R1LiTRoY7ixo8HhWU6sxZ76nGiO0oouR7gwuRJetu8I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eX/JbJ725asEDIqkJytfbRG3uVSO3xoajAZAbwSxEXtXQVYjlkQIwvjti3srl6aGAoCqBT1honJS0sj+0/dW57/A6iAbL6GWjvAJL5AJUn0EbP/L1pBa6QPrxXouKjNQ4FTzCVVIy33dOmdyCMWt2kTvwIf8dL7YcezaZTCFWEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEo3dbLm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEo3dbLm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086141F000E9;
	Mon, 13 Jul 2026 15:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783957883;
	bh=BraFKaiom+YXgAxOZC2R5jq262yVEHZ/hbJzpJ7CPXI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oEo3dbLm0nkPyrgLuPQyvcOEj3ZhrtfEqZVKzfVPLgycfHLdkJjWo1o3TFQ1Vvpcu
	 roYT7WnKPv2Xe8fsFUBfU6N78l55kVXoBv1ZHiCMasEqw2a2r4EHptDB4IwEWnhw1G
	 mhaAIqY4kI2jkbcQP5didPGma1/jRuxlgLL5uPKok9CQEZm5JmveSMTiKeuirAWn9u
	 8K0iGNXezseIU2Matjp4eNNrYjR3u44AaAo2BuTV7MyC41ewwFLbkVPHGNjw9DQ7Mv
	 XFep0bUg7jazZDgnHXyhsG9C/DoFTPsqTvEGCCnpDDdyIGRm5MdDvrvKDbQmO3XmQS
	 i+f0rcjRUmN4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 11/17] bpf: Report Call Type Safety argument
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260713153910.2556007-12-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
 <20260713153910.2556007-12-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 15:51:22 +0000
Message-Id: <20260713155123.086141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incorrect function name reported in NULL pointer diagnostic for =
global subprograms
--

--- Patch [11]: [PATCH bpf-next v3 11/17] bpf: Report Call Type Safety argu=
ment errors ---
commit 42278ddf76eadbac6e7b1b29c475b084fe058a97
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Report Call Type Safety argument errors

Augment selected helper and kfunc argument-contract failures with Call Type
Safety reports. Keep the existing terse verifier messages and add reason,
source context, causal register or stack-argument history, and targeted
suggestions.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 84eda5e83f873..07e2c1ed8fbe6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -8438,6 +8503,12 @@ static int check_reg_type(struct bpf_verifier_env =
*env, struct bpf_reg_state *re
>  		    (!type_may_be_null(arg_type) || arg_type_is_release(arg_type))) {
>  			verbose(env, "Possibly NULL pointer passed to helper %s\n",
>  				reg_arg_name(env, argno));
> +			bpf_diag_report_call_arg(env, env->insn_idx, argno,
> +						 func_id_name(meta->func_id),
                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
[Severity: Medium]
Will this produce an incorrect diagnostic for global subprograms?

When `check_reg_type()` is called from `btf_check_func_arg_match()` for a g=
lobal=20
subprogram, `meta->func_id` is explicitly zeroed and the subprogram name is=
=20
passed via the `call_name` parameter. By using `func_id_name(meta->func_id)=
` here=20
instead of `call_name`, won't this result in the log message printing "unsp=
ec"=20
instead of the actual global subprogram name?

> +						 "the pointer may be NULL, but this helper "
> +						 "requires a non-NULL pointer",
> +						 "Add a NULL check and call the helper only on the "
> +						 "non-NULL path.");
>  			return -EACCES;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713153910.2556=
007-1-memxor@gmail.com?part=3D11
