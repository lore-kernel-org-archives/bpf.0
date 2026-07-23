Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AD235AC12
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 06:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784786763; cv=none; b=URAOAx6q/c4X4UN1apBMv6gRrY6Oh5LT9dranZ9OeeRtnbfRKjILqjjibO9q04rEz6exsoXRLSh+Ik4XH8CSGK+W4iLgKBFPgUEnpuvq0gZPCn1mWvhKaDEUNn2b+aGBWxJOxTv+wWF5Rara7IUsWeuD8r88VkzZpq4ItgMSqbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784786763; c=relaxed/simple;
	bh=3vgwrGH26t35DlLQCta1Y9tRTWsVhCpBSi1HtSwviS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SpbaVBtorqRf1ACYMlVMt3gQUjvf+jM6FWhtixCbl7o35nvkFyfRMMZGRr9iueXgJqG2Aal3IJw1VHXRqAP6itp0AA+XdsDNAnBLQoI9pE11HrQgjczkF6xWJZ3Jr1WdcqPxcTdzRQZ4LAUnYyi+rttcVbiKqS1GdFmL/THXS/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tw9HVAEU; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tw9HVAEU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784786758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ewExqR6MeFWVwKzbjkv/ULcxEhhWIkFYVkeQnf1TdBY=;
	b=Tw9HVAEU6iNIVA16/5VOxfdVYV771My3Of+LWqJr/ZIhkEKveaUIVwI2H7TVL8CPHYsFp3
	/PMw6BUGeERilRjdt71OPIvvaopUmdxxE3oYj+6RA8OEECrKvvTRl9OP53wpYXcBZcLvg2
	LEOjwsmv8KgQUuIjNRiSGH23YuZr3sA=
From: xuanqiang.luo@linux.dev
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	idosch@nvidia.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	martin.lau@kernel.org,
	posk@google.com,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH net v1] bpf: lwt: Fix dst reference leak on reroute failure
Date: Thu, 23 Jul 2026 14:04:45 +0800
Message-ID: <20260723060445.21926-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

bpf_lwt_xmit_reroute() obtains a referenced dst from the route
lookup. When skb_cow_head() fails before that dst is installed on the
skb, the error path only frees the skb. The skb still owns its previous
dst, so the newly looked up dst reference is leaked.

Release the new dst reference before freeing the skb on this error
path.

Fixes: 3bd0b15281af ("bpf: add handling of BPF_LWT_REROUTE to lwt_bpf.c")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 net/core/lwt_bpf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index bf588f508b79e..652952d416f23 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -255,8 +255,10 @@ static int bpf_lwt_xmit_reroute(struct sk_buff *skb)
 	 * if there is enough header space in skb.
 	 */
 	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
-	if (unlikely(err))
+	if (unlikely(err)) {
+		dst_release(dst);
 		goto err;
+	}
 
 	skb_dst_drop(skb);
 	skb_dst_set(skb, dst);
-- 
2.43.0

