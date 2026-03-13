Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E4132D7F8;
	Fri, 13 Mar 2026 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773393628; cv=none; b=D26tS5A3B+MpLty/gIrunMUOIJyRbpT1p6l5MyBEEAiX4vFj3AxuhPVmG1NQc90oLx5DwFFmE7PP6IPhAlle5Q+0Eav8/d2GKsCLulUrdfjyzqRk9WFk8YvBLh1eWLOr98ltHnGv/wPre8m+feR9us0fYdiF6yHg7gz9Ce+bCAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773393628; c=relaxed/simple;
	bh=LjVfHbuCi9KhwfIom84fPNpVagtgwGp1sxoaiWQHbnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXA5H6ew83ULUPlsVEpFTLa1zcQjJN9FcZAosF+qGmjo4MjwQ6DlS1lv14mlikYopkAsIHcDGhcrQrRoPkS3GK/aMTU0K1rGTs/bPt/YiKRtiv8FHwqv0wyXBOSw3r3Km+RA3mhHgQJSdnlNAwKbKXuqafqy8lGblQqe69owV3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f7NNatSg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f7NNatSg"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5FCZp2259751;
	Fri, 13 Mar 2026 09:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=V1+YR2
	Gdrd+c9EUfP6/xgveOWhZcEejcxEcFlrcqYig=; b=f7NNatSgeMwofON7IXGgV2
	5/iCIMw/JcQ2nerYbxxqkhFDHqc8Dw5z/f/Ik4Zsa0YbZkrMncpUOOXi0ICYuBMG
	+uWGD9NEjxuQe7tVdeQUeAUI3qLipsFjRr4slA2cIH6StRsyU/TTpkempu8BzudE
	Dx3T+z4HnT1Srvvcp53EcKboHdK6VGDqO8GT4twroKAkeVLTh/hsMly4j4Q920kQ
	U7LfxzIGcXgX7BwvhFXjwrd5gfjWyI5hUYbz7z/dr2A+LjckPfw23++NO8iMP/tf
	0WWGucu/VhYioVTViueuQ9Vqet5OcZ154Jo4AgKSOQgKFG9XOYzjYOSQIvyGKNrQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh92f0km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 09:19:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62D5rRVX006048;
	Fri, 13 Mar 2026 09:19:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha9p0mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 09:19:10 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62D9J60F42992108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 09:19:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F5682004B;
	Fri, 13 Mar 2026 09:19:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4C742004D;
	Fri, 13 Mar 2026 09:19:00 +0000 (GMT)
Received: from [9.78.106.17] (unknown [9.78.106.17])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Mar 2026 09:19:00 +0000 (GMT)
Message-ID: <964fc2e2-35b9-4140-8da1-b029cb88aa7a@linux.ibm.com>
Date: Fri, 13 Mar 2026 14:48:59 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 1/5] bpf: Move constants blinding out of
 arch-specific JITs
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Puranjay Mohan <puranjay@kernel.org>,
        Anton Protopopov <a.s.protopopov@gmail.com>,
        =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
        Shahab Vahedi <list+bpf@vahedi.org>,
        Russell King <linux@armlinux.org.uk>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Hengqi Chen <hengqi.chen@gmail.com>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        Paul Burton <paulburton@kernel.org>,
        Christophe Leroy <chleroy@kernel.org>,
        Naveen N Rao <naveen@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>,
        Xi Wang <xi.wang@gmail.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>,
        Pu Lehui <pulehui@huawei.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Wang YanQing <udknight@gmail.com>
References: <20260312170255.3427799-1-xukuohai@huaweicloud.com>
 <20260312170255.3427799-2-xukuohai@huaweicloud.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260312170255.3427799-2-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: K6iQIqtcHiOhj0jt5YOl9BPIdRId6aPX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA2OSBTYWx0ZWRfX/HhShxc5s1z4
 dWMYyYgcFmi2bJ7BygCuAJaTE+3Kl48WmlUKGQDaHMaKMrqatLg/KnZcCyzQI0OKPOxH7r/2mTi
 FeV47pICGPE1DyWXosmR3v+xcIJrd332wLTZnr8iZuqyKfXQoLSdxhB+X17RDZ7kepbVN/pRQgz
 c1wRDUVLwsAIg/5ZCDWbb83dlJ4Mnma9Ncm2rqZmCnewNe+vuhldD4W7url4HuL7Hi4C2ifjw+5
 spNCnl40nupLQ3I5WQMFva9rU6PIH8QSFxTE6f3Wd6uHYQ0+WTqcWMZERRCuilCcEBiCzHGxh96
 8R/3ZQRMda8R+uY33nPi+yOjp4uVWlspadyljJcv8ZchNBkYplciQNYAcX8P3FS2JMxArJL+3zq
 KrP0FnENLTNsInrMcD7Mk3GMDOgEvoH7V9/XB4ExGNAK2XDJ40EfPUwRWhBiF+aljMP9Z7Yugy0
 yeZRphGmk6f1PAsomvQ==
X-Proofpoint-GUID: y778cEH1Rcqpg0fCF-EUAUmzmFGyDyc1
X-Authority-Analysis: v=2.4 cv=XNk9iAhE c=1 sm=1 tr=0 ts=69b3d68f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=i0EeH86SAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=65AwDx3lZvNIrb5Zd-wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130069



On 12/03/26 10:32 pm, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> During the JIT stage, constants blinding rewrites instructions but only
> rewrites the private instruction copy of the JITed subprog, leaving the
> global instructions and insn_aux_data unchanged. This causes a mismatch
> between subprog instructions and the global state, making it difficult
> to look up the global insn_aux_data in the JIT.
> 
> To avoid this mismatch, and given that all arch-specific JITs already
> support constants blinding, move it to the generic verifier code, and
> switch to rewrite the global env->insnsi with the global states
> adjusted, as other rewrites in the verifier do.
> 
> This removes the constants blinding calls in each JIT, which are largely
> duplicated code across architectures.
> 
> Since constants blinding is only required for JIT, and there are two
> entry functions for JIT, jit_subprogs() and bpf_prog_select_runtime(),
> move the constants blinding invocation into the two functions.
> 
> If constants blinding fails, or if it succeeds but the subsequent JIT
> compilation fails, kernel falls back to running the BPF program with
> interpreter. To ensure a correct rollback, the program cloning before
> instruction rewriting in the constants blinding is preserved. During
> the blinding process, only the cloned instructions are patched, leaving
> the original program untouched.
> 
> Since bpf_patch_insn_data() is chosen for the constants blinding in the
> verifier path, and it adjusts the global auxiliary data in the verifier
> state, a key question is whether this auxiliary data should be restored
> when JIT fails?
> 
> Besides instructions, bpf_patch_insn_data() adjusts env->insn_aux_data,
> env->subprog_info, prog->aux->poke_tab and env->insn_array_maps. env->
> insn_aux_data and env->subprog_info are no longer used after JIT failure
> and are freed at the end of bpf_check(). prog->aux->poke_tab is only
> used by JIT. And when the JIT fails, programs using insn_array would be
> rejected by bpf_insn_array_ready() function since no JITed addresses
> available. This means env->insn_array_maps is only useful for JIT.
> Therefore, all the auxiliary data adjusted does not need to be restored.
> 
> For classic BPF programs, constants blinding works as before since it
> is still invoked from bpf_prog_select_runtime().
> 
> Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>   arch/arc/net/bpf_jit_core.c      | 39 ++++++-----------
>   arch/arm/net/bpf_jit_32.c        | 41 +++---------------
>   arch/arm64/net/bpf_jit_comp.c    | 72 +++++++++----------------------
>   arch/loongarch/net/bpf_jit.c     | 59 ++++++++------------------
>   arch/mips/net/bpf_jit_comp.c     | 20 +--------
>   arch/parisc/net/bpf_jit_core.c   | 73 +++++++++++++-------------------
>   arch/powerpc/net/bpf_jit_comp.c  | 68 +++++++++++------------------
>   arch/riscv/net/bpf_jit_core.c    | 61 ++++++++++----------------
>   arch/s390/net/bpf_jit_comp.c     | 59 +++++++++-----------------
>   arch/sparc/net/bpf_jit_comp_64.c | 61 +++++++++-----------------
>   arch/x86/net/bpf_jit_comp.c      | 43 +++----------------
>   arch/x86/net/bpf_jit_comp32.c    | 33 ++-------------
>   include/linux/filter.h           | 11 ++++-
>   kernel/bpf/core.c                | 66 +++++++++++++++++++++++++----
>   kernel/bpf/verifier.c            | 40 +++++++++++------
>   15 files changed, 281 insertions(+), 465 deletions(-)
> 
[...]

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 52162e4a7f84..c9daa1a72378 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -142,9 +142,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>   	int flen;
>   	struct bpf_binary_header *fhdr = NULL;
>   	struct bpf_binary_header *hdr = NULL;
> -	struct bpf_prog *org_fp = fp;
> -	struct bpf_prog *tmp_fp;
> -	bool bpf_blinded = false;
>   	bool extra_pass = false;
>   	u8 *fimage = NULL;
>   	u32 *fcode_base;
> @@ -152,24 +149,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>   	u32 fixup_len;
>   
>   	if (!fp->jit_requested)
> -		return org_fp;
> -
> -	tmp_fp = bpf_jit_blind_constants(org_fp);
> -	if (IS_ERR(tmp_fp))
> -		return org_fp;
> -
> -	if (tmp_fp != org_fp) {
> -		bpf_blinded = true;
> -		fp = tmp_fp;
> -	}
> +		return fp;
>   
>   	jit_data = fp->aux->jit_data;
>   	if (!jit_data) {
>   		jit_data = kzalloc_obj(*jit_data);
> -		if (!jit_data) {
> -			fp = org_fp;
> -			goto out;
> -		}
> +		if (!jit_data)
> +			return fp;
>   		fp->aux->jit_data = jit_data;
>   	}
>   
> @@ -194,10 +180,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>   	}
>   
>   	addrs = kcalloc(flen + 1, sizeof(*addrs), GFP_KERNEL);
> -	if (addrs == NULL) {
> -		fp = org_fp;
> -		goto out_addrs;
> -	}
> +	if (addrs == NULL)
> +		goto out_err;
>   
>   	memset(&cgctx, 0, sizeof(struct codegen_context));
>   	bpf_jit_init_reg_mapping(&cgctx);
> @@ -211,11 +195,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>   	cgctx.exception_cb = fp->aux->exception_cb;
>   
>   	/* Scouting faux-generate pass 0 */
> -	if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false)) {
> +	if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false))
>   		/* We hit something illegal or unsupported. */
> -		fp = org_fp;
> -		goto out_addrs;
> -	}
> +		goto out_err;
>   
>   	/*
>   	 * If we have seen a tail call, we need a second pass.
> @@ -226,10 +208,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>   	 */
>   	if (cgctx.seen & SEEN_TAILCALL || !is_offset_in_branch_range((long)cgctx.idx * 4)) {
>   		cgctx.idx = 0;
> -		if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false)) {
> -			fp = org_fp;
> -			goto out_addrs;
> -		}
> +		if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false))
> +			goto out_err;
>   	}
>   
>   	bpf_jit_realloc_regs(&cgctx);
> @@ -250,10 +230,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>   
>   	fhdr = bpf_jit_binary_pack_alloc(alloclen, &fimage, 4, &hdr, &image,
>   					      bpf_jit_fill_ill_insns);
> -	if (!fhdr) {
> -		fp = org_fp;
> -		goto out_addrs;
> -	}
> +	if (!fhdr)
> +		goto out_err;
>   
>   	if (extable_len)
>   		fp->aux->extable = (void *)fimage + FUNCTION_DESCR_SIZE + proglen + fixup_len;
> @@ -272,8 +250,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>   				       extra_pass)) {
>   			bpf_arch_text_copy(&fhdr->size, &hdr->size, sizeof(hdr->size));
>   			bpf_jit_binary_pack_free(fhdr, hdr);
> -			fp = org_fp;
> -			goto out_addrs;
> +			goto out_err;
>   		}
>   		bpf_jit_build_epilogue(code_base, &cgctx);
>   
> @@ -295,15 +272,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>   	((u64 *)image)[1] = local_paca->kernel_toc;
>   #endif
>   
> +	if (!fp->is_func || extra_pass) {
> +		if (bpf_jit_binary_pack_finalize(fhdr, hdr))
> +			goto out_err;
> +	}
> +
>   	fp->bpf_func = (void *)fimage;
>   	fp->jited = 1;
>   	fp->jited_len = cgctx.idx * 4 + FUNCTION_DESCR_SIZE;
>   
>   	if (!fp->is_func || extra_pass) {
> -		if (bpf_jit_binary_pack_finalize(fhdr, hdr)) {
> -			fp = org_fp;
> -			goto out_addrs;
> -		}
>   		bpf_prog_fill_jited_linfo(fp, addrs);
>   out_addrs:
>   		kfree(addrs);
> @@ -318,11 +296,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>   		jit_data->hdr = hdr;
>   	}
>   
> -out:
> -	if (bpf_blinded)
> -		bpf_jit_prog_release_other(fp, fp == org_fp ? tmp_fp : org_fp);
> -
>   	return fp;
> +
> +out_err:
> +	if (extra_pass) {
> +		fp->bpf_func = NULL;
> +		fp->jited = 0;
> +		fp->jited_len = 0;
> +	}
> +	goto out_addrs;
>   }
>   
>   /*

Other than moving constants blinding out of arch code, this also
improved error handling in powerpc JIT. Looks good to me.
For the powerpc part:

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
