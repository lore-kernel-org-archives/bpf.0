Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C4B284883;
	Tue, 12 May 2026 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778597550; cv=none; b=BWkX3YRnzGzK39VdKvooLerbU3eIErO8JmcKDttnhGtyxM3PrOsD2+U8nU8DWZjEkq8znh3RJjSje1yOTa1NXkbRhZzafKUeaKuYNAAIzPnWPr1noqE2/Oh8QZrPkb2i5Dv5DBxgYXQcZSgBXZ0BeXfQ1JmFcgIQ04NroIwggks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778597550; c=relaxed/simple;
	bh=B3A2yAykcS1ympm2V9MGsO72iKngEppRZ5Kh5k/09e8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hgh0Z1VZwVNV5uyCxI/ADhgdXwpP2NkE0OxbkSHrCABVRst1YXduhu5CdMhCql2uM/UG8WxRxvMg8DRxEQDqKzSieTdWKHojII8ed1aEjP2DrUN5NJaoqDKMYcRtlkIhtP5YyprPvw5owAWn8S6l/AGXLbSogkFt1hIPTue7B7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EWHAOq3T; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EWHAOq3T"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CCiufJ2760182;
	Tue, 12 May 2026 14:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3lhary
	eCq7o/H4UmZvHjApFmPwLwb1UOopGyuR6mmxo=; b=EWHAOq3TDcdm0QxI8q0cSC
	3ao4vWwuJ2Vk2ofjYfa2Doy47ViVsZ6RV3QERcODC5j6tH8nLK7PE3kRKBAWtf/H
	vXFnPpyXAqLtcbQo6wUIRL9natH8YSi2h3UnlYRvFsDC66xeteIvR85v1ajAQ/QH
	SdyXCc3WAaPxsHcL4PpA0C0jRn303uaGzEQBAIwhyyrV6ev0KSbF6rr4RgumR/7i
	VsdamitE9/J8Cz8NAWyl9bFIAFgiNHsF9jW0vXaf2RAP40OOB5qPmnnVAG9hO1rS
	4GifT1GdnvzDz/fMPECoOxCWmLLOINRhmnCo3fLC9hAsthpHcpK0mCJj6BjOwdFA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6kegg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 14:52:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CEdWBC019005;
	Tue, 12 May 2026 14:52:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgbju8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 14:52:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64CEqN8Q61014500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 14:52:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 649B82004F;
	Tue, 12 May 2026 14:52:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 428FF20043;
	Tue, 12 May 2026 14:52:23 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 14:52:23 +0000 (GMT)
Message-ID: <edd04d6c-3cdc-43da-9cf2-44cccc353658@linux.ibm.com>
Date: Tue, 12 May 2026 16:52:21 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 11/19] unwind_user/sframe: Show file name in debug
 output
To: Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev,
        Indu Bhagat <ibhagatgnu@gmail.com>, Heiko Carstens <hca@linux.ibm.com>
References: <20260505121718.3572346-12-jremus@linux.ibm.com>
 <20260505184638.5648DC2BCB4@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260505184638.5648DC2BCB4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: A8nRzhep2oz0aBvY1XZxhj6sYJJN2533
X-Proofpoint-GUID: HiUlC5L0Drwbz9cpG-NPDpkUPgYJ1QiK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE1MyBTYWx0ZWRfX18lFaAw/k0QI
 hbOJ2u1DnsU309WWvIoX84APON+0xGsUhYP1HStky2mVDW332qGEJcyfkqYmTUNR9ZWGcJ/kEvz
 YYuvUubKQuHsVtQeAEbER+t3V/JAF/oOA6pvaBlFq7ur5zQwUm+LvaEYGbZWLBQoBZVropHSQlo
 j/p8C2tdBb5d2IUDe0+M4Ztu2e8QoKATLadW1y5U4IxUJ0RfA6Xc5jKP7dA2HTGxAw2kqV27CKT
 WFdSitpKk6SmczSnYGDyx2eQ2VQk3H3ZnHDEWtjug2YSw9bUY22IproUiqpAYRI3dLTOrdnQ3/b
 nt+40JJHNnwd2bUUckWnBV4qWZ9KufXUperjzMn0kMUSRHKwO1mUSP/BBW9lf4/VNdbGqnk+uUj
 Db0jB7zpX4V5F2UaDc8m2YQEAq/fo/vPGhv/p+2WWrsZhxWnMuuOz0D37wk8Re3p+g37syBO78w
 L0TzKl+lB8ayG3pfU6w==
X-Authority-Analysis: v=2.4 cv=P8UKQCAu c=1 sm=1 tr=0 ts=6a033eaa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=njC-hnyFwTIKUP6h0CMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120153

On 5/5/2026 8:46 PM, sashiko-bot@kernel.org wrote:

> [ ... ]
>> @@ -496,7 +501,7 @@ static int __sframe_remove_section(struct mm_struct *mm,
>>  				   struct sframe_section *sec)
>>  {
>>  	if (!mtree_erase(&mm->sframe_mt, sec->text_start)) {
>> -		dbg("mtree_erase failed: text=%lx\n", sec->text_start);
>> +		dbg_sec("mtree_erase failed: text=%lx\n", sec->text_start);
> 
> Does accessing sec->filename in dbg_sec() risk a use-after-free here? If
> mtree_erase() fails, it indicates the section might have been concurrently
> removed. The SRCU grace period could expire, causing sec to be freed before
> dbg_sec() is called.

IIUC this is a valid concern.  Should this change be simply be reverted
or should __sframe_remove_section() create a temporary copy of the
filename and use dbg() for this rather unlikely case?

> [ ... ]
>> diff --git a/kernel/unwind/sframe_debug.h b/kernel/unwind/sframe_debug.h
>> index 36352124cde81..e568be4172b1b 100644
>> --- a/kernel/unwind/sframe_debug.h
>> +++ b/kernel/unwind/sframe_debug.h
> [ ... ]
>> +static inline void dbg_init(struct sframe_section *sec)
>> +{
>> +	struct mm_struct *mm = current->mm;
>> +	struct vm_area_struct *vma;
>> +
>> +	guard(mmap_read_lock)(mm);
>> +	vma = vma_lookup(mm, sec->sframe_start);

Should below be changed as follows based on Sashikos AI review feedback?

>> +	if (!vma)
>> +		sec->filename = kstrdup("(vma gone???)", GFP_KERNEL);

	else if (vma_is_anonymous(vma))
		sec->filename = kstrdup("(anonymous)", GFP_KERNEL);

>> +	else if (vma->vm_file)
>> +		sec->filename = kstrdup_quotable_file(vma->vm_file, GFP_KERNEL);
> 
> Does checking vma->vm_file directly skip proper classification for some
> anonymous VMAs? According to the VMA guidelines, certain anonymous VMAs like
> private mappings of /dev/zero have vma->vm_file set. Should this use
> !vma_is_anonymous(vma) instead?
> 
> Do these string allocations need __GFP_ACCOUNT? Since they are triggered by
> user space and persist until the section is removed, could a user allocate
> large amounts of uncharged memory and bypass memory cgroup limits?
> 
>> +	else if (vma->vm_ops && vma->vm_ops->name)

	else if (vma->vm_ops && vma->vm_ops->name && vma->vm_ops->name(vma))

>> +		sec->filename = kstrdup(vma->vm_ops->name(vma), GFP_KERNEL);
> 
> If vma->vm_ops->name(vma) returns NULL, will kstrdup() return NULL and skip
> the subsequent fallback naming methods? Does this leave sec->filename as
> NULL, causing debug logs to print (null)?
> 
>> +	else if (arch_vma_name(vma))
>> +		sec->filename = kstrdup(arch_vma_name(vma), GFP_KERNEL);
>> +	else if (!vma->vm_mm)
>> +		sec->filename = kstrdup("(vdso)", GFP_KERNEL);
>> +	else
>> +		sec->filename = kstrdup("(anonymous)", GFP_KERNEL);

		sec->filename = kstrdup("(unknown vma???)", GFP_KERNEL);

>> +}
> 

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

