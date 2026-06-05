Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57004192F2;
	Fri,  5 Jun 2026 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672792; cv=none; b=MCj+RiZvXbjFtphAqKhJ9QHY1I8BKwHLWUqX8fKz0c8tv5Yl+FO0RnYH4zePFi2AYV+yRsDTEZ0XUyzgwhXY8x68gEvNeFWcN4LL956yrq4I3HFtTgYA3MDtE8n9WLRqdibDNhVO0u9de6ujbQBkj7XT8N3DpmCioTXV+vJdqjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672792; c=relaxed/simple;
	bh=hkDuOPVOfoh9t1i8IKAvhiAN9N5N+4dcSxmLTgUxUFQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pqUl8HRWrF4GRLqPxn6rzhEf4FRkSA8BiHLaKZg3LFgzfgd5SZT2je3sVDd3QBTrBgipU0RlF4lenfOlYrJdQvv+sBmzOexRva5R3b38jlgg3iHmQq5+OTfx0fHxqBzgOPJBXAZ4aMklhE5Vlp/zC1UyJGpMIF1Q5CQp3c+lmq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjblaRNX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjblaRNX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E571F00893;
	Fri,  5 Jun 2026 15:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780672787;
	bh=yqSyRj6GmazNruGfJ4/EsvMjp9Kn+w4KTusG/joVL3A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TjblaRNXB6X1CZfTE5lPehGTwDO5mLt6gmgDGmVhaAaappmp22fndZXk6No8TGdcu
	 qMpdpnx8+G++EuWUU1GnTl3rq4KOWuXQGFv4UgbdJAQrS11a2XL/EAh5QGDRU8X/K5
	 oE9cwcn4/r3HlcJcoRps7dKr8Gh6mqA96sdQtMdpMOsDX7EZU+s1Hq8+YFDvlu6RVf
	 lHnxc/4zgZbF/i/0foZtfJ9PoE24XvH35AXzKGqwbHYVHA0D4u18e5dAYP9gCsFG6w
	 JhgizyM2kH6lnwYbh3wvDGnRNkzrKVcdJdQfqdQzVgQpAJuvCAM5Bz2fgleS48gctp
	 ibp8C1B93X9ow==
Content-Type: multipart/mixed; boundary="===============0334693205050802382=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8c3468a91bbfac22f819b0ac7f1307de0bb5bec062229b36387550e05807e485@mail.kernel.org>
In-Reply-To: <20260605140243.664590-3-xukuohai@huaweicloud.com>
References: <20260605140243.664590-3-xukuohai@huaweicloud.com>
Subject: Re: [PATCH bpf-next v5 2/3] bpf: Add validation for bpf_set_retval argument
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,yonghong.song@linux.dev,sdf@fomichev.me,zhuyifei@google.com,mattbobrowski@google.com,2022090917019@std.uestc.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 15:19:46 +0000 (UTC)

--===============0334693205050802382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8ed484cb1a8a..a50280bb0d45 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9790,6 +9792,29 @@ static int do_refine_retval_range(struct bpf_verifier_env *env,
>  		reg_set_urange32(ret_reg, 0, nr_cpu_ids - 1);
>  		reg_bounds_sync(ret_reg);
>  		break;
> +	case BPF_FUNC_get_retval:
> +		/*
> +		 * bpf_get_retval may see arbitrary value passed by bpf_prog_run_array_cg for
> +		 * CGROUP_GETSOCKOPT type.
> +		 */
> +		if (prog_type == BPF_PROG_TYPE_CGROUP_SOCKOPT &&
> +		    env->prog->expected_attach_type == BPF_CGROUP_GETSOCKOPT)
> +			break;
> +
> +		if (prog_type == BPF_PROG_TYPE_LSM &&
> +		    env->prog->expected_attach_type == BPF_LSM_CGROUP) {
> +			if (!env->prog->aux->attach_func_proto->type)
> +				break;
> +			bpf_lsm_get_retval_range(env->prog, &range);

For a boolean LSM hook, bpf_lsm_get_retval_range() returns the range
[0, 1], and this code refines the bpf_get_retval() return register to
that range.

Can that static range be violated at runtime when multiple programs are
attached to the same cgroup hook with BPF_F_ALLOW_MULTI?

In bpf_prog_run_array_cg(), if an earlier program returns 0 the retval
is translated to an error:

	if (!func_ret && !IS_ERR_VALUE((long)run_ctx.retval))
		run_ctx.retval = -EPERM;

A later program that calls bpf_get_retval() would then receive -EPERM
(-1) at runtime, which is outside the [0, 1] range the verifier assumed
here.

Does this static-versus-runtime mismatch let the verifier reason about
bounds that the value can actually fall outside of?

This was raised on the v5 posting and does not appear to have a reply
yet:

  https://lore.kernel.org/bpf/20260605144232.95A141F00893@smtp.kernel.org/

> +		} else {
> +			range.minval = -MAX_ERRNO;
> +			range.maxval = 0;
> +		}
> +
> +		reg_set_srange64(ret_reg, range.minval, range.maxval);
> +		reg_set_srange32(ret_reg, range.minval, range.maxval);
> +		reg_bounds_sync(ret_reg);
> +		break;
>  	}
>
>  	return reg_bounds_sanity_check(env, ret_reg, "retval");


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27021279696
--===============0334693205050802382==--
