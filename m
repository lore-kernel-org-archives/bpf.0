Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF89930C61E;
	Fri,  6 Feb 2026 19:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770406651; cv=none; b=CDP3LxAlNZl5REHXQsrx4K+mTNjWe3LKrssXuhjGEZHTPYO/dSlqM4ppqdaf8nqM97NQ2PcJQUBWUUi0GpSb5o1226DNbh91gBhZPC78ZuZEv1OF7ihz9sPl4r2XH79A6RXYX5e8h/0vWwu1ieFziXkT0Ngnc2IEb/m7TbDWwOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770406651; c=relaxed/simple;
	bh=OAWaLOSHZDpLaJZvLcOOZL28lBXMhQYhK0tmFFzEHD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFsQASvmjgpgoQ7SO5/ivVgt/EtApNc73WhycZ+9oMGUTSF1qR9x26O8H7BWM0RUavErpmgwyL4P3gutHhDDJg1H5awOZX27gzbOhWfXlQ3rgvv+kAIUN+UX3Cmt52g58g9Mr7n9kcaaTaQ8+6QNVOml4rgCpI95TJ8mG71dnig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SkTtRszS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SkTtRszS"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 616DLpbk021704;
	Fri, 6 Feb 2026 19:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Eo/pp0nleSO0EJ0wJ
	M1Dr/9d5BD1HLrvl5BFx61+S2U=; b=SkTtRszSnvu4kzzDHbdtLOuVJBEPdPkrp
	AJZYZoNmKlQazA8VQXdJXxEZik2aOwBo//6Pc1xJG1VjsNrq7Qz8KUIpRa/5yEMg
	Cg9RCKdXqkIzjNmsE3AGPELbR71QZB+0vKpzjdR6GGq6omxtjf5aA6ikqax8RFhO
	r1HBZdHsPN1xQhW1etoPY8hoX4BHDe6ihCI8NdJB1x9eYf2nbzwnXqaL8CXE0qOF
	nK0PER7G3gZXfJ+4F6xXWnqcBX8PQ3Sxf03crmRJNgqMVa2YNEIPqJn+7ZyuwPvS
	hXVzdp/1M3jlwdkW5+cATtPZGoMj/ywACujK0B++ErugdcSWaNu5g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19dtn2k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 19:36:53 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 616JarY2018734;
	Fri, 6 Feb 2026 19:36:53 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19dtn2k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 19:36:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 616JIMGH015359;
	Fri, 6 Feb 2026 19:36:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c4gsgywpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 19:36:51 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 616JalcJ24772906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Feb 2026 19:36:47 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18E3420040;
	Fri,  6 Feb 2026 19:36:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99DAD20043;
	Fri,  6 Feb 2026 19:36:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Feb 2026 19:36:46 +0000 (GMT)
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
        David Hildenbrand <david@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH v8 6/6] x86/vdso: Enable sframe generation in VDSO
Date: Fri,  6 Feb 2026 20:36:42 +0100
Message-ID: <20260206193642.1580787-7-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260206193642.1580787-1-jremus@linux.ibm.com>
References: <20260206193642.1580787-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDE0MyBTYWx0ZWRfXyYp98ghj0CTl
 oBtY/leBNptJ1RaF8DKX0p/UpDtRPwGPAxn4WhDeRvkoh0Xq1jw1IGLAFt3JpKlR9TKskYlM/N4
 H7Ix7A3Lr0YqlVbNCIH5tD6SWg1RoTSr4ejyZJi2oWqn8q87adY5n3gL0RJGREsFOagZvj54aKq
 mHBt5EWfm+++P422P2tYGFx5V4GZO9tDN7G4oz3P+/OuvHlGXlYxN0f3PKJpSguHw9jjtmC04iW
 jU7cJeoSBmdgNkpFsZ/mP0X90OA0E/4w1lpZO5EBdA/sgtcOntsVVdE6ni50dB1PlvnjiV/wk/T
 R9nuIORufkMQtz68MLYTbQmn4L02HlPp5EokrGMwyDyQbJGqaJcd24YQGC2UyeHhDPtRUI/l1L1
 iZ3XO62RefXT6OiyWw7xKl/6IRMjVrMVEW4bIdXywZ1O2BVBHeQWhZIQjZ1c5QdISclmP3yDQRn
 0TQtBK3Gt9x7gVApK6Q==
X-Proofpoint-GUID: g0EbasElDUZeed4PNLBzqj12gLtaZ6p3
X-Proofpoint-ORIG-GUID: 56BAnvhvgqqDiT9io4BOCNC62xKpL8oi
X-Authority-Analysis: v=2.4 cv=LesxKzfi c=1 sm=1 tr=0 ts=698642d5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=VnNF1IyMAAAA:8
 a=IoSOydnM9KY_bAp2vAIA:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011
 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2602060143

From: Josh Poimboeuf <jpoimboe@kernel.org>

Enable sframe generation in the VDSO library so kernel and user space
can unwind through it.

SFrame isn't supported for x32 or x86-32.  Discard .sframe sections for
those VDSOs.

[ Jens Remus: Add support for SFrame V3.  Prevent GNU_SFRAME program
table entry to empty .sframe section. ]

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v8:
    - Discard .sframe for x32 and x86-32 VDSOs. (Josh/Indu)
      Note that the use of KEEP_SFRAME enables to define it for x86-64
      VDSO only.  Unlike CONFIG_AS_SFRAME, which may also be defined
      for x32 and x86-32 VDSO.  In x32 VDSO it would result in superfluous
      .sframe (copied from the x86-64 build - could be removed in X32
      build step).  In x86-32 VDSO it would cause a bogus GNU_SFRAME
      program table entry.
    - Reword commit message (append Josh's private fix).
    - Drop .cfi_sections .sframe in dwarf2.h in favor of the explicitly
      specified more specific assembler option --gsframe-3.  With this
      it is not necessary to undefine CONFIG_AS_SFRAME in
      fake_32bit_build.h.

 arch/Kconfig                                 |  7 +++++++
 arch/x86/entry/vdso/common/vdso-layout.lds.S | 15 +++++++++++++++
 arch/x86/entry/vdso/vdso64/Makefile          |  1 +
 arch/x86/entry/vdso/vdso64/vdso64.lds.S      |  4 ++++
 4 files changed, 27 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 31220f512b16..8170e492a44c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -479,6 +479,13 @@ config HAVE_HARDLOCKUP_DETECTOR_ARCH
 	  It uses the same command line parameters, and sysctl interface,
 	  as the generic hardlockup detectors.
 
+config AS_SFRAME
+	bool
+
+config AS_SFRAME3
+	def_bool $(as-instr,.cfi_startproc\n.cfi_endproc,-Wa$(comma)--gsframe-3)
+	select AS_SFRAME
+
 config UNWIND_USER
 	bool
 
diff --git a/arch/x86/entry/vdso/common/vdso-layout.lds.S b/arch/x86/entry/vdso/common/vdso-layout.lds.S
index 856b8b9d278c..47e6a6a0560a 100644
--- a/arch/x86/entry/vdso/common/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/common/vdso-layout.lds.S
@@ -60,6 +60,13 @@ SECTIONS
 		*(.eh_frame.*)
 	}					:text
 
+#ifdef KEEP_SFRAME
+	.sframe		: {
+		KEEP (*(.sframe))
+		*(.sframe.*)
+	}					:text	:sframe
+#endif
+
 	/*
 	 * Text is well-separated from actual data: there's plenty of
 	 * stuff that isn't used at runtime in between.
@@ -80,6 +87,10 @@ SECTIONS
 		*(.discard)
 		*(.discard.*)
 		*(__bug_table)
+#ifndef KEEP_SFRAME
+		*(.sframe)
+		*(.sframe.*)
+#endif
 	}
 }
 
@@ -89,6 +100,7 @@ SECTIONS
 #define PT_GNU_EH_FRAME	0x6474e550
 #define PT_GNU_STACK	0x6474e551
 #define PT_GNU_PROPERTY	0x6474e553
+#define PT_GNU_SFRAME	0x6474e554
 
 /*
  * We must supply the ELF program headers explicitly to get just one
@@ -104,6 +116,9 @@ PHDRS
 	dynamic		PT_DYNAMIC	PF_R;
 	note		PT_NOTE		PF_R;
 	eh_frame_hdr	PT_GNU_EH_FRAME PF_R;
+#ifdef KEEP_SFRAME
+	sframe		PT_GNU_SFRAME	PF_R;
+#endif
 	gnu_stack	PT_GNU_STACK	PF_RW;
 	gnu_property	PT_GNU_PROPERTY	PF_R;
 }
diff --git a/arch/x86/entry/vdso/vdso64/Makefile b/arch/x86/entry/vdso/vdso64/Makefile
index bfffaf1aeecc..459f8026531e 100644
--- a/arch/x86/entry/vdso/vdso64/Makefile
+++ b/arch/x86/entry/vdso/vdso64/Makefile
@@ -14,6 +14,7 @@ vobjs-$(CONFIG_X86_SGX)		+= vsgx.o
 
 # Compilation flags
 flags-y				:= -DBUILD_VDSO64 -m64 -mcmodel=small
+flags-$(CONFIG_AS_SFRAME3)	+= -Wa,--gsframe-3
 
 # The location of this include matters!
 include $(src)/../common/Makefile.include
diff --git a/arch/x86/entry/vdso/vdso64/vdso64.lds.S b/arch/x86/entry/vdso/vdso64/vdso64.lds.S
index 5ce3f2b6373a..13e30d3b4827 100644
--- a/arch/x86/entry/vdso/vdso64/vdso64.lds.S
+++ b/arch/x86/entry/vdso/vdso64/vdso64.lds.S
@@ -9,6 +9,10 @@
 
 #define BUILD_VDSO64
 
+#ifdef CONFIG_AS_SFRAME
+# define KEEP_SFRAME
+#endif
+
 #include "common/vdso-layout.lds.S"
 
 /*
-- 
2.51.0

