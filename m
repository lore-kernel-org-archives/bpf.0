Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109A63612FB
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773091403; cv=none; b=teRtP1F3aNRu6Ymqh2DzvY1qncDhanJeSPgap+ZnELFKtE8uPP2zuiYN9d4Q+5p+/KApUhUtC3w5gd4WMkjZB9VSFpTjwY81hfr32V1NQHwCTFjPUmUFltAgltr9rtWQxTRtBMW5ZUSDT4jNkj6CYSC9TPSm5ibPNqMezVR0xQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773091403; c=relaxed/simple;
	bh=igIUp01tMXryVCPxkpY9AxxddvQnCF4YaW4X1fq5ewU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fRLl2o8zdcXKMMFqJuF1pRrEasDdoT2vgLQ/QcBpFdqmwikrkyWYMtSzvLktNUu4WFh8Ut0O2xUrTPOZSqi3xRiJIP/1gtGdgMacVGnxB3O+U51bRXi2DoegBqxE0d71cGfo0ihgXcUIiOhykgZXxeV4xvzJgi/oWGfM55ofX50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayZsakmu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayZsakmu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CDBC2BCB5;
	Mon,  9 Mar 2026 21:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773091402;
	bh=igIUp01tMXryVCPxkpY9AxxddvQnCF4YaW4X1fq5ewU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ayZsakmufNm45EiyibBQgb9eEt1LBWqBzgpxHx3gNVK1+adWtTWBYC8vR5GLSWaho
	 fY2OarllGTH8k1M9XxRZlhqxy4qwI85hv27mBzUveFRgiZKU00vH4l2qnL+d3tuCza
	 75TYj2jz8ydVGK1X/eNtjuMAhTWxRk63rn2IqQWB0Her1u4PMguA9OZYQsgj9jeYA/
	 NP0MmyNCtjdvuf/sfok5Rf788f3GXEFMyEVPD7KgmVzPm/pLwIqfYSt88hpfW6NzOK
	 8cqxzj2FbKj5pcmOdVoxPjzKQRQU0e8xYMnuWJ9d8DjH3qusn3PbZw0+AWob9LsqNH
	 jKovKBxdduSfA==
Content-Type: multipart/mixed; boundary="===============5642644204148914780=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dfad552b2dad79e5546abbf329f2092b3e226a08d63cd4e3a1fd3dc2e95b1ef6@mail.kernel.org>
In-Reply-To: <20260309204430.201219-2-emil@etsalapatis.com>
References: <20260309204430.201219-2-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Only enforce 8 frame call stack limit for all-static stacks
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,martin.lau@kernel.org,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  9 Mar 2026 21:23:21 +0000 (UTC)

--===============5642644204148914780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8e4f69918693..ccd4efec179d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6733,9 +6733,11 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  	struct bpf_insn *insn = env->prog->insnsi;
>  	int depth = 0, frame = 0, i, subprog_end, subprog_depth;
>  	bool tail_call_reachable = false;
> -	int ret_insn[MAX_CALL_FRAMES];
> -	int ret_prog[MAX_CALL_FRAMES];
> -	int j;
> +	int total;
> +	int tmp;
> +
> +	/* no caller idx */
> +	subprog[idx].dinfo.caller = -1;

The function header comment above this hunk still reads:

    Since recursion is prevented by check_cfg() this algorithm
    only needs a local stack of MAX_CALL_FRAMES to remember callsites

The local stack arrays (ret_insn[] and ret_prog[]) have been removed
in favor of per-subprog dinfo fields. Should this comment be updated
to reflect the new approach?

This was also noted during the v3 review:
https://lore.kernel.org/bpf/ad397307a9cd76c9739ee05f4642c7b6a881b7dfb8a2facefa6b2062ffe328ea@mail.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22874415683
--===============5642644204148914780==--
