Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD5B15ECCC;
	Thu,  7 May 2026 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778165730; cv=none; b=qq43J2wGSx66T93hg2GgqKj00/Yka68gZqjMulydvCtwfUltRSZfQlvFXwLAfrjxQkAIHI7rM3XR0JeF9WJ00Wk/Fz9sDqbZVcEI1O130OrMW/i2+R6l6eQ67N1lRKJU8lKzwd7vlFtu2/K33NC+JRWsVoO7KxweY8/oMO0UQbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778165730; c=relaxed/simple;
	bh=2ZVajmPaSkGvuA/yHVKgEbcelNRw5s50vYsWkiOJxdE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nMfOVY1udn2P9k4ZsfYtBUjUbGuLJeaCQ4GaTQnccF0p7bRpfeOsT8DWQkubHOVwstOKr0lO2XdK97SfqnB22Mp/as3cvO/KHFhu6qT64C0xkKaZ8fR0cBCLKFCdB/tOTwc0C8px8KbEl5NHbV3Qm2tcI4dLFyx2Dp5ewBB6VYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c/fkqRoA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c/fkqRoA"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6479vfh81496151;
	Thu, 7 May 2026 14:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lWiIA9
	h8T8iXeuIwUqmNWo/xrWHHXLraLrEMf2skmsM=; b=c/fkqRoA9JDMeFkn6x8Lf0
	dCdNz0ZzT+ghTtIGBSvD1rDmNdnoGSWmyLTakW37lw2ZBTy0fdzaRPGs/aK3SHNC
	Dj1PZqVl9/Kd03cwI0ABek8ZzM12t6WnALI0ftJmuSdQnRVqW+NLFqxzMeQNGEXa
	q4ejkaO7oKW5/j/P+BG93/WSHINkIyTVKVtrjxbfnjtb3tFIbiSJqF/+r/L5gLyz
	eAvPFvuTRSeWaEvu4TyijRJhEdA1h3ZIefXyFz5J3yKiM2YKNnJVKjjW3Cr8I75n
	YDPnVzghoSP4ILvkBS8NTI8wxDOT4tyhxitAKL7u+FaqjECKeSL7qPDuW19KLJ2g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x4y4w4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 14:55:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647EsfIx002160;
	Thu, 7 May 2026 14:55:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgkxeq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 14:55:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 647EtN0u62325000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 14:55:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFD302004E;
	Thu,  7 May 2026 14:55:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EAE02004D;
	Thu,  7 May 2026 14:55:23 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 May 2026 14:55:23 +0000 (GMT)
Message-ID: <8809f550-1dcf-4e47-96fe-74e85c522418@linux.ibm.com>
Date: Thu, 7 May 2026 16:55:22 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 02/19] unwind_user/sframe: Add support for reading
 .sframe headers
From: Jens Remus <jremus@linux.ibm.com>
To: Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev,
        Indu Bhagat <ibhagatgnu@gmail.com>
References: <20260505121718.3572346-3-jremus@linux.ibm.com>
 <20260505124948.669E2C2BCB4@smtp.kernel.org>
 <f106e4a1-4f60-4c65-97bc-2257005765e5@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <f106e4a1-4f60-4c65-97bc-2257005765e5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE0NiBTYWx0ZWRfXztIuCT/MGSyv
 6B9CI6Wy/FYuMZUwce4LeXnB5JL7KZkq8ltFbxD/r4KTLNijEvQ10BX1/sOAJZ772CdtCPkZPCZ
 RitHY27A0xw0WB3L5Z6JXRUwdc8N5b88CHa0x7xRlvNyC9IwHd0lU/xCLLyqrKwpVLNiQPL2Qml
 0s+1vL39GhOqVWs/XiMbOYThOKtLRS6d17F62LYdSFmKv6E84NcQ1jUhZo78iU0Js06++cJmMfj
 7MlvtE3A2BAnHtZvAR7YeTg+LHXq9OVEpFHcd480yPA+w8f1HpYh1D69YX18Nv+RE8L7yorLYbf
 VGiPr5MO1YzdrcK++tI10rwFQikGhOwnW54SBJcBaZ0ppFrwPPLlHSsAAnwX6fqirQOuD06aKwg
 qBF4g95vKw+qypnkxX1qVZUHv+eBGNZh/rHBkOXYiuqoi9/6hZCIMFR4D9Rpb1MFMzblQrmWqtb
 lbb9OK8+82PXeS8rslQ==
X-Proofpoint-ORIG-GUID: AxTHEVNvyk6uLsp_uzrXGwTza0T2jt6y
X-Proofpoint-GUID: zXMZSxucn2v49XcB23sObOmHP0dJA1RS
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fca7de cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=LFt20mCCc4CE-LtB3JUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070146

On 5/6/2026 3:42 PM, Jens Remus wrote:
> On 5/5/2026 2:49 PM, sashiko-bot@kernel.org wrote:

>> [ ... ]
>>> +	sec = kzalloc(sizeof(*sec), GFP_KERNEL);
>>> +	if (!sec)
>>> +		return -ENOMEM;
>>> +
>>> +	sec->sframe_start	= sframe_start;
>>> +	sec->sframe_end		= sframe_end;
>>> +	sec->text_start		= text_start;
>>> +	sec->text_end		= text_end;
>>> +
>>> +	ret = sframe_read_header(sec);
>>> +	if (ret)
>>> +		goto err_free;
>>
>> Is it acceptable to mix goto error handling with scoped_guard() cleanup
>> helpers in the same function?
>>
>> The kernel's cleanup subsystem guidelines generally suggest that usage of
>> goto and cleanup helpers shouldn't be mixed in the same routine.
> 
> This references to the following comment in include/linux/cleanup.h:
> 
>   Lastly, given that the benefit of cleanup helpers is removal of
>   "goto", and that the "goto" statement can jump between scopes, the
>   expectation is that usage of "goto" and cleanup helpers is never
>   mixed in the same function. I.e. for a given routine, convert all
>   resources that need a "goto" cleanup to scope-based cleanup, or
>   convert none of them.
> 
>>
>> Could sec be allocated using __free(kfree) to avoid the goto entirely?
> 
> The goto error handling is used outside the scoped_guard().  So I think
> it is fine.

Let's do that.

> Do you see any value in converting it as follows (my naive attempt):
> 
> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> @@ -722,13 +722,14 @@ static int sframe_read_header(struct sframe_section *sec)
>         return 0;
>  }
> 
> +DEFINE_FREE(free_section, struct sframe_section *, if (_T) free_section(_T))
>  int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
>                        unsigned long text_start, unsigned long text_end)
>  {
>         struct maple_tree *sframe_mt = &current->mm->sframe_mt;
>         struct vm_area_struct *sframe_vma, *text_vma;
>         struct mm_struct *mm = current->mm;
> -       struct sframe_section *sec;
> +       struct sframe_section *sec __free(free_section) = NULL;

Obviously this whole approach does not work, as it causes the section
to get freed once set goes out of scope.  Just learned the hard way,
that I had not thought this through well enough...

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

