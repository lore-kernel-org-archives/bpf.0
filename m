Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867F73D1712
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781339104; cv=none; b=ZVsinXzZ2wiPY79IMFAobUc8bGXadf1MgGMdShyiUSUvocHQJ09tSUyq5OEzPcejukheEKIv7gswirwUXMhBOSFtN2Fg8Fx1PlY8pNiX+EgArUvL86BYIkSGIhMWOBVlZuwq+SKUTQVx6UQOimUn277NsuDYUBWqFxUAItMRqF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781339104; c=relaxed/simple;
	bh=uNZREjdTngEAW+wmgiqIS/P1uka5G/KGrFlcH/PgfwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pzm/liZD7KK63/UrhGEwwNrxftPHdGNtn1lVxPOEf5n62s6tS722oRG60+pOpTyRjx72hoRKR2BarGkiDX4c+akyHBRrR7hOvmkF+Rc/l4sbijiMkcEdN10ahKH7tnlviVywGZnqeqVwqC4EvtDLUl8iml7U40fN7WMPt00l4tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6fdZcCU; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6fdZcCU"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36d6bb38b44so1237230a91.0
        for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 01:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781339096; x=1781943896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SAVQv8WjEXijxzfisDbV6w9rhix2ecFSLNzXIn6EOaY=;
        b=Y6fdZcCUBd/J8Sl7J/ue523hT9ZrKEo6h0wdQJl+zQ53csFyWAWbJv4wZOvIHPZI+/
         T17ePuWoX2W9ApWIjpoldzrrbioO7wxxy5jdRCzvZ7+Zb0ugwDaRw2QLVsuBMHPNoptT
         jbDjFnLYMgP0uYxOAvffzlIDK2ZYshVYQ3KZO0w7o8WwnhQzyzuTajTRINd3KtidoePB
         DcgKleCQ4/9kX+jek33taf823iN40yezN4ttsr/8McvGFwMC4nCUFBOcPh41OiUV0Hzy
         YtglMYhSGjcYkLf9BcPOVWOevO92Do6CAhm/XAmrl5Ajwcx9HKiXyhjDU4wZZBgOGdJd
         Vt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781339096; x=1781943896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAVQv8WjEXijxzfisDbV6w9rhix2ecFSLNzXIn6EOaY=;
        b=ooQMRn94Mw+SCM23S1CNl2FoP/eqnemiyu4B2CZPuXanHX+dqVcUa9L2LL3nTfQYoK
         2xWBksPhATLk5iXmWffsGMLjFmPxBka+ln8NLz8FydugmgCpXHjs9PeJo3hqw9vU+0As
         ybQMwGTVk5Km5XVvXikVOXKDBlVhYaIudIYsc+7Mik/PZss2IVTSqHqGhi4QWtjjcPQ8
         8SGSePqExY3Ozxi0CABH0eUCORNfUrvrMhRowlNxUKunOVgw9M00ss+lO1JpfLHWKtd8
         I9P27OyxlXi3woX6Heu+w4J9RuLt/oemAY+Z4x4eNCVOqPmeqGLfxJMSTqJZg90voYW5
         qQIA==
X-Forwarded-Encrypted: i=1; AFNElJ84FIcx4jRZVuTTvtrRGE1JUVqcFTBGqBd7IR3N9MLeqr1keSH2S2vz5Eb7sZwzLYZyTRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWwKluhWleBIw5YiTQHPDh2BudULYa6jd6dsigrteENi5qmdKg
	CLW6RHCITrRR00D7/vrZjAPKT4V0o8pc9f3t6oH0ZBhZ+d5aThOout3s
X-Gm-Gg: Acq92OGLkQCVfE5AQ++EZJeloJm0WoQOFtdhx7noZPPOzK43UF0uRln4FyvDDMPXWZH
	PHnyMpY4o7bl9Ht4GRxw+tVH4mFn+MPEh6VwaUYU4jHfpIF8TKde4d643A1kWrlae80ooVyWqcz
	9ycpYmzjz9OMhGfVy5S6ptYQt07Odg+ezcBbnj8gMNQS155VxejUlKYi9dq2ixesEalm+BygyJQ
	9fcRI0F+DNrvbjPQhf196uvtVdAAwMyllVTtDZhfKHDu37D4IapgITkV8QuS9nf+dMw99EH6aD5
	yklWmNvRD25l23E36/ck2U26Bdlxt6AXVAhWG9f4c05RbOkZCB6uv9zpP57nYES71JZaPTU2Z7L
	N75Ia21LuqsbGk6IZid9myAWrtAfOUq7E6cIefpNC3OcCLacis+D6LGX7XAZ+Wn1o/Ced5M51US
	D9SKIL/Lk7AmOn243IP3QkTBoAvalNhvQ6tA9jlML2kNRJVMstzaDTTe6aBocgSw==
X-Received: by 2002:a17:90a:d44e:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-37a01847870mr6803728a91.1.1781339096450;
        Sat, 13 Jun 2026 01:24:56 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a25ecd5f4sm5070360a91.11.2026.06.13.01.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 01:24:56 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Liu Jian <liujian56@huawei.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Cong Wang <cwang@multikernel.io>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf, sockmap: fix BUG_ON in skb_to_sgvec() on a resized ingress skb
Date: Sat, 13 Jun 2026 08:24:31 +0000
Message-ID: <20260613082442.3252576-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sk_psock_skb_ingress_enqueue() maps a received message into a scatterlist
with skb_to_sgvec(skb, sg, off, len). On the SK_SKB strparser path off and
len come from the message's strp_msg (stm->offset and stm->full_len), set
by the stream parser. strparser does not trim the skb, so normally
skb->len - off >= full_len and len is within the skb.

An SK_SKB verdict (or parser) program may call bpf_skb_change_tail() and
shrink the skb after full_len was recorded. len then covers more bytes than
the skb holds, __skb_to_sgvec() walks past the data and trips BUG_ON(len):

  kernel BUG at net/core/skbuff.c:5286!
  RIP: 0010:__skb_to_sgvec+0x78c/0x790
  Call Trace:
   <IRQ>
   skb_to_sgvec+0x32/0x90
   sk_psock_skb_ingress_enqueue+0x42/0x370
   sk_psock_skb_ingress_self+0x1a8/0x200
   sk_psock_verdict_apply+0x33c/0x360
   sk_psock_strp_read+0x24a/0x370
   __strp_recv+0x66d/0xda0
   __tcp_read_sock+0x13d/0x590
   tcp_bpf_strp_read_sock+0x195/0x320
   strp_data_ready+0x267/0x340
   sk_psock_strp_data_ready+0x1ce/0x350
   tcp_data_queue+0x1364/0x2fd0
   </IRQ>

Clamp len to skb->len - off, and drop the message if off is already past
the skb. sk_psock_skb_ingress_enqueue() is the only skb_to_sgvec() caller
and both ingress paths (verdict SK_PASS and the backlog worker) reach it.
The clamp is a no-op unless the skb was shrunk.

Fixes: 7303524e04af ("skmsg: Lose offset info in sk_psock_skb_ingress")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/core/skmsg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index e1850caf1a71..2961178ebd1e 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -550,6 +550,10 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 {
 	int num_sge, copied;
 
+	if (off >= skb->len)
+		return -EINVAL;
+	len = min_t(u32, len, skb->len - off);
+
 	/* skb_to_sgvec will fail when the total number of fragments in
 	 * frag_list and frags exceeds MAX_MSG_FRAGS. For example, the
 	 * caller may aggregate multiple skbs.
-- 
2.43.0

