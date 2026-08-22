Received: from mta1.migadu.com (out-148.mta1.migadu.com [95.215.58.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D163F3A9871
	for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787417271; cv=none; b=kT0mYo4hUlQg/ShHBc9d4BFvzLyzCMI2SQDkgAcwlHO9Rp/5lOePrO21QINuHl0Qt8wD53E2gmyIVxGKYZXfH+KzalUrdbyuDWVp/VAa430nkPc7Z7UyBjsk8aB6wvvsZQBX6l26Rz3EDE7+tFsi9EwuOG2aJ4Ty97oYl7jy+cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787417271; c=relaxed/simple;
	bh=rDc3Id8axrTAcnL43ALOkwQoASNHMFwwWP5H5f36tv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZjmsIlBISgEgIBqBUdbn4zcJZE5NjY2u8il5vzZZeuD9uUh6jRcbfckmwnUx/JmTkyhiHVsZusEc5NnkT1+Xq1HZz427KWnnmigaFl+sd9dxWAbW3zoZ0tA/LRw2r3iw3cbmMm/HQQSdqrccqZw9XM6M9iSCAL1DG4EU+RrsFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VIHljJ1O; arc=none smtp.client-ip=95.215.58.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VIHljJ1O"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rDc3Id8axrTAcnL43ALOkwQoASNHMFwwWP5H5f36tv0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787417265; v=1; x=1788022065;
 b=VIHljJ1OVsHUtoUTeECyWLHKQ1yDlpH/gGp9kbbzkE1OSyGunnlz/0v9cKfHokdhXJkguUw9
 s6gNOLlF2u83VONIjFSyz2Rl0fKqHZ0xNLIrY2e/49gK26tI4iWTUEz5NELYX+uxjtMVDQY4OSd
 nq3LSMbuNAp8rMKk1Dqj3d0g=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:381:d619:d1ec:8d3:1358:3a33:c2e4] (2600:381:d619:d1ec:8d3:1358:3a33:c2e4)
	by smtp.migadu.com with ESMTPS id d9d4d2d40c17aaea;
	Sat, 22 Aug 2026 16:47:45 +0000
X-Mizu-Trace-ID: d9d4d2d40c17aaea
X-Migadu-Flow: FLOW_OUT
Message-ID: <bd05af85-eedf-4749-813d-452fecd2bcbe@linux.dev>
Date: Sat, 22 Aug 2026 09:47:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf: Rewrite "rX <<= 32; rX >>= 32" into "wX
 = wX" to keep linked scalars
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260821042837.2786719-1-yonghong.song@linux.dev>
 <f97bb12895dea33aa8f79b0468b5ada81510cc9d.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <f97bb12895dea33aa8f79b0468b5ada81510cc9d.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/21/26 10:36 AM, Eduard Zingerman wrote:
> On Thu, 2026-08-20 at 21:28 -0700, Yonghong Song wrote:
>> For the following test in
>> tools/testing/selftests/bpf/progs/verifier_linked_scalars.c:
>>
>> 	void alu32_negative_offset(void)
>> 	{
>> 		volatile char path[5];
>> 		volatile int offset = bpf_get_prandom_u32();
>> 		int off = offset;
>>
>> 		if (off >= 5 && off < 10)
>> 			path[off - 5] = '.';
>>
>> 		/* So compiler doesn't say: error: variable 'path' set but not used */
>> 		__sink(path[0]);
>> 	}
>>
>> Without alu32 (-mcpu=v2), the test
>> verifier_linked_scalars/alu32_negative_offset will fail with llvm22 and
>> llvm23 like below.
>>
>>    3: (bf) r2 = r1               ; R1=scalar(id=1,...) R2=scalar(id=1,...)
> Does r1 fit into 32-bit range at this point?
> I assume it does, otherwise it won't be possible to infer information
> about r1 range through zero extended r2.

Yes, r1 is in 32-bit range.

>
>>    4: (07) r2 += -5              ; R2=scalar(id=1-5,smin=-5,smax=0xfffffffa)
>>    5: (67) r2 <<= 32             ; R2=scalar(smax=0x7fffffff00000000,...)
>>    6: (77) r2 >>= 32             ; R2=scalar(smin=0,umax=0xffffffff,...)
>>    7: (25) if r2 > 0x4 goto pc+5 ; R2=scalar(smin=0,smax=umax=4,...)
>>    8: (bf) r2 = r10
>>    9: (07) r2 += -5
>>   10: (0f) r2 += r1              ; R1=scalar(id=1,smin=0,umax=0xffffffff)
>>                                  ; R2=fp(smin=-5,smax=0xfffffffa)
>>   11: (b7) r1 = 46               ; R1=46
>>   12: (73) *(u8 *)(r2 -5) = r1
>>   invalid unbounded variable-offset write to stack R2
>>
>> R1 is never narrowed down, so the address stays unbounded and the store
>> is rejected.
> ...
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 821b47ac75c5..e1de442801d9 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -15610,6 +15610,14 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
>>   	return 0;
>>   }
>>   
>> +static bool linked_base_fits_u32(const struct bpf_reg_state *reg)
>> +{
>> +	if (reg->id & BPF_ADD_CONST32)
>> +		return true;
>> +	return reg_smin(reg) >= (s64)reg->delta &&
>> +	       reg_smax(reg) <= (s64)U32_MAX + (s64)reg->delta;
>> +}
>> +
>>   /* Handles ALU ops other than BPF_END, BPF_NEG and BPF_MOV: computes new min/max
>>    * and var_off.
>>    */
>> @@ -15878,7 +15886,12 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
>>   						insn->src_reg);
>>   					return -EACCES;
>>   				} else if (src_reg->type == SCALAR_VALUE) {
>> -					if (insn->off == 0) {
>> +					if (insn->off == 0 && insn->src_reg == insn->dst_reg &&
>> +					    (dst_reg->id & BPF_ADD_CONST) &&
>> +					    linked_base_fits_u32(dst_reg)) {
>> +						dst_reg->id = (dst_reg->id & ~BPF_ADD_CONST64) |
>> +							      BPF_ADD_CONST32;
> This commit consists of two parts:
> - a special case for wA = wA assignment
> - a rewrite for `rA <<= 32; rA >>= 32;` pair
>
> Could you please split it in two with separate selftest for each.

Let me explain a little bit more.

For these four insns

   3: (bf) r2 = r1               ; R1=scalar(id=1,...) R2=scalar(id=1,...)
   4: (07) r2 += -5              ; R2=scalar(id=1-5,smin=-5,smax=0xfffffffa)
   5: (67) r2 <<= 32             ; R2=scalar(smax=0x7fffffff00000000,...)
   6: (77) r2 >>= 32             ; R2=scalar(smin=0,umax=0xffffffff,...)

Eventually, the above insns will be converted to

   3: (bf) r2 = r1               ; R1=scalar(id=1,...) R2=scalar(id=1,...)
   4: (07) r2 += -5              ; R2=scalar(id=1-5,smin=-5,smax=0xfffffffa)
   5: (bc) w2 = w2               ; R2=scalar(id=1-5,smin=0,umax=0xffffffff)
   6: (bc) w2 = w2               ; R2=scalar(id=1-5,smin=0,umax=0xffffffff)

insn 5 and 6 are the ones to be changed.

Here:

   5: (67) r2 <<= 32             ; R2=scalar(smax=0x7fffffff00000000,...)
   6: (77) r2 >>= 32             ; R2=scalar(smin=0,umax=0xffffffff,...)
converted to
   5: (bc) w2 = w2               ; R2=scalar(id=1-5,smin=0,umax=0xffffffff)

This insn
   6: (bc) w2 = w2               ; R2=scalar(id=1-5,smin=0,umax=0xffffffff)
is not really necessary. I put it here to maintain existing control flow graph.
Previously for insn 6, I used "goto pc+0" which will be removed later.
But "goto pc+0" has some impact on verification as it added yet another jump.
See bpf_is_state_visited():

         if (env->jmps_processed - env->prev_jmps_processed >= 2 &&
             env->insn_processed - env->prev_insn_processed >= 8)
                 add_new_state = true;

Here "goto pc+0" may impact for some programs. I didn't investigate this
in detail but probably I should investigate and fix the root cause.

Alternatively, we can rebuild the control flow graph by removing insn 6.
I am just not sure whether this is worthwhile or not.

> Also, could you please comment why the special case for `wA = wA` is necessary?

The second wA = wA is not needed. We can remove it and rebuild the control flow
for it, just not sure whether this is worthwhile or not. Probably yes.

> Is it because assign_scalar_id_before_mov() destroys the link:
>
>    static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
> 					  struct bpf_reg_state *src_reg)
> 	...
> 	if (src_reg->id & BPF_ADD_CONST)
> 		clear_scalar_id(src_reg);
>
> ?
>
> If that's the only reason, is it possible to extend existing wA = wB
> logic instead of adding a special case?
>
> Also note that this overlaps with Vineet's series [1].
> Representing zero extension as a combination of BPF_ADD_CONST32 and
> delta == 0 is a valid alternative for one of the patches there,
> but it also handles the value reconstruction on sync.
>
> [1] https://lore.kernel.org/bpf/20260814231945.3884596-1-vineet.gupta@linux.dev/

Thanks for the link. I see there are some change for BPF_ADD_CONST32.
I will wait after the above patch is settled.

>
>> +					} else if (insn->off == 0) {
>>   						bool is_src_reg_u32 = get_reg_width(src_reg) <= 32;
>>   
>>   						if (is_src_reg_u32)
> ...

