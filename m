Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF94238BF92
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777752466; cv=none; b=G0P/3bV+dNu9Fkxbw+V1a7rOWIEx23UHtVyrL/Kzl2q5U819cQZeXPjPKctww3NoOCOIelmGYJCYTGW1RB/1jNy8FA39N6LDzggHIqiGhM4PigSdyoCTuvRkSnwJQJYlnMy2cSBcURP6jv4DiKJFeuIajhayedpavgwG001yQJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777752466; c=relaxed/simple;
	bh=gf40XLR59hzjQDMnEBJgr3TwYidVgoYLeOXjiZN9IKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RiKIk8+N2lwfL26x1OvVe+P9BL8YiwVgLx1oQizsaSFNgWoA2yZ9IefqArwWXfT1cg58iesBFxAoCNnN+fDG4fmBqLwP44NkQOh+zF6MJbX8MmfRp1xQ4eHeXw2BATLRqjZMloEKXnpf/4+8yNQcoS+uAmID9Dc610NpG7xrwe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQhrHqc4; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQhrHqc4"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67bce1840f1so2010174a12.3
        for <bpf@vger.kernel.org>; Sat, 02 May 2026 13:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777752463; x=1778357263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXc8LtZ/Yq563oWOKcuS4yN5q506xKFEqEMGtau1Z+M=;
        b=VQhrHqc4SlzQJvUUPssF77QhowXt7fWOY8BdU2rRAIcSl0UaEFWHN9ZuiMUh3EeXH1
         5Af9jN6h9Vv145GiI4epe10hVA6xdiTkKK8ZlwKuDTFH/Cnfx/jvDpqGWDwBrv3cVwce
         Wx/70kAGj4GIhLLcE1YFknVOv8TbudgSaiZHZHOofh+GTsWMeqUshMe6medI42vuANlz
         TOvq7vvBzhtVNoae5dJXcE+zAkCz4XbC+cZ/usbuKXSYq11vEkTOvJViHqy2rInFbFyw
         plsCbDPTIm7B7ltgN6QviCXzpzCtgu7PQSKcuvejiGB1QCPwbfJfxuz+4QBPMVnbxlnc
         93LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777752463; x=1778357263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EXc8LtZ/Yq563oWOKcuS4yN5q506xKFEqEMGtau1Z+M=;
        b=mKiR7YWwltJKX66U36/mg34cDJ406zdJlDJKWlpaZ7ouKkVKeXaGcz+3drMbIaAH1t
         h2EaZk1WlkatV6dFF5hzV142ZhXGVgkivKcVqUsPq05f+naD0zTj8DvGc0c7gsXTLx69
         HbqafTxMcJOO2cnNqAghOh0igLDzCsvAZQ8L3O7LqFpGtRCf/c517EzS9WaCEAwrCMVN
         FNWA6oF+1B7SY98JzkHGdGftnNtC5C5gWoh9T0TBBK8yxnPtovUmeRkzyaEEqRDKdVHw
         Sof5tL9b3gAiO5RYjNo9vXKEkhs4s7fudTKj2qaUGQyp8+/Wkn6MOpDntfTEpW/2UeB4
         3frA==
X-Gm-Message-State: AOJu0YzAa3xYBryfHrv0C8L/GQm/0QZzW0UEQ/zhN8z64kNR6O65aoXR
	029n4pCFxRXuxBAaQodtCvHtxxlOfQ//TKgIRj0U8P/r1BMY9gPekBpV
X-Gm-Gg: AeBDieuKIs+BcXTFoYyDgXdfrGbXGn+Dip1e2KFctndQHw1V8gLaA6gvP45gzTH56eg
	mSY7LNCKmMaFAk9PRp3djHlxIV2WJdX6Qfs2PSE8O+5pLvwvrZZDPiGEei/j0rNfYj1wRgyCCgX
	02QFyhA7BXjLQ7k6nPWXIm9v5UTJ45yx7ycuZ6wFh745B3yKLj9MHTndRCy7sR2Y8rAPfKOaHBw
	akKcKm0b/Pu6fXdXnmt2OYRSgWbHTYu3fTxl+PaU01HY4j47rtv819sHHMvy6RKjDLxkMybbDIc
	9jf72u2LJ2w5OaExSplLi0mDHW2shs5N33kxxtEYPZ43SaTqsYFsLaDHrCIm0Nq/z8NHWa3X3m1
	bnnghB57gZn07I0XZ1g1074Ne03ln6qhgLV6th5bNd7SYb5kRCmtZlbK1ve9S2OCCX8g2j7Ygt+
	K/PDP3psD/i6MsC8xEvRSZ/tDLt5+OQWec4Kn4B3gkNnxKH3/C9aHrGXE3rLGHDqGzFRUOhFz6j
	slQ3RvECqa+sMpErcRYQO7LEE9l
X-Received: by 2002:a17:907:c02:b0:bab:29d9:babf with SMTP id a640c23a62f3a-bbffc47eabcmr176214066b.27.1777752462940;
        Sat, 02 May 2026 13:07:42 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([41.128.91.35])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b88094aa4sm1902528a12.24.2026.05.02.13.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 13:07:42 -0700 (PDT)
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
Subject: [PATCH net v5 5/8] xsk: prevent CQ desync when freeing half-built skbs in xsk_build_skb()
Date: Sat,  2 May 2026 23:07:19 +0300
Message-Id: <20260502200722.53960-6-kerneljasonxing@gmail.com>
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

Once xsk_skb_init_misc() has been called on an skb, its destructor is
set to xsk_destruct_skb(), which submits the descriptor address(es) to
the completion queue and advances the CQ producer. If such an skb is
subsequently freed via kfree_skb() along an error path - before the
skb has ever been handed to the driver - the destructor still runs and
submits a bogus, half-initialized address to the CQ.

Postpone the init phase when we believe the allocation of first frag is
successfully completed. Before this init, skb can be safely freed by
kfree_skb().

Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kernel.org/
Fixes: c30d084960cf ("xsk: avoid overwriting skb fields for multi-buffer traffic")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index ae59d1c1d2f8..13bacc11fa9d 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -739,8 +739,6 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 			return ERR_PTR(err);
 
 		skb_reserve(skb, hr);
-
-		xsk_skb_init_misc(skb, xs, desc->addr);
 		if (desc->options & XDP_TX_METADATA) {
 			err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
 			if (unlikely(err))
@@ -837,7 +835,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			if (unlikely(err))
 				goto free_err;
 
-			xsk_skb_init_misc(skb, xs, desc->addr);
 			if (desc->options & XDP_TX_METADATA) {
 				err = xsk_skb_metadata(skb, buffer, desc,
 						       xs->pool, hr);
@@ -887,6 +884,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		}
 	}
 
+	if (!xs->skb)
+		xsk_skb_init_misc(skb, xs, desc->addr);
 	xsk_inc_num_desc(skb);
 
 	return skb;
-- 
2.41.3

