Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43A042B73C;
	Tue,  5 May 2026 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984460; cv=none; b=cmD19r8Td5CHUQ2KZ491ugCU2nzOnlqam9VtH5sNH4CUMKLp1Y+cshVnrYsWMKMKvbsg1U8qR42R3aC4hAiIDoT5VVPgkEWSlSOv0NAC8ztPdaaZUW9FB1QGbN+Pc9wVuIaDqOl42H/ePJNUfzhPCvRvB6aYw04+isUpqYYuTKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984460; c=relaxed/simple;
	bh=6ZIpBc/QZ63SyA8rfhy5cczJyFwQMYR+8RxiIjBP1SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwRqw86t7ch5f77odlUSVaE/n+bcGuMVHpZJGROgnKbV8LMvzOBaHa3tA5l7DIhTSF0xJ5OU9LvGuWUsGNJTA+OFzOfVHVYKyAtIRyCtoLMBZtJ029epSjHDUomlnJuJdEoV7lWJ79HQ5FcnQnGG5oLKpBxUbNkaZQRnFhOLUX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z3wxVGHU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z3wxVGHU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645759Y03104130;
	Tue, 5 May 2026 12:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dukp3RbmqmBUYvLDR
	ffdTZCzKZvbBqET3lnQ61OH3Og=; b=Z3wxVGHUA8eHCrHdYrZ81sifMrqOz2E10
	OKDZlGnAAWqP15dBBNVNPlCKAoYdfiyv2yTZ/Rx9xEZaCXcDtB0Ro4yk3s/56B+M
	UaAvq4pvVQYw40gwLSOeJDenbMvz+/9Bvbv1EBzl07IxP4376sQdIJRD6H32S4sp
	VAS7MgxqFik1zWHcq96ySSaLCx9B2MFuUrG7dGQft24w52U0f9tjrzpI6lCSwJi+
	WSNaxT5GG03YK0+6vu44AND0upL50AQivSf4Hc5/dtos3QiGgnbvsvXj/1LoJWeC
	ZUcAaeFqTswXkhzf/+Pr5fvZrbY0QBb+FnKVE0MlTAuceDkz5EqMg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6b9s6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 12:33:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645CORtD013455;
	Tue, 5 May 2026 12:33:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukq9qtn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 12:33:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 645CXhZG11010492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 12:33:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1F842004F;
	Tue,  5 May 2026 12:33:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 487262004E;
	Tue,  5 May 2026 12:33:43 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 12:33:43 +0000 (GMT)
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
        Kees Cook <kees@kernel.org>, Sam James <sam@gentoo.org>,
        Andy Lutomirski <luto@kernel.org>
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
Subject: [PATCH v10 3/6] x86/asm: Use CFI_* macros in SYM_FUNC_* macros so they can be added to VDSO
Date: Tue,  5 May 2026 14:33:37 +0200
Message-ID: <20260505123340.3770025-4-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505123340.3770025-1-jremus@linux.ibm.com>
References: <20260505123340.3770025-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69f9e3ad cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HSAZBKcgB-AHDwtM:21 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=oGMlB6cnAAAA:8 a=VnNF1IyMAAAA:8 a=i3XSr9hboEKZ3AC0laIA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=NdAtdrkLVvyUPsUoGJp4:22
X-Proofpoint-ORIG-GUID: 35CngOw5o1TcLHbOe1fTc6Tnvv3ir5zu
X-Proofpoint-GUID: BAuJCiNjBlWBPSAQfA6QLGY-tMeDFuL1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDExNCBTYWx0ZWRfXz11+5X+/XGVo
 MK6RIRalrORnpcTVrmZwhfOPU0vkULbu5nbxw0+YQUCRnxfYr/cI5QmUXQO9ERpATHop/VP2jjo
 E1uxGe6GftYqSecg61HhBTL6BwTZ0Bl5Iw9wTmWDQVsydgXjDWRSJauNS1ANwy9HIdA3N5ORJfn
 xMM6jBwQ/ufhOwfMH+U1aSD2M16Z/7kReoGfC4HFZ2pop5OJ5doWgRTLskRpjlUKfiaQYzUFMMt
 nJEK7eSCU3/ndieHj07QFdE8EQ1ZWZiqeulV08M3EQzlKGyVI9CsKvwEvlDpw3+5yIMd82L7qy8
 EOMhqYH4/3vBTGRmBULqYGtTYxqHonatHwJSYj3sLvP/EPw6ye4q4gqbHjkASgtZZeRJUsgoxkL
 eFfUvOD43o0h7eoxSMNnaUgXluR4ucgWcFxfMXi/b/K1+dI6L3Chc34nAlovmPfKshs4y2ms98r
 DL6kq8VQT81YJuBSaFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050114

From: Josh Poimboeuf <jpoimboe@kernel.org>

Add CFI_STARTPROC and CFI_ENDPROC annotations to the SYM_FUNC_* macros
so the VDSO asm functions don't need to add them manually.  Note this
only affects VDSO, the CFI_* macros are empty for the kernel proper.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 arch/x86/entry/vdso/common/vdso-layout.lds.S  |  2 +-
 .../x86/entry/vdso/vdso64/vgetrandom-chacha.S |  2 --
 arch/x86/entry/vdso/vdso64/vsgx.S             |  4 ---
 arch/x86/include/asm/linkage.h                | 33 +++++++++++++++----
 arch/x86/include/asm/vdso.h                   |  1 -
 5 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/arch/x86/entry/vdso/common/vdso-layout.lds.S b/arch/x86/entry/vdso/common/vdso-layout.lds.S
index a1e30be3e83d..856b8b9d278c 100644
--- a/arch/x86/entry/vdso/common/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/common/vdso-layout.lds.S
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/vdso.h>
+#include <asm/page_types.h>
 #include <asm/vdso/vsyscall.h>
 #include <vdso/datapage.h>
 
diff --git a/arch/x86/entry/vdso/vdso64/vgetrandom-chacha.S b/arch/x86/entry/vdso/vdso64/vgetrandom-chacha.S
index cc82da9216fb..a33212594731 100644
--- a/arch/x86/entry/vdso/vdso64/vgetrandom-chacha.S
+++ b/arch/x86/entry/vdso/vdso64/vgetrandom-chacha.S
@@ -22,7 +22,6 @@ CONSTANTS:	.octa 0x6b20657479622d323320646e61707865
  *	rcx: number of 64-byte blocks to write to output
  */
 SYM_FUNC_START(__arch_chacha20_blocks_nostack)
-	CFI_STARTPROC
 .set	output,		%rdi
 .set	key,		%rsi
 .set	counter,	%rdx
@@ -175,5 +174,4 @@ SYM_FUNC_START(__arch_chacha20_blocks_nostack)
 	pxor		temp,temp
 
 	ret
-	CFI_ENDPROC
 SYM_FUNC_END(__arch_chacha20_blocks_nostack)
diff --git a/arch/x86/entry/vdso/vdso64/vsgx.S b/arch/x86/entry/vdso/vdso64/vsgx.S
index 37a3d4c02366..c0342238c976 100644
--- a/arch/x86/entry/vdso/vdso64/vsgx.S
+++ b/arch/x86/entry/vdso/vdso64/vsgx.S
@@ -24,8 +24,6 @@
 .section .text, "ax"
 
 SYM_FUNC_START(__vdso_sgx_enter_enclave)
-	/* Prolog */
-	.cfi_startproc
 	push	%rbp
 	.cfi_adjust_cfa_offset	8
 	.cfi_rel_offset		%rbp, 0
@@ -143,8 +141,6 @@ SYM_FUNC_START(__vdso_sgx_enter_enclave)
 	jle	.Lout
 	jmp	.Lenter_enclave
 
-	.cfi_endproc
-
 _ASM_VDSO_EXTABLE_HANDLE(.Lenclu_eenter_eresume, .Lhandle_exception)
 
 SYM_FUNC_END(__vdso_sgx_enter_enclave)
diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index a7294656ad90..c2ca8117376f 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -40,6 +40,10 @@
 
 #ifdef __ASSEMBLER__
 
+#ifndef LINKER_SCRIPT
+#include <asm/dwarf2.h>
+#endif
+
 #if defined(CONFIG_MITIGATION_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
 #define RET	jmp __x86_return_thunk
 #else /* CONFIG_MITIGATION_RETPOLINE */
@@ -112,34 +116,51 @@
 # define SYM_FUNC_ALIAS_MEMFUNC	SYM_FUNC_ALIAS
 #endif
 
+#define __SYM_FUNC_START				\
+	CFI_STARTPROC ASM_NL
+
+#define __SYM_FUNC_END					\
+	CFI_ENDPROC ASM_NL
+
 /* SYM_TYPED_FUNC_START -- use for indirectly called globals, w/ CFI type */
 #define SYM_TYPED_FUNC_START(name)				\
 	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_F_ALIGN)	\
+	__SYM_FUNC_START					\
 	ENDBR
 
 /* SYM_FUNC_START -- use for global functions */
 #define SYM_FUNC_START(name)				\
-	SYM_START(name, SYM_L_GLOBAL, SYM_F_ALIGN)
+	SYM_START(name, SYM_L_GLOBAL, SYM_F_ALIGN)	\
+	__SYM_FUNC_START
 
 /* SYM_FUNC_START_NOALIGN -- use for global functions, w/o alignment */
 #define SYM_FUNC_START_NOALIGN(name)			\
-	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)	\
+	__SYM_FUNC_START
 
 /* SYM_FUNC_START_LOCAL -- use for local functions */
 #define SYM_FUNC_START_LOCAL(name)			\
-	SYM_START(name, SYM_L_LOCAL, SYM_F_ALIGN)
+	SYM_START(name, SYM_L_LOCAL, SYM_F_ALIGN)	\
+	__SYM_FUNC_START
 
 /* SYM_FUNC_START_LOCAL_NOALIGN -- use for local functions, w/o alignment */
 #define SYM_FUNC_START_LOCAL_NOALIGN(name)		\
-	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)
+	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)	\
+	__SYM_FUNC_START
 
 /* SYM_FUNC_START_WEAK -- use for weak functions */
 #define SYM_FUNC_START_WEAK(name)			\
-	SYM_START(name, SYM_L_WEAK, SYM_F_ALIGN)
+	SYM_START(name, SYM_L_WEAK, SYM_F_ALIGN)	\
+	__SYM_FUNC_START
 
 /* SYM_FUNC_START_WEAK_NOALIGN -- use for weak functions, w/o alignment */
 #define SYM_FUNC_START_WEAK_NOALIGN(name)		\
-	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)
+	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)		\
+	__SYM_FUNC_START
+
+#define SYM_FUNC_END(name)				\
+	__SYM_FUNC_END					\
+	SYM_END(name, SYM_T_FUNC)
 
 /*
  * Expose 'sym' to the startup code in arch/x86/boot/startup/, by emitting an
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index f2d49212ae90..bbe270483e3e 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -2,7 +2,6 @@
 #ifndef _ASM_X86_VDSO_H
 #define _ASM_X86_VDSO_H
 
-#include <asm/page_types.h>
 #include <linux/linkage.h>
 #include <linux/init.h>
 
-- 
2.51.0

