Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755C647ECFA;
	Thu,  4 Jun 2026 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581152; cv=none; b=Z6EUO/849kEDZBV998HdLRJIpjgfMWgJrvIm6/KESETcJ1AX3l4bADI1Wz09zaPEc0H4T5qdk5PnkKDCBlAyLAlhAbjJoP6KTVXGmnv7D8qLb3FOadr4VDTfddHE18OGMXIzy8ndVItA1VnxhWIva4RJDbTqyVOqpK+TCVDMvzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581152; c=relaxed/simple;
	bh=JyRQ5DLI2Tz054FHOxWURSvexWnX6Hctzr8B1ljtrE4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=V4TvLauWAhJAR9YcVJUiet+DYoVlyWUji4G390ZNN3neM+An1rqnslJNQd3ptDhcebDHP4zuGJdImoIEtOrFv1YvB3RgLLIRXqcYJOs3b+TplXz8EQyBzmxH4v0FvDtEtLhdC+c44Gdx7XHamfHodOB+YUhDD5aAab4HMzSvwqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKoD6sVL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKoD6sVL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A15E1F00893;
	Thu,  4 Jun 2026 13:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780581151;
	bh=nP5ANhfUr65vaUgZeofhcvtZviOVxszyWSYwKeR25yI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PKoD6sVLfwWpY7uYD4J2riUIZ7n1ewh3EVIaR6rXZw3/lVyACghyer6gW9aWFZBYn
	 oVVstZF4398SDA6d2kucmCt0CKQtHjCUpIlsztC7KvQKSXfBMncgq+LnlOGAO+9hUo
	 fbHukQ8hWlGVTVQINWkZo8bBthlM90gAGnlz8iAv1gHw14B/FWKRH7xZ/W7aNFjcVS
	 1+EHDGeOWKyR7IxIuNPvwxe69ahYVMWs8JHgu/8OJoXojsqHuK9Lw3IBKGdNBe/NHq
	 wxRdBgjw5/oeH53yWo1hzJvxy76jlBjNTKkEZP/ao8OR5J/Rvlobp01+nIMzcnBPj2
	 NPbAuNXm+BYUQ==
Content-Type: multipart/mixed; boundary="===============5202350750330968314=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a91c8225b90fc2330bdca6af51f72c7cb872c1127deb54ca6d89f6f3f34b9657@mail.kernel.org>
In-Reply-To: <20260604130458.617765-3-xukuohai@huaweicloud.com>
References: <20260604130458.617765-3-xukuohai@huaweicloud.com>
Subject: Re: [PATCH bpf v4 2/3] bpf: Add validation for bpf_set_retval argument
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,yonghong.song@linux.dev,sdf@fomichev.me,zhuyifei@google.com,mattbobrowski@google.com,2022090917019@std.uestc.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  4 Jun 2026 13:52:31 +0000 (UTC)

--===============5202350750330968314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7fb88e1cd7c4..1bf58685b655 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9952,6 +9952,7 @@ static int do_refine_retval_range(struct bpf_verifier_env *env,
>  				  int func_id,
>  				  struct bpf_call_arg_meta *meta)
>  {
> +	struct bpf_retval_range range;
>  	struct bpf_reg_state *ret_reg = &regs[BPF_REG_0];
>
>  	if (ret_type != RET_INTEGER)
> @@ -9980,6 +9981,29 @@ static int do_refine_retval_range(struct bpf_verifier_env *env,
>  		ret_reg->s32_min_value = 0;
>  		reg_bounds_sync(ret_reg);
>  		break;
> +	case BPF_FUNC_get_retval:
> +		/*
> +		 * bpf_get_reval may see arbitrary value passed by bpf_prog_run_array_cg for
> +		 * CGROUP_GETSOCKOPT type.
> +		 */
> +		if (env->prog->type == BPF_PROG_TYPE_CGROUP_SOCKOPT &&
> +		    env->prog->expected_attach_type == BPF_CGROUP_GETSOCKOPT)
> +			break;
> +
> +		if (env->prog->type == BPF_PROG_TYPE_LSM &&
> +		    env->prog->expected_attach_type == BPF_LSM_CGROUP) {
> +			if (!env->prog->aux->attach_func_proto->type)
> +				break;
> +			bpf_lsm_get_retval_range(env->prog, &range);
> +		} else {
> +			range.minval = -MAX_ERRNO;
> +			range.maxval = 0;
> +		}
> +
> +		reg_set_srange64(ret_reg, range.minval, range.maxval);
> +		reg_set_srange32(ret_reg, range.minval, range.maxval);
                    ^^^^^^^^^^^^^^^

Are reg_set_srange64() and reg_set_srange32() defined in this kernel? A
search across the entire tree finds only these two call sites and no
definition. The struct bpf_retval_range has minval/maxval fields but no
associated reg_set_srange* helper exists in this codebase.

Looking at the existing pattern in this same function (lines 9969-9970),
the code directly assigns fields:

    ret_reg->smin_value = -MAX_ERRNO;
    ret_reg->s32_min_value = -MAX_ERRNO;

The reg_set_srange* helpers appear to belong to a different verifier
variant using reg->r64 = cnum64_from_srange(...) that isn't present here.

Should this use the same pattern as the BPF_FUNC_get_stack case above it:

    ret_reg->smin_value = range.minval;
    ret_reg->smax_value = range.maxval;
    ret_reg->s32_min_value = range.minval;
    ret_reg->s32_max_value = range.maxval;
    reg_bounds_sync(ret_reg);

This would match the existing codebase and avoid undefined function
references that will fail to compile.

> +		reg_bounds_sync(ret_reg);
> +		break;
>  	}
>
>  	return reg_bounds_sanity_check(env, ret_reg, "retval");

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26955107708
--===============5202350750330968314==--
