Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF39626E165;
	Mon, 18 May 2026 15:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116897; cv=none; b=OVMhgzy6O4+VZRtsv4dXp3qPixhz0QKR7WOLyzFGCpO16ydnhVsv9odAROUT0neoxSkZM7Sp++vFPjGDB5xSinZR2Z0PiPjIfQ9DVo2J11wimZqGw9OWDvk4hi3iNNxqJZntqeu6GJVqWjNOuUpQnVtvhAnb5hmxXXKrkV8hIrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116897; c=relaxed/simple;
	bh=NHmZVJ9vXBSEMhNUahDmsUQX4I8EfCiwcL4BrnEWSsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B37kRb7To6oo57R1ooq0RIFRbc1QdqIQCKe7ax/FO5G9qKeEDe6z+pSdJMzIDbjndGdvvkAeFR66JyEA9FLHluNOFm1Ge0HuePB8IXegUz+oybojKefGD6J5uuwGHAQZYMQSIkZl/l7yupQ1JtmBU8n/de9lxykbg8r64YfZHos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qsO5w20C; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qsO5w20C"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IA1T9n1876843;
	Mon, 18 May 2026 15:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AuGgYH
	yYxu1vVelMv39JleUQRAxEydXxN5CXOhnn+h4=; b=qsO5w20C/kUSV9rHiuLmMr
	CQfUk7nmk/bcz7TJ6IY6mUX7OSB4bi2PqyWGAWkyJmkaVvCndu78AZuy/YQIm6ZG
	iZoEyaTFwEU+NLckyBHV7A/xmnGLgs94mAEvXkxFETUt1Tma3eQYgWsYEneBWTIs
	rnPdyW5U3yYxbLG7ecLUtcvCKues0EghKuOJwnj8Ibhm68YZV+HPsdwY/D7ra5SB
	ix10vFbqinbkIUdWmxH3gIaOgh4atE0qBJb+CXkwDhX74yjfq0Ych5ApL7/cDWAq
	tQ6OuyUWqVZxtik3IPNzc5DsjvyyqRquwRevHBrwQmk4fBCWRPk/QO++gNH9lgKQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8886y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 15:08:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64IEs6tK004713;
	Mon, 18 May 2026 15:08:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wpxmnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 15:08:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64IF89Wl31588856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 15:08:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9146420043;
	Mon, 18 May 2026 15:08:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F20D420040;
	Mon, 18 May 2026 15:08:08 +0000 (GMT)
Received: from [9.111.207.149] (unknown [9.111.207.149])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 15:08:08 +0000 (GMT)
Message-ID: <3655cea2-03e6-4cc0-ae26-da5ba3521495@linux.ibm.com>
Date: Mon, 18 May 2026 17:08:12 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 14/19] unwind_user: Flexible FP/RA recovery rules
To: Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>,
        Dylan Hatch <dylanbhatch@google.com>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev,
        Indu Bhagat <ibhagatgnu@gmail.com>
References: <20260505121718.3572346-15-jremus@linux.ibm.com>
 <20260505183446.074E3C2BCB4@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260505183446.074E3C2BCB4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: UGZPixkokcR5TEKQzxKqPAwZdLnnGk4L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE0OCBTYWx0ZWRfX79VmfemCd7Kl
 yZg9ai1MRPtvi+dnefQcrdyJOI4CWCRWRlUi6SPcDfLG8IZwlvEqenmyc/I5vOgeAjgCnf1YpPn
 p18qsQaoKRSICxQSMOHIQ2QtCQNBRVIT15cHrgMi+J6ZiJyGe/g92t1VkqZRgyjGSXTolmHNeu6
 9wfuoWSwTVsqwEA8qemhik6Uvo1PUZfgG9l+UQojJVrq7wYrTKJYqwXmhEivgZDqluD8OYsegH1
 lcQdFVQcuDCdPOsHdAfx8cxKqk+yZxopfnptRH7msNcvY5lxO7RROVKQYzoUtsBkdUAbfxlXB2U
 c3CEf6I2tCxNVnH0seLkiQqlViDD8Iu3vOcQcdrE1eb+drhkB89Ia8W6c7sw7n05Nv2L+SLEfqm
 L/UU+zd2HHWMoSM9082oV0xPxGlc9JyYFQVADYtVD6CXa/INYQqYyvFHkoHlBs7S3pOluDzNeP/
 DYexzK5qU6aghryhTpA==
X-Proofpoint-GUID: 9BYE7sccHLCJcOU1WlcNfhw27gXudqfV
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0b2b5c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=i6mWMxdQ5USbOHvKD3YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180148

On 5/5/2026 8:34 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Unprivileged users can trigger a kernel warning (and panic if panic_on_warn is set) by providing crafted SFrame data that forces the use of unimplemented register recovery rules.
> --
> 
> commit 32f67c3538981cd61e598218f28891cb4051e567
> Author: Jens Remus <jremus@linux.ibm.com>
> 
> unwind_user: Flexible FP/RA recovery rules
> 
> This commit adds support for flexible frame pointer and return address 
> recovery rules to the user unwinder. It introduces rules to retain values
> or read them from registers.
> 
>> diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
>> index bc2edae399556..92cdf38c8aded 100644
>> --- a/include/linux/unwind_user.h
>> +++ b/include/linux/unwind_user.h
>> @@ -32,6 +32,15 @@ static inline int unwind_user_get_ra_reg(unsigned long *val)
>>  #define unwind_user_get_ra_reg unwind_user_get_ra_reg
>>  #endif
>>  
>> +#ifndef unwind_user_get_reg
>> +static inline int unwind_user_get_reg(unsigned long *val, unsigned int regnum)
>> +{
>> +	WARN_ON_ONCE(1);
>> +	return -EINVAL;

Replace with the following to resolve below issue:

	dbg_once("unwind_user_get_reg(%u) not implemented\n", regnum);

>> +}
>> +#define unwind_user_get_reg unwind_user_get_reg
>> +#endif
> 
> Could an unprivileged user trigger these WARN_ON_ONCE macros by providing
> crafted SFrame data during profiling?

Valid.  On architectures that do not support SFrame V3 flexible FDEs and
therefore do not implement unwind_user_get_ra_reg(), such as arm64,
above WARN_ON_ONCE(1) can be triggered using forged .sframe that
maliciously has SFrame flexible FDE/FRE that encode the FP/RA recovery
rule as register + offset or *(register + offset), with register != SP/FP.

> 
> If an architecture does not implement unwind_user_get_reg or
> unwind_user_get_ra_reg, falling back to these stubs will execute a kernel
> warning. On systems with panic_on_warn enabled, this could lead to a
> kernel panic.
> 
> [ ... ]
> 
>> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
>> index 9ceef9b2b8db0..89aecfbe3e849 100644
>> --- a/kernel/unwind/user.c
>> +++ b/kernel/unwind/user.c
>> @@ -61,22 +61,61 @@ static int unwind_user_next_common(struct unwind_user_state *state,
> [ ... ]
>> +	switch (frame->ra.rule) {
>> +	case UNWIND_USER_RULE_RETAIN:
>>  		if (!state->topmost || unwind_user_get_ra_reg(&ra))
>>  			return -EINVAL;
>> +		break;
> [ ... ]
>> +	default:
>> +		WARN_ON_ONCE(1);
>> +		return -EINVAL;
>>  	}
> 
> A similar issue seems to exist in the default case here, as well as the
> default case for frame->fp.rule below it.

Resolve by explicitly handling all defined enum values.  Keep the
WARN_ON_ONCE(1) to detect errors if extending the related enums.

> 
> Since sframe_init_rule_data() sets the rule based on untrusted user memory
> (for example, setting UNWIND_USER_RULE_RETAIN when ra_off is 0), can a
> crafted binary intentionally hit these paths?
> 
> Would it be safer to silently fail and return -EINVAL when an unsupported
> or unimplemented rule is encountered, rather than warning?
> 

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

