Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65552372060;
	Tue, 12 May 2026 13:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592917; cv=none; b=WZClUC6Ot5UQwLZE8AsPVE/VC8XymoAtqPn6Mgq2licGxmiSNzxXIDVHrNg23S35plXl2qSC9JjJvX8zKf7fGaj0KQ0R4r9Ll+B3mgpZkC+GsIUCcZkwji4zSubAoEW8wKUX6WbdBci9estU0I74K8QwbSPQzmMLQLTof2GU8TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592917; c=relaxed/simple;
	bh=iQM7EnntvAHBM6X+nTn7rjMEwcwcINlFq8ogCUisEG8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fsV0bjdL6PoZEAniXfZNhD84P6Z7euvKyFdBm14yu+hkJ1qFV+o7IIbC58A2LOtGOs5PDSM1CGYZ69PrE2pE26ev33nbntW0Mulzg/+jGrFgUBy1+ePtkjshY4E8DJUJLnOuZGbFUJqYCVR8kxh6uGY9h4ovIvMbhhYE/xVtqQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=foYkWe6o; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="foYkWe6o"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CBlg493187747;
	Tue, 12 May 2026 13:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kZufSt
	i3gs1q/2WRtK0lrXpp77tfnmxYdCF6VASig5w=; b=foYkWe6oioKFNr+8dmPOZa
	5ACZb8TV576A5OfUXl1CQY1IoQbBAVUR6kRZa85uxlEfMGrg97JkGr9V+4zh6Aqq
	gdepZZT6MKDJOMoYci2b1AvRFKSyiWx33OYpkUycviQhvi09FCilaVhT1k9qPnlS
	NarY+gq3j4rLpZ+4I27Np2Xj8ajHHJrRA22isY6MSKBzdmg39spvwq+77m7Oi5uZ
	0TU8M5DneGdewnPtGABtg4q63yQtNPuZkCmNVoJlUgWOVP9Jv8L1A+5kVGHXUrvm
	bVuW+ee0D8Qmmb2hqamE+2CIpQb7fKraZkst7MmvCRsAVrUJDTcSnRg6sxoAs79w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv5b979-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 13:35:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CDOP1x000445;
	Tue, 12 May 2026 13:35:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgba1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 13:35:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64CDZBHE29557066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 13:35:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0255020043;
	Tue, 12 May 2026 13:35:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7EEB20040;
	Tue, 12 May 2026 13:35:10 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 13:35:10 +0000 (GMT)
Message-ID: <5e7a8a95-fee6-42f7-9c17-a8c1684240ec@linux.ibm.com>
Date: Tue, 12 May 2026 15:35:09 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Remus <jremus@linux.ibm.com>
Subject: Re: [PATCH v14 05/19] unwind_user/sframe: Add support for reading
 .sframe contents
To: Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Indu Bhagat <ibhagatgnu@gmail.com>, bpf@vger.kernel.org,
        sashiko@lists.linux.dev, Heiko Carstens <hca@linux.ibm.com>
References: <20260505121718.3572346-6-jremus@linux.ibm.com>
 <20260505185932.C708CC2BCB4@smtp.kernel.org>
 <4e5d51f0-8f4c-4a07-9141-8b26d2c90fc6@linux.ibm.com>
 <20260506110142.7b2943d7@fedora>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260506110142.7b2943d7@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=cPHQdFeN c=1 sm=1 tr=0 ts=6a032c91 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=2POG_mW8sKFUiricw5gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qqLtYZYgfhGZEYV8snHbYRRLTxfoMe3U
X-Proofpoint-GUID: diAw8CWWhixftnCSkpBB9bYuMnoYP-eU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEzNyBTYWx0ZWRfX3NPFYjxY/51p
 UX0uVf0b++xU2EpzkkhKY2Dc8G05NKVlWXbrBVqVmJJZOj0HmKX6PAJtfpDu69Gai7XGEHxNnuo
 SZtZwI9EjIrhxSrC1pJ1wasf+n0BGrTB83y3UDfsEx5mUHPgP1hpoLtl+6H5BRMK30bypGJnCiN
 ZOa8yBHj7ur6ONPN6uMefyydv3KkqHIJF8X57kU9eujDxw8v/ACJOSmoF0GW11KwqPkoFbFsdEl
 XZYfY4V3ODtcwX4qxMqs+a0XRZGSana/MRLjALE/r9stX2yhmxktSFQNqJvnOxol5kO+e/WWQTE
 lYxOb/3IuZycbRx1Seuux6uI094Gvoe9bQFSXAx1YzLixEJ9KFMTUCl+IaEg1FViDE8rfG/2FbS
 L4gNXMotrgB8cCHs/YMizOtgJKWYjt5s1C0hDB9gtUMrHrbKB/AIL8AkBhoC16KiujvYMr1AMik
 KA/Em1P+jJsUjfkaBEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120137

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

Config option HAVE_EFFICIENT_UNALIGNED_ACCESS seems to be the one that
is used for exactly this purpose.


IIUC config options that get selected should not depend on.  So the
following would not be ok, although it seems to work?

diff --git a/arch/Kconfig b/arch/Kconfig
@@ -495,6 +495,8 @@ config HAVE_UNWIND_USER_FP

 config HAVE_UNWIND_USER_SFRAME
	bool
+	depends on 64BIT
+	depends on HAVE_EFFICIENT_UNALIGNED_ACCESS
	select UNWIND_USER

 config SFRAME_VALIDATION

This would trigger a warning if HAVE_UNWIND_USER_SFRAME is enabled when
64BIT and/or HAVE_EFFICIENT_UNALIGNED_ACCESS are not enabled (disabled
on purpose for testing below):

$ PATH=$HOME/temp/binutils-sframe/bin:$PATH make defconfig W=e
*** Default configuration is based on 'defconfig'

WARNING: unmet direct dependencies detected for HAVE_UNWIND_USER_SFRAME
  Depends on [n]: 64BIT [=y] && HAVE_EFFICIENT_UNALIGNED_ACCESS [=n]
  Selected by [y]:
  - S390 [=y]


Shall I better use BUILD_BUG_ON(!IS_ENABLED(CONFIG_...)) instead?  Would
I add that to all functions that are affected (i.e. __read_fre(),
__read_default_fre_datawords(), and __read_flex_fde_fre_datawords()),
duplicating the build-time error message, or would I better introduce a
dummy function to check this precondition (and 64-bit arch), for
instance:

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
@@ -886,3 +904,20 @@ void sframe_free_mm(struct mm_struct *mm)

        mtree_destroy(&mm->sframe_mt);
 }
+
+void __init sframe_check(void);
+
+/*
+ * Dummy function to break the build if preconditions not met.
+ */
+void __init sframe_check(void)
+{
+       /* SFrame V3 is only supported on 64-bit architectures */
+       BUILD_BUG_ON(!IS_ENABLED(CONFIG_64BIT));
+
+       /*
+        * Unaligned access to 16/32-bit SFrame FRE fields and datawords
+        * using unsafe_get_user() via UNSAFE_GET_USER_INC()
+        */
+       BUILD_BUG_ON(!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS));
+}

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

