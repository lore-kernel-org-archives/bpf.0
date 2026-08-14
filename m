Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB553D3D0C
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 02:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786673651; cv=none; b=jLjoVnPWyay//xRVu+R9WJkEzj6lqHANMiLz0F/mLr0HKDmG0Eq/J2ic1cYpBU625EIO3RhuvXHvt7oeSVQeCmxWJiAHPG1e6IxCO8LGSxcwvBMfYzizwGQuunxaTXHB90p3WR9y8D9jxb3uC9t00zd+6DGQ/6AHLrmtmdV1hvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786673651; c=relaxed/simple;
	bh=VPmC79P00gd0Re8coIvdeClW7MGZeIl+TN2GnYOFrhs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PtJ7Fg9TdviJ7Xr6N2w4hhOVj1HSHXnXUm7ERaUNlpmzM8HETznoeTy7j0KyBXizOgDkMfQeiBSuNQLVkn3NOp9rmnnGFl2W6XTtWB/KmU1wGrDKiP+CQJiBGHScPHt5lcoLu3OInW1v3UgLw8acV8SfHalQgj1gwhoixFUGX2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VJfk5ks6; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VJfk5ks6"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cab3e9cd922so333431a12.0
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786673649; x=1787278449; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=90f9qYSoa4jWz+OMhddSeknprbZZdC0eKrP4syapDZQ=;
        b=VJfk5ks6zr96PQuHI8iUv9BXkgxaMYIbpY+GzSmec1arJ6Mal3XvHOs9A+bR4rHe+f
         6Wqh+CiRLfmo2+DdqGMiBVIrme5P+lVPrv5NXzgspYI2nWEH5bm3MsbD9js33xxSdCmF
         UmJofSiT82ltwFN5NTMcFUW8Ri+1enzcyNM1LsrVhdX/lNst3CP9UJQ9RHwp7HAxaMFB
         KbBcdmcJhIF2CG20208cEQwKix/GKJpgsV4tXkoBx4OOqM6bfbpFRz4ELGeWnY8DyhP/
         L7Pd1D0Hl/cSdF94be2ZhybbjfQF0cAWtrEIVSLjgey3g0qm9EL4UUkBp5vYme/m9/aH
         rmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786673649; x=1787278449;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=90f9qYSoa4jWz+OMhddSeknprbZZdC0eKrP4syapDZQ=;
        b=Rlt+21lKMgnD//nBbnXaD9x00cDiKPam4VdDgKF8qFLCCX9A2nKWU+dN0PofgwtRY6
         5XYQtlE2LIzLtNHzUCa6WqI9SmdnicETAb6jwwR5kjEvmt2SuwTjIzZJDd8Sq8tlH7JN
         pXGTSlQ2gZTA7Cj3V/lTNuNJj4OVEXOwdVWesx/l8Vbe5toD9WMGwXFFFTY6OZWqtB6Y
         s/dM1TIg5jA55SqDu28mzs1KfLmuAYPRsBhjD5pYwcDtj9kHhKX94RMeQedrGMgX4IEs
         nK2GjtJm8n5MeH5vmZJykcHXZixa7HpDrBCzq2Ls5obscvw2+r4JAgXzFwC5NE67nQTK
         twOg==
X-Forwarded-Encrypted: i=1; AHgh+RoRr+Z+i7DnGhJ6yXN9dgETQromiRxRVdDnZMk5vdRsoe0TTUkxtj4OicOH9/ZM98DX+9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzEqlG4RIKCDgNHVUJhsQKdiYISeFaOeaz5nkGYAUwHdT2sh5X
	rMUN2ZEqUJqq0ne0lRjwL2+dlh1kc/z2SH1tHqUUyG7mi0Klz4ubusKdsy/Gyunp3DPBBclhBHp
	5vpTtn9HyLOc83s8u+20Tubaxhw==
X-Received: from pgbdp5.prod.google.com ([2002:a05:6a02:f05:b0:c85:a528:228f])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:9d90:b0:3c3:875d:c531 with SMTP id adf61e73a8af0-3cc7196e814mr3214623637.6.1786673648590;
 Thu, 13 Aug 2026 19:14:08 -0700 (PDT)
Date: Fri, 14 Aug 2026 02:13:51 +0000
In-Reply-To: <20260814021406.3044324-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814021406.3044324-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814021406.3044324-2-hramamurthy@google.com>
Subject: [PATCH net-next v4 01/15] gve: don't pass in unused parameter to gve_adminq_free
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com, 
	willemb@google.com, nktgrg@google.com, maolson@google.com, thostet@google.com, 
	jacob.e.keller@intel.com, przemyslaw.kitszel@intel.com, debarghyak@google.com, 
	kees@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
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
2.55.0.691.gc56d675ccc-goog

