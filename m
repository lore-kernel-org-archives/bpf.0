Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794861990;
	b=xHl5idJGLroJzKuXwcilipBGTtvzI2zalfP7+fKeuNB9svN4MbEbtIWppRyoKxfxN0ws
	 Gfk6x5+b20htu3oMetCHe/S0ZBoqHtXDwqQm1xUoxMfVNxdtq6kqptposjFwujPnCc6cw
	 nt8AajsRg3b7djZrcJFlh1H+Ntcf5ec50bqiXifBT4uVrbMRnqG4tW6G0BWHqcO5YmMbp
	 kFfZ6sqLT1FzclFO9A8rl1jtjQf0qBCZIoD1vd8eqhpIxfBQjilzy8pVfzbKDrRzf1UDH
	 D7XasprBd/lCdbI6X8rLPdMtb6z449AwZR/UIFSkPV8MRSKw3aCTGs4s6FJpHYlTU6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794861990;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=8JYetNZ7DheLCOUJdiDwgn10I8Vfpkp5NSU3Bw4KcF8=;
	b=wxvWR7psLLce6BrMDWjqYsD4BqIedS433UG+/N00pW5kX/P+Vxyg7OlS4MYfDH0EYxwU
	 YZvliGHESGNTJ5K+bABztEZItoLEAPVTudVukcDFhT9Y5dtXBUYEqvLp9yKtggRymQgve
	 aZqmG8AGOyp4OTPj0GenS+KKabRt+dub+g6xQEhgRzeoi9A/9l2S6ltFFl8bSWz5nb/vY
	 W/1HL3z9zi7rHglnG8h5pOjxAoW1/1KEfquWXO6Hbm8AU7hC4d7QcqAHo9vqrMH0Qc8uk
	 CsnkZQ0kMlE/leJEKu6vYgs9iBP4dVGSlF8atacgTRAeYhGhTDVmhHw2Ok33HZQvJMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hckj8bbs;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA440606A322
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 20:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA440606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hckj8bbs
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b197cd42b0so2791056a91.2
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 12:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794861989; x=1795466789; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8JYetNZ7DheLCOUJdiDwgn10I8Vfpkp5NSU3Bw4KcF8=;
        b=hckj8bbsYR69OuJ0X7cChT8JyxeH6GKENi4lyX+/gX5Kpu7Sp8sojv46XAmFyGR4pW
         vaoM5SMWVpNj5VMKjSTPt1AIEHCHEKqNVtGzkNpWcXtqZDQOOVywb+VyQydHpUH3jQm3
         zn7TSBI91dLuyOizrg8Tz5eU9IYKMOZ9I1Dwr4/4TV/0K4PSWKgCExt0dQrbJNyKSgtB
         igCgIFhFlleysNhB5OTPPacuub2xJXz9KU98OnKQdloD7efNBOnv7i68lwJoJysh2Jk6
         n4oR3Oh/47F9ooTrcrguQhQw1b10nJuR0zGIm5NY2bmXF3YXcRMaw7pLu3Mj6j8+IWK4
         SBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794861989; x=1795466789;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8JYetNZ7DheLCOUJdiDwgn10I8Vfpkp5NSU3Bw4KcF8=;
        b=yknUQamQ3wYyuvsfUTDg+iXkhE3si2rsSfxAZCrc0E4Gr8L2C/L3+rHM+nJkqEQSZo
         rZkR+SUqL3BOhKbTtS5tze7J/gGD3F58TVwQqG7DWskILVh9IXU5OS79+87Gf2wVmuB5
         c6KHy/FSmqNMpvgw6YlsWLjx+k6nuz+qOACOK0h7BaX43AXTOjmoPHevkC2maieFnR3v
         +csjtDVT5U93QLpJEM+zK+Ra3n5E8vLseZpINeGxZB0Iu9xVU4OMdiL6e9dZp5FNmEqH
         fVlHygbwE+rV1FLl/rg2SYnvFjmLikOnPC81r9vbqgiowU5oMFMZ6nRJ0VflkC5UnkMH
         M0HA==
X-Forwarded-Encrypted: i=1; AL+hErEmMyZdx/T/VUvMixR4ZXav2lJP5MunQELd15GG/sX7f+8pkyIFP63IL+R4lXmAGFx4f8M=@vger.kernel.org
X-Gm-Message-State: APuU4Z9JZQKqUoHLQkpAj4ittjBjypWnSMqso9rd2ALqCF3IWx2se10F
	37tDmoBrC+UCsxIetk1uWJV9u3O4QXNlxEYsrZhZix9XtEEKerR2LEd1
X-Gm-Gg: AZFdTZfvMuJxZE82GhmTXIi3RxdiS5+1n2SyqGV7pyD3fiSLlx0qhSOC2tvVT8fXinm
	6KuGIuL2vfqP9ZtJ90dyrRfiktOKlHu08u4d2YijRNTy+rk4iWFQgqFxoZL5ffMBNgurwOZECMZ
	oQ0lrzssNaG9TJX3fBTLuEmrtJlmCFdOGzrxhL5bZkq7FjqUVnsP6XaHH88SSjqmDsDRWRUK7zG
	acYWyKd2YUis3cYcjai1ZQtRThj49GGajIqkCiSfODYbp6SdTg270vTTOa3x+1Se1jX2tBJje3z
	G3OIVcqp2uAV40oUWA0iph/co0Dng+lf9xV1ViNPlUTFoNCFSCBNMBPxOQe2Lu2VMy+EgrOs/QK
	v/bgzLi3z1RETzQrSUal/l6zU5jUdjVZOu3JuLRwIzTGbiKR/eGH3sFuWTcnXuEj2I+3TBZNtVI
	jNT/tNgERFAGV23tFhGWytzdXExBCBLkzD1ZnDrhRyaiWnZrAkdGJHhv+cJamrnYSYNhupklHh8
	s6xwEKo3EsTxluJiDiEsy/DHyHptJc3QKPo1AdfE7j0TT7wyVkxKivk0PkqscT6xi8AlWb7YpWy
	XuZHiNqZvnkmZBqRGG7Wg6dm3Dct3vHFIzod2vBX7LP/Sj4wSERtF2mNRj9Tn3KDlTvKIN4ycpg
	ntLpXheToT/f88CaF/U+2EChGkwVOd6Of2Q==
X-Received: by 2002:a17:90b:4d0b:b0:3ac:a7ee:678c with SMTP id 98e67ed59e1d1-3b1b07e41aemr11138946a91.2.1794861988884;
        Mon, 16 Nov 2026 12:46:28 -0800 (PST)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3abe8b263sm786352a91.13.2026.11.16.12.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 12:46:28 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 20:46:27 +0000
Message-Id: <DMWXH28YQDYH.1SI4Y5WQ7EPSR@gmail.com>
Subject: Re: [PATCH net-next v4 4/4] bpf: drop the stale dst when
 redirecting to an explicit nexthop
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jamal Hadi Salim" <jhs@mojatatu.com>, <netdev@vger.kernel.org>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 <bpf@vger.kernel.org>, "Jiri Pirko" <jiri@resnulli.us>, "Victor Nogueira"
 <victor@mojatatu.com>, "Sashiko" <sashiko-bot@kernel.org>
In-Reply-To: <CORE-9NOG.v4.r0.20261116135311-4@mojatatu.com>
References: <CORE-9NOG.v4.r0.20261116135311@mojatatu.com> <CORE-9NOG.v4.r0.20261116135311-4@mojatatu.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 16, 2026 at 11:01 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> The release goes through skb_dst_drop_keep_metadata(), so encapsulation
> parameters a route carries are handed over to a metadata dst instead of
> being lost, and a metadata dst already on the packet is left in place. Both
> wrappers take their existing drop path when that copy cannot be allocated,
> so a packet is never sent with the stale route.

Just briefly looked at it. skb_dst_drop_keep_metadata() with kmalloc()
in the fast path is really no go.

Why not do something like this instead of patches 2, 3 and 4 ?

diff --git a/net/core/filter.c b/net/core/filter.c
index 946b07a..13f2d57 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2470,6 +2470,10 @@ static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *dev,
 	skb_unset_mac_header(skb);
 	skb_reset_network_header(skb);

+	/* The route is for the old skb->dev. Keep the tunnel key. */
+	if (skb_valid_dst(skb))
+		skb_dst_drop(skb);
+
 	if (skb->protocol == htons(ETH_P_IP))
 		return __bpf_redirect_neigh_v4(skb, dev, nh);
 	else if (skb->protocol == htons(ETH_P_IPV6))
diff --git a/net/netfilter/nft_fwd_netdev.c b/net/netfilter/nft_fwd_netdev.c
index 7447da9..d1ac4eb 100644
--- a/net/netfilter/nft_fwd_netdev.c
+++ b/net/netfilter/nft_fwd_netdev.c
@@ -15,6 +15,7 @@
 #include <net/netfilter/nf_tables_offload.h>
 #include <net/netfilter/nf_dup_netdev.h>
 #include <net/netfilter/nf_recursion.h>
+#include <net/dst_metadata.h>
 #include <net/neighbour.h>
 #include <net/ip.h>

@@ -176,6 +177,9 @@ static void nft_fwd_neigh_eval(const struct nft_expr *expr,
 		}
 	}

+	/* The route is for the old skb->dev. Keep the tunnel template. */
+	if (skb_valid_dst(skb))
+		skb_dst_drop(skb);
 	skb->dev = dev;
 	skb_clear_tstamp(skb);


pw-bot: cr
