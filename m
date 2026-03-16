Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A3D37269B
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 22:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773700164; cv=none; b=aR5iiOlj1/wYk5VXhz0R0UQ1ZCtgL08P/u6A7ylmDHLkBinI7VeWHgXRDdd47o8vaiup0pxC2IwFssa9EStaVj1dhRMD3Q3LD/+/UgF2wBkB07osk3wI7jfhRRglpit1ybeZTSh57buaBAxKQbRUxqN2EeGiy6ql3QaJF5uqrXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773700164; c=relaxed/simple;
	bh=m7LzcrwDBmaIfty6pcqphSCz4xQly0jpZEtJFxwEYFM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dsQI4l8Z2ONDa80UIfxCkwk0O8LD4potlImLpzphRWl6Htzlq7w6WhqLeEQ6OO8cr/tFMVUFSrSPgnlpuxCnVLUgBa6t3H0328zHpFaT8/nusJeesXdYCnpOQN0+SbypH4W0xzKWhQded/FrQzT12fKK7wxFrfq7zhICyGcMKQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDR/3HHE; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDR/3HHE"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64acd19e1dfso4818159d50.0
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773700161; x=1774304961; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w4CvTWsBdAJJ2Kt1MDOaHVOFx2tItiY273T4n5voea4=;
        b=YDR/3HHE32C3Mf4A871LQvtD21pA7JgPYJANmeUbYhF2gqjGo7ofP1H/VTogw9qJ/B
         8zgsjRvR/XKFg3LlVi/FLjO5vQuTpzDfCdD/8pJZSlRXhLlQjZpBMH37xrJyIONAKtB1
         MiAXXWynJN4caNjBuDqFVkfpajdsRoVcwJyPded1jGASGzUp9Ra2a8+uIYQ1DIjZGesW
         KtNyg1uz6zxn4PfO6rxmP68Q//CZFXe28uxhcjQ1WmInpA00WmsY6WxBDNkOHMuVyVQs
         saMI3CLvENadTsf1/gE15fsfxvU/pYOHMODX4TBY5VSZojRelHAZ/On+cVbZ6r1Vquid
         Y57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773700161; x=1774304961;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4CvTWsBdAJJ2Kt1MDOaHVOFx2tItiY273T4n5voea4=;
        b=ljeSUW7+281Ta9g5j7eOu9vzM8f8JnvK71+Bof5uYScZHs3mrVd35MAWMJN5mUHQd8
         nwYq7qbs6nZF9wTYPYBMh0/sqbA1UlJliIPSdg3eS/oicfUHCL/TuvbYl/NBFtBxerm/
         09BPB1IQ6et9SNU5Mc/Mjm1mQs9DgcfGbl0IGpx9kLa0kMt0rNLtaxnfXmhMNaQlXH3d
         /LPYNRXCYcYgP/BhMLkkB8Lq6xlCl+7EfH+F8+oNVuS5n5b8bACLfksX9XwVHtmm6FYK
         9tAfbp7F5x3YN5ifY5flmwwuoQDurgcSlgKg+eOHOjeiVlS5A1wG9dtWJLw6gnniS4tV
         UAtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbNy6q/jzLlCI90MrspwqQhizqdQWCtlaF0mvdqrpPvJg/IMZQoDggU4WOKdlF1VX2SVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOig8hSOZDzApbo8qraoR1SgF3INkWyIsZ2Lmoe8/7hq3bN6b8
	Eb2dYh5eFh6hiL35wruRbLS3jaGbEWg2hiAqcde+mj59Z5mOipNlRWw0
X-Gm-Gg: ATEYQzzvQ/DaVjPDQqT8j//xBEdfPcvmaephJmDyuhUXEIhAtjr2LVDfaMzt85c3B3S
	92/NOupRnTQIGnSe5AzJD0VpceVOPWmkmN2A76qFYMgG1zBtbdM/XAshz+WBqrCz5+6lz2H58Tq
	Ece/WpsyEmZ0RjkPe7BxRnG5BkBm7vZG2rM9wmOYG2Kzr0YCBk7xAQMBeVEuh3T8apFJJ9eSPvX
	vMxbjEYtbwLD1Axn7Oo33oGij1Jogpi9nVEn8ypZNuhnUXda2U+G1pk3hZ9Ox2mwRCH6uKd5HG3
	f4S/ZQNrVOop+dIorEdjneH7zSDSundIkgpmhLh4rL0oK08bvLpl1XZjIhZxMQGB2UTIiOdPtpo
	hlbEMjMxdFf6DOh7s+VykzdzOCdsvhgL9DcxtoRy/+Rzn1pz/T7xOOkpZrIYuaPdbVVSdKybqam
	IOlYyCxGjHwKsG6AGnkC50+nt5S87ah/Cm
X-Received: by 2002:a05:690e:24d2:b0:64c:e7b1:3573 with SMTP id 956f58d0204a3-64e63041455mr9721861d50.54.1773700161215;
        Mon, 16 Mar 2026 15:29:21 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:72::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e65a405c5sm6219061d50.2.2026.03.16.15.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 15:29:20 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next 0/6] net: devmem: support devmem with netkit
 devices
Date: Mon, 16 Mar 2026 15:29:11 -0700
Message-Id: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-0-b53c8cd72b23@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADmEuGkC/x3NUQqDMAwA0KuUfBtQO530KsOPtqZr2IzShuEQ7
 z7Yu8A7oVJhquDMCYU+XHkTcKZrDMTs5UnICzgDfduPre0s1li8xoxhC+FLNb9p9YIad1xWFNI
 X64ApTEO62fswThEaA3uhxMe/eYCQotChMF/XD1ruQhCAAAAA
X-Change-ID: 20260313-scratch-bobbyeshleman-tcp-dm-netkit5-fb85f437568c
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, 
 Mina Almasry <almasrymina@google.com>, Wei Wang <weibunny@fb.com>, 
 David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

This series introduces support for TCP devmem with netkit devices.

When a physical device leases a queue to a netkit device, the netkit
device is free to bind-rx on that queue. This works out-of-the-box and
for this RX path this series only introduces tests. The tx path, via
bind-tx, is less forgiving. Before the skb ever encounters the netkit
forwarding policy or BPF redirection verdict, the skb is dropped
because the upper devmem TX path deems the underlying netkit device
unsuitable for DMA and netmem TX.

This patch series introduces netkit and queue leasing awareness to
bind-tx and the devmem TX path, so that devmem packets do not
prematurely drop even when destined for a suitable netkit device.

When bind-tx is called on a netkit device that has been leased a queue
from a physical device, the binding looks up and remembers the physical
device if it supports netmem tx. This physical device is then used in
bind-tx and TX skb validation where the checks for netmem_tx are
performed on the physical device instead of the virtual device. If no
queue has been leased or the physical device doesn't support netmem TX,
then as usual these checks will fail.

If BPF redirect or ip forwarding lands the skb in the TX path of a
device that does not support netmem, then validate_xmit_unreadable_skb()
will fail and the pkt dropped.

This series depends on the queue leasing series:
https://lore.kernel.org/all/20260129222830.439687-1-daniel@iogearbox.net/

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Bobby Eshleman (6):
      net: devmem: support TX through netkit leased queues
      selftests: drv-net: extract _find_bss_map_id helper in NetDrvContEnv
      selftests: drv-net: add skip-config flag to ncdevmem
      selftests: drv-net: add primary RX redirect support to NetDrvContEnv
      selftests: drv-net: add netkit devmem RX test
      selftests: drv-net: add netkit devmem TX test

 net/core/dev.c                                     |  26 +++--
 net/core/devmem.c                                  |  16 ++-
 net/core/devmem.h                                  |   6 +-
 net/core/netdev-genl.c                             |  38 ++++++-
 tools/testing/selftests/drivers/net/hw/.gitignore  |   1 +
 tools/testing/selftests/drivers/net/hw/Makefile    |   1 +
 tools/testing/selftests/drivers/net/hw/ncdevmem.c  |  58 ++++++----
 .../testing/selftests/drivers/net/hw/nk_devmem.py  | 123 +++++++++++++++++++++
 .../drivers/net/hw/nk_primary_rx_redirect.bpf.c    |  41 +++++++
 tools/testing/selftests/drivers/net/lib/py/env.py  |  60 ++++++++--
 10 files changed, 314 insertions(+), 56 deletions(-)
---
base-commit: 6c80a1ec8984e01a4d92225ecaba66ab74063d2c
change-id: 20260313-scratch-bobbyeshleman-tcp-dm-netkit5-fb85f437568c

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

