Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FC81ACEDE
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 23:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769212197; cv=none; b=nkxZqzvX5f9ogDha99nQ0x4piMrT6o3tLCAflMu5eItj26xfCtUWG4L/Zu2crDkpLXSFTn4BPDtfuneMNgbzta9/3OXJFf/KmvyQR8de5UaFvJYn7n9O/ggj+wNvgn5p+5hxQMT7n/+URK0P/eHzswFTxTzpse7zIKJKoU/qM3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769212197; c=relaxed/simple;
	bh=b4VnQeWoptQ28TK9HlENzSnHiRsKOxr1MYsi2SmPhdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUx2dVt9JOwQNRhILudYnLsDTEacKq8OhkJwi2mpMQk36e1AZQ9ctuD2XpYaQtWj7VAwd3e1Rolap2AZgHOTGK4ZCxasXD7FyiLyvv914uDUhl+4lgaaClT2LKZhogCWMde0AP/kRsyWh4/MlcisBKuzouAS6A+4j9bf561EPPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ABSaO2mn; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ABSaO2mn"
Message-ID: <bbbf1b30-dfc9-4206-9285-0ce96e934e54@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769212183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xHM7cDEq2dLPRUsQsCW2aeoo3VeBsaynbMV8WcG9udo=;
	b=ABSaO2mnDYnQU5l6W0hwizoC8ZOSsTNyag7YtxswruaYmuQBHHFiJp5EX6fC4HSfggosEq
	AwCZIU98MhKBhEOqJZ/p8hMPBK8FeBUyF41XI//cMFoVuhhhZ3VE8X8iTtdF+OXI2U+h7c
	7eqjTX7bdLBftvJIC+laqg2DxrqoZq0=
Date: Fri, 23 Jan 2026 15:49:34 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/4] bpf, verifier: Support direct helper
 calls from prologue/epilogue
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org,
 kernel-team@cloudflare.com, ihor.solodrai@linux.dev, bpf@vger.kernel.org
References: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-0-0e50db4d4663@cloudflare.com>
 <20260123-skb-meta-bpf-emit-call-from-prologue-v2-1-0e50db4d4663@cloudflare.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-1-0e50db4d4663@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/23/26 9:05 AM, Jakub Sitnicki wrote:
> @@ -23909,6 +23928,9 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>   			goto next_insn;
>   		}
>   patch_call_imm:
> +		if (env->insn_aux_data[i + delta].finalized_call)
> +			goto next_insn;
> +
>   		fn = env->ops->get_func_proto(insn->imm, env->prog);
>   		/* all functions that have prototype and verifier allowed
>   		 * programs to call them, must be real in-kernel functions
> @@ -23920,6 +23942,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>   			return -EFAULT;
>   		}
>   		insn->imm = fn->func - __bpf_call_base;
> +		env->insn_aux_data[i + delta].finalized_call = true;
>   next_insn:
>   		if (subprogs[cur_subprog + 1].start == i + delta + 1) {
>   			subprogs[cur_subprog].stack_depth += stack_depth_extra;
> diff --git a/net/core/filter.c b/net/core/filter.c
> index d14401193b01..cb39388f69a9 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -9082,8 +9082,7 @@ static int bpf_unclone_prologue(struct bpf_insn *insn_buf, bool direct_write,
>   	/* ret = bpf_skb_pull_data(skb, 0); */
>   	*insn++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
>   	*insn++ = BPF_ALU64_REG(BPF_XOR, BPF_REG_2, BPF_REG_2);
> -	*insn++ = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
> -			       BPF_FUNC_skb_pull_data);
> +	*insn++ = BPF_EMIT_CALL(bpf_skb_pull_data);

Ihor reported that the test_map has started failing on arm64.

https://github.com/kernel-patches/bpf/actions/runs/21298510237/job/61311053284
https://github.com/kernel-patches/bpf/actions/runs/21298505282/job/61312363930
https://github.com/kernel-patches/bpf/actions/runs/21301695907/job/61321375157

For BPF_PROG_TYPE_SK_SKB, the BPF_FUNC_skb_pull_data has a different
func_proto. It is sk_skb_pull_data instead of bpf_skb_pull_data.
A different func needs to be emitted here based on prog type.
Not sure why it only fails on arm64.

The set has been reverted to get the CI going.
Please address the issue, add a test for this case, and
then respin. Thanks.

