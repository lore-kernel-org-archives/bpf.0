Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CFD2749ED
	for <bpf@vger.kernel.org>; Sat,  4 Apr 2026 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775315120; cv=none; b=hE6Y3Ljr/b8qq9Djx2jaTDztybaxFQDDJIxrw27DNrWE8f1kGcb8weyEoTOr0qCDVSa+jXY2cIo1UNAA4BUvubDyc/p217R1cH3Jok3Uw52ooCkfhG3DGIYlZAwMmcOAluri/CUeITQ4i/4xrURuC3jCBc6RdT80Icpw3csM6ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775315120; c=relaxed/simple;
	bh=FtKTq7Q2omV5L6dMEgKtQrlVoRSKqix2q+h2ljhis6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FyXM1EhhcYw9d8r3htwNHfByTbEUT5ERgQMt0Dd7hPkyjHjgCx3hoN+lNeTpcjFUc4WgGW8cs1CHEV7K3MUWo7hpX9itX3aUNRJcdHsdaqLdB2DVv5tOR8gGgNomlNK7kbOD68isrXjOc5aktoY5bhK46mFCiQhTF9msZhK9OsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGK1kybz; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGK1kybz"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c76b994f7a8so1128278a12.3
        for <bpf@vger.kernel.org>; Sat, 04 Apr 2026 08:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775315118; x=1775919918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ien+mM5l9GTSiQaCM6QFkP9RFuVj/1ho/sT8zyGGYM4=;
        b=nGK1kybzBfoofYK7NIBmQCwbuL7Z+MdRJTo1kzrx6edJPCarhFjgQ+Y4KSfRvvoWLX
         r3CT0Xtfu57ac1ttOv6/iKk5z4f3b+VRrdZ4yZ7EjaaNrwrgA6Nvzsni4E11F/T9PSh3
         RkoYekk43g3psoyvZftGMGNg3U68waGo2DAT0evDXl5cOhoJ82XgsSi0bbnPNl1ytWBD
         40YJPDp+c8nwmg1PN74V8Ry+hxkUng9sAa7M8v9wkp6YRnOiw5klq9WmFlrdgAX1WXaa
         4EMvmC5GY1GZv0puYTVGaWHedVLzZFmzpi3U8FYpdOqg68Rb/265HAPTtozcrjHEJB0B
         LGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775315118; x=1775919918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ien+mM5l9GTSiQaCM6QFkP9RFuVj/1ho/sT8zyGGYM4=;
        b=afKhsMmAwFAH4AlYzRn3NEzaWTtCP/owMuczmXNd0hHDkFOagLRhHJQfs/jfmBJ4rf
         8L69TkRwxwHi6pwvSYkCAKQ6C7DY2F4OrTYJ+r1pK5OUdQe7yatLoiRbi9VaVRh0YVRU
         Fr6O1Fzt6lgG1SuuHRhuPs99RSEwc11gRDALtcGr+ECLPvV1fTDhnr3CBayasBcWSMkj
         cs26pZ7f7u0Ae9XtrgmC5F8MNc8xwOz7EiHGOyXr6wgD1rROUFY3k6Y8XeNxNJRvjBj3
         ogoLkOC8LPgzyR6n8XTULPXmM3BWcRgmiJB+ZnFNSAjdt3YjSGeAVrr0G4UjJXb7uJvh
         UU0w==
X-Forwarded-Encrypted: i=1; AJvYcCVvnOhJlrpC9X9x0LMjIPJ2AmPnEdsD7oCE8ejZTIBTmiztw+pzEbAHKFiBQt+2GIF83EI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo/IXGFZ29vN1vXw59yjfCRZXxZQEnjIQzfesUQPR4M7/sEUtH
	r92s+fxdbUO/IXfZ96rQrJE9SXK6+5yTYC9FXGyhquHLw5kEAhiMsgWT
X-Gm-Gg: AeBDieuuOAuVvSHuXwpPyQIM0d6J8NYmRSmllq4O2YZkn+XzznlHNjhFJot8yQQLGpj
	8hCiKearJGQ3YXggTkLEk59ezwvk8Gfot2d3MHTXZROD8SK64IjxX5bf0E6D3U3lqYswJuMpTEC
	0N7IoAQU1wuLzy0hQxpNCUxg3oTW25oFotJkydGFhoyiszT/efCauGgX2CSZ9NWxQuoMSlgZjIz
	jGRSsk4CPXVdeIa3q+1Oeqcle4Aza5z0jMGpLlkzbFziFsFxApeOEcnDxuh0PXJZhHvm6iIFDOt
	xjprCwpj6OBNOAqPP8r6BvT3zVBg0JRf+3NVCnlouAedWjTo9JYFEg3O1gdjGXfOZyrNoh4gG9Z
	cpDJgTiRAyHW9RDyFk8Qcr8yRJL2BQiogh1CurJuR1AqCw2siBnXqmeeUVkh89PabgB1rOB38wS
	sa52S3AMHlJjmW33LjXpq3hWcwGDhMbv6LCKs7/uyoJc8gCojdw6Ps1yAqHMk=
X-Received: by 2002:a05:6a20:431a:b0:39b:ae5c:164d with SMTP id adf61e73a8af0-39f2eda9e97mr7034068637.4.1775315118410;
        Sat, 04 Apr 2026 08:05:18 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([121.25.96.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65935cbsm8051444a12.26.2026.04.04.08.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 08:05:17 -0700 (PDT)
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
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 4/4] bpf-timestamp: complete tracing the skb from each push in sendmsg
Date: Sat,  4 Apr 2026 23:04:52 +0800
Message-Id: <20260404150452.83904-5-kerneljasonxing@gmail.com>
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

The patch is the 2/2 part of push-level granularity feature.

Prior to the patch, BPF timestamping cannot cover this case.
Here is how we reproduce in theory:
1) in the first round, __tcp_push_pending_frames() or tcp_push() kicks
   the stack to transfer the skb.
2) in the second round, problems like skb_copy_to_page_nocache() that
   returns with err code.
3) it jumps into 'do_error" label and then 'out' label.
4) at this point, there is no single skb staying in the write queue
5) the end of sendmsg

Monitor these two push functions with the previous one to complete
the conversion from send-level granularity to push-level granularity.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 7d030a11d004..43fa8329a5ad 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1392,9 +1392,12 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 
 		if (forced_push(tp)) {
 			tcp_mark_push(tp, skb);
+			tcp_bpf_tx_timestamp(sk);
 			__tcp_push_pending_frames(sk, mss_now, TCP_NAGLE_PUSH);
-		} else if (skb == tcp_send_head(sk))
+		} else if (skb == tcp_send_head(sk)) {
+			tcp_bpf_tx_timestamp(sk);
 			tcp_push_one(sk, mss_now);
+		}
 		continue;
 
 wait_for_space:
-- 
2.41.3

