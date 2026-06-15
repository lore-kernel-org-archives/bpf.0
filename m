Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C93323909F
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 02:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781490037; cv=none; b=Jd4Wyph53PetJy3y1FHlx2E0FdsgwY3V/o/66nLgN2zASI8/7RKhVSPkWsIOrOIQxWRdQ0inYcneMduuHQL9eEUim4BDuspuihS9eroghEnNeQdTB/0NRsbAf7+dMNYt2xuqWjLF3wKNYNjMb15xeyP2nDo37gldJ2eYzviTDS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781490037; c=relaxed/simple;
	bh=uwybBJJJS67trTAs68fbSohQDQntqGwBcy6+LwRg8z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHfENNyge1fCGyovJnffp+2dgZXP7Ym54qsYe9GPhhsJf8cQCJUDX/M9FlCW14X/M/pdQh9tIQNdBXXytSMYYZvRWazp6bPASCA3+cQaZp2E4IMsD13aEJ3d7TrBqy1y+xk3t/v+4w2bSBhcV6vJW/LKYx4/0gjpxGh1FeFvvQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=doNJOq35; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="doNJOq35"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781490034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+4wRjg/VBX6jMXCUra998SaBMXKUnzqQsMOSm/pi5ks=;
	b=doNJOq35ajZRo3gd0o1g5q3TQMFcPpqOGyUjRBwVJQr4KMzA05DWEPslwIOCchnkqn4NL9
	g2TGWR21ghGOssJyfT6mZZyv6HHYTYaTJqjQE23q44Q6GfvoG2CBTsBjJFh32HR1nfbcKF
	WCvEbt5w8hsNTaWoejycPOWsTJsDDig=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev
Subject: [PATCH bpf-next v4 1/6] bpf, sockmap: reject overflowing copy + len in bpf_msg_push_data()
Date: Mon, 15 Jun 2026 10:19:54 +0800
Message-ID: <20260615021959.140010-2-jiayuan.chen@linux.dev>
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

When the scatterlist ring is full or nearly full, bpf_msg_push_data()
enters a copy fallback path and computes copy + len for the page
allocation size. Since len comes from BPF with arg3_type = ARG_ANYTHING
and both are u32, a crafted len can wrap the sum to a small value,
causing an undersized allocation followed by an out-of-bounds memcpy.

 BUG: unable to handle page fault for address: ffffed104089a402
 Oops: Oops: 0000 [#1] SMP KASAN NOPTI
 Call Trace:
  __asan_memcpy (mm/kasan/shadow.c:105)
  bpf_msg_push_data (net/core/filter.c:2852 net/core/filter.c:2788)
  bpf_prog_9ed8b5711920a7d7+0x2e/0x36
  sk_psock_msg_verdict (net/core/skmsg.c:934)
  tcp_bpf_sendmsg (net/ipv4/tcp_bpf.c:421 net/ipv4/tcp_bpf.c:584)
  __sys_sendto (net/socket.c:2206)
  do_syscall_64 (arch/x86/entry/syscall_64.c:94)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

Add an overflow check before the allocation.

Link: https://lore.kernel.org/all/20260424155913.A19FDC19425@smtp.kernel.org
Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
Tested-by: Xiang Mei <xmei5@asu.edu>
Tested-by: Xinyu Ma <mmmxny@gmail.com>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 9590877b0714f..3c8f1cedb217f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2829,6 +2829,9 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	if (!space || (space == 1 && start != offset))
 		copy = msg->sg.data[i].length;
 
+	if (unlikely(copy + len < copy))
+		return -EINVAL;
+
 	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
 			   get_order(copy + len));
 	if (unlikely(!page))
-- 
2.43.0

