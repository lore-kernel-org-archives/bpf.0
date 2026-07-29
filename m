Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1314968FA;
	Wed, 29 Jul 2026 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341077; cv=none; b=W2+O8b59bdIs8EhncnpW1qibI6KF1tc/raS/TeYuDtKGO1B8/MY7XfvDiWJ3DlPf3Rl08OUwCLjzqDr0I9f3bdCuCKSbDb3lx6BKDNsk2EF0dc3UbxNF6/6K2Po9aiX+rWZKNwqptt6dPw/BF+VV0DLmzw6WCAZAyvuaRkgX2AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341077; c=relaxed/simple;
	bh=FG4C98t6MGW2XnXOu4G3zWdpDlOnWj0aiBGmuM32XgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hREQjJORHDgmEPMk2WiKc9GJtv+ZCEdPUha54keL7h0kvTxBzq4ZgRi9Ze4bN41NcIoGqpgdwfhMTrc4N3sZ9zD5FavpkKix40vKyU1jAcUFJXS4wxnefXFOcmlQcF2Jn+/490jAEz2P9WfMk51V6TibDtHh34WK3Ui1cnEjsvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hU1Tb+8V; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hU1Tb+8V"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFHiwL282925;
	Wed, 29 Jul 2026 16:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GGoeNYhwb5eAHemQH
	LhW0LiwRcXg2k+NM6/nMNCEjUU=; b=hU1Tb+8VTMXkanIFq7UI5l5FDHu8xMFu+
	mK5j4vfCbbgF03KlzMR/lef7bsaNEhkak0vaX047Pzsggw/0RClfAkxF+qw36Ttm
	7uLtGnNG1qUgkR+gdPfaE3+jNUVvxlFvAzF0kchL3GcvA3Q7yi74NUz6/+jszoI9
	VZ75yv+Wdqj8KpY3WCPDsuuolK21cctOknel0wUQ1XHDxA+f6bWBqA+Je9xn4A4J
	feHnl/bYiLp1V0Sd0JWS3uqEG4ZGES89kULsoCj8pqvg5UufUbWftKCdtWuf8qgU
	h1IdmjAXPqKHZZ0pLDxlHGasOGa2761y7TAQB+irg7O+V773xLwwg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0ntqxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 16:04:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFuHRB030882;
	Wed, 29 Jul 2026 16:04:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhfa5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 16:04:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TG45CI16908548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 16:04:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB04520040;
	Wed, 29 Jul 2026 16:04:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6057920043;
	Wed, 29 Jul 2026 16:04:01 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.39.22.107])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 16:04:01 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
        memxor@gmail.com, hbathini@linux.ibm.com, chleroy@kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        skb99@linux.ibm.com
Subject: [PATCH 2/2] powerpc64/bpf: Fix build break for arch_bpf_timed_may_goto
Date: Wed, 29 Jul 2026 21:33:50 +0530
Message-ID: <c57271230ed1c33fffe0704de86d2ee8a557a553.1785339155.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785339155.git.skb99@linux.ibm.com>
References: <cover.1785339155.git.skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNiBTYWx0ZWRfX4hwRm99sAHrw
 Pbxb+l07MAzFQuYnLQoNg/DpvWODo5HXbVkMbUBl6Q2mMHspmqXuG75I7OcY3ag15RFAvEk8BY+
 W1eakzGDpqWYBBqK1I4vqRgN/zWTiB0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNiBTYWx0ZWRfX4kiQEBfuKahl
 mmWcwEIxAk8IK89wFBI5mrb7AQXMV/6NGJjJInegTYGhoepWQXxU/uUgb6AxR+1/Qs/DnWrdj5i
 YCKqG4YysGuEt1gglnYeObYsSktvQvL5Ci1WCnclgXUIdgUbculaD7abECmwJmcU74SV3uX5HQH
 cl+UJmLDRrgeEdw2zq70PlR94O2Sif9hTK4ggRcM9ZncaGVrHzN3xhmxZlGMt4gVGq+lcmFjT3H
 a1jIwr9lm/AatLk/+vozcQ1Rk2eqDvlSHJ+QBV8aHxIOn2d3k99nI7NxTnuez1pkF6wtaO+4+xS
 EAhxLO05+7UXgDQIvc/4+hjkKm75+a8O8503J/GUzSwLunAaHpRr4FxVYex0j856bdnOCKVbYxa
 XVWdPSNqWK3EG7dINl083VhFoBa2n2Ot7CouOHFsv/26xfPkfgvwOMY4uaxVEcnsvq1uDjeuKME
 J6JPWw9gjHHT0zCR20Q==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6a247a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=9jmqCVZ-90AupltRSVkA:9
X-Proofpoint-GUID: _zBCEUJEnPUWlD_BYqG5g_96W8nvnSf2
X-Proofpoint-ORIG-GUID: mmqwLI-ihXcESt3U65b0r4XnfNLK0G_y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290126

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

