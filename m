Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F545331EDF;
	Thu, 30 Jul 2026 05:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785390403; cv=none; b=ibsejitSaumjtsbnw0IuM53O3xy3qCpDzApikkvpnFRKdR2K03O8Kd2cr3RVbXtpnTXMwuFDF7YPku9cp7f0rc7kkVGJqFrugOYrTW3NIVG68+3zewbT/11tImhoJ6EAqvqFIHN90UBmYsEF3k0cGP8Nas0kjQVOitPQL0pGxCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785390403; c=relaxed/simple;
	bh=bS/tVn+SGfaNFyKySS5zLI/EazofPS6dYGhJKU3nPj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ub5Jj2qvqQqkO9Ui/lOF0p+CzSMakI5qbWkeHkvtB01l3skfzjn9t7WLD0BaLGL5ycLZsX6loCwGm12Y1N26/up8mDyV5DqhHf3YRGMPU7MsWFXdOAi5l6DOuhLdIGT6rn/uLwOpS5qllXcnKUX1ZGCS1jhKT07M3ER1m2Z3vXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E/beDa0x; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E/beDa0x"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U3mWcY1949656;
	Thu, 30 Jul 2026 05:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lYQcFjm5Tz7CZkime
	WHcrXDTk81MsYoSAgGM9iHh7D4=; b=E/beDa0xRk4usstUShlNxwoo2L7w+SE5Y
	OrgaoE9eQjvdfTLrYvH3inhPbZ0hyYGb89i5WTHRKvlvsUu3HB1mjbbYPh0sdtwH
	MueY/yHk0i+5z3RvcT0LG1zLBtMfDDyi7IioaEf4o/NLPrhg7f6b72PN47doPihV
	3EEV2xvlJhBj04RZA5onKTmqmKXpXs4osWJQwDtbPd4M+Or9LuJZy5Sl+ckKZqCM
	qBOdoUTAcVWR+4lhn3flgrbN/qMEYWpaCkj2vNtu7r1Gwk0t1nWdaqprHt3gyiRg
	mqw9f9g6JDiX80L/z50Hi/sdHwffrWW8FekkftwaGubzel3DwAzOg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd5c49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:46:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U5fKDn021706;
	Thu, 30 Jul 2026 05:46:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y9p33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:46:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U5kCFJ29426012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 05:46:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F22AA20040;
	Thu, 30 Jul 2026 05:46:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD7FC20043;
	Thu, 30 Jul 2026 05:46:08 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.bl1-in.ibm.com (unknown [9.123.13.162])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 05:46:08 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
        memxor@gmail.com, hbathini@linux.ibm.com, chleroy@kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        skb99@linux.ibm.com
Subject: [PATCH v2 1/2] powerpc64/bpf: Fix build break in bpf_jit_emit_func_call_rel()
Date: Thu, 30 Jul 2026 11:16:02 +0530
Message-ID: <e8e582fb425db165a72f00e3337cdf4c6ae383ad.1785387718.git.skb99@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: LVSvdAN3P8yvUrS_40NVsyJ4GFqp65dZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX1PVch7u1owBl
 PbxBG91M80J24+NY1JbLk/EI+awMOgZhpZl8w7hlECp+IMAAzSE/xHKEGY6nWAdsCOgoOo3CIf3
 D5ERiJRc0zbEiX6hhUUPqWeoVu7C6bI=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6ae529 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=1PX3H1HrtLKQNjst9QwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX/NmgTy0eoSU/
 FHcC3z5NaolrJ0sx4upmgMBgJmGvEx8tSRrgPZrLTGHE82ypUYttHF4iShvJ+GY+zuFpleREbpE
 pHPJEeNvayhXUEci0cCAP5oDcRtak2oXJq6DMXewcjdiien8zJGGa9p3NgAKP32mOpHrTXFR7Qw
 pAYz8yPkQUGVqceS9SJqn7n5d7i0oASuXSsWH9F8bkb6tWfdxt2o6MI1y7Lxaygv2tzOH1F1xUy
 4rh6rJZcOFyN2z9PFC4aR/ZtVtALdsLOKN767u4Q03ghJhSsKmFYr6MtxP8UNWDvBBKePz2Rjf6
 nEmhZqEba5T0Zv7usaE7hC2RjEzTaNcL3IWBmkIUwcH0YLIUoLvismGDH24Ye7KR9uuYr4vmkWm
 /6Mt0O0v5rMsERdlUAx9zVEc4nEbZ+GdgVRZNcPVVcrv8+Ijhx4JqCT7P9chuFRIuAdbZutM8K1
 dqxsQoInX9sLM1/PueQ==
X-Proofpoint-GUID: VNMakwWAtmfPvUBiq6yIIq116-Y2ehz8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_01,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300033

From: Madhavan Srinivasan <maddy@linux.ibm.com>

With CONFIG_PPC_KERNEL_PCREL enabled, build breaks with below error:

  CC      mm/dmapool.o
  CC      fs/readdir.o
arch/powerpc/net/bpf_jit_comp64.c: In function 'bpf_jit_emit_func_call_rel':
arch/powerpc/net/bpf_jit_comp64.c:475:13: error: unused variable 'ret' [-Werror=unused-variable]
  475 |         int ret;
      |             ^~~

Commit b55b6b9ad76c ("powerpc64/bpf: Add powerpc64 JIT support for timed may_goto")
introduced "ret" at function scope, but it is only used within its
respective conditional blocks. Same holds true for reladdr. Move both
variable declarations to the scopes where they are actually used:
"reladdr" to the CONFIG_PPC_KERNEL_PCREL block and "ret" to the non-PCREL
else block.

Fixes: b55b6b9ad76c ("powerpc64/bpf: Add powerpc64 JIT support for timed may_goto")
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index dab106cae22b..fc9db691e820 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -471,8 +471,6 @@ static int bpf_jit_emit_func_call(u32 *image, struct codegen_context *ctx, u64 f
 int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
 {
 	unsigned long func_addr = func ? ppc_function_entry((void *)func) : 0;
-	long __maybe_unused reladdr;
-	int ret;
 
 	/* bpf to bpf call, func is not known in the initial pass. Emit 5 nops as a placeholder */
 	if (!func) {
@@ -487,6 +485,8 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
 	}
 
 #ifdef CONFIG_PPC_KERNEL_PCREL
+	long reladdr;
+
 	reladdr = func_addr - local_paca->kernelbase;
 
 	/*
@@ -525,7 +525,7 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
 	EMIT(PPC_RAW_BCTRL());
 #else
 	if (core_kernel_text(func_addr)) {
-		ret = bpf_jit_emit_func_call(image, ctx, func_addr, _R12);
+		int ret = bpf_jit_emit_func_call(image, ctx, func_addr, _R12);
 		if (ret)
 			return ret;
 	} else {
-- 
2.54.0

