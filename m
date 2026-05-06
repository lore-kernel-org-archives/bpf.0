Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6EE48032C;
	Wed,  6 May 2026 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778078082; cv=none; b=c4tN0H48W/7rQ89VuhAfiTk/iODFoL7wcK9TBhzAhGh0nWS7nF2w3j+e33ezVw72EhNp2tYe8FvtnxEkHHCYDzW5m0N992rtC/H7BDsdAAkObf3oGFgBHMz+mMJeYCfPzrcCqRcjryTwq4pVtptXvLzxwSuQ5UKZeWceGEpy7WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778078082; c=relaxed/simple;
	bh=nPVEK2Trvf0Tsi9a0wbxOfom+PASPNRDHqCooMzbreY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGlpUWlbsRYW5JL/CNpLowyYmiq/ph6TfRdZKaL9HW/htGNGekHHpRX1J6wq59JlzrrlNdYvpQnTw0spvTtH6Y45UhfDR+dw/48Hc7145lNQ6BnZu78YBCLLtbcdaYIgJ7DWnbzrNauPCTRpEDu8+cDEaqmpsYs0K2cbk4dlFMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j9suFeK+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j9suFeK+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6463vfgO1430407;
	Wed, 6 May 2026 14:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3U4ILp
	+R7Tp81JQEhYQFx48Xxa305v1U04YgkcSOfiA=; b=j9suFeK+nZzL4unM7w5T4H
	F0URvWWT/2Psv8LzHmdEN3AnMCQe865YyZ8YbOUHg6AefsY9QJqmkSQ37IJy8KzO
	gWLexc+zkZxdRSxTYXwnMISWl8RZbk8IcHFeHCnpok5JrG4JljLYqY7LJO2mEVj7
	rMGTqpJZtr9hAwN4DRhdSzFZz0Dwqzl3U7ixWFEwVo7paw58Mi2UaQ54l/MsMKiH
	Bk71qFPHT9NKgAUpwnCwFcJFtdGr+5Eun0rV4vQPOsv916qA/GZmlAK/mV1eH+DN
	lXQ+LSxT0TwXmkXBP8V7iNf/NYLDDSISqexyZEhb4sV325zh1Nd4vTbEy+O3lBlg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxredx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 14:34:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646EOfLK025530;
	Wed, 6 May 2026 14:34:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukqet6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 14:34:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646EYY0U50135340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 14:34:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9138920043;
	Wed,  6 May 2026 14:34:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CD1F20040;
	Wed,  6 May 2026 14:34:34 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 14:34:34 +0000 (GMT)
Message-ID: <4e5d51f0-8f4c-4a07-9141-8b26d2c90fc6@linux.ibm.com>
Date: Wed, 6 May 2026 16:34:34 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 05/19] unwind_user/sframe: Add support for reading
 .sframe contents
To: Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>,
        Indu Bhagat <ibhagatgnu@gmail.com>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev
References: <20260505121718.3572346-6-jremus@linux.ibm.com>
 <20260505185932.C708CC2BCB4@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260505185932.C708CC2BCB4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzOSBTYWx0ZWRfX+XMJN3AltjSa
 wwmBByaGALRn9y2jM0i7aSNWDXGGf3A+l1qx+PPZ4bLk58yVnXGM0ra4r76W9N8zECmJEaVt3gd
 XgW3jK3TC/4Eer1lps9Sfdkdx/RtwkIoIIIvVES58iV6uYaRNce4Vwqd4zRuIMti9Z6WHlfdXCl
 fZcdTtP0y3hyrKk99xLK+MvA8evgMyj+Mqw/+Jf6v9J5tTfPSA/Q3MS4xhwia4HZqtBvCeyNIli
 su5ds36f4POTKVJEPLeDR9SGqquJqTB8AWpUjrgpg9f69chd6tiw9zhffxieZ73VI5WyskGs/Qs
 diDkpMBnN5UP2huRp9z3Gx4k01iIVUwyS+DgkHCnWNKjB9DBFQUryxn0IKSuvEsJkbsErG8tyC5
 gfdXTOQ5WNTDvOckdT5zcIPLez7cgJiUNq1juVg1j2lpKEL5MDEbAN4TPvXsEdAFORxjKn6GVa4
 3yeeAytC2b1buNN75ow==
X-Proofpoint-ORIG-GUID: eNup6MJNaxfsQWmNSX-f5cPPcETHrEpZ
X-Proofpoint-GUID: t5oP0p8aeRn8VpDpCi0AecaAQOe4xP0B
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fb517d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=YuDcBBqGAAAA:8 a=Rvwh-eWpcrEG-nYCzoQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=V9_jqlfyBUA7Gw2gN5zN:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060139

On 5/5/2026 8:59 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [Critical] Division by zero in `__find_fre` when `fde->rep_size` is 0.
> - [High] `mtree_insert_range` is called with an exclusive end boundary, preventing contiguous SFrame sections.
> - [High] Unbounded linear search over user-controlled memory in `__find_fre` can cause hard lockups in atomic context.
> - [High] Integer overflows in SFrame header parsing allow bypass of bounds checks on 32-bit architectures.
> - [Medium] Generic SFrame unwinding code uses `unsafe_get_user()` for unaligned accesses, breaking strict-alignment architectures.
> --
> 
> commit 159c92acf3c961aecc6383f6c3f35a955591abf3
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> unwind_user/sframe: Add support for reading .sframe contents
> 
> This commit adds support for reading .sframe section contents to facilitate
> user space stack unwinding. It introduces the sframe_find() interface which
> uses user_read_access_begin() and unsafe_*() accessors for performance.
> Support is included for SFrame V3, internal FDE representations, and
> PC-relative offsets.
> 
> Link: https://lore.kernel.org/all/77c0d1ec143bf2a53d66c4ecb190e7e0a576fbfd.1737511963.git.jpoimboe@kernel.org/
> Link: https://lore.kernel.org/all/b35ca3a3-8de5-4d32-8d30-d4e562f6b0de@linux.ibm.com/
> 
>> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
>> index fdb2a49085638..c60aa527984a1 100644
>> --- a/kernel/unwind/sframe.c
>> +++ b/kernel/unwind/sframe.c
>> @@ -15,9 +15,338 @@
>>  #include <linux/unwind_user_types.h>
>>  
>>  #include "sframe.h"
>> +#include "sframe_debug.h"
> 
> [ ... ]
> 
>> +static __always_inline int __read_fre(struct sframe_section *sec,
>> +				      struct sframe_fde_internal *fde,
>> +				      unsigned long fre_addr,
>> +				      struct sframe_fre_internal *fre)
>> +{
> [ ... ]
>> +	if (fre_addr + addr_size + 1 > sec->fres_end)
>> +		return -EFAULT;
>> +
>> +	UNSAFE_GET_USER_INC(ip_off, cur, addr_size, Efault);
> 
> Will this cause alignment faults on architectures with strict alignment
> requirements?
> 
> The .sframe format uses packed structures and variable-length datawords. The
> cur pointer might be unaligned here, and UNSAFE_GET_USER_INC() performs
> 16-bit or 32-bit reads via unsafe_get_user().

IIUC this should not be an issue for x86-64, s390, and arm64.

> [ ... ]
> 
>> +static __always_inline int __find_fre(struct sframe_section *sec,
>> +				      struct sframe_fde_internal *fde,
>> +				      unsigned long ip,
>> +				      struct unwind_user_frame *frame)
>> +{
>> +	unsigned char fde_pctype = SFRAME_V3_FDE_PCTYPE(fde->info);
>> +	struct sframe_fre_internal *fre, *prev_fre = NULL;
>> +	struct sframe_fre_internal fres[2];
>> +	unsigned long fre_addr;
>> +	bool which = false;
>> +	unsigned int i;
>> +	u32 ip_off;
>> +
>> +	ip_off = ip - fde->func_addr;
>> +
>> +	if (fde_pctype == SFRAME_FDE_PCTYPE_MASK)
>> +		ip_off %= fde->rep_size;
> 
> Can a malicious user provide an SFrame section with a rep_size of 0?
> 
> Since fde->rep_size is populated directly from the user-provided
> _fda.rep_size without validation, a 0 value here would trigger a
> divide-by-zero exception and a kernel panic.

Good catch!  I would add a check in __read_fde():

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
@@ -67,6 +67,7 @@ static __always_inline int __read_fde(struct sframe_section *sec,
        unsigned long fde_addr, fda_addr, func_addr;
        struct sframe_fde_v3 _fde;
        struct sframe_fda_v3 _fda;
+       unsigned char fde_pctype;

        fde_addr = sec->fdes_start + (fde_num * sizeof(struct sframe_fde_v3));
        unsafe_copy_from_user(&_fde, (void __user *)fde_addr,
@@ -82,6 +83,10 @@ static __always_inline int __read_fde(struct sframe_section *sec,
        unsafe_copy_from_user(&_fda, (void __user *)fda_addr,
                              sizeof(struct sframe_fda_v3), Efault);

+       fde_pctype = SFRAME_V3_FDE_PCTYPE(_fda.info);
+       if (fde_pctype == SFRAME_FDE_PCTYPE_MASK && !_fda.rep_size)
+               return -EINVAL;
+
        fde->func_addr  = func_addr;
        fde->func_size  = _fde.func_size;
        fde->fda_off    = _fde.fres_off;

> 
>> +
>> +	fre_addr = sec->fres_start + fde->fres_off;
>> +
>> +	for (i = 0; i < fde->fres_num; i++) {
> 
> Can this loop cause a hard lockup in atomic context?
> 
> fde->fres_num is a 32-bit value copied from user space without validation.
> Since sframe_find() is designed to be called by unwinders in NMI context, an
> attacker could provide a very large number of valid entries. Executing
> billions of iterations and unsafe_get_user() calls could stall the CPU
> and trigger the hard lockup detector.

Please advise.

> 
>> +		int ret;
>> +
> 
> [ ... ]
> 
>> @@ -120,8 +449,10 @@ int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
>>  	sec->text_end		= text_end;
>>  
>>  	ret = sframe_read_header(sec);
>> -	if (ret)
>> +	if (ret) {
>> +		dbg_print_header(sec);
>>  		goto err_free;
>> +	}
> 
> Can shdr.fre_len cause an integer overflow on 32-bit architectures during
> header parsing?
> 
> If a malicious user provides a large fre_len in the header, fres_end
> (calculated as fres_start + shdr.fre_len) could wrap around the 32-bit
> address space. This would bypass the bounds check in sframe_read_header(),
> allowing fres_start and fdes_start to point into kernel memory. Later, when
> __read_fde() and __find_fre() use unsafe_get_user(), this could lead to
> arbitrary kernel memory disclosure.

SFrame is currently only supported on 64-bit architectures (i.e. x86-64,
arm64, s390 64-bit).  So unsigned long fres_end should always be 64-bit.
Do we need to add the following to the header parsing?

if (fdes_start >= fdes_end || fres_start >= fres_end) {
	dbg_sec("inconsistent FDE/FRE start/end address\n");
	return -EINVAL;
}

> 
>>  
>>  	ret = mtree_insert_range(sframe_mt, sec->text_start, sec->text_end, sec, GFP_KERNEL);
> 
> Does passing sec->text_end directly as the last parameter to
> mtree_insert_range() break contiguous mappings?
> 
> mtree_insert_range() expects the last boundary to be inclusive, but
> sec->text_end represents the exclusive end address of the executable segment.
> If user space maps seamlessly contiguous text segments, the insertion for the
> second segment might overlap with the claimed end of the first, causing it to
> fail with -EEXIST.

Addressed in previous patch.

> 
>>  	if (ret) {
>>  		dbg("mtree_insert_range failed: text=%lx-%lx\n",
> 

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

