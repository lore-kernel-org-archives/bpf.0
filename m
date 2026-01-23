Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23FC3A1C9;
	Fri, 23 Jan 2026 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769172818; cv=none; b=Ovqy5kGHjokR6IEaXT2gzUN9wUMvTqHFjRt0BLG8VVSk1HePz7iY5rRPOd2P462qn8jN2ir0wy4Q++RDRLm9On3FEdWuf7qaEq3RtdhEAU65ctQBsfpyx1eYU47hqhv58X2hTxUoXQqo0dkR6m4qJEMFY4m28/Wl8B78ZXWj+zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769172818; c=relaxed/simple;
	bh=Odvs5mHV49Enhvn1S2u0TJsaGXLmkQA/qfnlaMireB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e4/QGbABHfNxm2hINUXHLTW0vgBRhfEPJwY2kW1UXHqLhDIIRfsPdJbqurTRjBHKjyhl2reebxZyLcPQ6NPwLeIfz6QfKfOOn4f/RNZRaIyQnitD+aWRglVdsASZGCe5D14MH7UeWtR1tqHSOIDmJ1eIhWv8KE8ujhUtnZOMMAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h6D78Jlx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h6D78Jlx"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60N2bxS5019542;
	Fri, 23 Jan 2026 12:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2FyZ0y
	q64l8xxgmx4MCJj5LlQFBuun7q58aTor9k8eo=; b=h6D78Jlx6it9ZMvyEkZ3LA
	z4HhC0RVFNMhxynIsrxjrRXNWb0+ay1nGbpiBenDWCUUJBUQQ6FJHLXLrKC6OGRX
	W+trJ1AeXB4+GiIVNpQ+LSqHO00GaXgkrrKK2E8WW1gRc96oa3AyzjWUXFhvkn9N
	P6Rcp6aUw+a/hC7SfDxNFnfBKvEBB4PsvQ7xY0aQLL39nkEUW6+deomwTTCEenLJ
	utx55zM+72NedM+4THhwZ901BB6IxkVh0mRQltIex8ojNVdriAM/SjSz1zaa3UIF
	zcy+Rdsf5s9DlSWLteX8qJL4bOFw3r1xd/Xmjh0+njDBINeIED0MNk+U05eBpvcw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br256fy6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 12:51:58 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60NCklSD014942;
	Fri, 23 Jan 2026 12:51:57 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br256fy66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 12:51:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60N9fSBh024583;
	Fri, 23 Jan 2026 12:51:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brxas7d8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 12:51:56 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60NCpqDL41091434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 12:51:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 620CE20043;
	Fri, 23 Jan 2026 12:51:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3677E20040;
	Fri, 23 Jan 2026 12:51:47 +0000 (GMT)
Received: from [9.78.106.105] (unknown [9.78.106.105])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Jan 2026 12:51:47 +0000 (GMT)
Message-ID: <7a5c0997-a5d1-4a2d-8d6a-f2697f575b65@linux.ibm.com>
Date: Fri, 23 Jan 2026 18:21:46 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] powerpc64/bpf: Add arch_bpf_stack_walk() for BPF
 JIT
To: adubey@linux.ibm.com, bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: sachinpb@linux.ibm.com, venkat88@linux.ibm.com, andrii@kernel.org,
        eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, memxor@gmail.com,
        iii@linux.ibm.com, shuah@kernel.org
References: <20260122211854.5508-1-adubey@linux.ibm.com>
 <20260122211854.5508-5-adubey@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260122211854.5508-5-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDEwNSBTYWx0ZWRfX60X9yPmpZv+o
 D6AbgOMbFXnlqHhvVml2SVJY1AhRdIbp5U6y55CtLM5svVigjFEdWA/7FSvgJEZDRJjhemsQXbc
 vFsfs4IM40rHkhT9spuT1QyhqnmRdu3SHA4fud4obttvgrwHayLQISLwtHHzxKzrmVmGXHV/oPz
 0n/MpNq4ynrP/3WEE/VYZRh6rfXoORCWt99nhZNDc+lL9ojxKLEjP8qzg1ukKhOuKLd3NVMaKVS
 vRsJf4cjh54tT40orB9zDLKOOgZwxIy0zFlw40Fohrewg9sD4Ka8aojWBS5GpR7zDKRBWRCg+13
 H1Jv0DKNa8rW6bFeU5YdacBfVbhLK/f8nOOXBLJc16s/dhBiG6U6GUjAdy+T1tIfyvsLDsfs5IZ
 kQifRURL37YLzyHpUkZIW0t9mhYNk/bAWktqWccQ/bZmYbERnHEvCZV7sgdQYq0XeXmpH60+vqo
 PV4OQFcRE1kZjUtCQmw==
X-Authority-Analysis: v=2.4 cv=BpSQAIX5 c=1 sm=1 tr=0 ts=69736eee cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=DG0_Qwyj5ITTcQcW4q8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: eGZ4HzSdcozE9GHkEshG_CPU23K_dgTB
X-Proofpoint-ORIG-GUID: YWWtRqAs31Iq652K2nCfH24MOxC874Mn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601230105



On 23/01/26 2:48 am, adubey@linux.ibm.com wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> This function is used by bpf_throw() to unwind the stack
> until frame of exception-boundary during BPF exception
> handling.
> 
> This function is necessary to support BPF exceptions on
> PowerPC.
> 
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit_comp64.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 18da5a866447..c25ba1ad587a 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -247,6 +247,34 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
>   	bpf_jit_build_fentry_stubs(image, ctx);
>   }
>   
> +void arch_bpf_stack_walk(bool (*consume_fn)(void *, u64, u64, u64), void *cookie)
> +{
> +	// callback processing always in current context
> +	unsigned long fp = current_stack_frame();
> +
> +	for (;;) {
> +		unsigned long *frame = (unsigned long *) fp;
> +		unsigned long ip;
> +
> +		if (!validate_sp(fp, current))
> +			return;
> +
> +		ip = frame[STACK_FRAME_LR_SAVE];
> +		if (!ip)
> +			break;
> +
> +		/*
> +		 * consume_fn common code expects stack pointer(sp) in third
> +		 * argument. There is no sp in ppc64, rather pass frame
> +		 * pointer.
> +		 */
> +		if (ip && !consume_fn(cookie, ip, fp, fp))
> +			break;
> +
> +		fp = frame[0];
> +	}
> +}
> +
>   int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
>   {
>   	unsigned long func_addr = func ? ppc_function_entry((void *)func) : 0;

Ok. Refactoring of arch_stack_walk() & arch_bpf_stack_walk() can be done
as a follow-up, but keep the code as identical as possible. Use 'sp'
instead of 'fp' and 'stack' instead of 'frame' to make it easy to
spot the similarities. Also, a "TODO:" comment on refactoring would
be good..

- Hari
