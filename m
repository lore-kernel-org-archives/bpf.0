Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71D335EDCC;
	Tue, 27 Jan 2026 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526422; cv=none; b=TO907YDKEiIX5Xkikk9Tl+1DwA7JGjs4xqDC8MlytqknRlrIFg7B1Ms9LeThz75DSEL6zDa44IPjcs/PxyIbntXxDsvgfVjGCSewqj939O3OtE4UFDXCEEBelyuqu7Mq49jiqiy8VW2XDjJw5MQXUJ4o2OLGAWj8WiDENV498cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526422; c=relaxed/simple;
	bh=Yp/q6S4FQghc3PZA/xbnvDPuYwgSc5y3GWTyaNDo0Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXQPps0c5R65PC8lhQGOrUmOwt+h0T7/i8BlCZhSWLrUqR/9laKbAK9uuanOa5eq4AEoAvrOdVGOt+sQq1QhXcQw2JEVKFucfDG0FSZznfXwT00AHltQfXWYxMeIRPdA4QIWucQ8mG7dC+JsFv9Pmqwg7BinMAp3y4EiNEEp+oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b2dhKUAg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b2dhKUAg"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R731Qb021146;
	Tue, 27 Jan 2026 15:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7Yoqs7fR6uybY6XM2
	9/Ri0f5H39nTiUmzWKwan6lvgs=; b=b2dhKUAgwKAoIdraPmJhsQcUUbf+CxMuY
	SW11FsdHArPhhKJ/F/2zaKoqBN9voPIfPEs0YGkVOsk44BRBFd/qL2WTgxbmO16+
	zwXoyrpPM0osol2YwF4VIK70kWkK5Uw5Mkzbaa03nx7Ehob3wkDWDlQKjGAnopsc
	m/q4cDoguRGT432cgGNT5OvuhyaiBIVVsNCWhKXK62ZzXvbUW0dSDzl/veTtSr3t
	eXGMYJ8R2SchnOBKByGPQMWPNV+EIhbafg3KbH/6nxddGLZn2BVENn+VBqPrhpha
	uxT0xIM+iko6XT5hESVSx4YoFT0Vk3fT/+TeCS3rfLV5H2tayoYzA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnr646qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:06:03 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60REbkt2008750;
	Tue, 27 Jan 2026 15:06:02 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnr646q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:06:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RE0G2W026319;
	Tue, 27 Jan 2026 15:06:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9wk91jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:06:01 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RF5vhP15597876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:05:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4865A20040;
	Tue, 27 Jan 2026 15:05:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7B3F2004E;
	Tue, 27 Jan 2026 15:05:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 15:05:56 +0000 (GMT)
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
Subject: [PATCH v13 01/18] unwind_user/sframe: Add support for reading .sframe headers
Date: Tue, 27 Jan 2026 16:05:36 +0100
Message-ID: <20260127150554.2760964-2-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127150554.2760964-1-jremus@linux.ibm.com>
References: <20260127150554.2760964-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyMSBTYWx0ZWRfXySYEBGmWu/Su
 3txPG92HqFUlDLN1xIkf+EK61hW9mi0SB+ApZ+ibVrNzHxR9RyDKLLFCm39BZwaIWRR0y4wH3J/
 pXYaOmpxbd56ZBu95Erw99pJHPzJdKrm6mTPU1l4tq/R+avCUFldYzkvqkSqjK+yGXJ8FU4Wo+C
 YrtvpmSbyfaSbSbr9YDqlU/DibbgVAORBod2aA76pwsjMm5SwyyeY0EJnoe0r+WOT9TiNmugJm2
 aYcLPKcBlRLXnCgW2vCmV9FbJIKEe8QpjraTiShmSiblub1FEzPhMJzCkthRNp+e/lL0bv4Lncs
 w8hWMudQX83/qMRhev1nlNFYl+UCFPxil4pt4QlNfnav6l1WB82747fZzl9Jr/bey+3eNcnvSRz
 KQtK46YnvNNG5pTrgLpjXTBpsW8g3zvc/3A2i4EsI5gwa+wnsfV0P8Ne7lLZ7zxxf4kOT95+Jqw
 /1j3tRbx39/AcS1zGzA==
X-Proofpoint-GUID: DsM9M45YuOzFQyLA6np9lhFgO2lae4Ty
X-Proofpoint-ORIG-GUID: zQ5awoGs6fGROUQ-xhWsKwUtmUR4dewc
X-Authority-Analysis: v=2.4 cv=X+Vf6WTe c=1 sm=1 tr=0 ts=6978d45b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=CCpqsmhAAAAA:8
 a=7d_E57ReAAAA:8 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=mDV3o1hIAAAA:8
 a=yMhMjlubAAAA:8 a=VnNF1IyMAAAA:8 a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8
 a=7mOBRU54AAAA:8 a=meVymXHHAAAA:8 a=FcC2FuIPsPklFa1YY6kA:9 a=gWTG3a1JFnwA:10
 a=0rJyKvmL6cEA:10 a=ul9cdbp4aOFLsgKbc677:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=HkZW87K1Qel5hWWM3VKY:22 a=wa9RWnbW_A1YIeRBVszw:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270121

From: Josh Poimboeuf <jpoimboe@kernel.org>

In preparation for unwinding user space stacks with sframe, add basic
sframe compile infrastructure and support for reading the .sframe
section header.

sframe_add_section() reads the header and unconditionally returns an
error, so it's not very useful yet.  A subsequent patch will improve
that.

Link: https://lore.kernel.org/all/f27e8463783febfa0dabb0432a3dd6be8ad98412.1737511963.git.jpoimboe@kernel.org/

[ Jens Remus: Add support for SFrame V3.  Add support for PC-relative
FDE function start offset.  Cleanup includes and indentation. ]

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Indu Bhagat <indu.bhagat@oracle.com>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Jens Remus <jremus@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Sam James <sam@gentoo.org>
Cc: Kees Cook <kees@kernel.org>
Cc: "Carlos O'Donell" <codonell@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v13:
    - Update to SFrame V3:
      - Add and use SFRAME_VERSION_3 definition.
      - Add helper macros to access SFrame V3 FDE type.
      - Rename SFRAME_FUNC_*() macros to SFRAME_FDE_*().
      - Rename SFRAME_FDE_TYPE_PC* defines to SFRAME_FDE_PCTYPE_* and
        SFRAME_FUNC_FDE_TYPE() macro to SFRAME_V3_FDE_PCTYPE().
      - Reword OFFSET to DATAWORD in SFRAME_FRE_OFFSET_{COUNT|SIZE}()
        macros.
      - Rename version-specific SFRAME_*() macros to SFRAME_V3_*().
      - Update struct sframe_fde and rename to sframe_fde_v3:
        - Change field start_addr from s32 to s64 and rename to
          func_start_off.
        - Change field fres_num from u32 to u16.
        - New field u8 info2.
        - Remove u16 padding field.
      - Split FDE into function descriptor entry (struct sframe_fde_v3) and
        attributes (struct sframe_fde_v3).
      - Rename macro parameter "data" to "info" to hint at fde/fre info
        word and wrap it in parenthesis.
    - Group SFRAME_* definitions so that related ones are together.
    - Reword commit message (my changes).

 MAINTAINERS            |   1 +
 arch/Kconfig           |   3 +
 include/linux/sframe.h |  37 +++++++++++
 kernel/unwind/Makefile |   3 +-
 kernel/unwind/sframe.c | 136 +++++++++++++++++++++++++++++++++++++++++
 kernel/unwind/sframe.h |  81 ++++++++++++++++++++++++
 6 files changed, 260 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/sframe.h
 create mode 100644 kernel/unwind/sframe.c
 create mode 100644 kernel/unwind/sframe.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9d..79cff4f4df56 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27226,6 +27226,7 @@ USERSPACE STACK UNWINDING
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Steven Rostedt <rostedt@goodmis.org>
 S:	Maintained
+F:	include/linux/sframe.h
 F:	include/linux/unwind*.h
 F:	kernel/unwind/
 
diff --git a/arch/Kconfig b/arch/Kconfig
index 31220f512b16..7d5517364d8b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -486,6 +486,9 @@ config HAVE_UNWIND_USER_FP
 	bool
 	select UNWIND_USER
 
+config HAVE_UNWIND_USER_SFRAME
+	bool
+
 config HAVE_PERF_REGS
 	bool
 	help
diff --git a/include/linux/sframe.h b/include/linux/sframe.h
new file mode 100644
index 000000000000..0642595534f9
--- /dev/null
+++ b/include/linux/sframe.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SFRAME_H
+#define _LINUX_SFRAME_H
+
+#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
+
+struct sframe_section {
+	unsigned long	sframe_start;
+	unsigned long	sframe_end;
+	unsigned long	text_start;
+	unsigned long	text_end;
+
+	unsigned long	fdes_start;
+	unsigned long	fres_start;
+	unsigned long	fres_end;
+	unsigned int	num_fdes;
+
+	signed char	ra_off;
+	signed char	fp_off;
+};
+
+extern int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
+			      unsigned long text_start, unsigned long text_end);
+extern int sframe_remove_section(unsigned long sframe_addr);
+
+#else /* !CONFIG_HAVE_UNWIND_USER_SFRAME */
+
+static inline int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
+				     unsigned long text_start, unsigned long text_end)
+{
+	return -ENOSYS;
+}
+static inline int sframe_remove_section(unsigned long sframe_addr) { return -ENOSYS; }
+
+#endif /* CONFIG_HAVE_UNWIND_USER_SFRAME */
+
+#endif /* _LINUX_SFRAME_H */
diff --git a/kernel/unwind/Makefile b/kernel/unwind/Makefile
index eae37bea54fd..146038165865 100644
--- a/kernel/unwind/Makefile
+++ b/kernel/unwind/Makefile
@@ -1 +1,2 @@
- obj-$(CONFIG_UNWIND_USER)	+= user.o deferred.o
+ obj-$(CONFIG_UNWIND_USER)		+= user.o deferred.o
+ obj-$(CONFIG_HAVE_UNWIND_USER_SFRAME)	+= sframe.o
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
new file mode 100644
index 000000000000..c128c1eeaca2
--- /dev/null
+++ b/kernel/unwind/sframe.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Userspace sframe access functions
+ */
+
+#define pr_fmt(fmt)	"sframe: " fmt
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/srcu.h>
+#include <linux/uaccess.h>
+#include <linux/mm.h>
+#include <linux/string_helpers.h>
+#include <linux/sframe.h>
+#include <linux/unwind_user_types.h>
+
+#include "sframe.h"
+
+#define dbg(fmt, ...)							\
+	pr_debug("%s (%d): " fmt, current->comm, current->pid, ##__VA_ARGS__)
+
+static void free_section(struct sframe_section *sec)
+{
+	kfree(sec);
+}
+
+static int sframe_read_header(struct sframe_section *sec)
+{
+	unsigned long header_end, fdes_start, fdes_end, fres_start, fres_end;
+	struct sframe_header shdr;
+	unsigned int num_fdes;
+
+	if (copy_from_user(&shdr, (void __user *)sec->sframe_start, sizeof(shdr))) {
+		dbg("header usercopy failed\n");
+		return -EFAULT;
+	}
+
+	if (shdr.preamble.magic != SFRAME_MAGIC ||
+	    shdr.preamble.version != SFRAME_VERSION_3 ||
+	    !(shdr.preamble.flags & SFRAME_F_FDE_SORTED) ||
+	    !(shdr.preamble.flags & SFRAME_F_FDE_FUNC_START_PCREL) ||
+	    shdr.auxhdr_len) {
+		dbg("bad/unsupported sframe header\n");
+		return -EINVAL;
+	}
+
+	if (!shdr.num_fdes || !shdr.num_fres) {
+		dbg("no fde/fre entries\n");
+		return -EINVAL;
+	}
+
+	header_end = sec->sframe_start + SFRAME_HEADER_SIZE(shdr);
+	if (header_end >= sec->sframe_end) {
+		dbg("header doesn't fit in section\n");
+		return -EINVAL;
+	}
+
+	num_fdes   = shdr.num_fdes;
+	fdes_start = header_end + shdr.fdes_off;
+	fdes_end   = fdes_start + (num_fdes * sizeof(struct sframe_fde_v3));
+
+	fres_start = header_end + shdr.fres_off;
+	fres_end   = fres_start + shdr.fre_len;
+
+	if (fres_start < fdes_end || fres_end > sec->sframe_end) {
+		dbg("inconsistent fde/fre offsets\n");
+		return -EINVAL;
+	}
+
+	sec->num_fdes		= num_fdes;
+	sec->fdes_start		= fdes_start;
+	sec->fres_start		= fres_start;
+	sec->fres_end		= fres_end;
+
+	sec->ra_off		= shdr.cfa_fixed_ra_offset;
+	sec->fp_off		= shdr.cfa_fixed_fp_offset;
+
+	return 0;
+}
+
+int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
+		       unsigned long text_start, unsigned long text_end)
+{
+	struct vm_area_struct *sframe_vma, *text_vma;
+	struct mm_struct *mm = current->mm;
+	struct sframe_section *sec;
+	int ret;
+
+	if (!sframe_start || !sframe_end || !text_start || !text_end) {
+		dbg("zero-length sframe/text address\n");
+		return -EINVAL;
+	}
+
+	scoped_guard(mmap_read_lock, mm) {
+		sframe_vma = vma_lookup(mm, sframe_start);
+		if (!sframe_vma || sframe_end > sframe_vma->vm_end) {
+			dbg("bad sframe address (0x%lx - 0x%lx)\n",
+			    sframe_start, sframe_end);
+			return -EINVAL;
+		}
+
+		text_vma = vma_lookup(mm, text_start);
+		if (!text_vma ||
+		    !(text_vma->vm_flags & VM_EXEC) ||
+		    text_end > text_vma->vm_end) {
+			dbg("bad text address (0x%lx - 0x%lx)\n",
+			    text_start, text_end);
+			return -EINVAL;
+		}
+	}
+
+	sec = kzalloc(sizeof(*sec), GFP_KERNEL);
+	if (!sec)
+		return -ENOMEM;
+
+	sec->sframe_start	= sframe_start;
+	sec->sframe_end		= sframe_end;
+	sec->text_start		= text_start;
+	sec->text_end		= text_end;
+
+	ret = sframe_read_header(sec);
+	if (ret)
+		goto err_free;
+
+	/* TODO nowhere to store it yet - just free it and return an error */
+	ret = -ENOSYS;
+
+err_free:
+	free_section(sec);
+	return ret;
+}
+
+int sframe_remove_section(unsigned long sframe_start)
+{
+	return -ENOSYS;
+}
diff --git a/kernel/unwind/sframe.h b/kernel/unwind/sframe.h
new file mode 100644
index 000000000000..07a2e99855f9
--- /dev/null
+++ b/kernel/unwind/sframe.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * From https://www.sourceware.org/binutils/docs/sframe-spec.html
+ */
+#ifndef _SFRAME_H
+#define _SFRAME_H
+
+#include <linux/types.h>
+
+#define SFRAME_VERSION_1			1
+#define SFRAME_VERSION_2			2
+#define SFRAME_VERSION_3			3
+#define SFRAME_MAGIC				0xdee2
+
+#define SFRAME_F_FDE_SORTED			0x1
+#define SFRAME_F_FRAME_POINTER			0x2
+#define SFRAME_F_FDE_FUNC_START_PCREL		0x4
+
+#define SFRAME_ABI_AARCH64_ENDIAN_BIG		1
+#define SFRAME_ABI_AARCH64_ENDIAN_LITTLE	2
+#define SFRAME_ABI_AMD64_ENDIAN_LITTLE		3
+
+struct sframe_preamble {
+	u16	magic;
+	u8	version;
+	u8	flags;
+} __packed;
+
+struct sframe_header {
+	struct sframe_preamble preamble;
+	u8	abi_arch;
+	s8	cfa_fixed_fp_offset;
+	s8	cfa_fixed_ra_offset;
+	u8	auxhdr_len;
+	u32	num_fdes;
+	u32	num_fres;
+	u32	fre_len;
+	u32	fdes_off;
+	u32	fres_off;
+} __packed;
+
+#define SFRAME_HEADER_SIZE(header) \
+	((sizeof(struct sframe_header) + (header).auxhdr_len))
+
+struct sframe_fde_v3 {
+	s64	func_start_off;
+	u32	func_size;
+	u32	fres_off;
+} __packed;
+
+struct sframe_fda_v3 {
+	u16	fres_num;
+	u8	info;
+	u8	info2;
+	u8	rep_size;
+} __packed;
+
+#define SFRAME_FDE_PCTYPE_INC			0
+#define SFRAME_FDE_PCTYPE_MASK			1
+
+#define SFRAME_AARCH64_PAUTH_KEY_A		0
+#define SFRAME_AARCH64_PAUTH_KEY_B		1
+
+#define SFRAME_V3_FDE_FRE_TYPE(info)		((info) & 0xf)
+#define SFRAME_V3_FDE_PCTYPE(info)		(((info) >> 4) & 0x1)
+#define SFRAME_V3_AARCH64_FDE_PAUTH_KEY(info)	(((info) >> 5) & 0x1)
+
+#define SFRAME_FDE_TYPE_REGULAR			0
+
+#define SFRAME_V3_FDE_TYPE_MASK			0x0f
+#define SFRAME_V3_FDE_TYPE(info2)		((info2) & SFRAME_V3_FDE_TYPE_MASK)
+
+#define SFRAME_BASE_REG_FP			0
+#define SFRAME_BASE_REG_SP			1
+
+#define SFRAME_V3_FRE_CFA_BASE_REG_ID(info)		((info) & 0x1)
+#define SFRAME_V3_FRE_DATAWORD_COUNT(info)		(((info) >> 1) & 0xf)
+#define SFRAME_V3_FRE_DATAWORD_SIZE(info)		(((info) >> 5) & 0x3)
+#define SFRAME_V3_AARCH64_FRE_MANGLED_RA_P(info)	(((info) >> 7) & 0x1)
+
+#endif /* _SFRAME_H */
-- 
2.51.0

