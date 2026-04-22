Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0562D2495
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 03:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776829026; cv=none; b=NgoLqxHzTdNAnNWzgChGHPbeZ7LV/DdJs3S1MY2eWebdsD8j+MXiqymH3Gkw3BWVeahgLSjrsO5gzIB8S+IftvDQ3WZtn5g0d1NgRWaTQZRWP6W53Tz1RdSIT8RMvRlZLooH5lYeIxMVpOISBWglTg615s0tehs5pJtzGmXKoX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776829026; c=relaxed/simple;
	bh=fctOOu8ihanad4KwnadnhQVcL0yq7+8B+O+aK7WYNr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c7+nDBFN9+4GCce6+YMJK8p9m6WVaGQuGUHjldKlgWmerpdk6MFN8O3vDqh5WX5xgpRFWcWld/bkXkfalGARxuN68pzeXppkQ57scu89NP3Wh3JPbDjFtXwXz2VwT40lEvSlUl3moLhJxp9LIMW3LQFSLRxuNKBtpV6T4HaQ7rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpV0pEeJ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpV0pEeJ"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82fbdd60b64so1767247b3a.3
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 20:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776829023; x=1777433823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0ej40ghKn8TLZMMNc2ToDzMeEQCp4B7994Wm2iXNOY=;
        b=LpV0pEeJW0DVwm6MxxOV7xIODT4a70EIBCvv824fRO9GDA727BrucJvsfRa3ub8Zs1
         +fl3ltKKRymBkBbej8jg8oVjWbjlFkAQty01TMJrV0Qxs+g4ZcvM0stgPn1DdNtcS2Jf
         gndnC8EKWMvaiGa19wJOYLl0lDXM69LpVJh8G3my072ePVM1HBgfaHLveLN+KX6LkRWU
         CXvps305HKYr842GxnLbU5e7/LGPqiQuVQsE4f7FWC+BVF1VRG061Fkmwe3q5fXyj24d
         acyUS0KoDVYIc23gtmydSRtGEbcBTJGxkGw/AJCCgqx8BgnfnzEHMIRuSl+EbQv+jY2s
         3tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776829023; x=1777433823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i0ej40ghKn8TLZMMNc2ToDzMeEQCp4B7994Wm2iXNOY=;
        b=gsmeABJu9SkDPGQ+YQCJtzfcIZC6d9Ca+2h7JgrsDpfAQf3SociZfqZo/Ke3Ayn8/H
         DCB33unYppPae9/aIBUx/MvLlU6lpcmmZrU9yR4OwesJHcfjgRkqFCjJszB6tX0wAI6r
         DTSQRYOwHrrzqQsrrIrhwCi8qHIhauE+Nr72xaNg3YfLZWUqP8ZPDSRiqipt0u2Xu/Db
         K1L7gynKlpInqonwwdsen9oFYF6/zYx1JhvwMpSp9xLXokM17QRbSk4cxXAIF+9cNSUV
         imXBZZBArQnXrQ/OuqEkPMoucxpXlQyW0TukwuNQm5VdxjHGA3CaUdZgycm3l6FlC9eH
         QytA==
X-Gm-Message-State: AOJu0Yy1lMfU8g2yfRGG9OOTOpzPht+dV2qNUNXWwNl4YeaxPTdcoFjb
	6sbY0QL3o8O3JroWtvWgaT9c6y2v3XD2AGpRCm5EAS2xzGbV8lLGToDu
X-Gm-Gg: AeBDieubmyqTF3t2UFBUVEnEpAjRlaPuNqqsQ+Tz2G8IBHXEunnECCnxJwEymHVT0xC
	SqtXUngZHCQhA7CbpIFS/hYDe95e0E7zBCB/0CuF0yo4eRzshyLd6XuemxjGRSk1vyn6Q2knM8j
	t32tiDz0ytxw05HqyP+UnEeNUPEmE9FYEdqYxb9SZQg7PiPEZPZysabppF8gUt7gyp7DwAxeye2
	Pnk4oQGRuIVL0hPN3h7RKKyihSRsbXtItaCXAHg4BPY5me46WpXLDH/0m+KyvtgjUWZgpyhz9LB
	Lclco22i/3Mzx/w0vooeHSnSKAmYAjtRmGbmYK5H4MuWJSO9ngtuJjaCpGAjVxsl9N2948JL5vL
	bMiYJtSuVomzJX6fgo4uFXs5wMZlsQsNkqmKZC8mPX24Ve+ASHqW2KKB6iJUkMe+YiGjVE5LDj4
	42B3yQYcKCxSsbYNPPTTXv/XZ418gfFADDpISBFppw2cN3RU3Ch//2L105Z4G15nINQx5DhpQaX
	hVeGvoS
X-Received: by 2002:a05:6a00:4502:b0:82c:70a8:faee with SMTP id d2e1a72fcca58-82f8c830903mr20784475b3a.6.1776829023119;
        Tue, 21 Apr 2026 20:37:03 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981c07sm18355473b3a.1.2026.04.21.20.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 20:37:02 -0700 (PDT)
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
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v3 1/8] xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR devices
Date: Wed, 22 Apr 2026 11:36:43 +0800
Message-Id: <20260422033650.68457-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260422033650.68457-1-kerneljasonxing@gmail.com>
References: <20260422033650.68457-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

skb_checksum_help() is a common helper that writes the folded
16-bit checksum back via skb->data + csum_start + csum_offset,
i.e. it relies on the skb's linear head and fails (with WARN_ONCE
and -EINVAL) when skb_headlen() is 0.

AF_XDP generic xmit takes two very different paths depending on the
netdev. Drivers that advertise IFF_TX_SKB_NO_LINEAR (e.g. virtio_net)
skip the "copy payload into a linear head" step on purpose as a
performance optimisation: xsk_build_skb_zerocopy() only attaches UMEM
pages as frags and never calls skb_put(), so skb_headlen() stays 0
for the whole skb. For these skbs there is simply no linear area for
skb_checksum_help() to write the csum into - the sw-csum fallback is
structurally inapplicable.

The patch tries to catch this and reject the combination with error at
setup time. Rejecting at bind() converts this silent per-packet failure
into a synchronous, actionable -EOPNOTSUPP at setup time. HW csum and
launch_time metadata on IFF_TX_SKB_NO_LINEAR drivers are unaffected
because they do not call skb_checksum_help().

Without the patch, every descriptor carrying 'XDP_TX_METADATA |
XDP_TXMD_FLAGS_CHECKSUM' produces:
1) a WARN_ONCE "offset (N) >= skb_headlen() (0)" from skb_checksum_help(),
2) sendmsg() returning -EINVAL without consuming the descriptor
   (invalid_descs is not incremented),
3) a wedged TX ring: __xsk_generic_xmit() does not advance the
    consumer on non-EOVERFLOW errors, so the next sendmsg() re-reads
    the same descriptor and re-hits the same WARN until the socket
    is closed.

Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kernel.org/#t
Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate function")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk_buff_pool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 37b7a68b89b3..c2521b6547e3 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -169,6 +169,9 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	if (force_zc && force_copy)
 		return -EINVAL;
 
+	if (pool->tx_sw_csum && (netdev->priv_flags & IFF_TX_SKB_NO_LINEAR))
+		return -EOPNOTSUPP;
+
 	if (xsk_get_pool_from_qid(netdev, queue_id))
 		return -EBUSY;
 
-- 
2.41.3

