Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1878137F012;
	Thu,  6 Aug 2026 04:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785989827; cv=none; b=SGEBlCKjyXtrfSGWmvtGToRsylxMNDuUWii60w1fkoLP1j1dI7CE/1g+Q90YEwrGmtNi8nLC4Nrbkn9RvK1qYYl70HDRHs8AlMxtLY9W1ViD7OvzASiXoyFjAzcmIm4XeS6U2tto6cEGwjVNYMUedswVmf0w1Te5CQmmxdOu3GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785989827; c=relaxed/simple;
	bh=PMUpXsRamu19zkSa8s/kLPqrUXOnQwWX2+P5JFaGNFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHzdHEGKdry/yFTZjAtBFAHVZSaFnAmAsY1Mog79tUkG5JGN+AhPVaAGbHYKUo/UNtcm7lIYjyWHRZembLT+HhzeOAnYsripJKTItcO3Pjjom7k6eztpwEgUKWBD8k2w+vHTJAadauUnOQD3p9HQv0RAsuJVMSZO41meA2+cTUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nKB+4Pjm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nKB+4Pjm"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NllpB993261;
	Thu, 6 Aug 2026 04:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=x0VVkL
	MR/hGrHcgCpSJQ0PqiF+s4nKSVP0fVvBdJUqg=; b=nKB+4Pjmu5zGhuJnYZHd4o
	oNkg/xADXWOR0nXJKFxTtUjKdV0tvGVtUNr+Yb+KoUzUa74S3rCPnViOOYvXikZW
	YtRaqIYqXS/sXmzuzAWKxUV8hK/hXw4qFPWwS+A4ZYHU4XnMuVOrJ3MtdlfpMSHv
	hPeSqHKgqKl4WZvmnh1OczZ4sMNPrgpX8pUGw83vP0wyE61x+0zDXM/TxqNO5tA0
	S+ocClVfKEUVv5wVDhWiF42bhcUT2nivSutzC/z9EaRgfTUXnQOocBuQwdGQtk5s
	T+gWyQhRi38CCeydREXWvfW9irdjp6+N32FwfimpT1ys/Tn5t0I0/ossChlxgK9w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77gdv19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 04:16:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6763uIjH026698;
	Thu, 6 Aug 2026 04:16:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k9kep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 04:16:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6764GZIp45613420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 04:16:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F233320040;
	Thu,  6 Aug 2026 04:16:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 050F120043;
	Thu,  6 Aug 2026 04:16:32 +0000 (GMT)
Received: from Linuxdev.j9d-in.ibm.com (unknown [9.123.86.85])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 04:16:31 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
        memxor@gmail.com, hbathini@linux.ibm.com, chleroy@kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com
Subject: Re: [PATCH v2 1/2] powerpc64/bpf: Fix build break in bpf_jit_emit_func_call_rel()
Date: Thu,  6 Aug 2026 09:46:30 +0530
Message-ID: <178598971877.942627.13081813570192663692.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <e8e582fb425db165a72f00e3337cdf4c6ae383ad.1785387718.git.skb99@linux.ibm.com>
References: <cover.1785387718.git.skb99@linux.ibm.com> <e8e582fb425db165a72f00e3337cdf4c6ae383ad.1785387718.git.skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAyNSBTYWx0ZWRfXwnNV+zBGLAsu
 pH5Vs7FdP0fwcKGmOaj0nddk6OQDZv9UFvP6lHwtJSnJbZgcS665Byr62Mqqth55tfENOuxLcYF
 LvvzzjtpuJ2m9J4yS3ARrnVVzaPUnzffuVSaFExAUnmnB9af6YfKzkvD0xckYBw5eRkiuuDrxIF
 LP/Ls3JgdMukxIR5mBqQDbuA3h1mTwEkHSSsqrcDxIwdaD86WDYXf65/Ik1l2ETpAjmxjXfcN5a
 4DEj7eNo7c4Q7mk19Fm/qEYnNJvxIxyPOVGB83wOvKOZZyxFdv2lo62bKhtrXiK4e4QmnAW6FT5
 dLW0lABQFD23TEbR6Rj64BEQ0Po6gz+BJESAOojrhAwvBDbXZkgTV0SZuQw1M271BIzuNVhUQec
 LDngrbe7dNpziroHW5mn6PeeE3yFfaKyPsQk2ptCLJF0ZqNrB4bsFDJpDfph+b3bPsfkW+ikVzw
 PnXDWWD3rHjU0e5mMUA==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a740aa8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=PYhWMvAcGiom0epyy1YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mK-F5A29MI63cB6GShHH3wAVyVJ1jBWa
X-Proofpoint-ORIG-GUID: _Vla3WCVPhYqydr0C6CEKJaHrdYNXqp-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAyNSBTYWx0ZWRfXyn5QL39qkWcg
 4Yj7rymqdWQCuQyJYKQwlsssbaG3jR+EjqngahzToIxf0DKuuPqCmnk/7pY+9gs8kYi0Jh14T2Z
 V8eIe59VU6PcOcDdhvZELK0DlVXEQ20=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060025

On Thu, 30 Jul 2026 11:16:02 +0530, Saket Kumar Bhaskar wrote:
> With CONFIG_PPC_KERNEL_PCREL enabled, build breaks with below error:
> 
>   CC      mm/dmapool.o
>   CC      fs/readdir.o
> arch/powerpc/net/bpf_jit_comp64.c: In function 'bpf_jit_emit_func_call_rel':
> arch/powerpc/net/bpf_jit_comp64.c:475:13: error: unused variable 'ret' [-Werror=unused-variable]
>   475 |         int ret;
>       |             ^~~
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc64/bpf: Fix build break in bpf_jit_emit_func_call_rel()
      https://git.kernel.org/powerpc/c/e8ee988c0087248324dbd3da486d22045e4a4079
[2/2] powerpc64/bpf: Fix build break for arch_bpf_timed_may_goto
      https://git.kernel.org/powerpc/c/e1e5e682511eda648aa91372542cc8f665ad0bff

cheers
