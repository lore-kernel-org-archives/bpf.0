Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD982BCF43;
	Wed, 11 Feb 2026 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770819259; cv=none; b=GNqFonqjTZO0gQNbcYjquDv8EW/Ux25zhZAR5kMPXIyLRUe2MRb1NCsBZYMfdNfDvpIZ5Tp+tL57lpJdwn5kRFMKqsD1rp8RdcXJ6oufL/VKvDyVmeZY0iHmWdG0pMW6wR4eAsEJIesupVd+Fp/RaHKHc8iBsiDL9qWeolFUoik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770819259; c=relaxed/simple;
	bh=SDVEHIVGeJRga/cenvkjR0/NXUnkcS502IutEhhhYro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rO6+Qv6PW/Bnu0MqbQ3KvSH/RVF3TGe4khlWumQQA8dqAoGUTbuSbzdVcZ8bgAVZYcRvpsesoTQDJHIkdUUrwQxWuRpiulnrqGQ3ZRJy9vj9V6X0U3OrR8EkIIEEYq5x9buLcecWDpWVe1BEUCskK80473VkGbhniNS3W3WWdKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OtHCEJS9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OtHCEJS9"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61ANslr2470140;
	Wed, 11 Feb 2026 14:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qiH+5t/dirTrzjD9Z
	dtQxW3Rb7kBj9PpVkHn0IEvdoQ=; b=OtHCEJS9FYwWQwev3XdeyV80sYiX60gha
	1o/sM9KcwYWvyQ8bAD3QYfkFgHibOqhVyYfH1+YFimppjc0nl6BEpUnydRmJfHxI
	Vha+nJjpbJM6+kswkEvy4AJUmYLP0/PKZpboICxCFaGP8mRmpUSIRS0ScOn4SOpH
	hDdwG9eLauie4j1MHHe0dPE74SstV5E+7OEBKOYhLhe9BagCycw7qERpzBAqCzV6
	zIDGYgr/W0AsSPK/Cnf+ScRCjBtq9o/Y917pFiH0OWOuTdU7O9V6EQafh7UHn48E
	JlkKfJuWyHolj8NAvKTN05URL7lLlk/2zM010EhPPpa74Z+/1hiVA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696wy141-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 14:14:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61BCt5Jh002567;
	Wed, 11 Feb 2026 14:14:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6fqsp93s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 14:14:05 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61BEE2Wm44171750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 14:14:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E128920040;
	Wed, 11 Feb 2026 14:14:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DA172004B;
	Wed, 11 Feb 2026 14:14:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Feb 2026 14:14:01 +0000 (GMT)
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
Subject: [PATCH v9 5/6] x86/vdso: Use CFI macros in __vdso_sgx_enter_enclave()
Date: Wed, 11 Feb 2026 15:13:56 +0100
Message-ID: <20260211141357.271402-6-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211141357.271402-1-jremus@linux.ibm.com>
References: <20260211141357.271402-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WZYBqkhX c=1 sm=1 tr=0 ts=698c8eae cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=oGMlB6cnAAAA:8
 a=VnNF1IyMAAAA:8 a=zHpKlsP_3zAlDdbrjxAA:9 a=2JgSa4NbpEOStq-L5dxp:22
 a=NdAtdrkLVvyUPsUoGJp4:22
X-Proofpoint-GUID: yaSfy3Y2S2nZC2d5EupOPnVwvtL2ZOYD
X-Proofpoint-ORIG-GUID: yaSfy3Y2S2nZC2d5EupOPnVwvtL2ZOYD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDEwNyBTYWx0ZWRfXz+3TUP9I9FB+
 mSytwbvWbAr+l1482s09TggHikYA11hlHEPTZ28cxfVt1dMz+e9/xafBI7kDDlISioSELkRqu4F
 1FwknobKOFUOTb3ATrvFXKJmwfhDlJvFov8pdAS/ly829RO5yuHQOPhjqoUgQ/Rh/YPIyFv9C6W
 8cDf50a/gYSS305gKbsKALv+bBShmyNaR5BwYrSUjbiYWqoc9mWF1SDEXMIjIl3MWeLMTqy2Lr1
 JiitKqxcf1WsPkzx/ZI4+nW1DawkoEJ77691qtszjQR2c265uQIWKyAC4uxg2P3XJBbnPwMSfLp
 ZnWVyFaTqWrHLD8n/dGIOidxfDLXseJxZrNN+9zSbXIMjZyxwKhZjhmdYZDuM2xm5A5zkdb/y+f
 JV8OdxMLywBFiXS9sUfmyfUQuETHAurUCPmdYsOjvX6Ubg12vcDl5bs7LuyurdqoI5mJsmomBF4
 SIQdDgNwM97883w0aUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_01,2026-02-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110107

From: Josh Poimboeuf <jpoimboe@kernel.org>

Use the CFI macros instead of the raw .cfi_* directives to be consistent
with the rest of the VDSO asm.  It's also easier on the eyes.

No functional changes.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 arch/x86/entry/vdso/vdso64/vsgx.S | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso64/vsgx.S b/arch/x86/entry/vdso/vdso64/vsgx.S
index c0342238c976..76efbeb1e287 100644
--- a/arch/x86/entry/vdso/vdso64/vsgx.S
+++ b/arch/x86/entry/vdso/vdso64/vsgx.S
@@ -25,12 +25,12 @@
 
 SYM_FUNC_START(__vdso_sgx_enter_enclave)
 	push	%rbp
-	.cfi_adjust_cfa_offset	8
-	.cfi_rel_offset		%rbp, 0
+	CFI_ADJUST_CFA_OFFSET	8
+	CFI_REL_OFFSET		%rbp, 0
 	mov	%rsp, %rbp
-	.cfi_def_cfa_register	%rbp
+	CFI_DEF_CFA_REGISTER	%rbp
 	push	%rbx
-	.cfi_rel_offset		%rbx, -8
+	CFI_REL_OFFSET		%rbx, -8
 
 	mov	%ecx, %eax
 .Lenter_enclave:
@@ -77,13 +77,11 @@ SYM_FUNC_START(__vdso_sgx_enter_enclave)
 .Lout:
 	pop	%rbx
 	leave
-	.cfi_def_cfa		%rsp, 8
+	CFI_DEF_CFA		%rsp, 8
 	RET
 
-	/* The out-of-line code runs with the pre-leave stack frame. */
-	.cfi_def_cfa		%rbp, 16
-
 .Linvalid_input:
+	CFI_DEF_CFA		%rbp, 16
 	mov	$(-EINVAL), %eax
 	jmp	.Lout
 
-- 
2.51.0

