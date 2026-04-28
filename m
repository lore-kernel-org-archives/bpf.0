Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C125444D6B2
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380953; cv=none; b=RwIB+GE/4cgLHWAodrNb3+322dipN8kagrvJexcLAMTz4ugjBMarNt2P3J6wTljw/oabK0kdYRjIWqIQ/KSo/CIEkhQQEp+0OsqpfOwM4XbU2rLf6rPQmZX7P6Htxif+rDR7PEBoXWu19SFFYIU20MuL25U3dpsG/4naPJSZmDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380953; c=relaxed/simple;
	bh=47qUe5iD0anvdWaqTf9AsGaa0trp/rCOtUxo2FmvnEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZauAZsbWGRk8lcftN4zgN8RY8btYEbUw85eysW62g8GhbyWocQRgqbnEfoxZqaFd60EtnnKCx1PLv2gz19LyZEaX+2l/nPqmpGteZpQaL7TB1zayZ1XM0la2JGz7VPJ7E4P3k95cviirISwF4n4DgLhmP/SfYFu8KW6B0OgtSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hF58UUFv; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hF58UUFv"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35e563b0ee7so5441852a91.1
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 05:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777380940; x=1777985740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slN5/hMTVlDaMpg5JpMzTWkk/vo41vVvsEaBCnd8nHM=;
        b=hF58UUFvzV2IB93MalYDmlii2PA03+Wb9RjeFNw40uS/NAE+c96pQXf8/2iUcQRF6T
         eJBjpitUZeWVq9SlXXkEngJ38tNAK15KJcLzhx3L6tFUFKLWPpdZhmzlufd/fCnb4f5h
         vImFYEud7tdMuAeCTKSy3tKTTaMJQ2PuVggA3O0/Hfrf1lokJ50vBrTs3fpwGpFuFTXi
         bff+1k/WYPH9FKTH3NJ2yiLhlFKExFxU8pXjmZNJnfIDHdf3kobQEvjaMybjOpXDc6Cm
         8wdOEx7Iw58zYpfccrzzLo22swzHasWIWbFVHGG0yoVzmkkMZG49x2FRXjxdG9ATUd3r
         lyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777380940; x=1777985740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=slN5/hMTVlDaMpg5JpMzTWkk/vo41vVvsEaBCnd8nHM=;
        b=AWGMhRvBTvhlYG0HQpoyAgF6CXDr8A92iWHbdQ+isNYhVfQXHMVLjlSAIS1/8KFtMy
         rwh+xSnsIgsj93FRBciuObZCEFskH1YN5k4g7wThNlydAVM2EjWi6b5mkkVgYqXLfqhH
         SKjNU1w0NquQSZT4g/R52B0pzHUKXKiKTV0xqIdftox9yujlD9LmYsrBnCU6uxm4ONM6
         90D3uYQ/cgtQYwzsB0y9D63VOPr4Wv5ZNSGvr3qpZVBnWeDasVMfyRFjEaLZTiL6tI3w
         XecAiTjjs8IrrqDmbSdrYdlDl4vFZTrQFiWof7XsvhZv2cXZNS5TnWNQqE5y4O5JtaeQ
         5DpA==
X-Forwarded-Encrypted: i=1; AFNElJ/fLFoq+TIBjfFzzsxXfcwRjac46+rtbBA8K7p9PfKzbjW5YFG7heLbqwfZCBb65D3kDvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YycYmQc4VGF/LpCcSdFTGlgVJsBIEGoqwyDEEMip0wSDNFwj5ko
	txNYkEB9pRqBc7fpHT5XQmOaRJc8IwHhTClRZhis0Pg2+Hn3zf5tGTik
X-Gm-Gg: AeBDietDrNmlwZNhVi/zsipDRVUYpbpjuINfAnJt0bLuludys21xUtnPAvl9YJGqBd8
	vBM17lqbjRUz1GHGcSXKzz0VjJ8Ei6soALUrBF9QeGQzudm4fZAUhK/ZlDhykcg01ofnby2iY+7
	JJLcTRnLy0IJsx9+Ap4UpBTr6LHmZohgb8KAbHwp8lNWT3s8PQAbjBQ/vUsZn7Lh1T8wOe4iK50
	2mHfX52tPavK6R/t1c/9I4KlWq00AMq05A0wIsgxqtE9EJPAQD74c9E8HX6+krSWf6VpBdKOt5k
	tmyYbCZtowuIkXYwqxCKAqy8JC5wowBopRt20BP3qHsyCojPkRhgCmQFlnPodhmPyyVMdKKEYs/
	qCxQ/xsZov2L6axrikQHH4LYSMsa0jOWTqiS9zJE0fQyVx5vfNLPOcUxLa/DV/qAk5AUjycE8p3
	b1bm3OAMqPKPDAOjVs+MLWuBQJW6DAvKn8bN2E1YDDG2zh4UI/ym4BNTh7QAtIZ4AnHA==
X-Received: by 2002:a17:90b:3947:b0:35b:d795:cf5d with SMTP id 98e67ed59e1d1-36491ccb41dmr2618794a91.5.1777380940062;
        Tue, 28 Apr 2026 05:55:40 -0700 (PDT)
Received: from hyj0824TXAir.sustech.edu.cn ([2001:da8:201d:1103:3367:a44:8d5a:228a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36490f9a304sm2912298a91.9.2026.04.28.05.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 05:55:39 -0700 (PDT)
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
Subject: [PATCH bpf-next v3] xskmap: reject TX-only AF_XDP sockets
Date: Tue, 28 Apr 2026 20:54:58 +0800
Message-ID: <20260428125518.4556-1-linpu5433@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2b156bc4277a9e891f3399935416701d1f9efd7c.1777276241.git.linpu5433@gmail.com>
References: <2b156bc4277a9e891f3399935416701d1f9efd7c.1777276241.git.linpu5433@gmail.com>
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

This became possible after xsk_is_setup_for_bpf_map() was removed from
the XSKMAP update path, which allowed bound TX-only sockets to be
inserted into the map.

Reject TX-only sockets during XSKMAP updates to avoid the crash.
They remain fully operational for pure Tx purposes outside XSKMAP.

Fixes: 968be23ceaca ("xsk: Fix possible segfault at xskmap entry insertion")
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Yifan Wu <yifanwucs@gmail.com>
Signed-off-by: Linpu Yu <linpu5433@gmail.com>
---
Changes in v3:
- fix the Fixes tag to point to 968be23ceaca

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
