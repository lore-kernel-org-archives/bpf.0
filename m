Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D11C3A451E
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776829047; cv=none; b=ju56MYcUYFNBX3+Ob65F/kJGhYExObGufzNRhlx5t/QAuyMybdSLlftBLkGRkCz0ZhcazbdHKFCWs7/B5pXn6AZ4d8yj3V6WgSTSVu40bIVHeoJ5AXrc7knffbywBTDKeOvgYhrY2LsKgKu0ZYWUHZOmRt2juLT3yGYGYPlfU1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776829047; c=relaxed/simple;
	bh=54dyOuVdK9FasYgsc8yIn1HhPOeS6TZ03uMxU/XoJ2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GAkPjuqyCI3ih867ONwHj9zocJTHVpePXXEhqNH2PAmTypIr2xM1BTiifqGG3GvYK84HFracWMWItdhjvfnthFTqOJNy5lYBz3oUDJVnjuWEjt+GKccgsv6PNx3uiCZHaSZ06dja/yAUzUdiBOMS2yXqP0STFtSVZi/cb+0G9SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=io6UOnYz; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="io6UOnYz"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82f83bd32efso3902383b3a.2
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 20:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776829046; x=1777433846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIbE2CkCL1kyhvQMnbjhjvSPF9qqQJuz1iFO3ISmZBA=;
        b=io6UOnYzqkm4hhKS9U6C3OZ0jNcaZn6I9ewGyyhd26PkC7be/LAbvytMDr00popdgn
         aYeyFeTmlLuSmZ1MpNmcRgWYPFxw5tqzc4+xfpDZ4FcYu2XwxBCobqDvU13dj/HHUQbD
         erO+Ii0Rfe1pOZNQgPZVaDjyLxA908Cy6G6x2Lu7S1Xok2Txk9monldtI8ql9x6NH5YU
         aO2nh4oWTMZtDLPZkORFSZfsTJF7tHTLnvG+CMabcMdwoYtoth0PKM3Jrp6gvWMAKFAp
         cvUO9q6VbUSVPa2QvCSaBGpO6KhUr80cXA4V/kdG6elhiWqQqf8E3WHT8onSGPbSx6bt
         F0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776829046; x=1777433846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WIbE2CkCL1kyhvQMnbjhjvSPF9qqQJuz1iFO3ISmZBA=;
        b=RuRfDu/OR+IMAAur+2KPssQuwPnECUgVadH6iGrjhZqL84PaGFg7qpFHqU8j9q3Zd1
         +IAN2ToVy8R+DjtWgIWeGhUZoYtZeLli9gFFH9tSqLfkGW8OBcqzgxEa+3uzW+kCD4Zc
         Ea68I5ohlKCv6lV391G9koaYVP+qy1Q4gAvD8kf3bnzKLe5U74H+QljGopER1Ofqn8Oq
         ew8hmbveTg3kAwFRJTEG8X/m5ESawFi0Z572tOso5/lQjtJhaxKVVAypKT/BBQU1y9BX
         1PnXibkgY+Jp/1No8LFIpF+dB6tjN2BJveLaUCWMEhqGSc8/fO89dd4cnQwqOCcmw3pz
         5kvw==
X-Gm-Message-State: AOJu0YxBPKYhmJ5FKSx+cu1hlU9Oo6e9IaDNVqID8zOp3NtPxiAsZMl/
	9aLs3DXKmv9GSvfuTpaaa/t9s7cKNmmoxWxB1BK2ZWbWzVV8F1tAEEnF
X-Gm-Gg: AeBDiesV1HZp8aZc3U9iK+3aiEqFYk2LAe4jqz05+d35pA0Me8tIhmba9HztXERloDh
	RgUYsbTr77cHQN97oFA10wXWZojzMEKlXf5z93H+lN8t2ibEqGHbhiiuU+o2ztCm6G8b94I1Dvr
	5plQs313PoZkVQOVluhUxex3/z4RLWnyQiOrZCP3OK6HpNuyBOnj1bLWiaLZRh0jLtmina4tVSO
	lRZ9SIT8TBIXrWcb9MNrXe5RHjEV7UzyWTyyWeAQG9OF9H8dtE+5Bb/0M6zQ9VcfK2o60AnaNHo
	Iq7mQRhLvFIsmmV7a7yd4qxOZpmsxxVN2D8lKRAeg311t7xhXc2wbiz+HKEamxof2ADqL+nXvRB
	3OswQ2F6hzG9aAOxFC44sGu8pkOhRgWG5S+Of0STZxoDu/q0ttJSg5MycdJiPkBdVPWjKZ2KnIy
	e9EhgEPHZjI1dk9PoILbe3Bn99Lo2gA46kdnaxvPkPonFlUfqtrqM1uOlXG6RywZvS12YQ+WkmK
	2MyHsEs
X-Received: by 2002:aa7:88d3:0:b0:82c:eafa:8863 with SMTP id d2e1a72fcca58-82f8c9501a8mr20628593b3a.49.1776829045684;
        Tue, 21 Apr 2026 20:37:25 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981c07sm18355473b3a.1.2026.04.21.20.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 20:37:25 -0700 (PDT)
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
Subject: [PATCH net v3 6/8] xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS
Date: Wed, 22 Apr 2026 11:36:48 +0800
Message-Id: <20260422033650.68457-7-kerneljasonxing@gmail.com>
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

Fix it by explicitly adding kfree_skb() before returning back to its
caller.

How to reproduce it in virtio_net:
1. the current skb is the first one (which means xs->skb is NULL) and
   hit the limit MAX_SKB_FRAGS.
2. xsk_build_skb_zerocopy() returns -EOVERFLOW.
3. the caller xsk_build_skb() clears skb by using 'skb = NULL;'. This
   is why bug can be triggered.
4. there is no chance to free this skb anymore.

Note that if in this case the xs->skb is not NULL, xsk_build_skb() will
call xsk_drop_skb(xs->skb) to do the right thing.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index c49b58199d2f..5e6326e076ab 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -776,8 +776,11 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	addr = buffer - pool->addrs;
 
 	for (copied = 0, i = skb_shinfo(skb)->nr_frags; copied < len; i++) {
-		if (unlikely(i >= MAX_SKB_FRAGS))
+		if (unlikely(i >= MAX_SKB_FRAGS)) {
+			if (!xs->skb)
+				kfree_skb(skb);
 			return ERR_PTR(-EOVERFLOW);
+		}
 
 		page = pool->umem->pgs[addr >> PAGE_SHIFT];
 		get_page(page);
-- 
2.41.3

