Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BE936404E
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 21:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781905622; cv=none; b=kmW2/K+bTo+wEJvoRCM8MbKOl5/V4hrwwea+pzC06wtLdV2LgEjRYR6x3k2iJWd5R1dIGBh77xp1wjILiiSyPlZ0Bb11Io9nlNircSEiz9To5QeyAwjFFYL5e3I41IiD47LDGqucL1M3dVwafVfrYHscWrgWFVHpK7+4kSIG/e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781905622; c=relaxed/simple;
	bh=7D+VWczG3KgYZMN40pdq/oSyYkOj/AXJtJesYlO0VGI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UXx4enP+flxbK7H28HXeSuTzgXgUOkBaYmtMphejstRuYPXYgP7TQFDQkXsS+zAogtRaoiAyr251cdcvPfgAfrJsdy5ErfZ0Mw2nem614eqHT9EBpoK7rIKTqFLeuwkz2DmBlGoe06deE8b5tVgPAtzBlMaBviYGEqi4AGFzxhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfjfdTPX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfjfdTPX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1360B1F000E9;
	Fri, 19 Jun 2026 21:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781905621;
	bh=Mx5H40i1wuIF6ZzWUn3ZhPLCkOdRODwelEmw/FRl7V0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VfjfdTPXwIPJWS7XKjVRg5egPy1nZILd2PcPeDrFEBez6PsA8pMk3TwjLux5HTLne
	 14NJU8rsVEk92I8kTXmq5WAAE2n1CjzXjwvOSjzqHgSavHtzJiFs5pE13/Jj/9t7OP
	 WxQgMCsmnVr1GLKSgBTRKDw1Xjs16AHkqWTE1ODEZ4P0A56cbmr7BNUwSg2mv5lzTY
	 vED8aX1JIH+jpKNdafQGZtaYQwS3JVJlo4iCK7va1MfkJfQoLw/X0e89Db3GCqJKye
	 OhqgszOB0Zapw9UGU+scg4HdU8uB8Efim9DZXPsT5ja9ZzbILxGjH1PO500gxXMUTX
	 7W7pPH/Sxj7yQ==
Content-Type: multipart/mixed; boundary="===============4767184949067385831=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2e698f1eb8290a797968f023b9736a7e3f502dbcde620ef32aa1e0e1d9915ef8@mail.kernel.org>
In-Reply-To: <20260619205934.1312876-12-memxor@gmail.com>
References: <20260619205934.1312876-12-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 11/17] bpf: Report Call Type Safety argument errors
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 19 Jun 2026 21:47:01 +0000 (UTC)

--===============4767184949067385831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index db151e6b8949..fdbf92bffc17 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -12587..-12662 @@ BTF_ID trusted/rcu, ctx, alloc obj

[ ... ]

> @@ -12587,13 +12735,35 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  	case KF_ARG_PTR_TO_BTF_ID:
>  		if (!is_trusted_reg(env, reg)) {
>  			if (!is_kfunc_rcu(meta)) {
> +				const char *expected_type;
> +
> +				expected_type = diag_btf_type_name(env, btf,
> +								   ref_id);
>  				verbose(env, "%s must be referenced or trusted\n",
>  					reg_arg_name(env, argno));

[ ... ]

>  		}
>  		if (!is_rcu_reg(reg)) {
> +			const char *expected_type;
> +
> +			expected_type = diag_btf_type_name(env, btf,
> +							   ref_id);
>  			verbose(env, "%s must be a rcu pointer\n",
>  				reg_arg_name(env, argno));

[ ... ]

> @@ -12831..-12946 @@ MEM/MEM_SIZE/refcounted/const str/irq

[ ... ]

> @@ -12831,8 +13015,18 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  			return -EINVAL;
>  		}
>  		ret = check_mem_reg(env, reg, argno, type_size);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			const char *expected_type;
> +
> +			expected_type = diag_btf_type_name(env, btf,
> +							   ref_id);
>  			diag_call_arg_fmt(env, insn_idx, argno, func_name,

[ ... ]

> @@ -12880,8 +13091,16 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  		break;
>  	case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
>  		if (!type_is_ptr_alloc_obj(reg->type)) {
> +			const char *expected_type;
> +
> +			expected_type = diag_btf_type_name(env, btf,
> +							   ref_id);
>  			verbose(env, "%s is neither owning or non-owning ref\n",
>  				reg_arg_name(env, argno));

This isn't a bug, but would it be worth using a consistent helper name
for the same computation?

In check_kfunc_args, the NULL-pointer and release blocks
(around lines 12650-12680) call the raw helper like this:

    expected_type = bpf_diag_format_btf_type_scratch(env, 1, btf, ref_id);

while the trusted/rcu, MEM, refcounted-kptr, and const-str blocks
(CHANGE-2/CHANGE-3) call a thin wrapper:

    expected_type = diag_btf_type_name(env, btf, ref_id);

Since diag_btf_type_name() is defined as exactly that raw call with
the same slot and parameters, could all these blocks use the wrapper
so the same expected-type lookup reads the same way?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27848712882
--===============4767184949067385831==--
