Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4178C423A62;
	Tue,  5 May 2026 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983504; cv=none; b=e5f7ObUwhrueySaZRg97D83KjQIXH4vYF389z5p4hXeEn6b1uSG1Xx49/9lziZjpceE2ZRL9TaLU7pwJ9ebNQUm3gTECgY19Vskhx8P0LKyn1SadeTP91CLLAMIA0i6NYU0RBR5yuZMQAqa13C1JHtq97dd2fa66owCT1vNkv3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983504; c=relaxed/simple;
	bh=6D70xgnfaV85V3maswNaB3qlxHlQue6yuz7etmDE50k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSmnTF3uuoIgRF7z+POwR4/6tFy7w8TFli6WAK7M97x0OdXCl2/iK/fW2YQturPKxnzkpjPqH/8FgDJNbUiiIyX16BUQ0+nNCb5h0gY/WJnbw0DxaMEihlmpZiEsxi7ueKGBcMgyxP1fW0Q7kXj9zqFhmKdbzjj6oLC7Nx3wKrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FttzhKCJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FttzhKCJ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645AF2Us963512;
	Tue, 5 May 2026 12:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AqkRAL/F99BswCpNX
	xBkMsZDONc7WSoAsmYzBCMlE/E=; b=FttzhKCJzAKCa9IJVeIrO713e2CR5igL1
	m2xgyu3IMZul5FMziNKnqvaM61KVxfpbNrXPpK8lsWPsoNkYj6BBwerjikaSxAwr
	WNZw3GAHQqxDYMDO5PoJcZdSAXSDDwMdInDRmTWhF9EXx9QqnV+lrJh+luKjpqhR
	nwz3cGmSRfIPqdlqpQDOGfGL29loe7CM469chD2A5nvSFq5bOBApxRR+7+r6jf6I
	W7bPEPy3XM+LOm8VX6+/u07lbPnLMdwUTleUzCtBGoLfD5Y0Ltt/4kiZejc0xM9Q
	WveBoVVsdWL4Xjg+vct3Uotk8USkYRAsWmi03/61YDrw/PXPAxeyA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v7bj9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 12:17:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645C9okx028585;
	Tue, 5 May 2026 12:17:31 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyw1m3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 12:17:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 645CHRMD57082294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 12:17:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 522AE2004B;
	Tue,  5 May 2026 12:17:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E23D72004D;
	Tue,  5 May 2026 12:17:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 12:17:26 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        x86@kernel.org, Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Indu Bhagat <ibhagatgnu@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dylan Hatch <dylanbhatch@google.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Kees Cook <kees@kernel.org>, Sam James <sam@gentoo.org>
Cc: Jens Remus <jremus@linux.ibm.com>, bpf@vger.kernel.org, linux-mm@kvack.org,
        Namhyung Kim <namhyung@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Carlos O'Donell" <codonell@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v14 14/19] unwind_user: Flexible FP/RA recovery rules
Date: Tue,  5 May 2026 14:17:13 +0200
Message-ID: <20260505121718.3572346-15-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505121718.3572346-1-jremus@linux.ibm.com>
References: <20260505121718.3572346-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDExNCBTYWx0ZWRfX0wRCLw1jLLWz
 WDXtsIOYA1bpJRM9NL7n9w+WuJE3fZ0sghrbhXA80rjVn+TJxwyDqef7Tj2AyE9LmEH2kVVRr47
 aCMw4aKhUweeAvX3L/6rG3QJrLAhjiYdyaLCfjWtVXITRmbmY6eOChpe2qhQrUleIdn0abE+8Bk
 oqvin1EOSezmh3pjQrQmPm7dgYcBOHKlkzEjyKVTTQKMV2ucvLi2FbO+aFoKGfNdWsNdD9cziHM
 SGltGgqgvf9vqe8eBhaFlQHENvjhPFOzxvILcWosv1umy2zs2i8QMLI6N9KKFgfjTws5aBuU20Q
 NWGPFM5kRXNH71mPvHhUxCJ/xVIB3Q7p9O6gRO/3+lqqvdP3BPkJlDpmsSHIQ7xrIdn7MyP+bbH
 xww+Ingn9cAHByC3DSCisPcyvZJKxjspMdAbEitTn6VTm0pkFh6pE2PLBiS6+3508WRhVD5QaR8
 lf1PpcLAH5eQoR6sFtw==
X-Proofpoint-GUID: pnR1nFaxQUpyd1FpSrOluPbIAnOgGWMX
X-Proofpoint-ORIG-GUID: YDladW5h7pO8Ko9AlmaJN6qgQyb2EtqC
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69f9dfdd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=GjvnxKKRlEeFsqGDDKkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050114

To enable support for SFrame V3 flexible FDEs with a subsequent patch,
add support for the following flexible frame pointer (FP) and return
address (RA) recovery rules:

  FP/RA = *(CFA + offset)
  FP/RA = register + offset
  FP/RA = *(register + offset)

Note that FP/RA recovery rules that use arbitrary register contents are
only valid when in the topmost frame, as their contents are otherwise
unknown.

This also enables unwinding of user space for architectures, such as
s390, that may save the frame pointer (FP) and/or return address (RA) in
other registers, for instance when in a leaf function.

Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v14:
    - Improve comment on why UNWIND_USER_RULE_CFA_OFFSET is not implemented.
      (Mark Rutland)

 arch/x86/include/asm/unwind_user.h | 21 +++++++++---
 include/linux/unwind_user.h        |  9 +++++
 include/linux/unwind_user_types.h  | 23 +++++++++++--
 kernel/unwind/sframe.c             | 16 +++++++--
 kernel/unwind/user.c               | 53 ++++++++++++++++++++++++++----
 5 files changed, 107 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index 2dfb5ef11e36..9c3417be4283 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -21,15 +21,26 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
 
 #define ARCH_INIT_USER_FP_FRAME(ws)			\
 	.cfa_off	=  2*(ws),			\
-	.ra_off		= -1*(ws),			\
-	.fp_off		= -2*(ws),			\
+	.ra		= {				\
+		.rule		= UNWIND_USER_RULE_CFA_OFFSET_DEREF,\
+		.offset		= -1*(ws),		\
+			},				\
+	.fp		= {				\
+		.rule		= UNWIND_USER_RULE_CFA_OFFSET_DEREF,\
+		.offset		= -2*(ws),		\
+			},				\
 	.use_fp		= true,				\
 	.outermost	= false,
 
 #define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)		\
 	.cfa_off	=  1*(ws),			\
-	.ra_off		= -1*(ws),			\
-	.fp_off		= 0,				\
+	.ra		= {				\
+		.rule		= UNWIND_USER_RULE_CFA_OFFSET_DEREF,\
+		.offset		= -1*(ws),		\
+			},				\
+	.fp		= {				\
+		.rule		= UNWIND_USER_RULE_RETAIN,\
+			},				\
 	.use_fp		= false,			\
 	.outermost	= false,
 
@@ -41,4 +52,6 @@ static inline bool unwind_user_at_function_start(struct pt_regs *regs)
 
 #endif /* CONFIG_HAVE_UNWIND_USER_FP */
 
+#include <asm-generic/unwind_user.h>
+
 #endif /* _ASM_X86_UNWIND_USER_H */
diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
index bc2edae39955..92cdf38c8ade 100644
--- a/include/linux/unwind_user.h
+++ b/include/linux/unwind_user.h
@@ -32,6 +32,15 @@ static inline int unwind_user_get_ra_reg(unsigned long *val)
 #define unwind_user_get_ra_reg unwind_user_get_ra_reg
 #endif
 
+#ifndef unwind_user_get_reg
+static inline int unwind_user_get_reg(unsigned long *val, unsigned int regnum)
+{
+	WARN_ON_ONCE(1);
+	return -EINVAL;
+}
+#define unwind_user_get_reg unwind_user_get_reg
+#endif
+
 int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries);
 
 #endif /* _LINUX_UNWIND_USER_H */
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index 616cc5ee4586..0d02714a1b5d 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -27,10 +27,29 @@ struct unwind_stacktrace {
 	unsigned long	*entries;
 };
 
+#define UNWIND_USER_RULE_DEREF			BIT(31)
+
+enum unwind_user_rule {
+	UNWIND_USER_RULE_RETAIN,		/* entity = entity */
+	UNWIND_USER_RULE_CFA_OFFSET,		/* entity = CFA + offset */
+	UNWIND_USER_RULE_REG_OFFSET,		/* entity = register + offset */
+	/* DEREF variants */
+	UNWIND_USER_RULE_CFA_OFFSET_DEREF =	/* entity = *(CFA + offset) */
+		UNWIND_USER_RULE_CFA_OFFSET | UNWIND_USER_RULE_DEREF,
+	UNWIND_USER_RULE_REG_OFFSET_DEREF =	/* entity = *(register + offset) */
+		UNWIND_USER_RULE_REG_OFFSET | UNWIND_USER_RULE_DEREF,
+};
+
+struct unwind_user_rule_data {
+	enum unwind_user_rule rule;
+	s32 offset;
+	unsigned int regnum;
+};
+
 struct unwind_user_frame {
 	s32 cfa_off;
-	s32 ra_off;
-	s32 fp_off;
+	struct unwind_user_rule_data ra;
+	struct unwind_user_rule_data fp;
 	bool use_fp;
 	bool outermost;
 };
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index d5e0fa04b99a..cc57804aa3b1 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -271,6 +271,18 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 	return -EFAULT;
 }
 
+static __always_inline void
+sframe_init_rule_data(struct unwind_user_rule_data *rule_data,
+		      s32 offset)
+{
+	if (offset) {
+		rule_data->rule = UNWIND_USER_RULE_CFA_OFFSET_DEREF;
+		rule_data->offset = offset;
+	} else {
+		rule_data->rule = UNWIND_USER_RULE_RETAIN;
+	}
+}
+
 static __always_inline int __find_fre(struct sframe_section *sec,
 				      struct sframe_fde_internal *fde,
 				      unsigned long ip,
@@ -321,8 +333,8 @@ static __always_inline int __find_fre(struct sframe_section *sec,
 	fre = prev_fre;
 
 	frame->cfa_off = fre->cfa_off;
-	frame->ra_off  = fre->ra_off;
-	frame->fp_off  = fre->fp_off;
+	sframe_init_rule_data(&frame->ra, fre->ra_off);
+	sframe_init_rule_data(&frame->fp, fre->fp_off);
 	frame->use_fp  = SFRAME_V3_FRE_CFA_BASE_REG_ID(fre->info) == SFRAME_BASE_REG_FP;
 	frame->outermost = SFRAME_V3_FRE_RA_UNDEFINED_P(fre->info);
 
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 9ceef9b2b8db..89aecfbe3e84 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -61,22 +61,61 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 		return -EINVAL;
 
 	/* Get the Return Address (RA) */
-	if (frame->ra_off) {
-		if (get_user_word(&ra, cfa, frame->ra_off, state->ws))
-			return -EINVAL;
-	} else {
+	switch (frame->ra.rule) {
+	case UNWIND_USER_RULE_RETAIN:
 		if (!state->topmost || unwind_user_get_ra_reg(&ra))
 			return -EINVAL;
+		break;
+	/*
+	 * UNWIND_USER_RULE_CFA_OFFSET doesn't make sense for RA.
+	 * A return address cannot legitimately be a stack address.
+	 */
+	case UNWIND_USER_RULE_CFA_OFFSET_DEREF:
+		ra = cfa + frame->ra.offset;
+		break;
+	case UNWIND_USER_RULE_REG_OFFSET:
+	case UNWIND_USER_RULE_REG_OFFSET_DEREF:
+		if (!state->topmost || unwind_user_get_reg(&ra, frame->ra.regnum))
+			return -EINVAL;
+		ra += frame->ra.offset;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return -EINVAL;
 	}
+	if (frame->ra.rule & UNWIND_USER_RULE_DEREF &&
+	    get_user_word(&ra, ra, 0, state->ws))
+		return -EINVAL;
 
 	/* Get the Frame Pointer (FP) */
-	if (frame->fp_off && get_user_word(&fp, cfa, frame->fp_off, state->ws))
+	switch (frame->fp.rule) {
+	case UNWIND_USER_RULE_RETAIN:
+		fp = state->fp;
+		break;
+	/*
+	 * UNWIND_USER_RULE_CFA_OFFSET is currently not used for FP
+	 * (e.g. SFrame cannot represent this rule).
+	 */
+	case UNWIND_USER_RULE_CFA_OFFSET_DEREF:
+		fp = cfa + frame->fp.offset;
+		break;
+	case UNWIND_USER_RULE_REG_OFFSET:
+	case UNWIND_USER_RULE_REG_OFFSET_DEREF:
+		if (!state->topmost || unwind_user_get_reg(&fp, frame->fp.regnum))
+			return -EINVAL;
+		fp += frame->fp.offset;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+	if (frame->fp.rule & UNWIND_USER_RULE_DEREF &&
+	    get_user_word(&fp, fp, 0, state->ws))
 		return -EINVAL;
 
 	state->ip = ra;
 	state->sp = cfa;
-	if (frame->fp_off)
-		state->fp = fp;
+	state->fp = fp;
 	state->topmost = false;
 	return 0;
 }
-- 
2.51.0

