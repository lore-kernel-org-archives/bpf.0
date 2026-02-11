Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0812822127A;
	Wed, 11 Feb 2026 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770819304; cv=none; b=tYzR13ka5cFFvHZgYwtsNpkF3O8teDwjQ7olrddy7cUhxyQA2f4GOZ6QjnWo3Gynj61wbGCDMAPQCMs7BL4HIaEIgfttstwW5hqHXkNnf7Qp9OrZpDbhh28oaGM0vvXCxUfnzyqI+TnJXJze66AqTSg/hTNyQ3CX2N/FBMoqEAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770819304; c=relaxed/simple;
	bh=Cqoc8OQwJhPoux08sZVnmwjAd48dEMQp6KQMjMfzIcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=omlYTBrSC84VJoou/djqB3I+Gl5QbkQ24nPsUo6BfcoCeqtCwJOUCUtZiCsKj3m7wHrEF1F25K6po8Nntoe3eYjGjqXmh2ekPNXVrSXup5y/1NyUpih31+87yJEmq6ZsV3jjl3CNmfbRNL8PY1NbMCdHkR96nxjzRqV513QTwhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pUKOPhDn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pUKOPhDn"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61B3UgPQ1915889;
	Wed, 11 Feb 2026 14:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=C7xAfdpMOTvilgbGfl6MI5ZAQDEnBGLGaHCN4H4rS
	Hg=; b=pUKOPhDnck4Q9STWjISIYOiIe41lRR24JfmI/37W1Yo1912gMHl/Ecjx1
	3jNWqtHbLjmnUFOQ3AS7XFRJ+F9l4IVuZwi5R/XBh0TLAMgCRDxNIdEt9dhzQ79f
	usGQgbeWHDJRKKTWAsMmM48Ok+F+2mujMvr8DWyWIqEPbvOCJ59IAC8nob4WMn2W
	Ha83VXo1S7odKUt1jxm4CGcWqMglcLOmgb780cw2MsEOEjGtn4ghlmCWBLNBp/IJ
	MXctnV0p2umjNVoDYnr6+G8/ayjYZ45B5HSFyhOM/ggYyMDMXa0kzpRiF/gTgg7e
	HW6Qstp1yatVyq8tcCyUBLMIY2aFA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696uhjjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 14:14:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61BAKMMg019225;
	Wed, 11 Feb 2026 14:14:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6hxk5wae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 14:14:02 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61BEDxIi61735212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 14:13:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F10BF2004B;
	Wed, 11 Feb 2026 14:13:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6669B20040;
	Wed, 11 Feb 2026 14:13:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Feb 2026 14:13:58 +0000 (GMT)
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
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH v9 0/6] x86/vdso: VDSO updates and fixes for sframes
Date: Wed, 11 Feb 2026 15:13:51 +0100
Message-ID: <20260211141357.271402-1-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=KZnfcAYD c=1 sm=1 tr=0 ts=698c8eac cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=VnNF1IyMAAAA:8
 a=yyHzTi5TPZ6eMx7n6w4A:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDEwNyBTYWx0ZWRfX07i6X+fQf8zN
 c3Rc2RJMzzVpF375bNDDCP/Dutmx87jRngoa45cIAraPPJeHJH748qXpNHLe99uUUdtyjoM4Z8c
 YQFbVUXqszB/yNASEr3dnEULNKOaq2NPbqlD6gQDgYFIGEV4Rd/jp7Emk2V7F0ROk3u1VOmNx0U
 OI/xiPPnyUUS+MrD8zfP+gcgBueUpNW9XuA3Wv+XJ0uK4dRkCzXNQUEwE5toP5XRDGO03ZlDJGb
 TbfqMc0RkOB8cABLEIzLln5qRD+YZcGOQe7jx08MRFz6WY+qM4gcnkcxKH/ESVjGZW3XUGyBgdV
 Xm/gO1PWbcX2VCLIZ4LizNCsY6y1sTR1843mobX5QOTcrFu/PWenfmh9T89F9a0ub1shMkWnFgO
 c98JwA1naCOOK48mDgkSH1AYsLzIMWFKmWTZi9rhgSHuvr5ix/6xw4tq3uaS/4MOlJbgS55/C7V
 uaMhAJN8DRq2UgdTBPA==
X-Proofpoint-ORIG-GUID: fYxGIuKxI2IysMn88FGH_RM0GYztilz-
X-Proofpoint-GUID: Cud1plyvitWwUQ8LOQUCZYatGYKgBM46
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_01,2026-02-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110107


This enables generation of SFrame V3 stack trace information for VDSO on
x86-64.  It's a continuation of Josh's and Steve's work:

   https://lore.kernel.org/all/cover.1737511963.git.jpoimboe@kernel.org/
   https://lore.kernel.org/all/20250425023750.669174660@goodmis.org/

This series focuses only on the VDSO code. They are helpful fixes
and updates that doesn't rely on sframes (although the last patch
is sframe related).

This series applies on top of tip:x86/entry:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/entry

Like the unwind user sframe series [1] it depends on the binutils 2.46
release to be used to build the VDSO with SFrame V3 stack trace
information (using the assembler option --gsframe-3).

[1]: [PATCH v13 00/18] unwind_deferred: Implement sframe handling,
    https://lore.kernel.org/all/20260127150554.2760964-1-jremus@linux.ibm.com/

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

