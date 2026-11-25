Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577629;
	b=v8sGx78LFYJ/SKdETJvkoEmTG6SV9AlXrAyvOImnGjDr5BYc5n+qrXWDpbcP6CZGCwwm
	 dCenTXgeAQ3AqP/p8Vbbg+mUUoPMMBgBfWRjppIozdde7vCKGDn2Fm0XQlm0q4h+GK2hI
	 1TkhWwvcFhft19QYyROTFoOlc+et+rH57Y48YwE3Csi8KPrlC8bBiYRIC8PNfWii5ZnuX
	 WYVqk/rR8XssIwRwi8J9PzY/xXdwbk2rIr3hM8MWzqL7Qn0dJWd25hsj2XckIR3M0Yv5D
	 gEIFm8q07iEwCUq+nWZQhDpurJu2pGpQRT3d26X6hqV8PqXmuc+o6oDdccL2T6XGXdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aJmBh1sMPPK5/LSn+ZacQ/Z6Krzf1/w8C9N4rRJM5WA=;
	b=2rLhcD2/zIVYh00TAckgcvtl27659vb0/wS71uzm6Zpstuvu7QrhbqEYbFgHPM0Z8vrH
	 XvkXI64r0eVxEzAgVvZcRFeouVkTYfFKFUjzLRe/6E62M7FLZP4QJNMyOQASfQIPZ4AvH
	 BnD18ZPMeRh9DNB6aYCNL2X4x5bSC1NmK1hJfpamPY04lXkemNxU9kAiKyyf0lk5XxbDn
	 C0AQYdz7MXRW1lzLyUrgjlF1u5m0nmiOk7CQ83HTKuscGmTN7bqSPaP0Xe54vjdrObHHY
	 T+j5AXVao94cEu/zS9KpN87DViyAgnIo3qoaCsl56iNTRY5yXon5Cv8wBiqpKy4mVbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="D/xVcqXw";
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4253606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4253606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D/xVcqXw
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2f04bea9a93so45970015ad.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577628; x=1796182428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aJmBh1sMPPK5/LSn+ZacQ/Z6Krzf1/w8C9N4rRJM5WA=;
        b=D/xVcqXwYpqQhuOL3mtsTPdGmiB5cMrGD/dJyfHO9r7zWSkw+xbG4RKN44zdgn+Ol5
         1XWMmBRyx2rVU7/cRMYzA91pvqnZWeISzTXF/cjLnsqL2cXqgZR86HNAuwxkZDL1fmvH
         vIAKD7haNe/r30gHdCaAq17HpsbRmDr3aHLQuJMdg+joA56UY/R2o/nYclWkL4u/K04+
         vVWRWb88McvBi/6ZSNapDQtr+aOnIzP0I4eGOKWAdJ9AQpDUXT4vd5cz1wOg4g5Kzci+
         IGzVWm42oAU8s/YAjY+JpWiT/H9gtPeqdkQl2TCVJ4ONJVVURKt+fqK+WexLtlfvnVrh
         7jfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577628; x=1796182428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aJmBh1sMPPK5/LSn+ZacQ/Z6Krzf1/w8C9N4rRJM5WA=;
        b=dx48kT/9PPkcvBooU43ra+XTYDVVIrxmImRkTAmezVGBYuKTv+7jfAW+/F61l/Jtk7
         4cjViQeO9Y9Cpw3UBFsZzzpzrxFIhAjJP/LmONi5FrkwmKhatb+wxWrE75NGQQleyf5N
         EiZYROrkNY+kO+Y/cv6T672xfRX+oOG0gJFKhQcifUtaYd63Kt9lsbLz00N78aVg7tcg
         EWb2+pHVwgAXG5iZcdpKP6FjwaSOiVO52Qkp7Q8UM3NPPnQPoh4TfYaXn8YYddWyJA6y
         E4PWNTPhimE6hoydqCyeS//wsYUvA6pCoSbGFrP2rBdU55GPgZQOMsWSUgfPM+HelURk
         f1+Q==
X-Gm-Message-State: APuU4Z+1UPo3wsiYzLiKDIcEhz0B4tdjKWwHVjQOhMaE+o4p9SQSOn9s
	wvh1c3B2M7LQKQHxLB6HqKQXRZtsX9ot9DolrSDJYRVfPQIOzggpAx8lIt37miQ8
X-Gm-Gg: AZFdTZclfmRm3/JcMbn1D4C8KZbT3RmbaTEdS3nVi7zqtECEdqYJwWJcLeKt9Mb4xLN
	o3YdcOBRHWFJQYQLqaJLVhAr1bxhcRYOwpnU707ungrHt3R+rr7/QlWU40tIHnRFO4+WFH+ncSx
	xs2bX64TQRrw8grVGdvMHvoFMreSvo5aR06P9pdq+FyFjFsBwiq8Wzklp3+AofeO3m78Q1B4zKg
	olVblt8tWeWqMqkM3LvqZFRz1ikTOXfO5+7uz+ts4TPrl1c04+LQXj0+PT9e150jpxgoqUOJc+n
	tjsrNzwBIjT8AHFoX2o+ELwVlgYJoT1YeoCNmowyvAvCIGWxJDTLzGDIbYsNrH23x+oS046hYkx
	Wl3MjlXqbME+0XOgZCmS2oKK9PscBFEdFH4rIBLWt4R2kqK493zY2oqHWSuCeLQgQ4y2jCgSANL
	T24gXsyIgk7dIKOB/O83AnXdjOW7TqGBwcZqd4wcidiAHI7Z+BCmlq0Jn7wdJyQUPLKZOimwzk5
	BFtaHq9XL04+9kSfle8MCHzocTCHGYKeSXK/OUm+hiX1jY9rt8wgwIK46kBjoJthkPNI7OxRKNL
	BQ2Ey2USnrM3aSWh/PDEcKOydcKD7FexZNhzCAgpz0h3rgKRcZvLlO2AiKSDCUAncexSkpJzbJp
	IrxE3riatRMQvBro2EUN9paAg0UhuDNTFq6wuQxFw9BxY82pPrA+Iv0t9/3dV25ktfxOLyh35Iw
	==
X-Received: by 2002:a17:903:2f87:b0:2ef:df75:337b with SMTP id d9443c01a7336-2f03f246f17mr169370905ad.48.1795577628048;
        Tue, 24 Nov 2026 19:33:48 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f0667679d8sm59082945ad.48.2026.11.24.19.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:33:47 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 42/47] bpf: Take a neighbour of the L3 master in bpf_redirect_neigh()
Date: Wed, 25 Nov 2026 03:29:33 +0000
Message-ID: <20261125032938.670542-43-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

bpf_redirect_neigh() takes the neighbour from the route, the skb gets
the device that the program has named. They are not always the same for
IPv4, and the queue of a neighbour is purged with its own device only.

When a L3 master was named take a neighbour of that device, as IPv6
does. Its driver drops the header and routes the packet, one entry does
for all.

Fixes: ba452c9e996d ("bpf: Fix bpf_redirect_neigh helper api to support supplying nexthop")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index eb6aeabb410e..8d331802a7db 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2367,7 +2367,11 @@ static int bpf_out_neigh_v4(struct net *net, struct sk_buff *skb,
 	}
 
 	rcu_read_lock();
-	if (!nh) {
+	if (!nh && netif_is_l3_master(dev)) {
+		/* The route leads to another device, this one looks it up again */
+		skb_dst_drop(skb);
+		neigh = ip_neigh_gw4(dev, htonl(INADDR_ANY));
+	} else if (!nh) {
 		struct rtable *rt = skb_rtable(skb);
 
 		neigh = ip_neigh_for_gw(rt, skb, &is_v6gw);
-- 
2.55.0

