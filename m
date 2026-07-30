Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49FE42F710;
	Thu, 30 Jul 2026 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785416911; cv=none; b=fmB7V/JPgmxznInO9xpbl4Ts3MOHyad99DCyK4WEgNhyf5ra00ieuUBqwJgUO4x0T9Bwo3h5/W6dKK3Bvf/YXkIoe6m2kAaQPNtOMYJcoxnOgdxxVN4kueol6D0ct+jtEpbFgL167nJm15NUT2Hfmwwewp74O5XUM2WEZ0Onq7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785416911; c=relaxed/simple;
	bh=VDCT+KByYx5g4iT3iOfkbZ2/qzUZZ6nDIfofCWRS0dE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+5GpYnVEuNOSCkzauI2kH0aGr1WDTojfQoIOPr7agMgukLyp43cSRXUxysftAtFV3eYPT+ZNFAeajD5Cf2zYJaMFA1OLmL9kVm2SWaVkpq/QhIa/F2AAvl7yWC5rGkWFecNGDJJrOzSAKSbDboCOTnUylbONO93wGZA5MjZLFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RMYdfH8Q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RMYdfH8Q"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UAHbo82708719;
	Thu, 30 Jul 2026 13:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=u8zch5
	DmNk58Rw/ACUH+ptO4cOhIAPQGkh8Kp7jvTDo=; b=RMYdfH8QSeYqYi82xF8cZG
	5OBajZhuJxfNMvRKj20CFsDogB/Y9WqxdftKsz8hySzMC4RhQ3L6rmwsgILzFhwN
	ULmSVuzD58zIiF8iAYvs0YF+xddbxi2r2sZWWWfpEve8MFs19F0Ox7J7fN3JcWCS
	u2e9li9ijemicVSbKhcDATcfhsS2WWI+IAeocr5xnu4MM03T2TtaE4bU+9xYudwm
	r5bf1QJ3vMzvilNmDU4Cv+O15lvm2megp0mNFgeZsDdH9lUTxUJPlm/nIMATgxni
	a1tO8leWxDXZ+Z6bI6jD3nTC5TwOAfe3nMxzaCSSTFPmPjjavfTv2VD4PQnWy/VA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7qu2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 13:08:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UCuOrx019237;
	Thu, 30 Jul 2026 13:08:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwbjjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 13:08:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UD7x1S16712054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 13:07:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AA8D2004B;
	Thu, 30 Jul 2026 13:07:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D470820043;
	Thu, 30 Jul 2026 13:07:55 +0000 (GMT)
Received: from [9.124.210.70] (unknown [9.124.210.70])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 13:07:55 +0000 (GMT)
Message-ID: <c4a967b3-940c-4707-b5fe-7db0dff77931@linux.ibm.com>
Date: Thu, 30 Jul 2026 18:37:54 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] powerpc64/bpf: Fix build break for
 arch_bpf_timed_may_goto
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
        memxor@gmail.com, chleroy@kernel.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com
References: <cover.1785387718.git.skb99@linux.ibm.com>
 <f75e5aa911afb984a94c0e85d58b1be5fb428548.1785387718.git.skb99@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <f75e5aa911afb984a94c0e85d58b1be5fb428548.1785387718.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: aqzt8hE_M2rQIWFLqgp3b0dvEuElntKB
X-Proofpoint-ORIG-GUID: egI5O4Y6d7wnw4oBHdjcVH2G3QsxkYqg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA5NiBTYWx0ZWRfX6O1sHYUFN3ao
 QT63XzF5DVr4QyDKaFYJ03gVSN0wLS3Fu+i5kjSgsayiHsGYG+4fkZygqxzprjrgPlfoL5IGvf3
 /SLsBxrdnx0U8vo6h4ww0dFuAaDtbB35fl8u+4AKmm9+VQR8yu5yUH+YuIKBt0yZ4XTwcE2iBRE
 xbUEV3Cl/ZUoaXvVQXp7aYHQqvbW+b+5co+ccogtqmzygeS8MkxTsCXYaOJt17284dnxB27gZBh
 wgGDmbbHlvrn7Z1DQmDAn6Hr357bEFEQs5j1tM37REvRCJ5inrLs7/5SxZU8P7bPYddSi2NpSX1
 5HNAE4sW6ZVjDdChHu2DhbpBXIQbzIkccXlZD3OhTTZh/6h3Q6n7ayUy5sBBSi+uNj5eXw3Lk2f
 POagM0Tfbne8TVq3gs/T/Y5eKpLOhJ1ZsHiNTrJIIGC2LKS0sF9t2ZraSfrr57uQvlSVwf9GE5s
 j0e3radeDbKzfKBYQqQ==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6b4cb5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=rbBgSRKb6kQpm1DpxiIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA5NiBTYWx0ZWRfX2YpFvWcSETzj
 9Q4Zti2fkP2w5DT1mGfwMjDto5RgMYVnO4VKvT2PByJrlXvKuTACFM2qjVqTsKLQTX70bPR9MSH
 mRDdMNLhq6cTmXfHQjVw3ar/Fkw7uPg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300096



On 30/07/26 11:16 am, Saket Kumar Bhaskar wrote:
> With CONFIG_PPC_KERNEL_PCREL enabled, calling bpf_check_timed_may_goto()
> using a bl instruction results in a link-time failure:
> 
> arch/powerpc/net/bpf_timed_may_goto.o: in function `arch_bpf_timed_may_goto':
> (.text+0x28): call to `bpf_check_timed_may_goto' lacks nop, can't restore toc
> 
> Use CFUNC() macro instead of direct 'bl' to properly annotate the call
> to bpf_check_timed_may_goto(). On PCREL builds, CFUNC() expands to
> 'bl name@notoc', informing the linker that TOC restoration is not
> needed, avoiding the "lacks nop, can't restore toc" linker error.
> 

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>

> Fixes: b55b6b9ad76c ("powerpc64/bpf: Add powerpc64 JIT support for timed may_goto")
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> ---
>   arch/powerpc/net/bpf_timed_may_goto.S | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/net/bpf_timed_may_goto.S b/arch/powerpc/net/bpf_timed_may_goto.S
> index 6fd8b1c9f4ac..84ecf6fa7f5d 100644
> --- a/arch/powerpc/net/bpf_timed_may_goto.S
> +++ b/arch/powerpc/net/bpf_timed_may_goto.S
> @@ -36,7 +36,7 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
>   	 * BPF_REG_FP is r31; BPF_REG_AX is r12 (stack offset in bytes).
>   	 */
>   	add     r3, r31, r12
> -	bl      bpf_check_timed_may_goto
> +	bl      CFUNC(bpf_check_timed_may_goto)
>   
>   	/* Put return value back into AX */
>   	mr      r12, r3

