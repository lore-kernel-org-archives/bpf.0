Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9141E2EBB9E
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 04:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776488253; cv=none; b=u042qwu0yO/8BM68rPeXyXZ7OnL7Ee7RxPg6QgONVnMBKdi+iiQ8lFGHGFEA01OkU1YgYiHtbfSjAtm9bsy29jOj56Z1ojEBGvHkKCxOAe/9FCw+7ikefYmXvzidKhrDzdGWWgB2DIk+qgJpOiz+BavgvO2dLQsXV8xLi2Jc+fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776488253; c=relaxed/simple;
	bh=3DIIIIQ8qtWzRzN1t+hW53HRIAOPy5kzr//rkIeFXPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cp66ndCyR6g1H1DyljVzdBa5LYQ/67n68qNgvbc2T4WbJRZRklN7nVp6hFWJstEGCzZe6R7m98RWaoghd4pl6ILj13P2C/nQU9F8CSq9G2vql7bXjuNQCUhWZNlx4X28nmhBJ6//4occavXrvrYwH4NNTcuSlf3e+tjClW04fZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qf7Pxihm; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qf7Pxihm"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-358ed696623so615312a91.0
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 21:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776488251; x=1777093051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPVULVHS7ZbCg3hexureS08Z0+NT0ceqMqy/MCX2QIg=;
        b=Qf7Pxihm3gWvvXowugsFy3j3ndO59ZAtG98rG/eDoZrYiJJ5aySxLyio/hRjLb+D6M
         05m07HJbSPJz/cxavpdWOddbNIUQyVvvyv7B6gy51M5E0A0itefXSkx2JI0bd/90lW2P
         vZr3eQkKmUqgGnVhR4QKReli/R4PFvh1U0DZLjrZrF96NiE2iw44Rn/rP0j1jcWt01Lb
         LjF8QAxfPOJ0K0cyiBugBwpdNoxO17gAew+FKbROrpbkesp+dayDPwcQjS91NfYAHFTr
         bjYNbtqqEWSMIMyShKgjtFGI/J5HxGVRkF/n/cxLrzPfPZWSqTfchV0p1EjX1E/goGIb
         J92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776488251; x=1777093051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bPVULVHS7ZbCg3hexureS08Z0+NT0ceqMqy/MCX2QIg=;
        b=RBwLZNXbh3Vzs1aJcEBGvBJqR7Nmh5gfn8gLeMjHlcbOoJo1JiN3oKgbSMM1pRD5BV
         V5jTjuj0PqzSGkWF9avNXiEFjhOySsCoteFPNGeaRA+7J/FVFi/yS/GR6Y+SfQ5zmisl
         tiYLNX+YGg7KWH2rXB0vAIIcgbHr7HNtQJsW/OR54hUUoUF8WJl8ZE6bjw4lGIi20dsl
         RvXeEdkXjJGoZky4wmnVx3kC5KNoqdNfZNQ5R6ME9ejbTRr7AnbeWsTxVfzcGrwPZ6sZ
         MClWJyrBDt8BmOxOEYQVYene+dwMF77hN504UJa/6aC69qB7ojdOPhin7hThpnSr1RKJ
         21zw==
X-Gm-Message-State: AOJu0Yy/4D1uyXq7mj/xTOSegFtraL3U6CfzpqjqDjF/54eE34buqy1U
	X1Q6UyO4PX+x4kMOqDAqwjKuW7huYygJ0rRh7bbs+P45qw70g6fboJbP
X-Gm-Gg: AeBDieuh15WzBc6FTyENU3ZKlnDD9Ty7OzYCrzcsYFhCtVIb07yUR+zQaUH91fdyUga
	OvUWBuByo4XtPTCTYCCg1qL2P8poPuC1fkTdb3O0ARFgTdSJIRKy2OGcst9h8az8wn4kP4WRzhp
	9eRHp64A2C8Al7Bxb/o4V3SEwtqWG9vvzVRh+Nz4m2mtEkCP+J7WI+QcWG1JO9P8bmO6MOLTYCs
	Q4z8SyrgEQ52Esl9XvxJf3d5IqlRZA9S6oXfA/FqjRU6B9eWNJIgfe5XV43cbZOMNoJGWY9uol+
	ZOBuqgo+6pa9a2i9Vna5Dtg5CQcC5okI38RbpPGNWCgpvkgb3TZW9ofyxCCt4V8fdLRghgnYOV3
	VrxfcPMhYpczdpbBupvzP4zZegHtQaqZzdl1dqb9FaxWzTJS+M1m2h5aN6TJNK+/bMpx9iRyNt2
	QQTWl4v6ZX+eOp6iE4LnEu41FUMuypNQxHUcYQv+TqbI7m7lnXD+DUUdu7/hDQkOSALNgr03UGR
	5QrfNrnow==
X-Received: by 2002:a17:90b:52cf:b0:35f:ba3f:e04e with SMTP id 98e67ed59e1d1-361403f1165mr5993151a91.11.1776488250835;
        Fri, 17 Apr 2026 21:57:30 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1924:8520:35f1:286f:2ada:eed0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614195a92asm3502377a91.10.2026.04.17.21.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 21:57:30 -0700 (PDT)
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
Subject: [PATCH net 4/4] xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path
Date: Sat, 18 Apr 2026 12:56:44 +0800
Message-Id: <20260418045644.28612-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260418045644.28612-1-kerneljasonxing@gmail.com>
References: <20260418045644.28612-1-kerneljasonxing@gmail.com>
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

Fix by adding a !xs->skb check to the condition, ensuring we only free
skbs that were freshly allocated in this call (xs->skb is NULL) and
never free an in-progress multi-buffer skb that the caller still
references.

Closes: https://lore.kernel.org/all/20260415082654.21026-4-kerneljasonxing@gmail.com/
Fixes: 6b9c129c2f93 ("xsk: remove @first_frag from xsk_build_skb()")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 2918b773aa84..22c7a92e0734 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -894,7 +894,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	return skb;
 
 free_err:
-	if (skb && !skb_shinfo(skb)->nr_frags)
+	if (skb && !xs->skb && !skb_shinfo(skb)->nr_frags)
 		kfree_skb(skb);
 
 	if (err == -EOVERFLOW) {
-- 
2.41.3

