Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A543A5431
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 03:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776829035; cv=none; b=hx3oAGTxnaDX21hWACLXHnZHEs5PPYioZkp1JM8RJvFqTou2qpn5ZmStr9WLcyMs0n5tH4BWj2ezX87DpyFWSsA8SEKLhH1GqY+1RnvBpSCLnfNVya7og77vPwEbNd3MtptOzlGT/UycQIMMHqdIOVeF85yOcX9yd7bO90e2Mwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776829035; c=relaxed/simple;
	bh=Y8cIJSbwKxm8IRUgTgVDsnhOlpbwrWMFM1NAxZoC6mE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K7eES8thBD0L1gGqc7+D4LxieMXmPlck0nyNW2ogQwfCqLByKDkMnwiIQs2MguYf52+y8HX5vY8EqutYMI9jounjMUfezEWMH/Igx8oYfR0ZAUDP0ZGoxJzDFqO6U/BIhd9IEFb7vOqeATTPsYuT0U3mmKDRKErGKsE3sJ2YvQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6eeN1yF; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6eeN1yF"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82418b0178cso3067531b3a.1
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 20:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776829032; x=1777433832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q09KfaozepH2LUse2hL0T0apyQAKIb5vyRGtj6T/eCU=;
        b=Q6eeN1yF2lTxcOMSBMhwgS1jiXD3BhzHLCeGT1CKxs/RDl8FKEPCOzukhqLzhtH8YH
         m3o1n61/zV9+rUI92arroaycgMG4gQhDNlDHNtvPPhhlvkkLmJ2FF20We2wUUfUAcDum
         L8ZUS7z34jZgZaAXeRx8gAVCYSaeWqeFd4Zei5G90oRcWmvpVmuSmQFf3YCDdTMbEUWz
         3KFju9Y0VFTLC4ezRZdMF+DnC6Gf84IMd2mV/S2lWvJLER1MB3qAnZhNiQ4qIbYusRgB
         IXE7CGyss9U1GGrGoqADdfyRC+81wnWh3OSOOcVxxCveU2Taf+ppw9JmeoEyO5sx1+Qa
         Qjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776829032; x=1777433832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q09KfaozepH2LUse2hL0T0apyQAKIb5vyRGtj6T/eCU=;
        b=exN5C0ce4HPDncAXZz+/ZZCAJ0/UaJlzrX09JyetEK6cVZmGtf11NcMULayXHBeMQz
         MaQ5G8KZ8bCm0rfHCDp33CRriwWUWm8FapJa4zT9+qUB5b0z5Xfb1MMHeSYvtr8s6VVI
         UoEaYXFSoqOck/U+03Bu+thiK6mNyVtBUKuJrPV1alRBzlALH7yzUC+Z/xff3J5RF6SU
         UTdSCU6bqtO/eFvrFWFXOzE5TSnobSn1d6/8RBBe3Z+rFTnF7atYx92n88NoYzhu7y2u
         dYBTt5ic7td3y5RttPBQR5IOA3hZk/5lnwrcu+JlNh10VziaNmWCPZsdlAW0lUcFRYQm
         Wvfg==
X-Gm-Message-State: AOJu0YwOO9HoKm/LcmpsOnIrtEny01K6ESfCmPnwIrWnMNgFALHntUjO
	P+AeRV3FGkptCEBjyW4H1GeLEoJAuXFIWqY0VI22WAyQ7Nwm+LNZd0A0AJ47uUah6nA=
X-Gm-Gg: AeBDiesFZ9F3Uxe2JAFyi9wvoq8cgp78bcuvqcV6XpO87qnKkjCCAOXOatpvUy65M/D
	gfIXPf7jCoJz9llYiQUZb4pufStzQSK7wByYygGV/DnRvX2J+4wgps4LARcPHv2kCpTgEoQ0fMD
	0r2u2mCl5aYWFcfMWgDfvTQj7B/rznwno7FAWJEBAjRNtTVIvE/Jh7GvToT0HfAf39iyo25DTEB
	Zabo2xoNBHRwleo0u9SWKHElgJWhfJf/diWo1quiLArUEMzj5z6q1MujVfJhav49wIBq3R59kfv
	WhPyDAOhWL5acGZt78ThcbrWWo0OJAw7LyAZSMf6P8iADbcIx/0cd8J3KsdrAoa885XsIFjn+gV
	bXV3L1T0llIiYsgpxEovs35wkjQ9qXo7tmuEvBxeM9q6Qew44gnl4LJN+2CmK7XTkiZTlGf9CMs
	nBnxCK0kDadtMQ+SChjccM/8vtlS8ifUHTYEpO7NsDiNkVQB0r2UaUJCN52lSyolPxQ7Z95WrJp
	2bbuToD
X-Received: by 2002:a05:6a00:2993:b0:82a:6461:6d1e with SMTP id d2e1a72fcca58-82f8c92a5fbmr20231914b3a.46.1776829032071;
        Tue, 21 Apr 2026 20:37:12 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981c07sm18355473b3a.1.2026.04.21.20.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 20:37:11 -0700 (PDT)
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
Subject: [PATCH net v3 3/8] xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path
Date: Wed, 22 Apr 2026 11:36:45 +0800
Message-Id: <20260422033650.68457-4-kerneljasonxing@gmail.com>
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
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6521604f8d42..d23d1b14b8b4 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -889,7 +889,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	return skb;
 
 free_err:
-	if (skb && !skb_shinfo(skb)->nr_frags)
+	if (skb && !xs->skb)
 		kfree_skb(skb);
 
 	if (err == -EOVERFLOW) {
-- 
2.41.3

