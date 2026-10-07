Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3279C3E49EA
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394581; cv=none; b=ExPrCuSmxs6bJFMZZ2LiV+ClMLWmjdBw44tg66c/o5WqBQmZg0Cf7awgBw+e+K6uiPS+F/9Ctw5ktWYBoLoCiL6lPawUfLgo98isILBut9Gc9LiGe4Ow1iOMNI+nWbwfdABf5F0T9fYUNdsXrYImew7pbG6Jq4ZlbFRo/skGDjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394581; c=relaxed/simple;
	bh=7/5tfJIy6W8TIdl9hZooAFhzBT+2SjfY6Wr1A0j34NI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kTURA+2a4rUBVTBmMqrv8rY84cnHA/lc0LsCP/IMpfZUFh/Wv2RilDF9gYuUUQpnIx5L+usRSriqEvbY4YMukVgzr5YVmLDF4s1sUianLZfjhuofwohQdS2srqpemwGvPLi8bXsUduWss4b/RN+2e0x8TTS7WRR8iRfO86qQr4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=Ob00tajF; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="Ob00tajF"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-533797e72e8so26370471cf.2
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 10:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791394578; x=1791999378; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zrdwjfjy+S8tMtuXsIClvdWbR7PzRWTgUMrLZvnePDM=;
        b=Ob00tajFE580Nl/3pAL8HWGKONucJT/gc9PBUPGBgXk8LoBoHSZMDZQY33SgxzVzgB
         ElNtz4FyH48sfQKFUWfilxrbuo0QvhtQVXGFdbDmuHUOMjW5BC42aFW+Hv8b5aCtj5Bf
         1YTz1mrlar5hcUrzmJvx6eEYoaP193rvzncOurKpmW4sg/MYZIsKJzTnG3ows13le49o
         e5NWOzw8a3qs+lJ8Qdrjzms0sc1gapMUOLfBONMaVZCJz35UggsKt17TJ8gjDTyIw408
         Euk/lJLOf8UW9m79Uh/7/5N9ff2ODUmLa9nQ/kllnF/AOaJ//bOniTs4SeSFnGWXyCJ+
         xLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791394578; x=1791999378;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zrdwjfjy+S8tMtuXsIClvdWbR7PzRWTgUMrLZvnePDM=;
        b=l/bKai3YySfpbctkmQu5A71VUZ68uyY9BXR0ojhQYs4mG8YVzGg4JIQZFDbDy2KrxA
         Weptl3osinwzh8jBCinoeFCV1X6X488M8rXcOjeizu6jlXCnRL6y2b4LU+qxc4q5mexj
         1K1CfN2KMlzIqFpUdeX6M5y5N+r1lFCqLXBiy81e04T+GD1QQ5Z3/0AI2F0lnfU/5AXF
         Xnb32bEvvE1eqCm/GyuvGxzG7iOaYcCIXp+ig8k2Xde89bH5PPauizOBTfSNM1/zbIaL
         LJHmNc29+IhxGBYfdz8lOFFXXIAvJmho1AMlhfd/xOPOKdwWmNzpUwmnCbMGo+219np4
         WR1A==
X-Forwarded-Encrypted: i=1; AKwUvBzcRsSJeW/zesMSfBpsxEVcUEsKMImuRen+x6zQBNLrfFu4+/gH+a6w5oew15c4WJdFdhA=@vger.kernel.org
X-Gm-Message-State: AFuF++kRRiCU39cpjEyW/dTl6eSUgGQ+Na83G3tloX0UCkIIkRLmOmYi
	wDKKc7/r7nvMqFWo0CTI5p1RVYrbnrDyO3laN69CnP8SqQj3CcjlUJqNjAPRl1e5x+8=
X-Gm-Gg: AYBFou0ERTtTZjeekqx+TWlloRTLlWn8iN3wYgNV7xqYTnQKqgN/E4usJlkKaw9Q0Xa
	l6RFvY9NB3r2NGivuzC4DTsY9r6ZBFdzC2JcP0h73MQnjAoyTCoRHrInAJeJtedOF594OhbHbHL
	8uZvVT+3JGOdIxC5UtEFlnCHNdt4F1ALs85iQOXqbFscVn2X27yIwxZfTdh9FNwlfMKcNKXU4VH
	KkW6QENqBdb97uo+CDY2+QsebrYt6np3abVk9qoDLfr4hJnBooDXF7SgDg2obVxhj8qwJ/Mjdws
	nuj/k+9OpS3/3t9/52dWmL2CnvkcYwn8RKwY1scKrTOdPFfNHXSH9SEoYZPFC7t2WI916aa6QyB
	16G6+J7xMF6Ozi3r4m+A4A9S1Ckkdks0A92ssGuLd6RCjElMU0i4647YeR+M6TgNArez/BJsKe7
	CEDsP00yAiWGxvSSpQ4T6rkoMR33ThqY+xniFhFK8DRnHwaR8owGUy3BacWXtjZz0ujeWE1EL7X
	18RcniFx/dRLbw=
X-Received: by 2002:a05:622a:418f:b0:533:2bf3:3301 with SMTP id d75a77b69052e-53575501674mr46954561cf.36.1791394577888;
        Wed, 07 Oct 2026 10:36:17 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5357213f3dcsm24583961cf.17.2026.10.07.10.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:36:17 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 07 Oct 2026 17:36:02 +0000
Subject: [PATCH net-next v2 3/8] net: skbuff: don't BUG() when
 skb_copy_bits() fails in copy helpers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-b4-skbuff-bug-on-v2-3-b9a5f732895b@toxicpanda.com>
References: <20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com>
In-Reply-To: <20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791394570; l=2620;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=7/5tfJIy6W8TIdl9hZooAFhzBT+2SjfY6Wr1A0j34NI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QG8qkTVUA4W+CHYi4hSjchPweqAtKNSPPJ2+IFTy68VmnoeA4rzJ6nve29AghKY4OXbgedSHcU1
 ZI3SHq1Y+CQI=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_copy(), skb_copy_expand() and skb_try_coalesce() all BUG() if
skb_copy_bits() fails.  skb_copy_bits() only fails when the skb's
lengths don't add up, which is a bug somewhere else, usually in a
driver building the skb.

Each of these functions already has a failure return its callers handle:

 - skb_copy() and skb_copy_expand() free the new skb and return NULL,
   as they do when the allocation fails.
 - skb_try_coalesce() returns false and the caller keeps the skbs
   separate.  Copy into the tailroom before skb_put() so that @to is
   untouched on failure.

Take those returns, with a DEBUG_NET_WARN_ON_ONCE() for debug kernels.

__pskb_pull_tail() has the same BUG_ON(), but several of its callers
can't otherwise fail and don't check its return, so it's left for a
separate change that fixes them first.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a6821ab13969..ffc78b1a8ab8 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2201,7 +2201,12 @@ struct sk_buff *skb_copy(const struct sk_buff *skb, gfp_t gfp_mask)
 	/* Set the tail pointer and length */
 	skb_put(n, skb->len);
 
-	BUG_ON(skb_copy_bits(skb, -headerlen, n->head, headerlen + skb->len));
+	if (unlikely(skb_copy_bits(skb, -headerlen, n->head,
+				   headerlen + skb->len))) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		kfree_skb(n);
+		return NULL;
+	}
 
 	skb_copy_header(n, skb);
 	return n;
@@ -2545,8 +2550,13 @@ struct sk_buff *skb_copy_expand(const struct sk_buff *skb,
 		head_copy_off = newheadroom - head_copy_len;
 
 	/* Copy the linear header and data. */
-	BUG_ON(skb_copy_bits(skb, -head_copy_len, n->head + head_copy_off,
-			     skb->len + head_copy_len));
+	if (unlikely(skb_copy_bits(skb, -head_copy_len,
+				   n->head + head_copy_off,
+				   skb->len + head_copy_len))) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		kfree_skb(n);
+		return NULL;
+	}
 
 	skb_copy_header(n, skb);
 
@@ -6233,8 +6243,15 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 		return false;
 
 	if (len <= skb_tailroom(to) && skb_frags_readable(from)) {
-		if (len)
-			BUG_ON(skb_copy_bits(from, 0, skb_put(to, len), len));
+		if (len) {
+			if (unlikely(skb_copy_bits(from, 0,
+						   skb_tail_pointer(to),
+						   len))) {
+				DEBUG_NET_WARN_ON_ONCE(1);
+				return false;
+			}
+			skb_put(to, len);
+		}
 		*delta_truesize = 0;
 		return true;
 	}

-- 
2.55.0

