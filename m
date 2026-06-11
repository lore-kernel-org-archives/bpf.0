Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2581E7C12
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 01:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781141783; cv=none; b=PRqZnrRZczY8T4b5APMBa94LTmjKYNhhJxRsVg1ZSF8wp9uKAyK8ifLrNJzh0NJGeIuNR5VH8RlEUV9RvI2f5CS0mzGTY5WFu7WjHZWhPbVwb66sGRBQ9/Yh4A74/eyb/co4x3lNd7t/KkvxiYyt3dLSaDI03JIqJE9SqeUqsTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781141783; c=relaxed/simple;
	bh=jl2claSN9GOw67/kTq6017cd8Q5GfpE37wMJaXmnS8s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQJvoZfCyu6cja0ZeHz0SgxxY+oF0YSfqcxSn/TMmlrDPoefBfAwqr09l55n/R0Y9zKi76WsK+ICxnqTmITi+LLlFPMuHnNzF9M/jc4K064l/TB1Wnc5Flp9jGLPMnDz0peVFn2ULIKqg+bEZFK25yTe0/t4DUKhvTrINsf19j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZbBUuFb4; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZbBUuFb4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781141781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YP2iUFjrI/82TGCr2jp8ZjuLYda7Ywpe6Kgd4LSKEFQ=;
	b=ZbBUuFb4YNd6VrmaOfYwy0WuTtObTAapND75qwudNgrMoLe75ZhoHI/CEINZ7RWghd6z8M
	Tv4vepP/iX6qCn5RNeVZYj4DJ5cUCsFMMnCawdq9vClKiEGdGT6RfmMO9Qct13f8a1oqvU
	MTTREQUgLb45pDYlVUyHlPQNG/H6sYk=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Subject: [PATCH bpf 3/4] bpf, sockmap: zero-initialize pages allocated in bpf_msg_push_data
Date: Thu, 11 Jun 2026 09:35:46 +0800
Message-ID: <20260611013547.247039-4-jiayuan.chen@linux.dev>
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

bpf_msg_push_data() allocates pages via alloc_pages() without
__GFP_ZERO. In the non-copy path, the entire page of uninitialized
heap content is added directly to the sk_msg scatterlist, which is
then transmitted over TCP to userspace via tcp_bpf_push(). In the
copy path, a gap of len bytes between the front and back memcpy
regions is similarly left uninitialized.

This leads to a kernel heap information leak: stale page content
including kernel pointers from the direct-map and vmemmap regions
is transmitted to userspace, which can be used to defeat KASLR.

Add __GFP_ZERO to the alloc_pages() call to ensure the allocated
page is always zeroed before it enters the scatterlist.

Link: https://lore.kernel.org/all/20260424155913.A19FDC19425@smtp.kernel.org
Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
Tested-by: Xiang Mei <xmei5@asu.edu>
Tested-by: Xinyu Ma <mmmxny@gmail.com>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 3e555f276ba80..982d59cf659f5 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2716,7 +2716,7 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
 	if (unlikely(bytes_sg_total > copy))
 		return -EINVAL;
 
-	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
+	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP | __GFP_ZERO,
 			   get_order(copy));
 	if (unlikely(!page))
 		return -ENOMEM;
-- 
2.43.0

