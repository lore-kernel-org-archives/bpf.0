Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAAD3A6416;
	Thu, 21 May 2026 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365344; cv=none; b=IJ+0LA3yJiu59Kv3YF8xjo4COlxFm3Bhzg6EJ1g5Fmps00Y7VZvEs4f18BbWTXBTSY3Z/O+aB7wllzeqlWMqpGouCtdOE8rBoqE8bMYJgjYJW3uQ+SL8CmXZsC2uscajcLVjv+1Ewe2OYwWe55Pyp7s8nEEVvRQRDTnrsUUedy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365344; c=relaxed/simple;
	bh=sJrrMr094xvZyddho70+YKweYqzL5J8iDOb5AzyHuag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UpUROMlS5SjQsyFbdQVPG3Ge3fcxMmPoQlRi6e950YM+B63Weowfvd0PMyT13XQjW9/qO5ED/BbFYUPT4JggGYCwm0tTrHB4z9lvN1wpd8LbKukoGSqtv/PcHnFwv4RZ8jrKBxA9kGyQktNKVbGSRRwkE8NWB73uhuDKOqoTjP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dviSgMU/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dviSgMU/"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L9ZfuT3760653;
	Thu, 21 May 2026 12:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=o816kP
	xjhdv4aBZwN0YA8yZrhVXNlyIVyYeZtdEI1AM=; b=dviSgMU/rtmOfFNQYPI2Zm
	mnrg1pFEFZdE86PiGSnC67XC6CwLiq7P9u/uOukY6adDvT4FP9CoKPGQ4qAI0w4e
	CyMZy8xlhcpZCroHaCJ6xn5xXpQh9JOxQ2aKVf936NxzwEmtCaHTglcJITR03Hit
	rldDBxx4CwxP0cv3wywVGLJFDDjszgCg8cj3AA0Sslp+eYgszyZVcADKmbGO/vXB
	vWc96P7i78t/p7Egw16hrCojV+Jz7NwwV7liWHwY1slJn50l25oFc84sWJjH1OZt
	ukY+F603W10jXr5vrLqiu/Hzyw7wB/C6PBKYSE8QCxDyiVMfyyt6c05gBYjCOuSQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h756q8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 12:09:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LBsP02023510;
	Thu, 21 May 2026 12:08:59 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wqc69h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 12:08:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LC8viq13304280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 12:08:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF6722004E;
	Thu, 21 May 2026 12:08:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7B7E2004D;
	Thu, 21 May 2026 12:08:57 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 12:08:57 +0000 (GMT)
Message-ID: <5729ca9e-1255-4dd9-a38d-182125207015@linux.ibm.com>
Date: Thu, 21 May 2026 14:08:56 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 20/20] unwind_user/sframe: Add prctl() interface for
 registering .sframe sections
To: Steven Rostedt <rostedt@kernel.org>
Cc: bpf@vger.kernel.org, sashiko-reviews@lists.linux.dev
References: <20260520154004.3845823-21-jremus@linux.ibm.com>
 <20260520165255.A69B71F00893@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260520165255.A69B71F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0ef5dc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=zW97R7vGGso92DYXnRsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Q2cwWq3tSJTp66zDKeH7I1D1pFt7R1SM
X-Proofpoint-GUID: Q2cwWq3tSJTp66zDKeH7I1D1pFt7R1SM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEyMSBTYWx0ZWRfXyoQxKBdw4mt4
 rBg5fadSR/ylGtXj9u8aAE9P8NcRCYqcnlyoDsLrIKSV88frZOM8TTH33XyD1FunA07iA7sF3AK
 d34N1j02vPCEIMYnfO8rrfoRjuJFPUriYq6Z6cyMz1FVXP6h3i5Abz01QZGdqR5CqjBhGPsIZr5
 CW2OiO2u8QLZhD51jbIGM4oDl3PgLshR5GaRBtksg9/8+ktW75Ai8uB8vElG3Tb1/21F5jY4IwC
 Xr84XJX20Zp3xbKk+5vudz1D93QMnSVjtBdUIzayYEUFE2g08lwcpEQV7w2bTp6r7exJsP+c6vi
 OVG10iY2bniI1aSNkOA0KVM2cJQ/HVU9MaVyQ297Mz7HBFgHGJj26V+AH8Gx8mMycqAYezZ0a6J
 Y1bK1q89JixXu7ze8h5qbo3pEQC0oAL/+jWB/jFiloc4EV3x6Bz0RNgS1do1DFNWrz5GjAmYjnb
 WddZR5UB/kmZFm7aL+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210121

On 5/20/2026 6:52 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] The patch introduces a temporary testing UAPI into `prctl` which is explicitly noted by the author as not intended for mainline.

Ignore, as this is for testing only.

> - [High] Concurrent prctl(PR_ADD_SFRAME) and prctl(PR_REMOVE_SFRAME) calls lack synchronization, leading to use-after-free, double-free, and memory leaks.
> - [Medium] Unsupported prctl options PR_ADD_SFRAME and PR_REMOVE_SFRAME incorrectly return -ENOSYS instead of -EINVAL when the sframe feature is disabled.

Steven, something to consider for your upcoming syscall that is supposed
to replace these temporary prctls?


>> diff --git a/kernel/sys.c b/kernel/sys.c
>> index 62e842055cc9c..b0a9b1e3ccd7c 100644
>> --- a/kernel/sys.c
>> +++ b/kernel/sys.c
> [ ... ]
>> @@ -2907,6 +2908,14 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>>  		if (arg3 & PR_CFI_LOCK && !(arg3 & PR_CFI_DISABLE))
>>  			error = arch_prctl_lock_branch_landing_pad_state(me);
>>  		break;
>> +	case PR_ADD_SFRAME:
>> +		error = sframe_add_section(arg2, arg3, arg4, arg5);
>> +		break;
>> +	case PR_REMOVE_SFRAME:
>> +		if (arg3 || arg4 || arg5)
>> +			return -EINVAL;
>> +		error = sframe_remove_section(arg2);
>> +		break;
> 
> [Severity: High]
> Are concurrent calls to PR_ADD_SFRAME and PR_REMOVE_SFRAME properly
> synchronized to prevent double-free or memory leaks?
> 
> If sframe_remove_section() only holds an SRCU read lock and
> sframe_add_section() only holds mmap_read_lock(), could Thread A and Thread
> B concurrently executing PR_REMOVE_SFRAME both find the same section and
> erase it?
> 
> If Thread A calls mtree_erase() and queues the section for freeing via
> call_srcu(), and Thread C concurrently inserts a new section at the same
> text_start via PR_ADD_SFRAME:
> 
> Thread B might then erase the new section but queue the old section's RCU
> callback a second time. Could this sequence lead to a double-free of the
> old section and a memory leak of the newly inserted section?
> 
> [Severity: Medium]
> When the sframe feature is disabled in the kernel configuration, will these
> calls return -ENOSYS instead of -EINVAL?
> 
> The dummy functions defined in include/linux/sframe.h return -ENOSYS:
> 
> static inline int sframe_add_section(unsigned long sframe_start,
>                                      unsigned long sframe_end,
>                                      unsigned long text_start,
>                                      unsigned long text_end)
> {
>         return -ENOSYS;
> }
> 
> According to the prctl ABI convention, unsupported options typically fall
> through to the default case and return -EINVAL. Could returning -ENOSYS
> cause unexpected errors for userspace applications probing for this feature's
> availability?
> 

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

