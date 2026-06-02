Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A7E3CF69D
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 23:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444746; cv=none; b=abZd1AKEhJ4nR/o2a+EyDtPYWljGcBmXSBqhEYdyfl6YXocZowUIhsZBxDMLTbfCR1Oy/7U3cF+4F5eYSUzAAwMgId1Vvy1yNpEqH78RGNDGMuNMbi8IVS3wlsmXMj1k8E7xwZ/te8Ure+z+0v44XvDUPGQ/2L7UhQRA8AxGJnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444746; c=relaxed/simple;
	bh=pxR7nr3c9FNUnFQ6q8DOgpLaxivaEWwt6eezH4HaIMw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gOZNeoEQplLZeReUCrJ0a2FGMzZkpi198dH0EeGnJtpVGS7+rWXokuWhumgByz216fbMUKAlyzzSDRIQPwhJMeRmvyzvMmdW4W3bw6sj0H0A3BEfcndcLYDJgZEEq4EzVvYU3CHJWWPJM14jgoe6/iEY6wbKOcIAzSNYFoY9Lhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eisbQNCT; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eisbQNCT"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8592a62f32so2075701a12.0
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 16:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780444742; x=1781049542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ylsEd+N3GUYWmq2CtHjynnzO2SghoMrBxYGLoVOsJ7E=;
        b=eisbQNCTCmd2uWgrMpN5IRQ9fftMzFOegQLou3jOQkAo72LpfATcXv6eOvsEjaqQTu
         5YO+MvEcUGEN9DMCDtMZrmzSskNzk+B8nZ2g+RhKOUQLq+uGjng0OPLSDbUdcRucJTwI
         F6nYPAgzVi5h9hrDYRi2/buG4qL0iGGCgmj9p6nQD0mvGUatvr76EVkcknO6bAW/3ntx
         dNtOBy47XRYQ9EDrkikmsBJAQflFp9P7+11nUJcEnxj9s/NGrexohsuJL6IVFiuuAwVo
         LtrRi+6NuoyZKEB9PzNl8lQJ/6bijCSUv2i9TjhUT7j2AtuwiaMggSs5S8U3s1TaO/Mw
         7TEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780444742; x=1781049542;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ylsEd+N3GUYWmq2CtHjynnzO2SghoMrBxYGLoVOsJ7E=;
        b=JgOYJIwQ39IK4ugTFr2ykJF8h+bNfyUxsuq0BuA0mN7OhQQ+kk30E3cOx/0n6cHf9b
         GfDj/My9qCgj9Qk47trmgRKfK7LyQe1QLOkfKAx8S985a6fRvhdZk/DMebCYk7u9/FsW
         TlxfuDtdKbvYMtXh1rZcnY4KFX+MOwm3vssNRcYh+UfKGr2XnkjrV9By+5JO1lpRFhlw
         CFEDlMaK8+7cYAqtlH9sK+EDf/yXrzcaRAjxH5XlGbCwpXn0XyNeH9jyyGf3K2semzGE
         SD9ffm8NF9KQyHqRCselsmYC9QLwtVO9DTWegYQ5xOP2peolntSOpNk3PK49qZsK5JF0
         cZqw==
X-Forwarded-Encrypted: i=1; AFNElJ8SzBL8wLvkmKUNZp7EKGogFaPbatuiZuBTiCbtpKpEdD78wRi5YTVJfkEsIloslPDGs4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiWsaAgTQ9QWBoDHyjueIzbX+vPmf5r1IQ9qt5EmHdE450KW0/
	ARyZPOMvFlnDPbC/CTaKsCOgRMb7YGiPdTYbyNWbqSElhrB6D9+c+/qIYkhkfrw6ldMFDOy0G/T
	+HVbuS5gq2VP5RpXTsxk6ZErzAw==
X-Received: from pjyl19.prod.google.com ([2002:a17:90a:ec13:b0:36b:cd5f:3e37])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e992:b0:36b:bbee:fb28 with SMTP id 98e67ed59e1d1-36e30742c4emr570865a91.2.1780444741985;
 Tue, 02 Jun 2026 16:59:01 -0700 (PDT)
Date: Tue,  2 Jun 2026 23:58:44 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602235900.3050782-1-hramamurthy@google.com>
Subject: [PATCH net-next v2 00/15] gve: AdminQ mode related refactors
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com, 
	jordanrhee@google.com, jfraker@google.com, nktgrg@google.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series is preparing the driver for the addition of a new control
plane mode(MailboxQ) by commonizing and reusing as much code as possible.
MailboxQ is a new control plane infrastructure which uses mailbox queues.
This is a new control plane to communicate with the device when the driver
is running on bare-metal instances as well as newer versions of the device.

This series contains 2 main changes to the gve driver's existing control
plane(AdminQ):
1) refactor some initialization/teardown path methods to make it work for
   both control planes.
2) add gve_ctrl_ops structure to the driver for various control plane
   operations

The refactors are mainly around the init, reset and recover paths so that
functionalities could be moved into the control ops like 'set_num_queues',
'set_num_ntfy_blks' etc.

This patch series only sets the control ops for AdminQ mode. This is
intended as a preparation for adding MailboxQ mode in upcoming series
which will add the new control plane infrastructure and then introduce
the corresponding control ops for MailboxQ mode.

The entire list of future patches can be found here for reference:
https://github.com/hramamurthy12/linux/commits/gve-mailbox-queues/

Changes in v2:
- Rebased against latest net-next to resolve apply failure for patch 5
- Fixed a few typos in commit messages of patch 9 and 14
- Fixed a kdoc warning in patch 9
- v1: https://lore.kernel.org/netdev/20260601175437.3767283-1-hramamurthy@google.com/

Harshitha Ramamurthy (9):
  gve: don't pass in unused parameter to gve_adminq_free
  gve: refactor initialization with helper functions
  gve: introduce gve_adminq_get_device_properties()
  gve: add a few helper functions to set device properties
  gve: add struct gve_device_info to hold device properties
  gve: introduce control plane operations structure
  gve: introduce ctrl ops to set vectors and Qs
  gve: refactor gve_init_priv for reset path
  gve: add ctrl ops to for queue operations

Joshua Washington (6):
  gve: simplify reset logic
  gve: add gve_ctrl_ops for gve initialization/teardown sequences
  gve: split up notify block allocation and setup paths
  gve: introduce new methods to handle IRQ doorbells
  gve: setup and teardown management interrupts
  gve: add link status/speed ctrl ops

 drivers/net/ethernet/google/gve/gve.h         |  91 +-
 drivers/net/ethernet/google/gve/gve_adminq.c  | 459 +++++++--
 drivers/net/ethernet/google/gve/gve_adminq.h  |  25 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c |   5 +-
 drivers/net/ethernet/google/gve/gve_main.c    | 876 +++++++++---------
 5 files changed, 912 insertions(+), 544 deletions(-)


base-commit: 0906c117f81c2ae6e6dbfa82719f79c75e1c9325
-- 
2.54.0.1013.g208068f2d8-goog

