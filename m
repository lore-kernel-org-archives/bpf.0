Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4564C3AA4EF;
	Thu,  7 May 2026 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778170693; cv=none; b=cRMaAtM/FKar3ZkjLUYUvCCs3eXbJQHM7mslrGPIWYgtTlCK91XA7auINlUTgptAmFLKa7ctJosFoKfYZZ57TMThMlrWe0TaoLzA9MJc+uYZiPNXKgDiueBiiLCGW0nDoUnVhEnYFq4djd7lNijTVRhpQxJEE5XEOXdJIdrOSfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778170693; c=relaxed/simple;
	bh=aKxMDtiHoVhnzD/c2/TNAnB/B9Nc0pG3fDUwCjpFGCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DAK5K8fKp9ZmTv/uhe5sMxpYeR984XDKuNHNdycY4PLlBCupOgRxysGdVX1P+XigfwjfMyZ2oDem6TxgNk+//u0w2NWRxYV6sffx6oYQQxbfi8BbUT0EUG40b0kI9aOhVvJ71bh67Z/VoBn2ZyKPWIt3bBwK1vbPVvOqnP3a7A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QW4feoLF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QW4feoLF"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647F8LeO852737;
	Thu, 7 May 2026 16:18:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=40bGt9
	8KM/a8ddhSWpZ0EbCqSAq51Gz6IvkA6nerBXU=; b=QW4feoLFeDoQ9J8kCSpX2Q
	ypx8HEzs6b5Slf7IChUeXXmdhrmnzaRabLpaQ9PGaS/b1BleTZ49mZa//NiSSz6m
	S6u/76VHK/Ckmc83WwHx0qvjrk6bF1JyS1de+yjYIloFO8M+l6FIOfJ7fHqdIMf8
	Fo53VeaAu7YMI6nkv7kPX7mA+iLJXg1tmt0UlpN9xqWTRBJT7aFe1Kf/QlAite3B
	YpdZgwpWCarIQYBgqMA/5MrJOsc287sgw7aaryRBuysDLQzqPpuxGT5wcMW7ZDAn
	tgbIzuPAc4IG8YgUwLK2E7C90B2WzyeDe+X89Y679cc3fjFXCyJ+rLmDIi19ezJg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4xjrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 16:18:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647FsUGF005677;
	Thu, 7 May 2026 16:18:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukqmm14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 16:18:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 647GI5tR47579632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 16:18:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E579E20043;
	Thu,  7 May 2026 16:18:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2FD320040;
	Thu,  7 May 2026 16:18:04 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 May 2026 16:18:04 +0000 (GMT)
Message-ID: <05adaec0-c2cc-4a16-b2da-ba3ed7437e7d@linux.ibm.com>
Date: Thu, 7 May 2026 18:18:03 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 07/19] unwind_user/sframe: Wire up unwind_user to
 sframe
To: Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev,
        Indu Bhagat <ibhagatgnu@gmail.com>
References: <20260505121718.3572346-8-jremus@linux.ibm.com>
 <20260505185528.8E529C2BCB4@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260505185528.8E529C2BCB4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1NiBTYWx0ZWRfXzTmBQ77rGbW3
 ut5+NszAjZiSoiUPIM8ysicjmxfVNcwhsVfuLwH1iPIzd7arY4zJvQ/OHWZqEwPSC7cX6xzQClX
 qDPu3/h85HPsKCpsayAA28ZYDSbvoc/lMcvgd+FcE5d5euFolBmLh68ldASsFWF/PTGCou7+fD4
 YtuZHHiIRyaGsMH31B3PWJgJKEKtZfXSu5eb3H5egVrF0fdF5XgQpkhU+auOEgFCOsyBUyvuQ/o
 5sE5r19diGDuBGZy9Iff6Q+KMR9V6oaan5lURMxApm9g4zo/du6dAgdp9O4Wf2CLiOMwqF8NENj
 BtSIpsCIQfz0Zt/TS6cLmzSpNPOBJoO4gNki0YDMDqdKKA2uJivWR86mqP0ExLBTFyOCSqpBaCw
 O1GO71UdRL24I0NDy00V4HaRrBFUR9LOBVy3fePWa/F0O+C9plt82KdsPm1Zk3CFizv2fTMucNG
 WhGNpFReWTZAChdYNkA==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fcbb3f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=cVT6PhOZ-X7ijlxorekA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hGPW0TDMrgCCN8dbdC1y53Z0VBeEN9GA
X-Proofpoint-ORIG-GUID: L7zQqDukMwgsizHEUVq_1v7W80Jx4Bc9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070156

On 5/5/2026 8:55 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Unbounded linear scan of user-controlled sframe entries can cause a CPU hard lockup in NMI context.
> - [Medium] The commit message claims to refactor `unwind_user_next_common()` by removing an unused `pt_regs` parameter, but this change is entirely absent from the code modifications.
> --
> 
> commit 2e1e17bbaa1c0426d41d66ce7930a944f3e86ae7
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> unwind_user/sframe: Wire up unwind_user to sframe
> 
> This commit hooks up the sframe infrastructure into the unwind_user interface
> to support user-space stack unwinding via sframe. It adds the
> UNWIND_USER_TYPE_SFRAME type and updates the unwind_user_next() logic to
> attempt sframe unwinding when available.
> 
>>     [ Jens Remus: Remove unused pt_regs from unwind_user_next_common() and
>>     its callers.  Simplify unwind_user_next_sframe(). ]
> 
> This isn't a bug, but does this commit message match the changes?
> Looking at the diff and the code, there are no modifications to
> unwind_user_next_common() or its callers to remove a pt_regs parameter.

Sashiko AI review failed to understand this commit message comment.

> 
>> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
>> index 90ab3c1a205ef..1fb2724197332 100644
>> --- a/kernel/unwind/user.c
>> +++ b/kernel/unwind/user.c
> [ ... ]
>> @@ -82,6 +83,16 @@ static int unwind_user_next_fp(struct unwind_user_state *state)
>>  	return unwind_user_next_common(state, &fp_frame);
>>  }
>>  
>> +static int unwind_user_next_sframe(struct unwind_user_state *state)
>> +{
>> +	struct unwind_user_frame frame;
>> +
>> +	/* sframe expects the frame to be local storage */
>> +	if (sframe_find(state->ip, &frame))
> 
> Can this sequence cause a hard lockup in NMI context?
> 
> Since this unwinder is often called from NMI context (like perf), sframe_find()
> eventually calls __find_fre() to search for Frame Row Entries. If __find_fre()
> performs a linear scan over an unbounded, user-controlled number of entries
> (fde->fres_num), it could spin for a long time without yielding.
> 
> If a malicious userspace program maps a large VMA and provides hundreds of
> millions of FREs, would this loop calling unsafe_get_user() on every
> iteration tie up the CPU long enough in NMI context to trigger the hard
> lockup detector?

Please advise.

A user could craft .sframe with a large number of FDEs (up to UINT32_MAX)
and large number of FREs per FDE (up to UINT16_MAX).  Each FDE could point
at the same FDA and FREs to save section space.  Each FDE would require
16 bytes in the FDE table. All FDEs could share a single FDA of 5 bytes
and share FREs of minimum 5 bytes each (when using the 16-bit start
address offset to have UINT16_MAX FREs) in the FRE table.

> 
>> +		return -ENOENT;
>> +	return unwind_user_next_common(state, &frame);
>> +}
> 

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

