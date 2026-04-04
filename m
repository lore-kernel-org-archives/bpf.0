Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C12256C6D
	for <bpf@vger.kernel.org>; Sat,  4 Apr 2026 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775315112; cv=none; b=WAp0kecxnNpzkQXcr8piWpoNWZywazzhpPSyFtUqdygv1lKnxHVO2eYf5w8O7V8/KXnW7zE9T/HHN674WcSNOFrYjC0PMdVjhuZjhhsQo1kROhpQpNqfxBGByW1/Hl3widY/VRcYhz8+JFeKW+QWccBWBQWBuTdPWLSASrNPfj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775315112; c=relaxed/simple;
	bh=bYrHVBQsBbtA88DUctBOYp6xxbPGu6oj8k5S2ee+Ehw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jNS6jEd00M8mjDKxgYdFZ1/3+fBrKXzTJeubEozMQ+9buGb3Jh5kLbRzbVl1uD85GGG12pUOy+PCmcSFIeNyaAHqQyYxVItAjCeRQ4uew5z65XE1Y9iJlLhQ3JtidznO1CDa+zm2Fij392z7OPgtTB62KEIkQH+45s0VEqsrg10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/qQi5H2; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/qQi5H2"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c741692db4cso475234a12.1
        for <bpf@vger.kernel.org>; Sat, 04 Apr 2026 08:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775315110; x=1775919910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dd4IriQRr3URJKHO1DlzNK82MX6elt7bV+ds6H1WDVg=;
        b=D/qQi5H2jkKmyzccq3UKkAGW7QWosZOrDu6RBeHIha/277ZlV1wUl5ptn2ilzKKtI7
         R7HaTMRuEy23Ng5vLV3dmxm+jInl5khy5QI5VbK+8WH5TnITPxiJgmbmgUj9oXjdUozq
         QP46f8u/8LXFhmbNwlSqrmscB543u+nWUsAcn7nw94huZSkucWZPpvgM1RaTdKT9PYOk
         R+vBp1vm7OZfiYlU4wv5SI8joQsfWyXl/sT5RTsVdk/QsrcqKQN0SYEamDiI2EObv3jQ
         I0EcA1Zg31Aq2SEZERpmQZu0pINBBcn/BX548Yy+Z3xKBX0UPQZxLvrwOrqNtZ35DZXB
         +shQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775315110; x=1775919910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dd4IriQRr3URJKHO1DlzNK82MX6elt7bV+ds6H1WDVg=;
        b=Xj21DkyyHd5sRBFPWxuVU6v4206FIKd6V7a1Cd3EiyBAC/7foGjPUijVv9TIPlZcWU
         tGuKZ9U4gyGStq2eUkT1LtNYp+wjPO1TKBOnTAEdDinn9CUtG499F5zWyObXOCBDqeLu
         uN+XaOe9AzaYrZj8Kms7NHkwl15LPRz8VI56tDC5NVRw//hMdviP9+cNCozwSVEzRG+a
         68mc02FV4pGAY2fdarqLBBsRkTla4UTt2Pa4lzIXrCEnfqVaJjSvYC237hXRAuDcDPKa
         AlHq6TW30f4kC2jLbXDm570anoYPq6yzQHpzAtyfjhzTNkRZN2DyB1p9FsLADmLW8Wc0
         EU2w==
X-Forwarded-Encrypted: i=1; AJvYcCUcNDrkYjLYYEw/GpPTHnDq982bG5iC1a++k3JsBZrYSvcHlqaQMAAemxLz3k3us5amY2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPUh8kxFp8dEXIeMaPfCZuAKSGerWbYHdsor5Rfd8L9DfxjqNg
	taPGC9Fecl/xZ3hgccBYndhyG4AL58O8jBdFSH/OOWlvpNRUfpR4UWTp
X-Gm-Gg: AeBDiet/jQbO+7iI4zIKoKLIzCJSBkXkZLXNZltx+5eh4RKM6wc4rSg3j64YPxGhMh2
	CP52/B4dT+4HlG7t235r98O/UiERlHy7LIiM1/aZqKomnFWfYiwiQGLb8oYxf5LNfl1diDCNM1j
	KPbfrSNOas/uuhJaK/6205/BHz+whTBoXHl7tQ9iaRI2wZvMRB3m/wxfsVmAxqxPVjQBBEbd6kY
	M5/qwQEK1N4jekuqZbC+yguns1s6uPp8nMANaNKdpJ3HNCWma0awJr4M7xOHXxmaPFiNqxKIKHW
	Tl1+TYOE1gZ6/tdmbYYQK505k8syPqnHHRcfsxRWSW1x4byLioEkAS14cc2RKKI6Yg2kzFzvqpd
	yfO7uemQGNNTQ5PSvRCeRJyuUAIYAU/x+Pl+lAwPSDif4gLl/qdo2VvbKq/Y+kfktl81NMdmhy/
	UfdtGjaluoUIO6IILf7iGX0jO28VN7Gd6kIunzr+tRlwQ1huZ9ABQxR0fCSG/C1bkKjsyDSA==
X-Received: by 2002:a05:6a20:a122:b0:398:7daf:6d7e with SMTP id adf61e73a8af0-39f2d9e755dmr5860907637.17.1775315110112;
        Sat, 04 Apr 2026 08:05:10 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([121.25.96.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65935cbsm8051444a12.26.2026.04.04.08.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 08:05:09 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	martin.lau@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	Yushan Zhou <katrinzhou@tencent.com>
Subject: [PATCH net-next v2 2/4] tcp: advance the tsflags check to save cycles
Date: Sat,  4 Apr 2026 23:04:50 +0800
Message-Id: <20260404150452.83904-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260404150452.83904-1-kerneljasonxing@gmail.com>
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Check the tsflags first to see if the socket timestamping is enabled.
If so, then try to fetch the last skb from either write queue or
retransmission queue.

Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 169c3fff4f6d..c603b90057f6 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -484,13 +484,14 @@ void tcp_init_sock(struct sock *sk)
 
 static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 {
-	struct sk_buff *skb = tcp_write_queue_tail(sk);
 	u32 tsflags = sockc->tsflags;
+	struct sk_buff *skb;
 
-	if (unlikely(!skb))
-		skb = skb_rb_last(&sk->tcp_rtx_queue);
+	if (!tsflags)
+		return;
 
-	if (tsflags && skb) {
+	skb = tcp_write_queue_tail(sk) ? : skb_rb_last(&sk->tcp_rtx_queue);
+	if (skb) {
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 		struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
 
-- 
2.41.3

