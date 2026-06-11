Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A7D21CA0D
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 01:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781141779; cv=none; b=Ywe6QZOBusZGujzk9qZf4ZSi7D5JOifvWOIZEXZ3+bimKffNWwafi2VOCbEiXNB3AX51QPAVio9Zd3L/8a8xLMw1lqshEnWz7UUMk+dJMPLRSm+lsBdSgWLbXeA1g5Q5yO+K/H08b6xdPc81KkQbHJAWtVEStxuFzmPoClZiT3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781141779; c=relaxed/simple;
	bh=ZCIzv6+lsbfVLlFVxtUoTluI23WWfKvqe4xO1/duSFE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fx4rBP2G1p1N43qfYzhYPjaW13rxNzECfxa2mBstyYT6ednQGsf1KQtWa8KO++bLsFsHuNWX8uTIbLNlVpHSHBsV38edd6PLwV1owYuRgqF74IQvht7ToY2RtmvgPDY5D19n1rPPtHMMApDTNJPq/eRY2k62edxUMwIduo+EHCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MvM1ykGR; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MvM1ykGR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781141776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JFpNrBu3QJCHypLb6mo7QQLGLEtEcT9OwqF3/hCfZn4=;
	b=MvM1ykGRR6b+I0axDuvfkFlkKhm1fEYj0VkgD7D/i9GCrN+m+3tlN+U7hhZ1Zl7zYoOM6h
	Eh71GuZh/qnzn+WjBExHPhae48Ae6Ai6IPLSz7TnoOVa++zVAk53xXPOcg1iIRezfusF4J
	MwZYv4XXH+JrfrS+f0z5YVNXt2ly/LY=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Subject: [PATCH bpf 1/4] bpf, sockmap: reject overflowing copy + len in bpf_msg_push_data()
Date: Thu, 11 Jun 2026 09:35:44 +0800
Message-ID: <20260611013547.247039-2-jiayuan.chen@linux.dev>
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
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
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

