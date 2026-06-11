Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE30227BB5
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 01:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781141782; cv=none; b=RTh57rWNjTI3GZvJfFcepfOWiIkME7QFxGCjcUah/WCRqNEMJFJbn0vb1lJ8sajt9XjlUfPT3P0SyMDkL77Qb2Av/CUWRSqv8jkds0aHX8SAjS3cbvoL0a3iLEbdJcc0Bv/LXtRheP2Dp1FQqg1k3fk7SPGACCD3Qs1P3errot4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781141782; c=relaxed/simple;
	bh=5mxKBzvnowidBjgde/jIqy+fc+YnBqgqCLy+7C+lsZ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qC1ZVuQaEDn8SJEK2HrjcnTdwtTt1x0AG73dgCETk9N6aaQ+5BHSWnA/jLGeE/gTj8LNYMFfdErVdhBbL8682zFVqfGo7Fsq0uHPU68VYfbEt+osRgCY9J+0r+uAnaoDwUgnjmO4rujh3oOU7Y0IOz1Qnun80Bn4d0KnGveMkRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JRvjOV03; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JRvjOV03"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781141779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sb9Iidi7i6IFHOh7FE3060dCj9fYsQNIqxlFu2JS7V0=;
	b=JRvjOV03i8U0RaPIEJGb1k84o/ejzj101maecrQcf2UAWpcC3byCC9sV5X1IVIwxvOjNHZ
	qh8PvLy/e3xLGGE6qRAGb1t5oh9BGcbgx7m5kWztFSTf1qSKWPS7PQHaveMp/Q2j+zwAFI
	ZSRQ7Yt1yiy/H3dt1l/AIUJ1qqFh00s=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Subject: [PATCH bpf 2/4] bpf, sockmap: Fix wrong rsge offset in bpf_msg_push_data()
Date: Thu, 11 Jun 2026 09:35:45 +0800
Message-ID: <20260611013547.247039-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260611013547.247039-1-jiayuan.chen@linux.dev>
References: <20260611013547.247039-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Weiming Shi <bestswngs@gmail.com>

When bpf_msg_push_data() splits a scatterlist element into head and
tail, the tail's page offset is advanced by `start` (absolute message
byte offset) instead of `start - offset` (byte position within the
element). This makes rsge.offset overshoot by `offset` bytes, pointing
to the wrong location within the page or beyond its boundary. Consumers
of the corrupted entry either silently read wrong data or trigger an
out-of-bounds access.

 BUG: KASAN: slab-use-after-free in bpf_msg_pull_data (net/core/filter.c:2728)
 Read of size 32752 at addr ffff8881042f0010 by task poc/130
 Call Trace:
  __asan_memcpy (mm/kasan/shadow.c:105)
  bpf_msg_pull_data (net/core/filter.c:2728)
  bpf_prog_run_pin_on_cpu (include/linux/bpf.h:1402)
  sk_psock_msg_verdict (net/core/skmsg.c:934)
  tcp_bpf_send_verdict (net/ipv4/tcp_bpf.c:421)
  sock_sendmsg_nosec (net/socket.c:727)

Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
Reported-by: Xiang Mei <xmei5@asu.edu>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 3c8f1cedb217f..3e555f276ba80 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2872,7 +2872,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 
 		psge->length = start - offset;
 		rsge.length -= psge->length;
-		rsge.offset += start;
+		rsge.offset += start - offset;
 
 		sk_msg_iter_var_next(i);
 		sg_unmark_end(psge);
-- 
2.43.0

