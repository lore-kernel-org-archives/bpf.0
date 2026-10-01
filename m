Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100D931F986
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 12:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856970; cv=none; b=i8D0uoboEisKA4JWXj32c/xpm+B/5vy1Fa0fQgUTAsOISn/Lg16CMCdwqgCo5NEEJkopB+hqCijabUPlWXtFrl7S5klPXkRhn20s+rdu8V7KY2kTaPM5qiSMQc9OKvivt2U69pxC5wf6/Y+mw1mbLi4gt8f7E7n8EHUjOtIC7aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856970; c=relaxed/simple;
	bh=4BLrtmzurW8UA6fVSeNeIt87jffuF6uA+vo/13A2Om0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eYe5/0bk7bPiN2ijOWNisc2mx1Qi/XUa7q0LpQNnKdaS9bg/j24XGnFLeyKBmh/lYQaSnwQScj1UDEmVYdohZEfIXPBD+9bVMcYb85IYX8h6+k48Bfw25NFB/7U+BZV7iAfPJ80XC3NBZXOnP6wTMDGDAnkXVUJmP+yrGKdDMlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9i5J00o; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9i5J00o"
Received: by mail-pj2-f38.google.com with SMTP id d9443c01a7336-2e2d58a3b05so21724065ad.0
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2026 05:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790856968; x=1791461768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IYDWZrZ8gM+j3CLV2m4lS/hjDIinyiJ4OzY5zDftFc8=;
        b=P9i5J00ob5YP6/Lw91kRYaskxWPp5+F73cSbLXenZS59Ltm+e41c7CEedK6ioqvK1P
         FrWzi4BKQI0xHy6bZ7JkH5WZHmQABiEDfYGVmqfbWeuK6GXbe3gJcaOy0A3jhqJHaTI5
         avW5CM9he2c4PYQJvYVVmjs8mpqNIbwM6nf5zQtUVl7GTjZ9oHPbxv54IsYl+LM3rIYo
         41I892hhxHw6EOShD//781Iw3Juy044fPMUM2Ud4UlKa0OeGWeqQGhfK7z8wkiNqIbiH
         jTWQBhbZGUjfj5rJqi7CxhINBe8Rh22i994181q8SD74DgaguIbuMHxi7NlMR+vcBz/D
         1PIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790856968; x=1791461768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IYDWZrZ8gM+j3CLV2m4lS/hjDIinyiJ4OzY5zDftFc8=;
        b=I71a9AHhElPon2oVF6SwMhlM7ifbXyUiOM6h9ZyrtUVdTxBu9LAK0zY8XEQ3vuG//u
         xn41DbS0eUZGdXfJEZRHN1mKtVgSsBuI0focQcJFXV1zNWIi4QduWlyqy3pSLHHWR/IQ
         kjl1yoZglaqFpW5BB/WejKwcZEwD2q/lSnqrwP0Vc6gFhOouZ56N1b7jYV374L77iFwU
         3jjdl8NciHJv3Q4L6Eb1nMZfqGdiSQpP9ENb8HJhOrO0o874YjtG3Nu4HwGUHdgiq4Sh
         5YSlZ35AwxA4pexHELko1NZJXPAHg5d3sGMQpZ9t4y0qoxixcpzEvID1JkrXiDSF0oYq
         wssg==
X-Forwarded-Encrypted: i=1; AKwUvBx061/SHDNOLkH9+1jeVPU8rXLRRnNB9eVOkVvaRzt4rY9nzF/rIIk+0uEGEHhYrI61jYQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKyqmMY3Dd2R1oguIW8A2d4IAaJD/bycrVEQaBOAu0iGu+gzbsu
	2lGJB2oXJUnYGX4C2GuwmeXHJV/Hf6XyCfJWvAg7KTECgwYVF/dO75o4
X-Gm-Gg: AYBFou0Y/9Je5iZfjW93AxP0u3FfNgZDdke+G3xTqgB6iuCSBLn1ybf5mKG1vAhyiuw
	V8P5rY/6gVxA4GiHpEiOFQUHJeVXtAU++peUcFuOjBsQDi0UVkQl1JM63SPLmrS9NyTgWqK05ue
	PKWXCl0FUfvZAVyGLLwLVC6+6fC7AVfHz6QF1tvzgC+knlVGxYof2ks95cX3tnejnkHoPXiXd2F
	a6+Q4tEZdVvBaw/FPxv1lHkCYWyHfxvmxSdQdE6NiHW/QG+zpPRVBaYDF+nJ7b0iLLpEFnaDOFO
	zvGRH5L/k/yX1WlwxI04botj9p1SaJRk0HRZvmYjG6nrIa/Lv9tkQVaapIx3Z0MfBc8kA+98iRc
	j5sXFObi5KBw0yEk7GeoxCW7ywNYti7s5laONMMQFHQn3CqOIma+Tdbd0jtQmu/XVYaFUa6mn5W
	oCmdiIlK9V80yRMhHvPiHQvELBfhS/dFZDU9ohtLypUj/Tgrq43gYUrle2LeYbByR3QGUL3iM5M
	3tEEm/eLxQ=
X-Received: by 2002:a17:90a:fc47:b0:39e:2e7c:d43c with SMTP id 98e67ed59e1d1-3a4d102d65fmr3985879a91.7.1790856968300;
        Thu, 01 Oct 2026 05:16:08 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f43c8b02sm4352278a91.5.2026.10.01.05.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 05:16:07 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] vsock: account only unread bytes in read_skb()
Date: Thu,  1 Oct 2026 21:15:41 +0900
Message-ID: <20261001121541.2983379-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After a partial stream receive, rx_bytes tracks the unread suffix while
buf_used and peer credit still cover the whole packet.
virtio_transport_read_skb() dequeues that packet but passes pkt_len for
both counters, underflowing rx_bytes.

On a connected CID_LOCAL stream with an SK_SKB verdict, a 40-byte read
from a 100-byte packet made SIOCINQ report -40, an empty recv return
ELOOP, and poll report the empty socket readable.  After verdict detach,
receiving 40 bytes wrapped the counter to zero and hid those queued bytes
until one more byte arrived.  The fixed run kept the counter balanced
and exposed all queued data immediately.

Subtract only skb->len minus the VSOCK offset from rx_bytes.  Retain the
full packet length for buf_used and peer credit.

Fixes: 45ca7e9f0730 ("vsock/virtio: fix `rx_bytes` accounting for stream sockets")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index f225f53ed4bab..1e762a480df49 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1927,6 +1927,7 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
 	struct sock *sk = sk_vsock(vsk);
 	struct virtio_vsock_hdr *hdr;
 	struct sk_buff *skb;
+	u32 bytes_read;
 	u32 pkt_len;
 	int off = 0;
 	int err;
@@ -1946,7 +1947,8 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
 		vvs->msg_count--;
 
 	pkt_len = le32_to_cpu(hdr->len);
-	virtio_transport_dec_rx_pkt(vvs, pkt_len, pkt_len);
+	bytes_read = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset;
+	virtio_transport_dec_rx_pkt(vvs, bytes_read, pkt_len);
 	spin_unlock_bh(&vvs->rx_lock);
 
 	virtio_transport_send_credit_update(vsk);

base-commit: e23a64eb244356ee47c0620f0722d51bd88db522
-- 
2.55.0

