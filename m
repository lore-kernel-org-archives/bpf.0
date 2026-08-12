Received: from mta0.migadu.com (out-223.mta0.migadu.com [91.218.175.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ACE43B3D1
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786553337; cv=none; b=WCNzvpNUhsVv72yeQNQS/Kf3jeX0a/OIWw1yGHgwWA9GXOnu2k8QDbHJHRCF8N1h1fYIqJQnAMRf1lP9Rt1QU4O/OIlzY4LiNIg8DPLBY90U7VGQqg3sZoRvBdiiZrZ8RXcbgb9nwW5V7ggRmsw4d3DfkiUMbhUkQ4bSN0US4CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786553337; c=relaxed/simple;
	bh=9Zz695qFcJN6tT5kWEDZG+5dsGqvgRv6vroaGOeo9KI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q6m0G77ZjqPeDHgA0l477vgef0Mit3RTK0DdydeETARprXLG8l66HrOX5hy6seR8eFSeuBq4+fjaKUYg710ARFENZwK6jXBfvkRtFQDOpy8Op3vdXeePTRcjha4X61zARyOGXA0K+t0PJ5ypLs/h9wCYDysko94eY35jeRhjuzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xw03RYoh; arc=none smtp.client-ip=91.218.175.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xw03RYoh"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9Zz695qFcJN6tT5kWEDZG+5dsGqvgRv6vroaGOeo9KI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786553331; v=1; x=1787158131;
 b=xw03RYohMMD1hSX/b4T958tX4iP8fjfsTUrIYEr1+hx6idCGKt7PgfwGPWAFDjDfnTjVRrDK
 ywFtNJkdWAuCxUJ7qoqm+AtgZAbifhIXPIcr/T2IuQgdMqskdeC3jRmYpTFT/1AAPWZehR7Kow4
 mHdPPYrktN7vqOpQLnJ2Qv9I=
X-Envelope-To: bpf@vger.kernel.org
Received: from .linux.dev (117.20.149.103)
	by smtp.migadu.com with ESMTPS id e0a4c1ed99434c8d;
	Wed, 12 Aug 2026 16:48:51 +0000
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next] bpf: Trim special_kfunc_list in verifier
Date: Thu, 13 Aug 2026 00:48:43 +0800
Message-ID: <20260812164843.55601-1-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 7619a0ee9340 ("bpf: Mark existing lock-safe kfuncs with KF_SPINLOCK_SAFE")
dropped some helpers in verifier, which also eliminated the use of the
following kfuncs from the special_kfunc_list:

* bpf_arena_reserve_pages
* bpf_stream_vprintk
* bpf_stream_print_stack

So, drop them from the special_kfunc_list.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/verifier.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index add3affc5703..8797ae08f232 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11092,10 +11092,7 @@ enum special_kfunc_type {
 	KF_bpf_task_work_schedule_resume,
 	KF_bpf_arena_alloc_pages,
 	KF_bpf_arena_free_pages,
-	KF_bpf_arena_reserve_pages,
 	KF_bpf_session_is_return,
-	KF_bpf_stream_vprintk,
-	KF_bpf_stream_print_stack,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -11185,14 +11182,11 @@ BTF_ID(func, bpf_task_work_schedule_signal)
 BTF_ID(func, bpf_task_work_schedule_resume)
 BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
-BTF_ID(func, bpf_arena_reserve_pages)
 #ifdef CONFIG_BPF_EVENTS
 BTF_ID(func, bpf_session_is_return)
 #else
 BTF_ID_UNUSED
 #endif
-BTF_ID(func, bpf_stream_vprintk)
-BTF_ID(func, bpf_stream_print_stack)
 
 static bool is_bpf_obj_new_kfunc(u32 func_id)
 {
-- 
2.55.0

