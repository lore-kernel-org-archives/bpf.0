Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E3A3A6B68
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 10:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781778458; cv=none; b=uOCkeBx+2FpMR82usGMB9FvTwCDqOur0nzyIhaJd3XIh1hoCaVljZ6cZb1gBnagOdtba1cC/ZXrRCqV4F+66qkqilsahbGWK7YAdupVNK02lOlV4mo5hboLkfk25wnQURT+ps5PXE23bc5uYwMMjSdw2/cOlAiqtNt/awFPHl1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781778458; c=relaxed/simple;
	bh=4bLcebf8/cJoz0Im0FVWTu3FiTZSoJUAZTYQfbXrjuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhGPoCZDxkdizW4EsgNctzcqOhBkfVHwDOH/SfmHrunWiqPoth9ADMQWzkp/pYX3C8ZV/hG8fTDOqeD5p10zJ2WZ9j9za/laq5Nbzh50vksiUIDEi2Xjh+P9EWTuwjTaLJE20W2G3DuFtw3Mdt+AFwOHm8ZYN/B1FfTYVrC5wvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBKi7S2J; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBKi7S2J"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37cae998401so319936a91.0
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 03:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781778455; x=1782383255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YPROmYOJkFlruTcYwHv/tQODxhuQZzZiMpxK1bmtHI=;
        b=nBKi7S2JnHf9qWA2ogAf7bARxqe8vkZ9l05IpKpNTqbUfEbLDobNBJYVj18Fga5XUP
         CHUpHm0GmGvAw4/71tzqngVnl1jQdXHR3p2H5NDFfYDKujp6rS7MFa+7EgsBT0+Npo3L
         WrfxGSGo37C+e0OrCnfxYkARjLBsVL9fAbAwj7hcOf6rCm7s6x+ST10flzqBkMyMdzUQ
         D5rhrsnr4kVknUiTXwGHBG6XdqXe6rP+njGZYei5Cn70/JkFUchQDVzRQZHxoZhdLD23
         S0LRd5rskp/yTh9ZZSBYIw+vV7Qvi/LAXd4lvE/3HoLvBvXUlVpvdL+a+OXU7RHcl6xk
         ROog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781778455; x=1782383255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2YPROmYOJkFlruTcYwHv/tQODxhuQZzZiMpxK1bmtHI=;
        b=S4QzvhK8idLO0j2Eih5fppl1sGM8EJsot3Z2mvmnl6O7W/mjh2d0vSBmrVKH1Oxv/J
         A75/SJkTOzUQo7TcXMxX+FXJgvmceCel7TlfQCHzWEroUOm2lo3n7tI242UX63MMlbzB
         6BHSG0HPlYiiNgdWyNIkk0KiCZUU+eqo4q9q42nwSYNC9oWxk+BGYlRe2zvFRwA8aAK4
         vL3TLy2uLVEJQExDtc8wiQbqhtSG5X/Xsvk42iZ45+MpQTUXB+osTqdHditNiHLJDORG
         lE1HsqQFhVnW2kmsLbryo0D7CnZbQKTJWfosRAl1/Yf3T7i++77jRIY7ken+kQMIgEIf
         o35w==
X-Forwarded-Encrypted: i=1; AFNElJ9kz1vZTFpHsmRNMsYMSEbBNn32fTHcKGUEt4Esh0ZV25nLoew4EYKVXhDEm9okydgR5jg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt1i22eAjyguzFu5PLl989Bn+Ww9McD6tDs51fug+LDblWqSrx
	6V77lgsKMObcns4vhDWytkX7lhX3QUJ5zfSO/VFs673WxFaBNcXTYOcU
X-Gm-Gg: AfdE7cn2CdMcbKzxpdKdNo12Ga/1SVtwSxUv/M49fGN3+WDpTAASFdY6Ck1V43jHlFy
	+UZL0wLebPqBhsVyvrCejR3n1BtTib2jWNB8rQV82zAKJa51fe2pepXLh2kmmpBcaRI+VCg74ZE
	XvS06zjtQQkwk0SA40D+ve/0HaaUcp9azDAkAyINUe5S6YUEQtE/InpMliVSzhED3XbYTFx8+EP
	3nwwr8EFhagTOfUyZs5hewAupUrA+qMTy3AZ9O+3k1H48mldoRlgelWJ2w/bwXrN0kbBIrynkRM
	kTe9uy07SJCZEefqU+qOhndnIZVlX8z+z8D6u4C1I5FEue9CJm7YjRRo661w6Fyhs0sR1T/x56k
	NSaO80cWalTyDLVlsRnWNN3Qb+PkRIrBrgSf+LcLnRWng2nVTUj6INdxo7036EnBPMwRZMiRZ+Z
	L3h3GVYgjlTeZGCQx6dBCijz8AQ73R43KWhxuxRn278wg0B11H+R0=
X-Received: by 2002:a17:90b:4acf:b0:368:5367:d679 with SMTP id 98e67ed59e1d1-37c930d593emr8144920a91.9.1781778455023;
        Thu, 18 Jun 2026 03:27:35 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521cac5bsm8997512a91.5.2026.06.18.03.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 03:27:34 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@gmail.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v3 1/2] bpf, sockmap: fix use-after-free when the stream parser resizes the skb
Date: Thu, 18 Jun 2026 10:27:07 +0000
Message-ID: <20260618102718.2331468-2-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618102718.2331468-1-rhkrqnwk98@gmail.com>
References: <20260618102718.2331468-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sk_psock_strp_parse() runs the BPF_PROG_TYPE_SK_SKB stream-parser program
to find the length of the next message. strparser assembles a message out
of several received skbs by chaining them onto the head's frag_list and
recording where to append the next one in strp->skb_nextp:

	*strp->skb_nextp = skb;
	strp->skb_nextp = &skb->next;

and then calls the parser on the head:

	len = (*strp->cb.parse_msg)(strp, head);

The parser is only meant to inspect the skb, but the program may call
bpf_skb_change_tail() -- or the sibling bpf_skb_pull_data(),
bpf_skb_change_head(), bpf_skb_adjust_room(), all allowed for SK_SKB.
Once the head carries a frag_list these go

	... -> skb_ensure_writable -> pskb_may_pull -> __pskb_pull_tail

and __pskb_pull_tail() frees the frag_list skbs that strparser still
tracks through skb_nextp:

	while ((list = skb_shinfo(skb)->frag_list) != insp) {
		skb_shinfo(skb)->frag_list = list->next;
		consume_skb(list);
	}

strp->skb_nextp now points into a freed sk_buff. The next segment of
the same message arrives in __strp_recv(), which links it with
*strp->skb_nextp = skb, an 8-byte write into the freed skb. The free
and the write happen in different __strp_recv() calls, so the message
has to span at least three segments before it triggers.

  BUG: KASAN: slab-use-after-free in __strp_recv+0x447/0xda0
  Write of size 8 at addr ffff88810db86140 by task repro/349

  Call Trace:
   <IRQ>
   __strp_recv+0x447/0xda0
   __tcp_read_sock+0x13d/0x590
   tcp_bpf_strp_read_sock+0x195/0x320
   strp_data_ready+0x267/0x340
   sk_psock_strp_data_ready+0x1ce/0x350
   tcp_data_queue+0x1364/0x2fd0
   tcp_rcv_established+0xe07/0x1640
   [...]

  Allocated by task 349:
   skb_clone+0x17b/0x210
   __strp_recv+0x2c3/0xda0
   __tcp_read_sock+0x13d/0x590
   [...]

  Freed by task 349:
   kmem_cache_free+0x150/0x570
   __pskb_pull_tail+0x57b/0xc20
   skb_ensure_writable+0x236/0x260
   __bpf_skb_change_tail+0x1d4/0x590
   sk_skb_change_tail+0x2a/0x40
   bpf_prog_1b285dcd6c41373e+0x27/0x30
   bpf_prog_run_pin_on_cpu+0xf3/0x260
   sk_psock_strp_parse+0x118/0x1e0
   __strp_recv+0x4f6/0xda0
   [...]

The same resize also leaves the head's length inconsistent with its
frags, so a later __pskb_pull_tail() can instead hit the
BUG_ON(skb_copy_bits(...)) in net/core/skbuff.c.

A stream parser is only meant to measure the next message, not to modify
the packet. Reject a parser whose program can change packet data
(prog->aux->changes_pkt_data) at attach time. The check is shared by
sock_map_prog_update() and sock_map_link_update_prog(), which between them
cover prog attach, link create and link update. Verdict programs are
unaffected and may still modify the skb.

Fixes: 8a31db561566 ("bpf: add access to sock fields and pkt data from sk_skb programs")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/core/sock_map.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 99e3789492a0..c60ba6d292f9 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1515,6 +1515,17 @@ static int sock_map_prog_link_lookup(struct bpf_map *map, struct bpf_prog ***ppr
 	return 0;
 }
 
+static int sock_map_prog_attach_check(enum bpf_attach_type attach_type,
+				      struct bpf_prog *prog)
+{
+	/* A stream parser must not modify the skb, only measure it. */
+	if (prog && attach_type == BPF_SK_SKB_STREAM_PARSER &&
+	    prog->aux->changes_pkt_data)
+		return -EINVAL;
+
+	return 0;
+}
+
 /* Handle the following four cases:
  * prog_attach: prog != NULL, old == NULL, link == NULL
  * prog_detach: prog == NULL, old != NULL, link == NULL
@@ -1533,6 +1544,10 @@ static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
 	if (ret)
 		return ret;
 
+	ret = sock_map_prog_attach_check(which, prog);
+	if (ret)
+		return ret;
+
 	/* for prog_attach/prog_detach/link_attach, return error if a bpf_link
 	 * exists for that prog.
 	 */
@@ -1776,6 +1791,11 @@ static int sock_map_link_update_prog(struct bpf_link *link,
 		ret = -EINVAL;
 		goto out;
 	}
+
+	ret = sock_map_prog_attach_check(link->attach_type, prog);
+	if (ret)
+		goto out;
+
 	if (!sockmap_link->map) {
 		ret = -ENOLINK;
 		goto out;
-- 
2.43.0

