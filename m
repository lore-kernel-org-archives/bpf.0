Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.250
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797736;
	b=MiZs7mpmS2DnkcaApVFnPze0PkZ9wPj1IZD2HzK+SmibgJ4AVwx7uSXYIvRcArmx3NKe
	 /W840eUIbb8sPPSlw7XlXveX3OFlgP0sYGCtstkqDY0kEardv2X7CHnSEEnEnuSpPPbgu
	 wS4EUF1390lHaQRvqcuu4ZYxWZOfOOAgFZ8FVyKC+feGOH8CQhrAiwGIQhC5eGdpFTnRg
	 SXTZFX6//QSYPNuzjRM40xkO6MUXGyZgG4gNGuAyqbpDRtBaQ+kVQooE9bHrlqCfuLabI
	 rEVxd0Elz7+Oa5wOuRbQvVOPPXjZc4Nt1jNbSPgG2lNLGSgnpDETsvRcjcX4MDHks7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797736;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Km4Cv0O0nuE0+Y+BE7m08mP9J2XXD5bcoWZppFqnwaU=;
	b=CXb+4HosGeZJnH2TgDn1R53b3x2K8M7McUZvQuximXV0GTIeRRDaz+9q63Ja51R9CxvO
	 uct89NBrkicwc/2TFREyYLloUS/jE8QTAjA29KfLnpUxxiY4MSsZELnSHEZDZ8kzpYOt1
	 pM27NwWgE2szO7yp2hIp/rJdKzqrrVePVuHMaLJ9GN1w4GxtW9I2EdAKp5yjeXKDAS7Hp
	 dq541Ua6eV7Qcn3ZmYzMdHKbD6k3XexgDSAejSOLGYCAsG8vEyao8GJ/a0Kuyyzx8xOMU
	 fXiczbZ1hEOdnrAzV4T1uFkY8AuFWkHqx1eNJqGxJZpAedbeYoTZZM009/kxYMKGZFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="Nts7Qz/c";
	arc=none smtp.remote-ip=95.215.58.250
Received: from mta1.migadu.com (out-250.mta1.migadu.com [95.215.58.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA34606A326
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 13:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFA34606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Nts7Qz/c
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jyyu3ZdXnJNcUGMDlH0RvUqU3YiWZYptJtZdAQQmKqQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793797733; v=1; x=1794402533;
 b=Nts7Qz/csRjIv5C/I+MPUbIfzmresybv4xf0R+/fVOEZEXeoQzZooXqNS11ho2y42mIfVar4
 /RhEG7gOngu+1Vat416C3dSUJ/T1OQnB/otSBNGcrbUybQn+wenll1cOkHZFDazBm4moNG6L7Ce
 ncMXZYHthv5Cz1Gcsfasm0Ok=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 25592fce0d3f543f;
	Wed, 04 Nov 2026 13:08:52 +0000
X-Mizu-Trace-ID: 25592fce0d3f543f
X-Migadu-Flow: FLOW_OUT
From: Ridong Chen <ridong.chen@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Dave Chinner <david@fromorbit.com>
Cc: David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Muchun Song <muchun.song@linux.dev>,
	Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	cgroups@vger.kernel.org (open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_)),
	Ridong Chen <ridong.chen@linux.dev>,
	Ridong Chen <chenridong@xiaomi.com>
Subject: [PATCH v7 1/7] mm/memcontrol: drop unused vmscan tracepoint include
Date: Wed,  4 Nov 2026 21:08:11 +0800
Message-Id: <20261104130817.849089-2-ridong.chen@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104130817.849089-1-ridong.chen@linux.dev>
References: <20261104130817.849089-1-ridong.chen@linux.dev>
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

memcontrol.c includes <trace/events/vmscan.h> but does not use any of
the tracepoints or macros it defines: all tracepoints invoked here come
from memcg.h and writeback.h.

Drop it ahead of moving the vmscan trace header under mm/, after which
<trace/events/vmscan.h> will no longer exist.

No functional change.

Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Baoquan He <baoquan.he@linux.dev>
Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
---
 mm/memcontrol.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ffbcea28a608..1ebc9330aeae 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -77,8 +77,6 @@
 #include <trace/events/memcg.h>
 #undef CREATE_TRACE_POINTS
 
-#include <trace/events/vmscan.h>
-
 struct cgroup_subsys memory_cgrp_subsys __read_mostly;
 EXPORT_SYMBOL(memory_cgrp_subsys);
 
-- 
2.34.1

