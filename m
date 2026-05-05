Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF5C441041;
	Tue,  5 May 2026 12:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983509; cv=none; b=r1Xf02egJLBDIR+8ZA3U7Rcugllf7Yn9ajtfon0CVXTUIaJBhxTZRkvL/rfNb0C6gKLbtBvAdAgkDuOqHKA4LgbEb3EGD6884jSLCkvB+u7a+AfrbEW2DLM2UcV5kUHwFHzIkQFMtOYom1aDYk1cdDdIeDv+oKqDBmk4EtDwCcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983509; c=relaxed/simple;
	bh=dQ3MEkFBssymppa9xBBcf1/EKwkyzQUKOzvnCZiUpyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGEfgO5fY6hzMaIt06kTm9S4+LjsnqFSIp28Iq8Yh3a8nPpT3fMkf0SFYeDRwr/KltLxy0ylf1vWP2yCnGtqs48bTzeRFK1qMwjBwLElG8L97or+8ETmcmqrYeB99OOpHykC9KM94e+LqDZiYKByrpjj9WleT0hqqG58d1uelqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FtfZd4ry; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FtfZd4ry"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6456A3de3182093;
	Tue, 5 May 2026 12:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=x08tC+lfWLJ46E0BX
	z9C4AQirN+u4zkUsjRqoQtFpXY=; b=FtfZd4ryPVkLU7KElGl42+t6ua2i+5MPX
	jSKgi+4yIyMlJS7Ibui3E7r/LLOa2gwUHm+sbE0dScbkiFppYIgyIX8QFSxiJNxQ
	BcO4t3p3kzWNhQKu8mAzepFQbxVWpE/B8p3YQ/TOiVlPLfjzhxv7LBJKa2rPxfW1
	fibTcToytoBGjEbKYCb/pTHH1hrrfi8GMScujpka6DpPcTzIdvw1XoKson5yhZ1c
	TqwNnWbWVweyNFWECeF4PcaT0YqHHldmevMwfiI58UMXznZ4204zKiP5s32780lT
	OrL7F8ROQzRpTjvevtK7vhZ2DBFHTWd6B9evzQjVb5S3hQKBrKSFA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxk5dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 12:17:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645C9dd0028522;
	Tue, 5 May 2026 12:17:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyw1m3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 12:17:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 645CHTff48955718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 12:17:29 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 089EB2004D;
	Tue,  5 May 2026 12:17:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B3212004E;
	Tue,  5 May 2026 12:17:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 12:17:28 +0000 (GMT)
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
        Ilya Leoshkevich <iii@linux.ibm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH v14 18/19] unwind_user/sframe/x86: Enable sframe unwinding on x86
Date: Tue,  5 May 2026 14:17:17 +0200
Message-ID: <20260505121718.3572346-19-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDExNCBTYWx0ZWRfX5eIgOiYSAVYE
 gElSVNIYwjC+gm3x9lJpoB3LhvyZaM8ze69qZvB0gkry/I2PHAEKK/M+0J5TilUholuTcn6JMjy
 RqwDtQzBNP7c52ykWcs4vBzV8Kp7lzrSkEbL6vCRA2Syg9STB8zwvaEnB1/qoC3w2XsxAeJUvH4
 nVpavikiq9He78B41gzJu+SY2m6RDpEwuKrwO8UPKFNg4Eh/EWQ/k/CNR4fo+/Du9BzfYuwy9cX
 lxbSQYuxBhp5/sShe0Y+SG+yB2YJXfR1cQsWPvL8lyyfY5fvuyPDLd2NVVD9jZEQelF2KxfCteg
 Lo3sQc4HS8+QPHcyDi0cnci2/EfR70uH4wXjtMQgEDVFiCM9c2XFCdV984+Q/5cxQKBGbxOtlTN
 xvUMXQJ7TmNMi5rnc5guWvcMBxmX3RF3edENd8v02WbNpszEIzStA4PU7xKMSwGcXRBtsubJ9rv
 kNWp0wqRkScUu6NA6MQ==
X-Proofpoint-ORIG-GUID: AQlMQiA4R5gyjNW1nup077lPuGq6n5_t
X-Proofpoint-GUID: rWYMWQbXEDhvt5xo-cN5CNnAkkafnuaD
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69f9dfde cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=Nb24OjdhCh9FoptYTSsA:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1011
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050114

From: Josh Poimboeuf <jpoimboe@kernel.org>

The x86 SFrame V3 implementation works fairly well, starting with
binutils 2.46.  Enable it.

[ Jens Remus: Reword commit message for SFrame V3, starting with
binutils 2.46. ]

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v14:
    - Drop superfluous empty line in unwind_user_get_reg().
    
    Changes in v13:
    - Naive implementation of unwind_user_get_reg() to support SFrame V3
      flexible FDEs (e.g. used to represent DRAP pattern).
    - Define SFRAME_REG_SP and SFRAME_REG_FP to the respective x86-64
      DWARF register numbers.
    - Reword commit message for SFrame V3 and (upcoming) binutils 2.46.

 arch/x86/Kconfig                          |  1 +
 arch/x86/include/asm/unwind_user.h        | 33 +++++++++++++++++++++++
 arch/x86/include/asm/unwind_user_sframe.h | 12 +++++++++
 3 files changed, 46 insertions(+)
 create mode 100644 arch/x86/include/asm/unwind_user_sframe.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f3f7cb01d69d..51286dfdb5f4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -302,6 +302,7 @@ config X86
 	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_UNWIND_USER_FP		if X86_64
+	select HAVE_UNWIND_USER_SFRAME		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
 	select VDSO_GETRANDOM			if X86_64
diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index f38f7c5ff1de..b80f0ec0f7a7 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -15,6 +15,39 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
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

