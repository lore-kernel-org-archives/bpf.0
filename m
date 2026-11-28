Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795873141;
	b=wb5PB7c9Yk2UL7HNDGag985iHUCOVob/COczRg77ATsD8HX55PmRbZ7g0y641ox+T9LI
	 cCapCrGjWENiuRATwkXzteK1pgNK3dHmLk19db13OxPpe/fcjI+R7CtTXJ4hMefjt3h2h
	 32Cf5ZMgFq8IrYIqKaO2LRFHVTEAf2g4UCMkZNAG5uUeeuJJ+Q5HP9wXKXa7NxSVxKwb5
	 7w9IKK0/7lWqsd43rsISx8QqYCZEQGuJnuHCHuoSje/YexheX+g5+b198j9ia47N+h5NE
	 BWuwiYE32k/mjOlpqapLBtZwkpaW4jGM/eGx+0XbYBMYevn+7V2HVNa4j8RFBbMC8xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795873141;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=4lDF0vQqikD7LUr8D749WPrms9ik25wN2smo9HvyhNI=;
	b=XQNpA6QG4q+CfVppBw5UG/VdHoSsNtluxwCdwFyyjOO7DZp7RtOf5MSi5gNMRxzhnDdF
	 RzWbxBDt3MyMbQ8tnGnh1ka8Vwa8Bpqw1i7Bqp4qkdRwO2c9S6lIGrfdUpNlQWyUFP5ig
	 cxks/I15L8Xx0uhhZEI/3UwVk62FahF5Z0BWms1nk9q6fK+FE3pYtIuMvvfNIQHGhyGN5
	 AvhW3FhZTZGmqhMymHqq9yJcg1yuctBhHQfEGvfAiDoFzux6TN6XKlcN2ipxNXmCvjnDX
	 33W8mtEM9PIoJkmypxDjFIgvise5+fuDBLBxy9QYjJ93zrcamDY8gnteBNYWb5S5euw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h0ZO1ZrT;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF297606A31F
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 13:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF297606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h0ZO1ZrT
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so94560635e9.0
        for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 05:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795873139; x=1796477939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4lDF0vQqikD7LUr8D749WPrms9ik25wN2smo9HvyhNI=;
        b=h0ZO1ZrTkM9NyNAhi4fxHRTUl0gaVwC4ROmUsoC0qiXHFQjZeDXILFRh3Gx2Ui0U3X
         aIjZ4Hv4vALD2DbtMtViShapkv8q4UyeOGuSesqYT7UH3h1xfxKph+nSaDQHxZM3cesf
         z5lj8NJF3QJRh0Up8YdzjBQmc61O5e+m8XQv5wC2Y+mgJlkFAvifbZWS6d+JPS6GF29J
         /+TRJcWOZ/TMPOVKwndYWEj8nbEnvx3ku6lA0Wm/lZ9m3aVpi6oujiAgdIw2Mbecu0zo
         Qo19v5K9pmIpk+r39p5LN+1tnBklNyhpq7ulkSNEfOSm+BVESD9/YKDkXnEr55oqPd9d
         KMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795873139; x=1796477939;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4lDF0vQqikD7LUr8D749WPrms9ik25wN2smo9HvyhNI=;
        b=gwvAuvXNshOx7bmokdmzeRrqd3DTeslyLjl82/qWnteV+rCIt+81X+tbN0KAYt/70v
         DFvUwT6WLxM5nhUC+cgV874Jb9h/nu2QVAkC0OTocnPOykKWICFEBBJeDjXoUWvGQOqj
         ulQ89blZbFdM0U5VHlj05+Pdpo55u4nwUEtE3jBU2N+0TxfTue51hsW2fAc603vRMd3a
         O/RWeOVa8K+oQgzBfpDJZKl7dFESzhQXEi2QK/0F9dxi0/U8D1q6G/PVtILRLrCuOm2c
         dKKUOxqvY0WCTpVVTqcn78hXyd203BdG8yPrVGwZJWYtTF2nMXOM+0JORlDmI5iEHcsk
         cSwQ==
X-Forwarded-Encrypted: i=1; AL+hErH6MuwTw00ptBQ7FRyK12vryui0XYxlPNxItDqGeVsKvlR5ZeMisPaMvcnaSmyKgz4dpjs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9UP6k7MR/ydYW8KNiMqLPYw3Kw7R5pRGUiOEMSHKL56QxX7Qau
	BCHyMErDco+fhwit4isuXWgr42HXnhG0KgAd7Dwm895KRgyjPbLgG936
X-Gm-Gg: AZFdTZd/Kll+QblSjDmY2MFRxeSB9LyhaSjisZgt5qvfY5Vg+v1GRLwO0tXLyvuNSqU
	PDutVCzZBA5ee6dQnjnb+WQoIhk+VSfw4nybPLUfPcUrATbV+pzdsF/QJeNH1eOSVlItoFkn4DL
	IDCZD39qGn/aB7lwL96jcy7wMhWaREQzcuspDqOjUFitxGarVJOuGkxovEWGTAHIrYThddfdyZJ
	jiygQB12l7CXmZZfxF/z6skjiineBw7Jco+w6zQK4tzzWTmIeyV1+xBgBoDuUt4HxP3xS5oI6rN
	al1wnuRxQyrJEjxwPZbSWgdRFpjrkLagjd3SfKzbIwRjuvfjzb2gAmjsQMS0owFwZDBngK9f6mL
	LpcE8oSFL7TsWN2Za2mi8rBP+4C8MtDcWblnnfXG3RhDV/rYnMvMs4GgU970W4NrZJxKHfeNjyp
	0wp8Kto3bk7s6DcUmgvGHoK3iAPGeDrBPOMYzgeWWSkPNGYzBmtslK94/iTKLdLhoOF3wxrcruP
	Q5D5enOa6U79ICFH5Pp/nUQ5uizA+w3cxXqdPjP39PNSnuS69YoFJsqfSrOpUeNrzwSY9zht9Ym
	Dsq4PErtoXKajDK/A3obl3TuCxRM2XWzU7YGEgsXgTTXJph5ko75HYRtTcIKpO0dinhPK6GDCKi
	atlrYD15c3wHUO6A9MTBPIuY098Dlgy6cQJ+MtaZ8yvIPFwa81ClaZDJS
X-Received: by 2002:a05:600c:a115:b0:4bb:a5e1:74ac with SMTP id 5b1f17b1804b1-4bba5e195bcmr184828885e9.4.1795873139198;
        Sat, 28 Nov 2026 05:38:59 -0800 (PST)
Received: from pc.tail250202.ts.net ([87.110.86.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bba6a0d65fsm295847225e9.3.2026.11.28.05.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 05:38:58 -0800 (PST)
Date: Sat, 28 Nov 2026 15:38:55 +0200
From: Janis Edvarts Lacis <janislacis06@gmail.com>
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: intel-wired-lan@lists.osuosl.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Sven Auhagen <sven.auhagen@voleatech.de>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
	Kurt Kanzenbach <kurt@linutronix.de>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v5 5/6] igb: resume the device before changing XDP or
 XSK settings
Message-ID: <lwmb2es2v4j6ec2kha24lk3uxtour2q45fqvjwihl7ik4auvet@jyhouq2ojte2>
References: <20261124235723.1135808-1-antonio@mandelbit.com>
 <20261124235723.1135808-6-antonio@mandelbit.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20261124235723.1135808-6-antonio@mandelbit.com>

On 25 Nov 00:57, Antonio Quartulli wrote:
>igb_xdp() can run while the device is runtime suspended or resuming,
>and __igb_resume() rebuilds the queue counts and the rings without
>RTNL. igb_xdp_setup() and igb_xsk_pool_setup() can then see a queue
>count whose rings don't exist yet (NULL dereference), or a NAPI that
>isn't enabled yet (napi_disable() never returns). Changing the XDP
>program of a runtime suspended device also opened it twice.
>
>Resume the device for the duration of igb_xdp(), as ethtool does. Like
>the other resumes done with RTNL held, this can still deadlock with a
>runtime suspend already in progress, which takes RTNL itself; closing
>an AF_XDP socket or changing the XDP program is now one of them.
>
>Tested with the 82576 emulated by QEMU by closing a zero-copy AF_XDP
>socket and attaching an XDP program while the device is runtime
>suspended; the latter no longer warns in __netif_napi_del_locked()
>because of the double open. The races themselves weren't reproduced.
>
>Fixes: 9cbc948b5a20 ("igb: add XDP support")
>Fixes: 80f6ccf9f116 ("igb: Introduce XSK data structures and helpers")
>Cc: stable@vger.kernel.org
>Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
>---
>v5: new patch (Sashiko)
>
> drivers/net/ethernet/intel/igb/igb_main.c | 20 ++++++++++++++++----
> 1 file changed, 16 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
>index acd9a33..80ae03d 100644
>--- a/drivers/net/ethernet/intel/igb/igb_main.c
>+++ b/drivers/net/ethernet/intel/igb/igb_main.c
>@@ -2942,16 +2942,28 @@ static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
> static int igb_xdp(struct net_device *dev, struct netdev_bpf *xdp)
> {
> 	struct igb_adapter *adapter = netdev_priv(dev);
>+	int err;
>+
>+	/* The rings only exist while the device is resumed, and resuming
>+	 * rebuilds them without RTNL
>+	 */
>+	pm_runtime_get_sync(&adapter->pdev->dev);
>
> 	switch (xdp->command) {
> 	case XDP_SETUP_PROG:
>-		return igb_xdp_setup(dev, xdp);
>+		err = igb_xdp_setup(dev, xdp);
>+		break;
> 	case XDP_SETUP_XSK_POOL:
>-		return igb_xsk_pool_setup(adapter, xdp->xsk.pool,
>-					  xdp->xsk.queue_id);
>+		err = igb_xsk_pool_setup(adapter, xdp->xsk.pool,
>+					 xdp->xsk.queue_id);
>+		break;
> 	default:
>-		return -EINVAL;
>+		err = -EINVAL;
> 	}
>+
>+	pm_runtime_put(&adapter->pdev->dev);
>+
>+	return err;
> }
>
> int igb_xdp_xmit_back(struct igb_adapter *adapter, struct xdp_buff *xdp)
>-- 
>2.56.1
>
Reviewed-by: Janis Edvarts Lacis <janislacis06@gmail.com>
