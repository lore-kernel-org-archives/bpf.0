Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EADE3839AF;
	Fri, 22 May 2026 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779447903; cv=none; b=uK9FqnC+q3z2wpClqbGKbn8LWYU92jHHYtU/of3BTpstNoFrddvpUAozt88/fs2jkCxsPjVN1vNPO26nP0hATaTFeh0qpRPDOg2CkXJwApioAl7vbuJmd87mGvkw4AcMQEeZ+2opkvTtGQaAzVPo0LaHkG5MxUEqwbCvTcXP6Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779447903; c=relaxed/simple;
	bh=pbEcWFdrYE1pvPPY1UVIfO6RazPLCFOoif6AGoGMuoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YS52sQp0E3WhMhukwJ0d4wAYGEt5hlu7l06lbO+j1DXkJ8LKr/h89Gmw1FwVCTZmcN/qLegLnmPjJAqucx6/ex+0c1hfWlcCI4HPJBq5wxsxQfe26rItqGLGKtLaoKdkLAgLw+W8pc1laUpfgVhyYUUfyZirFHHslkm0iUXMEjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sWlGo0Xg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sWlGo0Xg"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M0EbfD2799624;
	Fri, 22 May 2026 11:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=7o7C8hNkmHga6ni6+8HWP2rNkOEx2Ddd24EktKysi
	tQ=; b=sWlGo0XgWoW2zJU7QumXzGizw1BT+mZTeVpBFvBSJalW95wtoY2yojWlt
	JIOIRl+jJGmBjMrYiXcZpxpu8PmrJhk3Y3ukzFkc5W6wqX7y/vxu/Uv3EgA+CwmD
	32XKmygVwRvzv8+rTsTc4/NgL5RBxHpMaZfRAQQnxw+gOtWpo6V2JjHbxVuJQrZQ
	q2aIJIe0ivbPmoZexqF7pqIbhTl/2bk4y7haf+m9BxoYoqEbPRWYHCWJMC2F8qrP
	i32LIkUX5KP1scZY/lRFPKJbwQdRL/4sZTBjnwgu3FHMpM9w9/2HVa0xqyHZQWA/
	Z5zFpmt6iMgVz/DODURr5qA6lz9hQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hawj6mb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 11:04:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MAs5tN024410;
	Fri, 22 May 2026 11:04:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kyga2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 11:04:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MB4Tb648103864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 11:04:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93A0A20043;
	Fri, 22 May 2026 11:04:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CC6420040;
	Fri, 22 May 2026 11:04:29 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 11:04:29 +0000 (GMT)
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
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v11 0/6] x86/vdso: VDSO updates and fixes for sframes
Date: Fri, 22 May 2026 13:04:21 +0200
Message-ID: <20260522110427.2816637-1-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEwNiBTYWx0ZWRfX+TDXweVFZHqj
 GS1NitCuCg/j1MjKXOFZJlDydgsWi5MKMNIw4uD3YIxMnYlRPLQfUO1wRe+eVZlKlQTBtUzbfAJ
 9ZSOA5+xXgMWbLimo8txT58q0K4nj5uK4hn2lzCSSFpAZPIyIljEDcmg/S7biwrxqA/dzJm975O
 fmsMx05o8M8cVAd186z04ZULHwh5nveYVJRVJMCfbfYOMBAV2HXWsC1fEIKpqPB7ZRc1xGkouUB
 F/aPC7BpN8biFLpusrxNKQelSc9xbr+HtqeLLkbcmXzjighYUvYdZcC4+Jm1cLx8AK7YJFemOBI
 6rbS4QMokOuJShmBcg2XDeD9u7hUm4fgTqy3HqBdYAQm807YsGYU9Dv3LnmM5a/UtXQtBvKoZn9
 F4Xk6NLkYHSmUg6N105YDVbtDcHyZYIpovINL76imdL1+Hx2QAQ8VYdUV0c19WyQ2OxZoOCYYIM
 2k0A37IE8nKqXHAXVIA==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a103843 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=VnNF1IyMAAAA:8
 a=yyHzTi5TPZ6eMx7n6w4A:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: ozfd_wF-1anxlquG0TPfkjxCdxnnqWUf
X-Proofpoint-GUID: LTcWUY6ILTYE_T_CPU-TcOshhvcaNiyD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220106

This enables generation of SFrame V3 stack trace information for VDSO on
x86-64.  It's a continuation of Josh's and Steve's work:

   https://lore.kernel.org/all/cover.1737511963.git.jpoimboe@kernel.org/
   https://lore.kernel.org/all/20250425023750.669174660@goodmis.org/

This series focuses only on the VDSO code. They are helpful fixes
and updates that doesn't rely on sframes (although the last patch
is sframe related).

This series applies on top of tip:master (b07a332d9cbb):

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master

Like the unwind user sframe series [1] it depends on the binutils 2.46
release to be used to build the VDSO with SFrame V3 stack trace
information (using the assembler option --gsframe-3).

[1]: [PATCH v14 00/19] unwind_deferred: Implement sframe handling,
    https://lore.kernel.org/all/20260505121718.3572346-1-jremus@linux.ibm.com/

Changes in v11:
- Rebased on tip:master (b07a332d9cbb).
- This time with correct version in cover letter.

Changes in v10:
- Rebased on tip:master (a375022d6383).

Changes in v9 (see indivicual patch notes):
- Always define KEEP_SFRAME to either true/false in specific VDSO linker
  scripts and use #if instead of #ifdef in common one. (Peter)
- Reword patch 6 commit message to provide more details.
- Note: Binutils 2.46 with SFrame V3 support has been released.

Changes in v8:
- Discard .sframe for x32 and x86-32 VDSOs. (Josh/Indu)
- Define CFI_SIGNAL_FRAME for !BUILD_VDSO.
- Drop .cfi_sections .sframe in dwarf2.h in favor of the explicitly
  specified more specific assembler option --gsframe-3.
- Incorporate missing changes and review feedback from Steven's v6
  (I erroneously based my v6 on Steven's v5):
  - Reword patch 3 commit subject to Steven's v6 one.
  - Remove SYM_F_ALIGN in __vdso_sgx_enter_enclave(). (Josh)

Changes in v7:
- Rebase on H. Peter Anvin's vDSO changes on tip:x86/entry. (Peter)
- Simplify adding assembler option -Wa,--gsframe-3.  Add for vdso64
  only.
- Align to .eh_frame and mark .sframe as KEEP in vDSO linker script.
  Note that GNU linker 2.46 will mark .sframe as KEEP in its default
  linker script as well.

Changes in v6:
- SFrame V3 support (SFrame V2 is not supported).
- Prevent GNU_SFRAME program table entry to empty .sframe section.
- Integrate v5 review feedback. (Josh)

Regards,
Jens


Josh Poimboeuf (6):
  x86/vdso: Fix DWARF generation for getrandom()
  x86/asm: Avoid emitting DWARF CFI for non-VDSO
  x86/asm: Use CFI_* macros in SYM_FUNC_* macros so they can be added to
    VDSO
  x86/vdso: Use SYM_FUNC_{START,END} in __kernel_vsyscall()
  x86/vdso: Use CFI macros in __vdso_sgx_enter_enclave()
  x86/vdso: Enable sframe generation in VDSO

 arch/Kconfig                                  |  7 +++
 arch/x86/entry/vdso/common/vdso-layout.lds.S  | 17 +++++-
 arch/x86/entry/vdso/vdso32/system_call.S      | 10 +---
 arch/x86/entry/vdso/vdso32/vdso32.lds.S       |  3 ++
 arch/x86/entry/vdso/vdso64/Makefile           |  1 +
 arch/x86/entry/vdso/vdso64/vdso64.lds.S       |  2 +
 arch/x86/entry/vdso/vdso64/vdsox32.lds.S      |  6 +++
 .../x86/entry/vdso/vdso64/vgetrandom-chacha.S |  3 +-
 arch/x86/entry/vdso/vdso64/vsgx.S             | 18 +++----
 arch/x86/include/asm/dwarf2.h                 | 52 +++++++++++++------
 arch/x86/include/asm/linkage.h                | 33 +++++++++---
 arch/x86/include/asm/vdso.h                   |  1 -
 12 files changed, 107 insertions(+), 46 deletions(-)

-- 
2.51.0

