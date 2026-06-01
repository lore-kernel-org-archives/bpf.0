Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA90737268A
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336482; cv=none; b=W2JmBThxb6H6OK8FdCJbd+BKUQnuNTq6P9Fm0BGspJWO4JA16dtcLeeQbtB8c4uE1Tw/JuFcKa2oDzmT9ziiWqDfKY+maQKWxIKmsy1QiCLmoDYqB6W524At86C92dcDkqFZhy1j7cSEj61z/7wF+quYUYQ6xZKa3+71k7KPJ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336482; c=relaxed/simple;
	bh=QuWfugOytXeO0b1wxF7bijlHGp2GMNN8F233BLpEMgg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S6JYzGDZ+x/J017km7eU9BWc4kEDkb4pIMXgpGc+iqBpy6tQFPGrY4zEvIVqpU+m0HThEUgBA9V3yRnTHK0hGMXK1dMcYwkpmNBmNAAHihDVDNZ9n1C6Ibst4QobBi9bTbITCm9toYyQYpDM9rCUOloxc0JeTv/ej5qHUdOdJ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P8F6f95b; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P8F6f95b"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84235f9b91fso1405473b3a.2
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 10:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780336480; x=1780941280; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tWseiq4uumqZ00yU9HO4tB0QQ4Oyj0zXYc8zVlVyTfE=;
        b=P8F6f95b7KJdDMz7iffRimJstrr4lBRbF2McyRW3+7yQm+Mw9wmr3sjKng7fZmPFPi
         M6sZBZgLzhhq6r3STjl3BABjdjIMn/VCfyqIgQUsI5QZu1peGEPbpNuZmIiNsSG/XmuI
         +ROl6RPEQE70Hv3vHt/cyMZHk/eSrh0+Ik37q0Ff2M4gFrc37eMqjQeaYLycGflpG/6B
         aOqhXQGZMjMKv8fyKMFNCbMqt1j2nEMiM5fBq8XvPXY64qZwEfIlKcEDTd1ZN17OlZyT
         HmYHbSn+9WgZ5dlRxFvxjR3xSClbMnLx9ttTDxP33TQ1gmJ7lMRR4XzlQZ4qNkQFynBH
         CaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336480; x=1780941280;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tWseiq4uumqZ00yU9HO4tB0QQ4Oyj0zXYc8zVlVyTfE=;
        b=pXvf0ATZmUGPRwfSrpMfr3s/eyvftqJ1RFUS1ARyT67Naj6UL9z4Q8brbFwomnT2eD
         tU//lRzNdSG099vxNshDP/ZwrgSmgoWzmCK+MwQxJYbrCk7qD8PxqDwBGDShmDL1VrON
         c3/HUAD7XEVtUqCHXzIwQgVLEf47KgZPrc7aEyIYkibVKW0KuGrX11LgozPvUIuj6dyu
         Kq9BRGYj+3254VOTyaiy1tPrfzumcuvCFdu1ddF4Qj5ilSBDnYeKO+9+gpV9HMHCHo8/
         WzwN5avsFWBQPPdcYH0PgxfePt8JBrcLU4Cm+352SkuR/8bKHWMWYQHElsnvhkNaI70J
         Iz7Q==
X-Forwarded-Encrypted: i=1; AFNElJ+EC4OKg0CVn7Vf97NLxlVbJKoUgW6CR5vpe1BYaQMiQ2ZxM1BbjQVNmXFDonSQc89yy2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YynL2JQ29HC8kePY+i0694dY2NQGs1hm67ITnMBZH177PnsxRy6
	3XmxCjVhjv/DvArxmmASqaRFcZ85Dhj05aA2SK3TEWdHhGiBCmraRiQ9EmxDP97jKhX3dGdtyPk
	Sq3ez96QWy+f3K3G6r+7SXiI7Dw==
X-Received: from pfbfs2.prod.google.com ([2002:a05:6a00:8182:b0:82f:6e26:770b])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1a90:b0:842:5719:455b with SMTP id d2e1a72fcca58-84257194b05mr4280757b3a.42.1780336480081;
 Mon, 01 Jun 2026 10:54:40 -0700 (PDT)
Date: Mon,  1 Jun 2026 17:54:23 +0000
In-Reply-To: <20260601175437.3767283-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601175437.3767283-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601175437.3767283-2-hramamurthy@google.com>
Subject: [PATCH net-next 01/15] gve: don't pass in unused parameter to gve_adminq_free
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com, 
	jordanrhee@google.com, jfraker@google.com, nktgrg@google.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Clean up gve_adminq_free to not take in an unused parameter.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 2 +-
 drivers/net/ethernet/google/gve/gve_adminq.h | 2 +-
 drivers/net/ethernet/google/gve/gve_main.c   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 0d5a67523cba..d8d47a0c19b4 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -385,7 +385,7 @@ void gve_adminq_release(struct gve_priv *priv)
 	gve_clear_admin_queue_ok(priv);
 }
 
-void gve_adminq_free(struct device *dev, struct gve_priv *priv)
+void gve_adminq_free(struct gve_priv *priv)
 {
 	if (!gve_get_admin_queue_ok(priv))
 		return;
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index e6dcf6da9091..9fbea0cc6513 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -620,7 +620,7 @@ union gve_adminq_command {
 static_assert(sizeof(union gve_adminq_command) == 64);
 
 int gve_adminq_alloc(struct device *dev, struct gve_priv *priv);
-void gve_adminq_free(struct device *dev, struct gve_priv *priv);
+void gve_adminq_free(struct gve_priv *priv);
 void gve_adminq_release(struct gve_priv *priv);
 int gve_adminq_describe_device(struct gve_priv *priv);
 int gve_adminq_configure_device_resources(struct gve_priv *priv,
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index e4d78ae52daf..30bf6df4ebc5 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2506,14 +2506,14 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 	bitmap_free(priv->xsk_pools);
 	priv->xsk_pools = NULL;
 err:
-	gve_adminq_free(&priv->pdev->dev, priv);
+	gve_adminq_free(priv);
 	return err;
 }
 
 static void gve_teardown_priv_resources(struct gve_priv *priv)
 {
 	gve_teardown_device_resources(priv);
-	gve_adminq_free(&priv->pdev->dev, priv);
+	gve_adminq_free(priv);
 	bitmap_free(priv->xsk_pools);
 	priv->xsk_pools = NULL;
 }
-- 
2.54.0.669.g59709faab0-goog

