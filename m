Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5D53C343B;
	Thu,  4 Jun 2026 18:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780598728; cv=none; b=uy3z9WORHlyC4beoBhrXd1DuwfkpxfhOgBr4qFHPtHLnQ0+gF3HFz7I4wgC67WuwFE6JEBqS4+hiQRfNGZO/Bw6WggMm7gB5Df1nY/izGGWrH7nhjqLu2xUqk8pABm/11DVnL54qJUKc/RzsUe/2JS8mMFDt5UZ/nUI1T/h1aTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780598728; c=relaxed/simple;
	bh=bneck08iL0uAJUwehxAIYLer21vofFk57LMfT56Npas=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rnfF5NJrxNDMvYRmsyghagkwnvHSfSRbQfLghUWQGgSCfTFwdF3A6w+cqKfiqmH0BWKVZzjECRm9XR/NFtxcMkq5qK1eOSFW7h4p/HnmNTpF2BW5WiH6lvL42iLhNYFa0vzGU5DXUN1obkZKOUrNtw7b2p6uNhpWBb5QzhcvcAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhiXC83t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhiXC83t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3621F00893;
	Thu,  4 Jun 2026 18:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780598727;
	bh=JTu/rwe9drmxmdKjq/hupd33a1+QXWn0/gM7+SeFBHQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UhiXC83t7TYSe6tPaaNsnK6KNlbSWZBc2m0dXqMT9wJoMZ5fDHsKrAgeltItTZlFE
	 R1vbzpR4RgbiKoYXF/z8XltFqFDI3gEjBtinYVfGEb9jzqL4SDqwsD2Df/FeVURtxb
	 wHO8glsah0kP6t8M7ZqQOwMwCHz4RVUu6oHzOYHpZv8Z/X4S9vbakg4TJLp8usw9T9
	 g85hW5cMngfdo4TvrAIVWzWCsnwBSdEA9nQ6lyuqxS2laVCgwRB8Sh/kGOA9aiK95p
	 YjtJwwHlUc3zVrD5wccp4fZuXNGPR5U0a1O13acWT0fP4mQ3lWrZulYqMoCpyhtnuG
	 QV3LRhizeldtg==
Content-Type: multipart/mixed; boundary="===============7409798819395253037=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1ad0c6577b2590ffd933f1dd8ccf031e7f53dea7d070e9a5b61be290702b4c2f@mail.kernel.org>
In-Reply-To: <20260604180730.2518088-2-gnq25@mails.tsinghua.edu.cn>
References: <20260604180730.2518088-2-gnq25@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf-next v2 1/2] bpf, verifier: fold reg->var_off into PTR_TO_FLOW_KEYS bounds check
From: bot+bpf-ci@kernel.org
To: gnq25@mails.tsinghua.edu.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: gnq25@mails.tsinghua.edu.cn,john.fastabend@gmail.com,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  4 Jun 2026 18:45:26 +0000 (UTC)

--===============7409798819395253037==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8ed484cb1a8a..c04941636ef4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4728,9 +4728,22 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, struct b
>  	return err;
>  }
>
> -static int check_flow_keys_access(struct bpf_verifier_env *env, int off,
> -				  int size)
> +static int check_flow_keys_access(struct bpf_verifier_env *env, u32 regno,
> +				  int off, int size)
>  {
> +	struct bpf_reg_state *reg = reg_state(env, regno);
> +
> +	/* Only a constant offset is allowed here; fold it into off. */
> +	if (!tnum_is_const(reg->var_off)) {
> +		char tn_buf[48];
> +
> +		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
> +		verbose(env, "R%d invalid variable offset to flow keys: off=%d, var_off=%s\n",
> +			regno, off, tn_buf);
> +		return -EACCES;
> +	}
> +	off += reg->var_off.value;
> +
>  	if (size < 0 || off < 0 ||
>  	    (u64)off + size > sizeof(struct bpf_flow_keys)) {
>  		verbose(env, "invalid access to flow keys off=%d size=%d\n",
> @@ -6239,7 +6252,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
>  			return -EACCES;
>  		}
>
> -		err = check_flow_keys_access(env, off, size);
> +		err = check_flow_keys_access(env, regno, off, size);
                                                       ^^^^^

Does this code compile? Looking at check_mem_access(), the function signature
is:

static int check_mem_access(struct bpf_verifier_env *env, int insn_idx,
                           struct bpf_reg_state *reg, argno_t argno,
                           int off, int bpf_size, enum bpf_access_type t,
                           int value_regno, bool strict_alignment_once,
                           bool is_ldsx)

There is no 'regno' parameter or local variable. The register information is
passed as 'argno_t argno' and 'struct bpf_reg_state *reg'.

The established pattern in this file for obtaining a register number from an
argno_t is reg_from_argno(argno), used throughout verifier.c. For example:

verifier.c:1791:
    u32 regno = reg_from_argno(argno);

verifier.c:6859:
    regno = reg_from_argno(argno);

The call should be:

    err = check_flow_keys_access(env, reg_from_argno(argno), off, size);

This matches check_flow_keys_access()'s new signature where it does
reg_state(env, regno) to look up the register state, which should equal the
'reg' parameter already held by check_mem_access.

>  		if (!err && t == BPF_READ && value_regno >= 0)
>  			mark_reg_unknown(env, regs, value_regno);
>  	} else if (type_is_sk_pointer(reg->type)) {


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26970818032
--===============7409798819395253037==--
