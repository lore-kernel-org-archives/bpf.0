Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8C33803C6;
	Thu, 29 Jan 2026 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769686100; cv=none; b=cv6IDNR+Hi2i8gKoCaW7WC/rcPFVdhWxJZ+hOBhMcHSF1NxS52iaR3KNm0iRQ9psHObToEWel/AM+kDWERYu+B9a+I/ulDLdA4+j+K4LZnZnctSgzCCr8tM93IZhIXGQzCdsnjSWTk0d/FKHzDK8KMjoyOvszK6KjOkI6wtj6cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769686100; c=relaxed/simple;
	bh=9MJJArQoNvsP/VKdnm0R8HeQt9h4EA3Z6uLBIgq+Jus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFmETJ7VY6rfQfGKMLQLUtN8Kho4o0GNmGC8J93mOgjEZlqflnRyH7NSq9OdyRCaCtOJHroQAwYEeLybVhE/hsxrloWo2pd+tbUe4Q9yVohB7+7bL8dsH3nWGiehKVZZqhm0u+wuAsrGzpnlJCdPjVCcldl+RHrI9YpvxO2IbXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fmHPfMHj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fmHPfMHj"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60SLbET0024602;
	Thu, 29 Jan 2026 11:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IkzHqjw7Quv/1lQEk
	BGMQK/7nNo0dijsdSsDrvkxEas=; b=fmHPfMHjzAT53C7zpLE1I6TSkIT/9/Z6v
	CN/PBInQD01CMavvjZ/Y4wAdjNKWToJTCZUBgxlQC8/iED0DSXzyDtcZ/4k4MF+c
	raMluOuvRdf7fHyyH8dBWDIB6xyh8DC70jsQTLFkxKkqe3n79b1jvyh41z5hgGUh
	fYlzNaHA13xoZaMXIOlAf/ZrLqCggQ3IF9juaiETPEHk4IgqO2z2DAuZuXGxOnM9
	elkbr4fE0eVbLqIdDxencVznvGK/xE5DM6rxB5wGraX0lyGP4EpTxDCz0Ge77LWe
	WjhDppluicQ36nuQqm+uEWIA5OxSzs6RAK0L3+dEabGRK/JXe5c6g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrtr7wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 11:27:35 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60TBRYYd025755;
	Thu, 29 Jan 2026 11:27:34 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrtr7w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 11:27:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60T8SfCs018394;
	Thu, 29 Jan 2026 11:27:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwb421777-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 11:27:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60TBRTOx27001316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 11:27:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BFA620043;
	Thu, 29 Jan 2026 11:27:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7850720063;
	Thu, 29 Jan 2026 11:27:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Jan 2026 11:27:28 +0000 (GMT)
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
Subject: [PATCH v6 1/6] x86/vdso: Fix DWARF generation for getrandom()
Date: Thu, 29 Jan 2026 12:27:21 +0100
Message-ID: <20260129112726.892340-2-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129112726.892340-1-jremus@linux.ibm.com>
References: <20260129112726.892340-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5P16niUu5fnM_03ZbV24Md8SiiyC6Ndj
X-Authority-Analysis: v=2.4 cv=Uptu9uwB c=1 sm=1 tr=0 ts=697b4427 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8
 a=VnNF1IyMAAAA:8 a=rsc5PF6bQGhcUx5MhlsA:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: -gEHCNz9_kSMTT1AgYGNNuOuZqwKSrMp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDA3NiBTYWx0ZWRfXzFMmW3i8oKoP
 ife3f0NiGzr8EAlHvpVxAh4fbgqeizX5KArUmRVt1ai4yW4+0sus5vEcaCCZAX9ycVCXXvclEtn
 0hliKLvcXi5zivMf56FH4Ke7kfuYBn83NbIyopX7ZFsi3WitAZWH8mmOWZXHnmm7Hh4cZ2BINj6
 Vdh7NJXx4a7MprUSEG9USzMlCrKj9/lhBoouzQ9CcUbYmysqZleqs7WI+BwnFMgyY15qoX7oPqD
 I+WHKtoV6Z5DwM8hMYMPVSgFkhUZPOQXU8oSyY9b5Zzz09AvEQKw+ozmch70GU5tw8S7nv7Kk4R
 wJaSEr8s0OBlPVWWLHdXmuukfQHs9JGicDhgd7SMvuVEBZwf5EYkDQG+N96e7BZsKvlX/tPeG96
 JM/WxWM9F6CEKy1M2d+J/bFstQ8/Y8R3veUXzr7vvDeSz7kjgG3L2GIpByEdW5nl5g0r5oBjR4f
 4ILCyoRGelB551zGyBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601290076

From: Josh Poimboeuf <jpoimboe@kernel.org>

Add CFI annotations to the VDSO implementation of getrandom() so it will
have valid DWARF unwinding metadata.

Fixes: 33385150ac45 ("x86: vdso: Wire up getrandom() vDSO implementation")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 arch/x86/entry/vdso/vgetrandom-chacha.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/vgetrandom-chacha.S b/arch/x86/entry/vdso/vgetrandom-chacha.S
index bcba5639b8ee..cc82da9216fb 100644
--- a/arch/x86/entry/vdso/vgetrandom-chacha.S
+++ b/arch/x86/entry/vdso/vgetrandom-chacha.S
@@ -4,7 +4,7 @@
  */
 
 #include <linux/linkage.h>
-#include <asm/frame.h>
+#include <asm/dwarf2.h>
 
 .section	.rodata, "a"
 .align 16
@@ -22,7 +22,7 @@ CONSTANTS:	.octa 0x6b20657479622d323320646e61707865
  *	rcx: number of 64-byte blocks to write to output
  */
 SYM_FUNC_START(__arch_chacha20_blocks_nostack)
-
+	CFI_STARTPROC
 .set	output,		%rdi
 .set	key,		%rsi
 .set	counter,	%rdx
@@ -175,4 +175,5 @@ SYM_FUNC_START(__arch_chacha20_blocks_nostack)
 	pxor		temp,temp
 
 	ret
+	CFI_ENDPROC
 SYM_FUNC_END(__arch_chacha20_blocks_nostack)
-- 
2.51.0

