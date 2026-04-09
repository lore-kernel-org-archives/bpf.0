Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B4434D916
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 02:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775700863; cv=none; b=CigRkhZGN5o4Ew/xmxIDnzZazl2yC1uJDFYVpapoVaSMxRqdfCiWh4gJI+DP1yPa3d588D0lEW+cO/x/YV96c6md96KqG6KBAUqiygj5ghW/UR5kb2PZA7i3kQuvru01gOFOSXxD9K2Jg93SpS430iHo/RcpPCzTrjm5Tx4I2uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775700863; c=relaxed/simple;
	bh=eZsdsdXH5JiHdXpSgSmxo5FfvU2kOk7DowcobpqNJws=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nLmOYn+LPGDXkontjCUm09AIXgjADsi7CqW7lULcxinzC8g0CSp3d4FSvLdjrJBCnZc7WZ5JQQQoVV0LVbfTUM5IKjdR15fgbQU5zQHifbtdufRC8LHNOC0UWUMSD8asnVwisbBuMsXku9WMmV7F4TkLl654PG512V25epynTKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTKC0V4y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTKC0V4y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0318AC19421;
	Thu,  9 Apr 2026 02:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775700863;
	bh=eZsdsdXH5JiHdXpSgSmxo5FfvU2kOk7DowcobpqNJws=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ZTKC0V4yHSsUbt3yV4I+Aywn1ld8ROdw5BEJWI4tP4Cax3zE9M82d8eNBiu1yTC1l
	 IcbZVgGbeOpbLYVvtW3lqD1CNNh6UKGCDbTLy1eb+Q63nIro1UKJk1RHeKw4w17Z2c
	 FRppjGyL7uGhXHXKky0EocHwWsfavWBasKMXlvbpdTatDKd24f2eb6X29tH7em8J6s
	 /IccAvmFNm8iAgZiOwF19zs0fSNEqYQdnmpTx15kuZsotX/QL79uhz+YAP3XmZ0/ph
	 S4CB28FVyZ5inyPTbh4q+LTtf9knI6A8ERsH5E1c9MoiZ04YLLdSNFwnVDfd1BB56j
	 INfsfrf0uB1CA==
Content-Type: multipart/mixed; boundary="===============2972911015867541025=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e95d13fbead722599e4564be81702065da89034039d3dffa005eadb41b5f9382@mail.kernel.org>
In-Reply-To: <20260408-patch-set-v1-10-1a666e860d42@gmail.com>
References: <20260408-patch-set-v1-10-1a666e860d42@gmail.com>
Subject: Re: [PATCH bpf-next 10/14] bpf: change logging scheme for live stack analysis
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  9 Apr 2026 02:14:22 +0000 (UTC)

--===============2972911015867541025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index c3098369bee8..832c10846ec5 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> +static void print_instance(struct bpf_verifier_env *env, struct func_instance *instance)
> +{
> +	int start = env->subprog_info[instance->subprog].start;
> +	struct bpf_insn *insns = env->prog->insnsi;
> +	struct per_frame_masks *masks;
> +	int insn_idx, frame, pos, insn_pos, i;
> +	int len = instance->insn_cnt;
> +	bool has_use, has_def;
> +
> +	if (!(env->log.level & BPF_LOG_LEVEL2))
> +		return;
> +
> +	verbose(env, "stack use/def %s ", fmt_subprog(env, instance->subprog));
> +	verbose(env, "%s:\n", fmt_instance(env, instance));
> +	fmt_instance(env, instance);

Is this bare fmt_instance() call intended?  Its return value is
discarded and the tmp_str_buf it writes into is overwritten by
later fmt_spis_mask() calls in the loop below, so the call appears
to have no effect.

> +	for (i = 0; i < len; i++) {

[ ... ]

> @@ -1805,6 +1896,9 @@ int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env)
>  			break;
>  	}
> +
> +	if (env->log.level & BPF_LOG_LEVEL2)
> +		err = print_instances(env);
> +
>  out:

If the for-loop above breaks out with a non-zero err (e.g. from
analyze_subprog() returning -ENOMEM) and BPF_LOG_LEVEL2 is set,
this overwrites err with the return value of print_instances().

When print_instances() succeeds and returns 0, the original error
is silently lost and bpf_compute_subprog_arg_access() returns
success to compute_live_registers(), which then continues
processing with incomplete liveness data.

Something like the following would preserve both errors:

    if (!err && (env->log.level & BPF_LOG_LEVEL2))
        err = print_instances(env);

>  	for (k = 0; k < insn_cnt; k++)
>  		kvfree(env->callsite_at_stack[k]);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24168298083
--===============2972911015867541025==--
