Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D924A3845D8
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784645430; cv=none; b=MDdBeU5cxUqpgQBX6TSiIEhulXVyg+TT4WrxYeulEaNwrDTMMWM8RWYuAx4mxygobPAtpf+bBxuoTBn+DF7pXLGxLqRvQ5tz8+5IZ5WPfGTxT6W9qY99POkPIlEa1rM+9qInc1kNnH+s25JW6ZhfajoZgU3vQPAHPT1WEmhsE4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784645430; c=relaxed/simple;
	bh=VdzjbCqpOCc/wxAkcZBMdXE2lZLa455cPk+XT0ctYp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePrHOVcrw4vE0k0sulKiiYraZauE/wx5HRlu6cpbwBO0cnye3zI29inKlJxvuCK7tPSdAx3q1u6hPjDCc13tg8DwiadP7mwM+rS+2654ojrRzrOw41AVOJp81fuUczubd2mebRFPlVoV9a96SH0hlR3lljndrB33iFG2PDcZmME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F/6S49bv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JDX2t/Jv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F/6S49bv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JDX2t/Jv"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LDgAeg1592126
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 14:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yAKVXKkluIoVT2T7N4XQAHdKs/hPq5A0t8zyTSkrPJ4=; b=F/6S49bvvnH4yYT9
	N+GBwPl0pMXFrT3pq65+0jKTDv/V3cYvChvxXWLepEqK0bGH/TUH45/KeB+8sggf
	kpNV0o5mz/Z3F3Z2p1KEj4s5Tz+rDUyRrFSmBtFhrNMMHaYUn4sdQoetmXT/bwDA
	kvudWlVyWpcNNcaDeSs2SkiYuuadyZAvXfxzMRr/7aKVEenaZIeOd4/fUSH+JF4H
	DVzsJizbgilarL2UsrfJYvD1va5bIELaI1v+2SGgpzZbYQb7vTb0idRl4m44iyWE
	c8jEIimIOqcSHZ+wvnQcpfR9OjyeMW+OQSayMgpq4GWEQ9RWoK2EewGc407nQHMw
	JlVwCA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj0as3buu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 14:50:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c075c1e25so163031961cf.3
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 07:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784645427; x=1785250227; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yAKVXKkluIoVT2T7N4XQAHdKs/hPq5A0t8zyTSkrPJ4=;
        b=JDX2t/Jvht8ZnRUlrY0Mc82Dk3Hv2qneW6DSoHUV6akxjBL8ijSNhoQhHlaPE68Djt
         L8UyDT/Deg4EgW1OIhptR/8Cd3m3OpvDhudR216Bm6hDDiduqI88HP0/d6ORxOS32VUB
         /NuZum2KbxsJVc7MTaCRB4aK/HBEze+jPkvjR3mYIb0pQiZ34A5hFY29oMxpXQvViAxG
         qn/cli+a3ZT0FvmD+eG1u8Q15qyE6oWOO13poiW2jyMPQYXEJeeY21F9UrjvQfSXCG6e
         z52yjq1xFiL+1rreKjKTOicVbLL8+xLCStSD6A+UsIFZ6pnnSwzj1CgwV1JM1xFr71NI
         NXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784645427; x=1785250227;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yAKVXKkluIoVT2T7N4XQAHdKs/hPq5A0t8zyTSkrPJ4=;
        b=Cq1ZTU21cFV0Hj7ONGJDj4BlTfAbltlVgsHHa0OkXSFw2Cf3I89u4E+XsFmbiJD1ct
         psxeTEPdcPIn4LNtIGbWGCcuqXAymufTnE9t3HwsIUM8WjkWOP8Gb//X6OKinpzwaIiS
         ggF/nycnCpQORbMR0PAeVG1PFQlh03+SeLFpK0hsAEkWvaXleag8vM9oCKEtL9bRYSIG
         y1gbRbiI2uOiBkMTSzJjgmnQOWN5m1Em9qWCObqMHs/HIFZa8qZkxsLIp2LAr3U113DW
         GNjkhk/2Ynwl7MZ1DuOX2Fp4p7JmlJGER0NaFjecpYhF3aHMIX9+E33x9eL84VBMHG7v
         wiaQ==
X-Gm-Message-State: AOJu0YyT4tMjFk+G4oLai6NwIBll1Cg2fznplLeQfxZGVXw9ESgNjxdi
	EQwIr4AXdzF+BzNYECXirGRQUX71SKWgXD6WlRPDwJym/w9e1DW39DTwNnKzVSXM4GV/aaZMk75
	267ZMnrurqdymUzw4YoCUs8zv5qO4fR8wJkbIvxCbZvC9YNP1Hdk8ydA=
X-Gm-Gg: AfdE7cmTUMBYlqLNwqlmKHZIwu5A4bYyldDt0NhsQSjKjmCSIvjX90/kP0dzPD9iapn
	G9WRQeMAeivQb2KhZdKzGcjSUV5sde1KWGq27G5vwo5EN9+BL0+G7W0QyDWBolRD3dkp9KkM1dL
	9tAWdJACY3sKt5fawMbe9nfcHqfOH+NYy7B7r8Xf4f1BOtFYku+kvLAX5fM7c9YLoXsRM1JG17E
	gEuKnLVyPElHDkcCvdNhSSDLgOELjBsYHRiwhE1isJvxna2tYuCOlix3JdjkdivA7rb0ZSFaDXG
	A4UFtjtcGhVKcE+LdBAJHm4WL7YqeIvhnut0kLP6kE99maLFaZEH8TK1OvCNdRokU2OTpoS2yS8
	w7sQtEDUX1T1a9F6VRDkOS29N9oT9qjchpgPKreDDgOqln3yy43Q=
X-Received: by 2002:a05:622a:834d:b0:527:7112:a5bd with SMTP id d75a77b69052e-5277112a701mr7780661cf.78.1784645426879;
        Tue, 21 Jul 2026 07:50:26 -0700 (PDT)
X-Received: by 2002:a05:622a:834d:b0:527:7112:a5bd with SMTP id d75a77b69052e-5277112a701mr7780241cf.78.1784645426283;
        Tue, 21 Jul 2026 07:50:26 -0700 (PDT)
Received: from [10.131.142.220] (220.171.88.92.rev.sfr.net. [92.88.171.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956546de4fsm77753335e9.1.2026.07.21.07.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 07:50:25 -0700 (PDT)
Message-ID: <4c78319b-9816-4d01-acc9-fda1a68de3ec@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 16:50:21 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf, mips: Add support for BPF_SDIV and BPF_SMOD
 in the mips JIT
Content-Language: en-US
To: Nicholas Dudar <main.kalliope@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
        memxor@gmail.com, tsbogend@alpha.franken.de,
        johan.almbladh@anyfinetworks.com, paulburton@kernel.org
Cc: bpf@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, visitorckw@gmail.com
References: <20260716211055.2569433-1-main.kalliope@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260716211055.2569433-1-main.kalliope@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE1NiBTYWx0ZWRfX1AYzdT8kmGSN
 RcFTs8svpWFXwKx92s5g4AoU8Jh7qWVm0ESUD7CY7rSuQzO9L742JPaxVMgHc/F7hIl+HXw4emp
 pHQrBB6mW7KR702rplv6E7oUqSeMP6Y+wIKiuxiZjez5r9ByWNMQDxsrQU95QeDRsOTK9r6JxXj
 wmFI8i5jtjrA+ozkSwv9zxETyumtg3oTQeCiKUqY+GMnyIFa717Sh1tw9+zxDmcNl1SnvL+N+zN
 LV2KBze41WUFIb8cOzcV5fCx0OsxtI2FIZSIFl+5UIxYqHAduRuFeQIK3T4MGOchCCaX6jduUQG
 rf4jDwvd+LgrYil1r+KOGIhhO++ualnMN5dbbKd068t5nqW3x3e6dkD8v2GNaOA59gFKoczetkh
 cJ+e+9laZEUDkzU0/XdkAFIJm/A5PyDBmX2T2QUyRcuDidIDcRkTnyYo9QSMosNAjXMGCA8sCIw
 ZcGWuyv2QINB+xG8uLA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE1NiBTYWx0ZWRfX3ZB40W9VSHz3
 iN2WfpON3QyGOpb2z8CdDVFdP5DK7oylo/1O6bboPrxwVSxVogIYO946LUKZY7CzoIO67iZXG0w
 A5HeSgYr4G4cEdR70bnQyxnPntkM4aI=
X-Authority-Analysis: v=2.4 cv=DoFmPm/+ c=1 sm=1 tr=0 ts=6a5f8733 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=HvFMDRKYglX6yPpWI6gtsw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=c_zzUmBBnj_Mq94Nlw0A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: AdAo1N0jIb1OpVfZtLYqKfKPtVwWq5-F
X-Proofpoint-ORIG-GUID: AdAo1N0jIb1OpVfZtLYqKfKPtVwWq5-F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011 phishscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210156

Hi Nicholas,

On 16/7/26 23:10, Nicholas Dudar wrote:
> build_insn() picks the div/mod opcode by ALU width alone and never
> reads insn->off, so the mips32 and mips64 JITs do not implement signed
> BPF_SDIV and BPF_SMOD (off == 1). Signed div/mod get an unsigned
> quotient and remainder rather than the signed result the verifier and
> interpreter produce for negative operands. Neither JIT has a signed
> divide opcode or C helper.
> 
> Add the signed path alongside the unsigned one:
> 
> - uasm gains div/ddiv/mod/dmod emitters (and their R6 forms) next to
>    the existing divu/ddivu/modu/dmodu. This is shared MIPS assembler
>    infrastructure, so it lives with the unsigned emitters it mirrors,
>    not in the JIT.
> - The 32-bit and 64-bit JITs thread an is_signed flag (from
>    insn->off == 1) through emit_alu_r()/emit_alu_r64() and pick the
>    signed opcode. On 32-bit MIPS, ALU64 runs through a C helper, so
>    add div64_s64() and a signed remainder helper beside the existing
>    div64_u64()/jit_mod64().
> - valid_alu_i() drops the divide-by-power-of-two strength reduction
>    (/ (1<<n) -> >> n, % (1<<n) -> & mask) for the signed case. An
>    arithmetic shift rounds toward negative infinity and a mask drops
>    the sign, so the signed K-form falls through to the register path.
> 
> The K-form rejects imm == 0 at verify time, and MIPS div/ddiv, like
> divu/ddivu, does not trap on S32_MIN/-1 or S64_MIN/-1. The ALU32
> result is zero-extended after each div/mod, for the signed and
> unsigned cases.
> 
> Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> ---
>   arch/mips/include/asm/uasm.h   |  6 ++++
>   arch/mips/mm/uasm-mips.c       | 10 ++++++
>   arch/mips/mm/uasm.c            | 15 ++++++---
>   arch/mips/net/bpf_jit_comp.c   | 47 ++++++++++++++++++++++------
>   arch/mips/net/bpf_jit_comp.h   |  4 +--
>   arch/mips/net/bpf_jit_comp32.c | 28 +++++++++++------
>   arch/mips/net/bpf_jit_comp64.c | 57 ++++++++++++++++++++++------------
>   7 files changed, 122 insertions(+), 45 deletions(-)


> diff --git a/arch/mips/net/bpf_jit_comp.c b/arch/mips/net/bpf_jit_comp.c
> index 6ee4abe6a1f7..504daea4aac2 100644
> --- a/arch/mips/net/bpf_jit_comp.c
> +++ b/arch/mips/net/bpf_jit_comp.c
> @@ -208,7 +208,7 @@ void emit_mov_r(struct jit_context *ctx, u8 dst, u8 src)
>   }
>   
>   /* Validate ALU immediate range */
> -bool valid_alu_i(u8 op, s32 imm)
> +bool valid_alu_i(u8 op, s32 imm, bool is_signed)
>   {
>   	switch (BPF_OP(op)) {
>   	case BPF_NEG:
> @@ -237,6 +237,15 @@ bool valid_alu_i(u8 op, s32 imm)
>   		return imm == 0 || (imm > 0 && is_power_of_2(imm));
>   	case BPF_DIV:
>   	case BPF_MOD:
> +		/*
> +		 * The rewrite to a shift/mask below is an unsigned-only
> +		 * optimization: arithmetic right shift rounds toward
> +		 * negative infinity rather than zero, and masking does not
> +		 * reproduce a negative dividend's sign. Force the signed
> +		 * case through the general register path instead.
> +		 */
> +		if (is_signed)
> +			return false;
>   		/* imm must be an 17-bit power of two */
>   		return (u32)imm <= 0x10000 && is_power_of_2((u32)imm);
>   	}
> @@ -339,7 +348,7 @@ void emit_alu_i(struct jit_context *ctx, u8 dst, s32 imm, u8 op)
>   }
>   
>   /* ALU register operation (32-bit) */
> -void emit_alu_r(struct jit_context *ctx, u8 dst, u8 src, u8 op)
> +void emit_alu_r(struct jit_context *ctx, u8 dst, u8 src, u8 op, bool is_signed)
>   {
>   	switch (BPF_OP(op)) {
>   	/* dst = dst & src */
> @@ -385,20 +394,38 @@ void emit_alu_r(struct jit_context *ctx, u8 dst, u8 src, u8 op)
>   		break;
>   	/* dst = dst / src */
>   	case BPF_DIV:
> -		if (cpu_has_mips32r6) {
> -			emit(ctx, divu_r6, dst, dst, src);
> +		if (is_signed) {
> +			if (cpu_has_mips32r6) {
> +				emit(ctx, div_r6, dst, dst, src);
> +			} else {
> +				emit(ctx, div, dst, src);
> +				emit(ctx, mflo, dst);
> +			}
>   		} else {
> -			emit(ctx, divu, dst, src);
> -			emit(ctx, mflo, dst);
> +			if (cpu_has_mips32r6) {
> +				emit(ctx, divu_r6, dst, dst, src);
> +			} else {
> +				emit(ctx, divu, dst, src);
> +				emit(ctx, mflo, dst);
> +			}
>   		}
>   		break;
>   	/* dst = dst % src */
>   	case BPF_MOD:
> -		if (cpu_has_mips32r6) {
> -			emit(ctx, modu, dst, dst, src);
> +		if (is_signed) {
> +			if (cpu_has_mips32r6) {
> +				emit(ctx, mod, dst, dst, src);
> +			} else {
> +				emit(ctx, div, dst, src);
> +				emit(ctx, mfhi, dst);
> +			}
>   		} else {
> -			emit(ctx, divu, dst, src);
> -			emit(ctx, mfhi, dst);
> +			if (cpu_has_mips32r6) {
> +				emit(ctx, modu, dst, dst, src);
> +			} else {
> +				emit(ctx, divu, dst, src);
> +				emit(ctx, mfhi, dst);
> +			}
>   		}
>   		break;
>   	}
Your patch would be clearer if you extract a pair of emit_div()
and emit_mod() helpers in a preliminary patch, then include the
32r6 support (this patch).

My 2 cents anyway.

Regards,

Phil.
