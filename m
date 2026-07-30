Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647E94119E0;
	Thu, 30 Jul 2026 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785422866; cv=none; b=maE8OWqRFYosR6lWIqm3Xg4L6D8uUKCCzWt3ZMx638HVy/+NJXfYG+SUeUTHz6bNAeGN3jie5iNZGhHaLVNSDUKqJxtgEgNyuVIQMkSlpOxqyveb8FJqHwTeiHv44bGySFCYb7LO3Ui10N2Vk3GDhAw32WOF/YHU7goVOUoHpeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785422866; c=relaxed/simple;
	bh=ZJ9DPC8jdccdEzDfXwrwuF+TpwAga08jeTbGhM8J2XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFUcBmJi1ETDcWtbIMBPPYAtDEY6sJDfrvPpATAifT6dyeYTSxVd8olsgmfNKG+GhQo70kIpgOn8lEJIk0GumfAtHptVhfx7NWht6/pEthxlolJW4D81FRFlU+Y+dg2zo4ucKjXmv821btT9zRoPL+rC5Gi7g1VZyojvBYUkjNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OeUPSqO1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OeUPSqO1"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDI6Id3021202;
	Thu, 30 Jul 2026 14:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=alSeA1
	7h/2pJx91nNoz5quCPrJ+IskOUQygWjfwVXMs=; b=OeUPSqO1oc3Aw4KwnUDaxT
	JGJaF6A+zbZtIvIjoULqTjvMKaAhqfUOY8EOTSHWHgv2g/yvahUDLKaKL3nCWpMJ
	5COwEQ2pZrRhrtKGZpoM7IaY4e+Z7zKlaGZawVOtnzUk+j+0sGCGfFz3GtavomiR
	I5GVyLyT/ulC0lU3a6IYvKdTy9i2hGLYn8psgil1VsppYQBKedV7uGU7qqTWypGW
	JG7KUAbG6jkKXo7o1J/DBTSHKEafMZkTSX+KxSzhFIjj76Z0DOPQi+gz5DcCHcYJ
	EAEfcEF2c8lHP8n+bjmk9vNTED5bLtFYBpU4ocJoYTvUI2nMrxL9YIU9fmnZrD/g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjfdv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 14:47:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UEfHjk006327;
	Thu, 30 Jul 2026 14:47:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkbt2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 14:47:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UElfd145482244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 14:47:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09ADE2004F;
	Thu, 30 Jul 2026 14:47:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DD6520040;
	Thu, 30 Jul 2026 14:47:40 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.209.219])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 30 Jul 2026 14:47:39 +0000 (GMT)
Date: Thu, 30 Jul 2026 20:17:37 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v2 2/2] powerpc64/bpf: Fix build break for
 arch_bpf_timed_may_goto
Message-ID: <amtkCdPeeO0ld_d7@linux.ibm.com>
References: <cover.1785387718.git.skb99@linux.ibm.com>
 <f75e5aa911afb984a94c0e85d58b1be5fb428548.1785387718.git.skb99@linux.ibm.com>
 <20260730055641.85ADA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260730055641.85ADA1F000E9@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDExMiBTYWx0ZWRfX4JoFDoIdHd3F
 Ie3NsDpyRsFypPfcxYfZuS8Ga9xQkRpUWLNmMYNADhGhtutZA3SPKnjlyzUBNNFXSIJqUvSxsBI
 QMGzK7SoX9LFbEsCmXpFg9B8LqYiXlo=
X-Proofpoint-GUID: 1s-SfZwOx0x7cglDK3E-1rXKgkmY4NxE
X-Proofpoint-ORIG-GUID: 1s-SfZwOx0x7cglDK3E-1rXKgkmY4NxE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDExMiBTYWx0ZWRfXyGEQslfRf1Nh
 xYLk8Fdl5Umckz/O0jJtUpHe6MO+qTJq2yZVebRc8F6ePOdCiqYrxYgtSUi75uPQz6kFde5mp8y
 Dfl4O8xN1xz2m1LATKWdUX7NgaLSVrIwOwc1Wl2H01X1rPFlhzUuyYsrJnBf7mE8lsn3H2HMIk3
 E2msCldcmfFjtZms1vewP8ebY/dEnjhfUL16vQuLvsV2H1NHGPFYARHKfcIXL4IkRvZRQhZedCp
 flYDJHyiHbrhCSh12BvsC/Smedn/Yp1vAHab66CXAFxOJKA+orlMZ0KJqaNR+tLMkuOkNYtw7e5
 D5FH4hZV311KLUgtKbooWPS5Bcvsp/40VPJjFGeGrMuR/hu0tyaWsESE7o63rpgGq7piC+WrcRs
 ORAbeqwrHs5ZD5col2wcWYBqlSOJCiflMIuceQiOWr0qfwiMbyblSSpfOKvUY6PUuuYT42HfbSi
 XUnexVuDjL/kKVPbG9Q==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6b640f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=AfPCrFpzIVHIp_XhiCoA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300112

On Thu, Jul 30, 2026 at 05:56:41AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The assembly trampoline `arch_bpf_timed_may_goto` allocates a fixed 112-byte stack frame and stores caller-saved BPF registers at offsets `32(r1)` to `72(r1)`. On PowerPC64 Big Endian (ELFv1 ABI), this writes directly into the caller's TOC save area and the callee's Parameter Save Area (PSA), causing silent stack corruption.
> --
> 
> --- Patch [2]: [PATCH v2 2/2] powerpc64/bpf: Fix build break for arch_bpf_timed_may_goto ---
> commit fc9f3132494d759b31f127f67b0e0815b4960f74
> Author: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> 
> powerpc64/bpf: Fix build break for arch_bpf_timed_may_goto
> 
> This commit fixes a link-time failure in the powerpc64 JIT for timed may_goto
> when CONFIG_PPC_KERNEL_PCREL is enabled. It replaces a direct bl instruction
> with the CFUNC() macro to properly annotate the call and avoid TOC restoration
> linker errors.
> 
> > diff --git a/arch/powerpc/net/bpf_timed_may_goto.S b/arch/powerpc/net/bpf_timed_may_goto.S
> > index 6fd8b1c9f4ac8..84ecf6fa7f5dc 100644
> > --- a/arch/powerpc/net/bpf_timed_may_goto.S
> > +++ b/arch/powerpc/net/bpf_timed_may_goto.S
> > @@ -36,7 +36,7 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does the stack frame allocation
> in arch_bpf_timed_may_goto violate the PowerPC64 Big Endian (ELFv1) ABI?
> 
> Before this hunk, the trampoline allocates a fixed 112-byte stack frame and
> saves caller-saved BPF registers:
> 
> 	stdu    r1, -112(r1)
> 
> 	/* Save BPF registers R0 - R5 (r8, r3-r7) */
> 	std     r3, 32(r1)
> 	std     r4, 40(r1)
> 	std     r5, 48(r1)
> 	std     r6, 56(r1)
> 	std     r7, 64(r1)
> 	std     r8, 72(r1)
> 
> Because STACK_FRAME_MIN_SIZE is exactly 112 bytes in ELFv1, writing to
> offsets 40 through 72 places the saved registers directly into the TOC
> save area (40) and the Parameter Save Area (48-72), which the ABI
> reserves for linkage stubs and the callee.
> 
> When bpf_check_timed_may_goto executes, the ELFv1 ABI permits the C
> compiler to spill its first argument into the PSA slot at 48(r1). Will
> this silently overwrite BPF register R3 (stored at 48)? Similarly, could
> linkage stubs clobber R2 by writing to the TOC save area at 40(r1)?
> 
> Since the BPF verifier assumes these registers are preserved by the
> trampoline, this register clobbering could invalidate the verifier's
> safety tracking at runtime and lead to out-of-bounds accesses.
> 
Since this is not related to the change in current patch, will fix this
in another set of patches.

-Saket
> >  	 * BPF_REG_FP is r31; BPF_REG_AX is r12 (stack offset in bytes).
> >  	 */
> >  	add     r3, r31, r12
> > -	bl      bpf_check_timed_may_goto
> > +	bl      CFUNC(bpf_check_timed_may_goto)
> >  
> >  	/* Put return value back into AX */
> >  	mr      r12, r3
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1785387718.git.skb99@linux.ibm.com?part=2
