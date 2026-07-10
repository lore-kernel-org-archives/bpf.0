Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB7A377020
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 05:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783659970; cv=none; b=lTC3iOSY3DxD5ItvSDEuXrdCQslyDhqZgvXhElcpM/5ARknqKDMzKD+HkXrKu7Z1PV9Tm58Il2Bka00Y4Bi9Jh6c7RK1tDsEVyC8L33MemL9m8dODKRkqM0IS4IJ2xpcqwXqaRVfgkoZ8JtzenWvzbXLnedW8dtqmlf86Zz5MuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783659970; c=relaxed/simple;
	bh=r1SV/VAIqh0LTiCs2Aku46CPzSfvXWfbue/QIiTaYrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lELp+ppvBXmhOIEVzkXJkQLOvWTSKKIe4ziJ9yQWIt/Dki6dbGOC9dKWWcyoKqkSK4EplnGAmqRAVU7xRLZiuCuCCFeRkO3loFBUcrzfEcb6wrl+aqC1ASzrBygQ3NAU5YJtcLbVFMQpx+vYXbTUpNgjy2Hg2nnomM56SbE25rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NQKsHWSX; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NQKsHWSX"
Message-ID: <50363f51-fed1-42d2-bbc1-c47698491c6a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783659966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2DtzN3Rymn55du6EpMklx49F6/oGPqHpV6S3iVsm0RQ=;
	b=NQKsHWSX+MdfYIXvrJuZGXf+II5SC5PzEv6JhKbnaAm00kF1KHEpWNsnBWp7zQ7u2rYtVj
	NL0rFdmkLDuZU3e5FF+om9doSU4HiHCOVnOoy/11uMTG/8s3VwbSJ6LnQvFSggG2iLTn7V
	3yYJflQ5ORISYn+f2UUqYguSYWhoOlk=
Date: Thu, 9 Jul 2026 22:06:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 05/12] bpf: Account R2 of register-pair returns
 in live register analysis
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
 <20260708201005.2158063-1-yonghong.song@linux.dev>
 <825b731a390d0ecb7827c5a421aebd1dd1ee8d84.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <825b731a390d0ecb7827c5a421aebd1dd1ee8d84.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/9/26 2:07 PM, Eduard Zingerman wrote:
> On Wed, 2026-07-08 at 13:10 -0700, Yonghong Song wrote:
>> A BPF_EXIT of a subprogram returning a value larger than 8 bytes (a
>> struct/union or an __int128) reads R2 as well as R0, since the second half
>> of the return value is passed back in R2. compute_insn_live_regs() only
>> marked R0 used at exit, so the callee's R2 could be considered dead and
>> cleaned from checkpointed states, which would allow unsound state pruning.
>>
>> Mark R2 used at a BPF_EXIT when the enclosing subprogram returns via the
>> R0:R2 register pair. The call site already treats the caller-saved
>> registers R0-R5 as clobbered, so R2 as a result register is covered there.
>>
>> For example, for a subprogram returning an __int128, the live-registers
>> dump (log level 2) shows both R0 and R2 live before the callee's exit
>> (insn 5):
>>
>>    Live regs before insn:
>>          0: .12345.... (85) call pc+2
>>          1: ..2....... (bf) r0 = r2
>>          2: 0......... (95) exit
>>          3: .......... (b7) r0 = 1
>>          4: 0......... (b7) r2 = 2
>>          5: 0.2....... (95) exit
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   kernel/bpf/liveness.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
>> index 0aadfbae0acc..0977d32fcf01 100644
>> --- a/kernel/bpf/liveness.c
>> +++ b/kernel/bpf/liveness.c
>> @@ -2062,7 +2062,8 @@ struct insn_live_regs {
>>   /* Compute info->{use,def} fields for the instruction */
>>   static void compute_insn_live_regs(struct bpf_verifier_env *env,
>>   				   struct bpf_insn *insn,
>> -				   struct insn_live_regs *info)
>> +				   struct insn_live_regs *info,
>> +				   int subprog)
>>   {
>>   	struct bpf_call_summary cs;
>>   	u8 class = BPF_CLASS(insn->code);
>> @@ -2175,6 +2176,8 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
>>   		case BPF_EXIT:
>>   			def = 0;
>>   			use = r0;
>> +			if (bpf_ret_reg_pair(env, subprog))
>> +				use |= BIT(BPF_REG_2);
>>   			break;
>>   		case BPF_CALL:
>>   			def = ALL_CALLER_SAVED_REGS;
>> @@ -2237,8 +2240,12 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
>>   		goto out;
>>   	}
>>   
>> -	for (i = 0; i < insn_cnt; ++i)
>> -		compute_insn_live_regs(env, &insns[i], &state[i]);
>> +	for (i = 0, j = 0; i < insn_cnt; ++i) {
>> +		/* Advance to the subprog that contains instruction i. */
>> +		while (j + 1 < env->subprog_cnt && env->subprog_info[j + 1].start <= i)
>> +			j++;
> This loop is very in-elegant. The outer loop can be changed to iterate
> subprograms, with inner loop iterating instructions. Or just use
> bpf_find_subprog() when processing EXIT.

Ack. I prefer to have iterating subprogram in outer loop and iterating insns
in the inner loop.

>
>> +		compute_insn_live_regs(env, &insns[i], &state[i], j);
>> +	}
>>   
>>   	/* Forward pass: resolve stack access through FP-derived pointers */
>>   	err = bpf_compute_subprog_arg_access(env);

