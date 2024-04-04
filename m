Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844AB13B79F
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 22:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712268505; cv=none; b=dDpT6Lew66WU4jNa4qfKX7WSESLoQjjdMm12w8mJrNBqsBojZYu0G2eSxSGBBEC83npfPHHa5CYLHYcHe1NH8N46h8Qzlt3S8P5kswDf3n+VW3E1QzWHRZpG8dndEOa0br0d+9zyLC1i2zLx4Yiy3NgFoxaXOHbpxkhSnib+oOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712268505; c=relaxed/simple;
	bh=NF4Yu6YLDKq87PViz++XGy8mgHE38jgZknC+kIfo+gU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvfY9AoYDz7TN0iXgYllho4W7xrECgiqpzS+4DBlHiQzbz8nvbW8DHI8pNB08U3uPgzXoHGHDDzw00QwF0aOs86HcSZAhMEkNpB3pJJq9ef/1yG5fb2BSfOgUErLBB/+FdrliHEYlYGvfiX76ZYXHmWnok2KHzV3YgTV7JF9as0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JDDlF23F; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JDDlF23F"
Message-ID: <05dfc9a1-d572-4cf1-aa9f-bbe37b7c881e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712268501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXhIA8Ool2ai93FtDAK3tO1T7grvikM9ZpTLQOZzj/k=;
	b=JDDlF23FmRJz4CXf8G/ckd6/K+fpM+K8y6hT0SsbLQweJLprsFB+POx8JFiQuqDGdmyZab
	RfaJl3XRndOr+ZOMX5wSPrng5AOZvynhoFt9P+c08LL2ojU/TmTTwuDKkAmekZwQ8e0S8U
	uWR4Sz9evivz/ESj8XNAw28yELFhNfA=
Date: Thu, 4 Apr 2024 15:08:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] bpf: store both map ptr and state in
 bpf_insn_aux_data
Content-Language: en-GB
To: Philo Lu <lulie@linux.alibaba.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com, shuah@kernel.org, xuanzhuo@linux.alibaba.com
References: <20240402061615.48894-1-lulie@linux.alibaba.com>
 <20240402061615.48894-2-lulie@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240402061615.48894-2-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/1/24 11:16 PM, Philo Lu wrote:
> Currently, bpf_insn_aux_data->map_ptr_state is used to store either
> map_ptr or its poison state (i.e., BPF_MAP_PTR_POISON). Thus
> BPF_MAP_PTR_POISON must be checked before reading map_ptr. However we do
> need both of them sometimes, e.g., in bpf_for_each_map_elem() helper ().

You can say:
In certain cases, we may need valid map_ptr even in case of poison state.
This will be explained in next patch with bpf_for_each_map_elem() helper.

>
> This patch changes map_ptr_state into a new struct including both map
> pointer and its state (poison/unpriv). It's in the same union with
> struct bpf_loop_inline_state, so there is no extra memory overhead.
> Besides, macros BPF_MAP_PTR_UNPRIV/BPF_MAP_PTR_POISON/BPF_MAP_PTR are no
> longer needed.

You can further mention that this patch does not change any
existing functionality.

>
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> ---
>   include/linux/bpf_verifier.h |  9 ++++++++-
>   kernel/bpf/verifier.c        | 36 ++++++++++++++++--------------------
>   2 files changed, 24 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 7cb1b75eee38..1b5d6c7bb4e0 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -502,6 +502,13 @@ struct bpf_loop_inline_state {
>   	u32 callback_subprogno; /* valid when fit_for_inline is true */
>   };
>   
> +/* pointer and state for maps */
> +struct bpf_map_ptr_state {
> +	struct bpf_map *map_ptr;
> +	unsigned int poison:1;
> +	unsigned int unpriv:1;

Let us change 'unsigned int' to 'bool' which is more appropriate.

> +};
> +
>   /* Possible states for alu_state member. */
>   #define BPF_ALU_SANITIZE_SRC		(1U << 0)
>   #define BPF_ALU_SANITIZE_DST		(1U << 1)
> @@ -514,7 +521,7 @@ struct bpf_loop_inline_state {
>   struct bpf_insn_aux_data {
>   	union {
>   		enum bpf_reg_type ptr_type;	/* pointer type for load/store insns */
> -		unsigned long map_ptr_state;	/* pointer/poison value for maps */
> +		struct bpf_map_ptr_state map_ptr_state;
>   		s32 call_imm;			/* saved imm field of call insn */
>   		u32 alu_limit;			/* limit for add/sub register with pointer */
>   		struct {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index edb650667f44..515ac6165ab1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -190,11 +190,6 @@ struct bpf_verifier_stack_elem {
>   #define BPF_MAP_KEY_POISON	(1ULL << 63)
>   #define BPF_MAP_KEY_SEEN	(1ULL << 62)
>   
> -#define BPF_MAP_PTR_UNPRIV	1UL
> -#define BPF_MAP_PTR_POISON	((void *)((0xeB9FUL << 1) +	\
> -					  POISON_POINTER_DELTA))
> -#define BPF_MAP_PTR(X)		((struct bpf_map *)((X) & ~BPF_MAP_PTR_UNPRIV))
> -
>   #define BPF_GLOBAL_PERCPU_MA_MAX_SIZE  512
>   
>   static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx);
> @@ -209,21 +204,22 @@ static bool is_trusted_reg(const struct bpf_reg_state *reg);
>   
>   static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
>   {
> -	return BPF_MAP_PTR(aux->map_ptr_state) == BPF_MAP_PTR_POISON;
> +	return !!aux->map_ptr_state.poison;

with 'poison' is bool type, just return aux->map_ptr_state.poison.

>   }
>   
>   static bool bpf_map_ptr_unpriv(const struct bpf_insn_aux_data *aux)
>   {
> -	return aux->map_ptr_state & BPF_MAP_PTR_UNPRIV;
> +	return !!aux->map_ptr_state.unpriv;

return aux->map_ptr_state.unpriv.

>   }
>   
>   static void bpf_map_ptr_store(struct bpf_insn_aux_data *aux,
> -			      const struct bpf_map *map, bool unpriv)
> +			      struct bpf_map *map,
> +			      bool unpriv, bool poison)
>   {
> -	BUILD_BUG_ON((unsigned long)BPF_MAP_PTR_POISON & BPF_MAP_PTR_UNPRIV);
>   	unpriv |= bpf_map_ptr_unpriv(aux);
> -	aux->map_ptr_state = (unsigned long)map |
> -			     (unpriv ? BPF_MAP_PTR_UNPRIV : 0UL);
> +	aux->map_ptr_state.unpriv = unpriv;
> +	aux->map_ptr_state.poison = poison;
> +	aux->map_ptr_state.map_ptr = map;
>   }
>   
[...]
