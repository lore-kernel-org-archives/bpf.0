Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0998B2F30
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 01:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786154400; cv=none; b=tNC+sebnMfWJxt0doxmLZ0uEEWq7jCsFjXu4AXoLTCQrXVFxIT8m6FKaNx86Fg3416iEW0kq5ONfZx+7LHC01uhX7srVOivrkw+naWwT0SW/W0LL7peHIL+9IDswsKzqj0K0k02r22GJZD4MwlJRqpsLjX6fXQcKOoJm4Ma6A3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786154400; c=relaxed/simple;
	bh=p4+g3Cfw37Y3W733hpSZJIr/frMyHau3M1s20PR98co=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LzQTmJVFa5zcQl5MjVJOgaB8V/2GVd9UHqtCpHRQVrE/6h4B+1a6CyseER93NzgOHOY95JAo6A2Veh/yPCBH3/GryKxOU3jZkps2dH1912Afq8VG4mmoAjFMbQY8VFV5o+/+zHjBxcYmawp/UE7PqEf5GejrePhma9IT8NfhpOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7Qyy4Pe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7Qyy4Pe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF911F000E9;
	Sat,  8 Aug 2026 01:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786154398;
	bh=3424g6N0C2EEec+Ogj+VTFnk25I2vsDRrdmhc8KPxXY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=b7Qyy4Pehtf6d23GR/YcqUTtuiHr/GVm1VJc79mzLapcpXLDhl34u9UobJPkuM9Pc
	 osk6B8TbInqj8rm8inKLVsDifNhxEX/O0ucPh5Cl08A/17WjFRqUQO0DXr0cwj8C0o
	 uy2XgZzdw84ZV7zj2TCSdPuGzH3tobeJU311RCrOFGBmKKe8RNdu2/IF6De84WP6DK
	 kWGepXY9hALKKBFaHGRNGisA1xz6hysWZdwrcFUe23kmeAT+zfrpoghmSnXX8qeWox
	 fLPaAZ+Rhro3y0Z03UmdW6fWekeIrhKyjK0joZb9pj9cH+flW2R7n3ew6ncrsx0W//
	 q5R+JoqoICZiw==
Content-Type: multipart/mixed; boundary="===============8686466321155057618=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b839cf46146f3960d8da3f0d44c06de033c5e53fcaef2dcd0308565217c8d70d@mail.kernel.org>
In-Reply-To: <20260808003938.3486067-3-memxor@gmail.com>
References: <20260808003938.3486067-3-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v5 02/14] bpf: Split subprogram and kfunc collection
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ameryhung@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat,  8 Aug 2026 01:59:57 +0000 (UTC)

--===============8686466321155057618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 92d0cdd95c0f4..4573df98b1ce7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2842,7 +2842,7 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
>  	return 0;
>  }
>
> -static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
> +static int add_subprogs(struct bpf_verifier_env *env)
>  {
>  	struct bpf_subprog_info *subprog = env->subprog_info;
>  	int i, ret, insn_cnt = env->prog->len, ex_cb_insn;
> @@ -2854,8 +2854,7 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
>  		return ret;
>
>  	for (i = 0; i < insn_cnt; i++, insn++) {
> -		if (!bpf_pseudo_func(insn) && !bpf_pseudo_call(insn) &&
> -		    !bpf_pseudo_kfunc_call(insn))
> +		if (!bpf_pseudo_func(insn) && !bpf_pseudo_call(insn))
>  			continue;
>
>  		if (!env->bpf_capable) {
> @@ -2863,11 +2862,7 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
>  			return -EPERM;
>  		}
>
> -		if (bpf_pseudo_func(insn) || bpf_pseudo_call(insn))
> -			ret = add_subprog(env, i + insn->imm + 1);
> -		else
> -			ret = bpf_add_kfunc_call(env, insn->imm, insn->off);
> -
> +		ret = add_subprog(env, i + insn->imm + 1);
>  		if (ret < 0)
>  			return ret;
>  	}

[ ... ]

> @@ -2905,6 +2900,28 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
>  	return 0;
>  }
>
> +static int add_kfuncs(struct bpf_verifier_env *env)
> +{
> +	struct bpf_insn *insn = env->prog->insnsi;
> +	int i, ret, insn_cnt = env->prog->len;
> +
> +	for (i = 0; i < insn_cnt; i++, insn++) {
> +		if (!bpf_pseudo_kfunc_call(insn))
> +			continue;
> +
> +		if (!env->bpf_capable) {
> +			verbose(env, "loading/calling other bpf or kernel functions are allowed for CAP_BPF and CAP_SYS_ADMIN\n");
> +			return -EPERM;
> +		}
> +
> +		ret = bpf_add_kfunc_call(env, insn->imm, insn->off);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

This isn't a bug, but now that the CAP_BPF check runs in two separate
functions, would it help to say "bpf function calls" in add_subprogs()
and "kernel function calls" in add_kfuncs() so the rejection reason is
unambiguous?

The message "loading/calling other bpf or kernel functions are allowed
for CAP_BPF and CAP_SYS_ADMIN" appears verbatim in both add_subprogs()
and add_kfuncs(). Before the split there was a single site covering
both cases; with two independent passes the identical string no longer
tells the loader which kind of call was rejected.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31231521120
--===============8686466321155057618==--
