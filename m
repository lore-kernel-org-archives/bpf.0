Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364303;
	b=DB/jLOAalJ1rK1wxDXHm4Nuky8VMutm65HqtS1RgcMEgRfjNluMuKSUeB38eAMuFdiWe
	 if0t1xntPuULVpoEwnmeGX5e1YGibvdAEbUaB03TIj+naBOYchoykx7YGPZyn5TI+Zogg
	 lkkiwxRUYcwKgzy0y/+BuZnJu2Z4suiz7u8YiJOwlRd+ywHBFCfiLO+WzPaKKuVp9YsJ6
	 D83WSfb9rkUFmhCJ09ktGLcAv/kIpC/8MTnW2IXDhGMhVBl9duBuLW8qiESjM2RZwUXgc
	 N68I7viL1vQEFX87T+NNq43zQDIv6XJo1U0mCL7AxkVyXaaweRUEueyvATYlDXIsHhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364303;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=39vmiQMtWyNbLcbiDzlBusK1H/cuZi9zmgm0sXTcFYY=;
	b=FFtPDSUMcxQthxEYd7AhQtUlVzrf3WNGhdIDvSscef02fw0JfvQupLfQiBt8Mdxr6xTJ
	 Cy34/tGjM/s6KqS0In/PjhgIycnEoGvsvgqiKmKHOQiK6X8pTpiqLE/z5GH3WqEBuFxt7
	 bFb++scj75uYwUKtsYzQzj0n/bq9RIQnW3eZWlpP+V+cdN1jyRSM5pLTg5Mqfr4Vfq8e9
	 aYPxw1vOxbn2/Ep2uW3M01/3ZOftb6WmAeDLLyQp9XfFuD2x5WxCuFoxt5m9Fqb/nETki
	 ez/4wGF3es3ivXRGeArGayB7+J0cpuhddkZRAYgoDolIiCOzRois2ejzhOpG/BPGb3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gj2RPzp5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CF0606A32D;
	Fri, 30 Oct 2026 12:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gj2RPzp5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AD91F00A02;
	Fri, 30 Oct 2026 12:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793364302;
	bh=39vmiQMtWyNbLcbiDzlBusK1H/cuZi9zmgm0sXTcFYY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Gj2RPzp5KoxwoKF1iHeEhDwox+gnRST+yoH0o9v+d3TaC6a5en8t/et4Zjfs6KMQo
	 JWb0Hgjhz0DR0zbCMuCWrPee21xbdusghAgokXsj6RME6McX2q3RV+/SVabtEUDQXP
	 gwip9Usb5Mqcl1RlK3wRv5+KSZUKLMeeCmq42pfRbPMx1dH7dSvKI+3UYKs3h1pxLL
	 mCw9H8fdP/hy5yRACZQUQRvkv0mGfAycJ9pP4nslDpPL7MVaAY8NYvZFiXcJIlfjsi
	 oObkI2BLOa4aMKBV1BCw7Kdt+VmsMNc9SUP3WNylBFLB3MbTSQ/xJyt9zr526VsvA1
	 dmUYU21IBRG8g==
Content-Type: multipart/mixed; boundary="===============8628985895442330667=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <e928310aa89e34b3521d3ab468a8021ecd0704cc400986d33e88ba45cba1b7d1@mail.kernel.org>
In-Reply-To: <20261030-bpf-verifier-patch-batch-v2-9-55cd43439f7c@gmail.com>
References: <20261030-bpf-verifier-patch-batch-v2-9-55cd43439f7c@gmail.com>
Subject: Re: [PATCH bpf-next v2 09/22] bpf: Strip nops through the patch list
From: bot+bpf-ci@kernel.org
To: odys.yuan@gmail.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,odys.yuan@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 30 Oct 2026 12:45:02 +0000 (UTC)

--===============8628985895442330667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Strip nops through the patch list

TL;DR: The nop-stripping look-back in bpf_opt_remove_nops() may be quadratic
with no preemption or signal check, so a crafted program with many nops could
stall BPF_PROG_LOAD on non-preemptible kernels.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 95f4fe5d607e..7c7c38eb9f0c 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c

[ ... ]

> -static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
> -{
> -	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
> -	unsigned int orig_prog_len = env->prog->len;
> -	int err;
> -
> -	if (bpf_rewrite_must_abort())
> -		return -EINTR;
> -

[ ... ]

> @@ -1028,32 +855,63 @@ int bpf_opt_remove_dead_code(struct bpf_verifier_env *env)
>  	return bpf_patch_list_commit(env);
>  }
>
> +/*
> + * Whether insn i is a nop once the insns in 'removed' are gone. Only forward
> + * jumps over removed insns can turn into one.
> + */
> +static bool insn_is_nop(struct bpf_verifier_env *env, int i,
> +			const unsigned long *removed)
> +{

[ ... ]

>  int bpf_opt_remove_nops(struct bpf_verifier_env *env)
>  {

[ ... ]

> +	for (i = 0; i < insn_cnt; i++) {
> +		if (!insn_is_nop(env, i, removed))
>  			continue;
> +		/*
> +		 * Removing may_goto +0 can turn the may_goto +1 in front of it
> +		 * into another one, look back as long as it does.
> +		 */
> +		for (j = i; ; ) {
> +			__set_bit(j, removed);
> +			if (env->prog->insnsi[j].code != MAY_GOTO_0.code)
> +				break;
> +			while (--j >= 0 && test_bit(j, removed))
> +				;
> +			if (j < 0 || !insn_is_nop(env, j, removed))
> +				break;
> +		}
> +	}

Is the look-back here still linear in the program size, and can it still be
interrupted?

The removed verifier_remove_insns() called bpf_rewrite_must_abort() on every
removal, and the old "i -= 2" step back went through it each time, so each
step had a fatal_signal_pending() and cond_resched() check.  The new
look-back has neither.

After a may_goto +0 is marked, the inner loop walks back bit by bit over the
whole contiguous run of already removed insns:

    while (--j >= 0 && test_bit(j, removed))
            ;

Consider N "ja 0" followed by K "may_goto +0" and an exit.  Every
may_goto +0 walks back over all of the N "ja 0" plus the earlier
may_goto +0 insns before it reaches j < 0, so the marking loop does about
K * N test_bit() calls.

K is limited by BPF_COMPLEXITY_LIMIT_JMP_SEQ (8192), since each may_goto
pushes a pending state while the main path continues to the exit.  N is
limited by BPF_COMPLEXITY_LIMIT_INSNS (1M) for a privileged loader, and
nops are only stripped when env->bpf_capable is set.  With N around 970k and
K around 8000 that is about 8e9 iterations of test_bit() in a loop with no
preemption point, so BPF_PROG_LOAD cannot be killed or rescheduled on a
CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY kernel until it finishes.

The only bpf_rewrite_must_abort() check left is in bpf_patch_list_del(),
which is reached from the for_each_set_bit() loop that runs after this
marking loop.

Could the loop remember the index of the last insn that was kept, instead of
rescanning the removed run for each may_goto +0?  That would keep the pass
linear, as the commit message intends, and a bpf_rewrite_must_abort() call
in the look-back would restore the killable/preemptible behaviour.

> +
> +	for_each_set_bit(i, removed, insn_cnt) {
> +		err = bpf_patch_list_del(env, i);
> +		if (err)
> +			break;
>  	}
> +	bitmap_free(removed);
>
> -	return 0;
> +	return err ?: bpf_patch_list_commit(env);
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41053659762
--===============8628985895442330667==--
