Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88563F7A99;
	Wed,  1 Apr 2026 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042512; cv=none; b=VJSgF62UK+huv8JJu7U/U2s6Oa/2ug8QDyWxGkL+WLdLLBHIPDzvUrOhOOUFo7eg2gLcJ2eWEsVmkLLGl9ZL2RCH3+q2aKA2ppUafsVAgzbLiHREq/RufPs4LGcB/tEbjczNITGrk0zHWs/KtHMG2Oe06Y2COWaL6xUzND6lHBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042512; c=relaxed/simple;
	bh=4N7jZG1bOeXilLjTPuR2tPgSqwDbPnoLK4wJFfFacBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7OIUpGXEvOmSp8qbfz3PPUYIcIwUGlx9NvQJvOvU2mOgkf6FGK76/M7k3aWvdy1l8K4LZ7jkx9SOtX+T3n+QbEGidWsTXPIh3mL+Vu4IvIU34Q3sH4KrCd07YvJ4sd5PNkPokfEMHjQicDV4e9OuJ1/ipCydUXMu2rQQ9Vr0I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wvb1YeT9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wvb1YeT9"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VIvQiY330917;
	Wed, 1 Apr 2026 11:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wmGvHH
	1B8FUzrqXwVZu168JzRhaVJxY58Y6l5TrX4vI=; b=Wvb1YeT9hX5i/5fw/3l/Q3
	kWAJqnzXuRAdVQ5WihFPYKD0dUujbHpT2xRloHBARSBSSg71r5/II16nLxIDDavP
	ieDlihsQAOj+xPsTCKLVn9MbomfxNGuNVeL8jTrdcvbv0TM10XL6rqm0WzCSqq8v
	ezDCSItf/BwOgubFkbXrvLHXb0F3cnBXtlcuzjVJWfHrVczDSR1pTS3ZcC37YsYQ
	cqYX8xJNyuPGexqGkOgrFRgAr+sGtdUZtzIEACs1G55r88t6v+nEU4r898VbJf/Z
	PyaYSkA7XtzbepVsetbA2a3iuV1O3JETZOdlNpdM7JE0H8H5csWlnApl+4pFF4Fw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgq94k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 11:21:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6317Qw36014339;
	Wed, 1 Apr 2026 11:21:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkn6ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 11:21:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631BLSVu28770758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 11:21:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2CE12004B;
	Wed,  1 Apr 2026 11:21:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF1EF20043;
	Wed,  1 Apr 2026 11:21:26 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 11:21:26 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, bpf@vger.kernel.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v3 3/4] powerpc64/bpf: Add support for indirect jump
Date: Wed,  1 Apr 2026 11:21:32 -0400
Message-ID: <20260401152133.42544-4-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401152133.42544-1-adubey@linux.ibm.com>
References: <20260401152133.42544-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEwMyBTYWx0ZWRfX1USp16zGqzet
 m2X1gjZYPnjpnJxUEa1EX6mFHCccek7IRCVQXkU/ODybmwx2AHfPvu7itl8a9UbunWHlMM+XKK3
 XnDDcDkODzwpWzSDIXEWVeiL6tYcRIM0uiQ4afw9nuRcCtmRBP8REPkRFujhh6Ulyevx6Eg0S5E
 gPhUv9EOymn95wSTiNtNDRfvvTKxvT1xQ21Ob7Ks3pgAl039/2B5cGAGdCVpAxukQZbhE1ZszxX
 gAdFAWYIs6kU8Bs5TJoliakOE0dMI95PM2F77ih4ZBEkNMl7HWsftM2cT8oMrQitC1nJ0/F4v43
 WmwSvMNqpmIFCHkNxAu4q/KI+b69iIs1UL4p6He8qGqYMFprfqKxRGnAA0F1zMuwjXq7mZTJG7v
 c0OPgN0UgwvPL6GmD99WkJSidyXgVE3uXHs8mI3OaiBY+QMS4CLAhst4nm7N73EN/tTRGx6nHUG
 AoJMCEmYBq2iy7QgPyw==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69ccffbd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=_W6WOvRXMcVY7OADHKgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZUiKmzTkOJ99RxW7pm-xyapsjaYtvKAA
X-Proofpoint-ORIG-GUID: ZUiKmzTkOJ99RxW7pm-xyapsjaYtvKAA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010103

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
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index d9038c468af6..db364d9083e7 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -1708,6 +1708,14 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
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

