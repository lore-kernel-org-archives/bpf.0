Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F072378D6B
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781888979; cv=none; b=jqqYJ9vdFjpsIWMd3xaM2SSluLuNGbVG0N7AfIOUH+bOCD9qLZ21nLv96RsmSAB8FmXEl3CTC7peXXmdAD8dsDJ3438IuVkLR2C5qF+4POSXGWMQwzGowqhcHUX6isxJ5FzBVEvvXe7Wu2vDFL8HcmfyOdFMAEEz2RfeYuqfyfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781888979; c=relaxed/simple;
	bh=6k9NCq244tVcKlPUICoCvV945KqyAh1Xg2L2evCIIwo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TTnIpLdlBwFG4ZkEV+qyvfhwguIgnZxA1MEr/oh4DaY1csNXqwIQtg3Xqwy+jqQjDjI9Up/7zX8QFjsAD5VzQ3xoEs6WsnHd0njzeMZqyfSZCf6D2fv79y4hqm/lYf/CkDQouRE913FHIuS2tZi4mrnzmTTvO41Xe0ZbskxP3Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QMZuoc3p; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QMZuoc3p"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bec43ee8ff0so377837366b.1
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 10:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1781888977; x=1782493777; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fZVUN9gi5V0LCniL2G8xbRaPGKKOWind99J453gh/2Q=;
        b=QMZuoc3p9t35JkrCK19Axvsw13YKuFtO4ARGR/iApFRPxmQUloOtgDy9NrYRIlzWTv
         ZgLhBuqU+0tzDa10oniUch+VMxSxjOd27gcWzh9VKyNQvPUb6xp5rmLjzPFrX7vJWeyR
         R09Zf6RCPNgHEDiAmq2ET+/s8Gh5DPEk+12cipp40VWH/v+k8V60FCMpbB+K9omfLLV8
         nna+51vkUq2UoQp4nlE4ESfVot/CBmfefHe+RVwKDmR3eH0iePTMM9M6mDGJfupRZ6Wm
         Cwt8rXKQeCTMQLghVvV5NrtxXQ91lkRRCyTC/xjIrsXNVQ2QOCYjTOk/NU9ZwEJatMkc
         QaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781888977; x=1782493777;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZVUN9gi5V0LCniL2G8xbRaPGKKOWind99J453gh/2Q=;
        b=lyyxPx+lzMkzoQIZ4zNouHLOB+RSCYn4naFGS5UXzm6kA2QKvNhF+4xZQseKmFxeAC
         FvjZwlZLe1MBonBPr7u0+aZZTJXI1vVj7p/ZGcIPdghC66KbIUWV1jWkEvTKWMbzQ3sy
         y4qLdcU4mTbx0J5XeeX2COOPCxa09VC4UHmdjlvBkfR0mI7XIWFWdqvKETMJJ1V9yPX4
         okxiiJYTYr44gP45WczY5sn0A9FrsMIYIoD202rpLruguu1VGJtrSvBIM9OuujJbkq6u
         WfB8i8W2R9ZYwInRCecH/Z1VqFwGP7sUegFynOOyg+Syc85rM8WoLO5x5m5azujIXcpv
         LELw==
X-Forwarded-Encrypted: i=1; AFNElJ/VsMn21FvvtXnk+A+G/pOZ+eNCorZZ5idlHSzdYOmLRAvVl1wpV1B+Am9hNC8XE3pDHyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl+qZU0e9avjKpK62W1xmzVwN+CK83E28/rnbl3EYkQOIl9Ew4
	NmCZAeW1xr0S8L0ZfvCsGd4Au/LMV043Fu1q58fKiqq123qWq9cSCW+y/0cR28D/y/8=
X-Gm-Gg: AfdE7cllILM5UjZiaRwGKJlrcb1IBlDiAmQR6VjrStocg92W3zugt6/zobdL6/L7wtq
	FJa+GKnleEgSnntO/SDZzPv8XMigLLzFHDOWBQb5TkBpuTcmmNb8i5aVOZayGmt0m1UPGtsmoBb
	9++X4nOGb/CpiYKUvmbRhVRMpTNRpqYbpsxvaiSC3U47x0qaxrhDUnuPbBLW170O7IjLFIbUSR9
	9sRtSt2VDz8lxGoDja3rbfTIDCy2VCE1E7wDhrU17d8eLhOq5KcPM3TiwZ7a37qMQ8NbCpIelj1
	10+L/GAzUEtj1NME2ncYw9Ae0SMR+gmuLVte/jKF01kCa7O3d61SjcLgsZMhQxreqgGb07v+yQE
	OAadBaD0pl0RZZy1Yc1StYippZqP0+5JmC7g6fQZ707eKhw8FwQXAUrkMRo+zcXq426EESq16eZ
	zu8ZjnvWWak1eRcmq1dYmLDSFsl32A5AqktfN1xWAsZ6BcPhyL1UmjT2zAHaA=
X-Received: by 2002:a17:907:d17:b0:bf7:7d79:e7c0 with SMTP id a640c23a62f3a-c09b8f8f60fmr237382066b.13.1781888976678;
        Fri, 19 Jun 2026 10:09:36 -0700 (PDT)
Received: from cloudflare.com (79.184.207.15.ipv4.supernova.orange.pl. [79.184.207.15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5b304722sm7221666b.0.2026.06.19.10.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 10:09:36 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH net v3 0/2] Drop skb metadata before LWT encapsulation
Date: Fri, 19 Jun 2026 19:09:27 +0200
Message-Id: <20260619-bpf-lwt-drop-skb-metadata-v3-0-71d6a33ab76b@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMd3NWoC/32Oy04DMQxFf6XKGleTdF5lxX9ULBzHYSIyk1GSp
 qBq/p10kGCBxPLa1+f4LhJHx0k8H+4icnHJhaWG09NB0ITLG4MzNQvVqL5p1Qh6teBvGUwMK6R
 3DTNnNJgRzii1IR6aDlnU+zWydR87+yIWzuK1DieXcoifu6/IffWDvrlvog+EHh49rH4bwwyJI
 maaoEiQMNqB8KxPw0j8Qj5cjfUY+Uhh3h1F/XI72f7zclEV13Zj37dsSOnuD27bti/VG/PiJAE
 AAA==
X-Change-ID: 20260428-bpf-lwt-drop-skb-metadata-9a1bdce705ae
To: Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15.2

See description for patch 1.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Changes in v3:
- Clear metadata for non-BPF LWT encaps as well (Sashiko)
- Add selftests for LWT encap + XDP metadata
- Link to v2: https://lore.kernel.org/r/20260514-bpf-lwt-drop-skb-metadata-v2-1-458664edc2b5@cloudflare.com

Changes in v2:
- Clear metadata in bpf_xmit to allow access from tc(x) egress (Daniel)
- Add WARNING snippet to the description
- Link to v1: https://lore.kernel.org/r/20260428-wip-skb-local-storage-from-scratch-v1-1-8f7ca9b378ce@cloudflare.com

---
Jakub Sitnicki (2):
      net: lwtunnel: Drop skb metadata before LWT encapsulation
      selftests/bpf: Add LWT encap tests for skb metadata

 net/core/lwtunnel.c                                |   6 +
 tools/testing/selftests/bpf/config                 |   3 +
 .../bpf/prog_tests/xdp_context_test_run.c          | 175 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 123 +++++++++------
 4 files changed, 255 insertions(+), 52 deletions(-)

