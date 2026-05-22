Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39D73C8C7F;
	Fri, 22 May 2026 10:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444960; cv=none; b=EvV/dJnIwctCBdsSvu2HCSXAofyHGJ994/YezhwUcaYOb54vTPS2reJD5AAVzATyANgOVsYL6J6rzluNNg0U8ok6y3WRss0XQuvsOsZWuZWlDfIWnR1/ZoTpuOoKTOAUuY7VHTpsSdwc6gGqVrlazLoDXDXVZxh+AByjMYh/PMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444960; c=relaxed/simple;
	bh=dIAS9SeTDL0lghEqQji6iwi+vJPmBPoDvlKD4q+EYzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNwi7Tkx8oRBvGtp5zYcsQwhj8yR28jG/nuh4Vdn2jBadBQ81g4cnVzYqthcmr5Poc1KRkRWrRGiarsTMNZMUd/FgF13Ghr7/h+hPR1UYxJLgWAlnIoGXTRvIirwqkIE48/hRejbmt4NgNQ/rSx8hKcdnKN0yd+zxaZTSL6TDB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gg8TXE4U; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gg8TXE4U"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M8Wf0o1249248;
	Fri, 22 May 2026 10:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rQeEFc
	Oe/7zQSmQvZLP9idwRPZ6kN+gWKgmFkmN6dZc=; b=Gg8TXE4UbBz5IHIOQDSQEJ
	BpxADXSoPlodC1r59WkEbAa0CaXDsuYZ3/gBCcf0i/6qxeNtFNi0ir7oyf1g0KgJ
	PNAHWNhdIweocXF/qBtknHNISNDzKBvyMlCVzhP/of/ho2EkKM/dGuYuvRuLHIuy
	lYialc5clkM+0Xw/mKgmVfx8l1CeJ/Y6X0Lqn8joUPgpb9w7awoLIiCrGTL1q1xW
	Vcxtf59tEsWtL2AGH4iHvhuXhrEFTfFQNC78XEDIyLRy17Q5rdyM8Om5l4BUFNJG
	wm0DTtj3i6ivUHxy9xEqqPqDxDTmJ0kENxZghx3UebVfxojHePHNGCTAuAs7PKRg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88sy64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 10:15:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MA95FR007136;
	Fri, 22 May 2026 10:15:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dj0bty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 10:15:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MAFrYk53608832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 10:15:53 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 041CA2004F;
	Fri, 22 May 2026 10:15:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B92D2004E;
	Fri, 22 May 2026 10:15:52 +0000 (GMT)
Received: from [9.111.153.207] (unknown [9.111.153.207])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 10:15:52 +0000 (GMT)
Message-ID: <40e049af-83c5-4d97-8e26-2da069693184@linux.ibm.com>
Date: Fri, 22 May 2026 12:15:51 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 16/20] unwind_user/sframe: Add support for SFrame V3
 flexible FDEs
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, Steven Rostedt <rostedt@kernel.org>,
        Indu Bhagat <ibhagatgnu@gmail.com>
References: <20260521142546.3908498-17-jremus@linux.ibm.com>
 <20260521151406.E1BA21F000E9@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260521151406.E1BA21F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: E5UkUMCCKcPq6iSR-sxIzEqmck8lv6GW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEwMCBTYWx0ZWRfX/9H2SzFDUYmD
 nx8IEoQyp9z+Vi1p4yseOQbrsprgFsAWPYb32h/Ks4SwOi2SDDR32EkU+2Td6JlSXqONYqw6m12
 gASWzSKrfVuiCJBgZdnCZiHYJWo9KbLSBj0sP67AxZhfZYz6wRwe7M3sxLtesyrGayv5CHfVctp
 WKU+d73z+S4WtqcGWcdzkMHs3SzHCH/WrYUS/QbhNwtJErfGwIC5MvYD7mMaaHu/2b6dlOoESgo
 8rVe050KFnx3iS1nbbNmdgt4q4Rjby+MkAd7Gegkid6RI35YPpEZ86EWPc/ok57oaEwGVyVfvSK
 XYAisa7wyUKgKI3CW1y1G2pmoxlPL3KrcW8sSKbkKmuN7btZdu63KbBbr3k7Tr5hGpvkla7cCEA
 ufBb6EHrIrwbf/Ws+uj7BV8Tws5JSWDN4iFuKyVxjZUUa2NSpRfFsr8jENDdEG5fbQ6wH0+jJtC
 HnOQusIxmKbzjSzg7BQ==
X-Proofpoint-GUID: bZC9kYJwhQAxjAcMfA3IfjDO-fWdrYz8
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a102cdb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=9Kn7GfD3tJpvV5knKXkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220100

On 5/21/2026 5:14 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Mismatch between SFrame V3 flexible FDE control word specification in the commit message and the actual implementation.
> - [Low] The patch uses undefined macros `SFRAME_REG_SP` and `SFRAME_REG_FP` and includes a missing architecture header, breaking the build.
> --
> 
> commit 82ce04f2a50a8ff116e0ca155714efff95332739
> Author: Jens Remus <jremus@linux.ibm.com>
> 
> unwind_user/sframe: Add support for SFrame V3 flexible FDEs
> 
> This commit introduces support for SFrame V3 flexible FDEs, which encode CFA,
> RA, and FP tracking information using FRE data words or padding words. It
> adds logic to read flexible FDE control words and initialize the appropriate
> CFA and rule data structures.
> 
>>     This enables the following flexible CFA and FP/RA recovery rules:
>>     - CFA = register + offset       // reg_p=1, deref_p=0
>>     - CFA = *(register + offset)    // reg_p=1, deref_p=1
>>     - FP/RA = *(CFA + offset)       // reg_p=0, deref_p=0
> 
> [Severity: Medium]
> Is this description in the commit message accurate?
> 
> The commit message states that the FP/RA rule uses reg_p=0, deref_p=0.
> However, the implementation for this rule in __read_flex_fde_fre_datawords()
> uses ra_ctl = 2, which corresponds to deref_p=1. 

My bad!  Will correct the commit message in the next version.

> 
> Also, the commit message later notes that reg_p=0 and deref_p=0 is actually
> an invalid padding word.
> 
> Could the commit message be updated to match the code's behavior to avoid
> confusing future maintainers debugging the SFrame unwinder?
> 
>> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
>> index daa97d8b02316..b623dca072daa 100644
>> --- a/kernel/unwind/sframe.c
>> +++ b/kernel/unwind/sframe.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/mm.h>
>>  #include <linux/string_helpers.h>
>>  #include <linux/sframe.h>
>> +#include <asm/unwind_user_sframe.h>
>>  #include <linux/unwind_user_types.h>
> 
> [Severity: Low]
> Does this include break the build for intermediate commits?
> 
> This architecture header, along with the SFRAME_REG_SP and SFRAME_REG_FP
> macros used later in this patch, do not appear to exist in the tree at this
> commit.

This is intended.  kernel/unwind/sframe.o is only built if an arch
enables HAVE_UNWIND_USER_SFRAME and provides an arch-specific
asm/unwind_user_sframe.h header that defines at least SFRAME_REG_SP and
SFRAME_REG_FP.

> 
> Although this is fixed later in the patch series by the commit that enables
> sframe unwinding on x86, missing headers and undefined macros break git
> bisectability. 
> 
> Should these definitions be introduced in an earlier patch or within this
> one so that this patch compiles cleanly?
> 

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

