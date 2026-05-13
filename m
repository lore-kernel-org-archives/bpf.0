Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B42D218EB1;
	Wed, 13 May 2026 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680237; cv=none; b=ACKPiAD/RkEWtlx21J3gTOWMRLwAydOn+tp0+Nglz6QGNKefwswP6Zn4qTokJ3IgnALnPf6vykWxEA2OPuoDKwuMFjU6zs7RMOse4RjVNi5tJwl4JMfqVf/WoaZKybiEcsBCM8/h7I6p9k9r85kc5s1dSTi1sr8F91pjfQHBzdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680237; c=relaxed/simple;
	bh=YtpqK6fGGb0nQVlFbcxtygAtqmO0+bhZEuSqxr8PbcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gykffag6xJz5N8Oshwn3KTR9wnF042J8you39PhnCioBofyXd/dyj0iZ+nZX/1rUwIJlcoOCqdWnzv35L0Dxz9z5zqJW4X3Fo6gPm+mReopIqbeap8UrqJyGmCCalZUMJ/XadQpDV6j5J3KiVzhh69PhTAZDxXlWPO6o2p06fLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K3OqrLdg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K3OqrLdg"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D1sn9g2760537;
	Wed, 13 May 2026 13:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DjkPVR
	7thJMjU1xrnWigNpQ30VgrFrYsH0IdApf0BjU=; b=K3OqrLdgSPRWfKQ7UsdcIA
	bwQw36NeE1hPllSbKiTUzSwJRcw15BVZ0xJIKUAFOwl7totPd79a3OKQdOOLsD+p
	vylbQoZHI75Lt8vAmdyP2AK8X9F7x3XFttsOg2iA9GE66K+tJEMTegSONgKuA3Ht
	dSLerQl4gdzLrkPLGWfPEVY+0LOEN3yOnz9iGqYECw+kFMath5QznVWeXT8W0Bi9
	dAVQMVJ1wXgTKzbj5HaulIqec2vqB8HTGKDrXE45u0pkOIYS0+I1pTRNMuzq3W2g
	Dxqu+IEEjOW5Q4ncSG21yN59/JF/NonXlqzggkYOKeeotEPBhhVWfsHk+xdqXyXg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6qmw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 13:50:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64DDdVOo028707;
	Wed, 13 May 2026 13:50:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgqy9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 13:50:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64DDoUgJ31326666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 13:50:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E837D20043;
	Wed, 13 May 2026 13:50:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC05520040;
	Wed, 13 May 2026 13:50:29 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 May 2026 13:50:29 +0000 (GMT)
Message-ID: <af040f1c-7bcf-402b-961c-f5fce2afd60e@linux.ibm.com>
Date: Wed, 13 May 2026 15:50:29 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 16/19] unwind_user/sframe: Add support for SFrame V3
 flexible FDEs
To: Indu Bhagat <ibhagatgnu@gmail.com>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev,
        Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
References: <20260505121718.3572346-17-jremus@linux.ibm.com>
 <20260505185502.CB501C2BCB4@smtp.kernel.org>
 <fc085657-a79c-422d-afd5-4b5f2c55cec2@linux.ibm.com>
 <b76a0b89-3cef-4f72-90b1-7029b989cb63@gmail.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <b76a0b89-3cef-4f72-90b1-7029b989cb63@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: d5AHfYSPYTWGcEw64HOVnJEUWpHsnRe0
X-Proofpoint-GUID: Tu8ielcy3y1ECgK6Ekc6ixP2bBCJfeFi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE0MCBTYWx0ZWRfXwW7o0gA9VdLR
 XSzGkxD0FTuav2wQfP7xnEQyHRH4nAk83OBf+quajEjw+bmU3DIXLqUlLrNgFE77KccOShyvqdP
 pmWKmnLPWXmuAGWfBJ2iH4HejlxtIoh8dayawW58x+oHfc3cEE1vH+tPN46LsOo7+FKXDHWLjf4
 YRwoeK9OJLYEDMhyXF213VOqxVfSwssf0GFh/oRf4b7iL4WFXQ2JdQN/8JQIa1sWpjgnSzQH4bx
 Yibszmlkq841bPmoLBwNdC26hNHuQSHqNaJnEtg3v7v4xmo5sjDVycqv75gAxL2tLUN/rRVVj0Y
 EqCqtgJgV6JknVC1a9Zr4W3TrCkOEn/86cdu1fpTRh2H89yr1yGdqgib+nemN7iJBKlC95mUCHr
 pqZ6bIIcCcBGz5b3tKrv1BAgkVtIivqd8APZxrT7k/hY0E7WtWJXoP1eu8rao1JO8xpnFDebwK5
 XZUg3V9nf49AimeHJtQ==
X-Authority-Analysis: v=2.4 cv=P8UKQCAu c=1 sm=1 tr=0 ts=6a0481a8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=J9XYiVNKlqnHGsx1ktQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130140

On 5/13/2026 8:26 AM, Indu Bhagat wrote:
> On 2026-05-07 08:30, Jens Remus wrote:
>> On 5/5/2026 8:55 PM, sashiko-bot@kernel.org wrote:

>> static __always_inline int
>>
>>>>   sframe_init_rule_data(struct unwind_user_rule_data *rule_data,
>>>> -              s32 offset)
>>>> +              u32 ctlword, s32 offset)
>>>>   {
>>>> -    if (offset) {
>>>> -        rule_data->rule = UNWIND_USER_RULE_CFA_OFFSET_DEREF;
>>>> -        rule_data->offset = offset;
>>>> -    } else {
>>>> +    bool deref_p = SFRAME_V3_FLEX_FDE_CTRLWORD_DEREF_P(ctlword);
>> i>> +    bool reg_p = SFRAME_V3_FLEX_FDE_CTRLWORD_REG_P(ctlword);
>>
>>     bool reserved_p = SFRAME_V3_FLEX_FDE_CTRLWORD_RESERVED_P(ctlword);
>>     unsigned int regnum = SFRAME_V3_FLEX_FDE_CTRLWORD_REGNUM(ctlword);
>>
>>>> +
>>>> +    if (!ctlword && !offset) {
>>>>           rule_data->rule = UNWIND_USER_RULE_RETAIN;
>>>> +        return;
>>
>>         return 0;
>>
>>>> +    }
>>
>>     if (reserved_p)
>>         return -EINVAL;
>>
>> @Indu:  Although the SFrame spec does only state "unused Unused bit." I
>> think it would be good for the logic to reject any value other than zero
>> as that could be used in future extensions of the SFrame format.  Do you
>> agree?
>>
> 
> For unused bits, it will be ideal to not associate any "observable"
> behaviour on the consumer side, before the bits find their use.  So I
> suggest the recommended way is to ignore the unused bits completely,
> i.e., mask them out and not report any error (if they are set).

I disagree.  Masking unused/reserved bits would cause the unwinder to
ignore those even if they get assigned a meaning in the future that it
needs to respect.  It could thus cause the unwinder to erroneously
proceed with wrong results instead of stopping.

> 
> On the producer side, unused bits should be set to zero (which I think
> we are doing).

Makes sense.  I also think that this is how GNU assembler/linker behave.

> 
>>>> +    if (reg_p) {
>>>> +        unsigned int regnum = SFRAME_V3_FLEX_FDE_CTRLWORD_REGNUM(ctlword);
>>
>> Drop line above.
>>
>>>> +
>>>> +        rule_data->rule = UNWIND_USER_RULE_REG_OFFSET;
>>>> +        rule_data->regnum = regnum;
>>>> +    } else {
>>
>>         if (regnum)
>>             return -EINVAL;
>>
>> @Indu:  Is that too strict?  The SFrame spec does only state that regnum
>> is "Effective only if reg_p is 1.".  Shall I better ignore any non-zero
>> value if reg_p=0?
>>
> 
> Yes, ignoring the bits if reg_p = 0 is better behaviour.

I agree.  This is different from the unused/reserved bit, as the spec
clearly states that the value of regnum is only effective if reg_p=1.

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

