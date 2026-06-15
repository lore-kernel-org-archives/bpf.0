Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69355DDCD
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 02:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781490039; cv=none; b=nFf85uzIBQkfnMZL4Xu6haPUlWBqnw0934z6bl2c/E8XEmyRtvBr9eyqBO6DroEXCcI5XXJA6ZYw7uilPuUwEbs77CVA9kWR5A2lKf+FT5bgBP/PK6fwihsmmLHL0hZt6TQFUhQPzBZiK+oGAI4u1D7FA2OAnwpgMl5aK/NoZkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781490039; c=relaxed/simple;
	bh=3G4ey6S2accsHc3Ykg41xBf7IB6I7TLBuQOxpJ7SSMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlEkClQmOQ1qgKaSxhWQ5EX9Sh5apcXt2c1daCi9e+J8SuCrjc/f4RwfLlsC/vs+kisTH5miRcPOyzoZSDxsXDJc9wwQqzmRj5Dcy0z9cxaEOt+ag75+T5enTumEiGSR3BaQKTa3c3+TV9gPTxyaSUNYwDCSvkSAOtybd+l9t7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VMD4OIhO; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VMD4OIhO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781490035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=13yl1ZGHL8bYIIpg9EY4frJtIwM/R8sxT3ymIP4BNh8=;
	b=VMD4OIhOqLaa3vA1Co6lxyrB425Xblk99daUVuagy9ozI3Bd2uHL0tbNxd8fefSkU66XCf
	igztCfi05r8Gd0bxgrIjHlUjh7o0zqEbj9J3iKatm3KwzYlhu0ar+g2a/eDQqRIuA/WuyP
	GdiUg4CT3e8jpUkw0M3IiytZUM93w/Y=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev
Subject: [PATCH bpf-next v4 2/6] bpf, sockmap: Fix wrong rsge offset in bpf_msg_push_data()
Date: Mon, 15 Jun 2026 10:19:55 +0800
Message-ID: <20260615021959.140010-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260615021959.140010-1-jiayuan.chen@linux.dev>
References: <20260615021959.140010-1-jiayuan.chen@linux.dev>
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
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
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

