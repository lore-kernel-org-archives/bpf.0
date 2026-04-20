Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B6E388360
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673703; cv=none; b=OSxt9ux4vXNgSVqLtH41+hAzSXeW8RbWvit8G8txomyPDNhwKvjM5oYwfSnHPNmdndI8f5zGWU1Oz/KuaUieDp+Weu4vQOKHMeYVHHrSTPzmwY/60d19kVV1QdOMpxVvo3qWqsrf/hvghu6Tj81NOxWgqPB8Z2UKWxr36wpEA/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673703; c=relaxed/simple;
	bh=M4+77cOcU68W9THBSjVg8Xbcol4HAaJurQC7Ojwff/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YcN8jaPPYcpMnFWdJWT8IddG/gE8wlHHkfixYVohX75IuqzZK82Kfs1wcw91DiZRP6ZmroTcvrCeivz7Qkd4Nteu3jVffd9+oajvzTmH/PuBoGKiXANKhuHKGQwNC9mmRoPidXJOK9E0NPFsp0YnYgOTrPY9EWIO+M/UPEc0HgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kI4qao6R; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kI4qao6R"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c795f441ff7so1971853a12.2
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 01:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776673702; x=1777278502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5eoEKPMkgwA6eleJzc6ZMHbLGT+Vc5FYW2VP2CKDVk=;
        b=kI4qao6RuCvFlgAFnbZcP2xRyvEZWpCy172pXAjRLeXzSHYH8v7xU4cuwy8uJuoQ9Y
         CRA/bKYfvGvsL0Te6dralKu/WeunTn59NfGU4FsEfuDiIC/6CO4FPHQaf64FGupuSfjz
         nBhCGr/CpkMngVhD69ceDbq7bURS1SMHRlLh6hWT1ppNbXBQQRBCfClrmSNfoTB06zkW
         1yfnz8+P8Rw47GyphpjsEqXC4o3ipnmNfovu5sIbz14aYHqL7ChxLfFkx8G329aooqmE
         Uw7vnfed5j2zJwMy7tJ2sPKqZlvggHXFmguHz+yjBvTKLAj9D1q8W85I2q6KbztT6Jrj
         WYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776673702; x=1777278502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I5eoEKPMkgwA6eleJzc6ZMHbLGT+Vc5FYW2VP2CKDVk=;
        b=Y4nhvPULAV/f1WErvsPYzX+WCsYu1XoDE5WcVDBSZCZXD49qryWVmIZm/pQRBFfBp7
         FIQXCPkQJlJT0tEThNB6MIvcZXTHA8tfwH0knTlTcUlNParQ8RoE80v8nOEpkQCK46b7
         b1Hx1CxZa4zfJNE5/8eloN9WqjHWvSIVTMHep5On9XxfdqL5PJCb5/v1s8YvXyNgP01a
         MuPS/8CWd6pAwVbS+HOMQJumwY2jbebKLICoUl+la0qdVJfQYpzMMH76Qq+7FBEFRrhe
         s0Cox+ZVzoDFODlUOmljLw0RpJzrDE3WhP3ZwIluNXi8RI3WngGGOZmGItAphNVvG/4r
         tsuA==
X-Gm-Message-State: AOJu0YwrxV9EV10qpHvQSfUaxtIT0xmNk19ftwZdhgRnQUFKhEpmyUGb
	AHYiyXdwMVkPrneBcnfBvXuAD2lIVODsxyrPgrZJ5jwCuIE9Ezig76ln
X-Gm-Gg: AeBDiest9arcIFHwga4uBHGRg3rDin7OX1bPubzLOk2wrml4Rthu9K1s3GWVg255qYa
	7lR9rcEINF9/3dBul2oozXp4VgawGa46KqaU3vlTO7/tcBkYUE4ceY9zlrcEl3FtbpANa71UtUH
	UFy3vlOivx24kp3vmc/cMWw7WRSKr+9Nj98ItFlyoffDRr8ZbykB7qfhQh9f/QELObfnOSWOn5X
	eJnt8HLEHY2DXLGPRYs/DZVJWv/U4tos0yqqWssiHjhOTcZlQi/saGLjWxAtnputuVRj40JPN03
	vQo4qJnk+6IadCgImK8dl56M1CHsebUpn3X38RwshdWTCWz3n1+zAJvkXUcDUrVqyHurUG3JGO1
	t9jsNrJ8It/ut+QWViyC9okNkALGWsi1A898Nco4jmOLPiJhm7tTuGCkn4dgtPyG3WKFJt5JTpp
	uDzUhOnCbfbz2d4xjV25o3adkKMTcHUO0Cl2GVgpdW3cPa6BcvCyDsY7hNE7MPA6WkRHXuYEfeo
	K1CNKasCEfC/cLRWKw=
X-Received: by 2002:a05:6a20:7d9e:b0:366:2447:6778 with SMTP id adf61e73a8af0-3a08d93e320mr13740453637.53.1776673701880;
        Mon, 20 Apr 2026 01:28:21 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c798b56a758sm1728010a12.18.2026.04.20.01.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 01:28:20 -0700 (PDT)
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
Subject: [PATCH net v2 1/8] xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR devices
Date: Mon, 20 Apr 2026 16:27:58 +0800
Message-Id: <20260420082805.14844-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260420082805.14844-1-kerneljasonxing@gmail.com>
References: <20260420082805.14844-1-kerneljasonxing@gmail.com>
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

