Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5A73B3890
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777283078; cv=none; b=g3IehqcG9zNY0OKycK0gXt3EbLkKe4sNABAqeJ4C/na2sudetULfSSe0IGrvFs8ZRFwUd3yd67he3xhypIDqBm6RFV6UrPPk6Og43sOL/SeTExoDXdbQNzh+cJf+H1ZXaskRiIRc4yLWErB6FRXC1YGKORICcwMbApo5N26IG/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777283078; c=relaxed/simple;
	bh=YdtaQUlsZM4/WEYiUSZvYpnVG2bfZZGzoTMN2Z1MNx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=urqCW2XQ/MfDgXnZ7bB3Th2/ia4lcc8OO0WKAnVFLyYDXSAXcl5XCjCaKg2GT+NZTjqhUJO17hOf6+4vZ7MhBAW/94xC425Y15Bu4COwSaXYGIOuFeizzM+2XHt/2x4BL0D7cwhwsANg164rsD+YFu6IWw7g46r6JxNeG8Z3iSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sGYJNxCu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGYJNxCu"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so84774265ad.2
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 02:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777283075; x=1777887875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g66UKc4RYYU5Rnk8BWxgfZP37Yww2yik9aCxvKxm9+o=;
        b=sGYJNxCutB0L9+ydHB1YISDYS4UfaE11SuzhDBeQ/kV/Q4YJt3but5+BnFE0pkjtF5
         FBci7WBXz9uxspjp4y3hC2NOs8t5YELAz9ZbUXHSAgfyx3Z7Gpycd/AVMV7DcYTS8aTX
         2f7rbmz31tljk2EZcuvzYA2n+rbYfkjYZ8zCVkuFAMXtjvB2z8RHHpFwaKRtbreL+ltx
         a1qB7K1//O0lEQslHht63pY5Ws1rFOI0d9IY6KZIEDilxia9tdvF9qdOqS1qrfwJIvC5
         r9FuxTuD+kPfluq/5ORxCWN1DsCZU138Yuvi8RFnLaNaw/iVO9f7ZWs+DZJC/Xv4zKDv
         ueuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777283075; x=1777887875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g66UKc4RYYU5Rnk8BWxgfZP37Yww2yik9aCxvKxm9+o=;
        b=ZJIK23e8hoEVDwCGA69ZKV4lsXoW7YrRUgQTAG0HSoJNNRCQpXfZMrxIScFm7umbRX
         ZQuUlAOhYYDzBryzEP3GgrfL5YhPxl50HMm+rt4pAIWmhkgYzKGcinJ40Z/sM6wl+Gwg
         dgJeDXB0zQ7A+Q3zVRxa1YniKDHl/73+Nu+u7XeE1OUxg0/05rPZ/wrTsBnvWHXCtXyo
         wcs3MmgDY4g83WkX+NsmjKKAyzspmo0ehxUiz7/Z7VGtKD97fDP+NxASmud9AD47TdO5
         BZURDfPpBHmU4nZrrtMpbdFzG0myJD1uAyanI/NSLePFoX3Z6Y6enZH+yG5oVMMt52+1
         zN8Q==
X-Forwarded-Encrypted: i=1; AFNElJ8DM5FV/BcbQkoxI/HmCy8AbsrVbJPEngV3OH82P7qQZR2M6cVnIsAqsdLCCJwzqMIXICI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywingdi9gwIeaTT4DtgehCkXXNqiqgF6g5+qU9/4sg9DAYqLeY0
	RRgYmrsf0aaYzMAwgEhGWOnE6XTgAdGpQiV47pTzKYaylVyy05bS+3Er
X-Gm-Gg: AeBDiesJ5eZtW9fEstN3vykj1mmMEuWor5Gwxc/jn9oIpfEfTSvUMB70I96v0KYC4Us
	zgeJf0Yrjv+uCMkme5ca6xa61J7kcU2GIVnU59tt4TKCXyL+OEZCkvU+vco/r/9B88AMaR6M25a
	2FW/gJSu7h6TAsiXKU9QV64GXvEAIH4Dr5oaVxATV40rOLZkIAIroAmQNubY/izgZbqsEJYT6Wl
	UQSMVF0IW1J54JsZxZFIHi1zwKYfNpCnmXAXt8eWIBVTfvaj/++I8NkmVaUSVxZQIWXPf0emn1n
	hkyqBMaethiW+OlztZrLSvLUIP1ZVdo+FjIl3gQ8/PtcTgpw7PqkSDFpl3+mc1GjZy97daBMF08
	je2RpXwBZU9C/8Ta8G1NtVmhhbArrna1uA5Fo8PfuqUW/Mkl5E5rBCbo/NUp48YTunTa4n41w7h
	3gvum4zBZFCw9wshd9GhiREOve/YfI2uRsl6fgDQaqfALw7VP9xI4sz+G7KZVUjiXO2A==
X-Received: by 2002:a17:903:3bcf:b0:2b9:7051:2c18 with SMTP id d9443c01a7336-2b970512cfbmr12693285ad.0.1777283075064;
        Mon, 27 Apr 2026 02:44:35 -0700 (PDT)
Received: from hyj0824TXAir.sustech.edu.cn ([2001:da8:201d:1103:3367:a44:8d5a:228a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff3b4sm384931995ad.2.2026.04.27.02.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 02:44:34 -0700 (PDT)
From: Linpu Yu <linpu5433@gmail.com>
To: kerneljasonxing@gmail.com,
	magnus.karlsson@intel.com,
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
	tanyuan98@outlook.com,
	yifanwucs@gmail.com
Subject: [PATCH v2 bpf 1/1] xskmap: reject TX-only AF_XDP sockets
Date: Mon, 27 Apr 2026 17:44:22 +0800
Message-ID: <2b156bc4277a9e891f3399935416701d1f9efd7c.1777276241.git.linpu5433@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XSKMAP entries are used as redirect targets for incoming XDP frames.
A TX-only AF_XDP socket lacks an Rx ring and cannot handle redirected
traffic, but xsk_map_update_elem() currently allows such sockets to
be inserted into the map.

Redirecting packets to such a socket on the veth generic-XDP path
causes a kernel crash in xsk_generic_rcv().

Reject TX-only sockets during XSKMAP updates to avoid the crash.
They remain fully operational for pure Tx purposes outside XSKMAP.

Fixes: fbfc504a24f5 ("bpf: introduce new bpf AF_XDP map type BPF_MAP_TYPE_XSKMAP")
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Yifan Wu <yifanwucs@gmail.com>
Signed-off-by: Linpu Yu <linpu5433@gmail.com>
---
changes in v2:
- return -ENOBUFS for sockets without an Rx ring
- clarify the veth-specific crash path in the commit message

 net/xdp/xskmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
index afa457506274..3bff346308d0 100644
--- a/net/xdp/xskmap.c
+++ b/net/xdp/xskmap.c
@@ -184,6 +184,10 @@ static long xsk_map_update_elem(struct bpf_map *map, void *key, void *value,
 	}
 
 	xs = (struct xdp_sock *)sock->sk;
+	if (!READ_ONCE(xs->rx)) {
+		sockfd_put(sock);
+		return -ENOBUFS;
+	}
 
 	map_entry = &m->xsk_map[i];
 	node = xsk_map_node_alloc(m, map_entry);
-- 
2.54.0

