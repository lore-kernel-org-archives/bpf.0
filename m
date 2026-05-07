Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F69D27AC4C;
	Thu,  7 May 2026 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167851; cv=none; b=WAzWCa2ip8Zp3hZxBYfgO3vFsLK+Ry9GSVX1eop1n3rbasejcp4xGM+VwURI7lG/FSrSdvxX1gDY8X/nL7UuVDz8G6rZOswzl0LOp20ykeYBw8uYUrX95cAWLcJJbQoLT6974kxvHXD9jIxXux1l7t2tIrb1GJ1Fxj5DYNekGSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167851; c=relaxed/simple;
	bh=yHKJN6yJdHGVHKNBlpWlFw+Imp73/Wo6uj89SeP0Mbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HRsO+Hf2BlZbWLiJwaT3Sa2Rb8ZC32jSl2w0eTEYCBVMCLuoHkdTl/mkfDRNecKG57p1ZD1fMr9mBwqfGejp+saSsPfppR3PMlj9zGW8QqhTT+PlU0Hilf+lbscmF5PetE4/T9Zmtb0DVtvOba7mlqhA1JRrw5jlYNIt4kXH4ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kB9GTmrI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kB9GTmrI"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647F8Laj852737;
	Thu, 7 May 2026 15:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yxZdtq
	a5E3Qhk4LoUGbSZyeq5gtfw6PbQeAwxnaUINI=; b=kB9GTmrINWrwmgrIfa8jX/
	Qe969qTdnKWXW8FNyYA2yf9cjCYklPl/HY9/zhS5SMHQDbdgJFuoQtZMPR5cvVm4
	3Iu1Mg5UoOlByfzHhUY/tigvIndyuAb89wGTMRdv3ppbPOj04RzpNpElBE4TilNW
	qgz1Oo72IVQefmli5/rQQNtF7BT6KJNzrb/3ni46H8h52D+4nmgm9ckhhr+d/fid
	0scebtC0/Da/DJ/vehnhIFN1MWRULdfURRh1JCk5nlHRSfcmKVExTHc1U1zUuwMw
	hKp85Nc9qhqvqUFGl0JiHNl5B7qwsPH8Vkb/4V4EdLMU7WEiiKlvCzAExTyqIpQw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4xc81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 15:30:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647FOmR4001747;
	Thu, 7 May 2026 15:30:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuywcaqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 15:30:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 647FUgTC57409912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 15:30:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D69BD2004B;
	Thu,  7 May 2026 15:30:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A71C920043;
	Thu,  7 May 2026 15:30:42 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 May 2026 15:30:42 +0000 (GMT)
Message-ID: <fc085657-a79c-422d-afd5-4b5f2c55cec2@linux.ibm.com>
Date: Thu, 7 May 2026 17:30:41 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 16/19] unwind_user/sframe: Add support for SFrame V3
 flexible FDEs
To: Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>,
        Indu Bhagat <ibhagatgnu@gmail.com>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev
References: <20260505121718.3572346-17-jremus@linux.ibm.com>
 <20260505185502.CB501C2BCB4@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260505185502.CB501C2BCB4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1MSBTYWx0ZWRfXxOqe9++/ys5A
 O3SM97Jg7Pcc4RW6PPoR/OdxmEOpQKBzl/eO+8+c0z09QShvzTYC5B+NV4IaltIlbeQDLayuoND
 5jG76zB9bsOH00h1ftDdn4U7mmKHwWw+HX2Cr5Do4O9I3Byzt+iuBk2eeCTwu6NEDdCnZYpiFaG
 cbY+23MpzdvipXyThNy21tW+pf06IqS0LiXgnwrZAjF45OyMoaY/J8f8SUruBeg/xmQ8v7uoWtV
 1WwTIAgVXKjRwn1GYeP6LVPyr2m+kctURT9rUX45KQoh6kcSxgjsNtD7lhEE+TFLTTL9pIdhrr7
 ElcttdmNrq7flfU9Y2Uanzii7wh0F+Et7Qdo4ef6lPxnbh/KECSn0zuLvVifBODOpYVq9uNlENA
 B9knlx+Z3Ay65yUo6ZH4dHBS2mePlSjkR9/PcUWJk42+GOx7flKoZkc0iOD6UwH+MA8+ZXjWCFb
 ZUzhpwppqGH0jnxDQug==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fcb025 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=G2suM2WWGva1UPP46dgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: o5Tvlg3vZpiz1_4SMB-JiHSJTVTP5mjS
X-Proofpoint-ORIG-GUID: h1VPV_IckFIV_e0x1hVl9ntINtadvihE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070151

On 5/5/2026 8:55 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Valid flexible FREs ending in a single padding data word are incorrectly rejected.

Those are invalid as per SFrame spec.

> - [High] Valid flexible FRE rules for CFA and FP/RA produce unhandled enums, triggering user-controlled WARN_ON_ONCE().

Fix below.

> - [High] Outermost frame unwinding is unconditionally broken, causing unintended fallback to frame pointers.

Fix below.

> --
> 
> commit 7d3289b2e756d08c38877458400ce276ff3f5994
> Author: Jens Remus <jremus@linux.ibm.com>
> 
> unwind_user/sframe: Add support for SFrame V3 flexible FDEs
> 
> SFrame V3 introduces flexible FDEs in addition to the regular FDEs.
> The key difference is that flexible FDEs encode the CFA, RA, and FP
> tracking information using two FRE data words, a control word and an
> offset, or a single padding data word of zero.
> 
>> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
>> index 2721f4af53fd3..2ba2c8b385f96 100644
>> --- a/kernel/unwind/sframe.c
>> +++ b/kernel/unwind/sframe.c
> [ ... ]
>> @@ -189,16 +193,147 @@ static __always_inline int __find_fde(struct sframe_section *sec,
> [ ... ]
>> +static __always_inline int
>> +__read_flex_fde_fre_datawords(struct sframe_section *sec,
>> +			      struct sframe_fde_internal *fde,
>> +			      unsigned long cur,
>> +			      unsigned char dataword_count,
>> +			      unsigned char dataword_size,
>> +			      struct sframe_fre_internal *fre)
>> +{
>> +	u32 cfa_ctl, ra_ctl, fp_ctl;
>> +	s32 cfa_off, ra_off, fp_off;
>> +
>> +	if (dataword_count < 2)
>> +		return -EFAULT;
>> +	UNSAFE_GET_USER_INC(cfa_ctl, cur, dataword_size, Efault);
>> +	UNSAFE_GET_USER_INC(cfa_off, cur, dataword_size, Efault);
>> +	dataword_count -= 2;
>> +

	/*
	 * Each RA/FP location info consumes either two datawords
	 * (control word + offset) or one padding word substituting
	 * for that pair.  Padding is only valid as substitution if
	 * followed by further non-padding location info.  Therefore
	 * decoding only proceeds with at least two datawords.  Any
	 * leftover trailing datawords are invalid and rejected by
	 * the final check.
	 */

>> +	ra_off = sec->ra_off;
>> +	ra_ctl = ra_off ? 2 : 0; /* regnum=0, deref_p=(ra_off != 0), reg_p=0 */
>> +	if (dataword_count >= 2) {
> 
> The commit message mentions that flexible FDEs can use a single padding
> data word of zero. However, this code checks dataword_count >= 2 for both
> the RA and FP blocks.

That is ok, as a padding dataword for RA is only valid if followed by
two datawords (control and offset) for FP.  In case of a valid padding
dataword for RA only one dataword is consumed.  In case of an invalid
trailing padding dataword for RA it is not consumed.  The same logic is
then used for FP, as that ensures that a leftover trailing padding for
for both RA or FP is not consumed (and then rejected by the final check)
and that any future extension e.g. to convey SP location info can use
the same logic.  This helps reducing the number of checks at the cost
of a slow error path.  Otherwise the checks would be:

	/* RA */
	if (!dataword_count)
		goto done;
	if (dataword_count == 1)
		return -EFAULT; /* Trailing RA padding */
	... consume RA dataword(s) ...

	/* FP */
	if (!dataword_count)
		goto done;
	if (dataword_count == 1)
		return -EFAULT; /* Trailing FP padding */
	... consume FP dataword(s) ...

	if (dataword_count)
		return -EFAULT; /* Trailing extra dataword(s) */

done:
	fre->cfa_ctl	= cfa_ctl;
	...

> 
> If an FRE ends with a single padding data word, it will bypass both of these
> blocks and reach the check below:
> 
>> +		UNSAFE_GET_USER_INC(ra_ctl, cur, dataword_size, Efault);
>> +		dataword_count--;
>> +		if (ra_ctl) {
>> +			UNSAFE_GET_USER_INC(ra_off, cur, dataword_size, Efault);
>> +			dataword_count--;
>> +		} else {
>> +			/* Padding RA location info */
>> +			ra_ctl = ra_off ? 2 : 0; /* re-deduce (see above) */
>> +		}
>> +	}
>> +
>> +	fp_off = sec->fp_off;
>> +	fp_ctl = fp_off ? 2 : 0; /* regnum=0, deref_p=(fp_off != 0), reg_p=0 */
>> +	if (dataword_count >= 2) {
>> +		UNSAFE_GET_USER_INC(fp_ctl, cur, dataword_size, Efault);
>> +		dataword_count--;
>> +		if (fp_ctl) {
>> +			UNSAFE_GET_USER_INC(fp_off, cur, dataword_size, Efault);
>> +			dataword_count--;
>> +		} else {
>> +			/* Padding FP location info */
>> +			fp_ctl = fp_off ? 2 : 0; /* re-deduce (see above) */
>> +		}
>> +	}
>> +
	/* Reject trailing padding or unknown extra datawords */

>> +	if (dataword_count)
>> +		return -EFAULT;
> 
> Could this incorrectly reject valid FREs ending in a single padding data word
> since dataword_count would be 1 here?
> 
>> +
>> +	fre->cfa_ctl	= cfa_ctl;
>> +	fre->cfa_off	= cfa_off;
>> +	fre->ra_ctl	= ra_ctl;
>> +	fre->ra_off	= ra_off;
>> +	fre->fp_ctl	= fp_ctl;
>> +	fre->fp_off	= fp_off;
>> +
>> +	return 0;
>> +
>> +Efault:
>> +	return -EFAULT;
>> +}
> [ ... ]
>>  static __always_inline int __read_fre(struct sframe_section *sec,
>>  				      struct sframe_fde_internal *fde,
>>  				      unsigned long fre_addr,
>>  				      struct sframe_fre_internal *fre)
>>  {
> [ ... ]
>>  	if (!dataword_count) {
>>  		/*
>>  		 * A FRE without data words indicates RA undefined /
>>  		 * outermost frame.
>>  		 */
>> -		cfa_off	= 0;
>> -		ra_off	= 0;
>> -		fp_off	= 0;
>> -		goto done;
>> -	}
>> +		fre->cfa_ctl	= 0;

	/*
	 * A FRE without datawords indicates an outermost
	 * frame.  Zero-initialize CFA, RA, and FP location
	 * info, except for the CFA control word, which
	 * must not cause sframe_init_cfa_rule_data() to fail.
	 */
	fre->cfa_ctl    = (SFRAME_REG_SP << 3) | 1; /* regnum=SP, deref_p=0, reg_p=1 */

>> +		fre->cfa_off	= 0;
>> +		fre->ra_ctl	= 0;
>> +		fre->ra_off	= 0;
>> +		fre->fp_ctl	= 0;
>> +		fre->fp_off	= 0;
>>  
>> -	UNSAFE_GET_USER_INC(cfa_off, cur, dataword_size, Efault);
> 
> When __read_fre() processes an outermost frame, it zeroes out fre->cfa_ctl.
> In __find_fre(), this is later passed to sframe_init_cfa_rule_data():
> 
>> -static __always_inline void
>> +static __always_inline int
>>  sframe_init_cfa_rule_data(struct unwind_user_cfa_rule_data *cfa_rule_data,
>> -			  unsigned char fre_info,
>> -			  s32 offset)
>> +			  u32 ctlword, s32 offset)
>>  {
>> -	if (SFRAME_V3_FRE_CFA_BASE_REG_ID(fre_info) == SFRAME_BASE_REG_FP)
>> -		cfa_rule_data->rule = UNWIND_USER_CFA_RULE_FP_OFFSET;
>> -	else
>> -		cfa_rule_data->rule = UNWIND_USER_CFA_RULE_SP_OFFSET;
>> +	bool deref_p = SFRAME_V3_FLEX_FDE_CTRLWORD_DEREF_P(ctlword);
>> +	bool reg_p = SFRAME_V3_FLEX_FDE_CTRLWORD_REG_P(ctlword);
>> +
>> +	if (reg_p) {
>> +		unsigned int regnum = SFRAME_V3_FLEX_FDE_CTRLWORD_REGNUM(ctlword);
>> +
>> +		switch (regnum) {
>> +		case SFRAME_REG_SP:
>> +			cfa_rule_data->rule = UNWIND_USER_CFA_RULE_SP_OFFSET;
>> +			break;
>> +		case SFRAME_REG_FP:
>> +			cfa_rule_data->rule = UNWIND_USER_CFA_RULE_FP_OFFSET;
>> +			break;
>> +		default:
>> +			cfa_rule_data->rule = UNWIND_USER_CFA_RULE_REG_OFFSET;
>> +			cfa_rule_data->regnum = regnum;
>> +		}
>> +	} else {
>> +		return -EINVAL;
>> +	}
> 
> Because ctlword is 0 for an outermost frame, reg_p will evaluate to false,
> and this unconditionally returns -EINVAL.
> 
> Does this unintentionally break outermost frame unwinding? Returning an
> error here will cause __find_fre() to fail before it can reach the
> frame->outermost check, resulting in a fallback to frame pointer unwinding
> instead of stopping gracefully.

Good catch!  That was broken.  I did not notice during my testing on
s390, as the fallback to FP-based (back chain on s390) unwinding then
also detected an outermost frame.  Suggested fix see above.

> 
>> +
>> +	if (deref_p)
>> +		cfa_rule_data->rule |= UNWIND_USER_RULE_DEREF;
>> +
> 
> Also, does this append UNWIND_USER_RULE_DEREF to CFA rules in a way that is
> not supported by the unwinder?
> 
> If a CFA rule uses SP/FP with deref_p=1, this creates a combined enum like
> UNWIND_USER_CFA_RULE_SP_OFFSET | UNWIND_USER_RULE_DEREF. Because .sframe
> sections are user-supplied, could an attacker use this to trigger an
> unhandled enum path and hit a WARN_ON_ONCE() during unwinding?

Good catch!  The generic unwinding logic in unwind_user_next_common()
actually needs to support both UNWIND_USER_CFA_RULE_SP_OFFSET_DEREF and
UNWIND_USER_CFA_RULE_FP_OFFSET_DEREF, as those are valid to be encoded
in SFrame flexible FDE and sframe_init_cfa_rule_data() converts
deref_p=1, reg_p=1, regnum=SP/FP into those.  The reason for the
conversion is that arbitrary registers are only available in the topmost
frame, whereas SP and FP are available in any frame.

> 
>>  	cfa_rule_data->offset = offset;
>> +
>> +	return 0;
>>  }
>>  
>>  static __always_inline void

static __always_inline int

>>  sframe_init_rule_data(struct unwind_user_rule_data *rule_data,
>> -		      s32 offset)
>> +		      u32 ctlword, s32 offset)
>>  {
>> -	if (offset) {
>> -		rule_data->rule = UNWIND_USER_RULE_CFA_OFFSET_DEREF;
>> -		rule_data->offset = offset;
>> -	} else {
>> +	bool deref_p = SFRAME_V3_FLEX_FDE_CTRLWORD_DEREF_P(ctlword);
i>> +	bool reg_p = SFRAME_V3_FLEX_FDE_CTRLWORD_REG_P(ctlword);

	bool reserved_p = SFRAME_V3_FLEX_FDE_CTRLWORD_RESERVED_P(ctlword);
	unsigned int regnum = SFRAME_V3_FLEX_FDE_CTRLWORD_REGNUM(ctlword);

>> +
>> +	if (!ctlword && !offset) {
>>  		rule_data->rule = UNWIND_USER_RULE_RETAIN;
>> +		return;

		return 0;

>> +	}

	if (reserved_p)
		return -EINVAL;

@Indu:  Although the SFrame spec does only state "unused Unused bit." I
think it would be good for the logic to reject any value other than zero
as that could be used in future extensions of the SFrame format.  Do you
agree?

>> +	if (reg_p) {
>> +		unsigned int regnum = SFRAME_V3_FLEX_FDE_CTRLWORD_REGNUM(ctlword);

Drop line above.

>> +
>> +		rule_data->rule = UNWIND_USER_RULE_REG_OFFSET;
>> +		rule_data->regnum = regnum;
>> +	} else {

		if (regnum)
			return -EINVAL;

@Indu:  Is that too strict?  The SFrame spec does only state that regnum
is "Effective only if reg_p is 1.".  Shall I better ignore any non-zero
value if reg_p=0?

>> +		rule_data->rule = UNWIND_USER_RULE_CFA_OFFSET;
>>  	}
>> +
>> +	if (deref_p)
>> +		rule_data->rule |= UNWIND_USER_RULE_DEREF;
>> +
>> +	rule_data->offset = offset;

	return 0;

>>  }

Likewise checks of reserved_p and regnum in sframe_init_cfa_rule_data().

> 
> Similarly, if a rule for FP/RA is set to *(CFA + offset) with reg_p=0
> and deref_p=0, this assigns UNWIND_USER_RULE_CFA_OFFSET without the
> UNWIND_USER_RULE_DEREF flag.

Huh?  *(CFA + offset) is reg_p=0 and deref_p=1 and thus with the
UNWIND_USER_RULE_DEREF flag (i.e. *() denotes dereference).

> 
> Is this combination handled by the rest of the unwinding logic, or will
> it fall through to an unsupported state and abort unwinding?

The unwinding logic only handles UNWIND_USER_RULE_CFA_OFFSET_DEREF for
RA and FP.  It does not handle UNWIND_USER_RULE_CFA_OFFSET (that is
without the UNWIND_USER_RULE_DEREF flag).  The reason is that SFrame
cannot represent the rule CFA + offset for RA/FP.  Additionally it
would not be valid for RA, as a return address cannot legitimately be
a stack address.

sframe_init_rule_data() can be improved to reject the invalid encodings
reg_p==0 with regnum!=0 as well as reserved_p!=0 (unused control word
bit 2) as shown above.

> 
>>  
>>  static __always_inline int __find_fre(struct sframe_section *sec,
>> @@ -344,9 +492,10 @@ static __always_inline int __find_fre(struct sframe_section *sec,
>>  		return -EINVAL;
>>  	fre = prev_fre;
>>  
>> -	sframe_init_cfa_rule_data(&frame->cfa, fre->info, fre->cfa_off);
>> -	sframe_init_rule_data(&frame->ra, fre->ra_off);
>> -	sframe_init_rule_data(&frame->fp, fre->fp_off);
>> +	if (sframe_init_cfa_rule_data(&frame->cfa, fre->cfa_ctl, fre->cfa_off))
>> +		return -EINVAL;
>> +	sframe_init_rule_data(&frame->ra, fre->ra_ctl, fre->ra_off);

	if (sframe_init_rule_data(&frame->ra, fre->ra_ctl, fre->ra_off))
		return -EINVAL;

>> +	sframe_init_rule_data(&frame->fp, fre->fp_ctl, fre->fp_off);

Likewise.

>>  	frame->outermost = SFRAME_V3_FRE_RA_UNDEFINED_P(fre->info);
>>  
>>  	return 0;
> 

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

