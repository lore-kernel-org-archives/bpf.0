Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60967311968
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 02:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773195267; cv=none; b=tcmsV7GDFDoIsejcXIYLZ6bqB8DYBo1hcjzZZ8rK8OwpY7fwGMnbQTp3UKCGlrEUojPer5E9L4ulZO2zTfTClImMwNUP/o4GuFxzAYusEiCyD/B0Z7rceaPaG2HuGSULZuvB52a355S03kzAd+Z8lDJl682t2Jg3OdzcDq9SiZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773195267; c=relaxed/simple;
	bh=R/FuKT4sVVaoqPze5PBEzM3e4Q6QcFxbH+TNvr40RvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aK9jZi0Q4Pzr/KXTniAnQTcmW9+nh3nPGE/Byoxd+h9hPBj+n6pDM86ncaqyqr6UfBmZPkTqE/QgJDJAs7XWZtv5/FwVczUdo9jNWk7+x9fN3TdjRJUQgEuAN9havonkrCz29W8Piex333rwwUxoM2dcFGMo0mMfX76wivUw5yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GSY1u04E; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GSY1u04E"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B1JPh81764289;
	Wed, 11 Mar 2026 02:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=omegfS
	C/naUJ/me4BJnKHHPViowBHhuButMY5ic7kQk=; b=GSY1u04EaLmpEJCaCuZJNk
	RyKxXNFaPhcdtIpWe0ZQ+KpcvpuR66Kv9P6lRnuJd+5rbWOEYyf2i0TmUqwSQffH
	g5X7iLudOsJanusNc95Wg2DzQQOMliFNQAvNDk7ZgwagE4kaIGX7mFjUkaLh5zpc
	tyXMisILk3OEh+hlsx8x0Deun491WtTU1zSjd5Ejk0xWV46xrQbVSzEyiBAtBIkX
	CVFiQlSMWnLF9mS40iLUlNGvRnz8YMScXGgVVUjZYmbT2DFf4Ek0cujkw1GaI0VJ
	qML1dG33o7m+m4isasHSuPbmlEEoE8FNAbrw8dcKaJo7oHJlTdr/wnJLPmD62FSQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcuydsk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:14:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62B0cf22029359;
	Wed, 11 Mar 2026 02:14:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4csp6ur8x3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:14:09 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62B2E5on30867718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 02:14:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92EA820067;
	Wed, 11 Mar 2026 02:14:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBE6820063;
	Wed, 11 Mar 2026 02:14:02 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.124.195])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 02:14:02 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Hari Bathini <hbathini@linux.ibm.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Abhishek Dubey <adubey@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH v4 0/6] powerpc64/bpf: various fixes
Date: Wed, 11 Mar 2026 07:44:01 +0530
Message-ID: <177319508345.269267.12670103641877227517.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303181031.390073-1-hbathini@linux.ibm.com>
References: <20260303181031.390073-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EK4LElZC c=1 sm=1 tr=0 ts=69b0cff2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=9Bv8LlECD2avGt_Yqv0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAxNiBTYWx0ZWRfX9WxFJqfY5rjO
 gLZqQoYvxna6J1RG+6hTXjdnFkQtMdjdWPKsyutQXxdRxUqroxCCrbq/0oQ9WauxapGK7B6dreY
 osu2KWqYssn3RYnqJZX9mqoFKx17yC84p8MyhDnN38mKyM4zy2S07WVW3Om3VKSvL4lPFOMTSQM
 IevPNHX1rNxcjg3gU8he0ZA/Yb3kaRXnuhBNScI7Dx5VyvhHd4FG030Obrs43PkIbM3RhfuXj2S
 LtU9SIUWsnamDvDhhLpr5uJbdkmEyZp2Y9DzqhgY7XynN68bO0n2LMFDfl+vT4STwIOTayNAnJ/
 Yd9ay13Xu/GK0SLM60VGtxTMjBgAUr67h+g8R/f6lB1j4sfZJAdrtDJbS62K6a1+WE4R5NGyrB0
 bnpljKl6S4mKxbsw35wOezuoYabjIBayRpRoZkTjTJWLRYujfCDkHIAW52C2uNwdgvPZ2Qhlv9n
 dxpyCbEOA2gvl7mUXyQ==
X-Proofpoint-GUID: jCpWQnDs3LUG0CJE5W4-gzrJaXf-uDRk
X-Proofpoint-ORIG-GUID: jCpWQnDs3LUG0CJE5W4-gzrJaXf-uDRk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1011
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110016

On Tue, 03 Mar 2026 23:40:24 +0530, Hari Bathini wrote:
> List of fixes for powerpc64 BPF JIT:
> - Patches 1, 2 & 6 fix issues with existing powerpc64 JIT and are
>   tagged for -stable.
> - Patches 3 & 4 resolve issues with bpf2bpf tailcall support added
>   recently.
> - Patch 5 resolves an issue reported by bot+bpf-ci@kernel.org while
>   adding exceptions support on powerpc64 BPF JIT.
> 
> [...]

Applied to powerpc/fixes.

[1/6] powerpc64/bpf: do not increment tailcall count when prog is NULL
      https://git.kernel.org/powerpc/c/521bd39d9d28ce54cbfec7f9b89c94ad4fdb8350
[2/6] powerpc64/bpf: fix the address returned by bpf_get_func_ip
      https://git.kernel.org/powerpc/c/157820264ac3dadfafffad63184b883eb28f9ae0
[3/6] powerpc64/bpf: use consistent tailcall offset in trampoline
      https://git.kernel.org/powerpc/c/3727d6ec13665c1d99bf6dedb107104368ba42b4
[4/6] powerpc64/bpf: remove BPF redzone protection in trampoline stack
      https://git.kernel.org/powerpc/c/2d347d10f8e20e28a9eab52edf55079ae1ec0aae
[5/6] powerpc64/bpf: fix handling of BPF stack in exception callback
      https://git.kernel.org/powerpc/c/51b8de4b3d27ec12128fa2405e526c527a77ae65
[6/6] powerpc64/bpf: fix kfunc call support
      https://git.kernel.org/powerpc/c/01b6ac72729610ae732ca2a66e3a642e23f6cd60

cheers
