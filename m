Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC343A3E98
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 10:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786615875; cv=none; b=p/2nd/iC3gmF+wmJV1UXqIlNvvkoyTQx5+m3fbH1ZbDomjTCVl9y1Pc3/pJcCQHpCq56TKe0KVOxi0Yfr4oQYkwXOeSbJKiX5lapaDYjchqDzAOYgvC0o98F1M9bEvfUeboeasYKHAHiOTBnO/8mmi6c9RQm1zpEYCHB3gH0Yl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786615875; c=relaxed/simple;
	bh=BQdKGszJehJrpdNMOmOMODpoMnDI3zBgvmPQAZMe1+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4SAbRF8d48voUxnSfoMsR7pwMWKNt9uSflbtl6x7QqPbn4Py1SmUhF6rNKQ84pRbUMj2XQkzs2VB+xkwUyLOGhiYq68rN9kbPE/RikH5oWQGiLMK2l0T5AGmenczwI3BMTtXWMWn2xSd2Al44nfJxcVjrY/ZFE7JbsTepqkb7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hLLjD661szYQvpt
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 18:10:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 66B2D40561
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 18:11:03 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgB3Z0Y2mH1qTpefCA--.1118S2;
	Thu, 13 Aug 2026 18:11:03 +0800 (CST)
Message-ID: <e15065e4-881c-433a-9bc5-abd9991b0714@huaweicloud.com>
Date: Thu, 13 Aug 2026 18:11:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/7] arm64: insn: Add encoder for ADD/SUB
 (extended register)
Content-Language: en-US
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Tejun Heo <tj@kernel.org>
References: <20260810190922.3408757-1-puranjay@kernel.org>
 <20260810190922.3408757-3-puranjay@kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20260810190922.3408757-3-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgB3Z0Y2mH1qTpefCA--.1118S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKr18AFy8WF1fCw1rWFWUXFb_yoWxGry8p3
	98Zrs3GF48XrW7uFyftF1DXFn0qFWFkwsxWrnrCw4Fkw4DJa4aqr42gr9IqF45Cr1j9F4D
	tF4j9w4F9F48A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 8/11/2026 3:09 AM, Puranjay Mohan wrote:
> From: Tejun Heo <tj@kernel.org>
> 
> The insn library encodes the immediate and shifted-register forms of
> ADD/SUB but not the extended-register form. The BPF JIT wants it to
> rebase a 32-bit arena offset onto the arena kernel base in a single
> instruction, add xN, xBASE, wN, uxtw, instead of a separate zero-extend
> followed by a plain add.
> 
> Add aarch64_insn_gen_add_sub_extended_reg(), modeled on the
> shifted-register generator. The option and imm3 fields occupy the same
> bits as the shifted form's shift amount, so they are encoded through the
> existing IMM_6 field type.
> 
> Note that register 31 does not mean the same thing in the two forms: in
> the extended-register encoding it is SP for Rn, and for Rd unless the
> instruction sets the flags, while it stays XZR for Rm. Callers porting a
> shifted-register site that passes A64_ZR need to be aware of that, so
> say so above the function.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>   arch/arm64/include/asm/insn.h | 23 ++++++++++++++
>   arch/arm64/lib/insn.c         | 60 +++++++++++++++++++++++++++++++++++
>   2 files changed, 83 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
> index cc0702fa64a79..4548e8015808d 100644
> --- a/arch/arm64/include/asm/insn.h
> +++ b/arch/arm64/include/asm/insn.h
> @@ -205,6 +205,18 @@ enum aarch64_insn_adsb_type {
>   	AARCH64_INSN_ADSB_SUB_SETFLAGS
>   };
>   
> +/* option field of add/sub (extended register) */
> +enum aarch64_insn_extend_type {
> +	AARCH64_INSN_EXTEND_UXTB,
> +	AARCH64_INSN_EXTEND_UXTH,
> +	AARCH64_INSN_EXTEND_UXTW,
> +	AARCH64_INSN_EXTEND_UXTX,
> +	AARCH64_INSN_EXTEND_SXTB,
> +	AARCH64_INSN_EXTEND_SXTH,
> +	AARCH64_INSN_EXTEND_SXTW,
> +	AARCH64_INSN_EXTEND_SXTX,
> +};
> +

I checked the Arm Architecture Reference Manual(ARM DDI 0487 M.c).
The enum values correctly match the 3-bit "extend" values defined in
the manual.

>   enum aarch64_insn_movewide_type {
>   	AARCH64_INSN_MOVEWIDE_ZERO,
>   	AARCH64_INSN_MOVEWIDE_KEEP,
> @@ -378,6 +390,10 @@ __AARCH64_INSN_FUNCS(add,	0x7F200000, 0x0B000000)
>   __AARCH64_INSN_FUNCS(adds,	0x7F200000, 0x2B000000)
>   __AARCH64_INSN_FUNCS(sub,	0x7F200000, 0x4B000000)
>   __AARCH64_INSN_FUNCS(subs,	0x7F200000, 0x6B000000)
> +__AARCH64_INSN_FUNCS(add_ext,	0x7F200000, 0x0B200000)
> +__AARCH64_INSN_FUNCS(adds_ext,	0x7F200000, 0x2B200000)
> +__AARCH64_INSN_FUNCS(sub_ext,	0x7F200000, 0x4B200000)
> +__AARCH64_INSN_FUNCS(subs_ext,	0x7F200000, 0x6B200000)

Page C4-814 of the manual ARM DDI 0487 M.c says the bits 22~23
are fixed to 0 for ADD/SUB(extended register) instructions, so
the mask should be 0x7FE00000, not 0x7F200000.

>   __AARCH64_INSN_FUNCS(madd,	0x7FE08000, 0x1B000000)
>   __AARCH64_INSN_FUNCS(msub,	0x7FE08000, 0x1B008000)
>   __AARCH64_INSN_FUNCS(udiv,	0x7FE0FC00, 0x1AC00800)
> @@ -637,6 +653,13 @@ u32 aarch64_insn_gen_add_sub_shifted_reg(enum aarch64_insn_register dst,
>   					 int shift,
>   					 enum aarch64_insn_variant variant,
>   					 enum aarch64_insn_adsb_type type);
> +u32 aarch64_insn_gen_add_sub_extended_reg(enum aarch64_insn_register dst,
> +					  enum aarch64_insn_register src,
> +					  enum aarch64_insn_register reg,
> +					  enum aarch64_insn_extend_type extend,
> +					  int shift,
> +					  enum aarch64_insn_variant variant,
> +					  enum aarch64_insn_adsb_type type);
>   u32 aarch64_insn_gen_data1(enum aarch64_insn_register dst,
>   			   enum aarch64_insn_register src,
>   			   enum aarch64_insn_variant variant,
> diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
> index 37ce75f7f1f08..e70ac02385153 100644
> --- a/arch/arm64/lib/insn.c
> +++ b/arch/arm64/lib/insn.c
> @@ -986,6 +986,66 @@ u32 aarch64_insn_gen_add_sub_shifted_reg(enum aarch64_insn_register dst,
>   	return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_6, insn, shift);
>   }
>   
> +/*
> + * Unlike the shifted-register form, register 31 is not XZR everywhere here:
> + * it encodes SP for @src, and for @dst too unless @type sets the flags. Only
> + * @reg keeps the XZR meaning.
> + */
> +u32 aarch64_insn_gen_add_sub_extended_reg(enum aarch64_insn_register dst,
> +					  enum aarch64_insn_register src,
> +					  enum aarch64_insn_register reg,
> +					  enum aarch64_insn_extend_type extend,
> +					  int shift,
> +					  enum aarch64_insn_variant variant,
> +					  enum aarch64_insn_adsb_type type)
> +{
> +	u32 insn;
> +
> +	switch (type) {
> +	case AARCH64_INSN_ADSB_ADD:
> +		insn = aarch64_insn_get_add_ext_value();
> +		break;
> +	case AARCH64_INSN_ADSB_SUB:
> +		insn = aarch64_insn_get_sub_ext_value();
> +		break;
> +	case AARCH64_INSN_ADSB_ADD_SETFLAGS:
> +		insn = aarch64_insn_get_adds_ext_value();
> +		break;
> +	case AARCH64_INSN_ADSB_SUB_SETFLAGS:
> +		insn = aarch64_insn_get_subs_ext_value();
> +		break;
> +	default:
> +		pr_err("%s: unknown add/sub encoding %d\n", __func__, type);
> +		return AARCH64_BREAK_FAULT;
> +	}
> +
> +	switch (variant) {
> +	case AARCH64_INSN_VARIANT_32BIT:
> +		break;
> +	case AARCH64_INSN_VARIANT_64BIT:
> +		insn |= AARCH64_INSN_SF_BIT;
> +		break;
> +	default:
> +		pr_err("%s: unknown variant encoding %d\n", __func__, variant);
> +		return AARCH64_BREAK_FAULT;
> +	}
> +
> +	if (shift < 0 || shift > 4) {
> +		pr_err("%s: invalid shift encoding %d\n", __func__, shift);
> +		return AARCH64_BREAK_FAULT;
> +	}
> +
> +	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RD, insn, dst);
> +
> +	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn, src);
> +
> +	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RM, insn, reg);
> +
> +	/* option in bits [15:13] and imm3 in [12:10] together fill IMM_6 */
> +	return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_6, insn,
> +					     (extend << 3) | shift);
> +}
> +
>   u32 aarch64_insn_gen_data1(enum aarch64_insn_register dst,
>   			   enum aarch64_insn_register src,
>   			   enum aarch64_insn_variant variant,

Except for the mask value mentioned above, the rest lgtm.

Reviewed-by: Xu Kuohai <xukuohai@huawei.com>

