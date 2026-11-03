Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674608;
	b=mbcOB9YtwLGWeJexuY4s7dcmy+BvBu1JFHu6eEpoQQpn96/4crp7knHiZh1EvJFj8GN/
	 lNaXg0jo0gSP+UdH9js3EXIPBBG8r0Tyt5f4GqQJnAKtSFpauoVKIffLUHE0POF+XN5+c
	 wGY7uKuU5rcsHS4yKO6ZZ7/zLobb4a2wKlFTIMDUWFBN0tLOVMtzpbeW0Gv6Hie7+5drX
	 7j5XjnkvQlslNFSHrRwX7MYRR/ZCQNp51ZVxF1Wqd+bZjGTqb603JaiouZ7UAdhCMjJHY
	 XIPMbiADpKdhmI+0Abbd/Y5ZQWOwrkL5pxTWO8WadR0Et2WFRdlsHF5sCMqgOypyMcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674608;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RIOkkGnIZaSPy1/KAD5FiiNG0GgLq7eCUC5R8WcHZHE=;
	b=c3EhCyTD9GotBATM+/9qvUQ4W/Wirh3txB5PU25vd7uRW605DuQiccGa1/pWmHJ/f8B1
	 BoaKIooLa0V4E/oNLJ9/o0mT8+iU9ne9kYTKeQbJtlnBbKapbgm/Ju8viqBfYtxoglBuL
	 x+mFBqOtBzYdQxzxTY9oTZemJT8wdB5Hfjr9myujhqcGAOgsOFBDZhyS0s01ck/I1bIBg
	 bOLdndRqh9Y6ypn0oncGhsS7U16BfXC8ffToQJq9nGGmE/yg1LB3EFgWxh4BlOSYqXvii
	 ZuGUyq71KMy/14VMSqG/4AwFlFmVXY/mlttbwhx5ON4giBRbtYiV69/Ds6U0vMVqJ2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="cp2Z//Ry";
	arc=none smtp.remote-ip=91.218.175.205
Received: from mta0.migadu.com (out-205.mta0.migadu.com [91.218.175.205])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3DB606A326
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 02:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E3DB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cp2Z//Ry
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9n/hwIsY+R5F+Nl0olpxr58NPq3L66rvI7ss+scwvow=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793674606; v=1; x=1794279406;
 b=cp2Z//RyDRGkFzDFCZCmu1hbgRc4Q5bqkhpgGOy3i1hGpm1LxihWaKRiMUUz2EBrXHw5U7WV
 vEESiX2Wbe2xTpBf4rH31pN6dXsGkU23VFOtygJCr1dwNnr1RrlpoEqDq+NhfHKz/jhlOeToPCi
 qblVZMc2F24LY08wvwjI8e9A=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ddeccf7e7d3279f7;
	Tue, 03 Nov 2026 02:56:46 +0000
X-Mizu-Trace-ID: ddeccf7e7d3279f7
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
Subject: [PATCH v6 1/7] mm/memcontrol: drop unused vmscan tracepoint include
Date: Tue,  3 Nov 2026 10:56:04 +0800
Message-Id: <20261103025610.3738894-2-ridong.chen@linux.dev>
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
index ac6c43ea8c5a..5bad742dc381 100644
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

