Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789253BCD2E
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790540821; cv=none; b=XCUDgCrDLbSmczq4hm1G/7smL/54l4YPqZo2Y2bG8JeYQMhxxR5WwymhtbQi8R6wxif8DlDNQsyS47s2cqrB4uQ9GUAEngDzwj1rcBGRdVpiaGFf8Nq/EEn0Z/h8sdc8fuYLc3Ac9dDfe3Kvn4eu+OoWO14eoBmiPuTnpdWQXm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790540821; c=relaxed/simple;
	bh=bzSAY7ii7V6osyQIUb2aBKCcSe0MHMKQhAaJBpuBjbk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qJAdWwAehu7AdTOvettLujWk3W7rg0RQciJksv+4EtWx8u66qp/FrX4QzBVKsuqAjMXWEYotsmMOqsP+zhjPlxPPH26DDK9jtWXS0xKj8sxv8kGHNuNPvw3R9I97O4KhascML02AOPr0NXR09ZwtUYyNb6uiscbW/iGEf1XWFoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JT4FZ0Q0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JT4FZ0Q0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541321F00893;
	Sun, 27 Sep 2026 20:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790540820;
	bh=o56f2rjquxY3hfbS7TCn3byMJhrNlDskKeqNNS5A0PI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JT4FZ0Q0X1KVzxCfxSzRFEO11fqEhqq2snOjeg+1D13z74ZydORIRNNMMhOt0mVMZ
	 q86Eid18oityDBmxIRdg7ygRy0cjxGvEZYeoIGx3w3jcYT6Txd4mjhf+xwV7ar6pZH
	 uFyTWraY77ObIKkNcGrZ9p9Gjz7H4eIsomPnz8CdBcYoiQKOwZVjOuabVFb7AxYOBO
	 pJAgpiN8DU4D1hS+YEwRge7j1BEjfPtHrDsjnWBit433GelQX4AnS79moLRMHavy/5
	 V1OXx6HowiKCkJHfJUlOT3MeRjdBMotiCGXa/m3rXjaNZ0mNNeglNtG98e5vH/pkdQ
	 5otECQ+7CMYjA==
Content-Type: multipart/mixed; boundary="===============3517947935714306713=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e5585bc7a06dce553e5f262fc19e2a343ff1358b7176d375b27e8094239945f0@mail.kernel.org>
In-Reply-To: <20260926-scev-minimal-rebase-v1-3-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-3-c8e5ab5ba79f@gmail.com>
Subject: Re: [PATCH bpf-next 03/36] bpf: summarize live stack slots in insn_aux_data
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:26:59 +0000 (UTC)

--===============3517947935714306713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index c6d617581e84..7f31ce5ea6b7 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -667,6 +667,7 @@ struct bpf_insn_aux_data {
>  	 * that this instruction may write to.
>  	 */
>  	DECLARE_BITMAP(may_write_mask, MAX_BPF_STACK_SLOTS);
> +	DECLARE_BITMAP(live_stack_before, MAX_BPF_STACK_SLOTS);

This isn't a bug, but would a short comment on live_stack_before make it
clearer what the field holds?  Nearly every neighbouring field like
live_regs_before and scc has its own comment.

>  	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
>  	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
>  	bool nospec; /* do not execute this instruction speculatively */

[ ... ]

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index c871744ca5a8..b6b7fd479569 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
> @@ -729,8 +729,9 @@ static void half_spis_to_slots(unsigned long *slots, const unsigned long *mask,
>  }
>
>  /*
> - * Precompute, for each instruction, the OR of may_write masks over its top
> - * frame across all func_instances reaching it, stash it in the insn_aux_data.
> + * Precompute, for each instruction, the OR of may_write and live_before masks
> + * over its top frame across all func_instances reaching it, stash them in the
> + * insn_aux_data.
>   */
>  static void compute_may_write_masks(struct bpf_verifier_env *env)
>  {
> @@ -746,9 +747,12 @@ static void compute_may_write_masks(struct bpf_verifier_env *env)
>  		if (!fm)
>  			continue;
>  		nbits = frame_mask_bits(fm);
> -		for (i = 0; i < instance->insn_cnt; i++)
> +		for (i = 0; i < instance->insn_cnt; i++) {
>  			half_spis_to_slots(aux[instance->subprog_start + i].may_write_mask,
>  					   rel_mask(fm, i, FM_MAY_WRITE), nbits);
> +			half_spis_to_slots(aux[instance->subprog_start + i].live_stack_before,
> +					   rel_mask(fm, i, FM_LIVE_BEFORE), nbits);
> +		}
>  	}
>  }

This isn't a bug, but would a more general name for compute_may_write_masks()
make the function's purpose clearer?  The comment now describes computing both
may_write and live_before masks, but the name only mentions may_write.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346543957
--===============3517947935714306713==--
