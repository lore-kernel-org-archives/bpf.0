Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5165E3E0080
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786751365; cv=none; b=UqjcS9FQ4wuLUX+UsPyRteRYRv3+yJZnXmxIok+6sy8TnbvhHywEwoB6gFX6+2RECO9jWY/zAzbZY2kuNCHleP5nwNRmUg1Xe/5HHD3He40Omu92fLvNO1dcORLrhf+SJZtr8VtLUQKwLWys0mxc2QaPoR8BlVGzG3gsAjIbB5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786751365; c=relaxed/simple;
	bh=i5raLJ/viRB4jfYcj0wFvVQznmGjwyiH+SUbX8pRp8k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pcBXRw8poOfxwT98iiTFC0M3LGJ/UbjpoMzOcnOXZNCxT4R8CjTGa93rqKgYHOuqCPrZ/0gUQGOtl6ePIQ/HjdZVUc+ASpEe7houSN8F+8ZPYEtO3aeGgSrdVxA+RuzJ1rXWtwU4IdZKCySFCi/1nXyCahh7eUkJl2DQ/gJ4G6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p6mrx4fn; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p6mrx4fn"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d52734fc41so23427415ad.1
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 16:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786751358; x=1787356158; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7djAafJOLBuE+bXbQTtDxXCPhwnYez80KiMRMTkFHt4=;
        b=p6mrx4fnHojiNdphcYhOL1pN3SK3a2BR+qXr+ynr9+jIS+E/5Lhp1IVi67MNm2AzE+
         unPSkS+O5JbFV536ggTX0fFNDsceiaGM57CD8+qsH3BOitfPPHzF/zIS+Oe//JKWHYGZ
         tgIlS8aRhAx6D+1+PmIE+pj/+mG+hyOawuWRkXlQTjCcTbeR7JwzmfNBGN5oemaKp8nB
         FFArPu+nCYHZ4i9ZbOkgdawHVtfcCf22yiTjd1zU+EitSAQrY23TEpJ+cTiiuXjkkFZO
         SnoTLO29VqgWx0v4Y8oPSQeG4s8bG93En7UdgwssXSg1wsvQqZ5s9UZ+n5u/h/Tw/7JS
         dqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786751358; x=1787356158;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7djAafJOLBuE+bXbQTtDxXCPhwnYez80KiMRMTkFHt4=;
        b=rDKnj1Qn5CmpE+6GJXDDdzdgF90eqxuh+eP9tE6nwXcZRrj6QPm6jlz7qQuJDgwdDG
         /zj5lFwoR24QCvKTv1yKCqP+jJTewl5WvLt984IzFpGyUJH2bAeorXaSzR0u1ZSnICdj
         TcZtO1k4iXIyBwfPb6SoTQhXCanSILZQT0j9ZfL7PYMKMFZsvwpjKKibjwkY5t5VNV3i
         RavgATscfWw4n+ahtYPpUoq7kDZbiZ/jYGzU3IBwDU0LuC15JZSoVs1uLttXEtP6hKWO
         Z/AWV8rtvPU0+vKocqYkPBe3RI9HNBYD7ZcRz+/gdXT9iMUCPiUXUY2K4QoiSzbn7779
         t1ZQ==
X-Forwarded-Encrypted: i=1; AHgh+RqEOeBb6z0ID0wAcxHnFrIWBhmgzY3lUjIqbSwRmGo3mq6htEiQfvJ6UE/V6XAV/vLM/Ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzNloAcCOZxM/WDpULOSjw4IbamVQIS75lgi8aR/9oL3HupQ2x
	5lHVi+Nw+PrKPuMttclhyG8/jnETaILJGl+zJK9xpCvX1zG4n+sVZBPPuS3M1iCiHtSUN4qa6Lm
	Vm3uGH4IEt76mUg==
X-Received: from plnt11.prod.google.com ([2002:a17:903:196b:b0:2c9:a5a0:a677])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f689:b0:2c9:fa31:84f9 with SMTP id d9443c01a7336-2d3b0cdc256mr101631195ad.5.1786751357477;
 Fri, 14 Aug 2026 16:49:17 -0700 (PDT)
Date: Fri, 14 Aug 2026 16:48:42 -0700
In-Reply-To: <20260814234845.773189-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814234845.773189-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814234845.773189-4-joshwash@google.com>
Subject: [PATCH net 3/6] gve: fix XSK buffer leak on error descriptor
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jordan Rhee <jordanrhee@google.com>, Willem de Bruijn <willemb@google.com>, 
	Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When the error bit is set in the RX completion descriptor, the buf_state
and its attached buffer should be freed. In the case of AF_XDP ZC, the
XSK buffer was not freed, leading to a leak.

Fixes: c1fffc5d66a7 ("gve: implement DQO RX datapath and control path for AF_XDP zero-copy")
Cc: stable@vger.kernel.org
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Tim Hostetler <thostet@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 2c1ce23d1550..811db42d05c6 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -845,7 +845,12 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 	}
 
 	if (unlikely(compl_desc->rx_error)) {
-		gve_free_buffer(rx, buf_state);
+		if (buf_state->xsk_buff) {
+			xsk_buff_free(buf_state->xsk_buff);
+			gve_free_buf_state(rx, buf_state);
+		} else {
+			gve_free_buffer(rx, buf_state);
+		}
 		return -EINVAL;
 	}
 
-- 
2.55.0.691.gc56d675ccc-goog

