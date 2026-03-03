Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDC6396596
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 19:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567764; cv=none; b=CkONiA63SldqPCx34QjCr/J0eE0LtAFf7MpL9ZMXKvOkG/cOUFadO4+5iKO+t1OMYo2f2gC/7t/gbUNeTEhW2Wgl8x528LeuTVcZQ/aMcXJ5pO/Ft7g5taEg1JZlsYNqkmkjPAaS93+VJRv+mJTGskeX6jelh8TXTi+RiKdQG3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567764; c=relaxed/simple;
	bh=bcPmWJbA+HwFh5Sp4FvAT6eGPD1jFzH7Tlh7wmLVZFg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dUeOFe65oncHyz/Gk3NDSrPe4WwOqK3o143BEPQXBhJBuoFaV9V3a5d3alY0pzg/N5qkROiYFYeR347CQLvisVYNKuRd0/zyvkc/hXmqV41PVR4dKgPSlgF/ZIhdH2s6h/hWtLKSHGoAxiCcWci2KKoiCdYes1qjm56DlTX4tbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4bqAqaSW; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4bqAqaSW"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b6ce1b57b9cso4810935a12.1
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 11:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772567761; x=1773172561; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q7O+VqmWleakm25HNUCSndfnjpDlMGeEkeH0AG/54zw=;
        b=4bqAqaSWfGMG3ODjwionQIf98JgMtykwKCws9aOBc/R/0TMDWyhvKVMSl8t7m/OrEH
         hAnAJiFoXPGE6b+vCvEqZ8ArTzXM02uUgAS/9rLwQvfsxAav0QifZSzLM+gnraqQC7e7
         MAwO5HfSmh+3Jb8++u7fzA66Qo1R6nUJS+IUyg1yoqskycYCYmJ8oiGrz5QEApKHAlVV
         0tTt0sp/IBKIDwhs8Pr4dvTDj6kr3ZF8LiqN0KRKWEPk0dnSk+kX6WcD1Cv6M5MD5H+y
         SMY50DiqkA53sHj5v+MdaViqDzDWum0vIIjU8otQPEOadTsDEC/E10g/4VsYtD8BBx/Y
         Z1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772567761; x=1773172561;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7O+VqmWleakm25HNUCSndfnjpDlMGeEkeH0AG/54zw=;
        b=NfBPCHyNbi2FbLecNZfk6U+DYKhgYlJBDGy+aqcHnqxGRrYMGUpMY2DEpszFVW7es1
         BMbfarunJsl/TB8TCFrMCm3aANQEZabwlQ5/ZaTcnlJDi8t9JLjolojId2hLcc9wTDI5
         BXseRlu2OFdRwwdaoLw47oIO8J0NtnxxrLQXAZ1iTMXKLm7WrXwVhoGL2222roDZBoI+
         q9mSwmoCR2VN5pRG3QVh3vv7u2ARUaaBqW+oMuqgwtmmD8Dg0gBlB9Q6vCEhKjw3ARqA
         6n0W1GcPKnMHzAArzeoD63ELgP3XXyIIeNHsMQ++NkiujcwL7+0JSil6JSpOf238srje
         Aopg==
X-Forwarded-Encrypted: i=1; AJvYcCXZj+imPL74rdvaKVyKaZRbZeIwNqsgb+SsT7RaODEkb8W84TfUB1zSs28tlT78DI0Qtno=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOyF8InLWao5RazLAsJwajgztiAujdxkYZOU+fE0+1+sWqS6gw
	ElLdZvpvdr9B76HCMeP96ZdQki8H+sy5vsgEPdPRQeNUrHo98uMf3THKp5QGBClvgsEpk3LrFIm
	btPr3mgFMHkeRng==
X-Received: from pgag24.prod.google.com ([2002:a05:6a02:2f18:b0:c70:e479:52d3])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:610e:b0:38d:eeb9:8f49 with SMTP id adf61e73a8af0-395c39de44amr13785530637.2.1772567760815;
 Tue, 03 Mar 2026 11:56:00 -0800 (PST)
Date: Tue,  3 Mar 2026 11:55:49 -0800
In-Reply-To: <20260303195549.2679070-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260303195549.2679070-1-joshwash@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260303195549.2679070-5-joshwash@google.com>
Subject: [PATCH net-next 4/4] gve: Enable hw-gro by default if device supported
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Jordan Rhee <jordanrhee@google.com>, Ankit Garg <nktgrg@google.com>, 
	John Fraker <jfraker@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	Matt Olson <maolson@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Tim Hostetler <thostet@google.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ankit Garg <nktgrg@google.com>

Change the driver's default behavior to enable hw-gro whenever supported
for device.

Performance observations:
- We observed ~10% improvement in RX single stream throughput across
  various MTU sizes.
- No change in TCP_RR/TCP_CRR latencies

Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 873672f6..6ce8345e 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1128,8 +1128,10 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	gve_set_default_rss_sizes(priv);
 
 	/* DQO supports HW-GRO. */
-	if (!gve_is_gqi(priv))
+	if (gve_is_dqo(priv)) {
 		priv->dev->hw_features |= NETIF_F_GRO_HW;
+		priv->dev->features |= NETIF_F_GRO_HW;
+	}
 
 	priv->max_registered_pages =
 				be64_to_cpu(descriptor->max_registered_pages);
-- 
2.53.0.473.g4a7958ca14-goog

