Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795593196;
	b=qtn+0mNFcoqEAUqfe88P0Kxp2c5k695UcoQYqHbc9biTArc5JaFTaC7tQtHPcyVGvLAn
	 PGUbSFRLVdU9WoNnkqPTSY/8PLucqskzagVqGnV0V/NjW2KMHYVZxNQd49dTbbtsQs179
	 yXav0vj39ROFRJ6wpd+W7FLFXcDIXQh8MUxGM9b6C2z41TodthJ0b5paNDoCYY2/3NcNF
	 jNZJXD++ftNPyg1ZnD5S0U9oVz1sXdt7ds9blDirke0Xo8u/hOAVadLl9F+X7p2wqtXXO
	 PPXkOh+smOdHq/Ll3e+1ZHsh5hy0qlQYYgIcrlp5kaKnSFe300hzeRmHOiAlOrGL0xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Q1IQ8dR9rtLk1ZtkiFmjTbNWLoeDxqEYrwfomHq3uus=;
	b=CNCrwy0HTM3934xnXFGwKumy6Y0IHJSxUAD9YJMe/O11DNvg5KNVul6hXmt55IynQF32
	 KqQpRs5SH5SYuzCXLQ3eLpYb/nuGyaTRrvQjZumipCRll2eHIVpwHkC38x8bRMKKKmGFZ
	 3gMVHfMeIJG/gRr3qFOR2S1aumiziy1CeOHfo5GwtUuMwGJ2/rHFzbM5Gpb01lWfKw226
	 py6dnl5n+hRkFiWEwpjFluM2dB8eo4yHLIFyqPp9Bp7dzyZLZEzuoVqpZna5P/uJ0/PlZ
	 m5J7DkebNBcmn4xA4JbMVW3fSOAoXpJGz8IxpxzN5DzpR5AeGSN3o8FWW6zKpBT0+EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aQ7slzrm;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BC6606A32A
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 07:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11BC6606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aQ7slzrm
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49d05d51553so38740185e9.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 23:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795593194; x=1796197994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q1IQ8dR9rtLk1ZtkiFmjTbNWLoeDxqEYrwfomHq3uus=;
        b=aQ7slzrmMgaVPl8aVrgz2der8OplBkcNJfyrDRWxBHbvyGh7rnDwZHkQxnXqw+4hOa
         Y2ZZPEb3+cfR5h0L+etqDB00UeFouGwsPzKJPxbZojc/HGtsCsUC6ebTZI6s0FOQ/HwH
         YGu84sKCL4ub9CvUgrrjr5jn5IthDMMTfB1nPOv/r0HD+lHCa9U9n1asxbl4opWJXgYg
         YFsKJth1YyFpi8RFFgLppP9QwVrIDc0fTbYmwsAaxPXu0MaMgVbrk9G3xPSPKTzuHn9Z
         wrr7kvhZx+a2RJ1/covHQMmI81/yyGdyzlez4uZ7rUptOET08o6swyAgFyd9Yp/4U/pq
         DqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795593194; x=1796197994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q1IQ8dR9rtLk1ZtkiFmjTbNWLoeDxqEYrwfomHq3uus=;
        b=dCEmXr5AGRsxIKqud+NXCQCggH4JrFcPqtBILj4ATGO15iegwSirmx4lXynhmSwajt
         YwKkgSxipp787hOeL1tih4UMHSAtBxrck9eTZlVeBFlbWQzOfX7Z6+0uCV3pCej2j3iu
         5+dS5h//e4X359njetCk47dDqG2zvB8jM44z2yv0PUS8APcaY4pl3CiZ0Xdu2TpOJKrO
         okTZD2Gzj0dLTGMUZdR/ZUxTGqRDspDV0gWAbVNWAUifUCi1TuEN4H2oRydNbFQtomub
         ltykDkWVAjwZRwE2DgriQf6IBsXggFj1TsT0pBDUfC83hqYwONxV2Bfvzpdvw7xIEjaO
         7YOg==
X-Forwarded-Encrypted: i=1; AL+hErENJX8pGnmaUmDPRd6J6jxPtmsGB4WaPBI/i5AjfWc1jUNtetoUGotiaGcg0P+wYBLG0is=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7Mg02THyrf/dSbcRozZfsX8xOpAt2znhpC8zv6iLA87+GKMxF
	T4FWU/CUxrKUR0VKLVCFyyRnAAaPiO3HZH9diu12H2HWv13a88e+7Isn
X-Gm-Gg: AZFdTZfdsob1RrKC7Zt5Desp44pQhV1F/y947npfJbX5WUA+uCJ8JMQ0HHdEfQO538l
	vzN3lXPSc7vUPerSfcFm2kxEFwvtRW4iua9CCZdXYv0dkMiag9tibivNruv7gTbVVaxMQlw7iuM
	Z0+tK4V4G1kpZl1Wxw+23qzy1rJxqtp9WXEYKT2xve67znlPDkZcgQIJcrUOn7D72fegTvi9T5W
	ugYkA4Ybr+va8m01jNS8R+IcnCztnPw52AG9v3sbM8uWmR2R7wnowoVdHupBnrlNKMvPReng6+E
	TIkomfPra8RUrxTqznq4X9SBueEPelS8CvOgm60ZPfn5aLWzgV/i3Me5mlBH2t9jUVGVvQdo7pn
	qc5+flKdxqwOwflTTEjNJeCC+6zrB9hXZpQdrTGCDWPOeQRGZd/uWSTR3tGwiMzigrCIe51LNGe
	HWLSMJW+HUa2mrygyFNDTUq2HwrTjfUJOOW7O9VFrK5QhUsqkLUWWxDa/j+FK7fprEDu4cSUyHo
	uTvPDKr/daGCvvfThpne7hGSbpiDah7f+Tt9DIk9wAN7l46pxaD7b0xUJ8NfRWVL3WP5ExdcFzW
	0+fp4IKwHU5Fwru7NulAh9hm8mP9Iag2zlIVj0A=
X-Received: by 2002:a05:600c:3547:b0:4a2:a6e:80f5 with SMTP id 5b1f17b1804b1-4bb888098bfmr344058795e9.11.1795593194321;
        Tue, 24 Nov 2026 23:53:14 -0800 (PST)
Received: from Philipp-PC ([91.227.186.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a680483sm33001138f8f.28.2026.11.24.23.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:53:14 -0800 (PST)
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
Subject: [PATCH net v3 3/5] vmxnet3: limit the XDP MTU to the rx head buffer size
Date: Wed, 25 Nov 2026 10:52:53 +0300
Message-ID: <20261125075255.1517-4-filzador@gmail.com>
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

With XDP, rx ring 0 head buffers are page_pool pages, but the length
given to the device is skb_buf_size, which vmxnet3_adjust_rx_ring_size()
caps at VMXNET3_MAX_SKB_BUF_SIZE (3072). VMXNET3_XDP_MAX_MTU only
accounts for the page size, about 3494 on x86_64 with 4K pages.

With an MTU between 3051 and VMXNET3_XDP_MAX_MTU, a full-sized frame
does not fit the head buffer and the device splits it over a head and
a body descriptor. Such completions take the skb path with a page in
rbi->skb, which crashes the guest; see the next patch for the details.

Cap VMXNET3_XDP_MAX_MTU at VMXNET3_MAX_SKB_BUF_SIZE -
VMXNET3_MAX_ETH_HDR_SIZE, so that up to that MTU skb_buf_size is
MTU + VMXNET3_MAX_ETH_HDR_SIZE and a frame of MTU plus Ethernet and
VLAN headers fits the head buffer.

The problem was found and analysed, and this patch drafted, with the
help of an AI coding assistant. It was reported by an automated review
of an earlier version of this series.

Fixes: 54f00cce1178 ("vmxnet3: Add XDP support.")
Signed-off-by: Philipp Sudakas <filzador@gmail.com>
---
 drivers/net/vmxnet3/vmxnet3_xdp.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_xdp.h b/drivers/net/vmxnet3/vmxnet3_xdp.h
index f9d843e..8b69af3 100644
--- a/drivers/net/vmxnet3/vmxnet3_xdp.h
+++ b/drivers/net/vmxnet3/vmxnet3_xdp.h
@@ -20,8 +20,14 @@
 #define VMXNET3_XDP_RX_OFFSET	VMXNET3_XDP_HEADROOM
 #define VMXNET3_XDP_MAX_FRSIZE	(PAGE_SIZE - VMXNET3_XDP_HEADROOM - \
 				 VMXNET3_XDP_RX_TAILROOM)
-#define VMXNET3_XDP_MAX_MTU	(VMXNET3_XDP_MAX_FRSIZE - ETH_HLEN - \
-				 2 * VLAN_HLEN - ETH_FCS_LEN)
+/* A frame must also fit the rx head buffer, at most
+ * VMXNET3_MAX_SKB_BUF_SIZE bytes (see vmxnet3_adjust_rx_ring_size()).
+ */
+#define VMXNET3_XDP_MAX_MTU	min_t(unsigned int, \
+				      VMXNET3_XDP_MAX_FRSIZE - ETH_HLEN - \
+				      2 * VLAN_HLEN - ETH_FCS_LEN, \
+				      VMXNET3_MAX_SKB_BUF_SIZE - \
+				      VMXNET3_MAX_ETH_HDR_SIZE)
 
 int vmxnet3_xdp(struct net_device *netdev, struct netdev_bpf *bpf);
 int vmxnet3_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
-- 
2.47.3

