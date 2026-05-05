Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBE4478E25;
	Tue,  5 May 2026 12:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983509; cv=none; b=ZTHJA9TBmgOpqNuyxttP9yb/kfob4w35xc8P+UprWWTeAe8ApUSPIEd4vFLkzkNgpr+y7IHpHrLmRGC8sU4LNOsR6qAzvjevDn4IvdwEbhKWBN70UyjvJ3+UTH9ZHfo0shf9CwWj0eY+rOHgX6ZaQgOhdVkCkMN2n8RCrSLqHTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983509; c=relaxed/simple;
	bh=cOqq7IgH5VJlnXgsh0gku+QxLJmsH1taUomnCxgP/Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z2osm6020cm7DECYcOxtqNOs7MMLcAC4vGXO9MrqekG7xzq0WKwxAnOk+ND0qUSSLEGrIBzMxD0dLlyLslAUCHcNrRsmKOjCKlH2ehPZAirv9cOXBFgMfPFDPK7q7uxywBIK+39BRHIYfvNdxF4Phyd4KKx3JT+D8/zMTP4foK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nclHLjg9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nclHLjg9"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644M772W879334;
	Tue, 5 May 2026 12:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=llT3Bhic9idyt3sPU6ZF0LwtwTZv8wZlRy0aUwi7k
	Yg=; b=nclHLjg9YrZoEQ4MKRZANh07/iifQiV1UfKXHAgYmYParIpT5IzgJEYHb
	ElwDWLCTky0n/NYNRVbA6sJm9gQZy239+rtpN7hU5L1Wnvm13znOdv4Dy9TeCsz+
	fRZ6y9J/ChO+RB+Eq0sRAJ+f2kXTngNbhCCl/L93zzKQUOt4tmVRqjf61xM9aFrO
	T9PPJBdH7lG7aiH3Co6GWhfDqceNSRoDOCrPgdWji8CUw0Q+X7CRQzPVzIs2XcYU
	1Rk9dlYc+NfjqnJ78lk68tyE+8nd9MR1PGf0bQi4ZzrXJgO7ojIJCHll6nNVwYrn
	cpcxCb6KswkWYz5ydN/w+c/7+eAHQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x4kg5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 12:17:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645C9jXD024681;
	Tue, 5 May 2026 12:17:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3h1epy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 12:17:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 645CHLLE30081558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 12:17:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B42F2004E;
	Tue,  5 May 2026 12:17:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCC2F20049;
	Tue,  5 May 2026 12:17:20 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 12:17:20 +0000 (GMT)
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
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v14 00/19] unwind_deferred: Implement sframe handling
Date: Tue,  5 May 2026 14:16:59 +0200
Message-ID: <20260505121718.3572346-1-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDExNCBTYWx0ZWRfXzK+tM4dHQ5oJ
 MdX+8Rh7NXcIkVonTW0HV/soapNGLDJeyTVwWimaiCR8J6cLkXy8+4UV4QfiTnErNczrdnpFUM9
 jXUKUZ8Kn3KlJFll7/xE+P8UEMbUD0JBZw/gaOYoTU9qNBnNpw4EAxElEVbn0f4Rf/zG6tK96Cd
 JS9cS880iJjIEf684bTcAgBtSm5AwfHYC5VScXUdS25zAtrNqVc3Mrk4pxK+7m/R9uKmcCpMT7/
 7AbfkTSGV/09f3Fhfx7xsT9zAUhd2EwBwcL9Q2Kxw4CwqZ1Ijyvg8o5j0jS3iNvQUEdtqE4sBOc
 mGXlqKRQeYmi047CR64TdwOlUY1u5SWm803H7/0Nv+cXaErmlh2c2IUUE/5VuS2XvJ7HtL07Fof
 UPeTB+jebxx/dvUUFUf7ApcKhS8pARqzHDHTgzA9inYj9oM7uUYMB5K61QmRGfloI6+m2LgFHAc
 qL4sHHrKJ38JhD6Hzkw==
X-Proofpoint-ORIG-GUID: jy9g1owsajKLLw1g1bQpOgj0ru3-oMpN
X-Proofpoint-GUID: TrA4mvIZfh8aTdD5HOXkna__ldgjOzv5
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69f9dfd7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=CCpqsmhAAAAA:8
 a=JoJwsiaakNZ35iy3YUEA:9 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1011 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050114

This is the implementation of parsing the SFrame V3 stack trace information
from an .sframe section in an ELF file.  It's a continuation of Josh's and
Steve's work that can be found here:

   https://lore.kernel.org/all/cover.1737511963.git.jpoimboe@kernel.org/
   https://lore.kernel.org/all/20250827201548.448472904@kernel.org/

Currently the only way to get a user space stack trace from a stack
walk (and not just copying large amount of user stack into the kernel
ring buffer) is to use frame pointers. This has a few issues. The biggest
one is that compiling frame pointers into every application and library
has been shown to cause performance overhead.

Another issue is that the format of the frames may not always be consistent
between different compilers and some architectures (s390) has no defined
format to do a reliable stack walk. The only way to perform user space
profiling on these architectures is to copy the user stack into the kernel
buffer.

SFrame [1] is now supported in binutils (x86-64, ARM64, and s390). There is
discussions going on about supporting SFrame in LLVM. SFrame acts more like
ORC, and lives in the ELF executable file as its own section. Like ORC it
has two tables where the first table is sorted by instruction pointers (IP)
and using the current IP and finding it's entry in the first table, it will
take you to the second table which will tell you where the return address
of the current function is located and then you can use that address to
look it up in the first table to find the return address of that function,
and so on. This performs a user space stack walk.

Now because the .sframe section lives in the ELF file it needs to be faulted
into memory when it is used. This means that walking the user space stack
requires being in a faultable context. As profilers like perf request a stack
trace in interrupt or NMI context, it cannot do the walking when it is
requested. Instead it must be deferred until it is safe to fault in user
space. One place this is known to be safe is when the task is about to return
back to user space.

This series makes the deferred unwind user code implement SFrame format V3
and enables it on x86-64.

[1]: https://sourceware.org/binutils/wiki/sframe


This series applies on top of v7.1-rc2 tag:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  v7.1-rc2

The to be stack-traced user space programs (and libraries) need to be
built with the recent SFrame stack trace information format V3, as
generated by binutils 2.46+ with assembler option --gsframe-3.

Namhyung Kim's related perf tools deferred callchain support can be used
for testing ("perf record --call-graph fp,defer" and "perf report/script").


Changes since v13 (see patch notes for details):
- Rebase on v7.1-rc2.
- Correct SFRAME_V3_FDE_TYPE_MASK value.
- Fix FDE function start address check in __read_fde().
- Rename SFrame V3 definitions accoring to final specification. (Indu)
- Improve comments on why UNWIND_USER_RULE_CFA_OFFSET is not
  implemented. (Mark Rutland)
- Add/update/improve sframe debug messages.
- Add generic and arch-specific unwind_user.h to MAINTAINERS.
- Add arch-specific unwind_user_sframe.h to MAINTAINERS.

Changes since v12 (see patch notes for details):
- Add support for SFrame V3, including its new flexible FDEs.  SFrame V2
  is not supported.

Changes since v11 (see patch notes for details):
- Adjust to Peter's latest undwind user enhancements.
- Simplify logic by using an internal SFrame FDE representation, whose
  FDE function start address field is an address instead of a PC-relative
  offset (from FDE).
- Rename struct sframe_fre to sframe_fre_internal to align with
  struct sframe_fde_internal.
- Remove unused pt_regs from unwind_user_next_common() and its
  callers. (Peter)
- Simplify unwind_user_next_sframe(). (Peter)
- Fix a few checkpatch errors and warnings.
- Minor cleanups (e.g. move includes, fix indentation).

Changes since v10:
- Support for SFrame V2 PC-relative FDE function start address.
- Support for SFrame V2 representing RA undefined as indication for
  outermost frames.

Patch 1 (new), as a preparatory cleanup, adds the generic and arch-specific
unwind_user.h to MAINTAINERS.

Patches 2, 5, 12, and 18 have been updated to exclusively support the
latest SFrame V3 stack trace information format, that is generated by
binutils 2.46+.  Old SFrame V2 sections get rejected with dynamic debug
message "bad/unsupported sframe header".

Patches 8 and 9 add support to unwind user (sframe) for outermost frames.

Patches 13-16 add support to unwind user (sframe) for the new SFrame V3
flexible FDEs.

Patch 17 improves the performance of searching the SFrame FRE for an IP.

Regards,
Jens


Jens Remus (8):
  unwind_user: Add generic and arch-specific headers to MAINTAINERS
  unwind_user: Stop when reaching an outermost frame
  unwind_user/sframe: Add support for outermost frame indication
  unwind_user: Enable archs that pass RA in a register
  unwind_user: Flexible FP/RA recovery rules
  unwind_user: Flexible CFA recovery rules
  unwind_user/sframe: Add support for SFrame V3 flexible FDEs
  unwind_user/sframe: Separate reading of FRE from reading of FRE data
    words

Josh Poimboeuf (11):
  unwind_user/sframe: Add support for reading .sframe headers
  unwind_user/sframe: Store .sframe section data in per-mm maple tree
  x86/uaccess: Add unsafe_copy_from_user() implementation
  unwind_user/sframe: Add support for reading .sframe contents
  unwind_user/sframe: Detect .sframe sections in executables
  unwind_user/sframe: Wire up unwind_user to sframe
  unwind_user/sframe: Remove .sframe section on detected corruption
  unwind_user/sframe: Show file name in debug output
  unwind_user/sframe: Add .sframe validation option
  unwind_user/sframe/x86: Enable sframe unwinding on x86
  unwind_user/sframe: Add prctl() interface for registering .sframe
    sections

 MAINTAINERS                               |   4 +
 arch/Kconfig                              |  23 +
 arch/x86/Kconfig                          |   1 +
 arch/x86/include/asm/mmu.h                |   2 +-
 arch/x86/include/asm/uaccess.h            |  39 +-
 arch/x86/include/asm/unwind_user.h        |  68 +-
 arch/x86/include/asm/unwind_user_sframe.h |  12 +
 fs/binfmt_elf.c                           |  48 +-
 include/linux/mm_types.h                  |   3 +
 include/linux/sframe.h                    |  60 ++
 include/linux/unwind_user.h               |  18 +
 include/linux/unwind_user_types.h         |  46 +-
 include/uapi/linux/elf.h                  |   1 +
 include/uapi/linux/prctl.h                |   6 +-
 kernel/fork.c                             |  10 +
 kernel/sys.c                              |   8 +
 kernel/unwind/Makefile                    |   3 +-
 kernel/unwind/sframe.c                    | 842 ++++++++++++++++++++++
 kernel/unwind/sframe.h                    |  87 +++
 kernel/unwind/sframe_debug.h              |  68 ++
 kernel/unwind/user.c                      | 111 ++-
 mm/init-mm.c                              |   2 +
 22 files changed, 1423 insertions(+), 39 deletions(-)
 create mode 100644 arch/x86/include/asm/unwind_user_sframe.h
 create mode 100644 include/linux/sframe.h
 create mode 100644 kernel/unwind/sframe.c
 create mode 100644 kernel/unwind/sframe.h
 create mode 100644 kernel/unwind/sframe_debug.h

-- 
2.51.0

