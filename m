Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2295938654F
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567753; cv=none; b=IlrPb/mUL9mOy1eVToloFeS+XV5Slz5gXG2tdczu2AwKmFH2G4I5HXjT+GdGizgXLP+J7ZfTmAh+80bLomSTT+nWGFzaZWdLTr0YQQy427LwoUX/V/v7el7ql9h8gES2Md0ScJ3c7MYjXNDhZ3biAwvIYUavroEmm3lX7uyqb0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567753; c=relaxed/simple;
	bh=xCB+gUvuhiMj1a0fMSB9Z41DIUR6vugAoq4q0yEs7Gc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WOZmtOC5cTHXsEYy00qnJ0yId+L5K3NujB7YPPrJYTANI6kUD8pe2XOMbpgmM9YKxHNiNFqhkLbb5ADHMMt5a5ILBxgcAXG9HHQug6rRLNunC+L4QY9Fgp17KkAenoaGWcmlNpYK6ZQql0N/k1IJMSUcjtS3d8Kfk9742siD2YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J3mtLeq5; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J3mtLeq5"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c70fc78a985so3141803a12.1
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 11:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772567751; x=1773172551; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y0qcUmgK82L/UaWD6aUQJpUbsOWwly7fscJPcy0f4xE=;
        b=J3mtLeq5cMF4efL5QzMW3InDoaPlxt62fS+4I3KLKdbGP6SHFW8PZzcf6isDnlCFIg
         QwLF+L3yVzQk3uHRyeZg1xp+aFcrElgMRsJ1iJxO/l5dM7tdl3fpS0+bHYOCbPOZS8AH
         796L2LywlEEk1drJ7aaTQ5s4nErYNyEgQo6/S3IX/CTbYN3BimBPO9XDS4X8q+BE6dEu
         QHHdfkbRhhP7UJnIyAzB59XrzAKgA/WckTEdI6hMVb7Bi28xBJORSmg/EVnwIZ3sO3ux
         BFRu/qe1jIUAwweNektN4ZRtfuKn4xSyswYWVngXZ1dXHFim2QriRMM0jMH4iYVxf38A
         dDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772567751; x=1773172551;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y0qcUmgK82L/UaWD6aUQJpUbsOWwly7fscJPcy0f4xE=;
        b=S5XX5uaiMrIxwRj6Xyb4t+beXcYrAGjsmJKgHlDY5NcRSdsqNMOA/l/36Wj9Vu2bpE
         1/5+/8UtYTtnsH6oUG4iY8MpyQ8QavqAaW8Pln6bGJZxtstaZx9p3f3/8WDDoJp6VFQT
         X6ZUPM5PwhtXHlH7YeeoyLmiMTi/C/WwnIqn0abrZhpTrQFVRApy9PTlVk9euTaLKGBR
         qpFdOWhA/exiONOI5wdFGb6ri4FWD97eBSEZukN9JjlVCOG0lITl+TZS6tUsXyOn1uKT
         jx4c2CPe8lSsO5W3rAx+YVncjHPcEkICJbVN6SVaTe2kpk1LifD4DeRJ1C/jBYUPEz9S
         U7iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWER8bhRiHZT+yDNDVM4OyWFHnZZLp0GJQX1AYR1ikuRTTVtRXHpGB9BJQqfvurgNedHOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM6SApz1jUB0xYnzhSow01P8iou/ZaxyWWincPuyK6VnKSQi/f
	D/1dFOQT23BHPUJ9HrjnRyczXAFf4+0cs3iqqu/85AO7fL3B61ynL67SAxEVk3q05l6CVifo/Cw
	KqenRLnsWaSWw1A==
X-Received: from pfwo12.prod.google.com ([2002:a05:6a00:1bcc:b0:824:36aa:8d0])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2341:b0:81f:9a5b:e8fc with SMTP id d2e1a72fcca58-8274da094cbmr20670261b3a.54.1772567751119;
 Tue, 03 Mar 2026 11:55:51 -0800 (PST)
Date: Tue,  3 Mar 2026 11:55:45 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260303195549.2679070-1-joshwash@google.com>
Subject: [PATCH net-next 0/4] gve: optimize and enable HW GRO for DQO
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

The DQO device has always performed HW GRO, not LRO. This series updates
the feature bit and modifies the RX path to enhance support. It sets
gso_segs correctly so the software stack can continue coalescing, and
pulls network headers into the skb linear space to avoid multiple small
memory copies when header-split is disabled.

We also enable HW GRO by default on supported devices.

Ankit Garg (4):
  gve: Advertise NETIF_F_GRO_HW instead of NETIF_F_LRO
  gve: fix SW coalescing when hw-GRO is used
  gve: pull network headers into skb linear part
  gve: Enable hw-gro by default if device supported
--
2.53.0.473.g4a7958ca14-goog

