Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09823EA66
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 07:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780646261; cv=none; b=FojJnoY5TiISbJ4fIAIm4n3W3KxbRAkTnCLbeonKsm0axYY2ymd7yV3EocENXuaY2ss94VUp+RITCzq0/KxjA1KH1zaT061qelOlot2SmaVYi6zVzRdOmQ9vPxmNEHGuSrFeKsVg+RZovnGbvwDkmuSxjbq9GvbysK9q9e8Rd+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780646261; c=relaxed/simple;
	bh=iwo6Wmo7pxQx6rtK9VXb8wXgRhxsGDj53waPe5psmVs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YUcw/jMmv91FyVH/d/11DfEnwndTphNrV+KFLPUaSkVU0B8KhmNhnVChpUIrXwrNeN4B+x+vR5Xsy/9nkSpdJpAVbMmChFOXBHcxhwuvObo97xQPgv4H/3wev0e2VV/rjoZPIDvP7AdEQrhdWSt7DM7iosXFAucx6D5RkBmg3I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTIAf7/u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTIAf7/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416071F00893;
	Fri,  5 Jun 2026 07:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780646260;
	bh=mdT3uD8vZJSh5a4/TA7eXavwx98iTvqqxHOIgAeeQn8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fTIAf7/u/WL0QQisHykCbddOytnIqJm3AIaHe58AgWPfKlaq+1FQTcLo0HDIHvZr4
	 DoPG4BcXYgF2hoM5dmeI2rAPOjQuKWpdG9pIQT7lcw5IqUVLPsPsQ62OK1mvWkTuHv
	 JQCWlkl8PFBHjinTTsGaU/Y2vZ3il0QBWLL+24L6ORRXT8a8Mc48QOQ+H7hUfbz17s
	 5wIyalpRV6cEWNvScYdOHPMH7CFZR2RTv4uR8uFDqhKhlWq80WSQsuNtjMcI1F1VXT
	 7qQrdeNDmFMgM0M6nk3iF6oXML+owleJzwjiuMNQR7EfUTrZi2ySCipc1PJAN3pOHF
	 DwxkxSp+LmsBQ==
Content-Type: multipart/mixed; boundary="===============8438757971695485045=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8ba3b7a5c4885bc1d282b77f7648e95aad62a0c17062c384be31dc22c6b03b03@mail.kernel.org>
In-Reply-To: <20260605063412.974640-10-memxor@gmail.com>
References: <20260605063412.974640-10-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 09/17] bpf: Report Memory Safety bounds errors
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 07:57:40 +0000 (UTC)

--===============8438757971695485045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 920ac17758c2..0abe1ab19d25 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c

[ ... ]

> @@ -809,6 +809,119 @@ void bpf_diag_report_unreadable_reg(struct bpf_verifier_env *env,
>  				   "Avoid using the register after it is invalidated, or reload and revalidate a fresh pointer before this instruction.");
>  }
>
> +void bpf_diag_report_mem_bounds(struct bpf_verifier_env *env, u32 insn_idx,
> +				int regno, const char *reg_name,
> +				const char *type_name,
> +				enum bpf_diag_mem_bounds_kind kind,
> +				int off, int size, u32 mem_size,
> +				const struct bpf_reg_state *reg)
> +{

[ ... ]

> +	switch (kind) {
> +	case BPF_DIAG_MEM_NEGATIVE_MIN:
> +		scnprintf(proof, sizeof(proof),
> +			  "The smallest possible offset is %lld, below 0",
> +			  reg_smin(reg) + off);
> +		break;

When reg_smin(reg) is S64_MIN and off is negative, will this print a
contradictory positive number instead of a negative one?

Looking at the caller in check_mem_region_access(), it triggers the
BPF_DIAG_MEM_NEGATIVE_MIN diagnostic if reg_smin(reg) == S64_MIN:

kernel/bpf/verifier.c:check_mem_region_access() {
    if (reg_smin(reg) < 0 &&
        (reg_smin(reg) == S64_MIN ||
         ...)) {
        bpf_diag_report_mem_bounds(..., BPF_DIAG_MEM_NEGATIVE_MIN, ...);
    }
}

If off is negative, reg_smin(reg) + off will underflow S64_MIN and wrap
around to a huge positive number like 9223372036854775807. The diagnostic
output might then read something confusing like:
"The smallest possible offset is 9223372036854775807, below 0"

Unlike the max bounds case which correctly handles wrapping, the min bounds
case appears to evaluate this unconditionally:

> +	case BPF_DIAG_MEM_MAX_OUT_OF_RANGE:
> +	default:
> +		if (off < 0 && reg_umax(reg) < (u64)-off)
> +			max_start = 0;
> +		else
> +			max_start = reg_umax(reg) + off;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27000182395
--===============8438757971695485045==--
