Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B813D0903
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 23:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444747; cv=none; b=WbT/zaXu75gVWEHNXD58qrucWVjfeTO9xaX+9o9OLSj84KBQgeWeXvI53OH3wXwJIh6m3WQbotnzrvjOS9xqgkV+flqIT38DYI7u3CTDI+NYyBD8EkZq4wKHzq6Cknb8kTFoE4VDS4g+UOmZuKGDBxGGqH9d4n/4tWZN2inH4iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444747; c=relaxed/simple;
	bh=Z8zc+t9FysG/A3238K7QuL+tz/0ZsCr4c3rTv316V70=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XCXRcciBuxtzxkfGM853YLjtvW34VkRqqoTuGl0Ql/PVIYSI9QT7/W/c/RmeiRk41vcPH8uwQSZ8LhH5rKateMWuiKEncB6en3fym3Frb5RTE3H4sBdFN8HMOAwxUbA5LLq6Jml0fzqnev4M2w8lMtJbMVYoaA3jNKLDmNkwBgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=husRwNDD; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="husRwNDD"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c857fa2706aso2084949a12.2
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 16:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780444743; x=1781049543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0hfnKBitry7RLyqz55UndF/vQw9Tta7wZyRyA2fbEyo=;
        b=husRwNDDwL6ig0MoCxA7CRrosjjFEPir7xzRBrhYaNTxtTwPASLKGr2FmdejP9TcRi
         fbdQvz1NzhMgVcYi0Nx4Gy2/aRYFM24qTObdN1OMmROqzSeZCEOKczMiy7oWZu1hCEjD
         WF9xn8sRjI0OO5c+lh39IOdhgzIND/a6lWtswLgThc4JuyAEx/axz1AkspVTVWjHnXiI
         BJtx0dmOxAbC69hztd+Zpl9MJ5oM7K4ZPvWhcEXV7swJumRaflX0SY2i3knpXo54G2ti
         KEm30bpWZUNE2ZsUmzWU1JyrX35Z23X4He7KnYm6idIDBddASwbG+CJIxQX4BJ6keMlu
         ofWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780444743; x=1781049543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0hfnKBitry7RLyqz55UndF/vQw9Tta7wZyRyA2fbEyo=;
        b=D5WrSXYdx3JjV6WXGu6tUd6bxIPaw/r2M8YJXPk76XGOWw9JP9Is75tbYH4p9zLbVp
         Nib3qy1TXQe/WW98C3heYO/9F7HjmYpJ7KWPKLpLzIPRSF7CE9MFuYvORbX/6t8YnHIZ
         pMvrbF3XQvZhXqqpxDcaDODClnZM1WBIzi98cLxaiat4NwdKje4lJ4fGk+dlz4mDpXId
         IR5/w9ImyUPloYCjhZgoke5D0FT8NI4cDo+E8r19L6BApqtgjRHibGaXugHRzv7b5hBT
         zG70jWlVme0RQ5M1EveQA/pszVbAOgxVqTjunCCBulELc4YUiWMxo+m0DxEhI1QmfFVJ
         1UKg==
X-Forwarded-Encrypted: i=1; AFNElJ/PrmslCux8WjbvsCGgOMtDCQjpNDkBf/9ZIKiEw8iPW95/N1YZGGO5E5FQRU8Ay8axqyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx4mFbBZdrovDuRWsz+5Cf/9uaoijw+pBzg60glkZUcErXdpm6
	iik9snCQje6bR2MOMeERqCZIZhohqe+V1M5vcTdCquWZw5kHe/EoFcG1m5Rwej88TTj4Xuq/n4e
	e9uSnDck5pMGOzC5M2pjb/85VYg==
X-Received: from pgcl27.prod.google.com ([2002:a63:701b:0:b0:c85:104d:a751])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:c786:b0:3b4:7c33:296b with SMTP id adf61e73a8af0-3b497869594mr938429637.32.1780444742913;
 Tue, 02 Jun 2026 16:59:02 -0700 (PDT)
Date: Tue,  2 Jun 2026 23:58:45 +0000
In-Reply-To: <20260602235900.3050782-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602235900.3050782-2-hramamurthy@google.com>
Subject: [PATCH net-next v2 01/15] gve: don't pass in unused parameter to gve_adminq_free
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
index 08587bf40ed4..70ffed8b52c3 100644
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
index 22a74b6aa17e..8e80f36116ec 100644
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
2.54.0.1013.g208068f2d8-goog

