Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B5A3F6C4C
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181497; cv=none; b=QXv4HmkrBCjkCWcB30Nq/CK3NNE8rBsnWQiawMbkrzkgXdHdC4ClApQGHm6MO7Ls+blJB/f5kpEBvIearFYbKfMBuVQxIxcYUWzRGGApE8g11F+L+jM4V+XIKj1Qq7Elo1uU64mluTf/P9ttH2fwIUX0P1ZCrl2CcYdO+rCPaTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181497; c=relaxed/simple;
	bh=ghfH5nvlicymyNLnSTdOFRGpY796mE7bAdr1lzzVhsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sM5e45vzTxO0meD6fW9xrr3ROwDi0rZcfaQSU+VmL8fNfBwZGuYBQB7NB2x7DVV2TgvDjD6tXk9gBSOAIGJqj/A/3Nb1UpchbiwuAi3GD/weaY233voYo8ERF0NwxmqwbXwkMH4skvWWGdBBsB22rMXBJ5YczQbvivK1uLH/BNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B+o8IO1F; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B+o8IO1F"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781181493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CMBdnUcMnhel/4O4ougiErIWIqnRAV5U4TyAr6bYtvM=;
	b=B+o8IO1FtfyLvCP/Cei4TJInCPOuVpnw87zEUELVfBU41Dn4b5Z0xwbblHZmTupmlkRplS
	80TxJthOXjy2bjpZqN3xaf3p2lEGhL2aCeJo6BADmFFwTP9i2GYCZt+rOvpa0Tt/I8RGnw
	Z7i+4PxQVI4xiUvPLGVqh21Ej3eJxKY=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>,
	Xinyu Ma <mmmxny@gmail.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Shuah Khan <shuah@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Cong Wang <cong.wang@bytedance.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 3/7] bpf, sockmap: zero-initialize pages allocated in bpf_msg_push_data
Date: Thu, 11 Jun 2026 20:34:11 +0800
Message-ID: <20260611123538.156005-4-jiayuan.chen@linux.dev>
In-Reply-To: <20260611123538.156005-1-jiayuan.chen@linux.dev>
References: <20260611123538.156005-1-jiayuan.chen@linux.dev>
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
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 3e555f276ba80..6e345ca65ca14 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2832,7 +2832,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	if (unlikely(copy + len < copy))
 		return -EINVAL;
 
-	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
+	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP | __GFP_ZERO,
 			   get_order(copy + len));
 	if (unlikely(!page))
 		return -ENOMEM;
-- 
2.43.0

