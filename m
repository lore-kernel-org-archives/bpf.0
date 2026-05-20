Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F8A273816;
	Wed, 20 May 2026 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288566; cv=none; b=fWJrWQRnrY4CzwPWUJWTxSxuvjMKig4ISQWrjQ3F+jTHy2d8wBPTGf2BdAL4uQsdsahISKPxc5BlgJYNNOpWeqCVJkR/fPjUuf8QUUJMxTaO21DDcx3yxHS7ek5Cgy6kIdwYcglzq1zClSShh3kxIVkjcMKw+GPyQNiyjdL68zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288566; c=relaxed/simple;
	bh=Bg0hmWQCj+Z6DDOFgNrxr8RwlSJXj2ZjrZBxV2IkVik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pi/hrXrC5gLRXE0nkepPzAVzAMuvcDDeKZ9pEgiDh2iUy6o86iGpr9L5CYmXLtjeJWcWdY2zbqE4S5FyGDL4h1KVwVA0+5EU5UMKWdN3CPOSDuTG5fLbJ++0UphwhnWJ9xQdnhSqu6g5r5uv6YHHMoklOnDB3jYOtq7h2dugBEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UAWvKIuM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UAWvKIuM"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K8GSCB1497610;
	Wed, 20 May 2026 14:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XBLx6g
	f7y7RbazGwUc4UbQu+gQgJkOwo4DucHG3Gt3o=; b=UAWvKIuM8G9axi/VEvVTbC
	bMn4KbZLDtgiKOrrqKTotbcISmykRy9IP5ylAU//sHr5wfAhAu+T8mabr3I6GbQ8
	dkAWfk9g0YV4uTXMmEN1VdCYCtyKOXsYYgQPvFSVanrik5fYRLgr0ntkKgd6sS6g
	i/aP7LLs9olzxq87mEJUs8XTUyXIjWLYPeDwu/xbLh6vlLOOXirtcXaWD+KcRTym
	1CHSXrDA5EsOh60dkThmkBiNr98pJU727tKLDL0qRRSDG7J9fjJGwFSDKJPd82bT
	+XJd4EwzETjTBQkZ0O86T5Qo2M1PLYLAGOuJjE6+pUMKck+qsRgDD+nRZIloNC0g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9y2n19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 14:49:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KEdDm0031617;
	Wed, 20 May 2026 14:49:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wk7t2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 14:49:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KEmx4N60490080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 14:48:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAFF620043;
	Wed, 20 May 2026 14:48:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C265F20040;
	Wed, 20 May 2026 14:48:58 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 14:48:58 +0000 (GMT)
Message-ID: <4767d529-4551-43d4-8190-04edd559fff2@linux.ibm.com>
Date: Wed, 20 May 2026 16:48:58 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 03/19] unwind_user/sframe: Store .sframe section data
 in per-mm maple tree
To: Steven Rostedt <rostedt@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, bpf@vger.kernel.org,
        sashiko@lists.linux.dev, Indu Bhagat <ibhagatgnu@gmail.com>,
        Chris Mason <clm@fb.com>, Roman Gushchin <roman.gushchin@linux.dev>
References: <20260505121718.3572346-4-jremus@linux.ibm.com>
 <20260505185158.39F35C2BCB4@smtp.kernel.org>
 <49318ed5-8668-43fe-880d-b91bd7c3a7a9@linux.ibm.com>
 <20260506112135.554ca88c@fedora>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260506112135.554ca88c@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0MiBTYWx0ZWRfX1y2PGzN8S6lj
 FEkxSgKgD3GpIvHzHuq9gUJZeEtViKSamTCUmpHFQqgH1hk5L+exQJYn0EO04KtAFqUFeOrAu6A
 IQlWqOoLACzl4Qs4KXCbFcMTuPQP/KgG0kIxfySvQwhaeU9bcF6N9GzjUqG8jFQ1VSkp9mIXFYb
 LViHMTBLbF6BZhu09VGwZAF6LpwS1c/exUoXYDXMH+B1JZgOUFapn+8u6TfQ4VJxnByf64yRCgU
 cYPiYwhyKur3FzUAHfrbTAQLMPn+WtUS6LCRGRL0uOo1UXbcmXqJpmxCMlg+Kyn2i9TGwtx06o7
 o4X+auNTQ0W4tV0Zh5iw2WzS5KWdsSEKBMQt/uPksPK55WwTiT7zrH5NSfJca9SRFXlK2CiZ8iS
 mV4SjlM1mkLzAhy1GeKU2mynuspV47NWKc1/1LpfmrT4qoOpYFlf+iDHOgRE8j98qyyknoDJo10
 QhvAYqxIeD1o6cg1hCQ==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0dc9de cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=sYNHCNsufd3psUy7vJEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: OG591AqKXtBPSiihZllHHGG11PjzUYrO
X-Proofpoint-GUID: 4j-K5WuoIhvTnf28zPkClXWznTwMsY1q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200142

On 5/6/2026 5:21 PM, Steven Rostedt wrote:
> On Wed, 6 May 2026 15:50:45 +0200
> Jens Remus <jremus@linux.ibm.com> wrote:

>>> [ ... ]  
>>>> @@ -1100,6 +1109,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>>>>  	mm->pmd_huge_pte = NULL;
>>>>  #endif
>>>>  	mm_init_uprobes_state(mm);
>>>> +	mm_init_sframe(mm);
>>>>  	hugetlb_count_init(mm);
>>>>  
>>>>  	mm_flags_clear_all(mm);  
>>>
>>> When a process forks, this initializes an empty sframe_mt for the child's
>>> mm_struct. While dup_mmap() duplicates the parent's VMAs, it doesn't appear
>>> that the registered .sframe entries are propagated to the child's maple tree.
>>> Will child processes silently lose their .sframe unwind data for shared
>>> libraries registered prior to the fork?  
>>
>> Does this ring any bell, Steven?  I ran into it with my signal frame
>> stacktracing test on s390.  I think we discussed this during one of the
>> SFrame calls and it got lost.  
> 
> Oh, this is a good point. I think we need to copy the sframe mt on
> fork, not initialize it.

I'll send a patch with my next version very soon.  Hopefully you did not
spend too much time on that yet.  Review will be much appreciated!

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

