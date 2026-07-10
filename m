Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F373943800A
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783698351; cv=none; b=A+lZJO3sesGoeSJPFclQA2aBcYgN6+4Bj+2lHf46R17Ax0zkudwTT6xHMiXNr2OmimRWlWvwHueC2iIa2vx0b3UQ0vgB+KqjsJAcXpmoad8ylZIuD9JQLCIrbgP/bqA6AF4qhIdDtWt+w944DxHyu2fY4pNwBkDx9kphw/x3nS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783698351; c=relaxed/simple;
	bh=/8w4cg3G0sz49ntb0AfSThhT1fR15YhZSUKEzoSGPW8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Hx20y7Ds99r8sIENdTHaIDr9aVhZml+wEgYzKdbNu8RikdG57P7TkJCPs5ZkXLt9fMQi3/nj5V7c5iCDeSbDE6QFV8VOn0z0TpcUwts/oiKDkOW6b23j9HYaCJAd8o8Wy/aUrbrQEq34PsjUGparvq56kjCIRRw9kSPOGkRg6lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUwyEt7J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUwyEt7J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D24B1F000E9;
	Fri, 10 Jul 2026 15:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783698349;
	bh=j88XhhDhq467nmXHadIa3AfQnRxJvwZQkWbcisEzIBA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BUwyEt7JtJ61c9412CxUmP8GiIU62GIoJsyWHxc+X8Df5USxF87ETrXnYSoprQ2Tt
	 Fum0nElDROuOw4spuucVxhfaE1WYNBxuPAaq8yggUnzaG76btJYyLhq5lWMT3hRkZE
	 HKKwsYSTtBWAM6UX2xvFrm/a160oAqIU5Bsv1Lmid1kq2zucpRF93k5TV9n9KHPCcv
	 pjJcnp3MZRiO/8CXtERb71Eb3Y54fdXG23DsG2+aY0BXkmqO44fqieR1qyEH78RT6o
	 +nNCyZNWRygNvYjDtDNa+kHT7wuJlWrkeErwOBSwbUNrtH96lp8e+dqtpxXmw3W5bl
	 v1g83tLY5KEpQ==
Content-Type: multipart/mixed; boundary="===============4457655665606767974=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a45c78cf3167aa868b8a50fae2a4979c09f21890212e2013e05303b1fff30add@mail.kernel.org>
In-Reply-To: <20260710144404.2579671-1-yonghong.song@linux.dev>
References: <20260710144404.2579671-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf 1/2] bpf: Reject >8 byte return values on return-reading trampoline paths
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,leon.hwang@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 10 Jul 2026 15:45:49 +0000 (UTC)

--===============4457655665606767974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 51b16e5f5534..bbb44ef8f87a 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -445,6 +445,18 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>  		goto errout;
>  	}
>
> +	/*
> +	 * A >8 byte return value is passed back in the R0:R2 register
                                                                  ^^^^

Does this comment have the correct register pair? Looking at the commit
message, it states the second half of the return value is "RDX / R3", and
in arch/x86/net/bpf_jit_comp.c reg2hex[] shows BPF_REG_0 = RAX and
BPF_REG_3 = RDX, while BPF_REG_2 = RSI (an argument register).

Should this be R0:R3 instead of R0:R2 to match the x86-64 ABI return pair?

> +	 * pair, which the struct_ops trampoline does not preserve (only
> +	 * 8 bytes of the return value are saved and restored).
> +	 */
> +	if (st_ops->func_models[i].ret_size > 8) {
> +		pr_warn("func ptr %s in struct %s has a >8 byte return value, which is not supported\n",
> +			mname, st_ops->name);
> +		err = -EOPNOTSUPP;
> +		goto errout;
> +	}
> +
>  	stub_func_addr = *(void **)(st_ops->cfi_stubs + moff);
>  	err = prepare_arg_info(btf, st_ops->name, mname,
>  			       func_proto, stub_func_addr,

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29101893933
--===============4457655665606767974==--
