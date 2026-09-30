Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45079521212
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804864; cv=none; b=h2sTdg9xHpUERGyq9mNmcxPkydTEcj00c3RJGck0BNSSQQAq29G/6QEWiRU+Yvl2L7m6v8Ya6GNum0jIcUl4Tsd3KNrR9zmOCRY7RUm51fCzqSOck5t/oXL8eFyxubQ7UGZJdRwUkmfwlM+zYXGlM2KJTbNx2whVznmHH0xx/5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804864; c=relaxed/simple;
	bh=3RSdV5bBhWRULyl6uKfnW1LG/ffeWbw+PgurKVAIkeI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O7CBMyUUcS4Yfs3vKNZpZ+tkKf1NYsLJ6IGpPaYG5RHMC7idLpgrq4DQWLd5jLYUEOO8ldF2KXzszkmp/DXXPVrziWXyVqvCA7jbRgLHfmZPn0/ZfhB1WCcCPBeIGibT1EHhOfB3/3ghP71Pdts5POp6mNFgvptD1hFnFn8QBjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OQbLjmog; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OQbLjmog"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2df8d1e91c9so86086235ad.0
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 14:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790804862; x=1791409662; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OXsSMFeS4wLeCuWu6IbDBclh7ggI9zoXvgi6QeCApjg=;
        b=OQbLjmogbCnYlxzM9511KHvL5x5Vm5flBjBUFwQXOyboX0q+nkIIljDtN7Ez3KNulZ
         l4je9V4tZoL412ETer5+DZv2Gbfib/7FpVysDHOVVDclrfNvU6PB6EePsg5PanpWize+
         bDipB2Za48TrzTwRmVV7PHuHQV9Cv9NNVOE6YNaN5F4t6xhT+gzVoHkYuELpgBYR2fbY
         DzBs6B5RFFN6d1NoBOJaj3BIZzOME30QqF+RDJYcGHLKoqHKtNp/8hm1aORkz9NvaW/k
         WmfrDXhtVLnullQfEne8o4/zaY526DqEO3i0zXAhAVvKWe5Zq0W7rcajUOdn0qUzhgUl
         Eu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790804862; x=1791409662;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OXsSMFeS4wLeCuWu6IbDBclh7ggI9zoXvgi6QeCApjg=;
        b=QJRA/lmEQw/1go7tsx1XKRv2PF8bt58he5nRG170HffcZFJxfNvweZ16D3I2ycTFBz
         yyTRYpYI6C9/5zvqIJN/H0uEXOo1JBY5BVOuyThRJfKVpcj0TrMKeJcGfYmnYy40o/ao
         7AjmjM2JpKc05qAZqODq1Dlv3NtR3j5o7Jh84lLsiw7am1fInT5wkgAtSECm5ZRsoI64
         +PEHxFaB1xgcTAbdSY1P3ww7bUYx52SBu+8+gtaqx+Od+Wq1KbER/RUXLZKG8XtXu5Mi
         HiwxzbZqeoozmKIwwgwwxNMcTp2F5xG3Tu3EG/GBlTGXDznQiD5OZg5QA6Rs62CW9Ezc
         leHA==
X-Forwarded-Encrypted: i=1; AKwUvBxci2FRpD9KnZmz/G9jnntENEq4incolcTmrFRvy/AYlp98AXGDN6TDpwcUYtoZy4UjbKw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIiFa2uKc8AZMFcj8Z3gpLfy+p3hp80b36BvE27tH0mMnP4VGup
	Mis0ZvNnnSX5p6wofj8uui3bSQKBtp7rzdQ0zixaqo5DN5j0njOGfNv6bwAX0V/Xr4DKL9Inch2
	ItCLlV/0oou0KJQ==
X-Received: from plyt22.prod.google.com ([2002:a17:902:d216:b0:2e1:33de:ada4])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f684:b0:2e3:913:31a9 with SMTP id d9443c01a7336-2e30913f27emr449105ad.34.1790804861617;
 Wed, 30 Sep 2026 14:47:41 -0700 (PDT)
Date: Wed, 30 Sep 2026 14:47:33 -0700
In-Reply-To: <20260930214735.3288780-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930214735.3288780-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930214735.3288780-2-joshwash@google.com>
Subject: [PATCH net v3 1/3] gve: fix XSK buffer leak when rings are stopped
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

GVE does not free XSK buffers when resetting ring state as a part of
stopping queues. This causes all XSK buffers which are posted to the
NIC to be leaked.

Free XSK buffers attached to an allocated buf_state when stopping rings.

Fixes: c1fffc5d66a7 ("gve: implement DQO RX datapath and control path for AF_XDP zero-copy")
Cc: stable@vger.kernel.org
Reviewed-by: Tim Hostetler <thostet@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 5cf242b28557..a2c4a08ce68d 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -113,6 +113,12 @@ static void gve_rx_reset_ring_dqo(struct gve_priv *priv, int idx)
 				gve_free_to_page_pool(rx, bs, false);
 			else
 				gve_free_qpl_page_dqo(bs);
+
+			if (gve_buf_state_is_allocated(rx, bs) &&
+			    bs->xsk_buff) {
+				xsk_buff_free(bs->xsk_buff);
+				bs->xsk_buff = NULL;
+			}
 		}
 	}
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

