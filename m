Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DE33A4F2F
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 10:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774953782; cv=none; b=Cla92NMJhO/01l6HvrUaHp8Z/CSeT30kRJ9Wd2F27Bn/GZhdYgHMaIzNAEJodBK0SZWw9fcD5sonTzk4IVj7L5e1MmnmmQMoBC7DVxtD2b3e1TLuRRTGi7IfyveivnKG7pv5Q6DuEuh/Iv+z9xWmPbLS+uTe/ekzOT4Y053lolM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774953782; c=relaxed/simple;
	bh=60xmwZx8bCLcBZ4iTefOd3Jln/VXR92l9CFWnb0KfF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cn4ZUjb8P3H2VZU4GXxWgaXdcEXCkhURo5LJh4d6cnQvGuDgsoC4kJJfCbO/osLRg9BwS085EatCz76nX4+GpAuoUlMRbMEfgh1cEGTRoAnGz/hYUU1DPnmKA1qIxReaTKVaoGGIg5tQVeIVCVEChZ9hrdavDjCd2K0jjLUpEas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S0f/uWY5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S0f/uWY5"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V5nd3K4097773;
	Tue, 31 Mar 2026 10:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gio1Aj
	QTECfRrWvSt8Wp7EvKzsqs+ww+mh3Lz7clbqU=; b=S0f/uWY5APjYCVE36adi9h
	WAPR7c9G3GrJ4XSz+v4HM6arpx9WD7TucewwVjlmrOFlcuBCeaMxPrqZ15QY7mUz
	A0DYpy1KuaFNhoYmI0Mv+UWqPHs4FasiY0OzP18iSSfXyAsuBD7WBKtN7XoGQ6Q+
	Z3oMn9fpMmRDe9iOnScdpnh/gnQTGBjmtHe2mRglKkqRYWPADvcpPz0+138QFXWN
	dpL3X6iMf+pAhIAiLpkZAm+AIbiOG6SKMGIV5jCS0GVfuou/YsEVvfOAvMR49PW1
	0z3s410dWhEsmjJgU0bD0mp26RkYH0LXBKvCLmIMk4BWIfYDW9GHkuUcfZ/GvaMQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnjry7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 10:42:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62V6KnFo005977;
	Tue, 31 Mar 2026 10:42:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spy0qek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 10:42:44 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62VAgeGY62914956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 10:42:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54E3C20040;
	Tue, 31 Mar 2026 10:42:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D52820043;
	Tue, 31 Mar 2026 10:42:39 +0000 (GMT)
Received: from [9.78.106.17] (unknown [9.78.106.17])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Mar 2026 10:42:38 +0000 (GMT)
Message-ID: <b8da91b7-94f3-4614-8b92-5085734953d4@linux.ibm.com>
Date: Tue, 31 Mar 2026 16:12:38 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] powerpc64/bpf: Add support for indirect jump
To: adubey@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, maddy@linux.ibm.com
References: <20260227014315.39980-1-adubey@linux.ibm.com>
 <20260227014315.39980-4-adubey@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260227014315.39980-4-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Pf4AmC1_k1kxYMk9dMQLNyq7Tp9vXSo6
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69cba526 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=lo0OUDQOMmcdXGHtshcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA5OSBTYWx0ZWRfX1d8L16sUOhw6
 fycFUrWNkoI19YRWbTGs1CMzNp9WW1Lski5v8jab5Na24TZuwkpRporxnTBey/ay6s0WBdoXwlt
 csFEtQxjfhvyePMaK+RTY70w8BKNliFlP/YKFqBHkAtz+RMU84OUMTqt4vMrCYaa+Re5fC7Rkn+
 tixayfQzt1OsHZq6+mJoaPhJ0fk3f5GzcyK7fiLaZE3UkrrcXbU4s8U+NLbNm2AAd3pFmLhRehZ
 bOUZM65ViUcX3GmYrReFQ9Km49WvREyOePa/a08z84ZGa5iin08JjUeJoFWXTz1Nu2fnwZvQ3sZ
 1BWptaKG6rje9I/V1GP1ikRDdOTZ9GVMHvGzTXaK/zdY3Q3g+QgfzrBReh3FzjI/vWH24JgAbSZ
 IPa5BUcTy5Vu6nQTz69G9k5Q+cYMJTnYLNKuHXZCnCAicJAtRnbcyiQ2oRVUhHeWFwU2gGlaJLc
 shMsVOri4+CfOVuW9Xg==
X-Proofpoint-ORIG-GUID: Pf4AmC1_k1kxYMk9dMQLNyq7Tp9vXSo6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310099



On 27/02/26 7:13 am, adubey@linux.ibm.com wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> Add support for a new instruction
> 
> 	BPF_JMP|BPF_X|BPF_JA, SRC=0, DST=Rx, off=0, imm=0
> 
> which does an indirect jump to a location stored in Rx. The
> register Rx should have type PTR_TO_INSN. This new type ensures
> that the Rx register contains a value (or a range of values)
> loaded from a correct jump table – map of type instruction array.
> 
> Support indirect jump to all registers in powerpc64 JIT using
> the ctr register. Move Rx content to ctr register, then invoke
> bctr instruction to branch to address stored in ctr register.
> Skip save and restore of TOC as the jump is always within the
> program context.
> 

Looks good to me.

Acked-by: Hari Bathini <hbathini@linux.ibm.com>

> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit_comp64.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index c1d011046d8b..2cb550ca1dec 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -1627,6 +1627,14 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>   			addrs[++i] = ctx->idx * 4;
>   			break;
>   
> +		/*
> +		 * JUMP reg
> +		 */
> +		case BPF_JMP | BPF_JA | BPF_X:
> +			EMIT(PPC_RAW_MTCTR(dst_reg));
> +			EMIT(PPC_RAW_BCTR());
> +			break;
> +
>   		/*
>   		 * Return/Exit
>   		 */

