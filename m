Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3CE33F8CA
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 05:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777009113; cv=none; b=mdyGX+0hnz2VzafwbF1fcDRHwhVQZn/QhZTEdIEm5pbaLZuXzw7ht5P0FFPiG0Vg/v7Sk6EGjgM0kHSn7I4YKoBFQmLaaWEq72wj7FebG2Y/ZOgQXyY6hFPcXkbqpaJF74a6/k0+zLQFPZQuBSxbQS87lKLXS7IHhqDrFOVGgt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777009113; c=relaxed/simple;
	bh=fctOOu8ihanad4KwnadnhQVcL0yq7+8B+O+aK7WYNr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bz6MTGwFha9sFArD/1TPMhiohN+RNpj3HUR/f48Ae7ctKlEmbSZbwj1/wN2+VtrmQzx/moV6ZAOdz9QP81hP6KUzm3KGlb1xE638jCn4P4CadACixZhk7TjPD6mHXin6Rvy0abZwhIOY0l8gTuL0c3m5uUb/u6M+Mym3rk9LwiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9CRg717; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9CRg717"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b458ca2296so47566665ad.0
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 22:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777009111; x=1777613911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0ej40ghKn8TLZMMNc2ToDzMeEQCp4B7994Wm2iXNOY=;
        b=Q9CRg717t7I19+981t/+Nqu1X1tYncjidgdVL6rRcdCjg7iz+MhYt84VgWyHZo+H9W
         xifiwBM8yHMaksoth/4TeDOwCkZ/fzdzygN5U2v5j6kxyyHANcoLyEhzcY7+mZXgCL/w
         kcgK3nP/YNBFULoVvQZ4MjscUTzdfgzhi1+U8puQCCJlXROup2IEHAaEY+C59+DL0I3p
         lsRVwtzaSLdxNwBnDzcsDu9qojE/So7X8CcbTEihbVOoDUl9ESK+fIncfbmBz+PP0men
         k+U5WjMtejKqMwBAuGEbnoGaqg/FgQ43Nyf0mPcJN9ILMR79by3OCoNvDEkEvLLnmJBV
         o2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009111; x=1777613911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i0ej40ghKn8TLZMMNc2ToDzMeEQCp4B7994Wm2iXNOY=;
        b=ol2I5QO30LSEqzAeutSzNfWmVPViz5IvqmvzN0THK+cm2yqUFX5hA6VCbp7FnsT3DO
         fp8wrDJwImpF0PX4WTQc35xRbehxzDdl5nt4AKHT8qQyvKYk+24gkf9ubUCfJN21oKzS
         4pvkvD6HimWgGFa+t/NpoHuoDTlbuDj4M/h5o4zKwlpozSI6lHn4nrqwRFlKbU3jNDwu
         p9KiknyjwIw/BE/atp18Ipw1QU4Z7Ow48dvQmxXLrfaZdLztynjWWKjDs55R9lT84vp5
         8DZ6m6O+ZCeL06N/ZMbHX9BPlGjIVeB14GTqQAEB28yV/SuB2LDtKGnA2CKZmCH2pczq
         L1Wg==
X-Gm-Message-State: AOJu0YwOhxkD5TVFW6G2+ePFQ0C/We7Y7YJ56DTV08vYyPe9GqnkAjmo
	fAsCtCxBOO/YKbvd7TNmtkG6mNTGNwoTnpgCG9SDINMFNIgRxukZTgZw
X-Gm-Gg: AeBDietvhxqUhjqABvw+pH3dWksi5+x+5Qci1JNnpB8AHvUoLWlsMlofHcAuhHZGeUj
	ZRNCz2qHI4fHkuG0dk3AaZzT0BaoKUnRCteBtjRFZyHCiX5CKsr4HXpS2cznzIKueI4qD1keyRK
	mvFDrjZfyY1nobLNu2neRyttoNWiDuFvt/N8UD1UQKsyQ1VHkJwXArV6zGig8RNxyG85Hn1W3uw
	XyjStb2eRug7BWzTxlPe7EZ5E48ny5VM3XXkrW2STm1O/zSISJLnwyU1xw6LtExuDwteEmciebp
	FVMnRDPFGC0szyTVUiydF7MQcHFRfGV9h3Jmnu2Ie0Ux8T1yECyA5glyqu8F9f/XRYD4/UCMZxV
	92Qud7cZ/nWBu3GxxMLCKT61AHPD2lEZ+udQCu9+7gx7Gt0v1Av2fml65NgWbvyhdkFymIUtY83
	XitFTP0PAdoKjOkonqowZnR9BL1PHSsxU4xrzYBuPLvuNoE3Xi9ol1bf5lCZ2wqHbfsyrEPv0Jb
	ICqlBqXgAhxlISpXegW0Vm1ngjXL9ND6aeKri3d
X-Received: by 2002:a17:902:f645:b0:2b4:5ff5:e51a with SMTP id d9443c01a7336-2b5f9f51abcmr301815925ad.19.1777009110586;
        Thu, 23 Apr 2026 22:38:30 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab405f3sm209444725ad.78.2026.04.23.22.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:38:29 -0700 (PDT)
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
	aleksander.lobakin@intel.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v4 1/8] xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR devices
Date: Fri, 24 Apr 2026 13:38:09 +0800
Message-Id: <20260424053816.27965-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260424053816.27965-1-kerneljasonxing@gmail.com>
References: <20260424053816.27965-1-kerneljasonxing@gmail.com>
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

