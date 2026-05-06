Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3889F4779B9;
	Wed,  6 May 2026 13:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074945; cv=none; b=D3ZXe8hc45me/2tTLKoXm0UyKsPf3MedNxNpidMAdkGCLGpTmpT0quKxT2uLVT4Z162IFZvtRQEClivdEfDQj1zrtsetRPLY66ckznNrlM1zrwNByJCHa85Z5zr6/DQ+wXI/uMkD+zdMIYJsIA909j2mzuuGgazSqmUa5EYQ6Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074945; c=relaxed/simple;
	bh=XjJt4MMiRneSTZZ6NdJgHvj44kR4uurKFf9SIauftKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P1xJWZRtxCZsDzI6cJC52+p/XlWLEgvZI3jkJFey+pkXye14QpQACijhZiYS2sGOh4ZGSGhA7960kuk9G0D30n5Hum2IzLOrn4iJ/WNCxLxB0OuYpkEAmEcL176woUdqRwzeih4HFD8H/9/aUjDcA8dFNtt6evvTw5ym0iLilGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tdrB7WbH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tdrB7WbH"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646B4p632210426;
	Wed, 6 May 2026 13:42:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Uvy47b
	2CJY1t+DIcurbHCRix+0waFmJr2FYMuBH0/oE=; b=tdrB7WbHhfs3PmRupMHd+m
	zDTakINT8qvjFuoTZFAKNPk5F0dDS+33iFZo5nEDeWDf5NYPZXpt+dnFIX01AA3n
	C7YNpuukaNwx2PtBmrazw+T314TZeHsI6CEAmvQjn1PE75Hvz0S7ywXEDc23RINH
	uD7Isv8qvS+CUmLzkGVSE0pSfusKNb6NNM5GYK0FQgYy9OHduBetL5bKWldvB6ea
	M/RvktgNIT7STgFo2Ru8n/WqkXr5CSPb7Wqb1QGE2p4QA4tFvyJRum5Tpr08R3o1
	f6T+zsIHKMHijgjG7LK/M/uFFV9S33p54ytuXjS92ZKdz7tEDpW1SfNLaL0EpWyA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1gx1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 13:42:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646DdZxn007576;
	Wed, 6 May 2026 13:42:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtge8a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 13:42:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646DgGEs50856380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 13:42:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A53C120043;
	Wed,  6 May 2026 13:42:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8369D20040;
	Wed,  6 May 2026 13:42:16 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 13:42:16 +0000 (GMT)
Message-ID: <f106e4a1-4f60-4c65-97bc-2257005765e5@linux.ibm.com>
Date: Wed, 6 May 2026 15:42:16 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 02/19] unwind_user/sframe: Add support for reading
 .sframe headers
To: Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>,
        Indu Bhagat <ibhagatgnu@gmail.com>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev
References: <20260505121718.3572346-3-jremus@linux.ibm.com>
 <20260505124948.669E2C2BCB4@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260505124948.669E2C2BCB4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: u63sPowX08cZjLfRc8HYO0aZzJiZvLVK
X-Proofpoint-GUID: _y2Q5mmT00oMzphCrb6X7uL8BgPI6OJu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzNCBTYWx0ZWRfX515t7tDsKe91
 XlTmSkftQMI8X/5oyGwxPLzwoSws5zQ+7I8njjmQgHGturkojm2US+gysl71ytnbSyoeNldPABQ
 Q3TAlTJ2P8vM2Bpy/f3ViNkoR9r7lUWuMR5lgnIHfwFjk/xIxf68D/eHoVHiuHAuJrG1JABQTll
 G7MXwRhCI0YoIT0Pk0ab1S2Mks9veP3bZty0jp0MbkIWRDUZ+N4K4fEzYLj54MBmEKfUApYlmBe
 B/e/YiEF1B2oc7gfhX5quFACucC1ZGKT2wmOKQ37VWscbLJo3jSuE/KPsjLOunbm/IttZ1ru8ES
 ab8vUdBVJBfUH3yDnexMoooOBv8cWnhvLiNS+5/M0JmNaK9zJuQ+R6fCaYfO0SDXrwgPulvMEM0
 ODnC7ci5vAcdB6+7qYI6tbRdu4KnzevUmb3cBH1CS7yQ2SqmJv51yv/QjIAd3oiJHRGkaWKttEw
 upVcfbGEIonNVSpCGYg==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fb453b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ADBILDl3CrY6QJhYfcwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060134

On 5/5/2026 2:49 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Medium] Missing validation of shdr.abi_arch allows parsing SFrame data from mismatched architectures.
> - [Medium] VMA addresses are incorrectly evaluated as boolean flags to check for zero-length inputs.
> - [Low] Mixing goto error handling with scoped_guard scope-based cleanup.
> --
> 
> commit afe7c9eb6f0e6fc3f73d0b6a555f8d3926cf6ccf
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> unwind_user/sframe: Add support for reading .sframe headers
> 
> This commit introduces basic infrastructure for unwinding user space stacks
> with SFrame. It adds support for parsing the .sframe section header.
> 
> Link: https://lore.kernel.org/all/f27e8463783febfa0dabb0432a3dd6be8ad98412.1737511963.git.jpoimboe@kernel.org/
> 
>> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
>> new file mode 100644
>> index 0000000000000..c128c1eeaca20
>> --- /dev/null
>> +++ b/kernel/unwind/sframe.c
> [ ... ]
>> +static int sframe_read_header(struct sframe_section *sec)
>> +{
>> +	unsigned long header_end, fdes_start, fdes_end, fres_start, fres_end;
>> +	struct sframe_header shdr;
>> +	unsigned int num_fdes;
>> +
>> +	if (copy_from_user(&shdr, (void __user *)sec->sframe_start, sizeof(shdr))) {
>> +		dbg("header usercopy failed\n");
>> +		return -EFAULT;
>> +	}
>> +
>> +	if (shdr.preamble.magic != SFRAME_MAGIC ||
>> +	    shdr.preamble.version != SFRAME_VERSION_3 ||
>> +	    !(shdr.preamble.flags & SFRAME_F_FDE_SORTED) ||
>> +	    !(shdr.preamble.flags & SFRAME_F_FDE_FUNC_START_PCREL) ||

	    shdr.abi_arch != sframe_abi_arch() ||

>> +	    shdr.auxhdr_len) {
>> +		dbg("bad/unsupported sframe header\n");
>> +		return -EINVAL;
>> +	}
> 
> Should we also validate shdr.abi_arch to ensure it matches the expected
> architecture?
> 
> If malformed or foreign-architecture SFrame data is passed in (for instance,
> with an unexpected endianness or register mapping), the kernel might interpret
> it incorrectly and generate invalid stack traces.
> 
> Furthermore, accepting arbitrary values here could risk ABI calcification if
> userspace starts supplying invalid values that we later want to reject.

I could introduce an architecture-specific sframe_abi_arch() and update
the SFrame header validation as above.  For x86 the implementation in
in unwind_user_sframe.h could look as follows:

#ifdef CONFIG_X86_64
#define sframe_abi_arch()	SFRAME_ABI_AMD64_ENDIAN_LITTLE
#endif

Given sframe.o is only linked in if CONFIG_HAVE_UNWIND_USER_SFRAME and
that is only selected if X86_64 this should be fine.

Do you see any value?

> [ ... ]
>> +int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
>> +		       unsigned long text_start, unsigned long text_end)
>> +{
>> +	struct vm_area_struct *sframe_vma, *text_vma;
>> +	struct mm_struct *mm = current->mm;
>> +	struct sframe_section *sec;
>> +	int ret;
>> +
>> +	if (!sframe_start || !sframe_end || !text_start || !text_end) {

	if (sframe_start >= sframe_end || text_start >= text_end) {
		dbg("invalid sframe/text address\n");

Do you agree?

> Is it safe to use VMA start addresses as boolean flags?
> 
> Since vm_start can legitimately be zero in certain configurations (if
> mmap_min_addr permits), evaluating !sframe_start or !text_start could
> incorrectly reject perfectly valid mappings at address 0.
> 
> Also, to check for zero-length sections, would it be better to explicitly use
> comparisons like sframe_start >= sframe_end instead?
> 
>> +		dbg("zero-length sframe/text address\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	scoped_guard(mmap_read_lock, mm) {
> [ ... ]
>> +	sec = kzalloc(sizeof(*sec), GFP_KERNEL);
>> +	if (!sec)
>> +		return -ENOMEM;
>> +
>> +	sec->sframe_start	= sframe_start;
>> +	sec->sframe_end		= sframe_end;
>> +	sec->text_start		= text_start;
>> +	sec->text_end		= text_end;
>> +
>> +	ret = sframe_read_header(sec);
>> +	if (ret)
>> +		goto err_free;
> 
> Is it acceptable to mix goto error handling with scoped_guard() cleanup
> helpers in the same function?
> 
> The kernel's cleanup subsystem guidelines generally suggest that usage of
> goto and cleanup helpers shouldn't be mixed in the same routine.

This references to the following comment in include/linux/cleanup.h:

  Lastly, given that the benefit of cleanup helpers is removal of
  "goto", and that the "goto" statement can jump between scopes, the
  expectation is that usage of "goto" and cleanup helpers is never
  mixed in the same function. I.e. for a given routine, convert all
  resources that need a "goto" cleanup to scope-based cleanup, or
  convert none of them.

> 
> Could sec be allocated using __free(kfree) to avoid the goto entirely?

The goto error handling is used outside the scoped_guard().  So I think
it is fine.  Do you see any value in converting it as follows (my naive
attempt):

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
@@ -722,13 +722,14 @@ static int sframe_read_header(struct sframe_section *sec)
        return 0;
 }

+DEFINE_FREE(free_section, struct sframe_section *, if (_T) free_section(_T))
 int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
                       unsigned long text_start, unsigned long text_end)
 {
        struct maple_tree *sframe_mt = &current->mm->sframe_mt;
        struct vm_area_struct *sframe_vma, *text_vma;
        struct mm_struct *mm = current->mm;
-       struct sframe_section *sec;
+       struct sframe_section *sec __free(free_section) = NULL;
        int ret;

        if (sframe_start >= sframe_end || text_start >= text_end) {
@@ -768,7 +769,7 @@ int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
        ret = sframe_read_header(sec);
        if (ret) {
                dbg_print_header(sec);
-               goto err_free;
+               return ret;
        }

        ret = sframe_validate_section(sec);
@@ -784,10 +785,6 @@ int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
        }

        return 0;
-
-err_free:
-       free_section(sec);
-       return ret;
 }

> 
>> +
>> +	/* TODO nowhere to store it yet - just free it and return an error */
>> +	ret = -ENOSYS;
>> +
>> +err_free:
>> +	free_section(sec);
>> +	return ret;
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

