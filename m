Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D71036F42B
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648884; cv=none; b=cER8oYq4/iQn2OiyezFpSQgJlf9Qge3uLtaibQsVCHfBMoprbFkwlBVBumYqfwpe8neWBw1rIUNxgZFLrv9VKdz7nGvJn6yJYymJTF+DsyY7yNy+4lo3SYutt6SF5WRwjvuVaBBhsav97x4MdLzLZ/JXCNjtbjdQVQAo1NaaO+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648884; c=relaxed/simple;
	bh=uIb+bGCE8S4JEs44eUjR30wTDoR6S+nVPiNcXjCW1s8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cP62C8G5mYN/eEZBFbxVejuxQfRp3DpqwLSquztHA0P4kmln9kyrFu1j9STiDAZhPViagFUUK+C/hzNvKIvguVyhN6XARDZwIfGHTQoORiN9MoUzl0c4JbwDn8hn+J2m6mTZiBEfLzW77mZeC8r2bFEWFHjej1kSgwqXXUVvgek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCKq7fUk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCKq7fUk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4E21F000E9;
	Thu, 13 Aug 2026 19:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786648881;
	bh=vcdTJS3i7+0NgjBaxfFGy9SM8GMdH/9UuK8y2S17HWk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=GCKq7fUkjDrfaoW+hzIP7GemAz02jyujD/4yV6pOaE/undVtJMdaCahyQa1PI/v4g
	 Kzck52+qdQImt1aZJ4+/11TQd0cr9Qxq3Yje0AbFdqlPRdFaVRmY1VLmhJG+6mctRJ
	 kWz0peoSo7j2cnSWp5vFyMzaFk7fFG3dt0fXghMARdTQifzusHHLA2Yo0OfsFU1Xfj
	 Zi46eCkkYeG8IEcFPwtWypiMyvhPpCoSU4zZDYDRECN+yuBY3HMkVIeNHAh+d3Pakm
	 MY1DHJrzOr+IKekZZ1GxjDmIsgy4WLDeASLMO4FBcRoYEfOs6JEu2prlJWKv/mvCjd
	 t1pmFXvSJ02zg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, Mark Rutland <mark.rutland@arm.com>, Will
 Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Tejun
 Heo <tj@kernel.org>, Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH bpf-next 2/7] arm64: insn: Add encoder for ADD/SUB
 (extended register)
In-Reply-To: <e15065e4-881c-433a-9bc5-abd9991b0714@huaweicloud.com>
References: <20260810190922.3408757-1-puranjay@kernel.org>
 <20260810190922.3408757-3-puranjay@kernel.org>
 <e15065e4-881c-433a-9bc5-abd9991b0714@huaweicloud.com>
Date: Thu, 13 Aug 2026 20:21:15 +0100
Message-ID: <m2jyptzv10.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Xu Kuohai <xukuohai@huaweicloud.com> writes:

> On 8/11/2026 3:09 AM, Puranjay Mohan wrote:
>> From: Tejun Heo <tj@kernel.org>
>> 
>> The insn library encodes the immediate and shifted-register forms of
>> ADD/SUB but not the extended-register form. The BPF JIT wants it to
>> rebase a 32-bit arena offset onto the arena kernel base in a single
>> instruction, add xN, xBASE, wN, uxtw, instead of a separate zero-extend
>> followed by a plain add.
>> 
>> Add aarch64_insn_gen_add_sub_extended_reg(), modeled on the
>> shifted-register generator. The option and imm3 fields occupy the same
>> bits as the shifted form's shift amount, so they are encoded through the
>> existing IMM_6 field type.
>> 
>> Note that register 31 does not mean the same thing in the two forms: in
>> the extended-register encoding it is SP for Rn, and for Rd unless the
>> instruction sets the flags, while it stays XZR for Rm. Callers porting a
>> shifted-register site that passes A64_ZR need to be aware of that, so
>> say so above the function.
>> 
>> Signed-off-by: Tejun Heo <tj@kernel.org>
>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>> ---
>>   arch/arm64/include/asm/insn.h | 23 ++++++++++++++
>>   arch/arm64/lib/insn.c         | 60 +++++++++++++++++++++++++++++++++++
>>   2 files changed, 83 insertions(+)
>> 
>> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
>> index cc0702fa64a79..4548e8015808d 100644
>> --- a/arch/arm64/include/asm/insn.h
>> +++ b/arch/arm64/include/asm/insn.h
>> @@ -205,6 +205,18 @@ enum aarch64_insn_adsb_type {
>>   	AARCH64_INSN_ADSB_SUB_SETFLAGS
>>   };
>>   
>> +/* option field of add/sub (extended register) */
>> +enum aarch64_insn_extend_type {
>> +	AARCH64_INSN_EXTEND_UXTB,
>> +	AARCH64_INSN_EXTEND_UXTH,
>> +	AARCH64_INSN_EXTEND_UXTW,
>> +	AARCH64_INSN_EXTEND_UXTX,
>> +	AARCH64_INSN_EXTEND_SXTB,
>> +	AARCH64_INSN_EXTEND_SXTH,
>> +	AARCH64_INSN_EXTEND_SXTW,
>> +	AARCH64_INSN_EXTEND_SXTX,
>> +};
>> +
>
> I checked the Arm Architecture Reference Manual(ARM DDI 0487 M.c).
> The enum values correctly match the 3-bit "extend" values defined in
> the manual.
>
>>   enum aarch64_insn_movewide_type {
>>   	AARCH64_INSN_MOVEWIDE_ZERO,
>>   	AARCH64_INSN_MOVEWIDE_KEEP,
>> @@ -378,6 +390,10 @@ __AARCH64_INSN_FUNCS(add,	0x7F200000, 0x0B000000)
>>   __AARCH64_INSN_FUNCS(adds,	0x7F200000, 0x2B000000)
>>   __AARCH64_INSN_FUNCS(sub,	0x7F200000, 0x4B000000)
>>   __AARCH64_INSN_FUNCS(subs,	0x7F200000, 0x6B000000)
>> +__AARCH64_INSN_FUNCS(add_ext,	0x7F200000, 0x0B200000)
>> +__AARCH64_INSN_FUNCS(adds_ext,	0x7F200000, 0x2B200000)
>> +__AARCH64_INSN_FUNCS(sub_ext,	0x7F200000, 0x4B200000)
>> +__AARCH64_INSN_FUNCS(subs_ext,	0x7F200000, 0x6B200000)
>
> Page C4-814 of the manual ARM DDI 0487 M.c says the bits 22~23
> are fixed to 0 for ADD/SUB(extended register) instructions, so
> the mask should be 0x7FE00000, not 0x7F200000.

Thanks for catching this, fixed in v2.

>>   __AARCH64_INSN_FUNCS(madd,	0x7FE08000, 0x1B000000)
>>   __AARCH64_INSN_FUNCS(msub,	0x7FE08000, 0x1B008000)
>>   __AARCH64_INSN_FUNCS(udiv,	0x7FE0FC00, 0x1AC00800)
>> @@ -637,6 +653,13 @@ u32 aarch64_insn_gen_add_sub_shifted_reg(enum aarch64_insn_register dst,
>>   					 int shift,
>>   					 enum aarch64_insn_variant variant,
>>   					 enum aarch64_insn_adsb_type type);
>> +u32 aarch64_insn_gen_add_sub_extended_reg(enum aarch64_insn_register dst,
>> +					  enum aarch64_insn_register src,
>> +					  enum aarch64_insn_register reg,
>> +					  enum aarch64_insn_extend_type extend,
>> +					  int shift,
>> +					  enum aarch64_insn_variant variant,
>> +					  enum aarch64_insn_adsb_type type);
>>   u32 aarch64_insn_gen_data1(enum aarch64_insn_register dst,
>>   			   enum aarch64_insn_register src,
>>   			   enum aarch64_insn_variant variant,
>> diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
>> index 37ce75f7f1f08..e70ac02385153 100644
>> --- a/arch/arm64/lib/insn.c
>> +++ b/arch/arm64/lib/insn.c
>> @@ -986,6 +986,66 @@ u32 aarch64_insn_gen_add_sub_shifted_reg(enum aarch64_insn_register dst,
>>   	return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_6, insn, shift);
>>   }
>>   
>> +/*
>> + * Unlike the shifted-register form, register 31 is not XZR everywhere here:
>> + * it encodes SP for @src, and for @dst too unless @type sets the flags. Only
>> + * @reg keeps the XZR meaning.
>> + */
>> +u32 aarch64_insn_gen_add_sub_extended_reg(enum aarch64_insn_register dst,
>> +					  enum aarch64_insn_register src,
>> +					  enum aarch64_insn_register reg,
>> +					  enum aarch64_insn_extend_type extend,
>> +					  int shift,
>> +					  enum aarch64_insn_variant variant,
>> +					  enum aarch64_insn_adsb_type type)
>> +{
>> +	u32 insn;
>> +
>> +	switch (type) {
>> +	case AARCH64_INSN_ADSB_ADD:
>> +		insn = aarch64_insn_get_add_ext_value();
>> +		break;
>> +	case AARCH64_INSN_ADSB_SUB:
>> +		insn = aarch64_insn_get_sub_ext_value();
>> +		break;
>> +	case AARCH64_INSN_ADSB_ADD_SETFLAGS:
>> +		insn = aarch64_insn_get_adds_ext_value();
>> +		break;
>> +	case AARCH64_INSN_ADSB_SUB_SETFLAGS:
>> +		insn = aarch64_insn_get_subs_ext_value();
>> +		break;
>> +	default:
>> +		pr_err("%s: unknown add/sub encoding %d\n", __func__, type);
>> +		return AARCH64_BREAK_FAULT;
>> +	}
>> +
>> +	switch (variant) {
>> +	case AARCH64_INSN_VARIANT_32BIT:
>> +		break;
>> +	case AARCH64_INSN_VARIANT_64BIT:
>> +		insn |= AARCH64_INSN_SF_BIT;
>> +		break;
>> +	default:
>> +		pr_err("%s: unknown variant encoding %d\n", __func__, variant);
>> +		return AARCH64_BREAK_FAULT;
>> +	}
>> +
>> +	if (shift < 0 || shift > 4) {
>> +		pr_err("%s: invalid shift encoding %d\n", __func__, shift);
>> +		return AARCH64_BREAK_FAULT;
>> +	}
>> +
>> +	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RD, insn, dst);
>> +
>> +	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn, src);
>> +
>> +	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RM, insn, reg);
>> +
>> +	/* option in bits [15:13] and imm3 in [12:10] together fill IMM_6 */
>> +	return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_6, insn,
>> +					     (extend << 3) | shift);
>> +}
>> +
>>   u32 aarch64_insn_gen_data1(enum aarch64_insn_register dst,
>>   			   enum aarch64_insn_register src,
>>   			   enum aarch64_insn_variant variant,
>
> Except for the mask value mentioned above, the rest lgtm.
>
> Reviewed-by: Xu Kuohai <xukuohai@huawei.com>

Thanks for the review.
