Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A6244D690
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 20:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772138607; cv=none; b=NU20bBxEGmf8khiNafSIpafnCVgSAMbCpcp4PELRpmik3V78qPtlNYDpJkGik5ksv9ECtwRl3LQG8HT6KXIRxJ8mCzlPlBD4AmsP9CUv0JgIEU7bhxwue58LEX0JNIxl6vXMWgxdhLamz4zxVVeLzn7ElmslKQvzUQLYq0GVaf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772138607; c=relaxed/simple;
	bh=5/QFxsGx4uOYttK9dZTvW0kYhnnkX/NpCcOt7/jJDpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anDHwzOkGrt24Ogis6OvDxEWDThmxOdBOyOoUT7UXdTwp0vCQGBivKuGCDS5xyakttwUzbAs9VGfETejVMPREB48hqE/i2tIcKgZeiYU8FNwq+80kfYAJFSY2luQm3G0OL1MrGtL2pu9GbSq5ZyjNux+INOjHZHTxv1DNaAFcRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QGp5BP1j; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QGp5BP1j"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QDj9cL1677775;
	Thu, 26 Feb 2026 20:43:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DbXC/Z
	ebeVH7ZcPCmroeYdy31zFjUQNUMhnkXY5apiI=; b=QGp5BP1j9NLoRw0qyKtnVl
	bspnSNAk7XMaOBMCVl9zjD2yCdIZJe7npRkTp+zNeOuEE5qEViQdORH9y8ffOSs/
	IBnlawTMNYgvjVEW4qzsH2DVeKCROyiiIX0gU86bA2oXZCxp/r/p6P0+c+Do3Ctr
	pYOOxDLQp3KJQ0ZshcZsymZe9rinUgMTBOJP4E+zN+46Wmgu4+ej/2M/IGH9gr1P
	wow0ZUMv2Zbww2Hv4erGbjhtnqKt0K+JL2Q2Tlj87YEb1k5ZNqTQU9WnqvMPW//w
	c6Y5bQ931s2x5eJUrsQAh/wKZ8KxgBR4YxIKRv1MVW9KZMEM/1RJtc7+Rl1UhWnA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34cg3cq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 20:43:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61QKbwW7013406;
	Thu, 26 Feb 2026 20:43:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfqdye4kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 20:43:09 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61QKh5r150463086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 20:43:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B20220040;
	Thu, 26 Feb 2026 20:43:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E87E20043;
	Thu, 26 Feb 2026 20:43:04 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Feb 2026 20:43:03 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org, hbathini@linux.ibm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, maddy@linux.ibm.com,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v2 3/4] powerpc64/bpf: Add support for indirect jump
Date: Thu, 26 Feb 2026 20:43:10 -0500
Message-ID: <20260227014315.39980-4-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227014315.39980-1-adubey@linux.ibm.com>
References: <20260227014315.39980-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE4NCBTYWx0ZWRfX7YzVqwXqsAZG
 4jXZjhiAoVO0129rfV2eiLIWt7qWw2yx6aW8vjF/OKKbDTEA5ls+QdrgXtpI8lupc2BT4g3V7Xd
 DCE82bVXgvrmG0Z7HT0Bcn2X46O6pGPHK/jyk/1Lsi364PCBImHT9aRbrF89XDkChOJz7K1CqyH
 xbUWLlakYUfvMzX8lxbvGy8ydO9oTcZFr57+VzJbHrA/Ct4h0gBv5n4QLXvhFlwThG15ES879jm
 qXcTOg3vcA/w80zfO0F70Kh3gAHL9co+B1hWzdOdX/Yt9JuYovnmcj6/nBMg9N/MkLIgtlwttji
 d5iI3dMd6CZFh1EmODUUHQ0M3ZQ0qnezBnVXlVwrA9VFsVrbtZnAcAdzjO9ghMnR0ynTCJE8PV3
 XahyX3+COo5VT81w5hcP5UnFEnbiRw5qJ0I8LAN4QdUm9TGBDTzbQfxAHIhwaHMqnR/LLTOronP
 PAZNG+yllEE/WmRfZTw==
X-Proofpoint-ORIG-GUID: wVhKXsKyf0GQtWjZCFVFVa-DW-aUrCAf
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=69a0b05e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=qf4gfuq51q0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=_W6WOvRXMcVY7OADHKgA:9 a=3ZKOabzyN94A:10 a=k40Crp0UdiQA:10
X-Proofpoint-GUID: wVhKXsKyf0GQtWjZCFVFVa-DW-aUrCAf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602260184

From: Abhishek Dubey <adubey@linux.ibm.com>

Add support for a new instruction

	BPF_JMP|BPF_X|BPF_JA, SRC=0, DST=Rx, off=0, imm=0

which does an indirect jump to a location stored in Rx. The
register Rx should have type PTR_TO_INSN. This new type ensures
that the Rx register contains a value (or a range of values)
loaded from a correct jump table – map of type instruction array.

Support indirect jump to all registers in powerpc64 JIT using
the ctr register. Move Rx content to ctr register, then invoke
bctr instruction to branch to address stored in ctr register.
Skip save and restore of TOC as the jump is always within the
program context.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index c1d011046d8b..2cb550ca1dec 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -1627,6 +1627,14 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 			addrs[++i] = ctx->idx * 4;
 			break;
 
+		/*
+		 * JUMP reg
+		 */
+		case BPF_JMP | BPF_JA | BPF_X:
+			EMIT(PPC_RAW_MTCTR(dst_reg));
+			EMIT(PPC_RAW_BCTR());
+			break;
+
 		/*
 		 * Return/Exit
 		 */
-- 
2.52.0

