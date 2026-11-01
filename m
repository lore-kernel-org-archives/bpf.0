Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560064;
	b=sWhAeDbLS3ZTf9IREQhKUir2c08GUS9yoYC+WwgNzfsLetHSYxZzV/rxEHHrtYD2NUBR
	 xaqjx+86bXWr/GFUl586f7rhqv5z1PG0ek07/H1o3tx9ovVvdBnhhqtmy9+MTGc2YbRkq
	 DPh66ZPkfXHIYt0usNoqNXDiOXU5jG037GMPaklp4w3uyYogzce73g92LZuE/7Wh5lJg9
	 eSOxdh4zcK9yIX2kSt+JbSEQ3wFhnRh/pihuUjP4oR3cvwIUKHv9iZF9lWQOUtRBN+H2F
	 qz48iXkO44KGpN1WtOXAgJHmpmG/oqcPEPN1cf3KS8g+ZnlFrGe6McY+JQkf0g94EWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZgZmF6ifIE+ZtaYXSxZjzkmrnsEmQscLQoq/49MFZJI=;
	b=BTnihjMEqR/5wcCcogKVJjA6DoGIA9HOUUdxhDEVx05alH4fPrSvxmmGxp3lrXBEu6kl
	 PMesRFVuC2m329OkX12eeYI3VD0/zbvKD8+ZDcDQ2nxTM+c9GISTqbz6YRgIC0wqC8vbq
	 FpQBfFJ8J/4LXPo1Qkr3wy1G4sGLpUK3hGbUkIGGkWj3qKkvR4m9s/FSklxsM+ESJeEi6
	 o8KkI5P9NEyNT5p6Nve3ExDfUjXu7vuKMZcTmln/IBCO7aFcywhRqmJJ32aL5iCXnnm6D
	 JmV34av9aCbQBuDqfhh21JUOW4RNfXN5rRQ7LDQ84nC56etSx39XkjY6fRg0aP6b52g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BRi1UBCF;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAA2606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABAA2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BRi1UBCF
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso1051347a91.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560063; x=1794164863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZgZmF6ifIE+ZtaYXSxZjzkmrnsEmQscLQoq/49MFZJI=;
        b=BRi1UBCFrDcjvb2wc6EK5Ls3JHlXdmWWLJwhRMbJOz7WLvUojOFM9FtRxrXNERcmkA
         UP+IlF1MrVOcnwrUTP8L2+hO63c/tvGj/xUOMgu+KeDc9xDFQzDxYAK2ahr6kTjHRLkJ
         dpaCmFwZNaUqS6oYMUW2m714dJ4aaiMHoiNHLBrsBdkkyz+9yBZ2Enc+FSksGvTgMTJb
         NmN9LVRjFvWakaYdlDzxCKGoHIB8ia6NlqMJ7Xr02pKXuu3gUJZATydiFnoFXXE3Xs7D
         PXYDAmI7+XUDRvOL81V0f4xtcD3Q8lX9jgtbGK7/7nYURUlZYLtsAKQS13Vk6U8r9Jup
         zWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560063; x=1794164863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZgZmF6ifIE+ZtaYXSxZjzkmrnsEmQscLQoq/49MFZJI=;
        b=G3Q3ROxXHNZ2qDBUhHmRDbzXF5fi9pZmxZm43QfipKxpjKrgTBLRFllPvdrNE3q7gz
         9O0EGUKGR2szrgazyZHVgfhqDcgFl5zm02xyKksE7BYzTbh/LEY/GM2vEbdbbzoKZHsn
         uKBOfNd9CcmwR+Fhv4Gb0qr08A5vKT3iShDH4REy92+yOa4NGfYAB16opJRuSdPn7Zw2
         bkHkZhzkxOloWaUi+xKgMcMOihQ0xLqB+b9pY2pYlC4dngBWWOwCoWMW255Dc6d2+kTP
         chfWnmIFwNPAE3Bx7txPSbTvuZeKMDYt42p+rkIOn1qGVIcFd0cEo0VYQ0oL4jirZrVG
         QvuA==
X-Gm-Message-State: APuU4Z/Bx1uUBNWd1J8f58bqYWvGbIKfyEDVc22MgBQ0wWQTYjpvR0Uj
	v3IOn76QznXRBGQWKnxn2sjLL4d91mHSh9IAv8issxh0r0Tshoxc9/+CzluVPQ==
X-Gm-Gg: AYBFou28PaVFXXvndrQ5fZRd1EpGCbpNdSkbuOX9qQdcF2UU35sWgy33fyyUHtJ7QSh
	8LzysXq3d8bJBzv3DhfXAK/t17/AB49Fwy6XV4OPErYjDsV8aOAlO8A7lV3l5KuVAfxFexeh5H8
	8HPKVgxzCPJXLGeRjK6DAVHrrkzKq66YJGW6eIjJyT/OPD3wEZpt+bDSiADXtXaOejSG/7DsT4p
	AwYdqv/daZKv4tH/Ar6kREot4jRjmI9QSOyGk3/SHSMRecdj4eqcf3ywNCWeJgkoh0oUvD9IB6m
	Kgv+khn5JKH/AKwjxYNdcbTLgm34EIpi40h8Q7yDIqXPCPYy0r9wT68sVLYklgMFIXsBQzIERkC
	GAjoK2UxXfcMUOxgxfmD1wUxj2kwQcro8TEZnjMZlVdMEkO+h/Z3K+ShMPRNTDw9xiSMgZR6QK7
	ZTQdsrEdo8ColNGYcuPiYA4wC5uYmN5fVnDx/y4zx/4EZagtpUcPeK76QHwpW0AYT5qDtsQohRe
	20KSb+atf9WTFXbccPu7QKnZa2dAQ2uccXv3f+8uIfDFl/S0py41D0dcJjIl56c8KjWaA36xcN3
	RGAaN6ALcup7jy+ig+8mbNlTTnGkdjCY99uwyiu7PqFcF/5AXSy1k3ymr9RS3mwnmsfN5FLCVJb
	EIBEJM36yLAM06qv9/1SyNbV2sdLr9c42A/VC5QJ0y9ztjdbMan2RCP7ZZpQBe67/qaPV92ZcW5
	bcrMs7CqHCrXqW06h8EC+6
X-Received: by 2002:a17:90a:e7c7:b0:3ab:c674:d83c with SMTP id 98e67ed59e1d1-3ae897b6956mr5882172a91.27.1793560063074;
        Sun, 01 Nov 2026 11:07:43 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845aa27esm10389402a91.11.2026.11.01.11.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:07:42 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf 21/27] bpf: Don't leave a stale MAC header in bpf_lwt_push_ip_encap()
Date: Sun,  1 Nov 2026 19:05:29 +0000
Message-ID: <20261101190535.1454146-22-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

With BPF_LWT_ENCAP_IP, bpf_lwt_push_encap() pushes a new IP header. The new
header overwrites the MAC header of a received skb. But skb->mac_header
continues to point to the same bytes. Code that reads the MAC header after
the push, for example netfilter, gets bytes of the new header.

  before the push                        | MAC header  | old IP | payload
                                         ^ mac_header  ^ network_header
  today                            | new header        | old IP | payload
                    network_header ^     ^ mac_header
  this patch, lwt_in | MAC header  | new header        | old IP | payload
                     ^ mac_header  ^ network_header
  this patch, lwt_xmit             | new header        | old IP | payload
                    network_header ^     mac_header is not set

For lwt_in, move the MAC header in front of the new header before the
memcpy(), as __seg6_do_srh_encap() does. skb_cow_head() already reserves
len + skb->mac_len bytes.

For lwt_xmit, the output path makes a new MAC header. Thus mark
skb->mac_header as not set. This is the state of a locally generated skb.

Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_push_encap")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/lwt_bpf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index da49364ec63d..b9270a08cc6d 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -649,6 +649,14 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
 	if (ingress)
 		skb_postpush_rcsum(skb, iph, len);
 	skb_reset_network_header(skb);
+	/*
+	 * The new header goes over the MAC header. On ingress move it first.
+	 * On egress the packet gets a new one, so forget the old one.
+	 */
+	if (ingress)
+		skb_mac_header_rebuild(skb);
+	else
+		skb_unset_mac_header(skb);
 	if (is_udp_tunnel) {
 		size_t iph_sz = ipv4 ? iph->ihl * 4 : sizeof(struct ipv6hdr);
 
-- 
2.55.0

