Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28833D171A;
	Thu, 21 May 2026 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368444; cv=none; b=oEqagJt3vrM79da8k0ZjyuqzFKeS7TA7rBm1XrxLaHkx71Db/gaTuF8Su+DhSdQC9l6EmSrv44HUFZKQwbmBGMKuqeYDoN00dderrW+x38g5oSmDffephjaBwjfB1WCX0NXbdrtivJBW7PYx86OmEjZarAz3CjBeHamWSxP7+MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368444; c=relaxed/simple;
	bh=hLmRYRjMzNYwZpZm8Eji9CI2WEsX9TkYa0xTZw69CWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OmHiGmHDvN01L1wjIX9qhGTVaxFt297LDreT4Wf5U96gPefm+irGbXYxzwnNVyg10wFVR7gIx3gv5jdqOsxTFAuF7CNV+3b3D7Ymhrc64DjiBdOsPIKAfS1ktWWI40xB7/UY8hnfJW7c3gmn8eL20Jn5KKTEddapTPCxJdbhQpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hKiHlhNh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hKiHlhNh"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KNvYmM4011095;
	Thu, 21 May 2026 13:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tQJkHi
	y4tJYQZGzFrip9dcbyjSdItKfOvD7/G6dhVw0=; b=hKiHlhNh9RgV0EbWVoKkkf
	MVRF/Qf50Gtif52UzsWiWxU8Uhc8jiY4yP56vYszF4uEYsUrevsbawgCeZ+X6Dk/
	VWNq2NYmwzZIzkvugF10tOU4Vr/HG5pxh92psQv8N/vWeosecRMVs1rCCskvarnh
	dfOIvcFIw13SN8vPl9pIQ/0P9mB5VkEdRUIFcWtrjvTnY86sF/MOd9Kgb4xSC1H+
	7j1TZwvjZ6OU2QAKSih+nZWesJEJaO3Su+dp792fh7QXs+MjRTNyIYi5arXz8Iig
	w38f/MbGP4z2nKjBfxhDREbdstEPHoP+DFCaDzEccdbkVWuAgY0fyC3TMbbxpKUA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8nqj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 13:00:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LCs8vq023887;
	Thu, 21 May 2026 13:00:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754gkx5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 13:00:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LD0afl57082174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 13:00:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 815752004E;
	Thu, 21 May 2026 13:00:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6360D2004B;
	Thu, 21 May 2026 13:00:36 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 13:00:36 +0000 (GMT)
Message-ID: <bb451942-92b0-4464-aec1-034cd0380f47@linux.ibm.com>
Date: Thu, 21 May 2026 15:00:35 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 13/20] unwind_user: Enable archs that pass RA in a
 register
To: sashiko-reviews@lists.linux.dev, Steven Rostedt <rostedt@kernel.org>
Cc: bpf@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
        Indu Bhagat <ibhagatgnu@gmail.com>
References: <20260520154004.3845823-14-jremus@linux.ibm.com>
 <20260520162147.195FA1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260520162147.195FA1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEyNiBTYWx0ZWRfX+Z50Tk6KXhid
 HyAYMKAKdSgN3+bmYgtfDdotJvlWm9GycSsIsS/1ruix5EJFrlUMCb2cCMyhZtlrdkhJETLQogu
 rMwNmI8AfRT6aLggklDFqkzW0bGXU+aDY5wwVAAQrhb+WUR+l0xDGG4FINIdxu3ii3FwWTxWK6S
 3Ytm1mtULIWbMKeoUX3rYzQrJdKxzntS2e5jzKgtTIj449cG2sBvkZumAu+vH0/ih5vaFDINBYZ
 qLIGFru0B9IPJrBOVrb7DXTM411wnDddpnbUAwGequ/GPeddVlaXidwo1BX6JY4FakIK4PsGFbz
 9Co6Vaibb68oKS2HmdQj4vIaQZa0AcgnzntPMRjgoiV1GRquIkz80AHuiVNXm1uvRcG7Alt2RNv
 F4ptD8fcChZfn7AQbtjny0FdaUmGTwoJXEmIPoikpZgpooiPU+Fo0HDnzyObqFb06lZ1FqF/He2
 h/TqhrCWKRbKZcZHkuw==
X-Proofpoint-GUID: hMMia4oGE_QG2jRiFaUhU9D50HY7mnHR
X-Proofpoint-ORIG-GUID: -vjtYLt4mXJbdkPKvOpayTXpdNaBIBzC
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0f01f7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=WE8OqiDhfSTjO677DY0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210126

On 5/20/2026 6:21 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Low] The header file `<linux/unwind_user.h>` uses `pr_debug_once` and `current` without including the necessary headers.
> 
> Pre-existing issues:
> - [High] The SFrame FRE size calculation computes an incorrect length because `dataword_count` is consumed before it is used in the size formula.

Fixed in next version of "[PATCH v15 05/20] unwind_user/sframe: Add
support for reading .sframe contents".

> --
> 
> commit 842bbe46528fb50996a02de1f8b7f5df1d8b1026
> Author: Jens Remus <jremus@linux.ibm.com>
> 
> unwind_user: Enable archs that pass RA in a register
> 
> This commit updates the user-space unwinder to support architectures that do
> not mandate saving the return address (RA) on the stack, such as s390 and
> arm64. It treats an RA offset of zero as an indication that the RA is in the
> link register for the topmost frame, and allows the stack pointer to remain
> unchanged in the topmost frame.
> 
>> diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
>> index 64618618febde..7bf58f23aa64a 100644
>> --- a/include/linux/unwind_user.h
>> +++ b/include/linux/unwind_user.h
>> @@ -23,6 +23,16 @@ static inline bool unwind_user_at_function_start(struct pt_regs *regs)
>>  #define unwind_user_at_function_start unwind_user_at_function_start
>>  #endif
>>  
>> +#ifndef unwind_user_get_ra_reg
>> +static inline int unwind_user_get_ra_reg(unsigned long *val)
>> +{
>> +	pr_debug_once("%s (%d): unwind_user_get_ra_reg() not implemented\n",
>> +		      current->comm, current->pid);
> 
> [Severity: Low]
> Does this require including <linux/printk.h> and <linux/sched.h> or
> <asm/current.h>?
> 
> Using pr_debug_once and current without these headers might cause compilation
> failures for files that include <linux/unwind_user.h> without prior inclusion
> of these dependencies.

Can this be ignored, given kernel/unwind/sframe_debug.h does include
neither of these?

> 
>> +	return -EINVAL;
>> +}
>> +#define unwind_user_get_ra_reg unwind_user_get_ra_reg
>> +#endif
> 
> [ ... ]


Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

