Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F2D1A9B46;
	Sat, 24 Jan 2026 07:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769241300; cv=none; b=tdc5Kz2ibm7hGO92DDlg/p8tTH+BNwI3UIPycPXIoTxq04Wxt2KMtr4F8EYmSNNGyDFzcFWKOShIaBQ6VN1T2Ea7qI+V5Es/bn5IEVSZoDM/8uIpUnLve9GH9Y5I1CEyvV357hJnWnzMajmYAoZHwb1T/Zl+1N2t+IRyDM8eypg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769241300; c=relaxed/simple;
	bh=Zd0m7rUk7beURgdwtoStwocQjmWcEg/kis8HVPDJfy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3yHR62vxOFEH5LLGDNBkuuok7TJ/E1YjutAgR0nHq4D6B3XSPUVWn5IB9d7yrOYV2BDDqCxwWC1rZ28LszeIpe8R6UMiqGm3xIuwGmybWujyFNCEIckpzYc6FSPRMkTHaTWsBMmyhRxN82QGV/vJ/IAVhz91t8KywmL8DtDd3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=azM8mUfV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="azM8mUfV"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60O7l5Hj029709;
	Sat, 24 Jan 2026 07:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=whHUJNNJZ6qz3J1Px
	/WYh0SIfZcWl0bjN4IlDjqDEKw=; b=azM8mUfVXj26cYN9cnZwqeqe/xWX86Lng
	0I0re3LXQhzqZEAF75kWw/9ksZcZfUI6ryr2rSSfKbZAoZtdkOh+DV2700cNtqLb
	G/zGFnBxiFyALglOTBqo5VxXIjn0SHzQD+HMrf2CdPnMxMs1788gn4ADxPcU/m3b
	C6vWSdzEx4dEay7b8EA0ABhp5RyivQsXOas+ARKVJf1DYV4quKGuMIWyisJMJ0/Z
	QrqILN0DL2bmIbH2d3q5uJWODXKx0amwyxYdSHT+yBqG0x0JZqnnfU0jbjs/4FUu
	Eu83XqfIlRJjJtTJhK3LNnvOXPRqERS7Z2g42R13X/eXUaKjLyGKw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgm8urq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Jan 2026 07:53:18 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60O7rHli007337;
	Sat, 24 Jan 2026 07:53:17 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgm8urm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Jan 2026 07:53:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60O70MOj017070;
	Sat, 24 Jan 2026 07:53:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brn4yn392-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Jan 2026 07:53:16 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60O7rCqp56885562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Jan 2026 07:53:12 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCC4E20043;
	Sat, 24 Jan 2026 07:53:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4F6120040;
	Sat, 24 Jan 2026 07:53:05 +0000 (GMT)
Received: from abhi.. (unknown [9.124.223.59])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 24 Jan 2026 07:53:05 +0000 (GMT)
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
Subject: [PATCH v5 4/6] powerpc64/bpf: Add arch_bpf_stack_walk() for BPF JIT
Date: Sat, 24 Jan 2026 13:22:21 +0530
Message-ID: <20260124075223.6033-5-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260124075223.6033-1-adubey@linux.ibm.com>
References: <20260124075223.6033-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Gr1PO01C c=1 sm=1 tr=0 ts=69747a6e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=lmbXRN_Zm_tNO3HBYvgA:9
X-Proofpoint-GUID: X_2ZuYxAxidKUGW62CFsspbQMqss3Qmk
X-Proofpoint-ORIG-GUID: _Qr-1v1S46W0pKlaNUWMIFLkb5WedFBn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI0MDA2MCBTYWx0ZWRfX42sCkNmsDp+1
 3dIc6Gqf94nZ00lqSkC023Ww1kjBYMpWPOk6s9nTx5yUXX9Nc/2sSKfp0+CS0hAyAX8fJZ66Zrz
 DMeHHp9ubn96lt+FL/qG3GcPEhvIvfi5x/+6uiWenTinlw/agbZqPCgMkV7W5Qui1tj3oAU/O0G
 CwlWd3RhqVrIVg9t6mF6Zx2Vd/dwxqtkqysNf3bacD8IpH1PsF02gnew0SFuwMKUDYbQZKZJrnN
 6qZuMqzO7P9m1kP4Ef/3TN7eL+aBagxGfCkFIG6ttKN2xzm+8E3QZ/r6RHr072Hlli6wxV3ja6g
 vvQ5blVo83B8zA8bu+jqdfmyiFMviz1NfYF0IlccP1npIS3+JZPTr5z+QzJF3Fx3VdhK8tfm/yx
 /6H7mtYOMundk6hDBGkB6KaqwS8gX/wipvlum/qF7LZMhSBGXjYYq0iW09tJyEuuO334uCgrsU/
 VLnorIx4teRG0Iq/jGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-24_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601240060

From: Abhishek Dubey <adubey@linux.ibm.com>

This function is used by bpf_throw() to unwind the stack
until frame of exception-boundary during BPF exception
handling.

This function is necessary to support BPF exceptions on
PowerPC.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 41 +++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 18da5a866447..1bba068f2c4c 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -247,6 +247,47 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
 	bpf_jit_build_fentry_stubs(image, ctx);
 }
 
+/*
+ * arch_bpf_stack_walk() - BPF stack walker for PowerPC
+ *
+ * Based on arch_stack_walk() from stacktrace.c.
+ * PowerPC uses stack frames rather than stack pointers. See [1] for
+ * the equivalence between frame pointers and stack pointers.
+ * Additional reference at [2].
+ * TODO: refactor with arch_stack_walk()
+ *
+ * [1]: https://lore.kernel.org/all/20200220115141.2707-1-mpe@ellerman.id.au/
+ * [2]: https://lore.kernel.org/bpf/20260122211854.5508-5-adubey@linux.ibm.com/
+ */
+
+void arch_bpf_stack_walk(bool (*consume_fn)(void *, u64, u64, u64), void *cookie)
+{
+	// callback processing always in current context
+	unsigned long sp = current_stack_frame();
+
+	for (;;) {
+		unsigned long *stack = (unsigned long *) sp;
+		unsigned long ip;
+
+		if (!validate_sp(sp, current))
+			return;
+
+		ip = stack[STACK_FRAME_LR_SAVE];
+		if (!ip)
+			break;
+
+		/*
+		 * consume_fn common code expects stack pointer in third
+		 * argument. There is no sp in ppc64, rather pass frame
+		 * pointer(named sp here).
+		 */
+		if (ip && !consume_fn(cookie, ip, sp, sp))
+			break;
+
+		sp = stack[0];
+	}
+}
+
 int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
 {
 	unsigned long func_addr = func ? ppc_function_entry((void *)func) : 0;
-- 
2.48.1

