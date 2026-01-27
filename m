Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC4E32BF43;
	Tue, 27 Jan 2026 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769496860; cv=none; b=ApdMbP5pHy7ylNwvQI/s4PQRmxuXRg+U2IWCfUKMY/Xrh+ugMkcVDmwN8HMSE4NcL5ntYHn4s2EmySjGVVPGt0S8/iX/NMZ1LJwOtLopSBCAlXtaFVDeE51SRMODellBnkuwaSfVS6PhtOD88a882gecLUngz7oPu2lcyHglqcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769496860; c=relaxed/simple;
	bh=kghSbUBTJHHuIs7gcwu2kewIAHnML8RFagmQRZisVmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K0sSMcnTOdwdsbNPgsJfK/AQygQNLt/JM0gFBs5nKiahCufvLYW0k8cly6c4q6PF1RlmF3eq5tIKbd4+4GCa1GetrM/Xi1lLtcDcZHc3LFrHyyJE5QYxCdpQWWSbvvcf/3UvvhnLY3+F44Q/fNWTvlnT5AdL8B16HVoz9qH99t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MHjDObsF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MHjDObsF"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60QFcQPc023414;
	Tue, 27 Jan 2026 06:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2vKyuY
	Px1Jq1ekbrT4IzHP+v9xXysPIOpGFFOnvpWoI=; b=MHjDObsFUocpXTiOJ4FkIH
	pN5rcvsjOpbt8u4T4+d7nM9NeoYxToKC4IDqydh2gb8tTcZAiQ7zqNzlZXjNo4Ui
	inQ/b9mfiH/A0uDDOwrdbXQjwofOH6I440R8F2vyykGCooIH7wG+ogQV927a2KqH
	Ad87Z5KP0nTVfrUF3CnbY7QRUsuSX9Grlsn2CiKEBobISXeT+CTBkV+oK6vr6lcF
	/kz2U+YibqcAmstUBDzTLK4uPqI1knDINIMt0nPphvP3Mx+tPgJh4H20MkSBVO5F
	LA0Jl3SSM8Smi+XQlYY/Np2Rz6Gq64W2LlPGehMhGacmoNg8hXhyLHhVWpZass3Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnk6uxdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 06:53:45 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60R6rikb030787;
	Tue, 27 Jan 2026 06:53:44 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnk6uxd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 06:53:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60R3vTD3023625;
	Tue, 27 Jan 2026 06:53:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwamjqf9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 06:53:43 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60R6rdu253608772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 06:53:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D51120043;
	Tue, 27 Jan 2026 06:53:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83F5B20040;
	Tue, 27 Jan 2026 06:53:34 +0000 (GMT)
Received: from [9.78.106.105] (unknown [9.78.106.105])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 06:53:34 +0000 (GMT)
Message-ID: <91a1246a-44d7-4f39-b7a5-2de1865e7415@linux.ibm.com>
Date: Tue, 27 Jan 2026 12:23:33 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] powerpc64/bpf: Additional NVR handling for
 bpf_throw
To: bot+bpf-ci@kernel.org, adubey@linux.ibm.com, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: sachinpb@linux.ibm.com, venkat88@linux.ibm.com, andrii@kernel.org,
        eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, memxor@gmail.com,
        iii@linux.ibm.com, shuah@kernel.org, martin.lau@kernel.org,
        clm@meta.com, ihor.solodrai@linux.dev
References: <20260124075223.6033-7-adubey@linux.ibm.com>
 <2a310e86a59eb4c44c3ac9e5647814469d9c955580c9c0f1b3d9ca4a44717a34@mail.kernel.org>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <2a310e86a59eb4c44c3ac9e5647814469d9c955580c9c0f1b3d9ca4a44717a34@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PFbibNarOBqJkas2DMGTEou_bb19UzBW
X-Proofpoint-ORIG-GUID: 9D4Ah6Cb63jonCAn6hbYlOYL6sVvYXd6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA1NCBTYWx0ZWRfX92YmP9olsmk7
 ifu2d0hXdJlzQ/tVU8Ue7Aeym88Q9H0TKK0m9XsiWDeh2FQtCRR32Rl75Nu1XWlSzMyu0gRG7ek
 HuDq+VHNPDUg3jtdx/zn2Kho70vhOpazchYYqVvccMOBCsUp5K4+iu40FYdBdIl90LbgLZIhX6A
 7fU13Trb8v7KUiCfrWy2OFFVGUoVotOXIjf86qp9f2/POe5yIRagdjze/t56UQTPFpVDE38wfeP
 Lf9va1A6UeUkXsEILvDeXRkJhhqSvrlWum0Mp/RcbBwcRkaUxIyCE2ZZ/z58XuJaKkWHre0YrUM
 nRg4H1g6+0JB9p2stZVKug/6v4Ez++140RyvZG1KDZuiB9nxqHOVUuOhyVbh4Vo1skUuP48aEUC
 w37PSFcFkDE/7gPaRv6JtbDM3wCqUgX6mg2hMfqpmmX3dOBb+g+Cmx+vKhRBSANsxr86VhlfHdv
 EQEewlDpy8umq+1DWSA==
X-Authority-Analysis: v=2.4 cv=AMiVTGgp c=1 sm=1 tr=0 ts=697860f9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=DLj6BFq7CkYCEiYtZIMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270054



On 24/01/26 1:53 pm, bot+bpf-ci@kernel.org wrote:
>> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
>> index db121b1404fe..17de8b53a962 100644
>> --- a/arch/powerpc/net/bpf_jit_comp64.c
>> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> 
> [ ... ]
> 
>> +/*
>> + * For exception boundary & exception_cb progs:
>> + *     return increased size to accommodate additional NVRs.
>> + */
>> +static int bpf_jit_stack_size(struct codegen_context *ctx)
>> +{
>> +	return ctx->exception_boundary || ctx->exception_cb ?
>> +					BPF_PPC_EXC_STACKFRAME :
>> +					BPF_PPC_STACKFRAME;
>> +}
> 
> [ ... ]
> 
>> @@ -198,7 +249,19 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
>>   			EMIT(PPC_RAW_STD(_R0, _R1, PPC_LR_STKOFF));
>>   		}
>>
>> -		EMIT(PPC_RAW_STDU(_R1, _R1, -(BPF_PPC_STACKFRAME + ctx->stack_size)));
>> +		EMIT(PPC_RAW_STDU(_R1, _R1,
>> +				-(bpf_jit_stack_size(ctx) + ctx->stack_size)));
>> +	}
> 
> [ ... ]
> 
>> @@ -248,9 +311,19 @@ static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx)
>>   		EMIT(PPC_RAW_LD(bpf_to_ppc(ARENA_VM_START), _R1,
>>   				bpf_jit_stack_offsetof(ctx, bpf_to_ppc(ARENA_VM_START))));
>>
>> +	if (ctx->exception_cb) {
>> +		/*
>> +		 * Recover additionally saved non volatile registers from stack
>> +		 * frame of exception boundary program.
>> +		 */
>> +		for (i = _R14; i <= _R25; i++)
>> +			EMIT(PPC_RAW_LD(i, _R1, bpf_jit_stack_offsetof(ctx, i)));
>> +	}
>> +
>>   	/* Tear down our stack frame */
>>   	if (bpf_has_stack_frame(ctx)) {
>> -		EMIT(PPC_RAW_ADDI(_R1, _R1, BPF_PPC_STACKFRAME + ctx->stack_size));
>> +		EMIT(PPC_RAW_ADDI(_R1, _R1, bpf_jit_stack_size(ctx) + ctx->stack_size));
> 
> For the exception callback case, doesn't this use the wrong stack_size?
> 
> In bpf_jit_build_prologue(), the exception callback does not create its own
> frame - it sets R1 to the boundary's frame pointer via EMIT(PPC_RAW_MR(_R1,
> _R5)). However here in the epilogue, the frame teardown uses ctx->stack_size
> which is the callback's stack depth, not the boundary's.
> 
> The boundary program creates its frame with:
>      STDU R1, R1, -(bpf_jit_stack_size(boundary_ctx) + boundary_stack_size)
> 
> But the callback tears it down with:
>      ADDI R1, R1, bpf_jit_stack_size(callback_ctx) + callback_stack_size
> 
> Since each BPF subprogram can have a different stack_depth (set per-subprog
> in kernel/bpf/verifier.c via func[i]->aux->stack_depth), if the exception
> callback has a different stack depth than the boundary, R1 will end up at
> the wrong location after this ADDI.
> 
> After the wrong R1 adjustment, the LR restore below loads from R1+16 which
> is now pointing to the wrong memory location, potentially causing a return
> to an invalid address.
> 
> Would it be correct to store the boundary's stack_size somewhere accessible
> to the callback, or ensure the callback uses the same stack layout as the
> boundary?
> 
>> +
>>   		if (ctx->seen & SEEN_FUNC || ctx->exception_cb) {
>>   			EMIT(PPC_RAW_LD(_R0, _R1, PPC_LR_STKOFF));
>>   			EMIT(PPC_RAW_MTLR(_R0));
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.

I will post the fix for this issue as a follow-up.

Thanks
Hari
