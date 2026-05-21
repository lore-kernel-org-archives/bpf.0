Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC023E0C70;
	Thu, 21 May 2026 12:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367882; cv=none; b=EnR4Ti2GXjpylK70fxP+eZF6O0eo3P+re/IwZOXUQDMrsPCz6cE5Gk+7eXXXrnXiuhVTZwz2Dbf2YF1/CtlyMZpqUjAq5+Pgx1atITg7KX67cDxu7c5dKl/kKaamVnmKSZnAvoix7HEQpNkJz93C53Xs6173d+2+1BQC7D3i5/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367882; c=relaxed/simple;
	bh=sKDSDgj1kGBgjomj0UbaT2tUGzKQnmCyQ4i1nO3un0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lfJ5YEbHoM4IHPionPA5QsSJ8kGVtLMbfrdVDshXgP2KWPc1Fnz8rDi6gN0+X8qYFC7sjXK2eNkc+UF7/hesyIk67GrhAJkq+Oiiu++EyitHdvCNIqze49IoF6ZqWDzJBPHgBau3/9OYcWxy4MRz4crhZ8chyT5t4dbKjnhjQlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ndHZNIOH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ndHZNIOH"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L2OkDD3535366;
	Thu, 21 May 2026 12:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=a29WHK
	pShOg/JVIZtUZDr6ztAFdJZEzJUluVFVxVQMk=; b=ndHZNIOHeAIkjfTc5Pea4P
	+iMSJdOnr+kx6kq4zxyZqqDMsqW6F94E1R8fnsyEoYQba/Yjmo/NxbGjowEK0Xhj
	L2tpp6tuWOtLfzQj5IlQcmDi19XohOqjEhwxgFlJC/lUMnfqec1Jqja88d/etHfj
	yw+a9Yj7Pg1Eq6D6W0JP1ykGogtacE5UmTfl9/+liLgUjRSNEoJ+AJiG6W5Rz2aJ
	dbQrW7+sVD/iTLT9ViEOpDHCz+s0bTGRBSV113uw3IP8Hb/B9bOi1Yj/nlIJhOi7
	RNQf46cgbSncV1x2VFxt/mAwLYa298ADBYGRRyjmKL/nudBfFpsbVs74nKhzqd8A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hawdqy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 12:51:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LCd3G2007405;
	Thu, 21 May 2026 12:51:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wqcb46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 12:51:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LCpFRv47645170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 12:51:15 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0462E2004D;
	Thu, 21 May 2026 12:51:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCD9620040;
	Thu, 21 May 2026 12:51:14 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 12:51:14 +0000 (GMT)
Message-ID: <d2fd0c5a-a077-4471-abce-2cb80772a46c@linux.ibm.com>
Date: Thu, 21 May 2026 14:51:13 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 12/20] unwind_user/sframe: Add .sframe validation
 option
To: sashiko-reviews@lists.linux.dev, Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc: bpf@vger.kernel.org, Indu Bhagat <ibhagatgnu@gmail.com>
References: <20260520154004.3845823-13-jremus@linux.ibm.com>
 <20260520161541.690781F000E9@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260520161541.690781F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEyNiBTYWx0ZWRfXyB9Qe3aA7YOB
 bYNt7wOlnYjsTCS176MSQZvwOu/H+mJo0xL8cXmwpBgFF8lyPX4w5hi5uMKKOzbxin3f9LC1m0B
 hvrgSTsD2ewjCKXu0b2RHZM0ntybgjyYSEwKQZYXvQFQ1XvUeROdtKzbfL0ZUdJH6cVlXhFcRTP
 wUwdIR5PQogp6UlD7UNFsIWWmD31/Lw+6DeW7sOs72GDMd7hMbcJ94pTwa+M3zpZu9P6seR8UNr
 xvc0L+jtTadTho2myS+a/aoIgZwKskIQh0LeeZGNHgum5zcn1fs58FEnArlfZIO9ItDi8cJw8wL
 e5j2Y3xLBEtNYplk9JyYoIza+uxdQdAFcRTleL45Mw7ddiiwqv+ONUKbiEmcrocirU5T11x62yR
 7CyC28SYXberfLeyF6I1Vn7ZO9xMBQnpFvzj6JgktLtST15CYpbxCV76oBod+f/33HNfSehwSLm
 CWSZ4pVBhlu5a+vbFXQ==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0effc5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=K3T1W5yX-k8T0eC7ESsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: BLdGS2ue3nrWqRwE2_RmWSgfSyNTjGAR
X-Proofpoint-GUID: kMI52J2iJDg6x9ovrtbAUKCoSHjTMv6F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210126

On 5/20/2026 6:15 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] Missing cond_resched() or fatal signal checking in the nested loops of sframe_validate_section() allows an unprivileged local attacker to trigger a CPU soft lockup.
> - [Low] The validation logic in sframe_validate_section() incorrectly rejects a valid .sframe section if the first function is located at virtual address 0.
> 
> Pre-existing issues:
> - [High] sframe_find() handles read failures by calling sframe_remove_section(), which acquires a lock inside NMI or IRQ context, leading to deadlocks or PREEMPT_RT panics.

Ignore.  Stacktracing using SFrame is performed deferred and therefore
never in NMI context.

> --
> 
> commit 07d74be031cf9fade2b9ddd98bfdd8f52c38c2da
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> unwind_user/sframe: Add .sframe validation option
> 
> This commit introduces a debugging feature to optionally validate the
> entire .sframe section upon loading, rather than checking on-demand.
> It uses user_read_access_begin/end to read FDEs and FREs to verify their
> formatting and sorting.
> 
>> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
>> --- a/kernel/unwind/sframe.c
>> +++ b/kernel/unwind/sframe.c

>> +static int sframe_validate_section(struct sframe_section *sec)
>> +{
>> +	unsigned long prev_ip = 0;
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < sec->num_fdes; i++) {
>> +		struct sframe_fre_internal *fre, *prev_fre = NULL;
>> +		unsigned long ip, fre_addr;
>> +		struct sframe_fde_internal fde;
>> +		struct sframe_fre_internal fres[2];
>> +		bool which = false;
>> +		unsigned int j;
>> +		int ret;
>> +
>> +		ret = safe_read_fde(sec, i, &fde);
>> +		if (ret) {
>> +			dbg_sec("safe_read_fde(%u) failed\n", i);
>> +			return ret;
>> +		}
>> +
>> +		ip = fde.func_addr;
>> +		if (ip <= prev_ip) {
> 
> [Severity: Low]
> Does this check accidentally reject valid sections where the first
> function is located at virtual address 0?
> 
> Since prev_ip is initialized to 0, validating the first FDE when ip is 0
> will cause this check to evaluate to true, falsely triggering an -EINVAL.
> 
> Valid executables can map their text section at 0 if vm.mmap_min_addr is
> set to 0.

Valid.  Will fix in next version.

> 
>> +			dbg_sec("FDE %u not sorted\n", i);
>> +			return -EINVAL;
>> +		}
>> +		prev_ip = ip;
>> +
>> +		fre_addr = sec->fres_start + fde.fres_off;
>> +		for (j = 0; j < fde.fres_num; j++) {
> [ ... ]

Will also replace the alternation between two FREs with a simple
prev_ip_off variable:

>> +			fre_addr += fre->size;
>> +
>> +			if (prev_fre && fre->ip_off <= prev_fre->ip_off) {

			if (j && fre.ip_off <= prev_ip_off) {

>> +				dbg_sec("FDE %u: FRE %u not sorted\n", i, j);
>> +				return -EINVAL;
>> +			}
>> +
>> +			prev_fre = fre;

			prev_ip_off = fre.ip_off;

>> +		}
> 
> [Severity: High]
> Could a malicious user exploit these loops to trigger a CPU soft lockup?
> 
> The variables sec->num_fdes and fde.fres_num are user-controlled and
> bounded only by the VMA size.
> 
> Without a cond_resched() or fatal signal check, an attacker could supply
> large counts and cause these loops to run for seconds without yielding.
> 
> On non-preemptible kernels, this monopolizes the CPU and triggers the soft
> lockup watchdog, resulting in a local denial of service.

cond_resched() is not required according to v14 review feedback from
Steven.

> 
>> +	}
>> +
>> +	return 0;
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

