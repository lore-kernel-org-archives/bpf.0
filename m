Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9FF2DA76A;
	Thu,  7 May 2026 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169725; cv=none; b=jimMlPTwYmMCAn5b4pIP70of9dYc3PSYA5RWCso52OGB9mNYLB8dKyoausmLlXnnKJZqEaYRkrLRXCxB8rsMKb59QCDukn67VLwSVHbTivwh63hD5asbagfaDXdTgv93l8PJe3r3KvQxZaPGGiDP8iLO/scpScIqrtYi5u4SE2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169725; c=relaxed/simple;
	bh=P5zRmB3JYIFynYu6LoS9Zfk/P7CV1XT2vnQwV+0KnWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OT6bhYVvoFtVhoFehnRvZ1w+TuBiMsZnmiC2hZzIDnZUDMtNSpoVA3yF0gMdyi4ue2/mYWWatI4y4Wzcl8J1N7aV15Z2D643x9l4c08tE0AjxgFZKoxrYyoKEuj1ezMYQlhn7B1jY7klgnPvYPepOj9FjTY8kKEmsUEa3DGfzoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I1jH7qSl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I1jH7qSl"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647ENLRr813969;
	Thu, 7 May 2026 16:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EZLz10
	Z089O/ouHp1YKLVeQHxQZCg8SYO46eHsUglfA=; b=I1jH7qSlcRN2lJXKhu+tZ3
	QCGhXXT2bjw/1YbQ9052yaZB9jncu7d6yF3ePMRAPCnPcsnm6zdPS8XXMPjTkBwh
	sqYT0Ty3zFUMVt1VPwsXAM6cDLHkqIjbxYmG9HySBdtI1cbW58kvTmLzshQoDfY5
	reJaukwJUMag4XxO3TicrL1sM5acISmlaNvr94GdoZyze81arCK/o3e3pSJ/GZiM
	L/bWUcSV/Q4S9FD3Wn2EAqr6mjihUNeMAFnCXfKRAAs92rXz/Xc7H3u2sZoSBzyY
	B4Dvc0+eqg3kuzXKiZJwU1UgR6iZ/Ez1b/IAPcVoaYCMUoNMfTacPXiyKK8ilN5g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1qfx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 16:02:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647FsdNT005736;
	Thu, 7 May 2026 16:02:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkk4c02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 16:02:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 647G1uHg21627162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 16:01:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A72F620043;
	Thu,  7 May 2026 16:01:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83AAE20040;
	Thu,  7 May 2026 16:01:56 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 May 2026 16:01:56 +0000 (GMT)
Message-ID: <eeb0bfe8-0651-48c0-90fc-d1ebc7ce031c@linux.ibm.com>
Date: Thu, 7 May 2026 18:01:55 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 17/19] unwind_user/sframe: Separate reading of FRE
 from reading of FRE data words
To: Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>,
        Indu Bhagat <ibhagatgnu@gmail.com>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev
References: <20260505121718.3572346-18-jremus@linux.ibm.com>
 <20260505190506.698BEC2BCB4@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260505190506.698BEC2BCB4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: wLqntoCJMrMMvatxu2ch3uqOJ4zW6PaU
X-Proofpoint-GUID: HxlcmDf8flWVY7qxnl1PGQ0IaHbjRRRt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1NiBTYWx0ZWRfX5ByqI5+Aug3Z
 Eo7j2ynxbpHMKUdZi8T1V2W6BGotog3exicFilzBHUuTqzkjBUgQDUCNd4dOCLsCSSXTcjYWKFf
 vN/bP+VqAsUtrlq+EqfazVz6R4C3VC6NwbyTZjtvzbKQuaIq1bRF9WUK/zQI0jnOeb2HElQVZTu
 JBzeWmxGDlliQF9cTNSuXabpF3WHCVAGRZ9vUcJbbTtlCxnaO0V3m2t2blYGR5DeG0LspRX+QfV
 hLSmzlmkEyq8dP0SXeZIP5O3VudUnEmm+q7vfuhgnpMjAXAKZKmm4KNOQVK3ErstQl7t4KY1cco
 /4BRDA0S+nOf8jIh/ys96s4X1jetUh4hzzxl+7VHcaPuqtn/eucooKqtv4tzniPIDI1of98jA1j
 gH6+pZUwM1Co7uss2W6dGogTgag+C5ZZmEXlY5qnD7ueJz225yUqZw0CkKgha1GbkgZA0+OL2Wc
 Blvx+Gq2eepCIqeQTxg==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fcb779 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=bMbYIdgO7Ne2iVapFegA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070156

On 5/5/2026 9:05 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] A malicious user can trigger a kernel panic by providing a crafted `.sframe` section with `rep_size` set to 0, which causes a division-by-zero when the kernel attempts to unwind the stack.
> --
> 
> commit 1aeb36f953ce26b15e30e2b228bfb48239924c2b
> Author: Jens Remus <jremus@linux.ibm.com>
> 
> unwind_user/sframe: Separate reading of FRE from reading of FRE data words
> 
> This commit separates the reading of SFrame FRE structures from their
> data words, which allows linear searches to skip data words until a
> matching FRE is found. New fields are added to struct sframe_fre_internal
> to cache the necessary information to read data words later.
> 
>> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
>> index 2ba2c8b385f96..98346412078b8 100644
>> --- a/kernel/unwind/sframe.c
>> +++ b/kernel/unwind/sframe.c
> 
> [ ... ]
> 
>> @@ -455,6 +450,7 @@ static __always_inline int __find_fre(struct sframe_section *sec,
>>  	bool which = false;
>>  	unsigned int i;
>>  	u32 ip_off;
>> +	int ret;
>>  
>>  	ip_off = ip - fde->func_addr;
>>  
> 
> This isn't a regression introduced by this patch, but while looking at this
> area, can a crafted sframe section cause a division-by-zero just after
> this line?

Fixed in [PATCH v14 05/19] unwind_user/sframe: Add support for reading
.sframe contents.

> 
> In __find_fre(), the code does:
> 
>     if (fde_pctype == SFRAME_FDE_PCTYPE_MASK)
>         ip_off %= fde->rep_size;
> 
> Since fde->rep_size and fde->info are populated directly from the user-provided
> sframe section, does anything ensure rep_size is non-zero before reaching
> this code?
> 
> If a user provides an sframe section with rep_size set to 0 and the
> SFRAME_FDE_PCTYPE_MASK bit set in the info field, will this lead to an
> unhandled division-by-zero exception and crash the kernel during stack
> unwinding?
Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

