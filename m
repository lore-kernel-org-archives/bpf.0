Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561DC3C585E;
	Fri, 22 May 2026 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444244; cv=none; b=PfHXyR+zUyoWwo6GnazVH0jyGWxOVu1msUhzkb/Jgy/k5XZWa5Z5ZNeSojDK6HYfgnhlGrkNHEeSap5dKOmqT0PtD2h2ARFMMdwbSrIZAG/ZxejBimlvUNQHE13YGJHzCKCG9k7co9F1U+WQi1VFLXXJvJ5y/aFDyV9AHMIgVps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444244; c=relaxed/simple;
	bh=tn3/Gt4u0ELKPAkQwyUBAnAFtB3TMtR09k0nKQrSx1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RFYIHAtxkvfvemaCoVAnElTQwXHlNmiKxrVqCktBPXX2QTicMLCTA9y9mHibn7DyvDrZsKOTlUHgYtJGx7xoVUrRZEUqIOYqYC6vqfkvt0L+i1cwKfKpXkf9zfvRljUTwWDsCXtw1lr2KKMviKPebN8GHVJXLfVktS7zc1ZmUPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ou4DO3vc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ou4DO3vc"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M1Z7mV790111;
	Fri, 22 May 2026 10:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AIh/31
	+k2q201N+hv79/3la3AaA724ogqDUB+mTlvRI=; b=ou4DO3vcM/I576Ht8oye+I
	nqxM2XBlJtTcvXD4KtkynBGC6t1SRkjcuDAVGJu0YGbY4Ymg5U7ggYJG7tvmj1oh
	mNA7BiBvBrclLsX+WUVWPMUliYREAh0A/ga1EJZ6VSJP5UTCfxWqFxBG3rl5EGjI
	pcwvstAL6NEUgRsnocno20wyoBaJuKEybNXPifwCuJIXv/yuiWynMoNKR9urlEbG
	6MpWsXoNAWpDhz0JoE0K03hrdaoratzODXKgHRKcrxxrmvXjc4u1fByVxxz4mPXy
	n94YrzTO1G7kV0CZXJCp5Sz7n27x4ONigHtGNmLEBCB+nYbPafxr1fJLbEpFTqkg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8sw28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 10:04:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64M9sBs9024142;
	Fri, 22 May 2026 10:03:59 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wqgmvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 10:03:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MA3wtK23265868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 10:03:58 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5CFB2004E;
	Fri, 22 May 2026 10:03:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65F8A2004F;
	Fri, 22 May 2026 10:03:57 +0000 (GMT)
Received: from [9.111.153.207] (unknown [9.111.153.207])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 10:03:57 +0000 (GMT)
Message-ID: <a92ef01a-c69b-49e4-a166-5b8a3677c981@linux.ibm.com>
Date: Fri, 22 May 2026 12:03:56 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 10/20] unwind_user/sframe: Remove .sframe section on
 detected corruption
To: sashiko-reviews@lists.linux.dev, Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc: bpf@vger.kernel.org, Indu Bhagat <ibhagatgnu@gmail.com>
References: <20260521142546.3908498-11-jremus@linux.ibm.com>
 <20260521151911.55D4B1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260521151911.55D4B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5NSBTYWx0ZWRfX06u/EP9NO2zZ
 KADNDXNh5bdEECJWjyI0/zzfaRZmIfJRZPJXzpJ8oDPy9S2yLoYG1TZRkisC2eb8S2G5DtlsRPu
 iAs7Hoglt9nlyUTVhHgBarP92nHLAHcSKMuqCy1Obu9E+vQs+uHw3Fe62zR5E44WLkWbUaUX2N8
 y8Y/zjUUeudqm2wN58YLecFcIewQDdsphOPhYgY6mzczVoDOH1IWmiTlWmUf5UWl/f3FK2I4qNE
 AbYlTKAe9fj1zn8LhGOWIR3ixZunKCpwvHrS5IQTWceDwuAIzr4K0mEYg2Ifa9wBoVBa4qLO4nK
 VuVeK2KlwnCiT6GfW+FIol7yIxhYn5RQzJjgyVaewyUnkWFqaqagd3otTqs79o2sFaXFv29bqix
 OOYxVf9hNBOdnoam7dmW4/KU7QWjeuoLZUfqe1x/8zLZ3YeKQUunMuBtLfbcTFNAksXPVjDLiiz
 IySeRzuFhTWlHq908Og==
X-Proofpoint-GUID: akV9I3j1v9bfDOcOh4HtdGx2lcOE1Yot
X-Proofpoint-ORIG-GUID: akV9I3j1v9bfDOcOh4HtdGx2lcOE1Yot
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a102a10 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=dMhCc1OtdfcwexmOYjEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220095

On 5/21/2026 5:19 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Concurrent removal of a corrupted or unmapped .sframe section triggers a user-controllable WARN_ON_ONCE.
> - [High] Valid but paged-out .sframe sections are permanently removed due to transient page faults.
> --
> 
> commit b574618cbc641ef52e2678be129e34a64bc4fb53
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> unwind_user/sframe: Remove .sframe section on detected corruption
> 
> To avoid continued attempted use of a bad .sframe section, this commit removes
> it on demand when the first sign of corruption is detected.
> 
>> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
>> index 41ece3ca62a1f..e0eb2adf5a074 100644
>> --- a/kernel/unwind/sframe.c
>> +++ b/kernel/unwind/sframe.c
> 
> [ ... ]
> 
>> @@ -371,10 +371,15 @@ int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
>>  			ret = __find_fre(sec, &fde, ip, frame);
>>  	}
>>  
>> +end:
>> +	if (ret && ret != -ENOENT)
>> +		WARN_ON_ONCE(sframe_remove_section(sec->sframe_start));
> 
> [Severity: High]
> Can a concurrent unwind cause a user-controllable warning here?
> 
> If two threads concurrently fail to read a corrupted .sframe section, they 
> could both reach this code. The first thread would successfully remove the 
> section, but the second thread would fail to find it in the maple tree, 
> causing sframe_remove_section() to return -EINVAL. 
> 
> This would trigger the WARN_ON_ONCE(), potentially allowing an unprivileged 
> user to crash the system if panic_on_warn is enabled.

This seems valid and therefore I think we should remove the WARN_ON_ONCE().

Any objections?

> 
>>  
>>  	return ret;
>>  
>>  Efault:
>> -	return -EFAULT;
>> +	ret = -EFAULT;
>> +	goto end;
>>  }
> 
> [Severity: High]
> Will this permanently remove perfectly valid .sframe sections if they happen 
> to be paged out?
> 
> User space unwinding often happens in atomic contexts like perf NMIs where 
> demand paging is not permitted. If a valid .sframe section is temporarily 
> swapped out or hasn't been faulted in yet, the memory read operations will 
> cleanly fail and jump here, setting ret to -EFAULT.
> 
> Since -EFAULT is not -ENOENT, the error handling logic jumps to the end label 
> and treats this transient failure as permanent corruption, permanently removing 
> the section from the maple tree. Applications might lose unwinding capabilities 
> simply because their memory was temporarily paged out during a profiler sample.

No.  IIUC the deferred stacktracing explicitly allows for page faults to
be handled.  So any page faults during reading of .sframe section data
from user space should not cause an -EFAULT and thus never erroneous
removal of valid .sframe.

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

