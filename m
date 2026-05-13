Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BFA3E6DDD;
	Wed, 13 May 2026 09:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778664053; cv=none; b=fbGaKM+SCGk47iErNVV3LtmkuG2fB9Nr1o3Ypmq/AtelVXB7y3AexjVD+Mc5UeUFw2W0nwCgdqZD8nCz7HssTza0LPjG0AATff63PONo936OCdWSPetPSHBcQxr5FPEqgU3p3SNAUGSC3n+8Afh/ujqpl/FTLMDuNaLGkwmIBNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778664053; c=relaxed/simple;
	bh=voKyE5RZ6JydcnsVAPGVmM88R7mBpWV6dEqnB2yU1cc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MfFR14dyJ12e++L3dCS6EdlIAyYI+tGLe4YW1EcTIReG2bZGIbnwmCFON76rP8Bg7zzXtnsW5gqINiP+Pm0/3yvNmc5DB3XDjav0hafDmcF91HnQqo3cqwH76xTdXv/7/qxSVpEQOj9JjnxUWI0MYdiPHlFnahksMuI1cGWYyoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tCvflfaN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tCvflfaN"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D3EBp83049159;
	Wed, 13 May 2026 09:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OwwYCU
	FV8IC7PJ+SwxrCJWMwcLyhDqU2CKCyoIp9u9Y=; b=tCvflfaNy90crswhQ9vlp4
	3/KL468JkhZ88h1fBbsIpIh/GO3edj0JNZMJ9/x+da0mV4xxYulxRK4G1mbdnkdo
	UPT1IPrwHe5MdscEyjMk+8LpDfddgkFx8r76q35zzJuXewPPJQg33+d0qecQPTu/
	HVmf3gEuISV5Et9NSeKG4HEgrrd79Fz217JDHk1JobNaCLKOtncFygAKatyR64yV
	NXvRCTKjk+prnxemf+TR849Ly+Fn6pAwi+WHbBig8bN6q4HJgNjdQbr0trgwq7Cj
	MkKcjZpmw4N2v3U/i/pkaQnQYa7I4bjoXBUB1DshjV1WVScB2nUtlC+j1QT6UDiA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6pnx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 09:20:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64D99PnP025166;
	Wed, 13 May 2026 09:20:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgq3vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 09:20:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64D9Ke3o34537800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 09:20:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F0C82004E;
	Wed, 13 May 2026 09:20:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A8AB2004B;
	Wed, 13 May 2026 09:20:40 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 May 2026 09:20:39 +0000 (GMT)
Message-ID: <d12caa4a-e54f-422b-92b1-b2f51bf7ea20@linux.ibm.com>
Date: Wed, 13 May 2026 11:20:39 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 11/19] unwind_user/sframe: Show file name in debug
 output
From: Jens Remus <jremus@linux.ibm.com>
To: Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev,
        Indu Bhagat <ibhagatgnu@gmail.com>, Heiko Carstens <hca@linux.ibm.com>
References: <20260505121718.3572346-12-jremus@linux.ibm.com>
 <20260505184638.5648DC2BCB4@smtp.kernel.org>
 <edd04d6c-3cdc-43da-9cf2-44cccc353658@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <edd04d6c-3cdc-43da-9cf2-44cccc353658@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Us1T8ewB c=1 sm=1 tr=0 ts=6a04426b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=0MvmVg10__VCTnNSAJcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: eajoxDX7UYy6UqVBMykyXRGTaSxANpgM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA5NCBTYWx0ZWRfX96Wp664p85tg
 AljJKvZrKZkGrUEuT0bc6tj/yYhN9NJdnr7IsCsHCUFRlNMDchdLAIzyMpXSJjX75r87Pj9zvkl
 At3bxNECBln9CGoWxOdQJqMolqqgaIVSizUuBozAiELJCAerT/eSuqYoBmIbvyiI/FoHMJqPO+Y
 xOGuG7L61iVSKZeAQc5JGVYZX6s5uI3KuH13eFO/OigGVqxaSgDa9bePcqcbKFyzcWjQNCSZjlH
 m3JquUe5saniMdAlXVIsLlP3TDCdB+Y83uXyQfBYa0Bw+mzQncfObiRSc1zsXv1i+4VZjL84F+A
 /IHwTFgWXmxLE3ylNXJ7vDLEAnae/fWmya91+u0U/qbU9mdp3rBjxeHgoGBZievnFOxieAgIXMi
 +s5546XCPE4zsO0FY2cuhIN6uV/6sWFqLC2K3dOuwUWpZHBFExEjNLmJQYuYhAcXwXF/ovhW0hN
 iXHXb0JaPtCkoyfrghg==
X-Proofpoint-ORIG-GUID: dEsWO2sHdweVIFkg_oyCXmxZh8d5U2Gi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130094

On 5/12/2026 4:52 PM, Jens Remus wrote:
> On 5/5/2026 8:46 PM, sashiko-bot@kernel.org wrote:
> 
>> [ ... ]
>>> @@ -496,7 +501,7 @@ static int __sframe_remove_section(struct mm_struct *mm,
>>>  				   struct sframe_section *sec)
>>>  {
>>>  	if (!mtree_erase(&mm->sframe_mt, sec->text_start)) {
>>> -		dbg("mtree_erase failed: text=%lx\n", sec->text_start);
>>> +		dbg_sec("mtree_erase failed: text=%lx\n", sec->text_start);
>>
>> Does accessing sec->filename in dbg_sec() risk a use-after-free here? If
>> mtree_erase() fails, it indicates the section might have been concurrently
>> removed. The SRCU grace period could expire, causing sec to be freed before
>> dbg_sec() is called.
> 
> IIUC this is a valid concern.  Should this change be simply be reverted
> or should __sframe_remove_section() create a temporary copy of the
> filename and use dbg() for this rather unlikely case?

On my way home it occurred to me that adding guard(srcu)(&sframe_srcu);
to sframe_remove_section() (see my feedback on "[PATCH v14 03/19]
unwind_user/sframe: Store .sframe section data in per-mm maple tree")
should also resolve this use-after-free without any need for changes.

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

