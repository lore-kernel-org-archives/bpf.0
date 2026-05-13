Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7E73D3498
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778653592; cv=none; b=OLfrlr+kWtRpS1DjkCi+T/hUOZ3RDXSwegUQU9y3gtzi313tbaOe4DfjXPszeBlDYbsi78QZcdOUYC05ouLbaDKhNk7P3um5/EIJPBJj+Y9c9zyEQVQ/i5c9kHMh9RUeqtvxSaDb186tiTy+/gtRLu4+83DmbzScmdXIzbwyfC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778653592; c=relaxed/simple;
	bh=L1meuBnTATeCE7naJLP4jSqrIb78/RPPU43L+0CmyJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WPs/pmOy1BRpsr6rbDP/7n2AD/U1fXg3JFfQti5pYd3JSydwsAqFVD2oMioggZTgny0Nk1wXxghNq7tTU40wOXRKWruKCXANB1zhxrmNCWMpw5hmAyhn3h/WM9uRv6V0e/rsXbaodAWd0xjjIgZtVIF48qXQCOanS6ATBVlqA7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIBO6/0r; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIBO6/0r"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b788a98557so47948385ad.2
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 23:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778653589; x=1779258389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ep83jt+OM8P/+jtbt5r2tBIY+pKdA2ouS001Dlu0TG8=;
        b=VIBO6/0r2qXmmKbG+axkolR1+BEs6cKmxhranGKRIGXtSp8x6d6HOA/1AOjti5L3Xo
         RT3xH5J+pB/Ukbw546f7BAoua/BCqkA7KIucYLqHb0zD/ooCrTgUBNHVdsf5L9XBdbfs
         iVtOXxtWg+ccEObTxrJXN+xTirvZ7zv2fhE4SCzjveAVAc7g7WDYaEnfT/57ovSAWU8F
         OmIdgvf7c0mIaMsxWcipuyT+eRpvb2t9fUOWYEDgS2M8dK/iafEort4NHMiiX4hCDkDP
         3S5w5stiufQMrdJ0pschVT27/CPKhFp0H8UqyB15xbjZJLc3u91xXb7bYj3wYhWrmdnY
         o61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778653589; x=1779258389;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ep83jt+OM8P/+jtbt5r2tBIY+pKdA2ouS001Dlu0TG8=;
        b=mlG+vKJ9loadMXp2YUEsEwAkDsdp6zbgjhUrHfeh8lB0h78BsD0W0fg8HlbBnS4UPb
         Ec6yvNHA99OO2GVe63K+wesh+IPky76n1fx2/D+wJdFVDYbbvwTVfT95CkK5XK4rN4Vh
         MzZbxkA6+NKkDB1E6a3gxm3u7S7xQK9Kg7Mii4oQQt2DstC+PWzffDNARF4kTjtroMT2
         ksUfm3R2b5LAQMTTQ0m/V3Gmy7YPvL9IPDCkZj2z1Yt+ecKfBQFfOpWZvHNrP38Cek8N
         4yPHpkgPuADo+Cf9y3ZveT9HSrN/chsj01lPk2gb/SqwChecJ+KYl0CkueSmFT8MTKG9
         fkvA==
X-Gm-Message-State: AOJu0YzkH8Qq9Jeq5dWTW/k+O2k4TtpFeC4m95urlZDajZ9rHNLNe3qg
	4Y6pCrOMFnZx6Eo+X7OT9FE9WMTDzabzkT4RZRktoML/crWx1qB9AK13
X-Gm-Gg: Acq92OG3djlHuKyO6Qdz1+tPvRfUUoJ7kNWh5Nd5DmkW+3Pbyy6Go7EVFzfw+li5Eby
	4WpnBMTL2d4hFOu2UinZgP+Ohxq1MGO77KqkMYWaPYb1CYJGlIoOwpiOx0AQa6+LpxKrBwcNYc6
	fTt4yytiGuOc6eh1LuFAlSFKZI1QTgo8wDbtELfRqBlxNr9NEE4b9cBvmGt0+m3eH7KUBg0asS2
	Cjsr1dUs+ELiykD6HciD5Jlb3vDnGskIb8zjOdz8+cmBhLw+gk+kREDUAcPhRI15r3FZKi3J2jP
	q+ZzgYpmQOu8Yyq5pDEzAclyduwJ4RplHMSIxTQHhIgM6jBwbJr99S4uDfUv5OL4hbjlRnlzb+j
	mcncTuGlVFDoQRIS8E94YTnFhTSbiVCLWYsgeGAxeXV20x/sqCuoxJnymkA8GaT+sE1M0maRSmq
	v6W5mANNJbqwGtYIMGKqPUJTn3bqZoGDGwckrB8w==
X-Received: by 2002:a17:903:bc2:b0:2b0:c45a:bc2 with SMTP id d9443c01a7336-2bd27139901mr17598235ad.16.1778653588704;
        Tue, 12 May 2026 23:26:28 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9582:1100::c7c9? ([2604:3d08:9582:1100::c7c9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ec6e7dsm159310935ad.82.2026.05.12.23.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 23:26:28 -0700 (PDT)
Message-ID: <b76a0b89-3cef-4f72-90b1-7029b989cb63@gmail.com>
Date: Tue, 12 May 2026 23:26:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 16/19] unwind_user/sframe: Add support for SFrame V3
 flexible FDEs
To: Jens Remus <jremus@linux.ibm.com>, Steven Rostedt <rostedt@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev
References: <20260505121718.3572346-17-jremus@linux.ibm.com>
 <20260505185502.CB501C2BCB4@smtp.kernel.org>
 <fc085657-a79c-422d-afd5-4b5f2c55cec2@linux.ibm.com>
Content-Language: en-US
From: Indu Bhagat <ibhagatgnu@gmail.com>
In-Reply-To: <fc085657-a79c-422d-afd5-4b5f2c55cec2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-05-07 08:30, Jens Remus wrote:
> On 5/5/2026 8:55 PM, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>> - [High] Valid flexible FREs ending in a single padding data word are incorrectly rejected.
> 
> Those are invalid as per SFrame spec.
> 
>> - [High] Valid flexible FRE rules for CFA and FP/RA produce unhandled enums, triggering user-controlled WARN_ON_ONCE().
> 
> Fix below.
> 
>> - [High] Outermost frame unwinding is unconditionally broken, causing unintended fallback to frame pointers.
> 
> Fix below.
> 
>> --
>>
>> commit 7d3289b2e756d08c38877458400ce276ff3f5994
>> Author: Jens Remus <jremus@linux.ibm.com>
>>
>> unwind_user/sframe: Add support for SFrame V3 flexible FDEs
>>
>> SFrame V3 introduces flexible FDEs in addition to the regular FDEs.
>> The key difference is that flexible FDEs encode the CFA, RA, and FP
>> tracking information using two FRE data words, a control word and an
>> offset, or a single padding data word of zero.
>>
>>> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
>>> index 2721f4af53fd3..2ba2c8b385f96 100644
>>> --- a/kernel/unwind/sframe.c
>>> +++ b/kernel/unwind/sframe.c
>> [ ... ]
>>> @@ -189,16 +193,147 @@ static __always_inline int __find_fde(struct sframe_section *sec,
>> [ ... ]
>>> +static __always_inline int
>>> +__read_flex_fde_fre_datawords(struct sframe_section *sec,
>>> +			      struct sframe_fde_internal *fde,
>>> +			      unsigned long cur,
>>> +			      unsigned char dataword_count,
>>> +			      unsigned char dataword_size,
>>> +			      struct sframe_fre_internal *fre)
>>> +{
>>> +	u32 cfa_ctl, ra_ctl, fp_ctl;
>>> +	s32 cfa_off, ra_off, fp_off;
>>> +
>>> +	if (dataword_count < 2)
>>> +		return -EFAULT;
>>> +	UNSAFE_GET_USER_INC(cfa_ctl, cur, dataword_size, Efault);
>>> +	UNSAFE_GET_USER_INC(cfa_off, cur, dataword_size, Efault);
>>> +	dataword_count -= 2;
>>> +
> 
> 	/*
> 	 * Each RA/FP location info consumes either two datawords
> 	 * (control word + offset) or one padding word substituting
> 	 * for that pair.  Padding is only valid as substitution if
> 	 * followed by further non-padding location info.  Therefore
> 	 * decoding only proceeds with at least two datawords.  Any
> 	 * leftover trailing datawords are invalid and rejected by
> 	 * the final check.
> 	 */
> 
>>> +	ra_off = sec->ra_off;
>>> +	ra_ctl = ra_off ? 2 : 0; /* regnum=0, deref_p=(ra_off != 0), reg_p=0 */
>>> +	if (dataword_count >= 2) {
>>
>> The commit message mentions that flexible FDEs can use a single padding
>> data word of zero. However, this code checks dataword_count >= 2 for both
>> the RA and FP blocks.
> 
> That is ok, as a padding dataword for RA is only valid if followed by
> two datawords (control and offset) for FP.  In case of a valid padding
> dataword for RA only one dataword is consumed.  In case of an invalid
> trailing padding dataword for RA it is not consumed.  The same logic is
> then used for FP, as that ensures that a leftover trailing padding for
> for both RA or FP is not consumed (and then rejected by the final check)
> and that any future extension e.g. to convey SP location info can use
> the same logic.  This helps reducing the number of checks at the cost
> of a slow error path.  Otherwise the checks would be:
> 
> 	/* RA */
> 	if (!dataword_count)
> 		goto done;
> 	if (dataword_count == 1)
> 		return -EFAULT; /* Trailing RA padding */
> 	... consume RA dataword(s) ...
> 
> 	/* FP */
> 	if (!dataword_count)
> 		goto done;
> 	if (dataword_count == 1)
> 		return -EFAULT; /* Trailing FP padding */
> 	... consume FP dataword(s) ...
> 
> 	if (dataword_count)
> 		return -EFAULT; /* Trailing extra dataword(s) */
> 
> done:
> 	fre->cfa_ctl	= cfa_ctl;
> 	...
> 
>>
>> If an FRE ends with a single padding data word, it will bypass both of these
>> blocks and reach the check below:
>>
>>> +		UNSAFE_GET_USER_INC(ra_ctl, cur, dataword_size, Efault);
>>> +		dataword_count--;
>>> +		if (ra_ctl) {
>>> +			UNSAFE_GET_USER_INC(ra_off, cur, dataword_size, Efault);
>>> +			dataword_count--;
>>> +		} else {
>>> +			/* Padding RA location info */
>>> +			ra_ctl = ra_off ? 2 : 0; /* re-deduce (see above) */
>>> +		}
>>> +	}
>>> +
>>> +	fp_off = sec->fp_off;
>>> +	fp_ctl = fp_off ? 2 : 0; /* regnum=0, deref_p=(fp_off != 0), reg_p=0 */
>>> +	if (dataword_count >= 2) {
>>> +		UNSAFE_GET_USER_INC(fp_ctl, cur, dataword_size, Efault);
>>> +		dataword_count--;
>>> +		if (fp_ctl) {
>>> +			UNSAFE_GET_USER_INC(fp_off, cur, dataword_size, Efault);
>>> +			dataword_count--;
>>> +		} else {
>>> +			/* Padding FP location info */
>>> +			fp_ctl = fp_off ? 2 : 0; /* re-deduce (see above) */
>>> +		}
>>> +	}
>>> +
> 	/* Reject trailing padding or unknown extra datawords */
> 
>>> +	if (dataword_count)
>>> +		return -EFAULT;
>>
>> Could this incorrectly reject valid FREs ending in a single padding data word
>> since dataword_count would be 1 here?
>>
>>> +
>>> +	fre->cfa_ctl	= cfa_ctl;
>>> +	fre->cfa_off	= cfa_off;
>>> +	fre->ra_ctl	= ra_ctl;
>>> +	fre->ra_off	= ra_off;
>>> +	fre->fp_ctl	= fp_ctl;
>>> +	fre->fp_off	= fp_off;
>>> +
>>> +	return 0;
>>> +
>>> +Efault:
>>> +	return -EFAULT;
>>> +}
>> [ ... ]
>>>   static __always_inline int __read_fre(struct sframe_section *sec,
>>>   				      struct sframe_fde_internal *fde,
>>>   				      unsigned long fre_addr,
>>>   				      struct sframe_fre_internal *fre)
>>>   {
>> [ ... ]
>>>   	if (!dataword_count) {
>>>   		/*
>>>   		 * A FRE without data words indicates RA undefined /
>>>   		 * outermost frame.
>>>   		 */
>>> -		cfa_off	= 0;
>>> -		ra_off	= 0;
>>> -		fp_off	= 0;
>>> -		goto done;
>>> -	}
>>> +		fre->cfa_ctl	= 0;
> 
> 	/*
> 	 * A FRE without datawords indicates an outermost
> 	 * frame.  Zero-initialize CFA, RA, and FP location
> 	 * info, except for the CFA control word, which
> 	 * must not cause sframe_init_cfa_rule_data() to fail.
> 	 */
> 	fre->cfa_ctl    = (SFRAME_REG_SP << 3) | 1; /* regnum=SP, deref_p=0, reg_p=1 */
> 
>>> +		fre->cfa_off	= 0;
>>> +		fre->ra_ctl	= 0;
>>> +		fre->ra_off	= 0;
>>> +		fre->fp_ctl	= 0;
>>> +		fre->fp_off	= 0;
>>>   
>>> -	UNSAFE_GET_USER_INC(cfa_off, cur, dataword_size, Efault);
>>
>> When __read_fre() processes an outermost frame, it zeroes out fre->cfa_ctl.
>> In __find_fre(), this is later passed to sframe_init_cfa_rule_data():
>>
>>> -static __always_inline void
>>> +static __always_inline int
>>>   sframe_init_cfa_rule_data(struct unwind_user_cfa_rule_data *cfa_rule_data,
>>> -			  unsigned char fre_info,
>>> -			  s32 offset)
>>> +			  u32 ctlword, s32 offset)
>>>   {
>>> -	if (SFRAME_V3_FRE_CFA_BASE_REG_ID(fre_info) == SFRAME_BASE_REG_FP)
>>> -		cfa_rule_data->rule = UNWIND_USER_CFA_RULE_FP_OFFSET;
>>> -	else
>>> -		cfa_rule_data->rule = UNWIND_USER_CFA_RULE_SP_OFFSET;
>>> +	bool deref_p = SFRAME_V3_FLEX_FDE_CTRLWORD_DEREF_P(ctlword);
>>> +	bool reg_p = SFRAME_V3_FLEX_FDE_CTRLWORD_REG_P(ctlword);
>>> +
>>> +	if (reg_p) {
>>> +		unsigned int regnum = SFRAME_V3_FLEX_FDE_CTRLWORD_REGNUM(ctlword);
>>> +
>>> +		switch (regnum) {
>>> +		case SFRAME_REG_SP:
>>> +			cfa_rule_data->rule = UNWIND_USER_CFA_RULE_SP_OFFSET;
>>> +			break;
>>> +		case SFRAME_REG_FP:
>>> +			cfa_rule_data->rule = UNWIND_USER_CFA_RULE_FP_OFFSET;
>>> +			break;
>>> +		default:
>>> +			cfa_rule_data->rule = UNWIND_USER_CFA_RULE_REG_OFFSET;
>>> +			cfa_rule_data->regnum = regnum;
>>> +		}
>>> +	} else {
>>> +		return -EINVAL;
>>> +	}
>>
>> Because ctlword is 0 for an outermost frame, reg_p will evaluate to false,
>> and this unconditionally returns -EINVAL.
>>
>> Does this unintentionally break outermost frame unwinding? Returning an
>> error here will cause __find_fre() to fail before it can reach the
>> frame->outermost check, resulting in a fallback to frame pointer unwinding
>> instead of stopping gracefully.
> 
> Good catch!  That was broken.  I did not notice during my testing on
> s390, as the fallback to FP-based (back chain on s390) unwinding then
> also detected an outermost frame.  Suggested fix see above.
> 
>>
>>> +
>>> +	if (deref_p)
>>> +		cfa_rule_data->rule |= UNWIND_USER_RULE_DEREF;
>>> +
>>
>> Also, does this append UNWIND_USER_RULE_DEREF to CFA rules in a way that is
>> not supported by the unwinder?
>>
>> If a CFA rule uses SP/FP with deref_p=1, this creates a combined enum like
>> UNWIND_USER_CFA_RULE_SP_OFFSET | UNWIND_USER_RULE_DEREF. Because .sframe
>> sections are user-supplied, could an attacker use this to trigger an
>> unhandled enum path and hit a WARN_ON_ONCE() during unwinding?
> 
> Good catch!  The generic unwinding logic in unwind_user_next_common()
> actually needs to support both UNWIND_USER_CFA_RULE_SP_OFFSET_DEREF and
> UNWIND_USER_CFA_RULE_FP_OFFSET_DEREF, as those are valid to be encoded
> in SFrame flexible FDE and sframe_init_cfa_rule_data() converts
> deref_p=1, reg_p=1, regnum=SP/FP into those.  The reason for the
> conversion is that arbitrary registers are only available in the topmost
> frame, whereas SP and FP are available in any frame.
> 
>>
>>>   	cfa_rule_data->offset = offset;
>>> +
>>> +	return 0;
>>>   }
>>>   
>>>   static __always_inline void
> 
> static __always_inline int
> 
>>>   sframe_init_rule_data(struct unwind_user_rule_data *rule_data,
>>> -		      s32 offset)
>>> +		      u32 ctlword, s32 offset)
>>>   {
>>> -	if (offset) {
>>> -		rule_data->rule = UNWIND_USER_RULE_CFA_OFFSET_DEREF;
>>> -		rule_data->offset = offset;
>>> -	} else {
>>> +	bool deref_p = SFRAME_V3_FLEX_FDE_CTRLWORD_DEREF_P(ctlword);
> i>> +	bool reg_p = SFRAME_V3_FLEX_FDE_CTRLWORD_REG_P(ctlword);
> 
> 	bool reserved_p = SFRAME_V3_FLEX_FDE_CTRLWORD_RESERVED_P(ctlword);
> 	unsigned int regnum = SFRAME_V3_FLEX_FDE_CTRLWORD_REGNUM(ctlword);
> 
>>> +
>>> +	if (!ctlword && !offset) {
>>>   		rule_data->rule = UNWIND_USER_RULE_RETAIN;
>>> +		return;
> 
> 		return 0;
> 
>>> +	}
> 
> 	if (reserved_p)
> 		return -EINVAL;
> 
> @Indu:  Although the SFrame spec does only state "unused Unused bit." I
> think it would be good for the logic to reject any value other than zero
> as that could be used in future extensions of the SFrame format.  Do you
> agree?
> 

For unused bits, it will be ideal to not associate any "observable" 
behaviour on the consumer side, before the bits find their use.  So I 
suggest the recommended way is to ignore the unused bits completely, 
i.e., mask them out and not report any error (if they are set).

On the producer side, unused bits should be set to zero (which I think 
we are doing).

>>> +	if (reg_p) {
>>> +		unsigned int regnum = SFRAME_V3_FLEX_FDE_CTRLWORD_REGNUM(ctlword);
> 
> Drop line above.
> 
>>> +
>>> +		rule_data->rule = UNWIND_USER_RULE_REG_OFFSET;
>>> +		rule_data->regnum = regnum;
>>> +	} else {
> 
> 		if (regnum)
> 			return -EINVAL;
> 
> @Indu:  Is that too strict?  The SFrame spec does only state that regnum
> is "Effective only if reg_p is 1.".  Shall I better ignore any non-zero
> value if reg_p=0?
> 

Yes, ignoring the bits if reg_p = 0 is better behaviour.

Thanks

>>> +		rule_data->rule = UNWIND_USER_RULE_CFA_OFFSET;
>>>   	}
>>> +
>>> +	if (deref_p)
>>> +		rule_data->rule |= UNWIND_USER_RULE_DEREF;
>>> +
>>> +	rule_data->offset = offset;
> 
> 	return 0;
> 
>>>   }
> 
> Likewise checks of reserved_p and regnum in sframe_init_cfa_rule_data().
> 
>>
>> Similarly, if a rule for FP/RA is set to *(CFA + offset) with reg_p=0
>> and deref_p=0, this assigns UNWIND_USER_RULE_CFA_OFFSET without the
>> UNWIND_USER_RULE_DEREF flag.
> 
> Huh?  *(CFA + offset) is reg_p=0 and deref_p=1 and thus with the
> UNWIND_USER_RULE_DEREF flag (i.e. *() denotes dereference).
> 
>>
>> Is this combination handled by the rest of the unwinding logic, or will
>> it fall through to an unsupported state and abort unwinding?
> 
> The unwinding logic only handles UNWIND_USER_RULE_CFA_OFFSET_DEREF for
> RA and FP.  It does not handle UNWIND_USER_RULE_CFA_OFFSET (that is
> without the UNWIND_USER_RULE_DEREF flag).  The reason is that SFrame
> cannot represent the rule CFA + offset for RA/FP.  Additionally it
> would not be valid for RA, as a return address cannot legitimately be
> a stack address.
> 
> sframe_init_rule_data() can be improved to reject the invalid encodings
> reg_p==0 with regnum!=0 as well as reserved_p!=0 (unused control word
> bit 2) as shown above.
> 
>>
>>>   
>>>   static __always_inline int __find_fre(struct sframe_section *sec,
>>> @@ -344,9 +492,10 @@ static __always_inline int __find_fre(struct sframe_section *sec,
>>>   		return -EINVAL;
>>>   	fre = prev_fre;
>>>   
>>> -	sframe_init_cfa_rule_data(&frame->cfa, fre->info, fre->cfa_off);
>>> -	sframe_init_rule_data(&frame->ra, fre->ra_off);
>>> -	sframe_init_rule_data(&frame->fp, fre->fp_off);
>>> +	if (sframe_init_cfa_rule_data(&frame->cfa, fre->cfa_ctl, fre->cfa_off))
>>> +		return -EINVAL;
>>> +	sframe_init_rule_data(&frame->ra, fre->ra_ctl, fre->ra_off);
> 
> 	if (sframe_init_rule_data(&frame->ra, fre->ra_ctl, fre->ra_off))
> 		return -EINVAL;
> 
>>> +	sframe_init_rule_data(&frame->fp, fre->fp_ctl, fre->fp_off);
> 
> Likewise.
> 
>>>   	frame->outermost = SFRAME_V3_FRE_RA_UNDEFINED_P(fre->info);
>>>   
>>>   	return 0;
>>
> 
> Regards,
> Jens

