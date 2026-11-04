Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758374;
	b=mIHuVmImyLZmCQQ61lQ8T4JvkZe6STOR/TqsmGdH/raSIcbjIdKfC/Ci60AEtJ1eopyQ
	 7ZoXq31WM9nkuo9K+TcH15K9Dq//n0GXp7Hc+cB6sIbuhDvu+nbbfFXNE+DMq1Ea7nHob
	 +kfmx4y2eKvfy/gJfnV9iQUr57gKe67Q6UPRQ5x00KjbpCXZto/Ty4RuVZRGSPOBg8aRh
	 08d0ZwIBycb7iTBkbAjqeUYZUjnW4wFa5yC+1hnLneiELkIaZ0TT/p3BE47xsZtPQOWS6
	 QoUfDcFwkn9Dh/VeE1uqXQeZxLZzQ5ZOLtd2Rnw5B5+iCi7Y6BABlMD2753olQ24Kuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758374;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=6uVQbravGwtOXxa0br2UfYl2DmsF1MLJqtlph3eR8nw=;
	b=HDna7SW0E1yhvBPqmu1JfFD49pQM9Vv8Wliu7aRmL+ya1M/qy3d0hcx/4ow5rkaZwL9s
	 gZQlz4BFv2eePtbLgvg7QWeK/xANnRg7bskl3a4I1/ocKR5F+yaoddClsuclIBMeItcXC
	 IfKImthkj4HFRkBKpoWkOZk5PZ2oqvnU64SAic4TosooP/gJ7/CSVznaeed3YeM+IldyD
	 YmfuZLaVof8ll9WffNpg3+syxqLPC9CuDpIoWLAZtSASeZGuppc4FXZSK76b49sW7iXyS
	 XXKbhBqcdDvHgTxfDmGPk8V8/Y1cRHpw2UpvftKVO7R2g9M3FKaVgMpOAGmTnfk723Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FQRvcHzH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD45F606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 02:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FQRvcHzH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F911F000C1;
	Wed,  4 Nov 2026 02:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793758373;
	bh=6uVQbravGwtOXxa0br2UfYl2DmsF1MLJqtlph3eR8nw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FQRvcHzHg1jxhPoRYMNQVz118BU7h8Jh/5D4S+yWXw4DViQ21p1MEgeFWnwRpZjwI
	 ahWXIM4Pgz/Yxbkfy2bR64ZC1smxzjxXSA3WydGaQrXjSrTZE6GqnM1PCbeVAEIeyR
	 hL1/rVaBeKIwonFFy5Zl2/VG7o8sJTG+IfCT/i462cgZXOQTGgLQPWym2eLTmZIuxi
	 PwM4+MtEmb0TCLBZhSBcEdufe7gISV0A3ZKvGKE/y+cULwIZL22D9BEKZcqoQa+3ji
	 ndsGTTwJqg8VqlZvComMfz1C3PYv7K3oTK9o3zwNhwiY54qMCAFsRiXD/vEc+9n1Jg
	 cQsyhWZbPk9hQ==
Content-Type: multipart/mixed; boundary="===============0371421414770485787=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <e378c0a3da66e6f3ccd7d63915ec7b1207c6e8f73fd85dcabf9920cd34d7c42c@mail.kernel.org>
In-Reply-To: <20261104012401.1354861-12-alexei.starovoitov@gmail.com>
References: <20261104012401.1354861-12-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v3 11/14] bpf: Support BPF_REG_ARENA_SP in the verifier
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  4 Nov 2026 02:12:53 +0000 (UTC)

--===============0371421414770485787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Support BPF_REG_ARENA_SP in the verifier

TL;DR: Nit only: the new arena stack block in check_max_stack_depth_subprog()
separates the tail call comment from the check it documents; consider moving
the block above the comment or after the check.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -5832,6 +5833,24 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  	 * tailcall will unwind the current stack frame but it will not get rid
>  	 * of caller's stack as shown on the example above.
>  	 */
> +	/* The kernel calls a callback. It knows nothing about r12. */
> +	if (subprog[idx].uses_arena_sp) {
> +		for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller) {
> +			if (!subprog[tmp].is_cb)
> +				continue;
> +			subprog[tmp].arena_stack_entry = true;
> +			break;
> +		}
> +	}
> +	arena_depth += subprog[idx].arena_stack_depth;
> +	if (arena_depth > env->max_arena_stack_depth)
> +		env->max_arena_stack_depth = arena_depth;
> +	if (arena_depth > BPF_ARENA_STACK_MAX) {
> +		verbose(env, "combined size of the frames in the stack in arena is %d. Too large\n",
> +			arena_depth);
> +		return -EACCES;
> +	}
> +
>  	if (idx && subprog[idx].has_tail_call && depth >= 256) {

This isn't a bug, but the new arena stack block now sits between the
existing comment about limiting the caller's stack depth to 256 bytes when
bpf2bpf calls are combined with tail calls, and the check it documents:

    if (idx && subprog[idx].has_tail_call && depth >= 256) {

The tail call comment now ends directly above "if (subprog[idx].uses_arena_sp)".

Could the new block be moved above that comment, or after the tail call
check, so the comment stays next to the code it describes?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41755299448
--===============0371421414770485787==--
