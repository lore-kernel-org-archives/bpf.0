Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC992FFDFA
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 02:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769481916; cv=none; b=L2ddX1q8WAuIy0k8hYt6rSmjogU4byKdf51eOGy/nAiC5UK/Dcx+xYmWlQt1MTobd9JrkqgchW6fJ3z5X6098uN5ouBehOByPUlW1hBfzPp1lN3quRrtOc14OfqVnKlDxPQD35hHQ907ynEAv4aSCuWbe7+M68tjbx+qKAQNrcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769481916; c=relaxed/simple;
	bh=y+6fHome163PVdqshh0yMJG0Od8tfpk7TfqEd7GB9pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvO0okBw7qJRXACneLyRmTiDBm2g7W5aejDa+SKqXqFOIqVKRt85vzlEPH1GbDTkY4JWJa4XRgEQu8NpywSPQZCawxrJnHruzaPSTTwh8mmCt5deOmP4iSQORoiTNwlTqxAQiNS5Aw4lYM3CZGS2pX02xofNX72BxFCxcPvGPew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TLpEx4wa; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TLpEx4wa"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769481913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3nsZCHloDjEFT63wrJPNHkkbtPu1NO+p+ag9oOS/4s=;
	b=TLpEx4waOFjLCEtMyKYbSF7YnojCZxnLYrXP50WDo8bqSLwGFx/HZiKKsCkbSGJDWbHBeu
	x9hp2U81qFGa0LwaEVL+Y6HlGMaqxJCmDlfoIAvobc8Box8efuEi1XBeRL8orFcrYoTtr5
	qO+DZmBfWe2+lrYYtWn3/FpwVcs1lgQ=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: bpf@vger.kernel.org
Cc: Michal Hocko <mhocko@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH bpf-next v3 13/17] sched: psi: add a trace point to psi_avgs_work()
Date: Mon, 26 Jan 2026 18:44:16 -0800
Message-ID: <20260127024421.494929-14-roman.gushchin@linux.dev>
In-Reply-To: <20260127024421.494929-1-roman.gushchin@linux.dev>
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a trace point to psi_avgs_work().

It can be used to attach a bpf handler which can monitor
PSI values system-wide or for specific cgroup(s) and
potentially perform some actions, e.g. declare an OOM.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/trace/events/psi.h | 27 +++++++++++++++++++++++++++
 kernel/sched/psi.c         |  6 ++++++
 2 files changed, 33 insertions(+)
 create mode 100644 include/trace/events/psi.h

diff --git a/include/trace/events/psi.h b/include/trace/events/psi.h
new file mode 100644
index 000000000000..57c46de18616
--- /dev/null
+++ b/include/trace/events/psi.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM psi
+
+#if !defined(_TRACE_PSI_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_PSI_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(psi_avgs_work,
+	TP_PROTO(struct psi_group *group),
+	TP_ARGS(group),
+	TP_STRUCT__entry(
+		__field(struct psi_group *, group)
+	),
+
+	TP_fast_assign(
+		__entry->group = group;
+	),
+
+	TP_printk("group=%p", __entry->group)
+);
+
+#endif /* _TRACE_PSI_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 59fdb7ebbf22..72757ba2ed96 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -141,6 +141,10 @@
 #include <linux/psi.h>
 #include "sched.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/psi.h>
+#undef CREATE_TRACE_POINTS
+
 static int psi_bug __read_mostly;
 
 DEFINE_STATIC_KEY_FALSE(psi_disabled);
@@ -607,6 +611,8 @@ static void psi_avgs_work(struct work_struct *work)
 				group->avg_next_update - now) + 1);
 	}
 
+	trace_psi_avgs_work(group);
+
 	mutex_unlock(&group->avgs_lock);
 }
 
-- 
2.52.0

