Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D3B46D55D
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791793318; cv=none; b=LBY1C/0buh42pGrA0fyKamamuIk+EGEs9vF0LXIqsUp81qDfTC4bz1GogNjBJJIAci3D1lHYZ6Ks7xp7dVYEIv0NhjAGy8s1DIMEtDMa8gK+u5FQz48RmJAS60vbBR3g6CrPqB76uJTsmwTlUDrFcJF/A4DQ/uuKS88g94YyYdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791793318; c=relaxed/simple;
	bh=57Zei123p9xWRFdldkMP4W3UF50+eUNVP3R3eVd94K0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RGp+xd09X9TFCWtsNPOLb47QLIzcUOV9Re80EM3Dh/gGwYnMup5ZsaZva56KhRzqPxk1tuxKRnheQyJFWWmfN6U68iuUWhqf5d4K5WsRi+/HCD8yP7gDLKiZrLG4473zDG5Su6jhTeNjgFtt9IqWeFuPgaOYBsO0PB66bgKyRS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NZMqYmTV; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NZMqYmTV"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3510d0baf63so4630655eec.1
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 01:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791793316; x=1792398116; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XSfzsz0eu9DYJ9q7ruuuzGdJdAhI+2e1gpy8B2gxhXU=;
        b=NZMqYmTV7H1a6TlVGHC8JlbaTaE78cBuG3sGCaImWNIqEMfa06aYMvNK8CPiUhOfrA
         K+TKqQfO+JYHAbrhv8ZsqixAxVEsdRBIndS5YNYwrZ1sx6dMHCJubS3YYa4T18PMYaCS
         8Kgt+V4Q0ZUFsRgEtQw7sMovWzuOR+g4lZ0TnbNlzyIcoIq42tPmARoLiXPbqJuLyVx3
         S0ULBsBY2G0SBdDfjBLu04knsB3YLWbXWEsCAccJqN71CTxD2l49e1+Tq6TH3YqCXkGv
         6z1s/RB6Hb5muy8DOWmcWCdAKjLxisleqowYxPnYVg4Ws+R8SzS4wmXqX5+X1jX2VII/
         bCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791793316; x=1792398116;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XSfzsz0eu9DYJ9q7ruuuzGdJdAhI+2e1gpy8B2gxhXU=;
        b=Y0USj3E5Bs445+3RRsG2aKRdJxvIqRqPbdxQqnDElrTfGh6GTY5CPUzLeAIIOvINE0
         ua44P4ICyb/odwIehPLzB9QnfATp72Q5OtPuoLvfwe3A1PEvOz6EHiuY6MaJIy71LlVD
         ImVc5vi4v1UZfh9RyfIjNfE/0ETkjtoGZqa2ES18tEyP5EnMZ11Hv2YUWuBDwAVaeEUu
         xdZnoD2mU9Vn4lVKbxJ3lyXDQJMF4Ih8boUhKfYoANyn7waCPfgUkYfyj2T5a5Y3alFl
         /BVpEmKk5IN1meIUyQwsKss9QPSYJjdBEo7FsjkM6m4SBUkT5eIWai0knsEi/tsygD5+
         U0DQ==
X-Forwarded-Encrypted: i=1; AKwUvBwaS2lZvLUgiOzU+iKNfWzvM7zRqS52qlyVJm6pHaGF1buDmrKq7J2v/zKSKpU1gZpauQM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHAcHQdNoWuVImJcpqOM3yAR5yitnJJH3nZsfB4Vowg4/DsBn4
	sZNg20jZRiItFlBMd1us4WXnzAUcAGuye0qV+e2ITPxz/8ORPMsL8CP1LC3uy7MEQYHdqZqJCpi
	VdAqOadJk5QJ9SmgQ6anKNgTsuA==
X-Received: from dyay4.prod.google.com ([2002:a05:693c:62c4:b0:342:cdb2:3e44])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:152f:b0:351:7dc1:7aba with SMTP id 5a478bee46e88-3537e12becbmr10861813eec.32.1791793315255;
 Mon, 12 Oct 2026 01:21:55 -0700 (PDT)
Date: Mon, 12 Oct 2026 08:21:47 +0000
In-Reply-To: <20261012082148.1698596-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261012082148.1698596-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261012082148.1698596-6-almasrymina@google.com>
Subject: [PATCH net-next v2 5/6] net: skbuff: use skb_frag_ref() in skb_try_coalesce()
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
	"=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=" <u.kleine-koenig@baylibre.com>, Jijie Shao <shaojijie@huawei.com>, 
	Michael Grzeschik <mgr@kernel.org>, Jakub Raczynski <j.raczynski@samsung.com>
Content-Type: text/plain; charset="UTF-8"

skb_pp_frag_ref() was introduced solely to work around skb_frag_ref()
ignoring skb->pp_recycle and incrementing the non-pp backing refcount.
Now that skb_frag_ref() handles both pp_recycle=1 and pp_recycle=0
symmetrically, call skb_frag_ref() directly in skb_try_coalesce() and
remove skb_pp_frag_ref().

Assisted-by: LLM
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 net/core/skbuff.c | 37 ++-----------------------------------
 1 file changed, 2 insertions(+), 35 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index fe73f6e8d2b3e..20fca895d7090 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1078,37 +1078,6 @@ static bool skb_pp_recycle(struct sk_buff *skb, void *data)
 	return napi_pp_put_page(page_to_netmem(virt_to_page(data)));
 }
 
-/**
- * skb_pp_frag_ref() - Increase fragment references of a page pool aware skb
- * @skb:	page pool aware skb
- *
- * Increase the fragment reference count (pp_ref_count) of a skb. This is
- * intended to gain fragment references only for page pool aware skbs,
- * i.e. when skb->pp_recycle is true, and not for fragments in a
- * non-pp-recycling skb. It has a fallback to increase references on normal
- * pages, as page pool aware skbs may also have normal page fragments.
- */
-static int skb_pp_frag_ref(struct sk_buff *skb)
-{
-	struct skb_shared_info *shinfo;
-	netmem_ref head_netmem;
-	int i;
-
-	if (!skb->pp_recycle)
-		return -EINVAL;
-
-	shinfo = skb_shinfo(skb);
-
-	for (i = 0; i < shinfo->nr_frags; i++) {
-		head_netmem = netmem_compound_head(shinfo->frags[i].netmem);
-		if (likely(netmem_is_pp(head_netmem)))
-			page_pool_ref_netmem(head_netmem);
-		else
-			page_ref_inc(netmem_to_page(head_netmem));
-	}
-	return 0;
-}
-
 static void skb_kfree_head(void *head)
 {
 	kfree(head);
@@ -6309,10 +6278,8 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 	/* if the skb is not cloned this does nothing
 	 * since we set nr_frags to 0.
 	 */
-	if (skb_pp_frag_ref(from)) {
-		for (i = 0; i < from_shinfo->nr_frags; i++)
-			get_netmem(skb_frag_netmem(&from_shinfo->frags[i]));
-	}
+	for (i = 0; i < from_shinfo->nr_frags; i++)
+		skb_frag_ref(from, i);
 
 	to->truesize += delta;
 	to->len += len;
-- 
2.56.0.385.gd3acb90ef8-goog

