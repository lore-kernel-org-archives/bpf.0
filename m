Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A74B42B327;
	Thu, 30 Jul 2026 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785416849; cv=none; b=dxLILRjdvbnfIc6jj9JaczYEKFSvxiQGlytIVpKK1OlSo1cNGVmw7uhY0l+OobgoOY4jNikREbgzocAVxNS+kisYKASlSlaW0T6fLONPjHLsCyr2XG6LW6BmaWdtKWh7EeNQcdP6uJjFEIA4KNkaokjD1kTsEPUH4MNwLcGiRwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785416849; c=relaxed/simple;
	bh=VWR3Z377DpYxXD2MLVlmRx9q2E+LqD46l2BpmMhXWzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tALNFxVMMOz0g53IkP/hOnFNeDyc/SPlNzNawPWgbXm+8ZseH9jiTAkyoDZIHoXAVSs1qXyYClkNo7KWtBF/lkgIWrB5eDlCqF6652D59HjWZI9miN7mvzbCxsm96r+i39Ns7C9E7Mt8J5pjiiEElpSRgwo4za0YsCcnY5L4IbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kKQuNG35; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kKQuNG35"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UAHd732742051;
	Thu, 30 Jul 2026 13:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=u7S96N
	lnLwqhOM4g+/DIgXu0js9BGleUB91EboBxTro=; b=kKQuNG35EZd6d/O/5mXGsk
	ZRbjLjGo7eVvXsM7BSfPrttHtk1RU/c5xCJ9sLURG/iReaIbkEKXR6yV6zd34LAG
	MKkiyyuHkGDTYVNP0QCiWiCixp34Iy4lgTzxmWmB3K6QHhl5CJCS0q4hoy/Dd5yN
	nc5odgEmWmUAfAlG0Jvc+jNsMrBZvtEG5GdYViS1VrHnl22pfTybzz5pvxt9a2kl
	RzIpUVZLlu1egOfwMS93TVuwildNEXdpoTcbgfB9F1JnkoBqf+9md3Y0kQbjJJqc
	C/kW2NB1NgJKZ95Zr5MBVevIHlq4oNmoZvByZePknX8zRuAAvzmfwrCCVgctVxfA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xyv0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 13:06:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UCuMXA017081;
	Thu, 30 Jul 2026 13:06:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhkb5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 13:06:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UD6opG31195428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 13:06:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C68102004E;
	Thu, 30 Jul 2026 13:06:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA6082004B;
	Thu, 30 Jul 2026 13:06:47 +0000 (GMT)
Received: from [9.124.210.70] (unknown [9.124.210.70])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 13:06:47 +0000 (GMT)
Message-ID: <fcd85556-cc96-49ac-a715-09ab14d3f589@linux.ibm.com>
Date: Thu, 30 Jul 2026 18:36:45 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] powerpc64/bpf: Fix build break in
 bpf_jit_emit_func_call_rel()
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
        memxor@gmail.com, chleroy@kernel.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com
References: <cover.1785387718.git.skb99@linux.ibm.com>
 <e8e582fb425db165a72f00e3337cdf4c6ae383ad.1785387718.git.skb99@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <e8e582fb425db165a72f00e3337cdf4c6ae383ad.1785387718.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: WXe6Z8pYXvc1thTb6PfLW1rcFZE_Zj_V
X-Proofpoint-ORIG-GUID: fpi2A6djpuCClmCi2tmH40McNkTJRa-X
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA5NiBTYWx0ZWRfXyN7w8RYSmq1k
 H6aS15sSXpDrBUQstfEsrskGC1CyzbusyawG3DskwHgvzVU15jKeAt1l2oamZFu0BrmA0dMPthF
 0rWXYQSsCN1SYU8k2ASUXM7oCgPUuLg=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6b4c71 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=cvciGhUBELjveWF9BAcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA5NiBTYWx0ZWRfX/D7ZdSCgfmlj
 5wkJGcWcg2hiABgZXFGraTAoA7Y3cxCOs0CTfX+dlTYq1R1xNceSx3RY1u5FDrvky4i74jMzaQM
 6iP4FDXIp1tTfUUssep6kD6BmyfVhGIZ/XHq8FmeyYUzA1ykLMd6LUGV4Sh09oHS7HwwS3j248R
 J3ZRd56sJ1eVLPUBv09QLfdDIHBJiYLoQpWUPRmsDOYzRgyJZH/LXPp3O8AFXdsuIQzwZjLFwBP
 ikkMjkBfKgqPl9vzm9zVRjRYWf1jNC19XLhSqAmkrmfN+Ex+EdXX8E5BbmTVoXKF9+B+cqMni4o
 VtXkUCC6LKZN7bBUiJg2MVSteKScO6qNFt+5uOJdRRTZoCqD7ryM35mrmI114/BI9A8faTlwQxO
 LsnfDMnNH+hxbHvQH9HKxeR8MMlTMpa8hxarV1EFxS+/3bDGApU6SfUxXu8gtgg+CnfAuUxQyKq
 MWUNPDOFY2j1CsmudAg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1011 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300096



On 30/07/26 11:16 am, Saket Kumar Bhaskar wrote:
> From: Madhavan Srinivasan <maddy@linux.ibm.com>
> 
> With CONFIG_PPC_KERNEL_PCREL enabled, build breaks with below error:
> 
>    CC      mm/dmapool.o
>    CC      fs/readdir.o
> arch/powerpc/net/bpf_jit_comp64.c: In function 'bpf_jit_emit_func_call_rel':
> arch/powerpc/net/bpf_jit_comp64.c:475:13: error: unused variable 'ret' [-Werror=unused-variable]
>    475 |         int ret;
>        |             ^~~
> 
> Commit b55b6b9ad76c ("powerpc64/bpf: Add powerpc64 JIT support for timed may_goto")
> introduced "ret" at function scope, but it is only used within its
> respective conditional blocks. Same holds true for reladdr. Move both
> variable declarations to the scopes where they are actually used:
> "reladdr" to the CONFIG_PPC_KERNEL_PCREL block and "ret" to the non-PCREL
> else block.
> 

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>

> Fixes: b55b6b9ad76c ("powerpc64/bpf: Add powerpc64 JIT support for timed may_goto")
> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit_comp64.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index dab106cae22b..fc9db691e820 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -471,8 +471,6 @@ static int bpf_jit_emit_func_call(u32 *image, struct codegen_context *ctx, u64 f
>   int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
>   {
>   	unsigned long func_addr = func ? ppc_function_entry((void *)func) : 0;
> -	long __maybe_unused reladdr;
> -	int ret;
>   
>   	/* bpf to bpf call, func is not known in the initial pass. Emit 5 nops as a placeholder */
>   	if (!func) {
> @@ -487,6 +485,8 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
>   	}
>   
>   #ifdef CONFIG_PPC_KERNEL_PCREL
> +	long reladdr;
> +
>   	reladdr = func_addr - local_paca->kernelbase;
>   
>   	/*
> @@ -525,7 +525,7 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
>   	EMIT(PPC_RAW_BCTRL());
>   #else
>   	if (core_kernel_text(func_addr)) {
> -		ret = bpf_jit_emit_func_call(image, ctx, func_addr, _R12);
> +		int ret = bpf_jit_emit_func_call(image, ctx, func_addr, _R12);
>   		if (ret)
>   			return ret;
>   	} else {

