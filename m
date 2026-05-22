Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4853B3D567F;
	Fri, 22 May 2026 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779447913; cv=none; b=dUjJyyb26AHCT7MhuH7cE7tosrsRSLatrW/Z9toIbauPR0TM1JNL/7CIY/QQzPGE8DkSrVzGcNGsAuy09rUd1g23RoNFtcrv1WHbPNSW/Zc4JsfK33qaFdIS2aoC6NpDnkjYdu0TAeCklFC1t+iTBYg/pionGSMIfTl6u6FSP1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779447913; c=relaxed/simple;
	bh=oq0FWBveUGSeMhAcXcysR6Ct95jkvRt2c4zuz73D7JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RL8g0G6E7gU0qy3kF925Y61ggUfnyMLxEpnLGXy3QGEQTkYqx8lQ8gwXj+/PwTFt9cozeT6Ltkx9fTwUjfZoUce8C5e3deRbPFBDYsKr/z63z3cWkveEq6pUW9BNfFVufXhdyUAE5lGJUus5Xj62ddLMNzY/X9vQvxgaiYQhYN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CbRzUMcy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CbRzUMcy"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M8gjpX4104744;
	Fri, 22 May 2026 11:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Zcp5Naq2FPjOG1kV+
	prJJdfvki9PYjEAiotKE3UfUD8=; b=CbRzUMcymi1aDcsKkdt4nhhI4Uwf3qiA1
	HpBtvV7GbVfyk4LYRjyOvEhNirakl4a2CpmaC5Hqtqvr8xiqmuApsRhlti0vrd4e
	iY9FJjrbF8TiRFnLl+e6uEjRleb87DpaZn71Ubd7XNppBqGWak6Zpd5VNnF4PB9r
	TMVoH4sorDu0Y4gLVPI4jaTnE4Cab4nuIWXBuW8Sbp7lmNlMNYyeA6E6Sv/X5N3G
	pqAlvOxuc53N4utG5sBnjqUJSfwnBYsSVegErwc/3HWJl3AJcRhu0bSQc/MxsigX
	Y1/tffNfzggjdT11PK1Ne2MYw2P7Dr/nqC7KHa59RFbyU/o+0XrYQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9ybpy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 11:04:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MAs412023355;
	Fri, 22 May 2026 11:04:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754grbvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 11:04:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MB4VdI53412240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 11:04:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B8C320040;
	Fri, 22 May 2026 11:04:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C04720043;
	Fri, 22 May 2026 11:04:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 11:04:31 +0000 (GMT)
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
Subject: [PATCH v11 4/6] x86/vdso: Use SYM_FUNC_{START,END} in __kernel_vsyscall()
Date: Fri, 22 May 2026 13:04:25 +0200
Message-ID: <20260522110427.2816637-5-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260522110427.2816637-1-jremus@linux.ibm.com>
References: <20260522110427.2816637-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEwNiBTYWx0ZWRfX/P+uhVtwQr8m
 jhzMNaPEWoxj6Aqb0Z2DWWrXmNUy1ftmdFxyoj8e/9okIXSBVlSgejEHULeqLn/u1sP9OMOTy1G
 8mT8asYURR4ixiKKjicXsZ74SLZQxc/+4r0dpkU9PeiWGe8Diu+Opbg0CzqEVBEQg0mMqSk/pMs
 zqb7lwX4Vybr/bccO8cJ6PQb/6CSUXPdnDuq1FVgSfHDKC5BNfpe+ItQQ4n0hRZ7qT7OPS9da0y
 /1F9qQkVPp2dR8mai4arUnYrrc1g+pI8zx//w4YoB2XQS/+cgJCgoyeVy5Ud+wu0Z9E4IO9O//I
 LjnhswJblw8RQ0IPBk2+5H3rRNHgP0piy7bYEPduxIb2oKKq8HFFD5K7NtjNH3Nk6tDKs9xuJv9
 G6uwntNAoCTj36tUH+5jHk4hHX8EKHe3BM2KEHWLRBmy5+psHxqc6MYdOmYsn+KyGbpqajcbHsC
 WeSo6msJrgvQcON2EcA==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a103844 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=oGMlB6cnAAAA:8
 a=VnNF1IyMAAAA:8 a=lbqDleH5ITP0AWbVeFgA:9 a=2JgSa4NbpEOStq-L5dxp:22
 a=NdAtdrkLVvyUPsUoGJp4:22
X-Proofpoint-ORIG-GUID: V04qTLS_ndhFQVXOrx3v6E8pDtAyfImf
X-Proofpoint-GUID: qfbfDGJSQ5fC5_k0WxLQ4DjWXQ-o8VtO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220106

From: Josh Poimboeuf <jpoimboe@kernel.org>

Use SYM_FUNC_{START,END} instead of all the boilerplate.  No functional
change.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 arch/x86/entry/vdso/vdso32/system_call.S | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso32/system_call.S b/arch/x86/entry/vdso/vdso32/system_call.S
index 9157cf9c5749..a90f4f7de396 100644
--- a/arch/x86/entry/vdso/vdso32/system_call.S
+++ b/arch/x86/entry/vdso/vdso32/system_call.S
@@ -9,11 +9,7 @@
 #include <asm/alternative.h>
 
 	.text
-	.globl __kernel_vsyscall
-	.type __kernel_vsyscall,@function
-	ALIGN
-__kernel_vsyscall:
-	CFI_STARTPROC
+SYM_FUNC_START(__kernel_vsyscall)
 
 	/*
 	 * If using int $0x80, there is no reason to muck about with the
@@ -85,7 +81,5 @@ SYM_INNER_LABEL(int80_landing_pad, SYM_L_GLOBAL)
 	CFI_RESTORE		ecx
 	CFI_ADJUST_CFA_OFFSET	-4
 	RET
-	CFI_ENDPROC
-
-	.size __kernel_vsyscall,.-__kernel_vsyscall
+SYM_FUNC_END(__kernel_vsyscall)
 	.previous
-- 
2.51.0

