Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601357;
	b=1TYPnja2taVcp7TPJ1SyOnecePH6eyNni7Wli2SukEUPZU11qXPmF3XNCJLmnd0jgBhp
	 DlTJ0lfiqPYLfpxgsOqzGv0S+dDi58/CBqYHbw3hGoKLoacvVg2R4Ym88lZ+uUwbxzbVu
	 PSDpgJD5lquhwUMRvWJMRpiVUGPw5Q7hLZLXW8alsrzMj/m4fm35znAcnBas5BMQa61oh
	 A6ZWOUxtjHhBo5pZ98tlntmQJKaalv3JUSBTELNcecr0DoxRoDraRZ+0tYxa2VKC2n7lo
	 bm/OZhYxBnhC3A4/4ZbEFNLoG9JMBI1eR8zWDRgiNvX5AzHavFA38YLKMFjwqGf+AOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=KIQ4ZqYz7cbk1WpqhsyeBWWR103C0oZ7ZXL7of+RMlw=;
	b=gOeVGylj8p6jsIRT5DpiQ9ryc/PTGdEWDtaz2iSP3dmKxpq63fwnNetNHuhxIt9kR+Ul
	 WBe7wOEPt8Y4ryR9Ke9JGJAEfUuJnR4WnCmPoHTL0VJXu3OXfRg8ZkK/rMLsfcrBj08iB
	 QBVUjXjzM40kp4gNIxFy/qt7g5DNZb+H3oJVzAtY4Zvts3p4L3Bu6yiZmX8beML1Sv0En
	 upZxwp9KM5YgXjZweQw2hCH7W26dbzfiYuupRe+wf8hXHu4S6slnSnebGbmgxnsTxlc9S
	 A/zmYgnouGAfIjvhLKPR8heah26dfNWCerTT8L+vs5MnHRtcYrWas4/VGhRS+r1Pe6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g3ArpmUt;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F021606A327
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 16:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F021606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g3ArpmUt
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so30304a12.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 09:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792601355; x=1793206155; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KIQ4ZqYz7cbk1WpqhsyeBWWR103C0oZ7ZXL7of+RMlw=;
        b=g3ArpmUtemRDXn9NQEm94F0hdVHhOiv0ZuJaCx5uSGUxQVweKsEwXtcqJxfA84aNFk
         OZ6JwCSsz6kaHDHQMswYeRY6wuBTnS6rG1PhlBHD2/bIBXCJgjLuwSEkcq4vDp5iETnI
         mCEY0xOP8mFZUVmIp3/9UlrHArGSbiPvex6ywHhHktgOVAaV8G33PLHvt9M94P0qCdSZ
         ixlKFiXVMyyJ3r9qg0mzMFTGnbWL4Iq1uVQKcyBuqeJgmi/moeRik5Q2zoYV/DzEg3VZ
         4mAPiF2xQCrXCJkUmhKZIqbpa5tdu2Xh4gZC94fVEff2wuwu6Kzlx4ylEdwrA5bHxthu
         Wwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792601355; x=1793206155;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KIQ4ZqYz7cbk1WpqhsyeBWWR103C0oZ7ZXL7of+RMlw=;
        b=Ax0hVMmK5nbzaf73Mky8UwczKGIfcdOuY+wxNHpSObiOWpL5mVr5JF985JGxvG+Mao
         zrNXtCWdAZ2yYMbNilIUjJRWUXUjfRfdebL6neeARHmO3KuKD/70PEPhBuSuFSyNq7gQ
         DBPBU1PMiiymwLOLJQo3EyHzoUb0jZBZNtNTEIkS+pCNAz2x6bb1HycE2wxysK58L8fQ
         z6uBHcQp0coMYWJ80kskvvQY8Q5atSd8nhczOrkCCpvk34sN7xiVmRkJZaVyBiYhdOL2
         x5fXxsOs3rSPMalwM13/BYd9gSROJZJnA8DsjXGVL0BR+YPBeQu3342gYEit/P5CjYo0
         xygg==
X-Forwarded-Encrypted: i=1; AKwUvBxBXOZFrA+ZEwAb+1Urv+D2fiuKpShQ9837uXazjG5H3z7LEwjWnGE0w5tbyWEHmO8EDLw=@vger.kernel.org
X-Gm-Message-State: AFq9FYINPbzRDyMoN92SJLf/btBNisYenrhgo54T2jKqhhr25WHsR6xl
	Gu6Lr/SmE2jVtiXefJVkiBPBhg3J27xqCJomIcM08wOnnBuKgU3MW+y3
X-Gm-Gg: AYBFou0y1PKFglMjhwZy7r/S0oJGfA8q98ZKUERxOmVsB/gHcCgGFZrIan3Qx8exG6X
	Pc4vjCiKaWdEdEcJL2iN+EUYyzAYkgbHj19DNzoffDRD5Q98PoZpmLr2k8EKe+V5eJqe+RWN19o
	RxbFSTF7TxKpxDCHqI82ZlQrQzzqqRF8PiGuGPle0syMXbAlcUFmmInCwbbtV1k1NVoNt4FEojW
	GuuaeBroABsZNTmSCGUVrknJoDwIuF4tZCJt0jS4xZM6Qe+mkc1U6qhZlj6lvZs6JI19vvW7AK/
	lZjWb7uFkEjvwF2TYzLPnncrcI5v0HNbWcAuRv8dVz8LN9isIKhtfbZDez/ZL8V30YS6NTSXDUc
	FWWVryT1PUo5ulpe1u4Mqapm3SJWTVLSxt/XxJsmApflWVToVBnMh6w5JwJ5jk/4f/Iq4mUmD6C
	Y/YuTiinUOBjfSnn6hCX7kqOPchYwAWgIUIzvqL00LaRzviZWUpxmt/rHIOddBsWVkobWceZZik
	Np7T8O5t4w9+R4NiIA/KZBb00G/LIFxaYl9uiVY2hpditmm2pbLR5LQ457VW2UzEqZ5RzMy7kpp
	1R19nYlLviANwWsm5//HM2QLfBKGJa/iKuEFLf45IoHOVpg6kq5oW4Rc27WZlFx4+SRdwnjRUnM
	qxW0KDA==
X-Received: by 2002:a17:90b:2ec3:b0:3a0:e568:ed63 with SMTP id 98e67ed59e1d1-3ad86e96c23mr1512780a91.8.1792601355483;
        Wed, 21 Oct 2026 09:49:15 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4896c71sm279247a91.6.2026.10.21.09.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 09:49:15 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 16:49:14 +0000
Message-Id: <DMAO59MCJM9Q.19D7DBRQEDHLE@gmail.com>
Cc: "Willem de Bruijn" <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Rusty Russell" <rusty@rustcorp.com.au>, "Max
 Krasnyansky" <maxk@qualcomm.com>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH v3] net: gso: validate transport header before computing
 segment length
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <52b8bfe4ee848aff8ace47752352de486171d45f.1792596586.git.mst@redhat.com>
References: <52b8bfe4ee848aff8ace47752352de486171d45f.1792596586.git.mst@redhat.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 21, 2026 at 08:31 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> No unprivileged path is known to produce one - IP input resets the
> transport header to the parsed position, local delivery pulls data
> exactly to it, and tunnel decapsulation clears it altogether - but a tc
> BPF program can leave one behind through bpf_skb_adjust_room().

As Eric said it should be fixed on bpf side.
It's a bug in bpf_skb_net_hdr_pop().

Something like this (compile tested only):

diff --git a/net/core/filter.c b/net/core/filter.c
index b7ac145..ec47f26 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3417,7 +3417,6 @@ static int bpf_skb_net_hdr_push(struct sk_buff *skb, u32 off, u32 len)

 static int bpf_skb_net_hdr_pop(struct sk_buff *skb, u32 off, u32 len)
 {
-	bool trans_same = skb->transport_header == skb->network_header;
 	int ret;

 	/* Same here, __skb_push()/__skb_pull() pair not needed. */
@@ -3425,8 +3424,12 @@ static int bpf_skb_net_hdr_pop(struct sk_buff *skb, u32 off, u32 len)
 	if (likely(!ret)) {
 		skb->mac_header += len;
 		skb->network_header += len;
-		if (trans_same)
+		/* It was the same as network header or it was popped. */
+		if (skb->transport_header < skb->network_header)
 			skb->transport_header = skb->network_header;
+		if (skb->encapsulation &&
+		    skb->inner_transport_header < skb->network_header)
+			skb->inner_transport_header = skb->network_header;
 	}

 	return ret;

