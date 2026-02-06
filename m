Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0964E30E0EE;
	Fri,  6 Feb 2026 19:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770406647; cv=none; b=cS2beFMP1Vz4jv4KECqbsGKsa8mDl3sCXIXvbt+KAmdOyJro/ednu9TEuPeETlNbU7CxiUuqwRVihFzaNHhaSafFdnJK831PEPOFPvy0RDRXvVwdYbEQQrL+p4Fb5qB5yFMaiJ8o0tt8XkwBknKdle0aRWW5d05WuL11M7bqteM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770406647; c=relaxed/simple;
	bh=NGofp+qvy17jUvjKvFtS/73yn0m/Bavo1aPuGTsYU/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HntUc5AXOPHkBhUb6EcSuB/hyGN6Y+H+hGVyybA/bGRDcU/o8Fwy5UPCszX+1cR+kldX2ttGQjS+xsrNC5IKMsX1CRyH85CENO4EffxQZieOA1+0ICK8J6GJEn7jhhiF1F183bXWyVY+MlcK6TGRnk0B2DDGqFRtOaR7uJK1dGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jZu2R8dS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jZu2R8dS"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 616CwK45032189;
	Fri, 6 Feb 2026 19:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Sn287xhEf2Z9VJU3y
	h0bF7Kq6J2ymS6I6sGqlb7excs=; b=jZu2R8dSykYgcVDA4kkGoc2G9HgWjqfPu
	mXJq9KhhkB7iMm4MEjXpWb1sZD7EbAJ6fNB1QGkjL2bpuXtLQ+vzaHr7sA4j6zPJ
	mwXFphLGB9NgD6Tkhglox36+Wvl1ZfwbFC5Qv28c5MU7ADcoNKFm/DOr5vCs/ABz
	JrHp1DwLX8ImLINkg9B7v4zdT0c30t1MI4kKfQoWNUdhmGOBL4kkDuSFsSBW2vzO
	s8N7T23jH6b+s1mPsYwQ/Mi7rnabHQOeumwg3R04sJTcRBzAK5bdHHMg4xBQqa+c
	A8Y++PbcG0NTHjANs81yM8+GBf/0yyw3t1+6H90RpE0LgOrCo9Yuw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c185h9yhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 19:36:52 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 616JaplX004342;
	Fri, 6 Feb 2026 19:36:51 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c185h9yhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 19:36:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 616H0bKC025703;
	Fri, 6 Feb 2026 19:36:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1w2n7j9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 19:36:50 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 616Jak7w46596546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Feb 2026 19:36:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9333820040;
	Fri,  6 Feb 2026 19:36:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2081E2004B;
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
Subject: [PATCH v8 5/6] x86/vdso: Use CFI macros in __vdso_sgx_enter_enclave()
Date: Fri,  6 Feb 2026 20:36:41 +0100
Message-ID: <20260206193642.1580787-6-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=UdxciaSN c=1 sm=1 tr=0 ts=698642d4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=oGMlB6cnAAAA:8
 a=VnNF1IyMAAAA:8 a=zHpKlsP_3zAlDdbrjxAA:9 a=2JgSa4NbpEOStq-L5dxp:22
 a=NdAtdrkLVvyUPsUoGJp4:22
X-Proofpoint-GUID: bymhufXf1uUZ3hm-vPfESYKQzLkRnFG-
X-Proofpoint-ORIG-GUID: g3m2Z2TPNlXn0rou7v6QvC6IKZeplVJt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEzOSBTYWx0ZWRfX7dA5giIZIQ3P
 W8A5VU6cBOu0y+u5fkH+98aeWtK18LL7CbyetZAC7ac7ALHGaQ2HjfHySUTlz8xJ6ciXz7T4lv6
 woUzzuAI7FsrcJYFjA4MIIQCmd5BaeUj9FpDrBUXl9Rfmnsive+MSJQmFsYMxC+PjEs1wHBZe4o
 0P+JsC7c9tZtYR2VsL0sbsbpEHy+gW3mREpQgW+tQzdQJ728kK67+iWYIe53jajHu90mru05sQ7
 6roJfhqp4Chndvlqw3Zen9YbBumH59+6JgdOLwECQhu+fdzscS1J8IOfC3TcelQLaKGYAvq27Rn
 X/EHO4L7DjYWOTOu8xMDXfQ3NpCj1j/ZGI5DHN+K+WMJtHiYnNZ6LnxgYhmmO9sqn7nWnXorIm7
 05LaLLJ+15NbJ/z37iCCMrFWZnGq5xlHtRhRVZPPvY6c+cef9C64rihc1UjXvgZVJqZXs92i8XM
 G7r0Rfzv+Gx6BSI9ftQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602060139

From: Josh Poimboeuf <jpoimboe@kernel.org>

Use the CFI macros instead of the raw .cfi_* directives to be consistent
with the rest of the VDSO asm.  It's also easier on the eyes.

No functional changes.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v8:
    - Remove SYM_F_ALIGN. (Josh)
      https://lore.kernel.org/all/amh7fzsjx4p5nowy3b3j6blkty5ojqf7jawtlslexwzdbxrhc3@zersgacmcnai/

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

