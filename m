Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A0230BF69;
	Thu, 23 Jul 2026 03:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784778562; cv=none; b=DFwsZyQyBAWo3483LADg4vfR/6K/vHcL3Mn8oBs573q7eQsAB/1FqWAsuGqRTZcdbeUgksmDEc54bRZD1ALmMXkOufy3EwRSh0WYg2l+O5gE2sg+iJ3d7nhChHELHFx5zQIeK7UVNubT+5ow5x1K+iXlr1LLCpMkJOIAT5HDoHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784778562; c=relaxed/simple;
	bh=JRHRF0UjL/tTfKOLQFnEUxWAZntvU2Jl6BEMJgCB28Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C65LCLQ55c1viJPH+N96OLzaBpNra43I1EMuD9q/+wywtS0VeWwjjMyzwgIZzozw+nVCWRFHQh53Ko0JusCxiyl71TyqLjlOUkGl4o7SBOAYplGZT0aIFqnptZFFN+QFISGhI8248Ip6Jb8pPb96bLAt737mqVo26fd6BHFOcSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=43cuyZEp; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="43cuyZEp"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Sk4MQY9fTdOcpYq6qts+pW/9sqmDmJd6Hq154AHz+MQ=;
	b=43cuyZEp52Ztmp8boMTIafERbfeeV/KpNpPM7tX8db/0xlNHlbTzpIzdaMEvrY98nc1s2LJJH
	mnKUgX+cJd5PNNspIdNokvXsboveYUBXLJeTN4nhut+gJP6YrU6z5ymw0QBA5YvjsYqf/YlTe3F
	kCf2CRvTa7v0lt8zZtOkYco=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4h5H1d4qBdz1K96b;
	Thu, 23 Jul 2026 11:39:49 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 9225440588;
	Thu, 23 Jul 2026 11:49:11 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 23 Jul
 2026 11:49:10 +0800
Message-ID: <8c8ade93-05e1-4b94-9278-8c641600c123@huawei.com>
Date: Thu, 23 Jul 2026 11:49:09 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix WARNING in
 bpf_tracing_link_release
Content-Language: en-US
To: Leon Hwang <leon.hwang@linux.dev>, <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
	<martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
	<emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, Jingguo Tan
	<tanjingguo@huawei.com>, Lin Ma <malin89@huawei.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <kernel-patches-bot@fb.com>
References: <20260722151909.69142-1-leon.hwang@linux.dev>
 <20260722151909.69142-2-leon.hwang@linux.dev>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260722151909.69142-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/7/22 23:19, Leon Hwang wrote:
> The trampoline could be corrupted by the blindly
> 'tr->flags = BPF_TRAMP_F_TAIL_CALL_CTX' in verifier.
> 
> 1. A fexit attached to a tail_call_reachable prog. 'tr->flags' became
>     'BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_TAIL_CALL_CTX'. And, the
>     trampoline would poke the target prog's nop insn using jmp insn instead
>     of call insn.
> 2. Another fexit loaded with the same tail_call_reachable prog target.
>     'tr->flags' became 'BPF_TRAMP_F_TAIL_CALL_CTX'.
> 3. Close the first fexit link. Due to no BPF_TRAMP_F_CALL_ORIG in
>     'tr->flags', the trampoline will fail to restore the prog's nop insn
>     using call insn.
> 
> [    3.410719] WARNING: kernel/bpf/syscall.c:3551 at bpf_tracing_link_release+0x53/0x60, CPU#1: test_progs/98
> ...
> [    3.428793]  bpf_link_free+0x58/0x130
> [    3.429293]  bpf_link_release+0x23/0x30
> 
> Fix the warning by updating 'tr->flags' with '|=' and lock.
> 
> Fixes: 2b5dcb31a19a ("bpf, x64: Fix tailcall infinite loop")
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>   include/linux/bpf.h     | 2 ++
>   kernel/bpf/trampoline.c | 7 +++++++
>   kernel/bpf/verifier.c   | 2 +-
>   3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index e066f44a9c05..7bfc28673124 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1523,6 +1523,7 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
>   				struct bpf_tracing_multi_link *link);
>   int bpf_trampoline_multi_detach(struct bpf_prog *prog,
>   				struct bpf_tracing_multi_link *link);
> +void bpf_trampoline_set_flags(struct bpf_trampoline *tr, u32 flags);
>   
>   /*
>    * When the architecture supports STATIC_CALL replace the bpf_dispatcher_fn
> @@ -1646,6 +1647,7 @@ static inline int bpf_trampoline_multi_detach(struct bpf_prog *prog,
>   {
>   	return -ENOTSUPP;
>   }
> +static inline void bpf_trampoline_set_flags(struct bpf_trampoline *tr, u32 flags) {}
>   #endif
>   
>   struct bpf_func_info_aux {
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 6eadf64f7ec9..129d07db117e 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -670,6 +670,13 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, int size)
>   	return ERR_PTR(err);
>   }
>   
> +void bpf_trampoline_set_flags(struct bpf_trampoline *tr, u32 flags)
> +{
> +	trampoline_lock(tr);
> +	tr->flags |= flags;
> +	trampoline_unlock(tr);
> +}
> +
>   static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex,
>   				 const struct bpf_trampoline_ops *ops, void *data)
>   {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 52be0a118cce..66d8d9eaec05 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19523,7 +19523,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
>   		return -ENOMEM;
>   
>   	if (tgt_prog && tgt_prog->aux->tail_call_reachable)
> -		tr->flags = BPF_TRAMP_F_TAIL_CALL_CTX;
> +		bpf_trampoline_set_flags(tr, BPF_TRAMP_F_TAIL_CALL_CTX);
>   
>   	prog->aux->dst_trampoline = tr;
>   	return 0;

Reviewed-by: Pu Lehui <pulehui@huawei.com>
