Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776852;
	b=NC4Hjwom6CIyiaQa3YdUfX1dWG6pqLvG1Z9UCT11cRnTCrnyMmYdNV/Igea5n9NYjY7n
	 TMUunTkTOsFiLK51kxShb2kjXXvCmmUtq+BJ1+1zmEtDmzbwu8WCDWmhdqiVM0fm+2hp5
	 ZBGHWHNBLwSuCHS5vNgv0OP3rrg52rMujg0MRvAdR3+dnTuxtf3gssnTnkMs+xMnKyoj3
	 40sG7lTV17egAkM1j5+gnNNP4/1E1xego7V0WkHrf29jdGzmqlCRHIzj5Jv9DMSw0r2PC
	 H51ao4tVCleNrCldbFw/n8MDwF+NsT5acNg2SujWgbvme/hSD8e/rwlJvjCiNCGadlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6o6wwpsf6OkL2ZSFH1Jv+ohkliUZZst2ain93hx+srU=;
	b=f03S+kef3aSRgh53Vv36Htl3nJiFzGwVtbCdoluuiDeQBHpfhZp68KAhBWkHqXBsTTLQ
	 AyOOjvDSQxIJqSikqmlxkm+8gnNHbg4Vu6+/WB1ol4OmH0iYoSkddSAAq4qFw0FdYdJ8z
	 CKLZse5AzW0autP4W5aFCMHIhPQ7AsPoy8d15ni8chNN4/6pDCoclzragh6hd1KYkqYEa
	 bqTtpYHeYxvT+Mum5iRSupnglNVOCEmAyjZK4NN3XEtxV0Gsm31m7jPkK0/pWRe4lIvn7
	 Z9bW/iwZQ+VThWHG3gkeW7Yu1LEAauslnZF5rEDR9CyElusxpAgx61czRLYsIVmCkyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L0Z7gmyW;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FDC606A31F
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 10:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18FDC606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L0Z7gmyW
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b563e5cbc3so760435c88.0
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 02:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795776851; x=1796381651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6o6wwpsf6OkL2ZSFH1Jv+ohkliUZZst2ain93hx+srU=;
        b=L0Z7gmyWDD1NV0Rl0P5B5KEd730ZW3wJm61yeKjW2ZS6lcj0yg9gXasllzaa5OaXBH
         kQCRbmMazReS0eCAnld9Omnj3RA8Cr+q1QZgKdEwSVp291EoejBacQ3Ml/I2SQREA3PT
         ZmFbl6NF6QYBkFnR31lmaY9EjhDile36nYboZC+tM9Jz5tILRXbv8CYr4igILI/4IVOc
         ux+B37VoEia0Nybv2HEG/KgDjXMF0d4+7Hrwf6HGykRrJt+X0mS/H+p5KE1BPmmZyweC
         u31llk0wNY5vi/hg4ZMcDkZlQslu/wh/mspzJkdMn/XmxdGNxoGvp9PjDd/DdZruwEr5
         zjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795776851; x=1796381651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6o6wwpsf6OkL2ZSFH1Jv+ohkliUZZst2ain93hx+srU=;
        b=UHDRbIKWiEqS92O+EYb70Zugbg+c0njxtd34sp+W5g7sSUhfwAhTr/28IRrxaHx4sw
         8wbece+QTw/BCJgm86YSPTFToNWr9a+DDG36f1bk2chugi/t7S+AxM5tiigV/Hcw8yS8
         1Co9q0cITfLssmk88Wf+oXA5j7wG+X05R0FewhDcqmnN0wdXjVvAUqNlKoJtG5umwr6g
         SnHT1JYo+8YBh5tCeIR3A2hf19YhSXK4zHlv8pZqhYGhdFHFcEEEWqDO1k+p5AMJPUp3
         7g5nXCxGJRzh74+WYFKDjxUVxQh/1mcaLGXALPrK6/RD8UgV3SJ5HjwweQM2H3LBKSck
         lnkw==
X-Forwarded-Encrypted: i=1; AL+hErHwC7KhEzLz/r4kDNH16lP37oMwrRb+CjjisLVzZPKI0c3aWSX/v+Hs/APmVT9OEcrs0Dw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VoykPHgXsb5dVMC7oecJycl1ihxdbenQLGqklPUmfOa7okKXI
	cKYCzRTRnW92mKT8N8DMeyzp962u97XzZFfCpNsZjzvDuw0pyKGh+xBb
X-Gm-Gg: AZFdTZfe7AFHM9QSwKRnDpneDCIyC2F2u30KisPBa+udIjCqGn1az1BFDqjW9sRKF68
	WEEtMRCuBlacDbbA3hPDObapUychNGpvG6JX19myEdRifhCUozxUHyrlh0EdKfBUkiA+QdgBULw
	COMGO1+Kf7j2tucmwQtPTtTvwoDfwK5ClC3hfXPEiERYRntnDJq1pxU42O45rW6GnzO0IaKHuqP
	83flYS45naWYUxzxWAAkP5z/nEmw67IdgOiUOFs0NSB6JWmwqt6Z8O2Uzai8tUq6dYi50HgozIA
	l1U+8YLWKHKUoWrmdGVn4AA7qxtkLCB44u7Ud6sR5nZHbsABKQ5qYvyLZKuIESKovDoCI1wNGu9
	D3f2a/2Gq+4gm/ebBjHYDfw1Jl0b/y8bZTlrl48Lv2VbNOBTZzqcqv8EUXx45q+9Ysku0iBvFBX
	OHAm0feJQnxZ8GqTy8Xnbvr/A+w6uhsl47GlQ35AEtbUKV9k0fTTbqwqbtqcI+ElgJ0AP8sAKub
	X3O1q36NrJrXvYYNhZp69UJgIQwGPseoN07B/xtCzz7YASt5HrRV+z/hqeGkgrXFz4PI92JPxcA
	MtWDNSgUrQNE4c7WZyNhRwWTIFcU9cDIB/BG9XCsrORR3r/D2oaWMQEHtZm9WzGUl2Qjl2O7lKQ
	xf4ldpoDw+sNvyndIR26m5a9CaKhDcHz5N5CYPzMrn8NB9Z1ysfhfuCkoHXTljJjNFjxIDo8bnQ
	==
X-Received: by 2002:a05:701a:8459:20b0:1ab:90a8:87a2 with SMTP id a92af1059eb24-1b5524b0f73mr23088055c88.11.1795776851201;
        Fri, 27 Nov 2026 02:54:11 -0800 (PST)
Received: from localhost.localdomain ([38.114.108.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c1142sm54992326c88.2.2026.11.27.02.54.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Nov 2026 02:54:10 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: willemb@google.com,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	bjorn@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>,
	stable@vger.kernel.org,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net v2 1/2] net: reset the mac header in __dev_direct_xmit()
Date: Fri, 27 Nov 2026 18:53:46 +0800
Message-ID: <20261127105347.72997-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261127105347.72997-1-kerneljasonxing@gmail.com>
References: <20261127105347.72997-1-kerneljasonxing@gmail.com>
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

Compared to __dev_queue_xmit(), __dev_direct_xmit() is the only open
gate for skbs whose mac_header might not be initialized. A few months
ago commit c2707480cfbf ("net/packet: reset the MAC header on the
packet-socket transmit path") solves the case where AF_PACKET skb can
miss resetting mac header if a few conditions in packet_parse_headers()
are not satisified and it will cause out-of-bounds access.

Similarly, Petr reported an issue about AF_XDP path where copy mode
can also trigger the uninitialized mac header problem.

In reply to Petr's patch, Eric suggested to add the reset logic in a
general layer to stop future issues like this happening instead of
dealing with scattered cases one by one[1]. So anchor the mac header in
__dev_direct_xmit() exactly as __dev_queue_xmit() does, before
validate_xmit_skb_list() so that ndo_features_check() and the vlan helpers
see it too.

For callers that already reset the header the operation is idempotent.

[1]: https://lore.kernel.org/all/CANn89i+aacS2PfaMXnimzGgbCLz-JSnqo6QyoS122Gf+kxya3w@mail.gmail.com/

Fixes: 35fcde7f8deb ("xsk: support for Tx")
Cc: stable@vger.kernel.org
Reported-by: Petr Oros <poros@redhat.com>
Closes: https://lore.kernel.org/all/20260817153957.3177627-1-poros@redhat.com/
Suggested-by: Eric Dumazet <edumazet@kernel.org>
Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
1. this patch will be backported to stable branches to fix the xsk problem
   and will also be merged in net-next. In the -next branch, I'm going to
   follow Eric's thoughts to handle the mac_header 'issues' from the driver
   side, and then finally remove the guarantee (reseting mac header in the
   core stack layer) like this patch and that af_packet case.
2. this patch is also a prep for the second patch in the series.
---
 net/core/dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 3c58db732761..6ea2fd3506f7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5149,6 +5149,8 @@ int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
 		     !netif_carrier_ok(dev)))
 		goto drop;
 
+	skb_reset_mac_header(skb);
+
 	skb = validate_xmit_skb_list(skb, dev, &again);
 	if (skb != orig_skb)
 		goto drop;
-- 
2.43.7

