Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497803358A9
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 20:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771963818; cv=none; b=QqgzA2fl4qFsMXXfDzSoaE3lXz+13HMfFlO/wHYUiSn0CRCow3cymooe4Ua+mgLvRb+fXOGWfbNAz1PGm6UgqdsQyp6Q7I2K+nEhKIusL6YDY9QfBEbM6IC06KZTiPMk8vzI1SQoCf0ndUNOzk0lyyaZSZcaw8Ej81lthGk4I9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771963818; c=relaxed/simple;
	bh=Gj3G9WZifm7t9npP345VImwlmAzXV8CI/rr4e+yiJk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/GunnfQ34X5+wIniwtQ2sjzXuHPS5q6sI8yjTZKSz1rdRvdVF6cugEpeD7B6PP20dMwdyAVdmUsXD5pT7HSp9Q3VT5E5tuiMhr3yb/bDG7E+ETsoCMfDu52f5lLVZ0cbu/wDNe1qVqFdix1d8OuHyVP6m0BxS1J6LAMZ01nPZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pbftFmji; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pbftFmji"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OFQjmS1361599;
	Tue, 24 Feb 2026 20:10:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MjWESj
	X04CAWD4zzLRb+rT+HtdG6O8zDobj6zNRKaJI=; b=pbftFmjiN8JIN+Z9Ec8GIx
	ZKIS5jUpDuak7+WreLciVwyyyOm2Rlkq71/SsBrFQTG36XDxJ71UF9N7qZLlwJRE
	R7MobKQ/yggeCGN3C/7/oQyGyjg1Ux3lHCrHwF/7LLJm6lZ1jyH06neqkFYwzTln
	ZwuV3g7wCwOH1gsOushRNCuCbUAXtJiw/wxKyLhKTotk8ejMfUdlv9/Y0k/C7VwM
	pzvkImr+FjFKIKrv8LlXhv10nOuBHhBtjHyDFN7k/z/1nCr0X1L1HREGNtKSGKLB
	nrDAq8PPu75OTJMHoHsfpZDccRZOkFtqVYDaG7NCB5z3glbmYASwMlXB4iQKoo7w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34c4t77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 20:10:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61OGcddP013448;
	Tue, 24 Feb 2026 20:10:01 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfqdy2jdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 20:10:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61OK9vgZ40698280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 20:09:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3614D20043;
	Tue, 24 Feb 2026 20:09:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABD4120040;
	Tue, 24 Feb 2026 20:09:55 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Feb 2026 20:09:55 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org, hbathini@linux.ibm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, maddy@linux.ibm.com,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH 3/4] powerpc64/bpf: Add support for indirect jump
Date: Tue, 24 Feb 2026 20:09:31 -0500
Message-ID: <20260225010950.20218-4-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225010950.20218-1-adubey@linux.ibm.com>
References: <20260225010950.20218-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE3MyBTYWx0ZWRfX1/etIOebPwcR
 zu9M4gGVaNRinBUYJEtnJTRbYR7zF+N31ZnO00v/qeLmQ1EFb6hFa+MXcWkt/tljWcGg2bEl0bJ
 R6tsmlIAeRXmJiUR9Eb+z4xTn10VoaStjqNo8bU8tWWTc3hsVs2UCLW6h4jylUkaDPvLtpoc8uH
 7k4cT21E7lvKY7NxSOePLcXAR+bjPN6G2lI64lGH9lZ1QaEekeMKvqs4ttK7m6K0pl3hzzjkAgc
 6JdrMoL91clMzFIs6bp+THt4pEpNYCfcddtzvAk3fKjYzgsHYsdBTZDU9qL24NeUd2olmOle1po
 aj0GJxdGOBqHbMMPRJpLcxQggK3qZ7WCSY0IBNvo4HUBwpvAjPKlrHfX22TfMVbGG5PDVf+NZSR
 8nFuSVKz7EZhxi8Qwan+RC9cHvLLrMx8mm6VQ0U6w9w3OGelbCenhTCZTeN9m9MssVLlL7WmvEA
 m2gtjvS5vpG94i4VT4w==
X-Proofpoint-ORIG-GUID: C0KSaXJz-qQXWGq1EZpiS4RFAp4zN0lg
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=699e0599 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=_W6WOvRXMcVY7OADHKgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: C0KSaXJz-qQXWGq1EZpiS4RFAp4zN0lg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602240173

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
index 33ea07660ebc..8771c9f23c98 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -1604,6 +1604,14 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
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

