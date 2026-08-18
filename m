Received: from mta0.migadu.com (out-71.mta0.migadu.com [91.218.175.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65F8383984
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787066613; cv=none; b=gbDJDoyb738gbg7l9vVjMtn/CpYzqzl3c6LoOcz6TCSbKi1c740k3i0n5+Y65bwIs2nN+GcAJqbcn6+Fx2ScR2mNBzplcDjn/V/smRGQAH0ah6cTJzgFZWYAqWOwqyW6g+KJ5Tf9+3Hrk++NeboJJeIbKx+c9WQMBGXbo1mRt1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787066613; c=relaxed/simple;
	bh=NN1nvwHVM4sMs6sktgMnbJCqc7wba36OW2ufgd8BrRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAxrkPQfdYbPUKzGphgci7by32Os+jmEISII2Gi3jXiClMn/y0PM+VizRuVZ8/ZsobSKFMUYfFVCsUSSguRVZUukshE8kpwNxnCtiSvRvrE8q6L4iVH+YNeUx2IxF6kcsUro5DjShW0SUMtKS78vIzACPfUFxNn6owalS30cU9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KdcUPKH8; arc=none smtp.client-ip=91.218.175.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KdcUPKH8"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NN1nvwHVM4sMs6sktgMnbJCqc7wba36OW2ufgd8BrRw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787066608; v=1; x=1787671408;
 b=KdcUPKH8pKIFNlTLCTQPgrB2VoRrBCQP9+VaekAchnkPkAMploPyDPLfOJJHwhdLgP8laGDg
 Nrp75lsUwCWvLnFTMnG110+IZPy2UVAJzfm1G1NPMz6SNKTtvoGAAJgEUDf3Q0Mqtsr/f0VYRKh
 9aS4TfqiY4y/AzrY2r9GuiN4=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:382:861a:c934:1800:dc08:870b:3340] (2600:382:861a:c934:1800:dc08:870b:3340)
	by smtp.migadu.com with ESMTPS id 9c4906d55d580d82;
	Tue, 18 Aug 2026 15:23:28 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <5d02cbe3-fd71-44e4-a6dd-706233ba248e@linux.dev>
Date: Tue, 18 Aug 2026 08:23:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] bpf: reject stack-argument callback subprograms
Content-Language: en-GB
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260817204812.1637171-1-Jeremy.Jean@oss.cyber.gouv.fr>
 <20260817204812.1637171-2-Jeremy.Jean@oss.cyber.gouv.fr>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260817204812.1637171-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/17/26 1:48 PM, Jérémy Jean wrote:
> Helper callbacks enter BPF subprograms through bpf_callback_t, whose
> runtime ABI supplies five arguments. BTF validation nevertheless permits
> static callback subprograms to declare more than five arguments when JIT
> stack arguments are supported.
>
> This lets verifier state for a callback use outgoing stack argument slots
> prepared at the helper call site. The helper does not pass those slots. On
> x86-64, callback loads of arguments seven and later therefore read the
> helper native frame instead of the synthetic values checked by the
> verifier. KASAN reports a slab OOB write.
>
> Reject callback subprograms with incoming stack arguments when processing
> callback calls.
>
> Fixes: 0f6bd5e7a804 ("bpf: Support stack arguments for bpf functions")
> Assisted-by: Codex:gpt-5
> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
>   kernel/bpf/verifier.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fdc5fbb1f78c..5fcefc0eaba0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9285,6 +9285,8 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
>   	err = btf_check_subprog_call(env, subprog, caller->regs);
>   	if (err == -EFAULT)
>   		return err;
> +	if (bpf_in_stack_arg_cnt(&env->subprog_info[subprog]))
> +		return -EINVAL;

This is not good as user will not know why it failed. Your v1 does have an error message.

But this is not needed. Without above verifer.c change, user will get an error message:
    func#0 writes 4 stack arg slots, but calls only require 0

NACK, see my v1 comment: https://lore.kernel.org/bpf/14a7e7c2-36f7-4aa2-9b20-cc54700a9f1b@linux.dev/

>   
>   	/* set_callee_state is used for direct subprog calls, but we are
>   	 * interested in validating only BPF helpers that can call subprogs as

