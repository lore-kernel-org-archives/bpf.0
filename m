Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBFA3FBEC5;
	Wed, 20 May 2026 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779291665; cv=none; b=l/o8yT6b3U2H6CLrme3dkAwCUH3TUWr3ebcumMkxtO29B/U5jIxVybLZENqgfCG7uoha59EAPSWY2FHX1mEFdXK1JPDNRgAYNctORA1WYf+y24CNQpAxwV1yDl1E/x6bgbXnF6+agBTNhxWU5a4jmJ5MdCtp4kuK8eTnOAxpIrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779291665; c=relaxed/simple;
	bh=Tx9NNmKYA9KlmlyvKjTqRLgOHSsGh3wqj6BzpKYCLdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMUVnB16HlebC6gZbx62g2QngLFvvsUJhI/bK1mqJpz8qwPMR9dL0OJ4yfRHFNNtchcSnrVfgG3yrcNbn4gjOEETZMgXjPopzZa3Y/Qwy7OWr/YJ7EbJqpr+iSqHXR/J2KZz8PMQDV07rRD/8hj3OSx1kn2qjiZHXHtZX3NATF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n0RsZKAl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n0RsZKAl"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KDjwTS3464297;
	Wed, 20 May 2026 15:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fkwnhD2WmLbXls7AF
	23dDCFV4Jum648jzmG8gUQ48wA=; b=n0RsZKAlpgoRQGjZV1JCOfZocoJlM2FnF
	MNHfsNF+UwH95dbXrubMER35Tg4OcvS7X5jPhapxp79XbVaaLCOisOyOgVe2Ld4J
	cR53xHiPaxrYQLz39HenJ75R33aFzlBvyj2q4K0aTy2YI+8G5MrW7bI4JjPHHrEp
	MbbKXaoBTs5IVx+TUleXf2V39ccZzOIo9LxpXOz5nRFWePDHB5k1AMmHg4/8LJFA
	7kM+P0WU3FOazJIsgsII7XQgcJZ6FdD6yqyHNdmCUpNnNtnd2+BTW5zmYRMGgNDu
	VHXohilPWdVcuuBl3NwqRiyBOTRoa++/w++yN/7jS833IvQ76JytQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h752tam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 15:40:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KFd6aj031984;
	Wed, 20 May 2026 15:40:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wk801s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 15:40:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KFeGFm49480164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 15:40:16 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0904720040;
	Wed, 20 May 2026 15:40:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 748492004B;
	Wed, 20 May 2026 15:40:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 15:40:15 +0000 (GMT)
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
Subject: [PATCH v15 15/20] unwind_user: Flexible CFA recovery rules
Date: Wed, 20 May 2026 17:39:59 +0200
Message-ID: <20260520154004.3845823-16-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260520154004.3845823-1-jremus@linux.ibm.com>
References: <20260520154004.3845823-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0dd5e6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=BPVtMwLGy6aXIs-GLTYA:9
X-Proofpoint-ORIG-GUID: Et2AxjJa3Pj5hZ9P6YS9rixUG5u30Bxd
X-Proofpoint-GUID: alsWMSSF3RoBq4pWCZzCaW2wyGxtsgZi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1MSBTYWx0ZWRfXwEAaGgncNazS
 K3O7aDPEFTy0urcJGZvRbU84B2qZOMrJeE0uANav4q0zbAtahuusOYIUnmql7Ripk/CitiGnEEM
 3UpbIo3Hg5iScbuVyR0+hUDQ8SE1iWL8l33h5iHaX8KSGUDioLguxV+9ri0dti2JfItyKu6lvp1
 BIsk6BJ6HZGHTg+/EPCdf7JFVl714WKiCR/pnIiHjE0agryiBfq3PEffwwSn1d5G87HJ3XW7IS3
 CfCu9lAeKw3j6prRmLsH5+NZildLM2zEBlw1Es/faTPnDtfOjIgqU86UgNee/0xz14NAYUmvwEW
 VRhP3FqLyGwAgB2TirkkpeLHOEnnwAXfkzVmi5xmAuNnPLnXrwiq4xJz25OA/kkd1El9th4pRMB
 /9yE6zg6n9IeH+QxiSCex7KmPO6qcKvQUPPVEMnH799ThgIHqlQWw7nDuoHVBEsmKhbEIZi7qZW
 Sq8lKfRbgc50N1t718Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200151

To enable support for SFrame V3 flexible FDEs with a subsequent patch,
add support for the following flexible Canonical Frame Address (CFA)
recovery rules:

  CFA = SP + offset
  CFA = *(SP + offset)
  CFA = FP + offset
  CFA = *(FP + offset)
  CFA = register + offset
  CFA = *(register + offset)

Note that CFA recovery rules that use arbitrary register contents are
only valid when in the topmost frame, as their contents are otherwise
unknown.

Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v15:
    - enum unwind_user_cfa_rule, unwind_user_next_common(): Add support for
      SP/FP-based CFA recovery rules with dereferencing. (Sashiko AI)

 arch/x86/include/asm/unwind_user.h | 12 ++++++++----
 include/linux/unwind_user_types.h  | 22 ++++++++++++++++++++--
 kernel/unwind/sframe.c             | 15 +++++++++++++--
 kernel/unwind/user.c               | 24 ++++++++++++++++++++----
 4 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index 9c3417be4283..f38f7c5ff1de 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -20,7 +20,10 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
 #ifdef CONFIG_HAVE_UNWIND_USER_FP
 
 #define ARCH_INIT_USER_FP_FRAME(ws)			\
-	.cfa_off	=  2*(ws),			\
+	.cfa		= {				\
+		.rule		= UNWIND_USER_CFA_RULE_FP_OFFSET,\
+		.offset		=  2*(ws),		\
+			},				\
 	.ra		= {				\
 		.rule		= UNWIND_USER_RULE_CFA_OFFSET_DEREF,\
 		.offset		= -1*(ws),		\
@@ -29,11 +32,13 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
 		.rule		= UNWIND_USER_RULE_CFA_OFFSET_DEREF,\
 		.offset		= -2*(ws),		\
 			},				\
-	.use_fp		= true,				\
 	.outermost	= false,
 
 #define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)		\
-	.cfa_off	=  1*(ws),			\
+	.cfa		= {				\
+		.rule		= UNWIND_USER_CFA_RULE_SP_OFFSET,\
+		.offset		=  1*(ws),		\
+			},				\
 	.ra		= {				\
 		.rule		= UNWIND_USER_RULE_CFA_OFFSET_DEREF,\
 		.offset		= -1*(ws),		\
@@ -41,7 +46,6 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
 	.fp		= {				\
 		.rule		= UNWIND_USER_RULE_RETAIN,\
 			},				\
-	.use_fp		= false,			\
 	.outermost	= false,
 
 static inline bool unwind_user_at_function_start(struct pt_regs *regs)
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index 0d02714a1b5d..c18be5b7d586 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -29,6 +29,25 @@ struct unwind_stacktrace {
 
 #define UNWIND_USER_RULE_DEREF			BIT(31)
 
+enum unwind_user_cfa_rule {
+	UNWIND_USER_CFA_RULE_SP_OFFSET,		/* CFA = SP + offset */
+	UNWIND_USER_CFA_RULE_FP_OFFSET,		/* CFA = FP + offset */
+	UNWIND_USER_CFA_RULE_REG_OFFSET,	/* CFA = register + offset */
+	/* DEREF variants */
+	UNWIND_USER_CFA_RULE_SP_OFFSET_DEREF =	/* CFA = *(SP + offset) */
+		UNWIND_USER_CFA_RULE_SP_OFFSET | UNWIND_USER_RULE_DEREF,
+	UNWIND_USER_CFA_RULE_FP_OFFSET_DEREF =	/* CFA = *(FP + offset) */
+		UNWIND_USER_CFA_RULE_FP_OFFSET | UNWIND_USER_RULE_DEREF,
+	UNWIND_USER_CFA_RULE_REG_OFFSET_DEREF =	/* CFA = *(register + offset) */
+		UNWIND_USER_CFA_RULE_REG_OFFSET | UNWIND_USER_RULE_DEREF,
+};
+
+struct unwind_user_cfa_rule_data {
+	enum unwind_user_cfa_rule rule;
+	s32 offset;
+	unsigned int regnum;
+};
+
 enum unwind_user_rule {
 	UNWIND_USER_RULE_RETAIN,		/* entity = entity */
 	UNWIND_USER_RULE_CFA_OFFSET,		/* entity = CFA + offset */
@@ -47,10 +66,9 @@ struct unwind_user_rule_data {
 };
 
 struct unwind_user_frame {
-	s32 cfa_off;
+	struct unwind_user_cfa_rule_data cfa;
 	struct unwind_user_rule_data ra;
 	struct unwind_user_rule_data fp;
-	bool use_fp;
 	bool outermost;
 };
 
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index e82d1dcdd471..6187379750db 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -283,6 +283,18 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 	return -EFAULT;
 }
 
+static __always_inline void
+sframe_init_cfa_rule_data(struct unwind_user_cfa_rule_data *cfa_rule_data,
+			  unsigned char fre_info,
+			  s32 offset)
+{
+	if (SFRAME_V3_FRE_CFA_BASE_REG_ID(fre_info) == SFRAME_BASE_REG_FP)
+		cfa_rule_data->rule = UNWIND_USER_CFA_RULE_FP_OFFSET;
+	else
+		cfa_rule_data->rule = UNWIND_USER_CFA_RULE_SP_OFFSET;
+	cfa_rule_data->offset = offset;
+}
+
 static __always_inline void
 sframe_init_rule_data(struct unwind_user_rule_data *rule_data,
 		      s32 offset)
@@ -344,10 +356,9 @@ static __always_inline int __find_fre(struct sframe_section *sec,
 		return -EINVAL;
 	fre = prev_fre;
 
-	frame->cfa_off = fre->cfa_off;
+	sframe_init_cfa_rule_data(&frame->cfa, fre->info, fre->cfa_off);
 	sframe_init_rule_data(&frame->ra, fre->ra_off);
 	sframe_init_rule_data(&frame->fp, fre->fp_off);
-	frame->use_fp  = SFRAME_V3_FRE_CFA_BASE_REG_ID(fre->info) == SFRAME_BASE_REG_FP;
 	frame->outermost = SFRAME_V3_FRE_RA_UNDEFINED_P(fre->info);
 
 	return 0;
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index c6a2abac78e0..447061b10613 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -53,14 +53,30 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 	}
 
 	/* Get the Canonical Frame Address (CFA) */
-	if (frame->use_fp) {
+	switch (frame->cfa.rule) {
+	case UNWIND_USER_CFA_RULE_SP_OFFSET:
+	case UNWIND_USER_CFA_RULE_SP_OFFSET_DEREF:
+		cfa = state->sp;
+		break;
+	case UNWIND_USER_CFA_RULE_FP_OFFSET:
+	case UNWIND_USER_CFA_RULE_FP_OFFSET_DEREF:
 		if (state->fp < state->sp)
 			return -EINVAL;
 		cfa = state->fp;
-	} else {
-		cfa = state->sp;
+		break;
+	case UNWIND_USER_CFA_RULE_REG_OFFSET:
+	case UNWIND_USER_CFA_RULE_REG_OFFSET_DEREF:
+		if (!state->topmost || unwind_user_get_reg(&cfa, frame->cfa.regnum))
+			return -EINVAL;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return -EINVAL;
 	}
-	cfa += frame->cfa_off;
+	cfa += frame->cfa.offset;
+	if (frame->cfa.rule & UNWIND_USER_RULE_DEREF &&
+	    get_user_word(&cfa, cfa, 0, state->ws))
+		return -EINVAL;
 
 	/*
 	 * Make sure that stack is not going in wrong direction.  Allow SP
-- 
2.51.0

