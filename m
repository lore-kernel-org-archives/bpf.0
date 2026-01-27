Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC14367F2B;
	Tue, 27 Jan 2026 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526428; cv=none; b=E3Atr1pxpMFjLdAyh2rMNKAu++OXW1a+0FF6HgD6bQpy2jvHVGxnrurriJfmr3BLIK/usFlnFEmz7bqhGLWgTNIwFtCyBkRU1v0OaQc4Xa4vdmOUjHhjJ/YdEL8jKdCX6uOVC69TIuZNyY6+KtTFleWDrXmZHXpd+M4Uj/sr0dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526428; c=relaxed/simple;
	bh=hvgIJfBpHoLbv5QYTk6mNM3Nal4T0cMKbuSA+NhW1zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pv3t6ja8IGM0BJ687rqdjgEs4oVSFRGoswjTRJm7ozM5mzWvQynogf6HlZnlueMkSXKIwnx6k/JsWY1QTKwCTI/v16L2hyIKPC9IftLopUH28opsTl25zJtCjmpgsB8WbvjSzZIQ4PPS+PW0hdllaVU+rhEYbm5BR1Hs8txuP40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AQytbARN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AQytbARN"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R87Naa019341;
	Tue, 27 Jan 2026 15:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uwWg1c07d9H+HCNvl
	2tElPycvr/BKRKCv9OQussEtx8=; b=AQytbARNP4qnXj8rvVuVNw9y1Nv0ZwBh9
	H6KOkadJB+231cWeUkSoNNPqszf7dHUEJUbQ1tXMiZchBmp42ymnvHXIGit7zajH
	sx+3q1xIZcupRSdvg+sVdpEA1AEPnGYJk7gVBrAMGO0IvUjUD/RV9UHNH1zhuESH
	NSvvWy4h9p90Cq00pfDA+spwCUnwDEe/fq8VKl8/pcBO4tgYONhroFHRbw6JzxUc
	YKWOm9eZg8+NeRAJKkDVL+Vq+6vzGzEsfxduOUMzX3GfKqOW9EafdmBhrxxcsEZv
	FISiyJv++HElpEC8KbOHFsM5ZtnGalsCk2/NmJzn1oBhjD4lX6gbw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmmhje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:06:09 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60REbpce010389;
	Tue, 27 Jan 2026 15:06:08 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmmhja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:06:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RDQUkk026384;
	Tue, 27 Jan 2026 15:06:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9wk91k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:06:07 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RF630x27328964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:06:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C176520040;
	Tue, 27 Jan 2026 15:06:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69B1E2004B;
	Tue, 27 Jan 2026 15:06:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 15:06:03 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
        "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>,
        Dylan Hatch <dylanbhatch@google.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH v13 17/18] unwind_user/sframe/x86: Enable sframe unwinding on x86
Date: Tue, 27 Jan 2026 16:05:52 +0100
Message-ID: <20260127150554.2760964-18-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127150554.2760964-1-jremus@linux.ibm.com>
References: <20260127150554.2760964-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Gr1PO01C c=1 sm=1 tr=0 ts=6978d461 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=7d_E57ReAAAA:8
 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=mDV3o1hIAAAA:8 a=yMhMjlubAAAA:8
 a=VnNF1IyMAAAA:8 a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8 a=7mOBRU54AAAA:8
 a=meVymXHHAAAA:8 a=tblPhtueqqLfq7J8pFgA:9 a=jhqOcbufqs7Y1TYCrUUU:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=HkZW87K1Qel5hWWM3VKY:22 a=wa9RWnbW_A1YIeRBVszw:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-GUID: SC6a_GZaLSJST4dNpImiKnux7OUA9Y5-
X-Proofpoint-ORIG-GUID: jSsw6pqWwih_z9ydwCgegTWt6ewzRfS1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyMSBTYWx0ZWRfXw1eBBKqDLBD+
 tJT/S9j8kxQ14WzVVTLG7J6sZB/xUzwvHYKMQ7tC7bZ9MWiNkdPiS9I+mKv0zg5cKTnQ8Dli0YF
 sZZRaTCPjdsEAf9obXu6NqVzAsRrAanEydsm4HY+sOKgl9356Anq+6ZE1HJimJXoso+IOtQaEZr
 03oKv55mB3H6NgF0X0lCcsqPgiMgFohKuJSQhVVvE60qdgkO8IAH/O/Y2uKVITC1JL+7ROZ+3Ca
 hqGSgg4Sv68EDZG6s2jkU9YIFq8AbhC0Gr1cdQwn94CY+R9jJ1BChvt9rzStXjxpQsDyjSfDgEu
 xykyXvvjlxagpfDkg1/UOZ0jPD1aQ/n5XNrvSI03d9QTfen8oYmwU5yXmqtK+2ENj7lsPLHQoph
 losYFkUzI9G/NpIu+/XF+rDPIp8ZmmBCJ2NHGO7x8d7lwsZjGF3pIXV8eU5jXjhD49ch1IXpEaI
 Pjg2ci3/5LHSTy4N6Rw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270121

From: Josh Poimboeuf <jpoimboe@kernel.org>

The x86 SFrame V3 implementation works fairly well, starting with
binutils 2.46.  Enable it.

[ Jens Remus: Reword commit message for SFrame V3, starting with
binutils 2.46. ]

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Indu Bhagat <indu.bhagat@oracle.com>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Jens Remus <jremus@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Sam James <sam@gentoo.org>
Cc: Kees Cook <kees@kernel.org>
Cc: "Carlos O'Donell" <codonell@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v13:
    - Naive implementation of unwind_user_get_reg() to support SFrame V3
      flexible FDEs (e.g. used to represent DRAP pattern).
    - Define SFRAME_REG_SP and SFRAME_REG_FP to the respective x86-64
      DWARF register numbers.
    - Reword commit message for SFrame V3 and (upcoming) binutils 2.46.

 arch/x86/Kconfig                          |  1 +
 arch/x86/include/asm/unwind_user.h        | 34 +++++++++++++++++++++++
 arch/x86/include/asm/unwind_user_sframe.h | 12 ++++++++
 3 files changed, 47 insertions(+)
 create mode 100644 arch/x86/include/asm/unwind_user_sframe.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 80527299f859..195cb99a590c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -301,6 +301,7 @@ config X86
 	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_UNWIND_USER_FP		if X86_64
+	select HAVE_UNWIND_USER_SFRAME		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
 	select VDSO_GETRANDOM			if X86_64
diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index f38f7c5ff1de..ae46906c3b39 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -15,6 +15,40 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
 	return user_64bit_mode(regs) ? 8 : 4;
 }
 
+static inline int unwind_user_get_reg(unsigned long *val, unsigned int regnum)
+{
+#ifdef CONFIG_X86_64
+	const struct pt_regs *regs = task_pt_regs(current);
+
+	switch (regnum) {
+	/* DWARF register numbers 0..15 */
+	case  0: *val = regs->ax; break;
+	case  1: *val = regs->dx; break;
+	case  2: *val = regs->cx; break;
+	case  3: *val = regs->bx; break;
+	case  4: *val = regs->si; break;
+	case  5: *val = regs->di; break;
+	case  6: *val = regs->bp; break;
+	case  7: *val = regs->sp; break;
+	case  8: *val = regs->r8; break;
+	case  9: *val = regs->r9; break;
+	case 10: *val = regs->r10; break;
+	case 11: *val = regs->r11; break;
+	case 12: *val = regs->r12; break;
+	case 13: *val = regs->r13; break;
+	case 14: *val = regs->r14; break;
+	case 15: *val = regs->r15; break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+#else /* !CONFIG_X86_64 */
+	return -EINVAL;
+#endif /* !CONFIG_X86_64 */
+
+}
+#define unwind_user_get_reg unwind_user_get_reg
+
 #endif /* CONFIG_UNWIND_USER */
 
 #ifdef CONFIG_HAVE_UNWIND_USER_FP
diff --git a/arch/x86/include/asm/unwind_user_sframe.h b/arch/x86/include/asm/unwind_user_sframe.h
new file mode 100644
index 000000000000..d828ae1a4aac
--- /dev/null
+++ b/arch/x86/include/asm/unwind_user_sframe.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_UNWIND_USER_SFRAME_H
+#define _ASM_X86_UNWIND_USER_SFRAME_H
+
+#ifdef CONFIG_X86_64
+
+#define SFRAME_REG_SP	7
+#define SFRAME_REG_FP	6
+
+#endif
+
+#endif /* _ASM_X86_UNWIND_USER_SFRAME_H */
-- 
2.51.0

