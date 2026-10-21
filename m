Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605933;
	b=Q9uuPc8WokdsjYj9amQnOo8MEUQOg9r3ULTYaBlQnhFb4M/tDHavTxf0mdaJwCMTGPH2
	 ETFkjt8kJaVf4h+Mk2t3nbh0re9AVYw7DkTepPhiyoB4+18R94+ukL/CUz7dZu9XJWQGr
	 j5/gSZ/SNKCwqDmsLf06NhpvAFJ/FSkCWBQ8/gF1oVT9AK7SOVmKdWjRTUyrEnRrHOeeZ
	 5yPcuh65h9Gd99gaow0JcTDKRUNjsSqWQTe6yRvRj8grIheY/HCpwjYCa9tDBdUo3fSLW
	 tHdFvVNVGDoOS9bK7HTIblw/fJZD5NHeHncXdvx2oB7hrCGe5mb+I15GBig2QzXwXtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605933;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DS+qpxy2NKuBUhINnKtH+4oZ3tQEN68OVLg0g7A1lmA=;
	b=dTvPh+lskDOYX2d5z6PTTkpFc0OwmJoztvs5rJxzo/bQv0SpRVDnz6ae0WDJI6FZUVh9
	 odhpjlfYkYDiG8xDoWgNNGbCBZVad44Riy7aZjwgScJrWXInovrw2Bbbu/kPpCdwotWT+
	 XJEbOKUOlDfx82p/KX602LBEgonq9cFJL9DigngAj80xDSCBSewd2BoVkLyg9K/h88RlU
	 nk1rGIVDnyjrqZOv1uWtbcKWZfMeLHWgvGkcBhS/RW71TSptL1jfFlthOvuQvfguOXpQe
	 HTFLtOS2GLpxfuDbYs34BNk6DshQu/km6GApYoTBjBDqiAxWtWiEVWrHQcuGP2AoImw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ii5B2VWq;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A7E606A331
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 18:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4A7E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ii5B2VWq
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1dfd49525so8271295e9.0
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 11:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792605931; x=1793210731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DS+qpxy2NKuBUhINnKtH+4oZ3tQEN68OVLg0g7A1lmA=;
        b=Ii5B2VWqfwQW5rzOGgccwN0tkdmw/e4rjES1c5Zo92Eo0X5gjyDyp5PY38u63ZPztE
         uVtGhuu47sjcZgNH1Wo/jaIgCeym6Ms8YT9fEnibOKNBnQRdevlo7AO9rtWlYUIJIsqy
         x7i9wy67Yb/MnMKsq9nAG0J+0gIMNOB1eaLKhYtLYHSlrhUXRxA3nZimCsJRByF1QNlY
         RsVQJBPzWToj8ihKGmpCfsecuceIY94Cex4ogp5ahaUKwiHB58wCl9xgJCQz+9Fzp1bC
         Fes9WVUmPxSIFuH27OMYhcrpYJGSU9mA91jOKK6lqOTpzSrK6eb7HK4i+tuWFf9fp5OT
         RGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605931; x=1793210731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DS+qpxy2NKuBUhINnKtH+4oZ3tQEN68OVLg0g7A1lmA=;
        b=Dpudm6ZyVEldOd16/11OaPgYETv4ZVTkTi8naEXd8SiwY/c6c8iT+mzLFYkX7UpqDj
         7duNYZ85y3TUj89tj/7UFa3OB0zPwXnP1P3lX8qxSdbpxi1nXa99+lczwRSnWNLMJJu8
         3TjFu1nrTtYBtNliUi+9MLFpNlMZTrhrEz2ziVb3I31Paj5YrgXjmDCZyWGZTpLPElmx
         fADT/6X/fHwXUiaGvH9cHSc+7kdtqvuVY/482WfPotsW4CPkT/PFXu5CNr0jK+d6CxZI
         C9rsiTGR9GF0NDHiLSihhjX5Cg2GARchOp+j/QNIwzWYz+2Cu+7ybtgTouQMXBh4AnBL
         niQw==
X-Forwarded-Encrypted: i=1; AKwUvBzmSSQPUn4qD9qUay1MxIML+2d09oHN/zoJZ1rMDakRwEqv8mh3/Wlqr24ubgXKFd5A1Rs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHYldtyvu//3xtjkoCoIiiTbyDXbae9G7iZrLgHTolXDzffeZ3
	cAXowkU+9qYPovMgBiOXcSUxaCC4AcUMtYu9HdIuAG/vbdE6i3akqUza
X-Gm-Gg: AYBFou3l7yBoTMgTRySxWQY19IlNlq1uyOKK/iCKeBh637Tvgb8O4C0MKcyvm9XvhAf
	vlclM2HS6BHnmoEbJc9Jw1Qk1GaifOlaxHuuBcDm62cvlGP9QGVsnyySmsGKQvwHIgdAfbz7446
	gNZ/hgUfkXqjRJF/Ccjzq5Skd9J9QgfIu4Zq47dpnSikRrlH41tr5s8kn0RUrkfbSWx9q407LMr
	uI+pYFKYZJLV/97oJEPgbmlhKeA8XfA+Pi3ZZTnHts9NMpRK/if8bW3WfGXlKdWumr9XMD4otTR
	lVRPcYdIj8yHJ/LBtNbVB8pUiaPbi7JbxJnAsTh8HP11wIto/SW+lyAvAOp51MTjIyhuACVrZV2
	zSGTDboJcJ2kC/4dUPQXYuyKqs5pRmXmbfL48yVxOdF5Z8p8SljQ3R/SXt17R8qsgI1eXBu5j2a
	Vx1LaUGYm+C9sSTzdMWJnnYC70RE/BCImmrQuUFMw0/FZWS/hQyhdRAEQjzl7jXeyEdJhhrIO++
	Tm+v/21wKJCOgon1ORbdeaNSFThWVZhW26ChqwHJUOaGYXnkOTxUSwOzeB4ofGm9Ote+xxG6CeD
	wFv4N+FvkFuCMERtMkt9Fy4diVAJ6pPO9LtvsMJIhmo2EvD06w7/iEDR3C8Q2s82PE+/TtJiGhQ
	ovQoxFOeDQrz0+hi5S4mr7tBBMN8GMikk
X-Received: by 2002:a05:600c:1d0f:b0:49f:faa3:3ca2 with SMTP id 5b1f17b1804b1-4a1fdd14249mr60316635e9.13.1792605930927;
        Wed, 21 Oct 2026 11:05:30 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c6:e6ea:6401:f04a:ac6f:988e:f33d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd13891sm47007775e9.2.2026.10.21.11.05.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 11:05:30 -0700 (PDT)
From: Nick Simpson <nick.simo@gmail.com>
To: Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Sridhar Samudrala <sri@us.ibm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/3] xsk: document checksum offload handling in copy mode
Date: Wed, 21 Oct 2026 19:03:28 +0100
Message-ID: <20261021180329.26358-3-nick.simo@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261021180329.26358-1-nick.simo@gmail.com>
References: <20261021180329.26358-1-nick.simo@gmail.com>
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

In copy mode, XDP_TXMD_FLAGS_CHECKSUM requests are now left to the
device only for the TCP or UDP checksum of an unfragmented IPv4 or IPv6
packet, not IP-in-IP or GRE encapsulated, on an Ethernet device; other
requests are completed in software before transmission. On devices that
take skbs without a linear part (IFF_TX_SKB_NO_LINEAR), every request is
still left to the device. Say so in the description of the flag.

Assisted-by: LLM
Signed-off-by: Nick Simpson <nick.simo@gmail.com>
---
 Documentation/networking/xsk-tx-metadata.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentation/networking/xsk-tx-metadata.rst
index f240930ca1df..028564dba43d 100644
--- a/Documentation/networking/xsk-tx-metadata.rst
+++ b/Documentation/networking/xsk-tx-metadata.rst
@@ -50,7 +50,12 @@ The flags field enables the particular offload:
 - ``XDP_TXMD_FLAGS_CHECKSUM``: requests the device to calculate L4
   checksum. ``request.csum_start`` specifies byte offset of where the
   checksumming should start and ``request.csum_offset`` specifies byte offset
-  where the device should store the computed checksum.
+  where the device should store the computed checksum. In copy mode
+  (``XDP_COPY``), only the TCP or UDP checksum of an unfragmented IPv4 or
+  IPv6 packet, not IP-in-IP or GRE encapsulated, on an Ethernet device is
+  left to the device; other requests are completed in software before the
+  packet is transmitted. On devices that take skbs without a linear part
+  (``IFF_TX_SKB_NO_LINEAR``), every request is still left to the device.
 - ``XDP_TXMD_FLAGS_LAUNCH_TIME``: requests the device to schedule the
   packet for transmission at a pre-determined time called launch time. The
   value of launch time is indicated by ``request.launch_time`` field of
-- 
2.53.0

