Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D54A3EFD22;
	Wed,  6 May 2026 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081406; cv=none; b=pUqI03kKjUtPzyHHizkCOvnuLqpvS3j/OQHcElAoyV9zn14NzdNJJpMTN/gLxtIAw8siHr9HH0hs2gttlc+lbyjKuJ1gtB1TyODo9AiYBfOFTdtWxfWIABzIr+gyTm/NRwPfFYpajGvgGOULbUwWmzKgtrMQAstDb22XtWdikEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081406; c=relaxed/simple;
	bh=L5M9nBwS1nHUqtwhyuXq/8w0QC5A7ZsRsEYrR2CeSTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AncNvFhH2hnckRc+q7mieWHsqOuAwizJ8Mb9uLLTUBvnPZB0H+aNjjOefa4wbBWGmU4EKMMIWFz8Gm54xNkr+bPDrg7+atDYqKWTecawJaA6F2CcU6QTDRyesS/Cm3ZBjrA/HyMUFs81RERZPDwyEZ+WWAGPEKDNKEIVFJwM1M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jT6QKA10; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jT6QKA10"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646EvBOF1237317;
	Wed, 6 May 2026 15:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8o/pHM
	I0SFKBZ63TlqEPtfnkb+IoVS3CknkKEfiaa6w=; b=jT6QKA10pECSJNX3FttuUV
	rgXFx9AU8t0Gg2FceIpKj9Re6XL5APpTgqCF6KRmfQSddARoFEx2NtNExTA3YTcN
	A2PmdRsd1yAZQHYOWnpm4ZCpIyCdjAcMBfG2wlk81eO82rM54g0cvn4mx5ANAX8v
	T3u5o5UxVS7j+9MxkIhGNZAU02UuTwMYWlmVQVXliA3Jg5MZ0+SwtD09Bf241RqY
	MSl1ruVsINP4DiohX7HzUplGwh2jp7YLKJLIOUnLn8VxkabS8xKYjchkwixsjrYZ
	23zR9rHdNuKS257CBpShwyMgRiIisOctcTQuTkMIkAk+jDMyab7pPpNRE0Tb9VrQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxrp8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 15:30:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646FOZ2V018357;
	Wed, 6 May 2026 15:29:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyw6wtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 15:29:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646FTvI856623434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 15:29:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C209E2004B;
	Wed,  6 May 2026 15:29:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E36220043;
	Wed,  6 May 2026 15:29:57 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 15:29:57 +0000 (GMT)
Message-ID: <82fca24b-d166-4e87-abc9-07cfc9cb8160@linux.ibm.com>
Date: Wed, 6 May 2026 17:29:57 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 05/19] unwind_user/sframe: Add support for reading
 .sframe contents
To: Steven Rostedt <rostedt@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Indu Bhagat <ibhagatgnu@gmail.com>,
        bpf@vger.kernel.org, sashiko@lists.linux.dev
References: <20260505121718.3572346-6-jremus@linux.ibm.com>
 <20260505185932.C708CC2BCB4@smtp.kernel.org>
 <4e5d51f0-8f4c-4a07-9141-8b26d2c90fc6@linux.ibm.com>
 <20260506110142.7b2943d7@fedora>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260506110142.7b2943d7@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE0OSBTYWx0ZWRfXxXqdvENYODpM
 m+gFT++Mtd4vUeKEnK0kFi2Hy8UtOx+st0US3LArD+LkRRtdBY/t9T4SPLkfz1jhgnVlhOrBKb3
 7saTQl/NhXk2tM662Gfjrnfb9598mYUMy18ZzJLkXXil8/Cc/ZDHiQ8XcIbG+O0QRaqcoe9/xGJ
 IAG0AbWWYZZaRzIK9Aw+kT9C9BkEhSkEUMdLwBchgrlhvBSWkwPLkJ7wefNHHU2FbM3WjlVyEDK
 KqdWv5HIpsORniR9PsYJWhGt3zu5eHidHy3wlg61H3xJJw3LTQ24SUcbqufGx+yMar1sjC8romO
 61KRAEkC0WJynWlmgVavjG0SJIZ3ym8ayF+Bw7SwePYDU+ffh790EDrSiUgf9141HfsljA9qoNK
 pW5ROnzcElcoB3+ICcjsUp/B6zb7Q7XIaxMrVvz7IOTzU4UjMPM9DJwAsyPvZW6e8uhE9iDkKfB
 /aqLmbeyj2kNQ2vwlgA==
X-Proofpoint-ORIG-GUID: mdWZrTYdRrElCejZloWldTdKAwVD-PKL
X-Proofpoint-GUID: abjZye90Suc1ux3vqlNHF-JMUX8B6gTN
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fb5e78 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=CBcInBAli9MMVMz-rO8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060149

On 5/6/2026 5:01 PM, Steven Rostedt wrote:
> On Wed, 6 May 2026 16:34:34 +0200
> Jens Remus <jremus@linux.ibm.com> wrote:
> 
>>>> +static __always_inline int __read_fre(struct sframe_section *sec,
>>>> +				      struct sframe_fde_internal *fde,
>>>> +				      unsigned long fre_addr,
>>>> +				      struct sframe_fre_internal *fre)
>>>> +{  
>>> [ ... ]  
>>>> +	if (fre_addr + addr_size + 1 > sec->fres_end)
>>>> +		return -EFAULT;
>>>> +
>>>> +	UNSAFE_GET_USER_INC(ip_off, cur, addr_size, Efault);  
>>>
>>> Will this cause alignment faults on architectures with strict alignment
>>> requirements?
>>>
>>> The .sframe format uses packed structures and variable-length datawords. The
>>> cur pointer might be unaligned here, and UNSAFE_GET_USER_INC() performs
>>> 16-bit or 32-bit reads via unsafe_get_user().  
>>
>> IIUC this should not be an issue for x86-64, s390, and arm64.
> 
> Do we have a way to make sure that sframe support will always be for
> architectures that can handle alignment issues like this? There should
> be something to force this via configs or something that will trigger a
> warning or bug if this is built for architectures that can't handle
> this alignment.

Any suggestions are very welcome.

>>>> +
>>>> +	fre_addr = sec->fres_start + fde->fres_off;
>>>> +
>>>> +	for (i = 0; i < fde->fres_num; i++) {  
>>>
>>> Can this loop cause a hard lockup in atomic context?
>>>
>>> fde->fres_num is a 32-bit value copied from user space without validation.
>>> Since sframe_find() is designed to be called by unwinders in NMI context, an
> 
> What? No. This looks to be a hallucination. sframe_find() will never be
> called in NMI context. In fact, it can only be called in task context.
> 
>>> attacker could provide a very large number of valid entries. Executing
>>> billions of iterations and unsafe_get_user() calls could stall the CPU
>>> and trigger the hard lockup detector.  
>>
>> Please advise.
> 
> That said, we should verify that fde->fres_num is at least always
> smaller than the size of the table.

If we carry the .sframe header sfh->num_fres over to a new sec->num_fres
then __read_fde() could check:

	if (_fda.fres_num > sec->num_fres)
		return -EINVAL;

But I am not sure if that check provides much benefit, as fde->fres_num
is relative to fde->fres_off, which points into the
[sec->fres_start, sec->fres_end[ part of the .sframe section.
So even a small fde->fres_num might be out of range.  Given the FRE are
variable size, it is not easily possible to check upfront in
__read_fde() whether the fde->fres_num is valid.

The validity is checked later in __read_fre() before any fields are read
from the FRE, with fre_addr = sec->fres_start + fde->fres_off being
passed as argument:

	if (fre_addr + addr_size + 1 > sec->fres_end)
		return -EFAULT;

	[...]

	if (cur + (dataword_count * dataword_size) > sec->fres_end)
		return -EFAULT;

> 
>>
>>>   
>>>> +		int ret;
>>>> +  
>>>
>>> [ ... ]
>>>   
>>>> @@ -120,8 +449,10 @@ int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
>>>>  	sec->text_end		= text_end;
>>>>  
>>>>  	ret = sframe_read_header(sec);
>>>> -	if (ret)
>>>> +	if (ret) {
>>>> +		dbg_print_header(sec);
>>>>  		goto err_free;
>>>> +	}  
>>>
>>> Can shdr.fre_len cause an integer overflow on 32-bit architectures during
>>> header parsing?
>>>
>>> If a malicious user provides a large fre_len in the header, fres_end
>>> (calculated as fres_start + shdr.fre_len) could wrap around the 32-bit
>>> address space. This would bypass the bounds check in sframe_read_header(),
>>> allowing fres_start and fdes_start to point into kernel memory. Later, when
>>> __read_fde() and __find_fre() use unsafe_get_user(), this could lead to
>>> arbitrary kernel memory disclosure.  
>>
>> SFrame is currently only supported on 64-bit architectures (i.e. x86-64,
>> arm64, s390 64-bit).  So unsigned long fres_end should always be 64-bit.
>> Do we need to add the following to the header parsing?
>>
>> if (fdes_start >= fdes_end || fres_start >= fres_end) {
>> 	dbg_sec("inconsistent FDE/FRE start/end address\n");
>> 	return -EINVAL;
>> }
> 
> I guess this wouldn't hurt.

Ok.

>>>>  
>>>>  	ret = mtree_insert_range(sframe_mt, sec->text_start, sec->text_end, sec, GFP_KERNEL);  
>>>
>>> Does passing sec->text_end directly as the last parameter to
>>> mtree_insert_range() break contiguous mappings?
>>>
>>> mtree_insert_range() expects the last boundary to be inclusive, but
>>> sec->text_end represents the exclusive end address of the executable segment.
>>> If user space maps seamlessly contiguous text segments, the insertion for the
>>> second segment might overlap with the claimed end of the first, causing it to
>>> fail with -EEXIST.  
>>
>> Addressed in previous patch.
> 
> And I just sent a patch to fix the documentation of
> mtree_insert_range() to update the kerneldoc to explicitly state it is
> inclusive :-p

Thanks!

>>
>>>   
>>>>  	if (ret) {
>>>>  		dbg("mtree_insert_range failed: text=%lx-%lx\n",  
>>>   
Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

