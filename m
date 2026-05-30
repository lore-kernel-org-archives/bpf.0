Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E75386439;
	Sat, 30 May 2026 07:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780124663; cv=none; b=UE9B3x8iPaIlyya61VTHlcTt9UwLlh1XSvVbYHtHMz3ylsnlYPKYBRqK5anRVLgUsM2nuZF/PruUrJdhIYOmdBJfy1pBGwPVwyuenKNqRUKd4pEy7wP3seH+Bg/jRnA1hBFC44oNcpOc1GigSohBe/PdKlPkTFclERAeoGqavkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780124663; c=relaxed/simple;
	bh=D5XT32fPFEyOqx9xMhcOmqM0r2KWSZGxO6eWNcYClTc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rGPK0W2ARkZL4gwprOtnGAaE5ocIIqVlXGcJHBgKaGk/zKD1zEm5WpNgUbTvL+EZTGuZkNMFqjFDe9Mc4P85n6yQwBT1/pWIQSFOow4pYUNbHStrSndtt9HE1c4NkjcGXPB3frsU4aMMTI52eYqGIp4+jVTEuf5fA2V1RxHaN50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eL1qVJ6k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eL1qVJ6k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6C11F00898;
	Sat, 30 May 2026 07:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780124662;
	bh=fjUzEXiUg6EIzL4w+wGjH90Z7b2O+W9lYz0+uzRvG1Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eL1qVJ6k5pP2WVg/zILwSVXXI7mJiC/CsA2DLGQZegREtN0zVJy7NhclCiQZn2rk5
	 9shQY+senFfybPSBSCjIn+8oTnBnaeLeHdCEcRLN6EzzavfPUigs9o1peljTQ+pkjL
	 Lq20r3gcudHtgD0H69SCmkI71Y+BoXCzTz78iW0wuTKK5wbZoDW8plf5AyZeBOgV+J
	 sBaMD8H8iTOpTHjYlMA9cIRxqEQobwJiYtVPxHZCBfgcGzEFVElA5F6gsMemhR6FDc
	 tw5UkxfQWNZkzR6V+1MSaBcYTgKJ4D6ztAwerfNoSPgzYuhoN7nsIW9SMEl4NBMyQT
	 l+v9dF0An6O0g==
Content-Type: multipart/mixed; boundary="===============9129813254684474192=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0bd66ee75b8124e031cda23490dea118871cf1517c42f8e6d99ab8369d0e8411@mail.kernel.org>
In-Reply-To: <20260530055557.549474-2-xukuohai@huaweicloud.com>
References: <20260530055557.549474-2-xukuohai@huaweicloud.com>
Subject: Re: [PATCH bpf v2 1/3] bpf: Add validation for bpf_set_retval argument
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,yonghong.song@linux.dev,sdf@fomichev.me,zhuyifei@google.com,mattbobrowski@google.com,2022090917019@std.uestc.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 30 May 2026 07:04:21 +0000 (UTC)

--===============9129813254684474192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7fb88e1cd7c4..e82dedf871e8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10460,6 +10460,19 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  		}
>  		break;
>  	case BPF_FUNC_set_retval:
> +	{
> +		struct bpf_retval_range range = {
> +			.minval = -MAX_ERRNO,
> +			.maxval = 0,
> +			.return_32bit = true
> +		};
> +		struct bpf_reg_state *r1 = &regs[BPF_REG_1];
> +
> +		if (r1->type != SCALAR_VALUE) {
> +			verbose(env, "R1 is not a scalar\n");
> +			return -EINVAL;
> +		}
> +
>  		if (prog_type == BPF_PROG_TYPE_LSM &&
>  		    env->prog->expected_attach_type == BPF_LSM_CGROUP) {
>  			if (!env->prog->aux->attach_func_proto->type) {
> @@ -10469,8 +10482,16 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  				verbose(env, "BPF_LSM_CGROUP that attach to void LSM hooks can't modify return value!\n");
>  				return -EINVAL;
>  			}
> +			bpf_lsm_get_retval_range(env->prog, &range);
>  		}
> +
> +		if (!retval_range_within(range, r1)) {
> +			verbose_invalid_scalar(env, r1, range, "At bpf_set_retval", "R1");
> +			return -EINVAL;
> +		}
> +

Because bpf_set_retval() takes ARG_ANYTHING, does this bounds check need
a call to mark_chain_precision(env, BPF_REG_1) to prevent a state pruning
regression?

Since ARG_ANYTHING doesn't automatically mark the register as precise in
check_func_arg(), it looks like the verifier's state pruning logic in
regsafe() might treat this register as equivalent to any other scalar
value if it remains imprecise.

Could this allow a program with two branches to bypass this bounds check?
If a safe branch (e.g., passing 0) is explored first and saved with an
imprecise R1, the verifier might prune an unsafe branch (e.g., passing 1)
because it matches the imprecise scalar state.

This would skip the bounds check on the unsafe branch and potentially
allow the exact bypass issue this patch is trying to fix.

Reference: https://lore.kernel.org/bpf/20260530063315.7C5D41F00893@smtp.kernel.org/

>  		break;
> +	}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26677028117
--===============9129813254684474192==--
