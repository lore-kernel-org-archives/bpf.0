Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4B836B06D
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773424111; cv=none; b=tJ5/IFswEF0v+nGjRlWd6AnroNAKCP7CK3EPVl3HjVURO+TZMSTu2fdXQfLYPFfnuKXVqao+dXVQkn+UKR7TwVWEXuNKqIowPebaMstTZDDcG1NTL5i1ZB8sBZrHKzWjzcfmksPaAmC+xg+Kqw5sVnD0pmOvKHgn/FKXSJPEJt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773424111; c=relaxed/simple;
	bh=SBgN0ypaUE8BVba4+S7g3Z7yIqUtF3BpXH8EeF97N9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ilYsD+mXRvZSDehLnilAY6Jz1bjavMco3H8vpQ2M4A2aiOZW8fC/Q4BMh05KlUhv5jrJiUdiLyzDeg4DSuhlcz2KBGza2/OJkH9ex2NWyv2Hy2pGxnJ8J6fYbGD6xn12ZpRvrkpvu+UhMMOiXHkTa7SqAqsBxKiHSfeOcLTJPpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AuV6ij6J; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AuV6ij6J"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5lRKC2301893;
	Fri, 13 Mar 2026 17:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=YhveXLQE6JNjpf3dad94UGkv2193x8Bk43y7zFHMH
	3g=; b=AuV6ij6JE/EhdrWcwIuRvg3DwLMEo778+8vF/UsT695X8FzDiHAEMyLXE
	4zj/JsmvrkQRY3rApxtRLtUN5sgZzUaAR5lc2Osmctx5C3N9b6YN/E2OpjAwrIvF
	g7iwvxAF4ofnsQLPMt8kFrawJ8NgsuelY0GeO8MUrbC5/HAXPqXPQzk+02Z+02vM
	LpaP9xRowXluIHK1S1CaT3QHuzxHQCjqKOKFiZY6L+OsWPNltxigMPtKgT1b7v2b
	VV4Iae+aKB6Rt0cdE5V5i3HU0Q7YULvuQbyAqqEP7rpE6kCxnGwuiWanjfMlnTUP
	RzANsa6dfZNT5XP7HQNMtCItH7eDw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh960rkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 17:48:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DEwTwC021245;
	Fri, 13 Mar 2026 17:48:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha9qppp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 17:48:14 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62DHmAFk40239516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 17:48:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5351C20049;
	Fri, 13 Mar 2026 17:48:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC12B20040;
	Fri, 13 Mar 2026 17:48:09 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.88.140])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Mar 2026 17:48:09 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH] s390/bpf: Zero-extend bpf prog return values and kfunc arguments
Date: Fri, 13 Mar 2026 18:46:25 +0100
Message-ID: <20260313174807.581826-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDE0MCBTYWx0ZWRfX3Bbc6yk55fZm
 QAV6/xGWuX813xWuqcjQ/sUdiQprj33Sk0X4BpFc+I5VEU2jKaNCNBS24B/gO/5v8SEy91gXS17
 SUjCoMEkEo0DGDQGTDsu68nLMTROM6oTjeek/fw2jcmWCatb9oym2N+fhqxJMHdKoIdusxwjGnm
 /9Ju66GC3EOO7JrACGwTKPNgstpGrz2ZSAobmbhYXQQfC79I4h2UwVri7h5iBfj+K+9DHyR0kwQ
 ezkdUXCUiXRA9XFSiBXGfKTNbq9O2MhXktNGPwNZaT4HvZEjQwdpgCPFvsQAee5CEuvII3mGE1W
 h1tnadptgoaujdGCGdJS3scR48zAGjGjtjZQsnn6eQWGp/ZRAPyVMPORO1WUJ/O4EkiamYchlkL
 HhoF+Ta6vvTqnhj5fdIh2P5ILsXjpmqnQIVS39+HkOwv/bVyjmRV67D7wMrCdMeVZzhhaxpCneo
 iedCR9ohC7FA5l/K7Tg==
X-Authority-Analysis: v=2.4 cv=FowIPmrq c=1 sm=1 tr=0 ts=69b44ddf cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=f077Cj1veyUfnecLbkIA:9
X-Proofpoint-GUID: rwVLHmt_o1RGUZxRjcUIaKAWO0x5czpO
X-Proofpoint-ORIG-GUID: rwVLHmt_o1RGUZxRjcUIaKAWO0x5czpO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130140

s390x ABI requires callers to zero-extend unsigned arguments and
sign-extend signed arguments, and callees to zero-extend unsigned
return values and sign-extend signed return values.

s390 BPF JIT currently implements only sign extension. Fix this
omission and implement zero extension too.

Fixes: 528eb2cb87bc ("s390/bpf: Implement arch_prepare_bpf_trampoline()")
Reported-by: Hari Bathini <hbathini@linux.ibm.com>
Closes: https://lore.kernel.org/bpf/20260312080113.843408-1-hbathini@linux.ibm.com/
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 39 ++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 1f9a6b728beb..d08d159b6319 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -830,25 +830,34 @@ static int bpf_jit_probe_post(struct bpf_jit *jit, struct bpf_prog *fp,
 }
 
 /*
- * Sign-extend the register if necessary
+ * Sign- or zero-extend the register if necessary
  */
-static int sign_extend(struct bpf_jit *jit, int r, u8 size, u8 flags)
+static int sign_zero_extend(struct bpf_jit *jit, int r, u8 size, u8 flags)
 {
-	if (!(flags & BTF_FMODEL_SIGNED_ARG))
-		return 0;
-
 	switch (size) {
 	case 1:
-		/* lgbr %r,%r */
-		EMIT4(0xb9060000, r, r);
+		if (flags & BTF_FMODEL_SIGNED_ARG)
+			/* lgbr %r,%r */
+			EMIT4(0xb9060000, r, r);
+		else
+			/* llgcr %r,%r */
+			EMIT4(0xb9840000, r, r);
 		return 0;
 	case 2:
-		/* lghr %r,%r */
-		EMIT4(0xb9070000, r, r);
+		if (flags & BTF_FMODEL_SIGNED_ARG)
+			/* lghr %r,%r */
+			EMIT4(0xb9070000, r, r);
+		else
+			/* llghr %r,%r */
+			EMIT4(0xb9850000, r, r);
 		return 0;
 	case 4:
-		/* lgfr %r,%r */
-		EMIT4(0xb9140000, r, r);
+		if (flags & BTF_FMODEL_SIGNED_ARG)
+			/* lgfr %r,%r */
+			EMIT4(0xb9140000, r, r);
+		else
+			/* llgfr %r,%r */
+			EMIT4(0xb9160000, r, r);
 		return 0;
 	case 8:
 		return 0;
@@ -1798,9 +1807,9 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 				return -1;
 
 			for (j = 0; j < m->nr_args; j++) {
-				if (sign_extend(jit, BPF_REG_1 + j,
-						m->arg_size[j],
-						m->arg_flags[j]))
+				if (sign_zero_extend(jit, BPF_REG_1 + j,
+						     m->arg_size[j],
+						     m->arg_flags[j]))
 					return -1;
 			}
 		}
@@ -2566,7 +2575,7 @@ static int invoke_bpf_prog(struct bpf_tramp_jit *tjit,
 	EMIT6_PCREL_RILB_PTR(0xc0050000, REG_14, p->bpf_func);
 	/* stg %r2,retval_off(%r15) */
 	if (save_ret) {
-		if (sign_extend(jit, REG_2, m->ret_size, m->ret_flags))
+		if (sign_zero_extend(jit, REG_2, m->ret_size, m->ret_flags))
 			return -1;
 		EMIT6_DISP_LH(0xe3000000, 0x0024, REG_2, REG_0, REG_15,
 			      tjit->retval_off);
-- 
2.53.0

