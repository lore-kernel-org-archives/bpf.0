Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6C15326BB;
	Wed, 23 Sep 2026 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790171766; cv=none; b=drFLhQDvdYme5eTXxHZ7qlwswdO2f4mFH7cmfUozJrMr3j6zoxtKXlc0hIxoTEnR5FLR8ZSq5HS6KAK3GWXSJyYVJ2ZB35IBKgJAc1GXl7D8ISJpXW3kvSI6FTN0k7b6zimfO95tTd2zVWUVclNKsmNC/h8rLoJPsPL1oU7iv10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790171766; c=relaxed/simple;
	bh=zqDy86mP9fmqxJ+z6nD8B7gI9aGd8Nj7Y7iVprPg1qc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RoX4oVgk9xSD9xP4R5cg0NdpXmevP5L28nPpkwNj+GxZLw49Dgjt53BeFgelQ+WSPpltKRkEld2ZpgjQn8a3Yz/NsUY7mYLs+yZMDSVupaMLMUznBUMZLGiX38Obyb3/U7S2BwD6E1OYD80ancpzNX5SZdXKgndlVQ9lswPlez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsXP6fbu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsXP6fbu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CFE1F008A0;
	Wed, 23 Sep 2026 13:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790171765;
	bh=/RkMoEre4s0cWwdK8pJI3qLzangpGPybRLGHnZa2kcY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bsXP6fbu3tADeWx3UZmNQmxUeu+hk9l2AVXYnpdgrU3Sq/eDl0cuboXcSTq4mhGNI
	 MOIzvLFdgmt9DrQVWJeKBqpO0moXOBvv0mGWYee61ztRmuhYkGEeJcVX6sU6DFdSYo
	 /V7BX2I9LFamNA3TSFBCplKficQd7ppVMaWcpGfzfWfbGzxy1tUMp+l9xrHgKIGNMh
	 ZJV+o5oZfHCuuFdogX6L0rLnOOJfn0g2Pkby6zAN1/yGOy5R5TWINFzYmlixcbOnYS
	 TSmaWvjVMHMPWjesbsstMqxKgUSSDAKBlC3HAyS1yinqrLA2fHVjqzkZYNYw5ewc68
	 6B2/b+tp6PHUw==
Content-Type: multipart/mixed; boundary="===============8758721912312969620=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d96c63f73df29f7a250296c2734afc94f516716f270e51e33e311691010c6a34@mail.kernel.org>
In-Reply-To: <20260923130856.1157-2-cp0613@linux.alibaba.com>
References: <20260923130856.1157-2-cp0613@linux.alibaba.com>
Subject: Re: [PATCH bpf-next 1/2] bpf, riscv: Add support for indirect jumps
From: bot+bpf-ci@kernel.org
To: cp0613@linux.alibaba.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,memxor@gmail.com,bjorn@kernel.org,puranjay@kernel.org
Cc: ihor.solodrai@linux.dev,eddyz87@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,pulehui@huawei.com,pjw@kernel.org,palmer@dabbelt.com,shuah@kernel.org,guoren@kernel.org,bpf@vger.kernel.org,linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 13:56:02 +0000 (UTC)

--===============8758721912312969620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index ed0a6f871dea..9de3749fb268 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c

[ ... ]

> diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
> index 2fb0b4e198b9..15acf249fed4 100644
> --- a/arch/riscv/net/bpf_jit_core.c
> +++ b/arch/riscv/net/bpf_jit_core.c

[ ... ]

> @@ -176,6 +179,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>  		for (i = 0; i < prog->len; i++)
>  			ctx->offset[i] = ninsns_rvoff(ctx->offset[i]);
>  		bpf_prog_fill_jited_linfo(prog, ctx->offset);
> +
> +		/*
> +		 * bpf_prog_update_insn_ptrs() wants the start of each insn, so
> +		 * shift the linfo array by one and get insn 0 from the prologue.
> +		 */
> +		for (i = prog->len - 1; i > 0; i--)
> +			ctx->offset[i] = ctx->offset[i - 1];
> +		ctx->offset[0] = ninsns_rvoff(ctx->prologue_len);
> +		bpf_prog_update_insn_ptrs(prog, ctx->offset, jit_data->ro_image);
>  out_offset:
>  		kvfree(ctx->offset);
>  		kfree(jit_data);

This isn't a bug, but could the comment say "shift ctx->offset[] by one"
rather than "shift the linfo array by one"? The jited_linfo was already
filled in by the bpf_prog_fill_jited_linfo() call above, and it is the
JIT's own offset table that is being rewritten here.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35866214591
--===============8758721912312969620==--
