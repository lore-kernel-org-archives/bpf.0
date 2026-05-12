Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C993C5836;
	Tue, 12 May 2026 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601187; cv=none; b=pjppP+jr/kblo6FeE8ppc2t9Nf8L4wto/SC2DosWvpAqIWZdxAUVtMoTUgyvasB4u4SC40B88qZdKOs2h8FY/BJ0L4616MOVMwoRWYJyGBY6Z4+MVwrX0RSpqAxBKp0hqeaDcc8T0aPBYKhmWsPvtXTu8udV6cHPlQeMyqrLoS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601187; c=relaxed/simple;
	bh=6h1PmebQ4gC5kwBY+VHZyFvTuatm4tGgQawMKNpJDv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bci4sPHGP754TRKO3cqcOAcg/s+2sPeixeStrzqKvQ/Vaa+k4sNJP+SzC86SRHv95U6McUM8cqMuwPTjSE5Ak4BgFP2F8/W+5q7HawfP/uzA3QrgKPEo5Qo9gWRkj76bWtym8JpXK2Ss73YBbC1Q391WCpmvXOH7pkouGZi/WZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VwrGEcVi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VwrGEcVi"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CCiukE2760182;
	Tue, 12 May 2026 15:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IOzakD
	+PiSzcdRzArJxoCalB/4gSl8M/qYcaEAZmRSA=; b=VwrGEcViqBTOUiP4EyHVi5
	Sha7cakL7MZKXU1CnYB1FQxvdGR3N1ffXcnBNnRKs4ZZqmQJuo0G2m32acuxHYd1
	/50EI5WGk0AJyolwx4IfMFrkh0kJRr5vHNnIDNMfl5GBPkfklNsTquZ8yskCIhNX
	9sZaln7X0Bh6Sd+9zjROaW6Jb/fzbSut+2TmVffBI+WAzWvbw7iQR7M9+cdkfhwM
	I0Cyz4aH8YabL7SXhMGsMrK7mQlSjpbM/nrX0V4iWJ+IE9TXEGzblgJsgBaXKbp7
	NBvFIqoqzeuZ+jWaFpHVHGNIifXJvPAS1YMNrNTm4FNPCsvB+8+3qWz2vIkQF7Iw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6kp22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 15:53:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CFdg9Y031207;
	Tue, 12 May 2026 15:53:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgksmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 15:53:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64CFr0PT48038392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 15:53:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 149DF2004D;
	Tue, 12 May 2026 15:53:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA9C220040;
	Tue, 12 May 2026 15:52:59 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 15:52:59 +0000 (GMT)
Message-ID: <358d8d2a-e604-418d-8245-36ee0413f190@linux.ibm.com>
Date: Tue, 12 May 2026 17:52:58 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 03/19] unwind_user/sframe: Store .sframe section data
 in per-mm maple tree
To: Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev,
        Indu Bhagat <ibhagatgnu@gmail.com>, Heiko Carstens <hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Oof1CxiRXoDWimNDX0N7JfC0FH_nvDTS
X-Proofpoint-GUID: NI-MO8iQraRhssxeA0txhc-HWZLyehrd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE2MyBTYWx0ZWRfXw0qBy3UKf2Nc
 vK4lwUs4IzN8Ks2ZlaGiDxq3+oWmJWx9Mn85FmNGbm6zNmYJ+qBtHswwLs1orXTOcq9QO8UIsjQ
 4O2MuiOgKvFUDSeAejjIBE+IwIxIKUHfa4wB72zSMYiCqGtWgkqhA2O4reviLg3eC5cXbtp1vZF
 U2f5awpoWrGnvn/wgbYud6+Ib5IJaSJxPvhbT1bJ7tvSNODPG6O8SybiE3aLYnhYQfT4XIbn5Kr
 Agaa0lslUtrT37fjRf9xiTs9kF7Evvm6NywjrFLBm3s4kuPkyVNdfNdyOdWF6G6uPdeq1R2bBpF
 J9NFWv++V9TOQos2VLJku8bMCMuz81MlqqNNTXlfWFSbPhiZNaR22Y5Of34cxBe79i+Z4iDeuWM
 tKOlOsCD6v+tnYy9SDJL5Qw5lL+CEI5yycTp7YGPmiJQL16CFg4OvSpvMpTF4OMIdwEdnJ20BAk
 A6Ye0cBV+QWXDhdDp4w==
X-Authority-Analysis: v=2.4 cv=P8UKQCAu c=1 sm=1 tr=0 ts=6a034cdf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=d2iCtUAqFsupRfna_mMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120163

On 5/6/2026 5:21 PM, Steven Rostedt wrote:
> On Wed, 6 May 2026 15:50:45 +0200
> Jens Remus <jremus@linux.ibm.com> wrote:

>>>> +static int __sframe_remove_section(struct mm_struct *mm,
>>>> +				   struct sframe_section *sec)
>>>> +{
>>>> +	if (!mtree_erase(&mm->sframe_mt, sec->text_start)) {
>>>> +		dbg("mtree_erase failed: text=%lx\n", sec->text_start);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	free_section(sec);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>  int sframe_remove_section(unsigned long sframe_start)
>>>>  {
>>>> -	return -ENOSYS;
>>>> +	struct mm_struct *mm = current->mm;
>>>> +	struct sframe_section *sec;
>>>> +	unsigned long index = 0;
>>>> +	bool found = false;
>>>> +	int ret = 0;

	guard(srcu)(&sframe_srcu);

>>>> +
>>>> +	mt_for_each(&mm->sframe_mt, sec, index, ULONG_MAX) {
>>>> +		if (sec->sframe_start == sframe_start) {  
>>>
>>> Can concurrent calls to sframe_remove_section() cause a use-after-free and
>>> subsequent double free?
>>>
>>> mt_for_each() locklessly iterates mm->sframe_mt, and internally acquires and
>>> drops the RCU read lock, meaning the returned sec pointer has no lifetime
>>> protection in the loop body.
>>>
>>> If two threads concurrently invoke sframe_remove_section(), both could
>>> receive the exact same sec pointer from the tree. Thread A could then call
>>> __sframe_remove_section(), erasing the entry and freeing sec via
>>> free_section(). Thread B would then evaluate the if statement using the
>>> freed sec pointer, causing a use-after-free read, and potentially proceeding
>>> to free it again.  
>>
>> Please advise.
> 
> I guess it's asking if we should have a read_srcu_lock()?

Given __sframe_remove_section() does not schedule freeing of the section
and returns with -EINVAL if mtree_erase() fails there is no possibility
for a double-free.  Only one thread can succeed to mtree_erase().

Above change ensures that if two threads concurrently iterate the
sframe_mt in sframe_remove_section() they can both safely access
sec->sframe_start, as none of the sections will get freed until
return from sframe_remove_section().

Does that make sense?

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

