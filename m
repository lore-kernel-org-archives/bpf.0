Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555084052B1;
	Sun, 16 Aug 2026 22:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920457; cv=none; b=eNKU09nk5+HPnILW3q08TDOtA2WQrAPT65JtTXcrtIQ5m62OSPlR5mePqkwMVoYJbNlhgEJ5pw6Ku6tdPtwt4TjZGkiMA5xT2phAVm1FyHMpIQCaxcRGU4FWi0HqZhTtGbwbj0cva06FD4UzjbGuUVyl9db+Dqi6PRf/pPNAGPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920457; c=relaxed/simple;
	bh=IO5aq+XYavi19arLYAl9mlbrdb1QIjdbqr57wOBffnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFExQT/b+Uok7/Jo19mIs99Jvq/mDd5wXCAFgzEJWkJm94a58u0PKdgV4xqTo001ZnMyvTx2jNYEPLpqAqNDi69+1Gtv6duS5EkmpQjfKWMmmhnrrx6ERGaw04DNfsm6s7BzFBB24u0JUoDMBmQtjeHsQfuxYj206C27Qb95vgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=aUW9SjDQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SV/PYUiA; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="aUW9SjDQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SV/PYUiA"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 7D975EC0241;
	Sun, 16 Aug 2026 18:47:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 16 Aug 2026 18:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920454; x=
	1787006854; bh=rJV1RXsRkttc2jIpRgeymaLmVF3ajFQ4APp6aG4luFg=; b=a
	UW9SjDQJ9QSf8yY3eh4kelrOvX7FucErcgTcKgg/JVD6GDv+uNvPb3uo07P/+9sq
	egf/BaDfcMIUhLC6tMN8CgRdtfFgOtBllGsvlS/Yx3xHNkgHwKgMvLyl5Hrvjzb/
	GLGHSuMLCjBsiu1UexoFS7Kv/925N0qBs8p9dvLEnfr7k2QYFWUyTqLaX/7ZGoGM
	1uZeVEkYt961YFj8xjfho9ShO5TRQ9mmumxXixs/EZLPnjCrNJmFL5QqznnIv1kC
	42rEU5rIbksjeLj6pu+4J3XwvDrUYTTacWANJg9E6E2Wz32Ii9qRZnoBOReFCJ71
	XCYUziwLokks8nHCsAWoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920454; x=1787006854; bh=r
	JV1RXsRkttc2jIpRgeymaLmVF3ajFQ4APp6aG4luFg=; b=SV/PYUiAhgqOTOdcn
	B11l+Sm41650eHu3CUJHPTB3l8zPecWbhAyzcwWMv6eTVS+INQ2SdniFfmBWJlOB
	frudIzxT/3dzI+811LhH7EU0/PsLLjqwDQUVUjiI+aMW/o5V65WIlDM6xYCyNBY6
	84DdiEZN9rQs4+7US5dWvD76VYLIcjuWTzyQ4HX+U5Bj4UbP3LmW1NaVVEmX5oJF
	UGT+zK4SniVIumNnD8dSVRVD2Ak1QcSerB0d+DOaHypeeGMXzlOaQXMaVtP3NYCe
	pPcAQmTQ6QL9r2Txm1V7+efdLn9XgF5pwHUBbwGks6DF5scm5vBrVkZXYdzstJxB
	m812A==
X-ME-Sender: <xms:Bj6CamXMa95N95u-O5YdSsQJwBQz6hqPfvlTBrHZuhOxH2bhp2fkTg>
    <xme:Bj6CasK8cu2CXA7DRAJzMCf6FpZkS6GH9Pn7bVZGE0C-ntyH7UotKlCwY_O-nOJ-I
    uvr6aWmSRO4DLPQcENkQa6A7QlpzYS2Dz5ijJ6FdcIrt0g4vMioIqx4>
X-ME-Received: <xmr:Bj6Cal2N1Usku-9aauI4EMWds9Sw6H1eMtrlVYZGFynrN2BprG__MZXQU44>
X-ME-Proxy-Cause: dmFkZTEs0CqHyYyBrtEDvFsHJsaqDA+PIZ0J3r+Lfgg7JQy+ArVExyWeVwVWITCUEI32DM
    4Q07u0N7OV0zkPLdTdS1vdC5LFGL2haYN/6+YadFCAGEdEWDkiBi3rhYdwnM7rVYMLfpOZ
    IqudTgnad9TAcDUXw0QsBDvc+EbhJwbEI9dJrG3N8zHX8Hs4ScjPRdKN82RY2wyTeNKhqr
    YTzZzZs4Crypk/DQPLz6+eD8+5uxy24RPSI2P11jXgApnProibFo5ekQZWGTZ43B/F8fQP
    In8cSdmiaADGyUeORNkJ8RH7e9d6bLJ9AYQCJ2FX0Fia17GnwY/TqnulViI5crsw7X2mUA
    Nzwc/WiFcwI7tHKK7OGfdBPGyBDExQpnBrt3FnFaR7BTfgwwDb5QfBMizoi7mG8Bw/O8DT
    U6jSKyk/FWQho1hDU7lvfQNoGZzh+q/vCOLL2rl4DxuxcwdjsLfU8RLC/v49vD1DR6kA5u
    MGrQJ21Jg8P9hKumkyq+NXql9+UJMcN6A4FIBv73MaWE2m40+JFgdn++B+/HRa6FyG5mln
    sYZQzNby6qE4y2B+3RFT4/uXBfmE5JYvZ3HoQ3XT7IJPIv0m8T/G3JrCL0ih9WjP3XcsvY
    mN3JxakrOFQp4y0hkjiOH91KKCirGEtm3mWPzN1H+JaeQEQOdXcISKb3g68g
X-ME-Proxy: <xmx:Bj6CasD_Cx4stCb1iBfPkkPDo47a-YEL0fA4oBXYlLTUr8Gg7exB3w>
    <xmx:Bj6CaheD4-eAgRJW83Md7J4ETyLywm6q9BH8rBxfWxmJEmgiK0BuiA>
    <xmx:Bj6CanzPoUtnTPomxGqedrpi3lUBMkM8-rlvqls4Xejd5_0getJpgQ>
    <xmx:Bj6CahlkmP9wucZaewDI-d6c-66IkPfBc6d1NwSsPszncoYX8vAqGw>
    <xmx:Bj6CaiCPxZtOUtJp5IZ2beIAw4GrfKm8HybfCTTQQvDD-kz7tuPLSxcj>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:47:33 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	nico.pache@linux.dev
Cc: baolin.wang@linux.alibaba.com,
	baohua@kernel.org,
	dev.jain@arm.com,
	hughd@google.com,
	lance.yang@linux.dev,
	liam@infradead.org,
	mhocko@suse.com,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shuah@kernel.org,
	surenb@google.com,
	usama.arif@linux.dev,
	vbabka@kernel.org,
	ziy@nvidia.com,
	usama.anjum@arm.com,
	agordeev@linux.ibm.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kas@kernel.org,
	jannh@google.com,
	willy@infradead.org,
	pfalcato@suse.de,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [RFC PATCH 41/57] mm/collapse: give collapse its own trace header
Date: Sun, 16 Aug 2026 23:45:53 +0100
Message-ID: <20260816224609.308019-42-kirill@shutemov.name>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816224609.308019-1-kirill@shutemov.name>
References: <20260816224609.308019-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

Every event in include/trace/events/huge_memory.h is a collapse event, and
all but one is emitted from mm/collapse.c.  The header is named for
huge_memory.c, which emits none of them, and the tracepoints are built by
khugepaged.c, which emits one.

Rename it to trace/events/collapse.h, with TRACE_SYSTEM to match, and
build the tracepoints in collapse.c.

Two things follow.  The pass names a candidate event prints are needed
only where the tracepoints are built, so enum collapse_pass moves out of
mm/collapse.h into collapse.c.  And khugepaged.c becomes an ordinary
includer, for the one event it does emit.

The tracefs directory moves with the trace system: events/huge_memory
becomes events/collapse, so anything enabling those events by system name
has to follow.

khugepaged's own selftest does that, and is updated here.  So are the two
other in-tree references to the old name: the MAINTAINERS entry for the
header, and the group raw_tp_null_args[] keeps its collapse entries under.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 MAINTAINERS                                     |  2 +-
 .../trace/events/{huge_memory.h => collapse.h}  |  8 ++++----
 kernel/bpf/btf.c                                |  6 +++---
 mm/collapse.c                                   | 17 ++++++++++++++++-
 mm/collapse.h                                   | 13 -------------
 mm/khugepaged.c                                 |  3 +--
 .../selftests/mm/khugepaged_sync_check.c        | 10 +++++-----
 tools/testing/selftests/mm/vm_util.c            |  2 +-
 8 files changed, 31 insertions(+), 30 deletions(-)
 rename include/trace/events/{huge_memory.h => collapse.h} (98%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f513b42bc18..7c179b333e4e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17273,7 +17273,7 @@ F:	Documentation/ABI/testing/sysfs-kernel-mm-transparent-hugepage
 F:	Documentation/admin-guide/mm/transhuge.rst
 F:	include/linux/huge_mm.h
 F:	include/linux/khugepaged.h
-F:	include/trace/events/huge_memory.h
+F:	include/trace/events/collapse.h
 F:	mm/huge_memory.c
 F:	mm/khugepaged.c
 F:	mm/mm_slot.h
diff --git a/include/trace/events/huge_memory.h b/include/trace/events/collapse.h
similarity index 98%
rename from include/trace/events/huge_memory.h
rename to include/trace/events/collapse.h
index 6aabf4235648..a3af5d8cc9aa 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/collapse.h
@@ -1,9 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #undef TRACE_SYSTEM
-#define TRACE_SYSTEM huge_memory
+#define TRACE_SYSTEM collapse
 
-#if !defined(__HUGE_MEMORY_H) || defined(TRACE_HEADER_MULTI_READ)
-#define __HUGE_MEMORY_H
+#if !defined(_TRACE_COLLAPSE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_COLLAPSE_H
 
 #include  <linux/tracepoint.h>
 
@@ -282,5 +282,5 @@ TRACE_EVENT(mm_khugepaged_scan,
 		__entry->full_scan_finished)
 );
 
-#endif /* __HUGE_MEMORY_H */
+#endif /* _TRACE_COLLAPSE_H */
 #include <trace/define_trace.h>
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 22fc8f974be2..505bdbb534e4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6683,6 +6683,9 @@ static const struct bpf_raw_tp_null_args raw_tp_null_args[] = {
 	{ "cachefiles_ondemand_cread", 0x1 },
 	{ "cachefiles_ondemand_fd_write", 0x1 },
 	{ "cachefiles_ondemand_fd_release", 0x1 },
+	/* collapse */
+	{ "mm_collapse_scan_file", 0x10 },
+	{ "mm_collapse_file", 0x10 },
 	/* ext4, from ext4__mballoc event class */
 	{ "ext4_mballoc_discard", 0x10 },
 	{ "ext4_mballoc_free", 0x10 },
@@ -6702,9 +6705,6 @@ static const struct bpf_raw_tp_null_args raw_tp_null_args[] = {
 	{ "time_out_leases", 0x10 },
 	/* host1x */
 	{ "host1x_cdma_push_gather", 0x10000 },
-	/* huge_memory */
-	{ "mm_collapse_scan_file", 0x10 },
-	{ "mm_collapse_file", 0x10 },
 	/* kmem */
 	{ "mm_page_alloc", 0x1 },
 	{ "mm_page_pcpu_drain", 0x1 },
diff --git a/mm/collapse.c b/mm/collapse.c
index 6c17c83a4e21..952e3f62d920 100644
--- a/mm/collapse.c
+++ b/mm/collapse.c
@@ -26,10 +26,25 @@
 #include <linux/vmstat.h>
 
 #include <asm/tlb.h>
-#include <trace/events/huge_memory.h>
 #include "collapse.h"
 #include "internal.h"
 
+/*
+ * Which pass of a round reached a verdict on a candidate.  Named by the trace
+ * header, which only this file builds, so it need not be shared.
+ */
+enum collapse_pass {
+	COLLAPSE_PASS_ALLOC,
+	COLLAPSE_PASS_REVALIDATE,
+	COLLAPSE_PASS_FAULTIN,
+	COLLAPSE_PASS_FREEZE,
+	COLLAPSE_PASS_COPY,
+	COLLAPSE_PASS_INSTALL,
+};
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/collapse.h>
+
 /*
  * Anonymous collapse, in rounds.
  *
diff --git a/mm/collapse.h b/mm/collapse.h
index 4af7bb9c4261..9e2cec1f250b 100644
--- a/mm/collapse.h
+++ b/mm/collapse.h
@@ -16,19 +16,6 @@
 struct collapse_candidate;
 struct collapse_retry;
 
-/*
- * Which pass of a round reached a verdict on a candidate.  Only collapse.c
- * produces these; the trace header khugepaged.c builds names them.
- */
-enum collapse_pass {
-	COLLAPSE_PASS_ALLOC,
-	COLLAPSE_PASS_REVALIDATE,
-	COLLAPSE_PASS_FAULTIN,
-	COLLAPSE_PASS_FREEZE,
-	COLLAPSE_PASS_COPY,
-	COLLAPSE_PASS_INSTALL,
-};
-
 enum scan_result {
 	SCAN_FAIL,
 	SCAN_SUCCEED,
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 967cc472b6dc..f3a7aad5e8f2 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -31,8 +31,7 @@
 #include "page_alloc.h"
 #include "mm_slot.h"
 
-#define CREATE_TRACE_POINTS
-#include <trace/events/huge_memory.h>
+#include <trace/events/collapse.h>
 
 static struct task_struct *khugepaged_thread __read_mostly;
 static DEFINE_MUTEX(khugepaged_mutex);
diff --git a/tools/testing/selftests/mm/khugepaged_sync_check.c b/tools/testing/selftests/mm/khugepaged_sync_check.c
index 45001996b57a..4c37b697d3dd 100644
--- a/tools/testing/selftests/mm/khugepaged_sync_check.c
+++ b/tools/testing/selftests/mm/khugepaged_sync_check.c
@@ -41,7 +41,7 @@ static unsigned long hpage_pmd_size;
 /*
  * Each step switches the events off again, but a helper can still give up
  * on us in between (a failing sysfs write ends the test from inside
- * thp_write_num()), and huge_memory events left on are the whole machine's
+ * thp_write_num()), and collapse events left on are the whole machine's
  * problem, not this test's.
  */
 static void trace_events_off(void)
@@ -118,7 +118,7 @@ static void one_step(int iteration)
 	if (tracing_clear_trace())
 		ksft_exit_fail_msg("Cannot clear the trace buffer\n");
 	if (tracing_events_enable(trace_events_fd, true))
-		ksft_exit_fail_msg("Cannot enable huge_memory events\n");
+		ksft_exit_fail_msg("Cannot enable collapse events\n");
 
 	if (madvise(p, hpage_pmd_size, MADV_HUGEPAGE))
 		ksft_exit_fail_perror("madvise(MADV_HUGEPAGE)");
@@ -127,7 +127,7 @@ static void one_step(int iteration)
 
 	/* Off before anything that can give up: the events are system-wide. */
 	if (tracing_events_enable(trace_events_fd, false))
-		ksft_exit_fail_msg("Cannot disable huge_memory events\n");
+		ksft_exit_fail_msg("Cannot disable collapse events\n");
 	if (!passed)
 		ksft_exit_fail_msg("khugepaged did not complete a full pass\n");
 
@@ -164,9 +164,9 @@ int main(void)
 	kpageflags_fd = open("/proc/kpageflags", O_RDONLY);
 	if (kpageflags_fd < 0)
 		ksft_exit_skip("open(\"/proc/kpageflags\") requires root\n");
-	trace_events_fd = tracing_events_open("huge_memory");
+	trace_events_fd = tracing_events_open("collapse");
 	if (trace_events_fd < 0)
-		ksft_exit_skip("huge_memory events require tracefs and root\n");
+		ksft_exit_skip("collapse events require tracefs and root\n");
 	atexit(trace_events_off);
 
 	ksft_set_plan(NR_ITERATIONS);
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index ee1334778391..32cba59ae49c 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -601,7 +601,7 @@ bool is_range_backed_by_folio_orders(char *start, size_t len, int order,
 #define TRACEFS_ROOT "/sys/kernel/tracing"
 
 /*
- * Open the enable file of one ftrace event subsystem (e.g. "huge_memory").
+ * Open the enable file of one ftrace event subsystem (e.g. "collapse").
  * Returns a descriptor for tracing_events_enable(), or -1 if tracefs or the
  * subsystem is not there.  The events are system-wide state: whoever
  * switches them on owns them until it switches them off, including on the
-- 
2.54.0

