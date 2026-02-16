Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF7E1A9F88
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 08:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771231019; cv=none; b=ayzSL1rHj1b/uIiB6SZjmowkPqgUBduWxDsWkjFbFcvTkhYdY2CExzEVJHNyh5FkV6QrhehQo6nLww9JR4d9WfPXHbCdr4jkohSPpAXP4W3AgpaIg3DyXQlc98UWYTwPIKka9BaAV0+J9uMD1jrS55k7THkK4nc/MiTPk2KLyJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771231019; c=relaxed/simple;
	bh=2A8gyM5812GaOGynmvhLI0mZGovzk+NyYUvGelqcEUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbd6gN+IZhpgRVgcmLZjXj1iMgM3HixlHQ08I6dMhJl8etnRHDTyX0RMeam9Fj0ETxg9fygjVYV22sp1N2Ke6xR3RmFuWEuY8Ys/djPHdHdi5rMH3V1J8uN7bJ99ZFdS76uphur29OxOe8hXatwDbMzhbAIxwmPXIw0sVgfKLgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ALd2DyJq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ALd2DyJq"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FJkM7i3310647;
	Mon, 16 Feb 2026 08:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5tIzcw
	StWLw/uFU3YPIthqSkGIkJLpNLF6IomNN25DE=; b=ALd2DyJqlVtvuVGEGzhqJB
	TYeac51JMWryv2hAEesLu1z871X4DvnLbsmNBj9RBewlefXRiNq6KMdR4HrZrB+y
	J00zCUo20+ZIE8AY0fe6A/xkuuWmfxD+sq4Ir5dkFC3YITrd6SVY3AtFndbgRzi8
	jxiT5HPbzRGafFkI42idVezkjYTER3iYhM2RqXutw4kjyL0IcvfitsPTwwAYRY39
	WUEeVRP9tK63f4GrWbNX6/cloIW7yU6rp5TgUdf/iczx3SQur9/sGdVS7goi8f02
	Zb6KWb077lcYwxfYhUtMgyfTFNCqCds323c1m2AfN98DRo6Ns54RTLMtCRNWKtPg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4k6d02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 08:36:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61G6k212004197;
	Mon, 16 Feb 2026 08:36:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cb4cmvmq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 08:36:30 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61G8aPgo20840962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 08:36:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDF9C2004D;
	Mon, 16 Feb 2026 08:36:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B62920049;
	Mon, 16 Feb 2026 08:36:23 +0000 (GMT)
Received: from [9.78.106.17] (unknown [9.78.106.17])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Feb 2026 08:36:23 +0000 (GMT)
Message-ID: <87b92f46-8b05-4061-949c-4c15afc55d29@linux.ibm.com>
Date: Mon, 16 Feb 2026 14:06:22 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] powerpc64/bpf: fix handling of BPF stack in exception
 callback
To: bot+bpf-ci@kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, skb99@linux.ibm.com, adubey@linux.ibm.com,
        martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
        clm@meta.com, ihor.solodrai@linux.dev
References: <20260216065639.1750181-6-hbathini@linux.ibm.com>
 <5f92f12e74b1c8d6fa54ec72590d5087a3c8b7ac2d7302309936db6bd196f5cc@mail.kernel.org>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <5f92f12e74b1c8d6fa54ec72590d5087a3c8b7ac2d7302309936db6bd196f5cc@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA2NyBTYWx0ZWRfX77AkWTr2afRm
 gi64dMH77NNwHAYLooc7bGz9wmIR7SjtQhexbNyhQc5qgkJOX0Nh0NTXN2gNFjk6lucImhg/Vpx
 7f81RRrAeILeAOu06Z9dV07UXN7asbf4S476OQx2Dwl0yKWwxo8eAsypCjlLCbmgHNThYW4euR4
 7rFs1LWUgrBs46mp/jVevaoWIXgtWs3F44CT5noZjelmNGysL2K3juga+7LynVu4c9kBdWX0f47
 XwfjcPVT5VdwXKPvxCDMy10UgpxR583FYzbRTMxjdAN96Oxa8Xbvw65t/CitQGrfj9SyuO/NYH5
 vz1aGafiunUmBkeBXEs+s6+ziwt5Vagrxhp6cBm44zaZpW/fKxGF/RslP+KGtAkhKEazclblpzE
 5Q23D9y+qMsnFgZvyipqFuN6SV5kPn6XX9jKhUc0aqeiYHPo8AqiBeIZGRNBh5HGxt4/1rLbFsu
 mcjzuJ7DbQE9ke2uhsA==
X-Proofpoint-ORIG-GUID: dUEtbjr8eV1VnIqXfqevM8ijjJfpVQhl
X-Proofpoint-GUID: mCspMg7hfWqjXDzVlr07iz_OuCWjX2Wp
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=6992d70f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=vP-F963z1u4rLPN7kLoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_03,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160067



On 16/02/26 1:10 pm, bot+bpf-ci@kernel.org wrote:
>> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
>> --- a/arch/powerpc/net/bpf_jit_comp64.c
>> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> 
> [ ... ]
> 
>> @@ -287,6 +285,22 @@
>>   		 * program(main prog) as third arg
>>   		 */
>>   		EMIT(PPC_RAW_MR(_R1, _R5));
>> +		/*
>> +		 * Exception callback reuses the stack frame of exception boundary.
>> +		 * But BPF stack depth of exception callback and exception boundary
>> +		 * don't have to be same. If BPF stack depth is different, adjust the
>> +		 * stack frame size considering BPF stack depth of exception callback.
>> +		 * The non-volatile register save area remains unchanged. These non-
>> +		 * volatile registers are restored in exception callback's epilogue.
>> +		 */
>> +		EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), _R5, 0));
>> +		EMIT(PPC_RAW_SUB(bpf_to_ppc(TMP_REG_2), _R1, bpf_to_ppc(TMP_REG_1)));
> 
> Are the operands to PPC_RAW_SUB reversed here? At this point R1 holds
> boundary_sp (set by the MR above) and TMP_REG_1 holds prev_sp (loaded
> from [R5+0]). Since the stack grows downward, boundary_sp < prev_sp.
> 

> PPC_RAW_SUB(d, a, b) computes d = a - b, confirmed by how BPF_SUB is
> emitted in bpf_jit_build_body():
> 
>      case BPF_ALU64 | BPF_SUB | BPF_X: /* dst -= src */
>          EMIT(PPC_RAW_SUB(dst_reg, dst_reg, src_reg));

That was a good catch.
"subf Rx,Ry,Rz" vs "sub Rx,Rz,Ry" distinction on how the operation
is interpreted. Will respin.

- Hari
