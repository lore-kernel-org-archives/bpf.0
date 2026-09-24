Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDE84BE458
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272362; cv=none; b=YKcWuvWnF9Nmy24H2xqPdvUqj2uqaIez27TMJlNgq5UNpMm2BqXOCxAAf5m59nVuBtIGbAR4uLu03uZCzfef47JFNZAkEm2C++fICQ7syQhZkJ66+JHVBx2BKt4g5gnnghopMsione22KDGKuH7IFLc0/zVKNTD96/08p54BELc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272362; c=relaxed/simple;
	bh=pAjyl1lDqzmaSRa4oJuSczHRLs1XrvEnJgtyqZGUAWY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GOoWgQf8K93bifufx+Rr/XIEq0O9vJDi9gsZni446TCwtq6xdrH0KEJl+9x1g/QZtBkIbGRv4CBR/1iVu2xbFRYLV39vNzU6Agn2bzCwdnIP5IvOtKoJ7I0ZXL3UJ/dPFV/jmXbtdSrN81pMDJA4ImtUEgQ1yl+ZMCF8pZ3Lwrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUX4SK5g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUX4SK5g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332631F00893;
	Thu, 24 Sep 2026 17:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790272360;
	bh=0mWOsK9cLCBMnCfTCFhQzDqTjwIehU7Cgy9bixfxbJU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nUX4SK5gSQ+4/hT2bEL1pgfWQXcncOm+zZvIhMsk39oG+/BB8Jb07KqcJ5seqqNPC
	 GgIpI9rJEoHrWvwRWAqN226GGi3XA8M3gqgO6iMI8xaWCjxAoQutUT5a6VZEihZpP2
	 f/RErdOuxQSfbHqdVSQXYN0Ls7eXGYPgyRygknA8FpbV4oimCMuK+F5U9MJU++1XXj
	 UwxGytmQ60/crVNc71rEHc3pxJSB8fbax0Gi85KvDxBO7r9Q8ucCggjdGJjRqfdJeP
	 BwMxynFnMN93QjkCDt/Hu1TgQ4+kRSZP/LWNmZVxHvpGkd2WUTdd4clnNCG44fJGh6
	 dH9n1gH0feafg==
Content-Type: multipart/mixed; boundary="===============5203929634884331610=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dc4af1cfd62ba414e84c2d0da478adcbf80079a27fb17b04175c913d8b617e73@mail.kernel.org>
In-Reply-To: <20260924165740.2146806-8-memxor@gmail.com>
References: <20260924165740.2146806-8-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v4 07/18] bpf: Size liveness stack masks by the stack each frame uses
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 17:52:39 +0000 (UTC)

--===============5203929634884331610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index e64cfb3fe675..d3c31105a3ac 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index a204b492acc8..1d83a4cf6ec5 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> +/*
> + * Number of 8-byte spill slots to track for the instructions in [@start, @end):
> + * the 64 slots of a MAX_BPF_STACK frame, which the tracker has always
> + * followed, or the deepest 8-byte stack access made directly through R10 when
> + * that reaches further. Spills and fills are compiled as direct R10 accesses,
> + * so the count covers them whatever the frame size; a fill through a derived
> + * pointer that reaches past it is treated as imprecise, as one past the frame
> + * always was.
> + */
> +static u32 subprog_spill_slots(struct bpf_verifier_env *env, int start, int end)
> +{
> +	struct bpf_insn *insns = env->prog->insnsi;
> +	int deepest = 0;
> +
> +	for (int i = start; i < end; i++) {
> +		struct bpf_insn *insn = &insns[i];
> +		u8 class = BPF_CLASS(insn->code);
> +		u8 base;
> +
> +		if (BPF_SIZE(insn->code) != BPF_DW)
> +			continue;
> +		if (class == BPF_LDX)
> +			base = insn->src_reg;
> +		else if (class == BPF_STX || class == BPF_ST)
> +			base = insn->dst_reg;
> +		else
> +			continue;
> +		if (base == BPF_REG_FP && insn->off < 0)
> +			deepest = max(deepest, -insn->off);
> +	}
> +	return clamp_t(u32, DIV_ROUND_UP(deepest, 8), MAX_BPF_STACK / BPF_REG_SIZE, MAX_BPF_STACK_SLOTS);
> +}

[ ... ]

> @@ -1643,9 +1793,10 @@ static int compute_subprog_args(struct bpf_verifier_env *env,
>  	int end = env->subprog_info[subprog + 1].start;
>  	int po_end = env->subprog_info[subprog + 1].postorder_start;
>  	int len = end - start;
> +	u32 nslots = subprog_spill_slots(env, start, end);
>  	struct arg_track (*at_in)[MAX_AT_TRACK_REGS] = NULL;
>  	struct arg_track at_out[MAX_AT_TRACK_REGS];
> -	struct arg_track (*at_stack_in)[MAX_ARG_SPILL_SLOTS] = NULL;
> +	struct arg_track *at_stack_in = NULL;
>  	struct arg_track *at_stack_out = NULL;
>  	struct arg_track at_stack_arg_entry[MAX_STACK_ARG_SLOTS];
>  	struct arg_track unvisited = { .frame = ARG_UNVISITED };
> @@ -1657,19 +1808,19 @@ static int compute_subprog_args(struct bpf_verifier_env *env,
>  	if (!at_in)
>  		goto err_free;
>
> -	at_stack_in = kvmalloc_objs(*at_stack_in, len, GFP_KERNEL_ACCOUNT);
> +	at_stack_in = kvmalloc_objs(*at_stack_in, (size_t)len * nslots, GFP_KERNEL_ACCOUNT);
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  	if (!at_stack_in)
>  		goto err_free;

In an earlier review
(https://lore.kernel.org/bpf/DLNN6OBVQG1W.3QKYZXB09YNWO@gmail.com/), Alexei
Starovoitov noted:

  at_stack_in is now len * nslots * sizeof(struct arg_track).
  One 8-byte store at fp-2048 makes nslots 256, so the subprog pays
  2560 bytes per insn instead of 640.
  A subprog with 900K insns and one such store asks kvmalloc for more
  than 2G and hits WARN_ON_ONCE(size > INT_MAX) in
  __kvmalloc_node_noprof().

  Should we clamp it somehow?

Could this allocation trigger the INT_MAX warning for large programs with
deep stack access? The subprog_spill_slots() function includes a clamp_t()
call, but at this commit both bounds (MAX_BPF_STACK / BPF_REG_SIZE and
MAX_BPF_STACK_SLOTS) equal 64, so the clamp always returns 64 regardless of
the deepest value. Is this the intended behavior for now, or should there be
additional safeguards against excessive allocation before nslots can grow
larger in later commits?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36032786938
--===============5203929634884331610==--
