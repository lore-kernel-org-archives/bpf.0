Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7A939FCCC;
	Thu,  7 May 2026 14:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778163273; cv=none; b=KNq5Voe8Vr8S1Zb26N9OBY5iQo+Vj3eTOvCPu1ObuzwwD1YdSk1vG984nBdsh6SAz2SIJkqUTQK6UWQS33v8OEYGG94dpo9VlKbD1EvGvRBSeR+SXb5vYPqDuey8vfB8zUDayUfLHjpuhNF2jKu6PVzXgchEpOJCS/7nHm+FzyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778163273; c=relaxed/simple;
	bh=oyso3nExNrG4BywlWTOYcyfA7BLXnZvv6aLfX2RV21g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QPfKOujhUGP+k2F9uij5xeNGn0Q8QQQcB1Gq14Qu+q7yZ40JCGAcodiF8x7YZjRUQAVD/9SR0GNcVKfLqvZY16lCrpsM04swajKmTv8+GkqbCogN7YP7betBVa1J4GRGs6l6Q5GhjrQyVWg5I3zZ6k+l3D3fau4zq+uU+debo0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y4gOc3Mx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y4gOc3Mx"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6475dgmY989845;
	Thu, 7 May 2026 14:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jtZgxZ
	SPXnz+TforHqnmNEhazlwAO2Wl0iHCtSJM0nU=; b=Y4gOc3MxVgbUQ5IdNcg9Ij
	uDe34sb9OMhv0sv/APflAVozPFp/NDlMbT3yNiyyA8PoMuAjaybocxgdI5a1OzWO
	rP1WsWHJ8Uh0dnEKNeJaRtw4suCjg7+yxwMuR9J6NykwCyGq6b68ar4MIINbg0fu
	9nKE+bF09CRkHeEEeo0ERrMiHoTztxEwX+71atg9fxjAcsy3Djk0rLQlVlEyho3x
	g8MV6goYAvp+3KJz1O+8nZh0QSQN4pICHxmqrgkO7nN46N2Q2U7608WMV7Y244GR
	dedCxP45hvcVsvwFlg/B0JEoJwKTOllyNNrDODXbYAAcIvl1/F4qPVnjr4PK7gWA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6p099-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 14:14:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647E9RHS021713;
	Thu, 7 May 2026 14:14:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkk3y1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 14:14:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 647EEPB321496358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 14:14:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 369E020043;
	Thu,  7 May 2026 14:14:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1297820040;
	Thu,  7 May 2026 14:14:25 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 May 2026 14:14:25 +0000 (GMT)
Message-ID: <a59bec51-007a-436f-905f-dfdd54f5bceb@linux.ibm.com>
Date: Thu, 7 May 2026 16:14:24 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 19/19] unwind_user/sframe: Add prctl() interface for
 registering .sframe sections
To: Steven Rostedt <rostedt@kernel.org>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Indu Bhagat <ibhagatgnu@gmail.com>
References: <20260505121718.3572346-20-jremus@linux.ibm.com>
 <20260505184556.B94A0C2BCB4@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260505184556.B94A0C2BCB4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69fc9e44 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=LBgWG6ceKceDMaZCywwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: VdNAbrooQrd6lHdZPp91T2Nlqj3LFnpD
X-Proofpoint-GUID: ZWcFR8ylTy7n-FHybeIGLNofyJIW4xbx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE0MSBTYWx0ZWRfXxRejzSSfA+Q9
 CAMXc/4kBaFgHaXFMkeNHy3FYAY8v6ks6AszNdsfVLcmoJIi4CXfTzGxudzIXq5RhRLheWuG71i
 H4qTHouVVT7qNV3upJqM+lVQX7jgysSXCURdPFgA3MrsHjOPFYsRHP9W92gjHeVbUppMDk2i03n
 sA/TN9mPfgT1ypIUc3WSHJBIv7Rqn6C3QN4xdTryIEth0181luRVNl4vIizA0O/BjM6gdcJiqy3
 k0rRQvkwYBRoq8RbCtfgvUGPcdqD6l2HmsFQbSVv1T2aHo7CUNXUsd/z/KucIbyE5fZ0I47QX+s
 K/sIpZfGvDqhL7YJXXZ8oltLTVmG9SmgDck5tx/t05Sj9qoJMOZL9dyNIyNOFMVxa+C2d0bS5Qg
 gNvI5puxD1hEVd9HKkLEuDq60wYjgNUzE6oV7DCtWlviAR+SQLwoJfQaQxIUhpcZ2zc9PrvvW5L
 DdTspjT3RDU78wCa9Fw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070141

On 5/5/2026 8:45 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Missing `break;` statement causes `PR_SET_CFI` to fall through to `PR_ADD_SFRAME`.
> - [Medium] Patch introduces a test-only interface into the permanent UAPI.
> --
> 
> commit 9171aa16917963dd1070d9ca3467d9086cd66393
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> unwind_user/sframe: Add prctl() interface for registering .sframe sections
> 
> The commit adds prctl() interfaces which allow glibc to tell the kernel
> where to find .sframe sections. It mentions that the patch is for testing
> purposes only.
> 
>>     [
>>       This adds an interface for prctl() for testing loading of sframes for
>>       libraries. But this interface should really be a system call. This patch
>>       is for testing purposes only and should not be applied to mainline.
>>     ]
> 
> Is it intended to include this in a mainline patch series? Adding temporary
> or test-only interfaces into the UAPI represents a permanent ABI commitment
> once released.

This patch will get replaced by a new syscall that Steven is working on:

[RFC][PATCH] unwind: Add stacktrace_setup system call
https://lore.kernel.org/all/20260429114355.6c712e6a@gandalf.local.home/

> 
>> diff --git a/kernel/sys.c b/kernel/sys.c
>> index 62e842055cc9c..6e81e82bc9911 100644
>> --- a/kernel/sys.c
>> +++ b/kernel/sys.c
> [ ... ]
>> @@ -2906,6 +2907,13 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>>  			break;
>>  		if (arg3 & PR_CFI_LOCK && !(arg3 & PR_CFI_DISABLE))
>>  			error = arch_prctl_lock_branch_landing_pad_state(me);
>> +	case PR_ADD_SFRAME:
>> +		error = sframe_add_section(arg2, arg3, arg4, arg5);
>> +		break;
> 
> Does this cause the previous case to fall through into PR_ADD_SFRAME?
> 
> It appears the new case was inserted before the break statement of the
> previous case. This would cause execution to unintentionally continue into
> sframe_add_section and overwrite the original error status.

Doh!  Stupid mistake during rebase.  Fixed in next version.

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

