Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB62730C16F
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786751355; cv=none; b=UtopnaKjQ3x0yLOoQEWG2AkgGcjHbNx0bXAFVQLIsB3J0cP+ImdbOnJDc6Bio5ZP5X+LyyvHtlaO+/zUch/sX4a3bH4nqBIHhUZu+NU/gRrkKb83p2Ro2ugcUMbpua+HaEKm5QxYH+AZOZmVsN18Wb1V3W05FXFC4RiUgDBuQB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786751355; c=relaxed/simple;
	bh=x8eg9Jt6w3cS6X7e91rfazYnIdbQdxW90QnuVAm/iJY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oNPKHZ2RIvc54elYsX1Lu8OQvuser8cMd9yEdFMSIi0d+4bw4M/5HQVNAmU4A5Z5p3729ohB7oqCfw++4L0ZD/PHDCqTTu7BqDyZU6mBZOQa8A0aOvnrqil2cQqxWbyBLwo1z13H5qXCT7RLLcZZYC1gSb+uQxK2yLqAhACRxbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EzGLCdLA; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EzGLCdLA"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e375d9736so1252387b3a.2
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 16:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786751352; x=1787356152; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s1YbbHnn1o8ujr85Ja1lB8ygXtUPaAp528+7LLKHOkI=;
        b=EzGLCdLAMV6cboWVOOULUgjfPL/wuUwLk6sNd8y2I+U/slTKDjNDgaEUpe4bMAasWE
         wGIAuefZhE/jX2JHhdfGTS3oEJ0dqzdBTWvW8paT+3bF6TOF1MQlL3pkX49zuhiGbUUK
         R0hz3dNLZgq0eSIqTVn9C+LPLizDRuXH4PmkTRAy1lszBjDOMu4JYbCcRIIUvASxdm5T
         jVvwrjpopExyITWd2RKOzVzg52u4lQ8LiJquJtJDQaFGr27hu+UL7PhN7gsjsZpMB4RP
         XSxju9gAzQ3VBrZLoLnNSIq88fhfAfntBm3NUg0tyeRrXVrOWxSJpPyUAkd8//v3z8uE
         5csQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786751352; x=1787356152;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s1YbbHnn1o8ujr85Ja1lB8ygXtUPaAp528+7LLKHOkI=;
        b=c7VXRKYFeqAPxS9jvV+vGAGhoRLu5OkER7Y8EWR+I7w0tdQhU5+rl5joCoyK5vrMC8
         lYmG9i9w1tmk0c54hdGkz+yVIkq7Z88VuAYkDYW+cQAqAqpWY5ZsLDk9JjRgl8NUsO56
         qau1mjayM0aiMH3vNET+ShAPAQhVGiQnJin4suP+HjMhur0xz8hY14BsDGyTKntQbZqn
         usp/ucsVifneJnV5y1T6OulpqeYGIKLj4o+OtDaX+3hnEhKYC4INmo3E5S0l8j29/bVM
         7gUwQt2bOwunhnT9SuA+H+R+OmsiYBW7t01b1cQQkBWVOyDv9ifzt6hJvwylG27LFE4C
         3WOw==
X-Forwarded-Encrypted: i=1; AHgh+RrLH+j41jT/WHfzBhr97TDlZ1+KzA+52fT19LS127RcaytcNd763JSTKhFjPD+OTqcRQIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwouhqIEqT3KEIWxSVsVpr+7H07kxrsxgmtJYipySkajG1Qg1Wt
	a+mQZTgXeAaibsc5n1Jc0So9+vJys+LpE9VYQ/bF3hVRocTBbqlK1yDyGviTfEKAurUHwbJ6pzD
	52wQ8zAcRycyzjQ==
X-Received: from pglf1.prod.google.com ([2002:a63:1001:0:b0:c9e:a22d:15e8])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1895:b0:845:4928:8655 with SMTP id d2e1a72fcca58-84fde33319bmr9287557b3a.39.1786751351767;
 Fri, 14 Aug 2026 16:49:11 -0700 (PDT)
Date: Fri, 14 Aug 2026 16:48:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814234845.773189-1-joshwash@google.com>
Subject: [PATCH net 0/6] gve: various XDP fixes
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jordan Rhee <jordanrhee@google.com>, Willem de Bruijn <willemb@google.com>, 
	Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch series includes a number of XDP-related fixes, both in the
control plane and the dataplane.

A summary of the changes:
1) fix an issue where XDP packets weren't being counted against NAPI
   budget
2) fix an issue where XSK buffers that have not been processed are
   leaked when disabling XSK pools
3) fix an XSK buffer leak when an RX error descriptor comes back from
   the hardware
4) fix a NULL dereference due to incorrect registration of XSK pools on
   queues not set up in XSK zero copy mode
5) fix a deadlock introduced by attempting to acquire the netdev lock
   after it has already been acquired
6) fix a racy NULL dereference due to DMA umapping the XSK pool before
   queues are fully stopped

Joshua Washington (6):
  gve: increment work_done for XDP and error packets
  gve: fix XSK buffer leak when rings are stopped
  gve: fix XSK buffer leak on error descriptor
  gve: don't register xsk pool on pre-existing queues in RDA mode
  gve: fix napi_disable deadlock when attempting to disable XSK pools
  gve: fix NULL dereference from premature XSK pool DMA unmap

 drivers/net/ethernet/google/gve/gve_main.c   | 51 ++++++++++----------
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 20 ++++++--
 2 files changed, 42 insertions(+), 29 deletions(-)

-- 
2.55.0.691.gc56d675ccc-goog

