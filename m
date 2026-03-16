Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF9C288D2
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 23:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773702280; cv=none; b=FNt+78FRTkhEcz/j8gMFkZuFp6b7D7XjjqUnhf90EG6cvXwXsd6rxCreQ8FWMIKAPMzwucHiK1D0YnPWgNtAL6cLZrpG6I6juZI0IDLE1RlYOyxezHAYd8OQivkxwnJonKueYqTBgBFrbO4SUI4nttVXTeA0qvTdymiR9Puo2F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773702280; c=relaxed/simple;
	bh=e/UJdbtjfIAWPFAbM4sh8O6m1MaFL8Rs759mJkAnoxI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZKLbFNOoPz4WhwJdgxMvV/AcR688DasvvmV738OJPS4XGz9gB+7hRsiDzA3swfjPDvUuXGmdTFdqRB5vdXG11VLtMsXbk8SlRvd9vC5SL8xJ4iR74+Tqogn2oBr3eubmyNdvNhMCiDdO6rwQic9xlIhzl9j/f//G5aEg9qAXMUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GKIZGXPU; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GKIZGXPU"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8299c57642cso32018703b3a.3
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 16:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773702278; x=1774307078; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2YG2oO3UdAqZk7gaMfdq/iHM5U3MIRMYZTmSCx+DiOk=;
        b=GKIZGXPUjqC06FjPmnrt+J5u20iAgL13bKOqowx9YAK3oqKHrdpBtm40cAgMOksH2N
         6NspyaVAZLEQrJWhYIUaEOOBRfiWdILgwVryHUaSSfOMXJt1Fj/JjpR/yfSCculgcjOs
         wTXpeHJzuJdeSrFV1SPNWpik2I4ZdY20jitwXQwsm43xywBGEpjnlcd0/w3Y/KMTVXnN
         TziIEtKaTRpfc3PTCmghdacSY/Vdh+fMgSOpb8bV4MMkmKaOUIMWMwFwnLEvkUEM2vAy
         PgeOpj4O8yeB4RHA8pnA0lt1MGYxFkN8BtDeUQdYddESi/7WIduumz+4arrdmKmS/Ig7
         oQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773702278; x=1774307078;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2YG2oO3UdAqZk7gaMfdq/iHM5U3MIRMYZTmSCx+DiOk=;
        b=VwnPtx+AcT6jCabR1cT0ed15PLJ9Ku72S8KxIdUxGss26oPZJT1del08jPdW0D+sNh
         zIxpC7piNPt7eJ2FPqp465BEmu6wWkj6HSiw9GysiHNpCi4uBAk+WzquXAZ+pxvnwecJ
         ksZ1gVAdw5UNEKj+RMizgy8iFrF8riy9GjmS67HsVsAR1M10AcCyu/h3VNSWDN10398M
         3OBDxkZBM7WvOUENmz11C9av4BWEi17gg5sbmneWvJMuNg/wMV0XnXbki6eud2rnOTly
         NAXlh33dl3Cq4qlf3toB6+xI7lJHJ2Wn9WvM0IQeR7x/4Egoa2gWiLsuN5UdcVkI94+f
         dJwA==
X-Forwarded-Encrypted: i=1; AJvYcCVgJzxku5GJ4p7H7qHawqJF8AEOvFcYwksnz5kFNWaGm6nfHzsWix7fMRp2YyHyigbD1a0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdA1ALcJaoODrVYOJOKaN1e10w2ZGChHikvdfRwCLXIT+8Vyjd
	ytnTfYaUcVSOALnAN4vlg1qS8vaTYEKjrfH+aR27nANPB/FydTHac8W0cGqdzVfaTAWbdPrb7xf
	V/xtXl6/OCwiPwA==
X-Received: from pfbhu32.prod.google.com ([2002:a05:6a00:69a0:b0:829:f706:70e1])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:9062:0:b0:829:837b:9068 with SMTP id d2e1a72fcca58-82a1987bbc8mr13609230b3a.29.1773702278077;
 Mon, 16 Mar 2026 16:04:38 -0700 (PDT)
Date: Mon, 16 Mar 2026 16:04:34 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260316230434.1398828-1-joshwash@google.com>
Subject: [PATCH net-next] gve: add XDP metadata support for DQ RDA
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Tim Hostetler <thostet@google.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Jordan Rhee <jordanrhee@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit daa7ff1e1269 ("gve: Add Rx HWTS metadata to AF_XDP ZC mode")
exposes support for the XDP RX timestamping metadata operation in the DQ
RDA mode. While the operation works on its own, the intent was to enable
XDP metadata support for the queue format as a whole along with it.
Currently bfp_xdp_adjust_meta fails because meta_valid is set to false.
This change updates xdp_buff preparation to set meta_valid to true, so
metadata can be fully used by XDP programs.

Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 7924dce719e2..48945b4b6766 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -877,7 +877,7 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 				 buf_state->page_info.page_address +
 				 buf_state->page_info.page_offset,
 				 buf_state->page_info.pad,
-				 buf_len, false);
+				 buf_len, true);
 		gve_xdp.gve = priv;
 		gve_xdp.compl_desc = compl_desc;
 
-- 
2.53.0.851.ga537e3e6e9-goog

