Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720272D877B
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 21:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545451; cv=none; b=Z54uSI3VU9e+DpFVIyJyny+XfnZH4hR7NzpBUFZIVKdo8CaswwV5jk8hN6HXtl4v56zDHfGi5loDueRVT/kpKecnGuN2+2OWzsbl2AHwCT5RK7Wy7F3u1BzM+FWtcy5TjWqDdt8A7jmTDyGamq4+oCeiz4H+iVK2fr2hrAjo1t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545451; c=relaxed/simple;
	bh=3b7ZnWGI1aQFNqaq0eOQRMf+63NSMIaGaicIlevM4Ug=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=S48DJl2n7KzpL6wywVuyDMt2cP7mFbVo8AggTToOIxOQhVROXNDVw/gxa4+eivWqu0JJ3UAjbG9OP5xYlZCTXTqnySsr3y0niUjisYa4PHpYmcZX2Myy9SeL7VqtfsxurkNjmFpt7+sfbLhS2NeLwmPkEYbr4T2bIJdaVCZ3utw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0rOaOaS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0rOaOaS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82A01F000E9;
	Wed,  8 Jul 2026 21:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783545450;
	bh=j5w7LBLPvyd/w3nH1/hiV1ZICQGRtvHfgDeTaaOiOdk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=f0rOaOaS5UPOtDaKd5JG1+QCo/k5dSr754Vl796GuWsyNb3pbKaG8YguEzx1yYhSv
	 4p1QCAXD3qKMTF4UMrOAOPPggcHckUF9a8ahHwhd/BeEYf9AoXXC6tPYrMmQSsxOUi
	 EUNBgAz0EPGtS6pv2pchbIEFr9/wW2ro580GQ2SluD9agLQ2UDaRhwDmb+wMe1ArgY
	 4i+D/bXx84AQlrhd3zud1H56mprhXqlpQZkfFTCjRgxU2WJjOAf0cfd7mC4zMixSAm
	 aXX6N6N+WDuBAdZYvbtxGeduqyThDk9JEtIFncAKryNHZaygaR2V1ee9uFsFCOOYw6
	 IMAt6tTDVVrpA==
Content-Type: multipart/mixed; boundary="===============0700488358235346988=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <24d590de409218c14cbfe4124dbb59737c500b995ddf57d379851fe75c48c437@mail.kernel.org>
In-Reply-To: <20260708200949.2156169-1-yonghong.song@linux.dev>
References: <20260708200949.2156169-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 02/12] bpf: Add verifier support for 16-byte returns in R0:R2
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  8 Jul 2026 21:17:29 +0000 (UTC)

--===============0700488358235346988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3f34ce1a3107d..03ffb5f839fa0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -424,6 +424,35 @@ static bool subprog_returns_void(struct bpf_verifier_env *env, int subprog)
>  	return btf_type_is_void(type);
>  }
>
> +static bool bpf_ret_reg_pair(struct bpf_verifier_env *env, int subprog)
> +{
> +	const struct btf_type *type, *func, *func_proto;
> +	const struct btf *btf = env->prog->aux->btf;
> +	u32 btf_id;
> +
> +	if (!btf || !env->prog->aux->func_info)
> +		return false;
> +
> +	btf_id = env->prog->aux->func_info[subprog].type_id;
> +
> +	func = btf_type_by_id(btf, btf_id);
> +	if (!func)
> +		return false;
> +
> +	func_proto = btf_type_by_id(btf, func->type);
> +	if (!func_proto)
> +		return false;
> +
> +	type = btf_type_skip_modifiers(btf, func_proto->type, NULL);
> +	if (!type)
> +		return false;
> +
> +	if (btf_type_is_struct(type) || btf_type_is_scalar(type))
> +		return type->size > 8 && type->size <= 16;
> +
> +	return false;
> +}

This isn't a bug, but could bpf_ret_reg_pair() and subprog_returns_void()
share a helper for the func_info -> func -> func_proto -> return type walk?

Both functions repeat the same ~8 line sequence:

subprog_returns_void():
	btf_id = env->prog->aux->func_info[subprog].type_id;
	func = btf_type_by_id(btf, btf_id);
	if (!func)
		return false;
	func_proto = btf_type_by_id(btf, func->type);
	if (!func_proto)
		return false;
	type = btf_type_skip_modifiers(btf, func_proto->type, NULL);

They only differ in the final predicate: subprog_returns_void() checks
btf_type_is_void(type), while bpf_ret_reg_pair() checks the struct/scalar
size.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28973410219
--===============0700488358235346988==--
