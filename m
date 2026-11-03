Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674621;
	b=AO+v9NmQdJx6L0XlB1hIR0EpljUFUzJh1jkIq2IK/w+4KmDYK7ujGGDioEIwbA/SBWXY
	 W37HyCPvL4Qx1DOUxgmgq2F5pMlEYr2Go4ii2HfeJtG0FXMxfXJbXtPuKwEq47vaQFiMZ
	 O/DeyHbci3jiWn+bqkuS2XDycU0uTOVzcLRkjW9Yaz/T2dDrSXYi6SkrEpR7QMtXSrAW8
	 fBzg/35t6amfat6eYbEBT0M0VjHmlvsqz0DxsPhh9o3cjI17FZgRfMhvWDjPAAvJRNm8c
	 as4qQfocVZmQoat8qNnp5QxB5Ii11zAO++wzD9ZRXxWY4PMnpTm+uLDzshsJBlLGb0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674621;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4jYbJGRPUnmyd0m78ShAbCw2vgRacChEEB07WcUFwz8=;
	b=naTLQIno1/cIO/3+Jr3Gdn64EHY6GaiUGHHfCvgHSdUw7WX4J/I+qAh+6JCncZyXFK6C
	 +O5JCs3xSbl/9tHo0VCkeHsm3MrjnKlb0oaz+dkHuq93dV9eDxhCYXZqbA9CT7SC8Rm5V
	 MAzUm/ibL9T8PSo9L5rvk4oY2VoR6v4S6Se5TnwDcXyKP1iH3wYoA8SEvwCmuyoFHtGdq
	 X57VKxj/jRgC9PhaxlBUfRsLgd5pIBuIHH7YdjNMcpe4tAZhLJ5B/+B+Ip6tz9XZxaRh8
	 UG5CoxDknOGJPXL/CQWSKYDHkA07N7h+y5TKmg2s8lEC1pXq4PvlD52Ok8+KT4cyogg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fNZ7bYsM;
	arc=none smtp.remote-ip=95.215.58.201
Received: from mta1.migadu.com (out-201.mta1.migadu.com [95.215.58.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B68606A329
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 02:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5B68606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fNZ7bYsM
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mzUIeXXZbh8ECd3XI3JOV8bjDkJFsAQkq+BqyIRE5Gs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793674618; v=1; x=1794279418;
 b=fNZ7bYsMGhiuk/vXx6UpRecYimOdfMgz3iPLfM8pgcr7mL0by9NB54zBToKVmSjkKLY7LBms
 VNg5E+QRWNNAhksuO1gUOonx++XLa32Lt5e9J/3z8ROv+uL6bu5TssPtUoHLsqPMTXEV5GWSKTu
 FE1FGbXvohJAZezciOw13nHI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e6cf6c57cf4c7740;
	Tue, 03 Nov 2026 02:56:57 +0000
X-Mizu-Trace-ID: e6cf6c57cf4c7740
X-Migadu-Flow: FLOW_OUT
From: Ridong Chen <ridong.chen@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Dave Chinner <david@fromorbit.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <qi.zheng@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_)),
	Ridong Chen <ridong.chen@linux.dev>,
	Ridong Chen <chenridong@xiaomi.com>
Subject: [PATCH v6 2/7] mm/vmscan: move vmscan tracepoints to a local header
Date: Tue,  3 Nov 2026 10:56:05 +0800
Message-Id: <20261103025610.3738894-3-ridong.chen@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103025610.3738894-1-ridong.chen@linux.dev>
References: <20261103025610.3738894-1-ridong.chen@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ridong Chen <chenridong@xiaomi.com>

Move include/trace/events/vmscan.h to mm/trace_vmscan.h so that the
tracepoints can be extended to reference vmscan-internal structures such
as struct scan_control, which is not visible outside mm/.  This mirrors
what several other subsystems already do with their trace headers (e.g.
fs/fuse/fuse_trace.h, fs/gfs2/trace_gfs2.h, fs/lockd/trace.h).  As they
do, set TRACE_INCLUDE_PATH to "." and add mm/ to the include path of
vmscan.o, the only user that defines CREATE_TRACE_POINTS.

No functional change.

Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Baoquan He <baoquan.he@linux.dev>
Acked-by: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
---
 MAINTAINERS                                        | 3 ++-
 mm/Makefile                                        | 1 +
 mm/shrinker.c                                      | 2 +-
 include/trace/events/vmscan.h => mm/trace_vmscan.h | 4 ++++
 mm/vmscan.c                                        | 2 +-
 5 files changed, 9 insertions(+), 3 deletions(-)
 rename include/trace/events/vmscan.h => mm/trace_vmscan.h (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index f4a6b5735794..95ff3743cec8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17708,6 +17708,7 @@ F:	Documentation/admin-guide/mm/multigen_lru.rst
 F:	Documentation/mm/multigen_lru.rst
 F:	include/linux/mm_inline.h
 F:	include/linux/mmzone.h
+F:	mm/trace_vmscan.h
 F:	mm/vmscan.c
 F:	mm/workingset.c
 
@@ -17928,7 +17929,7 @@ R:	Shakeel Butt <shakeel.butt@linux.dev>
 R:	Lorenzo Stoakes <ljs@kernel.org>
 L:	linux-mm@kvack.org
 S:	Maintained
-F:	include/trace/events/vmscan.h
+F:	mm/trace_vmscan.h
 F:	mm/vmscan.c
 F:	mm/workingset.c
 
diff --git a/mm/Makefile b/mm/Makefile
index 2a3ec53d62ee..277b97f7f8d7 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -32,6 +32,7 @@ KCOV_INSTRUMENT_vmstat.o := n
 KCOV_INSTRUMENT_failslab.o := n
 
 CFLAGS_init-mm.o += -Wno-override-init
+CFLAGS_vmscan.o += -I$(src)
 
 mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= highmem.o memory.o mincore.o \
diff --git a/mm/shrinker.c b/mm/shrinker.c
index 4fb424e721bc..4fbdade6d2f6 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -3,7 +3,7 @@
 #include <linux/rwsem.h>
 #include <linux/shrinker.h>
 #include <linux/rculist.h>
-#include <trace/events/vmscan.h>
+#include "trace_vmscan.h"
 
 #include "internal.h"
 
diff --git a/include/trace/events/vmscan.h b/mm/trace_vmscan.h
similarity index 99%
rename from include/trace/events/vmscan.h
rename to mm/trace_vmscan.h
index 8a872990b4be..ad90f0e9bf2e 100644
--- a/include/trace/events/vmscan.h
+++ b/mm/trace_vmscan.h
@@ -648,4 +648,8 @@ TRACE_EVENT(mm_vmscan_kswapd_clear_hopeless,
 #endif /* _TRACE_VMSCAN_H */
 
 /* This part must be outside protection */
+#undef TRACE_INCLUDE_FILE
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace_vmscan
 #include <trace/define_trace.h>
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7ddef3b488b3..b51fae79c6ab 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -71,7 +71,7 @@
 #include "swap.h"
 
 #define CREATE_TRACE_POINTS
-#include <trace/events/vmscan.h>
+#include "trace_vmscan.h"
 
 struct scan_control {
 	/* How many pages shrink_list() should reclaim */
-- 
2.34.1

