Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A83A3B1014;
	Thu, 21 May 2026 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779360958; cv=none; b=aM7+l1wI/vi9erM7jdAAk6PzsorV26yHcJlSl/UoZu16B6prqMiL6B92Q60guvyKiAd5vt3ZrLhPqQ+gVyvPqtij7cFzvlAweGNKoTInoC1ELkz4B10G47JtCXp+rBLyXcxHjDefrnGfyo8zOd7c+yz0s/i89tsKGyhO6ppZe4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779360958; c=relaxed/simple;
	bh=1tHefm4NsJ2JmbBBALCKKNJ8tlIEbuKmvnfbm3m5vug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mo9T50k9fHlEDm8bxUZGVoiw7KQ4xyYNa57ilRuzXeeuYM3VhPg1QHdiXqoP3Az5Tq8gJhgv+1Q1NoNSr5vxBx3kMQZSaX6I8Ff/E1GFgfcc71XtLOgVBx9R9IdLKNFsu3Hik1OUbwVUzME0dqfCyLRcXW69TfWyOYTGod7Ojjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PGwYZRw7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PGwYZRw7"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LAJtcA709576;
	Thu, 21 May 2026 10:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6TYQyU
	tK+N64GhcEccfNzUZ27UDcZ+v6dwkMv1FlVJ0=; b=PGwYZRw7zCmt4ApE8Ifj8N
	MvVijsKFiafabbyHr7RRGsrupq7jDTUjTbUeZFWuhVP746DeOq/JMR1pxsHdTve0
	aU24Z902bprxnsRYQxPR26tCek17DCozBBNpHSFO6dS1iEWcHHNr4t6YcgrxlYHV
	8UvqKolSIzxfKvQNzd8XU5VpG0OM+yJLOLdmMyMLQ7/z+gcEbkRDgnLZdl5y/hsh
	uKqvh4OJMsUc/V2px1+TSDO5juLBVzAXfeFBnjzYuOd5jtXjHqgaBj2SZF+gt95R
	iPUaB6/1VnEKSp9P2zCGxBmwSkPN5CKrA8s2s/4eG0hahiSy7lnDo6QaI/B2qJcQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h756edc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 10:55:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LAs9ru008705;
	Thu, 21 May 2026 10:55:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wkbppe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 10:55:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LAtpFK52035850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 10:55:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 677A720043;
	Thu, 21 May 2026 10:55:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4996520040;
	Thu, 21 May 2026 10:55:51 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 10:55:51 +0000 (GMT)
Message-ID: <17ef3fa5-d378-43da-9407-62fd1bba5d96@linux.ibm.com>
Date: Thu, 21 May 2026 12:55:50 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 11/20] unwind_user/sframe: Show file name in debug
 output
To: sashiko-reviews@lists.linux.dev, Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc: bpf@vger.kernel.org, Indu Bhagat <ibhagatgnu@gmail.com>,
        Dylan Hatch <dylanbhatch@google.com>
References: <20260520154004.3845823-12-jremus@linux.ibm.com>
 <20260520161405.AE1C31F00893@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260520161405.AE1C31F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0ee4ba cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=z2FLfFt9dpsr1D0tU9QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HNpV6IXKzOqk5UmX_3LKB2S6AZALZNqe
X-Proofpoint-GUID: UGZ5pSZWvVsTaasM5CNC9D0gCO2vLle6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEwNSBTYWx0ZWRfXymyudY+j9iIJ
 2DjbVcgLS+1NZRdERQexL7MIFS4T/tOVQ8m7Ch/qWeQlyOe8PpW4vXmK0weYuJ0nrAKTcieEd9K
 mI4UICpD9RlgW8VfYnzw9fA3AqkugBOH9ifObqNPUlhb3zzwRFze8+5LaHcCgUBjlvZvxzWkiOu
 8aL5TLFnKpEwF2r8GkySubhYg9g1Kf0QBmRxto3kijD+SEOkOmrKvTz/Iw0HGiq17tN8vjojd4O
 N74F0iiL/eEDlcpaPW8GAVv7tthuRyJHBs8PzRMndMDMBRDeUBYdGqUFvLvhUWCjQqzht1SNGRi
 I9KYOoDGGoxKVFMi5iYg7Mmdll+niE0MBeOJbg9nh3no8Zqqh4zvoGgERwUcVlFXiYiJfUrSmAf
 tkcex8p5gqR1eB8+ZzCSf44t1rXBsfBSGF/oHWtVUkflC7LSPwYb7WsHK7VuA5AMHAKEOKBggvj
 YKDj2tJC/sojkXqnpug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210105

On 5/20/2026 6:14 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Low] Incorrect use of `vma->vm_file` instead of `!vma_is_anonymous(vma)` to classify a VMA as file-backed.

Steven, Josh, please advise whether to apply the changes below.

> 
> Pre-existing issues:
> - [Critical] Calling `sframe_remove_section` from `sframe_find` acquires a spinlock in NMI context, leading to deadlocks, and triggers a user-controllable WARN.

Invalid.  Stacktracing using SFrame is only performed deferred and
therefore never in NMI context.

> --
> 
> commit 60b05617f9a9c00f287a96dda25f8e4086c6178b
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> unwind_user/sframe: Show file name in debug output
> 
> This commit prefixes debug output strings with the file name to make sframe
> debugging easier. It looks up the VMA corresponding to the sframe section
> and extracts the filename based on the VMA properties.

>> diff --git a/kernel/unwind/sframe_debug.h b/kernel/unwind/sframe_debug.h
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
>> +	if (!vma)
>> +		sec->filename = kstrdup("(vma gone???)", GFP_KERNEL_ACCOUNT);

Should vma_is_anonymous() be explicitly tested?  Currently an anonymous
VMA is assumed as last resort (in the final else clause).

	else if (vma_is_anonymous(vma))
		sec->filename = kstrdup("(anonymous)", GFP_KERNEL_ACCOUNT);

>> +	else if (vma->vm_file)
>> +		sec->filename = kstrdup_quotable_file(vma->vm_file, GFP_KERNEL_ACCOUNT);
> 
> [Severity: Low]
> Does this code accurately classify file-backed VMAs?
> 
> Anonymous mappings, such as private mappings of /dev/zero, can also have
> vm_file populated. Relying only on vm_file might misclassify these mappings
> for the debug output.
> 
> Would it be more reliable to use !vma_is_anonymous(vma) to check if the
> VMA is file-backed before accessing vm_file?
> 
>> +	else if (vma->vm_ops && vma->vm_ops->name)

Shashiko AI review of v14 brought up that vma->vm_ops->name(vma) may
return NULL.  Should this be explicitly handled as follows?

	else if (vma->vm_ops && vma->vm_ops->name && vma->vm_ops->name(vma))

>> +		sec->filename = kstrdup(vma->vm_ops->name(vma), GFP_KERNEL_ACCOUNT);
> [ ... ]

If explicitly testing for vma_is_anonymous() above, then the last resort
would be something unknown?

	else
		sec->filename = kstrdup("(unknown vma???)", GFP_KERNEL);

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

