Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B3136CDEC
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344680; cv=none; b=ehBCLJ37gHJ5oDKdLhKQgoGb8GAlALkrELhIaTe8aHY/Gl4IhrkK8VFagznnia/1Awu4uHQGiof6N6QnY34naMUHuH/v2dPaIoOP2ifzz0hfSxCqKxDrnvZyXxu0o+WZPp4olxL4VL9+GDDxXhrmmWLfFqMWoXgVuNVnn9juIqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344680; c=relaxed/simple;
	bh=ZPyMbeH74CfATelwbvRR/WDTmfrH8DIuF2c4UvyXpNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sr/HpU02l/DHq0cWJCBG5BgLmvBV74EW4PyeaXdKqDvCmuIpOgvnJKWRiWKoXQOsu1PMHgTEDmzZ4pKBZbLQebec88ZycybZ4UcenSPXDZkytRYkJiwpGEGIuTlzQ4z72gCGia2UMELSRwDLFMSZcRISJD6kGarYIPiQA7crhYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sob93a7L; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sob93a7L"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H98FR03945141;
	Tue, 17 Feb 2026 16:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=hMj8qY259c5QXaQCpk0YnlVNOES+xwzxln+C0r5Qc
	rM=; b=Sob93a7LcnbSs9liNz0bfA2HQSn+ClYfciZ3tcRi7SAK3i1kaI5bvPXmu
	6TL5bsR3DF7kNxWXuVsAOR4Ptf8mbT0wCEeWVBad3snMJyqJbD56cIwBWt7C17VN
	hslZhrl/ANm4g9KoFoMnSOCIKBuZZ9W1D/qdvnjumIxZfJEO/RzfqVjCvZUvPf5z
	e9KlIlorS7Y0jL50AGrnVesz85pNgmg8UAD4cz5jwUFgmPJYQaTT3UVsmhLbrPOi
	KZWUDrobmJShZFbPWEUqDyYCLEPW+eSdCYCL2wHK2SqX1Omg5nzMkzu8gN8nvRaq
	ZVYWajuUrgKSf0CHnPhNjoN+l++rg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcjc741-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 16:11:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61HFrw70017834;
	Tue, 17 Feb 2026 16:11:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb28bkpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 16:11:04 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61HGB0Yu40894830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 16:11:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7C5F20049;
	Tue, 17 Feb 2026 16:11:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 840D020040;
	Tue, 17 Feb 2026 16:11:00 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.136.123])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Feb 2026 16:11:00 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH] s390/bpf: Do not increment tailcall count when prog is NULL
Date: Tue, 17 Feb 2026 17:10:06 +0100
Message-ID: <20260217161058.101346-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TUCbrJuKkxpKm_L9n0JGyZBmzxzZNh3O
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=69949319 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=3VfLUtj-Zce8GtbBNYUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEzMSBTYWx0ZWRfX7mGVoJE4Fb3n
 CPLTU8BHZUeP/U3jr1ASFgrgKhnDJPZpPWjXNGwdegPMKVgxWPFdaoMo7fsBLTzWdgWyFgcNui/
 jRY8KZf8tdyTqZHxp/LGLCOQpBmzSWlWxPZDdDNgllovHYKoWtmBTR4mVND6pt9Xi7SBYl2BuEq
 HPLCbndlmi88AJ5yHofgcfjDKx8dvTF/YSKB/MQuOsdTnDA0ZzpY6KcxJ6Xt/Ld82OYMox1+UNO
 DqO1VKtfj9W5topiO1DemXUvgeM6qs8cxz5F7kDbCb9THWILwQA4Nq2Kjfkb+VeaOviHKKkESds
 /hfg4qCkYm4jBlZgRM6l4al/cFqo9Yvej0G2LPfV+zDRmCry3HSQzdDc5qiDFbwm2xsAzG534pt
 ZqAZBaffUf2nhqEaY/5ZFBj7cJ2LAoCMXVk/l8yEmWhXXz65hODo2b5hNjaVdpON42HXSROSXnm
 74mYlrZcMogFMits+GA==
X-Proofpoint-GUID: TUCbrJuKkxpKm_L9n0JGyZBmzxzZNh3O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_02,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170131

Currently tail calling a non-existent prog results in tailcall count
increment. This is what the interpreter is doing, but this is clearly
wrong, so replace load-and-increment and compare-and-jump with load
and compare-and-jump, conditionally followed by increment and store.

Reported-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 579461d471bba..c754ae4f41a98 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1862,20 +1862,21 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 				 jit->prg);
 
 		/*
-		 * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
+		 * if (tail_call_cnt >= MAX_TAIL_CALL_CNT)
 		 *         goto out;
+		 *
+		 * tail_call_cnt is read into %w0, which needs to be preserved
+		 * until it's incremented and flushed.
 		 */
 
 		off = jit->frame_off +
 		      offsetof(struct prog_frame, tail_call_cnt);
-		/* lhi %w0,1 */
-		EMIT4_IMM(0xa7080000, REG_W0, 1);
-		/* laal %w1,%w0,off(%r15) */
-		EMIT6_DISP_LH(0xeb000000, 0x00fa, REG_W1, REG_W0, REG_15, off);
-		/* clij %w1,MAX_TAIL_CALL_CNT-1,0x2,out */
+		/* ly %w0,off(%r15) */
+		EMIT6_DISP_LH(0xe3000000, 0x0058, REG_W0, REG_0, REG_15, off);
+		/* clij %w0,MAX_TAIL_CALL_CNT,0xa,out */
 		patch_2_clij = jit->prg;
-		EMIT6_PCREL_RIEC(0xec000000, 0x007f, REG_W1, MAX_TAIL_CALL_CNT - 1,
-				 2, jit->prg);
+		EMIT6_PCREL_RIEC(0xec000000, 0x007f, REG_W0, MAX_TAIL_CALL_CNT,
+				 0xa, jit->prg);
 
 		/*
 		 * prog = array->ptrs[index];
@@ -1894,6 +1895,12 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		patch_3_brc = jit->prg;
 		EMIT4_PCREL_RIC(0xa7040000, 8, jit->prg);
 
+		/* tail_call_cnt++; */
+		/* ahi %w0,1 */
+		EMIT4_IMM(0xa70a0000, REG_W0, 1);
+		/* sty %w0,off(%r15) */
+		EMIT6_DISP_LH(0xe3000000, 0x0050, REG_W0, REG_0, REG_15, off);
+
 		/*
 		 * Restore registers before calling function
 		 */
-- 
2.53.0

