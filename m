Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA183FAE1D;
	Wed, 20 May 2026 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779291662; cv=none; b=NYmhTtZoFmzNISyZWsJvkDhlqx28o5iaNnnkmLY0xcVD0RTJnVJ62+v1XXZvss/ISJFhRpy8IpCSMQuea+Q7UsNzrobSl/76ywccsORKfhmGRb4Mx+Iou1hA0C3fUsqB/sKCAaXJe4wvMia6SA3oWZQwT/NZDQQEk+I+XVlg+GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779291662; c=relaxed/simple;
	bh=v9zR+CxaBwVN8AGwvg5kcpnBTB/dRkF7ZIq0HuQ3Qrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsexWf9Dzdis/M3blH/yTFENybIgYUaJ05BlYwlurfcpQatYoKpoojTwZbt7yij9LPfn1E7XQ9ICDGzwiHH2V5YrrDqgS6zdBtLhcZ51ugehLk7hI7WppXqbxyOP/ZmIpVAs9cjIQzH68SXIJD26KOPtk6mf8kPUTwTRDeD3ryk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RmtPp3Yy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RmtPp3Yy"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KDiWDK441640;
	Wed, 20 May 2026 15:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MtnVctqCs7YoKq/Mw
	D8B6NDfS4Kt/fyB5yJ2+IDDGco=; b=RmtPp3YyIDUtcOunstkoYqNG6K8x8vh0d
	XC/ylbnOE2XyhlxSEp2caZGJK2go77jARAMjTX7R+0+Z5v6UteO+Ls2S0qdgCFnN
	U60uDQ+tJ7p2a37n6ngn8nYZHs04DA58wxJ09AsbbwMRFC2C5r9F+Aty5zB+8bwn
	nl0ZqTv9JgYfbhsvKfiDQ79cxsGe5yXLaxK22G6KNFe4G4BF3loxLUbD3+4avKa7
	fQQqtic+nCDXObGnMn1UK5EOpZNQEB/FCQ4AzG/INNFlQTSy1YLrWnx7HNNrUgq0
	+vJ3WGF5O9el91TU3okL+GbzC+Lc3s7U4xk6dKR1zaIPkmRno8Y7w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8hspa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 15:40:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KFdHi1026172;
	Wed, 20 May 2026 15:40:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75ky7q6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 15:40:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KFeI7E8323522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 15:40:18 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53BA320040;
	Wed, 20 May 2026 15:40:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C648620043;
	Wed, 20 May 2026 15:40:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 15:40:17 +0000 (GMT)
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
Subject: [PATCH v15 19/20] unwind_user/sframe/x86: Enable sframe unwinding on x86
Date: Wed, 20 May 2026 17:40:03 +0200
Message-ID: <20260520154004.3845823-20-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1MSBTYWx0ZWRfX1ynlGov/rsON
 ONpIgpdK/avkbTb7ZZZvkfzF6YGwh4OQEO1iP4y0mzix3CRsnkfAe4OxJsWfeTkyal6ZBnSGZds
 PHvbCTPIjXa1A74yNjXEftL/S6ji6anH1FY2m44uaCHmXJgsDSzr/AzjReP2/vFtbaSDJQ2Ib0I
 6Yk2WS6y77HwI59arU7bm2tsbOqHjqNhC1EmtLfelw08L5yun8E4M8MzAjBH2xoP4rmV4mKJzBC
 G4A9/y0TxBAXxZY9MtVuHcpLV29baPqcp+dUmpl4GGAmHKSIES6xTcip4N5bbWmjWge6oNRMtra
 NgcyF2WJLE/d8xjWezuKz+PlP+t1Hk2tBmC+0Ewjyae8g7rPnTKH2co8xCPH5bBRlE5xEM7Jd3L
 UVKc7ERzeHawHQemetQmdAjDxxeY7Ly9oEb3zo6El4/ksr8OO6c8iQSUnnJkilvFHfLCNk+p47W
 YhSFMsigHLvtK7lPNOQ==
X-Proofpoint-GUID: MY3deY7T0eQoBbntI9zjLIpcrmO-vjbB
X-Proofpoint-ORIG-GUID: xgx2UBI6tlWlIKVb1qHEiuYVnXS55moD
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0dd5e7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=BJDwMle8H-fvePKCLUUA:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200151

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
    Changes in v15:
    - unwind_user_get_reg(): Fail if !user_64bit_mode(). (Sashiko AI)
    - unwind_user_get_reg(): Simplify guarding using CONFIG_X86_64.
    - unwind_user_get_reg(): Add pr_debug_once() if unsupported register
      number.
    
    Changes in v14:
    - Drop superfluous empty line in unwind_user_get_reg().
    
    Changes in v13:
    - Naive implementation of unwind_user_get_reg() to support SFrame V3
      flexible FDEs (e.g. used to represent DRAP pattern).
    - Define SFRAME_REG_SP and SFRAME_REG_FP to the respective x86-64
      DWARF register numbers.
    - Reword commit message for SFrame V3 and (upcoming) binutils 2.46.

 arch/x86/Kconfig                          |  1 +
 arch/x86/include/asm/unwind_user.h        | 39 +++++++++++++++++++++++
 arch/x86/include/asm/unwind_user_sframe.h | 12 +++++++
 3 files changed, 52 insertions(+)
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
index f38f7c5ff1de..942475235431 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -15,6 +15,45 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
 	return user_64bit_mode(regs) ? 8 : 4;
 }
 
+#ifdef CONFIG_X86_64
+
+static inline int unwind_user_get_reg(unsigned long *val, unsigned int regnum)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+
+	/* SFrame only supports x86-64 */
+	if (!user_64bit_mode(regs))
+		return -EINVAL;
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
+		pr_debug_once("%s (%d): unwind_user_get_reg(%u): unsupported register number\n",
+			      current->comm, current->pid, regnum);
+		return -EINVAL;
+	}
+	return 0;
+}
+#define unwind_user_get_reg unwind_user_get_reg
+
+#endif /* CONFIG_X86_64 */
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

