Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560081;
	b=VWPnK0kkB+UIuFipEGqTANSR6eiLPu8aY9BvxPLWmWqFzgPxJl+2rQepnPmTLgWg+hdD
	 bJY9qF7Myq3b1B+/zu/8OvH7PqrrVccGo3YsqD1sQJeRPEVPbY8/L4eYC4uxUq/5wlgiU
	 YYKbybuqGyTYsQxVKSH294C5FiRREjjrY2pmx/m+rhQ9TdPPfr2MtLaKhWc2ZpVa88Rsv
	 1QtrSaWGHfEb1gmwjaz4qUCyhuh5GhdsLKVnxJGmFOJ4QarU/dMhMpoPuOUhwEWQfcwE+
	 B8GF1Gf1AnQDCwH2G8CWeLHkhDXDDw1GPfGrODjihayGluV8oTZJW5QgTBKltfS5rew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560081;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+UOxuYBMkJ+wSapEqQUvRP4XzP1iFenzIi9awHoYZ+8=;
	b=REfPpjpw+H+oJTF1D0+F45RU33qLYZvFn1qZKfiOR+4B6qers0Tm4Q5Oa36BvDvuit9c
	 1kthG/vrtr/Ki1FPygGho9QKUW95VtQicZx5TO7UxlPYBnLgTG0h7rFyXsZwNq7t2ktwV
	 sNtqlKxgBLswxSSLjZsRpjb78oC61zWwH22B57ZyoYMp7og6OmHH+/NZOQI6bSIbZ1s5j
	 UfoGRQFd36snNYQKev8n2EX+nKabAdt92Mf00/qbV0fSiDUf3bx7t8O7N3BsmweR5dbW6
	 oD9uiGN5to3VZlE8BuFeCEMPA8t1mpBFOyEY2Xhx91MUHA4trW1wpClmohN7Tt7JRJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TSWOPSbd;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83447606A326
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83447606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TSWOPSbd
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e9eb579c0eso11531945ad.3
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560081; x=1794164881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+UOxuYBMkJ+wSapEqQUvRP4XzP1iFenzIi9awHoYZ+8=;
        b=TSWOPSbdw943B4xveMHSrS2H9Njgfua8KGoIZ4pFwaKbeL3qRuopZli7lLGKs+zscr
         AfRv//IAqKonjlPtuq2hr9OJLgAO+u5GWIuL8fhLyEoht2jXe06FzhU2ciK2BI0ifchT
         Su7i5kj7y9lJAXqhRiux5JMNbgAHltxseWkTva7x9k5mP3wbHI7FMVkgJwgOepRS+RAq
         ZhUbHVBTEdeXyCvoai4HBZbKjJBuQuGrrAtcoabaLVt0kJlvgmmnUanMmzIc6PBUeSak
         R33OcXvBfxl8WxM6IkXEHUGzTO+MXd0Dd0FIlWbdnDPjk9SpGZ9TcvKy+/gTD78I+lCc
         oDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560081; x=1794164881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+UOxuYBMkJ+wSapEqQUvRP4XzP1iFenzIi9awHoYZ+8=;
        b=a9GQxb0sfQJSC42aSb+o36cx9tiFJP0Sko1jDaTbnA3hJdB1MGYthnM21hqUnxF8Hx
         Lqa5Wltnf0XFd4XcJDQB5DhfyMu+cPkvYrkpgdXMCwHN/mfIVf1pQJPH1PsYPHJYAjjU
         AWznTG7gjBHstpMS2OPSoUmwBeafh9w/9OO4Tlt1JlF9pqxZIFTA62HNymuD7UlgpFPu
         3dCMV6fPf5mdABwWmuJS9N1LraEAvDObGZXwQrWlyn91puUXoW9/MatqM5yAi/Iiq0NG
         JmYqaLqbANkhjrxaOCqltQahGLEsgnZeh4OGTKRYwQ19BddxLtsmgA19ViXJg0rSMmO/
         WzVQ==
X-Gm-Message-State: APuU4Z9iEuP1UQBXee2I69kB4nSNXi/ousdJg6HXHJgTcippaE6QYRmV
	6DxPYWs0RlcaetUFFNKdOruY2hlZoamkbssNBAj7CD99MDV1rrTVNkcT0CuulQ==
X-Gm-Gg: AYBFou2T/tijDjspgLvN20KONZrSpAzMN3Yo/gnqIW9UFOVBLRql5m1PB4KGryZAqTd
	DVeECSqdeSn1ioGPY9CB7zOKHk5boFXAsvuXnL46L03SEWcOhsLDTH6BW+qIOms0m2aTwAgq69K
	4gZOrZZ0Efj8Y2tP5Zq7VlCsB1OsRFou0XTw8L7DYJvC0c2BuaktrpHTxk7w2RK1npwVTXsc5rf
	oOeTv3tzA/kJnuw9H2GDeMLrVH+emaTy3dKcJ0yYLiTsCEv5eN8ib+TSlf+35guyLKbADdsLwyY
	MuELH7hvzoyOLQsxCiuGkfG8vezNUE8LbTh+JcPqVTzxxy4LyBhRf1fwIwCof15r7vSTeCpsZF2
	w0G/1mS77QEIYivXkqvTWt78fWGIMtgqj6k9OmZSQIUT7fg7w+dAv2YMPM1tG2PkO77anQrY+We
	N0FPpAun4/7grc/Vl+PlhMYdcF0WqUdd95zilImzEVcWGWNTAw6Qjk2Vxix9YC1PjZp/NbAu+ra
	lBKCELEm4GhFTo9raMLmAOg9/VLw3z6DJg9eALnnpgzCoeW687yK71eOKTBEzsmdT/V6ZvYW4wL
	v4nKY+2BJ5pHHHeURRrfBBPz18lAgJpyyVt1/r/XVhGIxR62ShX4xKdOffKG+4yobdX99ko7Fgz
	tWZpjEFUkN8Y/Z8bOCtros2ImaEeCzab/sWRz/cwY3fKlZ3OHFhHLNUtOxwjgIOhpqJrNWTvbGA
	==
X-Received: by 2002:a17:90a:ec8e:b0:3ac:9599:a689 with SMTP id 98e67ed59e1d1-3ae897d5fc0mr5554678a91.34.1793560080773;
        Sun, 01 Nov 2026 11:08:00 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae87ee7765sm6826287a91.2.2026.11.01.11.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:08:00 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf 24/27] bpf: Don't let lwt_in progs call into IPv6 when it is disabled
Date: Sun,  1 Nov 2026 19:05:32 +0000
Message-ID: <20261101190535.1454146-25-alexei.starovoitov@gmail.com>
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

With ipv6.disable=1, inet6_init() returns before it registers any pernet
subsystem. Thus net->ipv6.devconf_all and net->ipv6.seg6_data stay NULL.
IS_ENABLED(CONFIG_IPV6) only says that the code is built in.
bpf_lwt_input_reroute() and bpf_push_seg6_encap() call into IPv6, but do
not test ipv6_mod_enabled(). An lwt_in prog also runs with ipv6.disable=1,
and skb->protocol == htons(ETH_P_IPV6) does not prove that IPv6 is enabled.
Thus the kernel dereferences NULL and crashes.

Return -EAFNOSUPPORT before these calls if ipv6_mod_enabled() is false.
BPF_LWT_REROUTE then drops an IPv6 skb. With IPv6 enabled nothing changes.

The first Fixes tag is for bpf_push_seg6_encap(), which never had this
test. The second tag is for bpf_lwt_input_reroute(). Until that commit it
used ipv6_stub, which returned -EAFNOSUPPORT with ipv6.disable=1.

Fixes: fe94cc290f53 ("bpf: Add IPv6 Segment Routing helpers")
Fixes: ad84b1eefe28 ("bpf: remove ipv6_bpf_stub completely and use direct function calls")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c  | 4 ++++
 net/core/lwt_bpf.c | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 482f8132d9ca..08168ea381c2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6924,6 +6924,10 @@ static int bpf_push_seg6_encap(struct sk_buff *skb, u32 type, void *hdr, u32 len
 	int err;
 	struct ipv6_sr_hdr *srh = (struct ipv6_sr_hdr *)hdr;
 
+	/* With ipv6.disable=1 the netns has no seg6 data and no IPv6 tables. */
+	if (!ipv6_mod_enabled())
+		return -EAFNOSUPPORT;
+
 	if (!seg6_validate_srh(srh, len, false))
 		return -EINVAL;
 
diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index 60f4eda7dae9..774fad4e9fbf 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -128,7 +128,7 @@ static int bpf_lwt_input_reroute(struct sk_buff *skb)
 		dev_put(dev);
 	} else if (skb->protocol == htons(ETH_P_IPV6)) {
 		skb_dst_drop(skb);
-		if (IS_ENABLED(CONFIG_IPV6)) {
+		if (ipv6_mod_enabled()) {
 			ip6_route_input(skb);
 			err = skb_dst(skb)->error;
 		} else {
-- 
2.55.0

