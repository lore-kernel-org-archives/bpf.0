Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C289637881E;
	Thu, 22 Jan 2026 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101169; cv=none; b=BURKuN6DIZyJ2s6OclJRH6BLjlUCFqxkqHNTvyp17jlK3X50fqL06UrHuCm6eorJ2QZs9m9Eo1F2nvGqopMW/z1DxljtbWt6WyfjjSnQXLBOufJKc7/Tn0vc46RnhoIC7phPQIufffnpmuBXGzfcUL2G1dX4g1lb0tJMuaL1deY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101169; c=relaxed/simple;
	bh=ZZiPNtMVFac7HGXvfmtml7hvEu08J1Eucvq6mX/4TTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sz0YvyLPlfu2Ixe9pHMxicFmLaY0P8TNDb07aOJtsY7e2VswKCSn7h+GWTKdWDGPalc8VfTgW2pV9Yr57BLAkUEaiX8DevTOpWTr1DxvzNhWskIsGeEorzg5BlgYZmxWTNqrMjNW4yyCqcOCe9iL6YwuM73nj0ZFiwE7JfigDRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IjmE86Yc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IjmE86Yc"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60MDbeLa007922;
	Thu, 22 Jan 2026 16:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TXgmDXs4JFjAGlSMt
	ms1ah2TwLO40IrSCwqYBvl/j9w=; b=IjmE86YcB2DSUR21+YDW0eKWc9xEqrLAM
	0U47DvmdKi8U9U9/yzx+bkHqVEeNOAYRAZ2RsFxO1vDBaj9MLuPKu/O5VDMR4EZG
	lj+HRr1Yhk9fioi8TrFdgWHGQSd6qHiEEEbWTq/3s9RwYvZGRbAB+x23Ks3Gb/7I
	6FN0ZqkyLZzFYXS8f6MEcIdbBhc7GQDwwHWr09Id3y2CcDuCU4f2roUBBk/zH1cV
	4/2farnONZY4ytbeI2cQxzu4f3GjICWZDdw/LzZgFK1OtlGlUJl8d62gaQPxZBMG
	alozonVgQazGeRNWTUvrhtv4O3/9GxnrAjRE2FJACEv0sp5Z01bTA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyukhqhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 16:58:41 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60MGwW2o010141;
	Thu, 22 Jan 2026 16:58:41 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyukhqhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 16:58:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60MGZ2KZ027382;
	Thu, 22 Jan 2026 16:58:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brnrnbf41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 16:58:40 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60MGwak940763746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 16:58:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D4F72004D;
	Thu, 22 Jan 2026 16:58:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61D7720043;
	Thu, 22 Jan 2026 16:58:27 +0000 (GMT)
Received: from abhi.. (unknown [9.39.26.73])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Jan 2026 16:58:26 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
        andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, memxor@gmail.com,
        iii@linux.ibm.com, shuah@kernel.org,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v3 4/6] powerpc64/bpf: Add arch_bpf_stack_walk() for BPF JIT
Date: Thu, 22 Jan 2026 22:27:14 +0530
Message-ID: <20260122165716.10508-5-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260122165716.10508-1-adubey@linux.ibm.com>
References: <20260122165716.10508-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyOSBTYWx0ZWRfX7o4fRMBQJzI6
 2YcgubMjXUKPguJUZWQswqJXX3ZIJQV2jr/ouomNqMGWLujOp55j9SS8mjm/gq9i/zxcORoTXuP
 E1jXaS7CuoZ8rFdPLGjdjb71xaMKBRKylqXD5LAXC6MsdwYcyNTIblp9lf6x77meFVQSDBTzlIS
 zveRiivNxcfOj970SLdUlCcVhU7aVRSfu6IqWgoGkRuBJpGOM8adbVBzNJub+cccNbo3t2jGrN4
 F09NxgOnvBQZf2e2+xQ/g6lg2AjhOKFeeTJJzJ8bhZupA962z3OpmXU/LCtVL8RbHJjjm4eirQc
 aSwBPO8jQ1cQqzaHVed3rC8mZ7uwS5zG1ZPFKX+qkdthdVsY2V1HHpV1d+FSfmWzKXdxcA2t7XK
 Uvmo2fdKAJNbC/YREQsceB5pJBc8ITTkf+5FYE78A3ZrGDPBhwFB/lPuUW/DbkQ3fDXD1vZTHbf
 lfGnFCOueaVd3wbU6gw==
X-Authority-Analysis: v=2.4 cv=bsBBxUai c=1 sm=1 tr=0 ts=69725742 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=ovcAVf-9gG4EF5hqTukA:9
X-Proofpoint-ORIG-GUID: kzVjUVpO-cdw4KcpKHSaszo6afiDf37c
X-Proofpoint-GUID: tTTqY_y5OCYccDmCwqxZhRoCHAdgcFhk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601220129

From: Abhishek Dubey <adubey@linux.ibm.com>

This function is used by bpf_throw() to unwind the stack
until frame of exception-boundary during BPF exception
handling.

This function is necessary to support BPF exceptions on
PowerPC.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 18da5a866447..c25ba1ad587a 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -247,6 +247,34 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
 	bpf_jit_build_fentry_stubs(image, ctx);
 }
 
+void arch_bpf_stack_walk(bool (*consume_fn)(void *, u64, u64, u64), void *cookie)
+{
+	// callback processing always in current context
+	unsigned long fp = current_stack_frame();
+
+	for (;;) {
+		unsigned long *frame = (unsigned long *) fp;
+		unsigned long ip;
+
+		if (!validate_sp(fp, current))
+			return;
+
+		ip = frame[STACK_FRAME_LR_SAVE];
+		if (!ip)
+			break;
+
+		/*
+		 * consume_fn common code expects stack pointer(sp) in third
+		 * argument. There is no sp in ppc64, rather pass frame
+		 * pointer.
+		 */
+		if (ip && !consume_fn(cookie, ip, fp, fp))
+			break;
+
+		fp = frame[0];
+	}
+}
+
 int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
 {
 	unsigned long func_addr = func ? ppc_function_entry((void *)func) : 0;
-- 
2.48.1

