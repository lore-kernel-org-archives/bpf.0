Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B7436C5BB;
	Thu, 30 Jul 2026 05:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785390407; cv=none; b=TXKTW1+AHkN7nfsErlKKIyYLb1MGmbCT8PM0X0VmVZajtORDTB4/MrjTxIVNYoHKs65AmZzbavalgwV6pYSqwQdgTWI80+5e+CjkK2Pfalbf9lhQ/ZZVhjLULhV7Jg5xJzOo77vvlmYpvCjRVmiZgkMQxxi5HkOT4kAnMwek1VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785390407; c=relaxed/simple;
	bh=/QeO6UP3+sgdsMVxhL22ZPQUrHeaXUCcsaWrukUI6lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNr4pn6l5eLphJemu8cG2GGad6vrTrpi+bJttOwlv0wpwbDbFPur7ymGdOiExaLEBcW2IcLq3+8s7w4UcA72jIBjMIbfWoTE13OwdM5hAlFvcZsuw0xEQsw7wuNUq2xU5zG9ic77orWW4m1+UwJO4UFo5X3ylqCVszs3lzp94Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PE1lEskG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PE1lEskG"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U3lYeM1933410;
	Thu, 30 Jul 2026 05:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=F7JButPmqY93oJnyq
	KF37Unfz4D/8yGvykpyvEy4ncw=; b=PE1lEskGrccOIi4/VizXn39X9inhTkI8i
	RJVjEKWwBfR+Lt241EN3h1z0IgP8l/mFb6kOorrI8LJrA1M9Opu5Sg5wnbg8Z5j8
	PCizi8kKkVGcOwN0MF+2Ch2TigMxqbHhsGiKvt7WcVa/YnIhdQ8eaQZe+fUtMyTA
	64YimnVuvLj5KYUpskJ/44b6vBwf9fAh2RowAT7+kd9cga+oYGC7/vJ/hWKqCRKP
	rr20aUHUlSrlrWnMmQ0AqQ+/gRXEEP2VU24mQOEYDFrzeaxz8QRGTIcMnIYTgUK7
	wRirZli3x6BsVCdn+h0i2Q3dazNkyw1dw/5iiOVqkSzjxDj6476TQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xx7s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:46:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U5fGOb021842;
	Thu, 30 Jul 2026 05:46:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhhunu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:46:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U5kF0j31588902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 05:46:15 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B6DB20043;
	Thu, 30 Jul 2026 05:46:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BE6A20040;
	Thu, 30 Jul 2026 05:46:12 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.bl1-in.ibm.com (unknown [9.123.13.162])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 05:46:12 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
        memxor@gmail.com, hbathini@linux.ibm.com, chleroy@kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        skb99@linux.ibm.com
Subject: [PATCH v2 2/2] powerpc64/bpf: Fix build break for arch_bpf_timed_may_goto
Date: Thu, 30 Jul 2026 11:16:03 +0530
Message-ID: <f75e5aa911afb984a94c0e85d58b1be5fb428548.1785387718.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785387718.git.skb99@linux.ibm.com>
References: <cover.1785387718.git.skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: qwAsLyK3WCLjOddTDikT6iJDPoDWSiEV
X-Proofpoint-ORIG-GUID: SdHJS_JpRU4nuJM6WBEpMzna7mzz4c6l
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX17BaoulcxSd3
 nGAFhn9pk0oTvgVChoNhqZWXcVKJS4jZjdhaLspN2nzVrm9rnP5rAF5nxgdm2bslTgu9H6ijDSF
 i0VB0XYeHV/3BPeiDW8bN4DcbYAFQRg=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6ae52e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=9jmqCVZ-90AupltRSVkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfXyKPcCpe5ng6g
 JCPx3qw+50pH+Gf82a8zw8v6Dwgt6xJP2jNRDlJs05VpNyIoMcI4gcjrHTthCB5+MHfGmWaINni
 uGb+D+CWbICaOVP0D2c1RtPU9xhhQcdJpKatxk0SdT/79G6yD5kk9p1I9Jle8tjJVKVVbJFWYlN
 G3e7enW7FFYVtaLXpwzCml/ZB+J1K+xZ4Nqf9l/8gtNvMN7Gw+KUI2WzWrhlNqFj1jY4i//zPXe
 xTLLCvTEXX1kMSLn86MhqSA++dShmuGlRhB2bXUsu2+JT1xFXDZ1X6RJ7WnE2xnJqjNPk1YnmcE
 rpj9/aAxYNZn14MuqQkPnSYf5pHNfopsVwcT9GNPc5zQliTr2w2NmU/UZh+nMgDrvc3qKEsjgKg
 SpziypKSJvWeOCJpdOJY14z6VksgplZ8qbd5tMkDWUxZsaa3xEr1a2kIOiPPkf9ywe05/NGciae
 EvvyzPnnOAqjESQkcmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_01,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300033

With CONFIG_PPC_KERNEL_PCREL enabled, calling bpf_check_timed_may_goto()
using a bl instruction results in a link-time failure:

arch/powerpc/net/bpf_timed_may_goto.o: in function `arch_bpf_timed_may_goto':
(.text+0x28): call to `bpf_check_timed_may_goto' lacks nop, can't restore toc

Use CFUNC() macro instead of direct 'bl' to properly annotate the call
to bpf_check_timed_may_goto(). On PCREL builds, CFUNC() expands to
'bl name@notoc', informing the linker that TOC restoration is not
needed, avoiding the "lacks nop, can't restore toc" linker error.

Fixes: b55b6b9ad76c ("powerpc64/bpf: Add powerpc64 JIT support for timed may_goto")
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/powerpc/net/bpf_timed_may_goto.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_timed_may_goto.S b/arch/powerpc/net/bpf_timed_may_goto.S
index 6fd8b1c9f4ac..84ecf6fa7f5d 100644
--- a/arch/powerpc/net/bpf_timed_may_goto.S
+++ b/arch/powerpc/net/bpf_timed_may_goto.S
@@ -36,7 +36,7 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	 * BPF_REG_FP is r31; BPF_REG_AX is r12 (stack offset in bytes).
 	 */
 	add     r3, r31, r12
-	bl      bpf_check_timed_may_goto
+	bl      CFUNC(bpf_check_timed_may_goto)
 
 	/* Put return value back into AX */
 	mr      r12, r3
-- 
2.54.0

