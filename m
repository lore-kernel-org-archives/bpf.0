Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A706B3BB113
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083438; cv=none; b=YmrXfo8OKKBhIu1YDkMapXl1B4jtQ5qrTccGFFUgbHT8kiqmCxvfEAPSgp+xdFQnyOnJ8TyclS+eCpuhqCGga8Tqh0ZFTe81ZK0r+xofsROA6ketHXmKxbpZ/jjjinnjgsr3AFVPdWZ46buI8ucdVsVpn+TmPGJv3SGLec1c8hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083438; c=relaxed/simple;
	bh=TsmP8dMtKZZZwpXrJqpPIn+B68roxPBxoITwiAtyBZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUPPVcriZu9mgefCioSaSkuVcedMF9lgEg6r2y+F9K8CAqV6WBkLGxCLOOX0yOIJ5lied6Dy1ySRp56hPae6uP+5I2VqTP1pRBWVxkzKQ/lGxQGf5+/sOktD09jpEOeFf4VPrpRLCKbhQCteiY01CjM+5u8JOp8fGHi1LAsm2+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zr99YOGR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zr99YOGR"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636IPY71930856;
	Fri, 3 Jul 2026 12:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8L7wTQ7HY939IYwtA
	Jf69/jpNH7zEe6ZWx/Ba9fpktk=; b=Zr99YOGR4pLesi5vYDjl8Wi/lBV/LbFaz
	iPORGebaftAL9GWhO8WHEhLULLZfCgWgH5ng8xrHOsw5nQGpkWuabBsk+tigfxKy
	BmsVczTuJlHdMhA/NRAz2qBUu9ROaFkfrADy2G3AqIX0lY7LQSSFFZW319ckTrPK
	EE8UM9Akq3jhr/LBS6lzOAgXqFbfCHhEfmSD4XShr6/Z0nl3cZeSNlODydro9lS3
	ui5/WZ8Dw9GJYMuDl7MgEeANpIvDxl/9UzuYs2bZeRwyOmBKQmzeP+Z9JzRG/ZbQ
	bLgmoWlkBC/kaaaKhFtJbDy6mqi/SE3itEwzYjcnMj4jI0w6q8F2Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pefdva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 12:57:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663Cne5G003128;
	Fri, 3 Jul 2026 12:57:03 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2sukgws5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 12:57:03 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 663Cv2nk787438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 12:57:02 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1348D58043;
	Fri,  3 Jul 2026 12:57:02 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05EA45805D;
	Fri,  3 Jul 2026 12:57:00 +0000 (GMT)
Received: from thinkpad-p1.ibmuc.com (unknown [9.111.50.198])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Jul 2026 12:56:59 +0000 (GMT)
From: Maxim Khmelevskii <max@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH bpf-next 1/2] s390/bpf: Replace ly instruction with llgf
Date: Fri,  3 Jul 2026 14:51:35 +0200
Message-ID: <20260703125648.919196-5-max@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703125648.919196-4-max@linux.ibm.com>
References: <20260703125648.919196-4-max@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lyr7KLse1xUUqdOVWmybvem5t1NJriMd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEyNiBTYWx0ZWRfXxe8vcWAdfLcg
 QUhbab4lJ+qbXQCxfDqShclRm7A7PELBbKs8/BCtH1Ra++S+brs9OrClbsUAsktZir8d0oFBM3p
 Lan41P92qnvIx03ZAu7y6d5XNepgmCw=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a47b1a0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8
 a=50wamhQsRirIyYOn3_4A:9 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEyNiBTYWx0ZWRfXwKHlpNCFKdnz
 AKM31MswpjPgWIJwcQ6AHmML9eesOAbh64R0y7O49tYumIxgLTeP39OvKpKZz5VmTnq+nC0KXv5
 c1df8Qexs2nBq5Wm0ceXY+V6LER61vs9DsBAQ3JadL9mb1HUwoXXgs/edI38fHH0GLP7a4/ea+O
 4yKW9bedGlVBP6fkBQVfHHjaV+61tJNtyQbIwmDJYKErQ+u6zzk4cDxoobxW+1is2WrP56TR+X9
 FBLIzdZ7PryMzUE7noWOvc6YRFeio8i7fhOYB09iowK4IKxW1m5U0U3CkvYki4mpltn024qApdP
 jYdsRfSMvKxEVy1dkjFvk38Ok3OyjK3coTypAqAoCpCzOA6oTqgMwN12JVNjJcQOKQgG1ezpCQ5
 UJTaW+7UDUVQsZuFe8VG8arF/Y9oqP24IhCUCfIg5hBpyqheRcGXoqDLeDvBDeOyZefkukLz46r
 +3U+Gp4jneobZTxZbNg==
X-Proofpoint-ORIG-GUID: lyr7KLse1xUUqdOVWmybvem5t1NJriMd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030126

cpu_nr is a 32 bit value and BPF_REG_0 is a 64 bit register,
when ly loads the cpu_nr into BPF_REG_0 it does not zero the upper bits,
but llgf does.

Link: https://sashiko.dev/#/patchset/20260414142930.528751-1-max%40linux.ibm.com
Fixes: 9012cf2491e3 ("s390/bpf: Inline smp_processor_id and current_task")
Signed-off-by: Maxim Khmelevskii <max@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 14eaaa5b2185..d62c5838c741 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1783,8 +1783,8 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		    insn->imm == BPF_FUNC_get_smp_processor_id) {
 			const u32 *cpu_nr = &get_lowcore()->cpu_nr;
 
-			/* ly %b0, cpu_nr */
-			EMIT6_DISP_LH(0xe3000000, 0x0058, BPF_REG_0, REG_0, REG_0,
+			/* llgf %b0, cpu_nr */
+			EMIT6_DISP_LH(0xe3000000, 0x0016, BPF_REG_0, REG_0, REG_0,
 				      (unsigned long)cpu_nr);
 			break;
 		}
-- 
2.54.0

