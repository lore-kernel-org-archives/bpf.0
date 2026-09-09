Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A217E3B4E95
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 07:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788938015; cv=none; b=VXK7iR8iT06gFgCuu1nKfgVXSLjGykRthHZiVJL/GzMNvOvDRSz9Z7RntLQKScRx5EUetcbyFZy7uN5CUY/3WlvO5zfvW2ZeS7APJnPVR7X7PcO53nUa9eI+g+2G0A1K1WaxP8Db8UVXvJiQkaiLI14JourGnRd4VjeL5sdTNR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788938015; c=relaxed/simple;
	bh=yTcfALd4OL6w1zqiNTA/pRFk0iu0iv+mSY4ze7PBMi8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AdGhmveJXUKAMFMgzvhvl89dD287vKvJH/gKUdoUuFRBekTR/Z4iUEGcT5vN9eszkFjhlscGE5OPJSALDtBDrZ1km//DOVcv+gpbVrLXrNBXmIBXcl+ZKp7ZTAMf2k4gMz6vhqA21UA/SNYT3UhZhDxFH1oMuPZStJ/gDs9DoZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqKme/yY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqKme/yY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6051F00A3A;
	Wed,  9 Sep 2026 07:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788938012;
	bh=gAac+aNd63COSIzW1UwbNeo6BSTCzMuVviCAmrXT8Yo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=oqKme/yYZjA/zAS/7y36LnDdq6c+pB7k6VhsLGJLEa0Ei7t2OmV6sKAPS/iwOVUwS
	 0PDy/Si+W8Rs4FNIFOuPXov2V+SUbsGXZj2uZjKof6RhIU3N6ZpEE3G18lDeVcDBXY
	 AQtzfUcWd4mLuuM0CpszlaMUV35O53XyKO6nwRGYo00Z57mmbP+zcOIBqGdSxvR9ku
	 BV6RIcC0lDcnv6RwZJPLd5E6misYpThWTiZePcZs1L58B1iOCgnmyYsRuWNuBRTpiB
	 3R+DlfGC3Lag96oWlIndiGL1rLrJwRmYoKkt7e9EFjt6iEbfZmVY4YFtc+LAXSGYXE
	 BTSZx47ykWx9g==
Content-Type: multipart/mixed; boundary="===============7629561995378166472=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <015098d2b080372b27acd82b6bea918f3762ba1c4f49a8c26ca273842ba67547@mail.kernel.org>
In-Reply-To: <20260909062533.4002610-1-yonghong.song@linux.dev>
References: <20260909062533.4002610-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 02/12] bpf: Index global function arguments by argument slot
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  9 Sep 2026 07:13:31 +0000 (UTC)

--===============7629561995378166472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 31057c8f3a7c..104a91f5ffd5 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8037,7 +8037,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>  	const struct btf_param *args;
>  	const struct btf_type *t, *ref_t, *fn_t;
>  	int err;
> -	u32 i, nargs, btf_id;
> +	u32 i, slots_used, nargs, btf_id;
>  	const char *tname;

[ ... ]

>  	args = (const struct btf_param *)(t + 1);
>  	nargs = btf_type_vlen(t);
>  	sub->arg_cnt = nargs;

[ ... ]

> @@ -8122,8 +8122,9 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>  	/* Convert BTF function arguments into verifier types.
>  	 * Only PTR_TO_CTX and SCALAR are supported atm.
>  	 */
> -	for (i = 0; i < nargs; i++) {
> +	for (i = 0, slots_used = 0; i < nargs; i++) {
>  		u32 tags = 0;
> +

[ ... ]

> @@ -8254,6 +8260,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>  		return -EINVAL;
>  	}
>
> +	sub->arg_cnt = slots_used;
> +

This isn't a bug, but would a short comment on the early 'sub->arg_cnt =
nargs;' noting that it exists only so the error path in
btf_check_func_arg_match() has a stack-arg count, and that the
authoritative slot count is set after the loop, make the two meanings of
arg_cnt easier to keep straight in the later patches?

>  	sub->args_cached = true;
>
>  	return 0;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34320399441
--===============7629561995378166472==--
