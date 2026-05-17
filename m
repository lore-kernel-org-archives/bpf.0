Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967732D46C0
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 06:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999625; cv=none; b=AAS40qGpVBO2d1eu21TNzkvjpLCn4nCjktCMm3B+Ec4PVgQuIJCrq8U8wqeH0uhJ8E/WrGJe9euvWzQzZyWfy2CK0wDMmIE7dJBJ8rycJNnDd1Gmk7eP6DdXWucrg3LX6TAGg+px3xdedlRgVMtA1RTAH3s8yF8xLn166x4/4tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999625; c=relaxed/simple;
	bh=gYo9/K8sLXJNeg4Hne6w4h87zBKCMcNLlvVjrX7mcO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AJxPWgvWhSRwRfNqRjYavLfGL3aUo352yvEt7ao06KwYNfmJZ0Qs4l7mJjrJKjjyVhVeQq+MU7lqF2PtPq/WSAsJf/eTsWPMSU4Fh/SJZTp2deIUcyUnzE3mQKitjM8LltyZFoNrtC5Sq9lSeOo2Rr8aOQVjbGfe1TfFXu4h4DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkN11s1r; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkN11s1r"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c801912c903so402009a12.0
        for <bpf@vger.kernel.org>; Sat, 16 May 2026 23:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778999624; x=1779604424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZ5UR7Z/H4396xz/6XU9FLA+Qv1VDDlhZ5LK4N+hzCw=;
        b=gkN11s1ra2mqr38AzFMcwMHFc2in2cEGtoCGfvMY49w5VhKdRrgPvnx9a0d4EFtsoI
         GjM+6v+b1TWBEoJtkAEjBuXZ2K0tLpwp20hwbYtAzNTr/ilYaqbNFLkcDUDtCHvSDZ/G
         nod+j4b/Ql0voTcE+ZJ62MHSf8NxrfLGG1k5kpzgtMYNMVAQvLQC+xm/OsEvHQST8j02
         zDlRsj+urnbSuHHrhXq/yObhSW8KJvU2WSTquZPMG+Hsgyg6c/aN+BHKNJZh/bjMvhxB
         hS+hyae9O3+2HCgoWXz27KMIo5C4jF9kZNXL9B8GNuAnHNZuUeqrZdpxpcj2N0CwvfTU
         5k2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999624; x=1779604424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZZ5UR7Z/H4396xz/6XU9FLA+Qv1VDDlhZ5LK4N+hzCw=;
        b=FhmfLWqkSPCbjBABbbys3TwY69r9ALqWUGRBDnhgqegwH2NOd4VMReuwTyGwcZUiFm
         3Di5FtUL/9x1TvKRL69mgv0N3oxTJnQD3b2nWli5i4yxrFM+j8L2kpn0whtIxmwTbpUA
         xJ2NRL+/WB1f3BBBjlC+y2mJl2Kw7/ErcsPIPQih8ss6uIWxwI2ZPjDDRaZVFagOxX8K
         sNbp/6BAWioBpq092h5rW9N7yLGK5lzBmwtDZYFiPctuYvF/7VRAtkPfLG2+wALe0TvV
         VMOGg224tDQjHCmU8ZD8oC/zymBL9z6kjaSh10cw2cuH7RnHO9UooX06bOlok2aYvfTm
         ZghA==
X-Gm-Message-State: AOJu0Yx0n4aSockgbQZekc84qRxi72uFmOR0SAvC95Usa4lG4hmxBOUk
	NzFJmbXQeT+tcZA0OqpzB1bs5qbx7nWaLYr0FAkWf9j1rKOWzmHwLcUk
X-Gm-Gg: Acq92OHpD3lp2p2lMnbf3m1Plf4eC1/F+A8M/bwqQvX2VUkvyVKctXEmm+8+GIGJKeQ
	yWrZLf7MHmysmbmhZPqBesSZ/hfTDDyfkakR2hC2tzCA590ZXybmnrNxsQE7jzP5lNG6oobqgfJ
	dqVfEA1Pa58Y60mOiwBKUgwwkMRTExa3IF/f4IOK401x+FOHdHegpyDo1c73AiKigHgFwLUy8E8
	h8wJ7AT7vtDBRcLDN4RGN0gvwNWVsjcsOCj5k1TdIQGChU1RnlZiOvx7Okw8XH8ZKbbImM15/59
	Up8evl72xn3zrpXSvUL3JjBW9MyruL7dPT6e/Er6LurVinsJrRJR7zkbY4CZQfVHbRioCdlcYGA
	YzXS7GEGdVbGIyqls9WO3NwSQmaO+xpipx2JRHAsBTwuQQNAyx3b2n3rdwL42rgWy0SHw5SHLDC
	JQ3eK+r1pyGEm973PXDvzDjnu83jkNu3TZaY0UeOtIhz1Fe6/RGC7F1IYyag95lGHm1/u4wixep
	ZC7CYJFcLpLEUEMWjtlAn3Fg8QeKg8=
X-Received: by 2002:a17:902:cecf:b0:2bd:6327:b4f5 with SMTP id d9443c01a7336-2bd7e93580dmr115440635ad.40.1778999623958;
        Sat, 16 May 2026 23:33:43 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:78ef:13e7:10c0:51d5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f2cesm111625115ad.14.2026.05.16.23.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:33:43 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v3 4/5] xsk: drain continuation descs on invalid descriptor in __xsk_generic_xmit()
Date: Sun, 17 May 2026 14:33:10 +0800
Message-Id: <20260517063311.28921-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260517063311.28921-1-kerneljasonxing@gmail.com>
References: <20260517063311.28921-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When the TX loop in __xsk_generic_xmit() encounters an invalid
descriptor mid-packet (e.g. an out-of-bounds address), the partial
skb is dropped and the offending descriptor is released. However,
remaining continuation descriptors belonging to the same multi-buffer
packet still sit in the TX ring. Since xs->skb becomes NULL after the
drop, the next iteration treats the leftover continuation fragment as
a brand-new packet, corrupting the packet stream.

Fix this by setting the drain_cont flag when the released descriptor
has XDP_PKT_CONTD set. On the next call to __xsk_generic_xmit(), the
drain logic introduced in the previous patch handles the remaining
fragments with normal CQ backpressure.

There is one subtle case: if a subsequent continuation descriptor also
has an invalid address, xskq_cons_peek_desc() rejects it and the
while loop is never entered, so the in-loop drain path cannot clear
drain_cont. The post-loop code already handles this: it sees
xskq_has_descs() is true (the failed descriptor was read but not
released by peek), releases it, and checks its XDP_PKT_CONTD flag.
Add an else branch so that when the released descriptor is the
last fragment (no XDP_PKT_CONTD), drain_cont is cleared. This
prevents the next valid packet from being incorrectly drained.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 298194b7335e..cd451b285645 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1122,6 +1122,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 		if (xs->skb)
 			xsk_drop_skb(xs->skb);
 		xskq_cons_release(xs->tx);
+		xs->drain_cont = xp_mb_desc(&desc);
 	}
 
 out:
-- 
2.43.7

