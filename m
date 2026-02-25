Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564D3330646
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 20:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771965397; cv=none; b=Bo31RF1ZHsDvdnR5dtMC69Mv+GzCvO3jHyTplxU1757nap1oiUpcl2m5ZQjgjXG71J4eLcmLOUMmbn1Xs+Ru5++pQgur1NLx63/oJmjpy7CZaJZDxfqnSPMY7Z+P67OJyJUWiHLOr7JNDf6qmOqnyfbDFGw6NNm3afmBVpy55q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771965397; c=relaxed/simple;
	bh=fA+Qnd/N61W6e2G/IBwfW+XyiqY8klY8a/PHL+fcKMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=df9qtDLhv/p2zoY+TaAHdjaNH9Yr0VkdO0Xa8DC6kIwC2Z/ZcAi4PkIt20Gz9lI243f15MaCWYU82fZydKiNvOCWKbAwr6aK9hc0bhxzMJxnFA6syeqWP2ddBEQgx74itI0oi48nspoAUzfj5hMJKWJ4QD5ZOYSHwMpC5uaNqSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KY6X/9EF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KY6X/9EF"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O8ol2K2750096;
	Tue, 24 Feb 2026 20:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hkKeLALRX+wEf7R0B
	0QQJ3Jzp38A18d+Zk0fmCyexBs=; b=KY6X/9EFUXT21EjkwLv1GS/L+Bu+Q6CNO
	ytvvoGQ/FGz6p4INxkU52tZO6QR0ihy3gHGVt4Bg3FGLXDo/T9p0RRTdSW0zwGSI
	DQRbeXtNLxXQBWi/4KYOv03fyYNdwZLxNuNgAIRc3uCK7Zxl99qgVm4EHJHuKUJn
	+aLIxRd1epSrxXOyQtezisPO3UI8v0xJ4Wu3ML/S4Y1AvfsPp3IhgrcIYBvfkQ3f
	YvRPkTaQq6heVhf0NjSLxwgcEd/cM2msX47Thz9xM3o7p2FslLXJAN0hh9PhD51R
	Vany2U5sQFmM66LZCT4zC0cFFAXAjhkxS7ScGS338QKfCBsUqLYsQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf471wh4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 20:36:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61OGoWWv015750;
	Tue, 24 Feb 2026 20:36:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfq1sjnar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 20:36:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61OKaG3G33947998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 20:36:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67EC820043;
	Tue, 24 Feb 2026 20:36:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD2C620040;
	Tue, 24 Feb 2026 20:36:14 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Feb 2026 20:36:14 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org, hbathini@linux.ibm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, maddy@linux.ibm.com,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH 2/4] selftest/bpf: Fixing powerpc JIT disassembly failure
Date: Tue, 24 Feb 2026 20:36:25 -0500
Message-ID: <20260225013627.22098-3-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225013627.22098-1-adubey@linux.ibm.com>
References: <20260225013627.22098-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TiAGzuz9J_GhPCyqqkrvlNFWaRqtnr8g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE3MyBTYWx0ZWRfX3EWqtKwZNcnK
 gMw7BWe1i+1y1Ob6zUVkpn6sr04Yn9yJSLqzPWo9xP7enAO8UDa11ApHS5abIpNJvIlIku36CyI
 uflwHhTJ3m88/tglUB4DSp8NxzbvHYmCTHBd+h+zr8zQEXD02jEyjuDVXZ9AG9Jn62HQK/aPtkZ
 bUOGsNQlRuwjD+F5g0hCgFwRZg79XAA2HDz2Wldvb5Dq/1ARHkTLnzf2Ef2GTYUXgMgiEau8tgr
 A4Cx+5Ii7DG+ZHpz9y0s0Pv530oO3lXl/Qr2/VUmuT0z9/4t75Yn074v8wwkJK+ysFq68JgN36A
 eHsUvc76Ycw59JQ5OZwMnUy3EBBgtp7CgISFNhIB4Ml8I3DDYVJkDK2OebsZtOLGaRfbLZ0spgi
 7zpwSpDY6S8WfhrRh0zXQ8PBcElXFaPpuHrL4VmHNHVSz+yJdHlUJhWUoQQDRr3ZgZyfqRyxiKS
 DjYW480JVOSNKYRwgxw==
X-Authority-Analysis: v=2.4 cv=R7wO2NRX c=1 sm=1 tr=0 ts=699e0bc5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=kVjrMc9Is9WrAmO39HcA:9
X-Proofpoint-GUID: TiAGzuz9J_GhPCyqqkrvlNFWaRqtnr8g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602240173

From: Abhishek Dubey <adubey@linux.ibm.com>

Ensure that the trampoline stubs JITed at the tail of the
epilogue do not expose the dummy trampoline address stored
in the last 8 bytes (for both 64-bit and 32-bit PowerPC)
to the disassembly flow. Prevent the disassembler from
ingesting this memory address, as it may occasionally decode
into a seemingly valid but incorrect instruction. Fix this
issue by truncating the last 8 bytes from JITed buffers
before supplying them for disassembly.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 tools/testing/selftests/bpf/jit_disasm_helpers.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
index febd6b12e372..cadddeaa6ed7 100644
--- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
+++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c
@@ -170,9 +170,11 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
 	struct bpf_prog_info info = {};
 	__u32 info_len = sizeof(info);
 	__u32 jited_funcs, len, pc;
+	__u32 trunc_len = 0;
 	__u32 *func_lens = NULL;
 	FILE *text_out = NULL;
 	uint8_t *image = NULL;
+	char *triple = NULL;
 	int i, err = 0;
 
 	if (!llvm_initialized) {
@@ -216,9 +218,18 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
 	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd #2"))
 		goto out;
 
+	/*
+	 * last 8 bytes contains dummy_trampoline address in JIT
+	 * output for 64-bit and 32-bit powerpc, which can't
+	 * disassemble a to valid instruction.
+	 */
+	triple = LLVMGetDefaultTargetTriple();
+	if (strstr(triple, "powerpc"))
+		trunc_len = 8;
+
 	for (pc = 0, i = 0; i < jited_funcs; ++i) {
 		fprintf(text_out, "func #%d:\n", i);
-		disasm_one_func(text_out, image + pc, func_lens[i]);
+		disasm_one_func(text_out, image + pc, func_lens[i] - trunc_len);
 		fprintf(text_out, "\n");
 		pc += func_lens[i];
 	}
-- 
2.52.0

