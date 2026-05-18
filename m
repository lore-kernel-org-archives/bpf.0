Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6753F58CE;
	Mon, 18 May 2026 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118433; cv=none; b=HDuKYWoO2iyydN+befgmHNgNgTL1YOWaFltmTmJ9mEPhIO55/TfeKEjqjMyci/WbouneM1XXGLg8VzD6jDfSt4dFq+gaVIKim0CT2Q0e3s4iD8bYThpPM5gNyhLQv3E804E8aW6/Yk/v5TQVN7I1wkQYkm1JYo5T4bbEggKxhvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118433; c=relaxed/simple;
	bh=oOJSliR96/EG9L1zo/9MC/oHTqhl/n1vL+Zyt0/5DgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8B3L8ceE0inz9ps5eTdJkI3rTsISUvLXM/sPQpWLRBkqyUjPu3CEfkvNtN6PtcTokdTQFTQ8S2kLsUlc/aUKgaXSANjsfd/ti/ECtv39zNoASnCIgEcfRWRFySDjh3PWmwekeQtPCXjxajw4c0oicxKjllsIkmkQSGM72IzETk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QCP5GOdy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QCP5GOdy"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ICxH7L1839474;
	Mon, 18 May 2026 15:33:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0PI8VH
	71/0W9AkHdto2vPt6Pm31raVjs1JFf9JpvqIM=; b=QCP5GOdyV7ETCJ8e1DEQBo
	5HD/qguP4TqFI7tcl9cX+PDeYIFFkwFPwz/u0fG6o8/GlwX5OxiES1Ci1pp4I+wo
	uOWFqKCscL3JK6ZKJl6hrp9a8ha+N/OWv1uJfk/OsREveefBij9D0hxEQO3ByByO
	VfjZM9egdDp0dhEOahEO+m68JI/zPh0j3Qo+ZD+v5fRfZvbV3tAmW1IXh0E+56BM
	W0IZ8vVHcUVTbj8xZx1NZMh1+5kok1l7EncA6pjmMz0P8crbD7POhaOn6ttsfZfh
	kkKnwnAZrpBq/Au/YeIHS48djgIQQelip3skbS0uR79UC1juNnfttkeNjSBmS9ug
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mgt35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 15:33:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64IFO9fk005792;
	Mon, 18 May 2026 15:33:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dheemu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 15:33:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64IFXg4c24248796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 15:33:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5876F2004B;
	Mon, 18 May 2026 15:33:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C339A2004D;
	Mon, 18 May 2026 15:33:41 +0000 (GMT)
Received: from [9.111.207.149] (unknown [9.111.207.149])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 15:33:41 +0000 (GMT)
Message-ID: <3c9ee86e-b3d2-455d-9f4f-170e014dd127@linux.ibm.com>
Date: Mon, 18 May 2026 17:33:45 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 18/19] unwind_user/sframe/x86: Enable sframe unwinding
 on x86
To: Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev,
        Indu Bhagat <ibhagatgnu@gmail.com>,
        Dylan Hatch <dylanbhatch@google.com>
References: <20260505121718.3572346-19-jremus@linux.ibm.com>
 <20260505190728.91695C2BCF4@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260505190728.91695C2BCF4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 6jQR226Sm1sHq7bKEUwNw3mhif9ujTwY
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0b315a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=njC-hnyFwTIKUP6h0CMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: z1qyi6JlES86cR7edGwaWbXNlcXsqeNG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE0OCBTYWx0ZWRfX193DiNl71Czv
 9H2q4qy8aACDu3eNlmsc7n8p+tGV+8InqSz4JqGTEiIyV5u1lskUJocFH49bv/JG5ACGPWlsKgv
 GA504FRAw01VaJL6FBuRtGq94A5lfCCUb8xouIZIMfgtOwyvzvXeTzFW+KOulmM3o0dZ2dD6fqZ
 b6F8zxHqGRxQCww8Bc0LDkMxiUROaPVgSTjGLDPanbDgyEckm6nuDWS5B+YdZ2Sw8XCwroAW1xS
 /74cluqqEmx/clSgWryDfkZ+IhEsIt+1XJGCnDzIe/Fz4Ym+khFP8WZG9JM2yw8wrN+oBJC3jPQ
 1MfqKafPlyPwa9n6Ws0y/SpK3wMjhli4Pb88FaaBUFVC/bPaKi0SJXHOlxapiXceFXeJ5nANT/u
 FqHSwQUklxmIPopGuS3EZ+lIBsEFpMKIZ1kWjpRmjgVH0gHuzg67Vzbmb9JfOD3PcsKQpKMncP1
 gtEUpsl3pOkcNmRlY4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180148

On 5/5/2026 9:07 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] SFrame unwinding uses incorrect DWARF register mappings for 32-bit (compat) user processes on x86_64.
> --
> 
> commit 014ce7a38c83420c1017dd7293ec85cc9b4e45d6
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> unwind_user/sframe/x86: Enable sframe unwinding on x86
> 
> This commit enables SFrame V3 unwinding on x86, which requires binutils 2.46.
> It introduces DWARF register mappings and sets the SFrame register constants.
> 
>> diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
>> index f38f7c5ff1de1..b80f0ec0f7a74 100644
>> --- a/arch/x86/include/asm/unwind_user.h
>> +++ b/arch/x86/include/asm/unwind_user.h
>> @@ -15,6 +15,39 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
>>  	return user_64bit_mode(regs) ? 8 : 4;
>>  }
>>  
>> +static inline int unwind_user_get_reg(unsigned long *val, unsigned int regnum)
>> +{
>> +#ifdef CONFIG_X86_64
>> +	const struct pt_regs *regs = task_pt_regs(current);
>> +

SFrame is currently only supported on x86-64 (no 32-bit compat):

	if (!user_64bit_mode(regs))
		return -EINVAL;

>> +	switch (regnum) {
>> +	/* DWARF register numbers 0..15 */
>> +	case  0: *val = regs->ax; break;
>> +	case  1: *val = regs->dx; break;
>> +	case  2: *val = regs->cx; break;
>> +	case  3: *val = regs->bx; break;
>> +	case  4: *val = regs->si; break;
>> +	case  5: *val = regs->di; break;
>> +	case  6: *val = regs->bp; break;
>> +	case  7: *val = regs->sp; break;
> 
> Does this code handle 32-bit (compat) user processes correctly?
> 
> 32-bit (i386) processes use a different DWARF mapping where ESP is 4 and
> EBP is 5, but this code unconditionally uses the x86_64 DWARF register
> mapping (where register 4 is RSI and 7 is RSP).
> 
> When an i386 application uses an SFrame V3 flexible FDE, the DWARF register
> number is explicitly encoded in the FRE data words. The generic unwinder
> sframe_init_cfa_rule_data() compares the register against the hardcoded
> SFRAME_REG_SP (which is 7 on x86_64).
> 
> Since an i386 SFrame specifies 4 for SP, the check would fail and fall
> back to UNWIND_USER_CFA_RULE_REG_OFFSET with regnum = 4. Then
> unwind_user_next_common() would call unwind_user_get_reg(&cfa, 4), which
> would return regs->si instead of regs->sp.
> 
> Could this break unwinding for 32-bit tasks by using the wrong registers
> (e.g., RSI acting as the stack pointer), leading to corrupted stack traces?
> Would the unwinder need to be explicitly disabled for compat tasks or
> dynamically adjust the DWARF mappings using user_64bit_mode(regs)?
> 

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

