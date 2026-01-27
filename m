Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5792F366DAD;
	Tue, 27 Jan 2026 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526428; cv=none; b=gXGGykHMVX9Cc0M5jd7recSykNPvO0v4jekGhbjipMpVZGF8uE7HmgKl8KG1iDceDwvUQMF/tbvyRRooVnpMhnBtDLciduY2vNz5IHtD3WAnO0P1rgJ6O0Jw+LOImFITdprbbfGs3KzEsiEe0R+OPZtyrr7r8dN7LVjAhU0iqGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526428; c=relaxed/simple;
	bh=/jaT8DYcz6/t5qEtz84JolEYNmHSd+p3IQAPKf8c6gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drxmUtZMNWODQCzRLaqiVXlPRijwWoFEZcGbpNegnxD0pYXcJJpI6IGcqpE3HRUqwdVJQboem9wd3AL2xC8oFeRnLgK4oxjYFPAr3NXg8GBtzM0NW9H49y780/WD8HhpK1rpo+Arvzvq7RXmZGLO3Ln6iAFRHlkMzlpzvlQfE2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GsStQhwG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GsStQhwG"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R7589N000453;
	Tue, 27 Jan 2026 15:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DbpoU7V6wjGl7C19u
	Q9e9DVJpWOU0+bGfyvDPjd+U9U=; b=GsStQhwGs70N2hzjvI9EcXMrhXrTg4xFz
	qZnDzNVtWyeDCFi7hQyAkGpuCapI0g7Z0zeuhFVinXJpkC6EZLqB18Qih5JUUXsx
	PqC0zKswa+Aq8rNBkdH4rGqmC3wJgKzsyO4coLyicESpxocRM5reJYMut19aXDjc
	ceaI9Lt60Ga1cAdwC5ij44YT/pkzerOqRMtD4cRXoqMqpCLIG2kxVLdC3wX5Ew/9
	pZRUYVI0kaXf+W/MQw6V5R5Dymdh2D8IwaJgENqskOLXvMIGlWJsxqXUP5yNVo9P
	H2ggT/yVLS08Wvzuo2iiIFgsLbxZi4mjPD3ABBenDAG8i0Rt02pYw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmmhhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:06:04 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60REv2n7016679;
	Tue, 27 Jan 2026 15:06:03 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmmhhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:06:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RF43I4018045;
	Tue, 27 Jan 2026 15:06:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwb41ru3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:06:02 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RF5whg34013604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:05:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EB1F20040;
	Tue, 27 Jan 2026 15:05:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2508820049;
	Tue, 27 Jan 2026 15:05:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 15:05:58 +0000 (GMT)
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
Subject: [PATCH v13 04/18] unwind_user/sframe: Add support for reading .sframe contents
Date: Tue, 27 Jan 2026 16:05:39 +0100
Message-ID: <20260127150554.2760964-5-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Gr1PO01C c=1 sm=1 tr=0 ts=6978d45c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=7d_E57ReAAAA:8 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=mDV3o1hIAAAA:8
 a=yMhMjlubAAAA:8 a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8 a=7mOBRU54AAAA:8
 a=meVymXHHAAAA:8 a=YuDcBBqGAAAA:8 a=W06K4fExuwiiLY1qHd8A:9
 a=jhqOcbufqs7Y1TYCrUUU:22 a=1CNFftbPRP8L7MoqJWF3:22 a=HkZW87K1Qel5hWWM3VKY:22
 a=wa9RWnbW_A1YIeRBVszw:22 a=2JgSa4NbpEOStq-L5dxp:22 a=V9_jqlfyBUA7Gw2gN5zN:22
X-Proofpoint-GUID: bxllR8V2cfKsLY4uc8NmlESMOL4FGHqT
X-Proofpoint-ORIG-GUID: gvUXawCUsZyo0XByjQUvWCrzApMOkwsV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyMSBTYWx0ZWRfX6r4Qq0mN6reT
 hCqK4ruC0Kcg4mwPHv94OdEXmw7sdbKDtv3DlS/Xcrxwgh+nhuHWO+RZwflYa7et9LxYDh6aqzc
 Onba562M5N24b57by3HX+gqnc18WV8vGfMHv6AMPLpT8TC6Mwc3ensAgLgmMHDni5FmFlTXTUmy
 LXsuZA/6CEU4wG96J20bAdDNbufh+xCb8jcOEvGTIMmtesHm0J7Zk7fHjiaUkMwPAJAssK5lTGR
 Zhfe01EuQOYdwW8UVrCHNgu1v9QQZwcC+MlkwhL7x6zT6Dq0CMmAgkDGrLXnuIe7AUsOrxULuzk
 hfZFLnRaPixf1x8n2L4ExA5sEDbkWIrl1rnqsYmfgj/VjBX2dNXZYN+FUvo8GCBFmWHa4vChrSI
 8149JQeria7C3c4BJh0VA/WwTuAuyqHRlqZSLxdv/u+81Uy3xsO4qTfPv36TAI6SGa6T4Tgc/qa
 01oLkX4XUtm/AtNiBsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270121

From: Josh Poimboeuf <jpoimboe@kernel.org>

In preparation for using sframe to unwind user space stacks, add an
sframe_find() interface for finding the sframe information associated
with a given text address.

For performance, use user_read_access_begin() and the corresponding
unsafe_*() accessors.  Note that use of pr_debug() in uaccess-enabled
regions would break noinstr validation, so there aren't any debug
messages yet.  That will be added in a subsequent commit.

Link: https://lore.kernel.org/all/77c0d1ec143bf2a53d66c4ecb190e7e0a576fbfd.1737511963.git.jpoimboe@kernel.org/
Link: https://lore.kernel.org/all/b35ca3a3-8de5-4d32-8d30-d4e562f6b0de@linux.ibm.com/

[ Jens Remus: Add initial support for SFrame V3 (limited to regular
FDEs).  Add support for PC-relative FDE function start offset.  Simplify
logic by using an internal FDE representation.  Rename struct sframe_fre
to sframe_fre_internal to align with struct sframe_fde_internal.
Cleanup includes.  Fix checkpatch errors "spaces required around that
':'". ]

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
      - Adjust to SFRAME_V3_*() macros and macro/define renames.
      - Adjust to struct sframe_fde_v3 rename.
      - Adjust to s64 FDE function start offset.
      - Rename local variables fde_type to fde_pctype.
      - Add and maintain struct sframe_fde_internal field u8 info2.
      - Adjust to FDE split into function descriptor entry
        (struct sframe_fde_v3) and attributes (struct sframe_fde_v3).
      - Rename offset_count/offset_size to dataword_count/dataword_count.
      - Limit __read_fre() to SFrame V3 regular FDEs (FDE_TYPE_REGULAR).  A
        subsequent patch will add support for flexible FDEs (FDE_TYPE_FLEX).
    - Rename struct sframe_fde_internal field func_start_addr to func_addr.
    - Add support u64/s64 in UNSAFE_GET_USER_INC() for s64 FDE function
      start offset.
    - Reduce indentation of assignments to fre.
    - Reword commit message (my changes).

 include/linux/sframe.h       |   6 +
 kernel/unwind/sframe.c       | 346 ++++++++++++++++++++++++++++++++++-
 kernel/unwind/sframe_debug.h |  35 ++++
 3 files changed, 383 insertions(+), 4 deletions(-)
 create mode 100644 kernel/unwind/sframe_debug.h

diff --git a/include/linux/sframe.h b/include/linux/sframe.h
index 7ea6a97ed8af..9a72209696f9 100644
--- a/include/linux/sframe.h
+++ b/include/linux/sframe.h
@@ -3,10 +3,14 @@
 #define _LINUX_SFRAME_H
 
 #include <linux/mm_types.h>
+#include <linux/srcu.h>
+#include <linux/unwind_user_types.h>
 
 #ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
 
 struct sframe_section {
+	struct rcu_head	rcu;
+
 	unsigned long	sframe_start;
 	unsigned long	sframe_end;
 	unsigned long	text_start;
@@ -27,6 +31,7 @@ extern void sframe_free_mm(struct mm_struct *mm);
 extern int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
 			      unsigned long text_start, unsigned long text_end);
 extern int sframe_remove_section(unsigned long sframe_addr);
+extern int sframe_find(unsigned long ip, struct unwind_user_frame *frame);
 
 static inline bool current_has_sframe(void)
 {
@@ -45,6 +50,7 @@ static inline int sframe_add_section(unsigned long sframe_start, unsigned long s
 	return -ENOSYS;
 }
 static inline int sframe_remove_section(unsigned long sframe_addr) { return -ENOSYS; }
+static inline int sframe_find(unsigned long ip, struct unwind_user_frame *frame) { return -ENOSYS; }
 static inline bool current_has_sframe(void) { return false; }
 
 #endif /* CONFIG_HAVE_UNWIND_USER_SFRAME */
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index fdb2a4908563..9b3779924395 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -15,9 +15,338 @@
 #include <linux/unwind_user_types.h>
 
 #include "sframe.h"
+#include "sframe_debug.h"
+
+struct sframe_fde_internal {
+	unsigned long	func_addr;
+	u32		func_size;
+	u32		fda_off;
+	u32		fres_off;
+	u32		fres_num;
+	u8		info;
+	u8		info2;
+	u8		rep_size;
+};
+
+struct sframe_fre_internal {
+	unsigned int	size;
+	u32		ip_off;
+	s32		cfa_off;
+	s32		ra_off;
+	s32		fp_off;
+	u8		info;
+};
+
+DEFINE_STATIC_SRCU(sframe_srcu);
+
+static __always_inline unsigned char fre_type_to_size(unsigned char fre_type)
+{
+	if (fre_type > 2)
+		return 0;
+	return 1 << fre_type;
+}
+
+static __always_inline unsigned char dataword_size_enum_to_size(unsigned char dataword_size)
+{
+	if (dataword_size > 2)
+		return 0;
+	return 1 << dataword_size;
+}
+
+static __always_inline int __read_fde(struct sframe_section *sec,
+				      unsigned int fde_num,
+				      struct sframe_fde_internal *fde)
+{
+	unsigned long fde_addr, fda_addr, func_addr;
+	struct sframe_fde_v3 _fde;
+	struct sframe_fda_v3 _fda;
+
+	fde_addr = sec->fdes_start + (fde_num * sizeof(struct sframe_fde_v3));
+	unsafe_copy_from_user(&_fde, (void __user *)fde_addr,
+			      sizeof(struct sframe_fde_v3), Efault);
+
+	func_addr = fde_addr + _fde.func_start_off;
+	if (func_addr < sec->text_start || func_addr > sec->text_end)
+		return -EINVAL;
+
+	fda_addr = sec->fres_start + _fde.fres_off;
+	if (fda_addr + sizeof(struct sframe_fda_v3) > sec->fres_end)
+		return -EINVAL;
+	unsafe_copy_from_user(&_fda, (void __user *)fda_addr,
+			      sizeof(struct sframe_fda_v3), Efault);
+
+	fde->func_addr	= func_addr;
+	fde->func_size	= _fde.func_size;
+	fde->fda_off	= _fde.fres_off;
+	fde->fres_off	= _fde.fres_off + sizeof(struct sframe_fda_v3);
+	fde->fres_num	= _fda.fres_num;
+	fde->info	= _fda.info;
+	fde->info2	= _fda.info2;
+	fde->rep_size	= _fda.rep_size;
+
+	return 0;
+
+Efault:
+	return -EFAULT;
+}
+
+static __always_inline int __find_fde(struct sframe_section *sec,
+				      unsigned long ip,
+				      struct sframe_fde_internal *fde)
+{
+	unsigned long func_addr_low = 0, func_addr_high = ULONG_MAX;
+	struct sframe_fde_v3 __user *first, *low, *high, *found = NULL;
+	int ret;
+
+	first = (void __user *)sec->fdes_start;
+	low = first;
+	high = first + sec->num_fdes - 1;
+
+	while (low <= high) {
+		struct sframe_fde_v3 __user *mid;
+		s64 func_off;
+		unsigned long func_addr;
+
+		mid = low + ((high - low) / 2);
+
+		unsafe_get_user(func_off, (s64 __user *)mid, Efault);
+		func_addr = (unsigned long)mid + func_off;
+
+		if (ip >= func_addr) {
+			if (func_addr < func_addr_low)
+				return -EFAULT;
+
+			func_addr_low = func_addr;
+
+			found = mid;
+			low = mid + 1;
+		} else {
+			if (func_addr > func_addr_high)
+				return -EFAULT;
+
+			func_addr_high = func_addr;
+
+			high = mid - 1;
+		}
+	}
+
+	if (!found)
+		return -EINVAL;
+
+	ret = __read_fde(sec, found - first, fde);
+	if (ret)
+		return ret;
+
+	/* make sure it's not in a gap */
+	if (ip < fde->func_addr || ip >= fde->func_addr + fde->func_size)
+		return -EINVAL;
+
+	return 0;
+
+Efault:
+	return -EFAULT;
+}
+
+#define ____UNSAFE_GET_USER_INC(to, from, type, label)			\
+({									\
+	type __to;							\
+	unsafe_get_user(__to, (type __user *)from, label);		\
+	from += sizeof(__to);						\
+	to = __to;							\
+})
+
+#define __UNSAFE_GET_USER_INC(to, from, size, label, u_or_s)		\
+({									\
+	switch (size) {							\
+	case 1:								\
+		____UNSAFE_GET_USER_INC(to, from, u_or_s##8, label);	\
+		break;							\
+	case 2:								\
+		____UNSAFE_GET_USER_INC(to, from, u_or_s##16, label);	\
+		break;							\
+	case 4:								\
+		____UNSAFE_GET_USER_INC(to, from, u_or_s##32, label);	\
+		break;							\
+	default:							\
+		return -EFAULT;						\
+	}								\
+})
+
+#define UNSAFE_GET_USER_UNSIGNED_INC(to, from, size, label)		\
+	__UNSAFE_GET_USER_INC(to, from, size, label, u)
+
+#define UNSAFE_GET_USER_SIGNED_INC(to, from, size, label)		\
+	__UNSAFE_GET_USER_INC(to, from, size, label, s)
+
+#define UNSAFE_GET_USER_INC(to, from, size, label)				\
+	_Generic(to,								\
+		 u8 :	UNSAFE_GET_USER_UNSIGNED_INC(to, from, size, label),	\
+		 u16 :	UNSAFE_GET_USER_UNSIGNED_INC(to, from, size, label),	\
+		 u32 :	UNSAFE_GET_USER_UNSIGNED_INC(to, from, size, label),	\
+		 u64 :	UNSAFE_GET_USER_UNSIGNED_INC(to, from, size, label),	\
+		 s8 :	UNSAFE_GET_USER_SIGNED_INC(to, from, size, label),	\
+		 s16 :	UNSAFE_GET_USER_SIGNED_INC(to, from, size, label),	\
+		 s32 :	UNSAFE_GET_USER_SIGNED_INC(to, from, size, label),	\
+		 s64 :	UNSAFE_GET_USER_SIGNED_INC(to, from, size, label))
+
+static __always_inline int __read_fre(struct sframe_section *sec,
+				      struct sframe_fde_internal *fde,
+				      unsigned long fre_addr,
+				      struct sframe_fre_internal *fre)
+{
+	unsigned char fde_type = SFRAME_V3_FDE_TYPE(fde->info2);
+	unsigned char fde_pctype = SFRAME_V3_FDE_PCTYPE(fde->info);
+	unsigned char fre_type = SFRAME_V3_FDE_FRE_TYPE(fde->info);
+	unsigned char dataword_count, dataword_size;
+	s32 cfa_off, ra_off, fp_off;
+	unsigned long cur = fre_addr;
+	unsigned char addr_size;
+	u32 ip_off;
+	u8 info;
+
+	addr_size = fre_type_to_size(fre_type);
+	if (!addr_size)
+		return -EFAULT;
+
+	if (fre_addr + addr_size + 1 > sec->fres_end)
+		return -EFAULT;
+
+	UNSAFE_GET_USER_INC(ip_off, cur, addr_size, Efault);
+	if (fde_pctype == SFRAME_FDE_PCTYPE_INC && ip_off > fde->func_size)
+		return -EFAULT;
+
+	UNSAFE_GET_USER_INC(info, cur, 1, Efault);
+	dataword_count = SFRAME_V3_FRE_DATAWORD_COUNT(info);
+	dataword_size  = dataword_size_enum_to_size(SFRAME_V3_FRE_DATAWORD_SIZE(info));
+	if (!dataword_count || !dataword_size)
+		return -EFAULT;
+
+	if (cur + (dataword_count * dataword_size) > sec->fres_end)
+		return -EFAULT;
+
+	/* TODO: Support for flexible FDEs not implemented yet. */
+	if (fde_type != SFRAME_FDE_TYPE_REGULAR)
+		return -EFAULT;
+
+	UNSAFE_GET_USER_INC(cfa_off, cur, dataword_size, Efault);
+	dataword_count--;
+
+	ra_off = sec->ra_off;
+	if (!ra_off) {
+		if (!dataword_count--)
+			return -EFAULT;
+
+		UNSAFE_GET_USER_INC(ra_off, cur, dataword_size, Efault);
+	}
+
+	fp_off = sec->fp_off;
+	if (!fp_off && dataword_count) {
+		dataword_count--;
+		UNSAFE_GET_USER_INC(fp_off, cur, dataword_size, Efault);
+	}
+
+	if (dataword_count)
+		return -EFAULT;
+
+	fre->size	= addr_size + 1 + (dataword_count * dataword_size);
+	fre->ip_off	= ip_off;
+	fre->cfa_off	= cfa_off;
+	fre->ra_off	= ra_off;
+	fre->fp_off	= fp_off;
+	fre->info	= info;
+
+	return 0;
+
+Efault:
+	return -EFAULT;
+}
+
+static __always_inline int __find_fre(struct sframe_section *sec,
+				      struct sframe_fde_internal *fde,
+				      unsigned long ip,
+				      struct unwind_user_frame *frame)
+{
+	unsigned char fde_pctype = SFRAME_V3_FDE_PCTYPE(fde->info);
+	struct sframe_fre_internal *fre, *prev_fre = NULL;
+	struct sframe_fre_internal fres[2];
+	unsigned long fre_addr;
+	bool which = false;
+	unsigned int i;
+	u32 ip_off;
+
+	ip_off = ip - fde->func_addr;
+
+	if (fde_pctype == SFRAME_FDE_PCTYPE_MASK)
+		ip_off %= fde->rep_size;
+
+	fre_addr = sec->fres_start + fde->fres_off;
+
+	for (i = 0; i < fde->fres_num; i++) {
+		int ret;
+
+		/*
+		 * Alternate between the two fre_addr[] entries for 'fre' and
+		 * 'prev_fre'.
+		 */
+		fre = which ? fres : fres + 1;
+		which = !which;
+
+		ret = __read_fre(sec, fde, fre_addr, fre);
+		if (ret)
+			return ret;
+
+		fre_addr += fre->size;
+
+		if (prev_fre && fre->ip_off <= prev_fre->ip_off)
+			return -EFAULT;
+
+		if (fre->ip_off > ip_off)
+			break;
+
+		prev_fre = fre;
+	}
+
+	if (!prev_fre)
+		return -EINVAL;
+	fre = prev_fre;
+
+	frame->cfa_off = fre->cfa_off;
+	frame->ra_off  = fre->ra_off;
+	frame->fp_off  = fre->fp_off;
+	frame->use_fp  = SFRAME_V3_FRE_CFA_BASE_REG_ID(fre->info) == SFRAME_BASE_REG_FP;
+
+	return 0;
+}
+
+int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
+{
+	struct mm_struct *mm = current->mm;
+	struct sframe_section *sec;
+	struct sframe_fde_internal fde;
+	int ret;
+
+	if (!mm)
+		return -EINVAL;
+
+	guard(srcu)(&sframe_srcu);
+
+	sec = mtree_load(&mm->sframe_mt, ip);
+	if (!sec)
+		return -EINVAL;
+
+	if (!user_read_access_begin((void __user *)sec->sframe_start,
+				    sec->sframe_end - sec->sframe_start))
+		return -EFAULT;
 
-#define dbg(fmt, ...)							\
-	pr_debug("%s (%d): " fmt, current->comm, current->pid, ##__VA_ARGS__)
+	ret = __find_fde(sec, ip, &fde);
+	if (ret)
+		goto end;
+
+	ret = __find_fre(sec, &fde, ip, frame);
+end:
+	user_read_access_end();
+	return ret;
+}
 
 static void free_section(struct sframe_section *sec)
 {
@@ -120,8 +449,10 @@ int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
 	sec->text_end		= text_end;
 
 	ret = sframe_read_header(sec);
-	if (ret)
+	if (ret) {
+		dbg_print_header(sec);
 		goto err_free;
+	}
 
 	ret = mtree_insert_range(sframe_mt, sec->text_start, sec->text_end, sec, GFP_KERNEL);
 	if (ret) {
@@ -137,6 +468,13 @@ int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
 	return ret;
 }
 
+static void sframe_free_srcu(struct rcu_head *rcu)
+{
+	struct sframe_section *sec = container_of(rcu, struct sframe_section, rcu);
+
+	free_section(sec);
+}
+
 static int __sframe_remove_section(struct mm_struct *mm,
 				   struct sframe_section *sec)
 {
@@ -145,7 +483,7 @@ static int __sframe_remove_section(struct mm_struct *mm,
 		return -EINVAL;
 	}
 
-	free_section(sec);
+	call_srcu(&sframe_srcu, &sec->rcu, sframe_free_srcu);
 
 	return 0;
 }
diff --git a/kernel/unwind/sframe_debug.h b/kernel/unwind/sframe_debug.h
new file mode 100644
index 000000000000..36352124cde8
--- /dev/null
+++ b/kernel/unwind/sframe_debug.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SFRAME_DEBUG_H
+#define _SFRAME_DEBUG_H
+
+#include <linux/sframe.h>
+#include "sframe.h"
+
+#ifdef CONFIG_DYNAMIC_DEBUG
+
+#define dbg(fmt, ...)							\
+	pr_debug("%s (%d): " fmt, current->comm, current->pid, ##__VA_ARGS__)
+
+static __always_inline void dbg_print_header(struct sframe_section *sec)
+{
+	unsigned long fdes_end;
+
+	fdes_end = sec->fdes_start + (sec->num_fdes * sizeof(struct sframe_fde_v3));
+
+	dbg("SEC: sframe:0x%lx-0x%lx text:0x%lx-0x%lx "
+	    "fdes:0x%lx-0x%lx fres:0x%lx-0x%lx "
+	    "ra_off:%d fp_off:%d\n",
+	    sec->sframe_start, sec->sframe_end, sec->text_start, sec->text_end,
+	    sec->fdes_start, fdes_end, sec->fres_start, sec->fres_end,
+	    sec->ra_off, sec->fp_off);
+}
+
+#else /* !CONFIG_DYNAMIC_DEBUG */
+
+#define dbg(args...)			no_printk(args)
+
+static inline void dbg_print_header(struct sframe_section *sec) {}
+
+#endif /* !CONFIG_DYNAMIC_DEBUG */
+
+#endif /* _SFRAME_DEBUG_H */
-- 
2.51.0

