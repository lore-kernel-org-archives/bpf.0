Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795593191;
	b=SnAnC3ky66ansXVbQyaq0B46Yk2vNKLhzRUAor6sH2Ra6y8Q6IhOOULFnypAA3RukcCA
	 cg+PLVfoKgvlaANlBRhzOcNDup+bSc1hDpyvcv5DlovCbtm5fCSQxMjKXmXiyYpWeuP9m
	 bXyOnDRX1JSN2763BuluBozS5wbYxX2KS5tMCDBQUxH/tBlqlIMVT+Wm7+81oIoM5kVZO
	 yvGY3ZUU+2jWhIWDd/SkmT5aXY4Uq3FhRWGzo8B5YDgGvNSKDjFQxR8fmbtfxY0JEkR0D
	 5cpiuMOOBh+0MWcfUFRkj9PyC9N1ljTr8a83BI/CIKFGgfgThHg5Ln6Rz+uqpGLkxoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nAlv3xeWLjPkzwFkSmSMhDw5Up084r6SQ9sON5hrIy4=;
	b=MSzUUxjHOdRijjma9oRJU+2kN79pHqRJg7X+IJxFrZHTYv6psCz6HOSYwRtTV+y0nY6y
	 bXweGEEMbBKOn1IOuMjjBxhxPTiAENs/MyYvowLkx2NtVz+7QcOConrppZZ4yKED4pIXn
	 bEmH31LdJAubTEPNHQZbSC6cV6wYZ+OUMoZYR92NJi1DjHIlEVdRa+rAeHjWE8jowkeXX
	 QzEK4BAUhAdfAtz7+OXcJLFe9jRwvLnMd0yXQEmea2ZriTX2scozDXWYe5d6Q5MkiYtJq
	 SrspgSR+VL47XgloIoYaMwFy0Y29o014kmodU4tPR1LgxqWQQcUuSl2qHTZp0UQiADg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o+3hBtZX;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA0C606A338
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 07:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAA0C606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o+3hBtZX
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb85e07aadso66971895e9.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 23:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795593189; x=1796197989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nAlv3xeWLjPkzwFkSmSMhDw5Up084r6SQ9sON5hrIy4=;
        b=o+3hBtZX2n152doDdurhNK7m8sZN61nzua1l3ObMLghmRbiSkFchusywbfY07OxyoF
         iiY5qjUE1Kkjwki21Oq7Mh4vCsTV2c1nacahE70HrosyyeeGokZCHzwTE8W/cduePNE4
         7jTXqXt8Q56n8fec78d1Y60DXD1ruyymcI0ejJ6kGKFBKL5n4q5Lz+pFz+oIevG4CzDa
         v6eAOugLiITw2eRP6d9dCnh+lsrnnCAT4ufDIZx+kBeGbw/vDU+OB49P6WXSjpyee4IF
         7fju9aio5VZ3CKC1KLGAieis6n0zFlyQ8P7SAg3bD3nNs1jmS/Q5w16Y/X/iOroG9c9E
         I7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795593189; x=1796197989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nAlv3xeWLjPkzwFkSmSMhDw5Up084r6SQ9sON5hrIy4=;
        b=tHI9L4BH5eyIfMfqEooIy54HGOB6IQNkwJXAdiV8bvhscE0KT/7PDZK6/Hwoio3jrW
         JLbAGFVozQWJjRzk39sE7t3ojlr2ySmDhjaMD65Jdl9D52QQyklgMCyT8kt4bdyWIf+E
         SDLKvmOtKxjP7zrn5TSk9G6KWjImfbKuR0HOQAyl+yCl97fgPoW77KhHqFQ5jD3WNCjs
         itngjKFd9nClWk7V/m06BRGZ6vp45N6D+RoCshKb6y+PE6dxs5vXhbtUKGDXhVr+wngo
         aBd12t3nLm/B0+SuYxUwSWW8wJ7st2LClowtiJ4v/6pKqmjRqn9x9PbNrfCvH2kzHbHY
         5/WQ==
X-Forwarded-Encrypted: i=1; AL+hErHPFemsmIWcfCBs7Fe91s3JNGURUd8IOh7bcJBqxvLx8I1f93sXf08l29j2AydjkMC3MsQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+h0vP/gIKdZ/OZa254redJLIWwGJqPF/QtQ3ENstd1p5qywocq
	nUbqpCg2kiB6In2Z8zbopyyh9kchjnDCJZrL5sDEyCq35OO55IzuSI3Y
X-Gm-Gg: AZFdTZf1rTsIOmmGEM6aIWwBwEBsQ4Yyn9nJo/6nPWkg0R44ww88keubPJHelYmS7DX
	5uXYbsBP1gPrRCFBCdSoqM54wCCzfWZOkFtgG0P/FQoimP+OT/qm+pYljCummzH7pLu7UoYkH83
	iMUO5Ms+rlvdCRvXauoXganufK8ihXBPeQZ/K6ikRu6aBalyfSAhTfgoPbQSugaYOghbuimrAu+
	N6UyvKeYNaY1sc4AUMiMhdqBuBsVIgtBmsI5li2MJc+0ZIX7XQNw96km71aqU4b9YZHw6mZudly
	DExEW4O0HTbiBd2ljdIcZ44YIceEDlpLaYAOn8u7Bn6xKFX337X2p30IY3RgnyVjUp2r3+9MSpY
	HfYzsBhCshVXHZQw6YOb7Guo+36piQmgsDK+envcJnBXX/9sCh7uuT58h9qqmSDwsBhJxGn6LMb
	rkF5R6m18IQ13b7mHSc2PSzPWIZ1hk1MNnkqodb9laPAgFpU3VNEEOX1h2nuqW5mTXrLGN5JY7N
	pf5facXYuDj64W3tdarUK9cmeE5TK1wNtD3O7DNjXGMfpVxN0eXOMdVwManlS6pe+MJHm3J3WY/
	mPnC2JY2OcZNEXNx5+URaeuS9yQSuGl5M2B1+BVN
X-Received: by 2002:a05:600c:820c:b0:4bb:7987:fbbc with SMTP id 5b1f17b1804b1-4bb887c29b4mr303248805e9.1.1795593188856;
        Tue, 24 Nov 2026 23:53:08 -0800 (PST)
Received: from Philipp-PC ([91.227.186.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a680483sm33001138f8f.28.2026.11.24.23.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:53:08 -0800 (PST)
From: Philipp Sudakas <filzador@gmail.com>
To: ronak.doshi@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	u9012063@gmail.com,
	Philipp Sudakas <filzador@gmail.com>
Subject: [PATCH net v3 1/5] vmxnet3: clear rx_ctx.skb after a data ring XDP verdict
Date: Wed, 25 Nov 2026 10:52:51 +0300
Message-ID: <20261125075255.1517-2-filzador@gmail.com>
X-Mailer: git-send-email 2.56.0.windows.4
In-Reply-To: <20261125075255.1517-1-filzador@gmail.com>
References: <20261125075255.1517-1-filzador@gmail.com>
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

For a completion from the rx data ring, vmxnet3_rq_rx_complete() sets
ctx->skb = rbi->skb in the sop block before running XDP on the data
ring copy. With XDP enabled, the ring 0 head buffer is
VMXNET3_RX_BUF_XDP and that union member holds a page_pool page, not
an skb. On XDP_PASS ctx->skb is replaced with the new skb, but on any
other verdict, XDP_DROP included, it keeps the page pointer.

The stale value then belongs to no frame. If the next completion is a
single descriptor with rcd->err set, vmxnet3_rx_error() passes it to
dev_kfree_skb_irq(). The ring buffer XDP path already clears ctx->skb
after a non-PASS verdict; do the same here.

The problem was found and analysed, and this patch drafted, with the
help of an AI coding assistant. It was reported by an automated
review of an earlier version of this series.

Fixes: 54f00cce1178 ("vmxnet3: Add XDP support.")
Signed-off-by: Philipp Sudakas <filzador@gmail.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index f8df83f..e8be95c 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -1742,6 +1742,7 @@ skip_xdp:
 					ctx->skb = skb_xdp_pass;
 					goto sop_done;
 				}
+				ctx->skb = NULL;
 				need_flush |= act == XDP_REDIRECT;
 
 				goto rcd_done;
-- 
2.47.3

