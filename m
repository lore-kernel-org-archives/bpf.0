Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457821FE451
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 05:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775972600; cv=none; b=JLtGBDM0b1fgHKcMSLOex7JDIhzVEicEkj8wjf0HdZpUJZPxJCno2ILlwuCEPADlX9h9SRE3lZubc6PeGYs6XmegSFeJbeeJGI/k+a+D/KAET2dAAqOL/0dtMlvhRNrq2lOWttOaYw+on8334MxMh0kLy7JSiCPx8ExwT9qYYIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775972600; c=relaxed/simple;
	bh=y/+R/DTE0X9iBgzYl6Yi/IPet8C1R66+a/Zby9ztto8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DV/w7m0V9Rvu6QvfjIsyCtJJTYnIgYu0yQ4M6n3R0BN4qUQLqKB6xkALsL3Bs56Znzo4OgmGGKeY2i1rbdL1mV2IqmqdIDjcicVBSeKnTyysIw+vzlneqF9JUcpJZYIqE0cKBLw28uWr14bCWS/jY1qG7O33cMZ64UZFIoJB09M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYo1hxkN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYo1hxkN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2BCC19424;
	Sun, 12 Apr 2026 05:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775972599;
	bh=y/+R/DTE0X9iBgzYl6Yi/IPet8C1R66+a/Zby9ztto8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=XYo1hxkNkkBIKiMEW39Tg5KxYGQNudYLmipzjxby9SvSvXqODmpPFBUeFsfWbvYLS
	 /DcymGlGMMIsDIqEH96GjgKxS3jniJN1OqX7tx0udweg7pm9b9pDUNKTBktzNHh9T2
	 siQypD7fNUTgrkJxH8sKEJ4Ay7+RRf8XkjYCcPeEyFCBuCktGV6iUIDqTE2uS9AxU9
	 T0zXZISTftkJwQ+SeEMm+58ovbB0yYjaMH+zrDXznUIh36SmlGn+bZKXS2y8N2HqVi
	 cKlxR0DFu1voBE7YMPQAYxlxvVQB5sA+dyQ4jBqS8ijjdfX8qX4gBn0cHRGnQ8xciQ
	 6Oqo6fjUVQbMw==
Content-Type: multipart/mixed; boundary="===============2933192911232600193=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2783e4c4632337ff1a09e3ece084c8bce5f1672a0ec5bacf093e497ee66107a8@mail.kernel.org>
In-Reply-To: <20260412045857.256260-1-yonghong.song@linux.dev>
References: <20260412045857.256260-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 06/18] bpf: Use argument index instead of register index in kfunc verifier logs
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 12 Apr 2026 05:43:19 +0000 (UTC)

--===============2933192911232600193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 54296d818d35..01df990f841a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -8592,12 +8609,12 @@ static int check_helper_mem_access(...)
>   */
>  static int check_mem_size_reg(struct bpf_verifier_env *env,
>  			      struct bpf_reg_state *mem_reg,
> -			      struct bpf_reg_state *size_reg, int mem_regno,
> +			      struct bpf_reg_state *size_reg, int reg_or_arg,
>  			      enum bpf_access_type access_type,
>  			      bool zero_size_allowed,
>  			      struct bpf_call_arg_meta *meta)
>  {
> -	int size_regno = mem_regno + 1;
> +	int size_reg_or_arg = (reg_or_arg >= 0) ? reg_or_arg + 1 : reg_or_arg - 1;

[ ... ]

> -	err = check_helper_mem_access(env, mem_reg, mem_regno, size_reg->umax_value,
> +	err = check_helper_mem_access(env, mem_reg, reg_or_arg, size_reg->umax_value,
>  				      access_type, zero_size_allowed, meta);
> -	if (!err)
> -		err = mark_chain_precision(env, size_regno);
> +	if (!err && size_reg_or_arg > 0)
> +		err = mark_chain_precision(env, size_reg_or_arg);
>  	return err;
>  }

When called from the kfunc path via check_kfunc_mem_size_reg(),
reg_or_arg is always negative (-(mem_argno + 1)), which makes
size_reg_or_arg also negative (reg_or_arg - 1). The condition
"size_reg_or_arg > 0" is then always false, so mark_chain_precision()
is never called for kfunc mem+size argument pairs.

The old code unconditionally called mark_chain_precision(env,
size_regno) with the actual register number. With the new encoding,
precision tracking is skipped entirely on the kfunc path.

For reference, check_kfunc_mem_size_reg() constructs the negative
encoding:

> @@ -8674,14 +8691,15 @@ static int check_mem_reg(...)
>  static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env,
>                                     struct bpf_reg_state *mem_reg,
> 				    struct bpf_reg_state *size_reg,
> -				    u32 mem_regno)
> +				    u32 mem_argno)
>  {
> +	int reg_or_arg = -(int)(mem_argno + 1);

[ ... ]

> -	err = check_mem_size_reg(env, mem_reg, size_reg, mem_regno, BPF_READ, true, &meta);
> -	err = err ?: check_mem_size_reg(env, mem_reg, size_reg, mem_regno, BPF_WRITE, true, &meta);
> +	err = check_mem_size_reg(env, mem_reg, size_reg, reg_or_arg, BPF_READ, true, &meta);
> +	err = err ?: check_mem_size_reg(env, mem_reg, size_reg, reg_or_arg, BPF_WRITE, true, &meta);

Should check_mem_size_reg() still call mark_chain_precision() with
the actual register number for the kfunc path? It looks like the
precision marking was unintentionally dropped rather than being
intentionally skipped. The later commit 2d66a554f1b5 ("bpf: Support
stack arguments for kfunc calls") adds "if (regno > 0)" guards for
mark_chain_precision in check_kfunc_args() but does not address
this case in check_mem_size_reg().


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24299298635
--===============2933192911232600193==--
