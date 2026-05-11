Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC1B378826;
	Mon, 11 May 2026 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778493936; cv=none; b=Yf3dYFlINoG9glUulfTlnHwGQi5PinhgkLKPpVbz67WcBZK9CH5eKYzm6PeoNy9qLNJYvlo3ZU+STs1aysMzxQrOo3GgSsJBY8pg4Twj8jzaN9wuLPQMVwJ1Khd1IZGQ90EaI0uDe4N2bTqXVoaKWR86ak6oX7ojJeDeit2sQLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778493936; c=relaxed/simple;
	bh=JjQsZXL5lCvaLFgQRbb6uZNFflglWFxp9aFH5F4C/QU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PBbR9Nr74mcxxBs9DMNH0Ijh5zQQvz+4AlANEhGmXgZKCqnT5OMQDcfKvhI6FvjA7glsL4eIbK1hsw2aBYbRV14tXx15P1oSIrKqeXX58/2tCj/K03VJcFm7rOI27j+IMxlKeKFWMfULXDztM5T5IP69oS8hsFQcb7lSnFOoRzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kLoUpXja; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kLoUpXja"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B7P5qe2514984;
	Mon, 11 May 2026 10:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eEq89B
	a+z2i76yq5Q8rXh82J04RT9WAiGk2x2cvZ50E=; b=kLoUpXjaByRDBqnCUjm0bC
	qsW0Q/o//Dcp2OZ4o0Ndq0hgIqVbnFA3tHVRKCulF7QhmdGoGVDDx9i/e0FZoe1Q
	uBXknWUweGWtYo3sUARZolchagbXOhMxTgO+IZl3g0U2p+4x0DCMjKaeSep+k+Iw
	k5pul5OuvJVtkwE5Y3LGyGsUWcyx+5wV1p/WVug7jn/m9waO2FjbY2mYBXVULSXg
	WLoiw374fCTlVgyPW7xGRmwZujFwgZIhLDS2nmyn/R/192VTSNzZjsEYZiYfqE0X
	GjK3tmSaGwzDxIUrjJXYBrV8Jkz6D4wHxG5V8ZBy9Fqpu5W2dBGlfUaVHbNQBs8g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1tbhqdfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 10:05:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64B9hB2b017649;
	Mon, 11 May 2026 10:05:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2hxy4g2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 10:05:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64BA5S1k44368344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 10:05:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 633972006B;
	Mon, 11 May 2026 10:05:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B71C20067;
	Mon, 11 May 2026 10:05:28 +0000 (GMT)
Received: from [9.111.205.47] (unknown [9.111.205.47])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 10:05:28 +0000 (GMT)
Message-ID: <5b05d165-0c8d-4e37-8cc1-589c5f04b0f4@linux.ibm.com>
Date: Mon, 11 May 2026 12:05:27 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 02/19] unwind_user/sframe: Add support for reading
 .sframe headers
To: Indu Bhagat <ibhagatgnu@gmail.com>, Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev
References: <20260505121718.3572346-3-jremus@linux.ibm.com>
 <20260505124948.669E2C2BCB4@smtp.kernel.org>
 <f106e4a1-4f60-4c65-97bc-2257005765e5@linux.ibm.com>
 <68676204-ba32-446d-a0fd-c2f39cea775e@gmail.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <68676204-ba32-446d-a0fd-c2f39cea775e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ZdQt8MVA c=1 sm=1 tr=0 ts=6a01a9eb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=K-j2ccP4JMExiSf2CMQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fnMSU_Ruzrxfzss7IDqBX0WdMs2KvBCt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEwNSBTYWx0ZWRfX8Qd9DtcKe78I
 wgecsua8voKV5CVfsobXMIyV2Ch6GcQ9v4kNGhgremLZ/0DrRXxSFX+m+r5CekYP/RTv725MOST
 dGWIoLF4ToZ5X4UpIkU78H3vmeUqIHhaB10GWpDamXVmLt0xSrDuXwt6ysSBO/OfAPxSJwhzGTM
 ZinLbiLA3xIlH/inmoHm3TzcaZog0GcE/Civ/MBzBNl5tRdeFfNknkvUDcuP6iYoGXMXUlLJgFq
 7ps2FYfS3yqObj0awHqdYDXHcnYrAzdEhvLaJWj0w2+cmb5T9i0KjvrW/qqtGLiFru3vmegFrwg
 WOiJD9K0rq4exh90vEjFEloipTxy7LqT1ClbSbATY5X5uPpLmR7xIGS5ZTUQ2l/Ds/gHOG/OwMr
 /6bEMo4M7+LH6e1U8cF0GVWukdfZJOL6w1+2lUcqBZk3lqwQFT+uB/9T30zC62VhCbPCSIhA5ht
 9XHe54i4dVJTY8jx/HA==
X-Proofpoint-GUID: 7RLR5uGhl6fe8VrrMKmoS9j1W1A77BS3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110105

On 5/9/2026 1:02 AM, Indu Bhagat wrote:
> On 2026-05-06 06:42, Jens Remus wrote:
>> On 5/5/2026 2:49 PM,sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>>> - [Medium] Missing validation of shdr.abi_arch allows parsing SFrame data from mismatched architectures.
>>> - [Medium] VMA addresses are incorrectly evaluated as boolean flags to check for zero-length inputs.
>>> - [Low] Mixing goto error handling with scoped_guard scope-based cleanup.
>>> -- 
>>>
>>> commit afe7c9eb6f0e6fc3f73d0b6a555f8d3926cf6ccf
>>> Author: Josh Poimboeuf<jpoimboe@kernel.org>
>>>
>>> unwind_user/sframe: Add support for reading .sframe headers
>>>
>>> This commit introduces basic infrastructure for unwinding user space stacks
>>> with SFrame. It adds support for parsing the .sframe section header.
>>>
>>> Link:https://lore.kernel.org/all/ f27e8463783febfa0dabb0432a3dd6be8ad98412.1737511963.git.jpoimboe@kernel.org/
>>>
>>>> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
>>>> new file mode 100644
>>>> index 0000000000000..c128c1eeaca20
>>>> --- /dev/null
>>>> +++ b/kernel/unwind/sframe.c
>>> [ ... ]
>>>> +static int sframe_read_header(struct sframe_section *sec)
>>>> +{
>>>> +    unsigned long header_end, fdes_start, fdes_end, fres_start, fres_end;
>>>> +    struct sframe_header shdr;
>>>> +    unsigned int num_fdes;
>>>> +
>>>> +    if (copy_from_user(&shdr, (void __user *)sec->sframe_start, sizeof(shdr))) {
>>>> +        dbg("header usercopy failed\n");
>>>> +        return -EFAULT;
>>>> +    }
>>>> +
>>>> +    if (shdr.preamble.magic != SFRAME_MAGIC ||
>>>> +        shdr.preamble.version != SFRAME_VERSION_3 ||
>>>> +        !(shdr.preamble.flags & SFRAME_F_FDE_SORTED) ||
>>>> +        !(shdr.preamble.flags & SFRAME_F_FDE_FUNC_START_PCREL) ||
>>         shdr.abi_arch != sframe_abi_arch() ||
>>
>>>> +        shdr.auxhdr_len) {
>>>> +        dbg("bad/unsupported sframe header\n");
>>>> +        return -EINVAL;
>>>> +    }
>>> Should we also validate shdr.abi_arch to ensure it matches the expected
>>> architecture?
>>>
>>> If malformed or foreign-architecture SFrame data is passed in (for instance,
>>> with an unexpected endianness or register mapping), the kernel might interpret
>>> it incorrectly and generate invalid stack traces.
>>>
>>> Furthermore, accepting arbitrary values here could risk ABI calcification if
>>> userspace starts supplying invalid values that we later want to reject.
>> I could introduce an architecture-specific sframe_abi_arch() and update
>> the SFrame header validation as above.  For x86 the implementation in
>> in unwind_user_sframe.h could look as follows:
>>
>> #ifdef CONFIG_X86_64
>> #define sframe_abi_arch()    SFRAME_ABI_AMD64_ENDIAN_LITTLE
>> #endif
>>
>> Given sframe.o is only linked in if CONFIG_HAVE_UNWIND_USER_SFRAME and
>> that is only selected if X86_64 this should be fine.
>>
>> Do you see any value?
> 
> I dont see much value.  fs/binfmt_elf.c has done some admission control
> for the user binary already.  For bi-endian systems, this doesnt add
> value (wrt checking correct endianness).
> 
> For addressing the concern of a compromised SFrame section, we need to
> ensure checks at SFrame information read/validation time (which the code
> is doing already and additional checks that can be added are currently
> being discussed).  Checking for the abi_arch value does not necessarily safeguard much.

Good point!  I agree to omit validating shdr.abi_arch, given the ELF
architecture and endianness have already been validated.

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

