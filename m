Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CC52EFDA6
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 22:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777503362; cv=none; b=i37d5sDQxQxo4ajfFwz9VF8T91tpVJ32TOSxtBofDO04+BCBQRfOBonQli4uv+gkLfKIea62Hy8BWHTyAXdwwPGeOXzKnIGW6xR4Wa4fLekU3PkA7kNnsyOmKT8Yqe64K0W6rJdc5FeOdAIkSX9cGflPqMu+1hkS70petqa8Li8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777503362; c=relaxed/simple;
	bh=FywfVDR9cXiiJ7SYm4iq3ZXN30HLQ/+mEVzcyrY5jm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVa53DSroJSSaebaUMqodtETZ5g8wEhoKa+rGqP1yTXTnubC7p0QT19bDgrzalajIeYJ43CyCwz7qPlVpj0a8K0Ow4AezZFUvuRnY/EA055zZyt5jIpP6eFjDop165a9lJ2d1vO/NbGcuaW9BQ0CWqzvwcnkZoiv3dI9hTrzJ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n1b0tKHu; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n1b0tKHu"
Message-ID: <d581f2a8-75f3-4e93-bd75-69bfc2dc96dc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777503359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tMi0MKn+KOcAa/CMO5Jt5Vwi6GSl0q99nW7LK+Am4AI=;
	b=n1b0tKHun0HAt0efMoYDKkueVhgNMRQ6MBFh05Y80tnDI8W2YVq8TnEREwbzr8b3SqxM3X
	XBiTke7oirqkBfSrPyWNCgcBkBeWd/94G/bx8Ab5822LKB45CpjEIvt5TWnwFMRO3N14c6
	UXyDTkny60d8kHXpI8HVsj9sqlWp7j0=
Date: Wed, 29 Apr 2026 23:55:57 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 04/18] bpf: Extend liveness analysis to track
 stack argument slots
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260424171433.2034470-1-yonghong.song@linux.dev>
 <20260424171454.2035580-1-yonghong.song@linux.dev>
 <0ab27743df8930a342517e1f3246662c86c0763a.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <0ab27743df8930a342517e1f3246662c86c0763a.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/29/26 1:22 PM, Eduard Zingerman wrote:
> On Fri, 2026-04-24 at 10:14 -0700, Yonghong Song wrote:
>
> [...]
>
>> diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
>> index db73c4740b1e..b65285d61efe 100644
>> --- a/kernel/bpf/const_fold.c
>> +++ b/kernel/bpf/const_fold.c
>> @@ -51,13 +51,22 @@ static void const_reg_xfer(struct bpf_verifier_env *env, struct const_arg_info *
>>   			   struct bpf_insn *insn, struct bpf_insn *insns, int idx)
>>   {
>>   	struct const_arg_info unknown = { .state = CONST_ARG_UNKNOWN, .val = 0 };
>> -	struct const_arg_info *dst = &ci_out[insn->dst_reg];
>> -	struct const_arg_info *src = &ci_out[insn->src_reg];
>> +	struct const_arg_info *dst, *src;
> Nit: there is no harm in computing addresses before validating the range.
>
>>   	u8 class = BPF_CLASS(insn->code);
>>   	u8 mode = BPF_MODE(insn->code);
>>   	u8 opcode = BPF_OP(insn->code) | BPF_SRC(insn->code);
>>   	int r;
>>   
>> +	/* Stack arguments use BPF_REG_PARAMS which is outside the tracked register set. */
>> +	if (insn->dst_reg == BPF_REG_PARAMS)
> Nit: I'd add several accessors:
>       - is_stack_arg_st(insn)
>       - is_stack_arg_stx(insn)
>       - is_stack_arg_ldx(insn)
>
>> +		return;
>> +	if (insn->src_reg == BPF_REG_PARAMS) {
>> +		ci_out[insn->dst_reg] = unknown;
>> +		return;
>> +	}
>> +
>> +	dst = &ci_out[insn->dst_reg];
>> +	src = &ci_out[insn->src_reg];
>>   	switch (class) {
>>   	case BPF_ALU:
>>   	case BPF_ALU64:
> [...]
>
>> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
>> @@ -1560,6 +1603,9 @@ static int compute_subprog_args(struct bpf_verifier_env *env,
>>   	struct arg_track at_out[MAX_BPF_REG];
>>   	struct arg_track (*at_stack_in)[MAX_ARG_SPILL_SLOTS] = NULL;
>>   	struct arg_track *at_stack_out = NULL;
>> +	struct arg_track (*at_stack_arg_in)[MAX_STACK_ARG_SLOTS] = NULL;
>> +	struct arg_track at_stack_arg_out[MAX_STACK_ARG_SLOTS];
>> +	struct arg_track at_stack_arg_entry[MAX_STACK_ARG_SLOTS];
> I think this implementation is correct.  That being said, an
> alternative option would be to track at_stack_arg_{in,out} as a part
> of at_{in,out}, just at indexes >=11. This should avoid duplicating
> the code processing joins in compute_subprog_args(), record_call_access(),
> and memory handling a bit. Wdyt?

Good point. Let me give a try.

>
> [...]

