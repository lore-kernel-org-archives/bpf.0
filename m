Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5BB36215E
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251436; cv=none; b=nfslGM2HTL3P232nwjQQfiMQtk5CqLMTG2r837olKVDvCfZfce7Qje1w5L6NaxWNxgfcyEuEIyz/6QbSL6swLS/fBQ9srtb4rRkO7QzE/zgz5ti1qSCCFNIovPilKrkY5pW35uLmzXiTiOGJ17f9YqR0zBhcNV4dg4HnpBODOFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251436; c=relaxed/simple;
	bh=EyXG+VwrAF+um4XflE0usQdCTWRvEq/i5fmd3Ev8uzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eZtYqUmKMnLOZYebJZHCcLHYaHpUsE9jFBudanWrx8lKOuV0pbpKaDM7t/1ebNJmDPumDgKXWUfUsc0gd6m3mBIaEVaYwBJqaesNN+I21ClcIulglWcvSv4Dt1byQ7iAGuBASTDQvii+UZZldUzg+kc57SHoR7/QphGyrkHMhDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dg8HjAmb; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dg8HjAmb"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82748257f5fso2013749b3a.1
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 07:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778251434; x=1778856234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a2w1uSP/0twE+5ljaP1rCYoWbGtAjbga1hTtB1LlN6c=;
        b=Dg8HjAmbjrTgvDXVnmvLLG25cAknvGCWOVEvIZpItXfQt+6YIWNUAP0jI1hNIXzX23
         IA4TJzQ9LQRSEcfKZQIgE5RsNd1iV5LBMtBCvx33MWIZmuxOShb7FYvNfAex3lt/+7DL
         SU4GoxlxwCb5srsbctjt5kYfB1AQLKL1FZWLtJ6z753owcHsQbG1RdpylocU6eofoIB/
         8d5Ig1EvZsJ7B1HsYqNkdXiPPh4+yKll97a0sMeTCDIfsYcN3fJ802iFti7Vu38lMOht
         VhHJ4+SYpyy5OjpMHI9xZNxZYljgSb3dXY/JncuRaL7kK+OoRPWCiJn0pzveQXJuUn21
         bBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778251434; x=1778856234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2w1uSP/0twE+5ljaP1rCYoWbGtAjbga1hTtB1LlN6c=;
        b=jAkkkLBjEkP1WQuE5xVeolF6tkiD1LNQdz/RNRn/bF2Xytlj3g8uugQQ+7ypAN+O24
         O/gGCLKIvrfxhwj2x3XBw052TYYeXAwLUvvqIokXmqefHibzk9gDEZSnDrcyChPUaEz4
         LIYTrYzv22C0jrcUwh6enCRGwvTZ909PrhMrXKr9N2ZwIb9SxFxHvYeZmTIK6MZZ6K8F
         0aj3C4s9L0Kept0mB4dPGqp+AupmPMSIKhI0I29rTlKEZsXYuaCNRqD6hrwVinYj4gf0
         QCTW/bBF75mjVxaYysUbcn+d+VD9AMm5IVIDK7aSzCtscv0o55oOWwFFA4cJanHJeAtd
         TKlg==
X-Forwarded-Encrypted: i=1; AFNElJ/9CfgiWmXjZYQTyBBHmrw7Ro4L96tOsYwLrO1/On7kw3ju0RaOvifh3lLpRw/VuNaOhcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuLwvydCpjuAGwuPyulPMMLdcNEjqkaKRkznGu1lKKFdJ3XnX+
	jMQf7xnariS6Qw6QY/XFFxikXzi1I54l3zxQEJsI3TxwxQX7TApUrmoX
X-Gm-Gg: Acq92OGjwn7Z3oMPOACSY/EsgVjD8nY29RNi+BRjeTX7Knlk4kBiyzN3eQOGsJ1rca4
	omXWk8P7PNkKoU1itq+tvUHVCnJADFNtPECJyqPGwwsz8isO6CqpsVTPSIWOQdofIAd3aomSSM6
	prDEybukit+6NuvwUE8f3t/pamj8iO1TtbVb05eR3Up2SuzFWRj/JYXa+dDRwqRmJ6QkIK7EYBq
	Rbl9pTQZwwLWqEVUP/RysYCm8DOYyBxVAE59fy6W8oD0foVSZla5lkBbsUrphbMSMHIb8riTcF+
	uAhgFPQ5fnpvYHz/1cizckV/BV0uT1i0l6HXY+Hh3oXaNHi+j/2f7DpB6Yxp7y7+t1joCU1iCQP
	c91uYNdMCbfyPpaKqrTNDLDHXbOF3FFR1AqhGqc9QzbBUYcEZd+H+WjrVucwOWvNsiGXm/Irgpt
	wMH1Kkzvna1B5QGmbvRK38mIvzSrrLuhXinA==
X-Received: by 2002:a05:6a00:2304:b0:837:8a0c:8f70 with SMTP id d2e1a72fcca58-83bb8691c49mr6557122b3a.28.1778251434012;
        Fri, 08 May 2026 07:43:54 -0700 (PDT)
Received: from hyj0824TXAir ([110.65.147.186])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbdda0sm12856887b3a.44.2026.05.08.07.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 07:43:53 -0700 (PDT)
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
Subject: [PATCH bpf v4] xskmap: reject TX-only AF_XDP sockets
Date: Fri,  8 May 2026 22:43:43 +0800
Message-ID: <20260508144344.694-1-linpu5433@gmail.com>
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
Changes in v4:
- retarget the patch from bpf-next to bpf
- resend after no feedback

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
