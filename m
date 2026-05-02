Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F8738B157
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777752463; cv=none; b=ClKvzWMTP53ITqxkNarIWuUYcrrGW97IcwLVTfRGuuI2d2K/jMl8CDwFQdLDfwL/0VGExKiBlN0XjQCnMJ8RO/+u/NyCOMXTPFb5Uy36jP94h9RyzFk98+5zJMyisrRLP+3DAernqXJv28WvLgecuyWH48QGtzII6tbfnz7A9Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777752463; c=relaxed/simple;
	bh=K/LAURG9+wJ0eXVQ2YKLQza3gcowCv7irj6gBkQPWBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bGSXtknFYfvrYAIWnzCqy4rgRM8HQaFZqS/BWtKfay/3TresRXfjs0su8zCwaJXzXoZlFTyF0uV7JVlCQ3YxMG6kVheGuaPSo0GR9EL5usTRINXRjj9k5Zx8FMtJ5fnWDeglf4c/7GLvgemWVShPfqw8OkCZDU/aanOSif3hbXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qV/WEb3Q; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qV/WEb3Q"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-66b2d49ffb0so3737250a12.3
        for <bpf@vger.kernel.org>; Sat, 02 May 2026 13:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777752460; x=1778357260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sW6oxdoX7foHM7PJXeH0dE/YeOwcCSHqe5elQi75+pw=;
        b=qV/WEb3Qp/GviQtppQ/16FS+hZElTQE7Pxm9ysfrLrdoOojFDIXkRrF94Cojx8VpJv
         LSo7LaAEtaY4eKLWOSYbm+zTiinBaN4CS06R6uLfo0c36jK7X02uQdAYcgUOTyERNUvR
         08+vxvn9RQWey/cKwnyZ4WQOZHY6hjASHDuQr+/Ipsw6yc0at/xiBLw+q++cWLViLf99
         p3W8GpHfuaRfkNm3xbKLjEoa+pGTK3VH2/3J7sibIi/ceLMhjIiTC1VSN3nnw6+zWl1B
         0GJBqS5uw+imMQBybvtKVTrKAMXOdcc/e4WIrN6ZmgJhn+w9uQ3LOJ1acUqUBOBTdYrN
         HLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777752460; x=1778357260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sW6oxdoX7foHM7PJXeH0dE/YeOwcCSHqe5elQi75+pw=;
        b=V23TfpN+gP2ckH+me2YTXv2AdOadfSw6fQW/VMa9+ZDIPIVd76ASDY020YY0LrvnqG
         7T4oP/uQHotq6hWbVIdASXbdb6PXwSGTxIc4SEaK0ccGOqiLXAskeorD/UAyBoDJxB+k
         X6Z8flyz/RXHlfg1Y59WaKlpev1Av1bu3DxH9UqXj/+F0nBYt4qsBMEDTYwA5UBg8Q0w
         OM2+E6ywB6ZcGrM7/rCR0DTXj1XZvrrk8tuSIxVk0NieFalsenkTUgZw2RccbGTDaZNN
         VS+bRcEWCiS1uHRCWCKiwxYhMC+j/x876HfxIaOiGzCuBUilw8DkqKhBwgue0JjpSsNa
         A6Xg==
X-Gm-Message-State: AOJu0YxfhhrTkoAKuI1QFkmTJgD+XRRipgYTEoWiMx9F2XJLq07+mvc7
	C1445pUzLYUAMWJPfsMG1yHtzgGwKeTgbwTU3lyJoyOlWwmXGrH5YxYX3OtJneNT
X-Gm-Gg: AeBDiesINAU1juu69kVeVYLNvdKzQ5g8F1TQGCfp2hW0t0krLtipqKdA2Kbmq9FQ907
	ci83yY1FrgiDkKDiMxBxxCXujcB/3zcVq3h+Yj0Ou3ADPqQwxbp/H47mcerhy4i3AkF2WytsDJZ
	M8040ccfXLEBlgQfIHwCBETVZmVylY3s0YFKCWrAuqUlHJ6yglB/j0mtlu93GBls2V8Wz+pvJaS
	FJLtJeHT291U+wYCxz7U1B+ZZ+R9Hn7rz7sppj6dPqZeJTwHrj7QM0D183E7Tk/79/aMkuzVuU4
	0YL7Ixy30Emkprv61s2xGkEHSPSM5YGiS7K/Szd3FZRoSSc3Co1wcmyn72A8lDq919PGT19pocQ
	cBWshjt550jog3KRE9WKGbWgjaOF6tdmsJyVHGmsBLmeT3EvsakbLbUul0wbRaprsKs3+fkKb2i
	hydGQTswMqv9lGqUoqq0SxGMFgPMpDJ1Egq6l6id4bq9GTv6AIbs4Hklc1oXYYj9Zf9sjVhY9Ey
	SAReefZGSHZfD5tXZTpxIka81Wa
X-Received: by 2002:aa7:c541:0:b0:66e:4372:7518 with SMTP id 4fb4d7f45d1cf-67c17f32792mr1144411a12.2.1777752460198;
        Sat, 02 May 2026 13:07:40 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([41.128.91.35])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b88094aa4sm1902528a12.24.2026.05.02.13.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 13:07:39 -0700 (PDT)
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
Subject: [PATCH net v5 4/8] xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path
Date: Sat,  2 May 2026 23:07:18 +0300
Message-Id: <20260502200722.53960-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260502200722.53960-1-kerneljasonxing@gmail.com>
References: <20260502200722.53960-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When xsk_build_skb() processes multi-buffer packets in copy mode, the
first descriptor stores data into the skb linear area without adding
any frags, so nr_frags stays at 0. The caller then sets xs->skb = skb
to accumulate subsequent descriptors.

If a continuation descriptor fails (e.g. alloc_page returns NULL with
-EAGAIN), we jump to free_err where the condition:

  if (skb && !skb_shinfo(skb)->nr_frags)
      kfree_skb(skb);

evaluates to true because nr_frags is still 0 (the first descriptor
used the linear area, not frags). This frees the skb while xs->skb
still points to it, creating a dangling pointer. On the next transmit
attempt or socket close, xs->skb is dereferenced, causing a
use-after-free or double-free.

Fix by using a !xs->skb check to handle first frag situation, ensuring
we only free skbs that were freshly allocated in this call
(xs->skb is NULL) and never free an in-progress multi-buffer skb that
the caller still references.

Closes: https://lore.kernel.org/all/20260415082654.21026-4-kerneljasonxing@gmail.com/
Fixes: 6b9c129c2f93 ("xsk: remove @first_frag from xsk_build_skb()")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index ff1eade29aa6..ae59d1c1d2f8 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -892,7 +892,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	return skb;
 
 free_err:
-	if (skb && !skb_shinfo(skb)->nr_frags)
+	if (skb && !xs->skb)
 		kfree_skb(skb);
 
 	if (err == -EOVERFLOW) {
-- 
2.41.3

