Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AB63B47F0
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 07:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781162004; cv=none; b=MEd7Tv2zVdlpgUwqy2QVmtNF6Y2jycPC4cCVG+jBMkfWuklaPrMuThj+9hrqPC8aX4XPurwYXys8Rt8quuLFHmpRy8QhhDoz/JsY781GM4V1h0BXJTVWr40FNE/+dOk8XBteGibkbOwIYTX79y2/Cam+Xl06813ZSxhNntTVYgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781162004; c=relaxed/simple;
	bh=xIYuk1b0GTpsWcIVIg4zf/5vOm0XAhvVbZrtDZjApvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tA7UwIkAuhLnLl3uBkKuDc6dNtxpPAUkHtmfQ5+Ko0+oR6DL+UeB2BJ+8DAmdX/ptQClGnOnmeCOXsLnKQK7uZ2TdLj71jRE/j4IFJABrDv5NGZykN9FKBdRZxJkiIEjFUmJu7Bh15CYmucUqXHJjtohOKH03+c90/5A9EuhXXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rP2XE2nN; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rP2XE2nN"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-7e8b45dfb3dso90698807b3.3
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 00:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781162002; x=1781766802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuaK5tAXGNz9SIgM947GwEn0x65wr34XvqFUv1VfkTw=;
        b=rP2XE2nNNIpSmnn4vFxfD4LMIHZS0abPdZ0L4g3Tkeke9KscuClA6wAVgFMkFIAIY9
         BBhExw75qxfusLQtX3KHmEbLhlL9O8BN/qrR9hYtE9PDzIQEJDqbCJrPuKYejbraEktr
         kEgMHlcqv1/cIHdKBaO1D11jVkSwkRwB5dt+sZopL/FNAEkOuErXX0Zx6plgHZkR/ozW
         KEAgkaWwf0pJY1JA/Qtyd3p8HoZh2cyUXW5NWiP8aTtYLQwEIpVhkrkghUXcgDyC4Dak
         jlEkAafdzCaPU/Bl97W3ZhxxJ1VQWD5qVBJ8a4jjNFKWpreZN7aoxCwTwJPVDZuHViOv
         4RVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781162002; x=1781766802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KuaK5tAXGNz9SIgM947GwEn0x65wr34XvqFUv1VfkTw=;
        b=C6f/Fn0AQpSzgaEkFJ1Gmb+gZdRQ6FWp3JlK4cIuUAeuYWd7AsUsXraxPkAHeeOn6B
         BTEVRmW2HtMyNL7CW+FqM5ZRJdMarzrJrZwQ7O5UgKUHirsvShYeas0eNoiyiZabZlf4
         jK8Vzrn2UULZCKGvup+i2vHn4CGQ9o1jLkmwKOHTM0jx1zTuPIYzb8hr5C+buO9wZ7wj
         eosE/QgswU+2wyd89lduFttbaPeHrI6lxnBEYrulvsYFucK9UBJkN+JCZV6TnZV0AB/7
         tML3fGeYZhrpAXY2DgVFk2u+kKl3yChqcQulU1hSIoevcx/awsPStezPq1nzhfX8D3ra
         XcAA==
X-Forwarded-Encrypted: i=1; AFNElJ+zFnzKsJ0DPNbxzsnb815tSu5/8pdngc8XoWAhAGY0b1eNUtvZyXULoE8kv/Sp5u28C7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNaK2D6hcl9Bmt22OqhC6FNbvkNaOWo4XulVp4AZmYyKRA22zM
	dp9Nw9JRvisDV43B+w4YAbN7HKIYOU2nf0Z0TURwICTUIJGdn+2dSAGO
X-Gm-Gg: Acq92OHS2nWowTLwk9+24aZ2hrgXhHLqFX82iFD/sIDd89X4AGQjY/+WqCZDKK1GJ1i
	4Wma+3VSM3Ob6V0FamZQGUYKIcfBEd0tnZqXdaDR7TdK/2Qomt4Uw6GTvaCAw3QPJirM/9i/dUo
	iCwcfjVvXgrBYNis9oXgDkeRDv7v04X7tsifz2H1tbXEU51eb3d3kz8i3gKNo5tA8m1K8F48vLK
	b77nqhO/mFb7cJhP9mqSOEChg+ONqf+xlZenGmlyMIg89+HkJPKSy/1xitFePpmjVzkqB2BnSs7
	te1+1HxvhoY7wy7gJYVI8Mo+EXvR8M63hX/9iVsOQUR65FYEz2fNspVaOQnljRMnU8K+K/sNu07
	6BFoTT3hI7lZvZZORKDLf1jP0XOYvrZGm7P1dZFEb/jkpwy94rkXklP/bdESNKk7+ti5BxcvzvV
	t+OhozAxS1UumKv7TikGqfCA9r+nXb5jY3qlAMne+FY2toHJBs6gU=
X-Received: by 2002:a05:690c:6b83:b0:7bf:55b:8f97 with SMTP id 00721157ae682-7f6561dc497mr17405317b3.14.1781162001681;
        Thu, 11 Jun 2026 00:13:21 -0700 (PDT)
Received: from localhost.localdomain ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7f693504701sm2551487b3.15.2026.06.11.00.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:13:21 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: dongml2@chinatelecom.cn
To: jasowang@redhat.com
Cc: mst@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bjorn@kernel.org,
	kerneljasonxing@gmail.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next 2/3] virtio_net: initialize napi.tx_napi in virtnet_alloc_queues()
Date: Thu, 11 Jun 2026 15:12:41 +0800
Message-ID: <20260611071242.2485058-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
References: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <dongml2@chinatelecom.cn>

Ininialize the tx_napi for the rx queue, which will allow us get the tx
napi from the rx napi.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/virtio_net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 86b5c1ca568c..d72c124c9760 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6543,6 +6543,7 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 					 virtnet_poll_tx,
 					 napi_tx ? napi_weight : 0);
 
+		vi->rq[i].napi.tx_napi = &vi->sq[i].napi;
 		sg_init_table(vi->rq[i].sg, ARRAY_SIZE(vi->rq[i].sg));
 		ewma_pkt_len_init(&vi->rq[i].mrg_avg_pkt_len);
 		sg_init_table(vi->sq[i].sg, ARRAY_SIZE(vi->sq[i].sg));
-- 
2.54.0

