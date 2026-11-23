Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438148;
	b=BmZFeO/sYlsU1WO5O3J6hTGDBuPjSEApNopr9gFZvGD1MaJWHe+aVYN4JF48/NoGY4U4
	 2omRGTB6+qjN+8GSvphV+45twsaY1RuSwjW28eoxVPqAVQAdTmd8hpVUx55I6t7eK+KmT
	 CedadkxWSgI3z3xydLOkFs2WYIfag5x0fH9APtE/b9BfVwu2SQ8K9xBP6E/nn8XDyJU4W
	 Qx5RKlxCIvmjZ9IJ7oRHq7GsOHFK+bdifXYP3TJLNAQKA/5WDKkyelkqK4zPpHngW/rKO
	 l1INscixCfTY/APGIzF7Iw4gvrqAO4xQOTDH6m4OmEt26PSt680edSn4AqrjfOUobTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nAlv3xeWLjPkzwFkSmSMhDw5Up084r6SQ9sON5hrIy4=;
	b=3rZCWRGAFqLeOGm1O+qvQsGWjctP2Lr0rbz9LvtrX9fNc4A+7HYbVsw4HUMfVxxPUnHX
	 3hoJRKBgWeWdOrBGTkdvuzBf8RVcNRTcg8QJlU9MCA68/Wt3KZCBCpavdsR2zcI9HPeCg
	 v9hlDWPQCCpdgBiSUHu+kHva+1Ml3htDzxjjqcP5m3wdFzgjSrnB9gTNt/yzjfZUX3ZYy
	 HLUFompUPnmEiAVLvjPlVDFGR3+yVuxnHZHmGY6iPzygVFTOrswmw+GJ71O5DhcfLHbfY
	 HzcK0d1G1JYtnHG6gSWvLJ6wZU9ShKhIf2kdkhCkUz/JvDnNwZi8DuZ5Wr6hFvtUFIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c5EMtvW4;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F3E606A33C
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 12:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62F3E606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c5EMtvW4
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4a7b8abe209so2481737f8f.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 04:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795438147; x=1796042947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nAlv3xeWLjPkzwFkSmSMhDw5Up084r6SQ9sON5hrIy4=;
        b=c5EMtvW4sGHt8pybLjUkbqUlFj/76F7yzHS9ZmTPCmDx0+IY931gi6AXMTpDgQtwji
         R14tAlW4QidV7Ywp9bnWDnGD4DxEkYLtmhdJtJtC9MudsJ/wwerJfU+nZTpeksQ7HZeV
         KWe60KKocXkp5k+Xoi5ZALptMcCHOcat5RRbR8ZUDno0D7BgE2NPWSkGX9fxuxmCjM8j
         bknZga9sKk31kJJZ0ZYir3EPPSf/UHyxTHPyvJWNXIDBYRdnEgj8l6locMQg3HABf6aJ
         2JRkjF2zsrkOUBO+PkvcK72ElKqHaC6oJQ5DKMeMLLcznUclmToeV0ykE+s/+QdH1RHW
         2mIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795438147; x=1796042947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nAlv3xeWLjPkzwFkSmSMhDw5Up084r6SQ9sON5hrIy4=;
        b=T4xg16K1/6lYoUc05PeeJ8ValE3CSdyRhj+p4hX4uSCTwgXSvU5kPf6xnIUkQnVTwJ
         0viE2bXS930IQELh8XTDVrcQfnOHx9bC9vd2MxxBed4amaqhytF/guY1E1/px2Kvrsld
         KzQJiT5YzjUjkj5Zmcl/yn9oY2wXFJHXFDT+qUxzjVPGV7MFG9P8Swook/DMZSXwbkDa
         mi3HRJX7n8Gs8f2kCv/yzKrWttp/RZvSE5tpF4cV6pjkuP9KpjL7x/pbKEs0R+BpF6Fg
         JRdgfuXkdVu3N8R9hPhQZxTF5xCD71XaytS+mcoFkvdkhnyjVcWHFSi9O+MIDJNKyPPQ
         lSHA==
X-Forwarded-Encrypted: i=1; AL+hErE2/JmPXCAYQTq5imF9yBlNgkF6AuVU1OeDNvkN1roVnJZftdL8WpxgAGhDD3T2kTFsHcw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8OZNLNaqTzQGRo+sdfL/NOyz9iPyQza+MNX26LASkXybxy2mfB
	i6UsWd7okKjdx8CvofF5E0cqWmiC+dWCdOHqj7ZE0gQsZKJLK/7YEvX1
X-Gm-Gg: AZFdTZcYpY56jwvEbE/jSy2aCuuBRAt5W0gwkiXM6RFLAi0MjvgXRzr+4Qp14CRKp1+
	052/pMw6MaZ/FBk+5aj8vC7t9EYe5V4w6QaNdfBJIXJTTq5KYVn2o6qRU9cMiHNIGrRX1IjtgUR
	n6LVMvomMEBnJJNJgLgq8azgX7+vCtqtwn2OnVTpeYm9pe2xaQdsBKEUk+GbvLSaYZ6uqu8jdwx
	bxnPGsCGxuvUdLqv5G4Hj4A5wPc/RupXqbdYfN7ug3Kr/bwKz4PzP+GRbtbQJLuVZH7AQbBVTu/
	tT91fcUHeKAHk0Lp4wIvm+QVIBzN+ZcW16ndAQDY0bYgE3j/jVSfjMM3lfSLxoupaOe5ijHpMR8
	XNgDdp7AdU4mTMt1Wi56HKSz11IXSEfETkNJW5UwbbtN5uT1kmvr/rqdZx/y+PF5IEcmoT5na6o
	/YLS8LZzjbI0usdqszWMJtknO8LyOaRMcKmgxgNmduUv06vSMvjLABIFIwNm0sNj7dmShMC4LQH
	QvLWp97tNL/0f1wLvj9YryXeTsPqimmVAre4f/tygQY7W58tNGpJ92Tz9JbT9+LODIkENOObTUM
	G5u7syOG+96I7d+KpQa37KI0OBWvedWFvobzRHE=
X-Received: by 2002:a05:600c:674f:b0:4bb:7e4e:de69 with SMTP id 5b1f17b1804b1-4bb88814c37mr228817315e9.20.1795438146683;
        Mon, 23 Nov 2026 04:49:06 -0800 (PST)
Received: from Philipp-PC ([91.227.186.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906817ccsm165097045e9.5.2026.11.23.04.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 04:49:06 -0800 (PST)
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
Subject: [PATCH net v2 1/5] vmxnet3: clear rx_ctx.skb after a data ring XDP verdict
Date: Mon, 23 Nov 2026 15:48:51 +0300
Message-ID: <20261123124855.1021-2-filzador@gmail.com>
X-Mailer: git-send-email 2.56.0.windows.4
In-Reply-To: <20261123124855.1021-1-filzador@gmail.com>
References: <20261123124855.1021-1-filzador@gmail.com>
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

