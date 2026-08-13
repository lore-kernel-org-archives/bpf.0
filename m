Received: from mta1.migadu.com (out-229.mta1.migadu.com [95.215.58.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8F02F531B
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786644334; cv=none; b=ALIhaqzOOxzDP3U6Wr96eFSTcQTyLbREJeU7bpLjyQWvanYqj682dihlqz3GbpIstg5a0cIRg6ZuR1F1PvD1KmqKLkxaKKmcrSAdAXeCrYIfbLv5XQRfwcBNzvi6qpqievrca/wZKIvztmKd/i21lsLjTOi3DVE8aPp/A2+tiks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786644334; c=relaxed/simple;
	bh=Wp/X/mEujTaPdvVgUNwfZJyH81darH6pDTHk91I0sYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=srcIaZksJ07RgD6VRpJM/071wHgAO3OuBfJrXfSnNgj4P4zMYUUrcj0lepItzzDmOjhIoYPHKbO/ALfFNu3ZdaPH4+CL1Xjb3wBOVx8QuNpM4dZKHmUXyC/Jua5Uhhp3f/5mXeZa1ILfQ1UuNbojHtyuPLL0YX6bYz3aAhgo7Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b3wuwQWP; arc=none smtp.client-ip=95.215.58.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b3wuwQWP"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Wp/X/mEujTaPdvVgUNwfZJyH81darH6pDTHk91I0sYc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786644330; v=1; x=1787249130;
 b=b3wuwQWPX46/A4VuFg3MF/9uWmiJpItEOH0ZLxDrPB6prJlP+SjuICjSX4nv+gz1IrYiV1Ht
 7Nv9TcbQq+tFbExhsRJ2WAKLitNRC5BXwX4mTF4wSPcJx4PwXrNTmELuhuUTMP5n1cAxj5QvfpO
 LLQ8SB4rwh+/uBpnbi3EU6jw=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:381:1f2d:e3e3:185d:58c3:4c79:68c] (2600:381:1f2d:e3e3:185d:58c3:4c79:68c)
	by smtp.migadu.com with ESMTPS id bc141ebfc3cd9cb7;
	Thu, 13 Aug 2026 18:05:30 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <547517b3-0ed9-41fb-8973-e381b8b70561@linux.dev>
Date: Thu, 13 Aug 2026 11:05:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 05/13] bpf: Account R2 of register-pair
 returns in live register analysis
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260811000911.2378679-1-yonghong.song@linux.dev>
 <20260811000937.2381528-1-yonghong.song@linux.dev>
 <f98b37e8dfd115063150a7f3caea873451295771.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <f98b37e8dfd115063150a7f3caea873451295771.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/12/26 2:21 PM, Eduard Zingerman wrote:
> On Mon, 2026-08-10 at 17:09 -0700, Yonghong Song wrote:
>> A BPF_EXIT of a subprogram returning a value larger than 8 bytes (a
>> struct/union or an __int128) reads R2 as well as R0, since the second half
>> of the return value is passed back in R2. compute_insn_live_regs() only
>> marked R0 used at exit, so a callee's R2 could be considered dead and
>> cleaned from checkpointed states, which would allow unsound state pruning.
>>
>> Mark R2 as read at the BPF_EXIT of a subprogram that does return a register
>> pair. bpf_compute_live_registers() walks the instructions in order and
>> env->subprog_info[] is sorted by subprogram start, so the containing
>> subprogram is tracked with a running index and its return convention is
>> queried once per subprogram through bpf_ret_reg_pair().
>>
>> Marking R2 at every exit instead would be simpler, but R2 would then stay
>> live backwards across any call that is not followed by a write to R2, which
>> is nearly every program, and would needlessly hurt state pruning.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
>>   kernel/bpf/liveness.c | 25 ++++++++++++++++++-------
>>   1 file changed, 18 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
>> index ef9a5a922887..451edd74fa6f 100644
>> --- a/kernel/bpf/liveness.c
>> +++ b/kernel/bpf/liveness.c
>> @@ -2062,10 +2062,15 @@ static inline u32 mask_widen(u32 m) { return m | (m << 16); }
>>   static inline u16 mask_lo(u32 m) { return (u16)m; }
>>   static inline u16 mask_hi(u32 m) { return (u16)(m >> 16); }
>>   
>> -/* Compute info->{use,def} fields for the instruction */
>> +/*
>> + * Compute info->{use,def} fields for the instruction. @ret_reg_pair tells
>> + * whether the subprogram containing @insn returns its value in the R0:R2
>> + * register pair, which matters for BPF_EXIT.
>> + */
> Nit: this comment change is unnecessary.

Okay, will revert to the original comment.

>
>>   static void compute_insn_live_regs(struct bpf_verifier_env *env,
>>   				   struct bpf_insn *insn,
>> -				   struct insn_live_regs *info)
>> +				   struct insn_live_regs *info,
>> +				   bool ret_reg_pair)
>>   {
>>   	struct bpf_call_summary cs;
>>   	const u8 class = BPF_CLASS(insn->code);
>> @@ -2196,7 +2201,7 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
>>   			break;
>>   		case BPF_EXIT:
>>   			def = 0;
>> -			use = r0;
>> +			use = ret_reg_pair ? (r0 | reg64_mask(BPF_REG_2)) : r0;
> Nit: let's add an r2 variable.

Good point. Will do.

>
>>   			break;
>>   		case BPF_CALL:
>>   			def = ALL_CALLER_SAVED_REGS;
> ...

