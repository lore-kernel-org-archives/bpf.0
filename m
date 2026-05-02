Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7829538C2D7
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777752468; cv=none; b=BVa6JFXkftMiIHs9et0+64jtrB9Vzy+w493YFqH3+r7QMaQl8UMzLNomf7FTIndCnEDITqQ7Udq1BLaedkWhF5pbIzn4hThlVL4sL+9LVF5ZQuQjEkLh3a+v/Mn0A7hYgwA/k1mOt7B0Y5yb8v24uxhoo6J16osHX1KUjFYerUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777752468; c=relaxed/simple;
	bh=FGvDoM9uXVztwtUKgUek9flqeiLXdB/EkIyHK8t010c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=buhorgn/zJYdeqRFKtaxs+cdLGZAT4JNkI3Lpku25stNmPFHOlxCMGnGPJ1kqt2JGZ6/bQuWMni7cbWVxljg62bDLlMdS1hcdnvsViNo7LF+p3aSaHLiN/PsDbEp/pSfCXAB0hnaRGwhLeVFsz6fGaC0G9FZHSlHlaP0eZkgh5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmoIFbJD; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmoIFbJD"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so5651136a12.2
        for <bpf@vger.kernel.org>; Sat, 02 May 2026 13:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777752466; x=1778357266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCgbdkfklEvQqwpphvtN/a1Cdnlt6OuamWeTRxx8vKU=;
        b=DmoIFbJDRPSIvEomWGcTisLu9jv5H87ao2MyN3AGqTWni116TBbcAC4I/Us+rcPsRu
         FeDZUThnkk2MH7Igz+4BDBrj7IG3uK2jV6Imigy4u16rK+Ex1M8twaqW8K4E1qora66Y
         XlyJDhtKpyYGHLvWidFLhZBYjQBlBclEtB76hAs0OKmQC3rCNETJd9ftzCTmoBywVyAp
         ERxk4JJpgfXtySPXYBB9KmMGCB7O7rxLg1BzFEKSTI2pI747lKHdOCoul3S09i8m24vX
         Z8N1m6lGkETAg5OT6FW9Nu5JuYEZkyrH1n+/SHeuj3N989YD2u7/2S33MlJ6LfWVD5/b
         pJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777752466; x=1778357266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fCgbdkfklEvQqwpphvtN/a1Cdnlt6OuamWeTRxx8vKU=;
        b=YVr5fBCEoeUEpNxqYdmRWC2imwhdip3UNOc+aD+9IwR8a9SqdDRgDFr6EemC+EtpZT
         iO+RI062gHNEifcjCTINbCEFKDdUFciv0hux4rG764nZBAuyDfwyY8bREsb3nDuopj5b
         QBNY2pujzAChy17A/Cl7RljiDV4eC1kja22jrj4uzXOJuFezADzS/B52/+aMY4W3DKA7
         dx39pX80ar4iNLPMzI75i7ThIJsAAE5KpUgK8LB3anhbwr34ZDvgQQXDAZ/u9bflw2v3
         x5fu9IjD831E1DGOzTQiPEfBS1ntIrO5WCDXxqpQsfSxkBxDuVwWmffSXfthSUIZJ9XF
         bKgQ==
X-Gm-Message-State: AOJu0YynPrXyM3aAC2lrZsQ+6yV/0BKuHOyv0t7ax1LqzbZPZ187ViYU
	aVGDT0IFzW02s3VZ3y+Z7ZYwTNEuiG1Rw/TOT6TtnUZfbOwQkq62ukQW
X-Gm-Gg: AeBDieu2EXyCiPr9H3pYauoWufbowse6Yo+A62FpUfT4N5c0evPU5zwnNeUq3NjPM+k
	3tryGPAyxg9a1fUewXuLGq+K2XX2HaWQHw8ND7jYK12cfb0jjjD7JZ2BKPN/K3gG3jNj9ZA7ezJ
	plGdOg3teYhuaOak4IUQ1V4KDWyHNQqa06zigQUfmVYG1rLq2w74Bkic9kPJsfzQl3XZ7uRqAau
	+uzggCCCAZCMbGIK0/Tebprsmudz0ELTi2Mdn+kPSKHEy9iCZryv53D1OApqXsfNwhIO0pImWb8
	UB/EEcIekQufC9wI6RwkVZnlnjM/uFVoiC7OPQMJPEFxeRUIT7Xn8aJj/2I0pmoMsEJHBeSvxwH
	NbPBVHpnd8oCQQvy3jfwytvcx31KF8DCV9MM+6dwaD3LBK2Cn2nzxxw98+qbQe5gvOmYQ5eiFE4
	vCAhNbO4DkeAtq6ILIR2dBhxoOU8VfA/3zbUVm/R007qUt8a/g5CNEw7NImhtzRN7kiqwTtgODL
	aM2iC9BeqyuFfmGHBkVwdNRxLwz
X-Received: by 2002:a05:6402:21d2:b0:67c:1fd5:32ca with SMTP id 4fb4d7f45d1cf-67c1fd535d2mr984867a12.21.1777752465628;
        Sat, 02 May 2026 13:07:45 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([41.128.91.35])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b88094aa4sm1902528a12.24.2026.05.02.13.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 13:07:44 -0700 (PDT)
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
Subject: [PATCH net v5 6/8] xsk: avoid skb leak in XDP_TX_METADATA case
Date: Sat,  2 May 2026 23:07:20 +0300
Message-Id: <20260502200722.53960-7-kerneljasonxing@gmail.com>
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

Fix it by explicitly adding kfree_skb() before returning back to its
caller.

How to reproduce it in virtio_net:
1. the current skb is the first one (which means no frag and xs->skb is
   NULL) and users enable metadata feature.
2. xsk_skb_metadata() returns a error code.
3. the caller xsk_build_skb() clears skb by using 'skb = NULL;'.
4. there is no chance to free this skb anymore.

Closes: https://lore.kernel.org/all/20260415085204.3F87AC19424@smtp.kernel.org/
Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate function")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 13bacc11fa9d..5e6326e076ab 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -741,8 +741,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 		skb_reserve(skb, hr);
 		if (desc->options & XDP_TX_METADATA) {
 			err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
-			if (unlikely(err))
+			if (unlikely(err)) {
+				kfree_skb(skb);
 				return ERR_PTR(err);
+			}
 		}
 	} else {
 		struct xsk_addrs *xsk_addr;
-- 
2.41.3

