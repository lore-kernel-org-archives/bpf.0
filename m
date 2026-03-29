Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A8937BE6F
	for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 19:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774812597; cv=none; b=aFC+snED+vlUr+7+pSvzl1uyh+wWJuNJQ90d9qwgZeCYpqGZOGAKOOFmU0Khhy/PUO922Xwz5q1eYnYn/pUQx1APADIW5v1JIYULH1VXN00oFG0kx33/TTsdWtKG1+bK4oxnrWZ3fJNVxdoB3p1OtY66TmFWeVgyxudW19WZFtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774812597; c=relaxed/simple;
	bh=TVGIvwq7++r98D6MzS4FnxGtSITtMoooJkrNi7DUieM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhVbHJ7gP59uody3WBiLeQR/oP4yHuzJxBIKw/gnJOZrQvzeWzaK8p1YqLup0Di31Rg9rZXckCC2q8be8gzQVyTOcN9l9TD8guzKvd5SsSi45DANwgukw/bCu/QtcT1CU5JHz5GAG9XjddZPICIyQuL+SdUr+vSzTctKIIVuoO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qLDMpSKo; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLDMpSKo"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b0ba3bfe16so29685075ad.1
        for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 12:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774812594; x=1775417394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTz6k9vPuNqocM97eUGslil5NIJ+KRt/46MukpBHLQ8=;
        b=qLDMpSKovunWsOxGdgNz/UsF7iACexAh3YBkrjiTziSN7bu6NglzLZ33u8Z1Pj2/1a
         ZR52nko01rY5NwcNt8qy6SYDbAtb489lQKXz1uXMASVQCvs8sgxUriklFyvwgOl7poXc
         lf+/inv8FU+q61SWkTQE+rFjLv76aiGHn/UaF+onC9PgVEgA1mn+c8JICLq/tkOidhzd
         MIXLx1JuGapYXxaeSwa//2Q4KLfP5x5tuJEo1TfSsm+wl8qrJZyOKy1o1lLb4f0jZR2Q
         AfyZTyVxz79rFjxJH4Tki3z54iECnYNnu/XZ9pAxaXa1LIaBcb0R9sWgEnb/wxVT+SAn
         3Oaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774812594; x=1775417394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CTz6k9vPuNqocM97eUGslil5NIJ+KRt/46MukpBHLQ8=;
        b=eJ0MGzPX5JKygkA8fVXO9ZTB2cUCsHCpiX/s1F5+y3t4U0+70zLKmg4MU4Y1ypIt4K
         GpIdIYbIcUASBwIKyhj+cZIyOvdeBLBZ/2/F3ofgx+M9QiD+ggUXJ6ephogI1or3Tnpc
         x6WWEP7vYg/onAyaobkumAUofiT/wPnpNfQ9F/IyaWljj+EUCHdESVjTWoigz9v6cBCm
         AZymmD15tdVO8nx9wO75UCJhk7TxHFPNyL9r3ekpRoJxCa599E2RzRfnNkTq25OxwGQ0
         St6z6p0fMDZtS5rGpJMMB4cIIaPrtcuAYnFx3L7nXGyH7Beh3DzKlnm5bLREKfsk4mlx
         1e+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7Zh9TaBzl9TSfmBsF2okvL73J1fa2i7JZSyoLDS/LyNGzEBEbKbTz3rB9IkfAbGkF95Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3CZyBC5jhxbo3/qLMnkkEcY9BKLAhYJKZGr/kNCfQDpQbH2Ng
	id3v5L7x4rVS0Kil16xO6POeR733Q2vVSoBxUxSB6LD6ikJVZpj+g1+4
X-Gm-Gg: ATEYQzwm0sInMyjgZ8hmL60+/Q0G3rC2DHr2AkwY63rMVXv/X6HBLnUE2y4dSg9Yl7A
	spDB4zGoa3bEyVIvPv2GtVu+JsZ9Akn6y00Ojz7heOHBiwmrS7dJpoek0uKwL4ODXTVjGBmPEUh
	n6y1Jfm3G8NpfbFXIVdKnO6GVKqZJL0xge1vBmUAslqEMvoGMm+4Dk6WAjkGASEOHU0vVszQ0p7
	2JTvxRPQdnol8VtBRWJ4/eiTuYtvXpqCeF84oFDdezhQxYj/7pKTiQHVTRKzn61ejV8ThlwvRPx
	l5WuuVBtYeezUZ0RbkBOfj1w0KNQYkNTz+8ry2GjaakSwTd6sda9i8dryZYipSRuySLKqmg9uRc
	qkNp472Cv0afUTh7Dy23bRmPMb/j2A8T9h4dgdvhVosg9VZv/I7XXj1yQeu7wmIiOW38fjpt4AB
	s43La8c0Zau8x9mHSOpnbvLutjHTnnOCv1rngmQL3YvqiB5w==
X-Received: by 2002:a17:902:ea08:b0:2b2:3eec:c75b with SMTP id d9443c01a7336-2b23eecd00cmr67930985ad.2.1774812594514;
        Sun, 29 Mar 2026 12:29:54 -0700 (PDT)
Received: from hyj0824TXAir.sustech.edu.cn ([2001:da8:201d:1103:b2f6:47fe:9572:b2af])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242642905sm68959585ad.17.2026.03.29.12.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 12:29:54 -0700 (PDT)
From: Linpu Yu <linpu5433@gmail.com>
To: magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bjorn@kernel.org,
	linux-kernel@vger.kernel.org,
	yuantan098@gmail.com,
	yifanwucs@gmail.com
Subject: [PATCH 1/1] xskmap: reject TX-only AF_XDP sockets
Date: Mon, 30 Mar 2026 03:29:42 +0800
Message-ID: <6584463e576b7bb3619dc302cfecfb8ca56bc86a.1774701288.git.linpu5433@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774701288.git.linpu5433@gmail.com>
References: <cover.1774701288.git.linpu5433@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reject TX-only AF_XDP sockets from XSKMAP updates. Redirected
packets always enter the Rx path, where the kernel expects the
selected socket to have an Rx ring. A TX-only socket can
currently be inserted into an XSKMAP, and redirecting a packet
to it crashes the kernel in xsk_generic_rcv().

Keep TX-only AF_XDP sockets valid for pure Tx use, but prevent
them from being published through XSKMAP.

Fixes: fbfc504a24f5 ("bpf: introduce new bpf AF_XDP map type BPF_MAP_TYPE_XSKMAP")
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Yifan Wu <yifanwucs@gmail.com>
Signed-off-by: Linpu Yu <linpu5433@gmail.com>
---
 net/xdp/xskmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
index afa457506274c..6dac59ebb5cf0 100644
--- a/net/xdp/xskmap.c
+++ b/net/xdp/xskmap.c
@@ -184,6 +184,10 @@ static long xsk_map_update_elem(struct bpf_map *map, void *key, void *value,
 	}
 
 	xs = (struct xdp_sock *)sock->sk;
+	if (!READ_ONCE(xs->rx)) {
+		sockfd_put(sock);
+		return -EINVAL;
+	}
 
 	map_entry = &m->xsk_map[i];
 	node = xsk_map_node_alloc(m, map_entry);
-- 
2.53.0

