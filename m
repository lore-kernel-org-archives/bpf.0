Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33138526A8D
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 21:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804869; cv=none; b=rw/gO2i2JNeMqwXd3X/RqlSqnwIzmka4NXP9z26S0fchrqZkhkiixcIcEVpkEaTenqM5jcp8695zd8iunrnU36aa1JC0/FxoDk39RWIXrvi3xheECUMWN8opSv5gA3pI4v3k6rLGa0DnDKTS1afUG57MLdusFPYzMlERYQQ5Cfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804869; c=relaxed/simple;
	bh=fmRUv0rgYENilBBqlQb0+ODvj/lHolbV7pwBrCOH7eY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ft2OtRA73cb4E6cEmBhE+gytphIj9PmE9wD1Ikg03PPtSVstIS/UE0vLOrUc8rjoA9ZC25uEX7jjD9rKd2jdQZsoZ8ZNIceafYRI4wWMvIvmshQS40wECCj/+AONm66bSoWyzdOgk/Miej3Ak5FG4ShWWbGEFz0y105nwgUh8p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tR+ZKzJc; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tR+ZKzJc"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3a0be20102fso5573858a91.0
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 14:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790804867; x=1791409667; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sie3jAJkujJ1GxkZsQETdrfF4K98ZdkI7DVnUVfTI68=;
        b=tR+ZKzJc0u/Nj4vF4zkP7ohQoSV9c6QuwFW8ZotKDPDYmzwI+iRyW0T7+/c/+RIwHN
         /JKklG1Mb1BQqxzWs16vWJoXGggvrBInNRO1FJzTkBiAeTP3541z9Rjd5Z2/5/QmeMGt
         JOBxZo0PcZP3Rb6Qp78+v6VpEurfVv9X8jWXe7YIkS+tnXAVy3VQTtij/IH+tclVgKi7
         0/bHL04iKHbPvwO8A8r6JodORYXBayfKAqQLTN+rnnkVdwvXbF2PgeXV8L7Yz45FMLAf
         k7n9yoIMyJwjHvSOfauqLWY1HUlvoAB7tYuzJad6FxebSzPhhyEza76JJfn9M/GMDXaT
         blxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790804867; x=1791409667;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sie3jAJkujJ1GxkZsQETdrfF4K98ZdkI7DVnUVfTI68=;
        b=rqyTasiSMqc6AFNDlFD2xZyWjv3wsIoUd7eXkPqMXU8s60I92C3EwbpsrkEeW1oV6t
         WNWnT4jT3Rj3lpPIYEmdLRSvANxX3aMJ6dIeiFoksl9Dkww2Z5fbeIKDPjzOqn0zTA9q
         Me3DV5rzJyPbIjSLbE9OH9TYVoOKXz2c38RDMF/VZO0h7OvgI+t2mDhpiK6iocK2Dl4b
         77efasb7ND/nLTqYl0SkkhPpB2++uuBcR6nHzlN2hIhg4XT8UFr+6KaZOBf6BwfPAARu
         MdTQam5A/kcInhcuoHaMC890WTO4LdpNADEx98vQB7pBafF7q4FIWotE0hpcE+lsoVp1
         pKFA==
X-Forwarded-Encrypted: i=1; AKwUvBxR39bZCJjHkyIXQ3OzZufofWFlUgA52JV7REc+KQRIxpZCmN94xdavD24Khc1WU0J7XcE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIuy0gOb3QMQLQGSl12r9pM9mbkxyJc30yfx+9Htyt9zfnC5RgJ
	poR7uVMXcatwXvuuhB2GeDRDfeK0p7Avu9uUL087xJsr1bl18efiSZWh5+3Fi1IvVKMjTYoQJg1
	kAh7o58X0jf7aGQ==
X-Received: from pleb19.prod.google.com ([2002:a17:902:d413:b0:2dd:5303:f008])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e7c9:b0:3a4:85c4:68fc with SMTP id 98e67ed59e1d1-3a4d1545a03mr2457426a91.29.1790804865442;
 Wed, 30 Sep 2026 14:47:45 -0700 (PDT)
Date: Wed, 30 Sep 2026 14:47:35 -0700
In-Reply-To: <20260930214735.3288780-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930214735.3288780-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930214735.3288780-4-joshwash@google.com>
Subject: [PATCH net v3 3/3] gve: fix napi_disable deadlock when attempting to
 disable XSK pools
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jordan Rhee <jordanrhee@google.com>, 
	Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When disabling XSK pools, GVE calls the unlocked versions of
napi_disable and napi_enable. However, the netdev lock has already been
acquired before ndo_bpf is called because GVE supports queue management
ops. Calling the unlocked versions of napi_disable/enable results in a
deadlock when attempting to disable XSK pools, as the thread attempts to
re-acquire a lock it already holds.

Update the NAPI calls to use the locked versions.

Fixes: 606048cbd834 ("net: designate XSK pool pointers in queues as "ops protected"")
Cc: stable@vger.kernel.org
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 9cc343a16271..a6c18e2431cc 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1708,17 +1708,17 @@ static int gve_xsk_pool_disable(struct net_device *dev,
 	}
 
 	napi_rx = &priv->ntfy_blocks[priv->rx[qid].ntfy_id].napi;
-	napi_disable(napi_rx); /* make sure current rx poll is done */
+	napi_disable_locked(napi_rx); /* make sure current rx poll is done */
 
 	tx_qid = gve_xdp_tx_queue_id(priv, qid);
 	napi_tx = &priv->ntfy_blocks[priv->tx[tx_qid].ntfy_id].napi;
-	napi_disable(napi_tx); /* make sure current tx poll is done */
+	napi_disable_locked(napi_tx); /* make sure current tx poll is done */
 
 	gve_unreg_xsk_pool(priv, qid);
 	smp_mb(); /* Make sure it is visible to the workers on datapath */
 
-	napi_enable(napi_rx);
-	napi_enable(napi_tx);
+	napi_enable_locked(napi_rx);
+	napi_enable_locked(napi_tx);
 	if (gve_is_gqi(priv)) {
 		if (gve_rx_work_pending(&priv->rx[qid]))
 			napi_schedule(napi_rx);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

