Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A471F360EE7;
	Tue, 12 May 2026 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595823; cv=none; b=MSQZ/i5lwEqXox+1yHF/ytXN4BkxRBECchh8Ytrwu4xV9ppMK7PUbMBtPLMuTTp2T0+6RuPCtDw+K4V7Wwquu/qDrpshgUQukd+gpuBx2B1d6w85jU1AJdo6sdNJOhJZ8/WzktdyDFiGo3wut6PswwVNN0L7qgsaG4d7+Hc9aA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595823; c=relaxed/simple;
	bh=UrpT1tZAdD2EhiixXxkYiYBLu6+I12GxN8UBUOVlkTU=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:From:To:
	 In-Reply-To:Content-Type; b=VvGf6nmwUk6xtNC4qfeTcjy7Tj5yuMfpQ1PNQKrboi4IV8m5wwbj9sJ5WQs4rbvaECTIEAwMvAB1F3fJkfsgrQZrnev5GQzknJub1C6T508y3W3/tCxQutxrNRupxeX16UUguFDunyf5E8lkmIYH0fRMd0dOVydC5An7XZqPxb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wx4g44tQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wx4g44tQ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CCJpQv3775727;
	Tue, 12 May 2026 14:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/J3d1T
	Vi4CMe80K15QN+hwpr/QvZ0ARt4NMu4FX6i+k=; b=Wx4g44tQd/o9i0lPeZMFZB
	eqhE74ouKexF1rUQXNYuGCqPTjf2boPt7kWJ+Rj9B2WoR+YmZt4fqrz3kWJyr2xE
	VJX2javxT2Ku46yatAMmnlUMUfJ8CShw2jpi7wgzOEOXhvtOW8R0EVW+Q100+zyx
	SBGoQL/o2cQ61607XxTtkTfsEYnnAi9jKx35UPo4pDhcDQW4B0/BOpiAg/8Y0Bdg
	iNwd+cGeE+DfLGi0RtIAxZfvrYsiId9HbyzrI9sUcJNXcaOUlAEATHooGBIbgWg2
	J7i5E4CDwpf05wTlKZU0gRT8ALExPxxltgMKfWvLOQybHtFZp1CIYOXlsX9xv51w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6k9y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 14:23:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CE9RW8031032;
	Tue, 12 May 2026 14:23:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgugdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 14:23:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64CENZfo44761466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 14:23:35 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E5402004B;
	Tue, 12 May 2026 14:23:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F58820043;
	Tue, 12 May 2026 14:23:35 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 14:23:35 +0000 (GMT)
Message-ID: <c865e97c-416a-4c3e-8817-9d3f4a8f004c@linux.ibm.com>
Date: Tue, 12 May 2026 16:23:34 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 12/19] unwind_user/sframe: Add .sframe validation
 option
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev,
        Indu Bhagat <ibhagatgnu@gmail.com>, Heiko Carstens <hca@linux.ibm.com>
References: <20260505121718.3572346-13-jremus@linux.ibm.com>
 <20260505183254.AF63AC2BCB4@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
To: Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>
In-Reply-To: <20260505183254.AF63AC2BCB4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KbvidwYD c=1 sm=1 tr=0 ts=6a0337ea cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=njC-hnyFwTIKUP6h0CMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE0OCBTYWx0ZWRfXxxo2ITelINFS
 WM2OU71tbUuFzqxmmAmIScC1jpM/Y4cP1xtQ1i9BxnaYHM3/3BBhyTYjl8jr9ZjlXXkYX2pP/b5
 mQQBmwdYkH9CKs90ME8ZswufXZKZnmfSdY7M/RnkFgwjL28BK5Q7BBN5NTb3fgx02o+Qc6w41Ng
 kmy0DDb/QzWXHvrPEa+IqpfGWtEy48KVuxPVwizwCuDyuyNARdmN7BwbWM0ydpYZAtIEbMdkifa
 ObZliUAJmssACkRvRRcQ7fmEti5fQ8TLNL3hiJE7MPM4nbZZB4sxWZ3kfppeKH3UGYCpF9Wfr9A
 R84VE31g37l3wVVTZVtFQamrXdWlPUFBnDFVbmtuImVxqzGPLDb9+bFKLKpvAnQBg5pEAu4LA6w
 GAAG52xe7z+BQRvWGaTd0ZSvPeCwZ0dv7h7r2EbYpl5MIvwb3aTuG53oD1VSkD2alfBnLMcRMj3
 sRdhrJECkX+D1czvEmQ==
X-Proofpoint-GUID: JsjnHwrp52Tl1OUtadeS787KFlNNJMKt
X-Proofpoint-ORIG-GUID: HtxZBiLieEzp1nmtdSdl0Hh_ZrlrgkpI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120148

On 5/5/2026 8:32 PM, sashiko-bot@kernel.org wrote:

>> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
>> index 4419626f01734..45988cdc5c37a 100644
>> --- a/kernel/unwind/sframe.c
>> +++ b/kernel/unwind/sframe.c
> 
> [ ... ]
> 
>> +static int sframe_validate_section(struct sframe_section *sec)
>> +{
>> +	unsigned long prev_ip = 0;
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < sec->num_fdes; i++) {
> 
> Can a maliciously crafted .sframe mapping with extremely large values for
> sec->num_fdes and fde.fres_num cause a soft lockup?
> 
> The outer and inner loops iterate over values parsed directly from the
> user-provided .sframe section header, which could be up to 4 billion.
> 
> Since there is no cond_resched() called within these loops, processing a
> large section might monopolize the CPU for an extended period and trigger
> the soft lockup watchdog. 
> 
>> +		struct sframe_fre_internal *fre, *prev_fre = NULL;
>> +		unsigned long ip, fre_addr;
>> +		struct sframe_fde_internal fde;
>> +		struct sframe_fre_internal fres[2];
>> +		bool which = false;
>> +		unsigned int j;
>> +		int ret;
>> +
>> +		ret = safe_read_fde(sec, i, &fde);
> 
> [ ... ]
> 
>> +		fre_addr = sec->fres_start + fde.fres_off;
>> +		for (j = 0; j < fde.fres_num; j++) {
>> +			int ret;
Steven, Josh,

concerning the questions raised by Sashiko AI review regarding crafted
.sframe with a large number of FDEs and/or FREs:

1. Could this trigger the hard lockup detector?

My understanding is this cannot occur, as neither unwinding nor the
optional validation are performed during NMI.


2. Could this trigger the soft lockup watchdog?

In the unwinding path binary search is performed for the FDE and linear
search for the FRE.  In the optional validation path (for debugging
purposes) both the FDE and FRE tables are iterated.  In both unwinding
and validation any detected invalidity stops the search/iteration.

FDE may not overlap; this is checked during validation and partially
during lookup.  FREs may not overlap either; this is checked during both
validation and lookup.  FDEs may share FDAs and FREs.  The maximum
number of FDEs is limited to 2^32-1.  The maximum number of FREs is
limited to 2^16-1 per FDE (due to the possibility for sharing).  Each
FDE/FRE must cover at least one byte of text.

For maliciously crafted .sframe to reach the maximum number of FDE of
2^32-1 a text of 4 GB is required, when having each FDE cover 1 byte.
To reach the maximum number of FRE of 2^16-1 only 64 KB of text is
required, when each FRE covers 1 byte.  To maximize on FDEs and FREs
4 GB of text could be represented using ~2^16 FDEs with shared
2^16-1 FREs each.

Given the wort case complexity of the validation is
O(#FDE) * O(log2(#FRE_per_FDE)), should it perform the following after
having processed a FDE including all of its potentially 2^16-1 FREs?

	if (need_resched())
		cond_resched();

What about the unwinding?  Given the worst case complexity is
O(log2(#FDE)) + O(#FRE_per_FDE), should it perform the above after
having performed the binary search for the FDE (before performing
the linear search for the FRE)?

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

