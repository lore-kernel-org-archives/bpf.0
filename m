Received: from mta0.migadu.com (out-85.mta0.migadu.com [91.218.175.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ABD30AD05
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 05:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789103139; cv=none; b=dEH9YM/TPAo2A8ICJPhAMfmTPDWzPwvLj2zqmVz+Yf+iWJVQ9V2zc0V076yZmzrsIktdFKLVEB2ovtrejR8V4vtqmrgN1di41t8uCom/fj7U2Gu82wK9kMLi4cZWMUZIslwP3gnjDy97SlM3Cx7sBap0B+csRkBa54Cs2FLq0Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789103139; c=relaxed/simple;
	bh=2Gkj5VJt7SRjzEW/QyXw+AWkCyZdehrXf3Pt3IETZ+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hKF7cJ6JdqIp4qG6XlbJXbCUq9WDz9BqJmjuABGosjpnRx0TfLGbwwhtZKLjPbK96fDKaeAwEuIyw+mh/8gXdmpsfyHxzvP5NbOvjPJuLjVBKDvALS4DrSwxNYt/KnxXSQ6QACh6zNYns9Yl3IorWYfoZfdwEWIINrtXvFQps5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c+ulu6J8; arc=none smtp.client-ip=91.218.175.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c+ulu6J8"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2Gkj5VJt7SRjzEW/QyXw+AWkCyZdehrXf3Pt3IETZ+g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789103132; v=1; x=1789707932;
 b=c+ulu6J8MaG2fEKq//g5Ad3MndVuP7OKB7l8dfkRKJVl2/doI75SHnGNu8awfXmW1/LMBWg/
 l7YQkrjbhoYLtIn2yhAnpSdIgkHU5fsgJWQef+7RQxxUL/G0PTbIz3sf77/pdPflIWpO+WvKFlp
 gZ63uQ8S0KToWwHWu4r8vxOo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 66dadd09ed6c7452;
	Fri, 11 Sep 2026 05:05:28 +0000
X-Mizu-Trace-ID: 66dadd09ed6c7452
X-Migadu-Flow: FLOW_OUT
Message-ID: <8d5905b3-ab49-46c9-96c0-4709646f12b3@linux.dev>
Date: Thu, 10 Sep 2026 22:05:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 07/12] bpf: Prepare kfunc arguments for the
 JIT from an ABI description
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260909062522.4001896-1-yonghong.song@linux.dev>
 <20260909062559.4007404-1-yonghong.song@linux.dev>
 <20260909064649.55C691F00A3A@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260909064649.55C691F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/8/26 11:46 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Stack buffer overflow in `bpf_jit_plan_arg_moves` and `kfunc_abi_slots` due to undersized arrays based on maximum arguments rather than maximum slots.
> --
>
> commit 180655f49c406c35435ba5ebc05f2900a3c56656
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Prepare kfunc arguments for the JIT from an ABI description
>      
> The previous patch refuses a kfunc argument of more than one eightbyte.
> This patch allows up to 16 byte kfunc arguments.
>
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index 00ad8b63aa477..01b52d0259d18 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
> [ ... ]
>> @@ -1248,6 +1248,38 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
>> +
>> +/* The JIT's scratch register, in place of an argument slot. */
>> +#define BPF_JIT_ARG_TMP		0xff
>> +
>> +/* Every argument slot moves at most once, and the scratch goes out and back. */
>> +#define BPF_JIT_MAX_ARG_MOVES	(MAX_BPF_FUNC_ARGS + 2)
> [Severity: Medium]
> Since arguments can now take up to 2 slots (for 16-byte arguments), could the
> maximum number of slot moves actually be up to 26 (24 slots + 2) instead of 14?

In jit, for x86_64, we have

         /* x86-64 supports up to MAX_BPF_FUNC_ARGS arguments. 1-6
          * are passed through regs, the remains are through stack.
          */
         if (nr_regs > MAX_BPF_FUNC_ARGS)
                 return -ENOTSUPP;

So the maximum number of regs is 12, so we are okay for x86_64.

But arm64 is different. It has

static int calc_arg_aux(const struct btf_func_model *m,
                          struct arg_aux *a)
{
         int stack_slots, nregs, slots, i;

         /* verifier ensures m->nr_args <= MAX_BPF_FUNC_ARGS */
         for (i = 0, nregs = 0; i < m->nr_args; i++) {
                 slots = (m->arg_size[i] + 7) / 8;
                 if (nregs + slots <= 8) /* passed through register ? */
                         nregs += slots;
                 else
                         break;
         }

	...
}

So the maximum number of reg arguments can be 24. I think I will
add a patch similar to x86_64 above.

>
>> +
>> +struct bpf_jit_arg_move {
>> +	u8 dst;
>> +	u8 src;
>> +};
> [ ... ]
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index c673b02d55a65..d4bd2ba9aadee 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
> [ ... ]
>> @@ -3287,6 +3287,100 @@ bool __weak bpf_jit_supports_kfunc_ret_reg_pair(void)
>> +
>> +u32 bpf_jit_place_args(const struct bpf_jit_arg_abi *abi,
>> +		       const struct btf_func_model *fm, u8 *pos_of_slot)
>> +{
>> +	u32 i, k, nslots, slot = 0, nregs_used = 0, stack_off = 0;
>> +	bool on_stack = false;
>> +
>> +	for (i = 0; i < fm->nr_args; i++) {
>> +		bool align16 = fm->arg_flags[i] & BTF_FMODEL_ALIGN16_ARG;
>> +		u32 pos;
>> +
>> +		nslots = btf_func_model_arg_slots(fm, i);
> [ ... ]
>> +		for (k = 0; k < nslots; k++)
>> +			pos_of_slot[slot + k] = pos + k;
> [Severity: Medium]
> Will this overflow the pos_of_slot array if an architecture adopts this API
> for BPF trampolines?
>
> The callers currently size the array based on MAX_BPF_FUNC_ARGS (12), but
> slot + k can reach up to 23 because some arguments can require multiple slots.

I will add a check to ensure maximum reg arguments is 12.

>
>> +		slot += nslots;
>> +	}
>> +
>> +	return slot;
>> +}
>> +
>> +u32 bpf_jit_plan_arg_moves(const struct bpf_jit_arg_abi *abi,
>> +			   const struct btf_func_model *fm,
>> +			   struct bpf_jit_arg_move *moves)
>> +{
>> +	u8 pos_of_slot[MAX_BPF_FUNC_ARGS];
> [Severity: Medium]
> Does this stack array need to be sized for the maximum number of slots
> (e.g., MAX_BPF_FUNC_ARGS * 2) instead of the maximum number of arguments?

This is for kfunc. I will check whether we need to do
   MAX_BPF_FUNC_ARGS * 2
or not.

>
>> +	u32 nslots, n = 0, s, back;
>> +
>> +	nslots = bpf_jit_place_args(abi, fm, pos_of_slot);
> [ ... ]
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 94c359351bb69..2b8df8c7f098c 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>> @@ -12172,6 +12172,58 @@ static u32 kfunc_proto_slots(const struct btf *btf, const struct btf_type *func_
>>   	return slots_used;
>>   }
>>   
>> +static u32 kfunc_abi_slots(const struct btf_func_model *fm)
>> +{
>> +	const struct bpf_jit_arg_abi *abi = bpf_jit_arg_abi();
>> +	u8 pos_of_slot[MAX_BPF_FUNC_ARGS];
> [Severity: Medium]
> Similarly, does this stack array also need to be sized to accommodate up to
> 24 slots rather than 12 arguments to prevent an out-of-bounds write in
> bpf_jit_place_args()?

Yes, I will check whether we need to have 24 slots or not.

>
>> +	u32 i, nslots, slots = 0;
>> +
>> +	for (i = 0; i < fm->nr_args; i++)
>> +		slots += btf_func_model_arg_slots(fm, i);
>> +
>> +	if (!abi)
>> +		return slots;
>> +
>> +	nslots = bpf_jit_place_args(abi, fm, pos_of_slot);

