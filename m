Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C1C352034
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 18:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992140; cv=none; b=jy5ntkXBR7+U0OS6hpSFveepj2JX/Vxv3ewx+Hco4bpBMf6t+wkqvRHtayRirWwXA3JtEoQGH0Tf1Vy5ygOzKQENljQ3FGyijV8K/XCZvNWVC5fxQdsICnla6sVkffc0QNHEl57enptdA2XgTp4Zg+YG0wT573JECFfk7kqRIM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992140; c=relaxed/simple;
	bh=cb4U2Si3K8QOl5jD0yIag9CfRpslIR/gvYzEE3h3byA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i/w8Twl61OJHBSchfntTXF9pwUZRp8/niZfsnCOlKanl8ukDN53bvCAyiGgNmIdKjJ0ElBXUeSqzns+eHiJ8nn4E6h+Y0iuZJExXUm0QyVQ/c+uhIepZ5kjqcorSXPbjOkCM7Ps5kktZ9VjRgY5usc9y6aoz1lCzW7Jreasc9E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhurpHfc; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhurpHfc"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45ed9336049so2702839f8f.0
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 11:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779992137; x=1780596937; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QrBQ0l7Fiu4edckQS5V63QMXMV3VadWEYHK9tER1dv0=;
        b=PhurpHfcCSjDd10RQDWZLxhaA21/93tRfyj8gmxutBJobexgL7gqg5QJ8NibZNd9/B
         XjggIzupz0xBGvpofJitEhcyemJAFyCnaoTO9eaNJCMxkPqGDneC+7PvBNO6/Ypqe3+R
         DQOT2KzzbertM5z+bFPs158yhkUgGxNN6CeXAq36NYPtGfNL4jqG622yGSopQJrREifv
         AZfbyjsJj6n9igcvOOE2VyIYInL84DTE3gqWxDw2xkxhYt4+pZBMmiqB2qfWOvaLyU93
         zv8PkCAyII/gPnts6V+hcLmBi0wR6qBT35AvKEqPhalCNKuw7chA4BjdpflIqR2/oEbZ
         0ROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779992137; x=1780596937;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrBQ0l7Fiu4edckQS5V63QMXMV3VadWEYHK9tER1dv0=;
        b=gVjd8P20EBX/dCkMchtQBsDwJbmfD6QG/1bqZxlbdI0A7gQKnUJIV7y6xyJLXiyQ+A
         v+0Jgp2aRCh68D23KrZ0T0rr4CJqRVAUZa0+ROtaiw8mTcvAQKRfBPRfBHdxS/yE4aTa
         j1uEoyk1xbZOPSPsgOPdM3BV9UZWJUOJKZ2wEJ4r46fnSZWUvUdR0bNADiTvu2d2VSpH
         FCIb16sIogdc7yDxPFvjcX/xvCckvMxHLD5ExImHWpvH85ouMl4wo6c2xuCZR2PvuPYe
         oq3eREfXCOs6zpmQh6+vwGF+c0usN+zUI7mWIpn/Qou+/pWPORAjMBG4QzLXASIPQKj6
         deWw==
X-Gm-Message-State: AOJu0Yw6rkFPXptXliL50UAKUQwmCKFIfsR/E1r5dbWG6Bg3Md4lIWQj
	6HxsbC2uNLwJGgFHFoikAhP76SYDSFrCluV6MJ5LgQBTADHuOFUvZJMYvW73+8jt
X-Gm-Gg: Acq92OFkgwqa++V7illfpYh4xfgZUEZ7fVYLSELZbN9d2CaAiAPlkop/OuIgC0ae11u
	sjcvLizXvFQTZ8R0Q3IJZLPDjlLJ99cywPlrsFjb4e2aMizhmsehVdzZhK0RorsdGymvHwh+GBH
	e8ZLyxT/LO5ICFZXJX83g4Hpj4yg2T4JMqpqP4YwMDtaZgT6OlLqOmx0WDnRpU8q5JFtc4lr8ux
	iykU2HtP2fjM1g/Ght8K+nZRtRtfE0KvmXdVKPM8wcWjc7VXQF/iSXlSFq6r0Ge3XTONrjoPZ3U
	wE28NSG69FA/zq/43Hd8ZOk6elZvbpg7DseMQTvEK+BAF87TCR7OrlwO3X64QqWCGXLs5jjYrWN
	Yg1dB1tjKgd/x81LvYfh6w4ZQXUzYawpHzs8yd38vULnuoh1RGt4wF7ilvtn7TbWmPH9p24jHRY
	yH3LAAjBixsjmEmpmWSRCWo50=
X-Received: by 2002:a05:6000:1006:b0:45e:db3b:921d with SMTP id ffacd0b85a97d-45ef05f84fcmr302826f8f.31.1779992137334;
        Thu, 28 May 2026 11:15:37 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5b314dsm14232019f8f.30.2026.05.28.11.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 11:15:36 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH RFC bpf-next 0/3] bpf: Fix LRU NMI/tracepoint re-entry
 deadlock
Date: Thu, 28 May 2026 11:13:23 -0700
Message-Id: <20260528-lru_map_spin-v1-0-4f52223170cf@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMOFGGoC/x3MQQrCMBAF0KsMf91AGrRotoIHcCulJHaiAxpD0
 pZCyN0F3wFeReEsXGCpIvMmRb4RlvqO8Hi5+GQlMyzBaDPoY39W77xOH5emkiSqExs9O+/DYdD
 oCClzkP3f3XG7XsinoCLvC8bWfp26jaBsAAAA
X-Change-ID: 20260519-lru_map_spin-8e20dabbf460
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 syzbot+c69a0a2c816716f1e0d5@syzkaller.appspotmail.com, 
 syzbot+18b26edb69b2e19f3b33@syzkaller.appspotmail.com
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779992135; l=2233;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=cb4U2Si3K8QOl5jD0yIag9CfRpslIR/gvYzEE3h3byA=;
 b=CArPmUbU1AYYimxgBinLctNb1JdZmP2Yi1FlhG37Svbr3ZY8DDY3S62X8C65FqlpnDOwInXt3
 ZOl98+9XnbMCjN+8RVv8xWjvoPmZxEsZ6H5qBi9Xv3bdX6lbg15kW/4
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

This series fixes AA-deadlocks where NMI and tracepoint BPF programs
re-enter the per-CPU or global LRU lock already held on the same CPU
(syzbot c69a0a2c816716f1e0d5, 18b26edb69b2e19f3b33). Three prior
attempts have been nacked since 2024.

Patch 1 converts every LRU lock site (six of them) to rqspinlock_t
and adds explicit recovery for some failures so no node leaks:
per-CPU lockless free_llist for stolen-node recovery, plus a
pending_free flag honored by flush, shrink, and the steal path.
rqspinlock blocks like raw_spin_lock for normal contention and only
fails on deadlock or a timeout, so steady-state contention does
not degrade reliability.

Patch 2 refreshes Documentation/bpf/map_lru_hash_update.dot to show
the new rqspinlock failure exits and recovery routes.

Patch 3 replaces the original single-CPU NMI reproducer with a
parameterized stress harness across three map flavors (common LRU,
NO_COMMON_LRU per-CPU lists, per-CPU LRU map): perf-event NMI BPF on
every online CPU plus one pinned userspace hammer per CPU, both
mixing update and delete. Post-stress drain-and-refill asserts every
slot is re-allocatable - a stranded node from a failed push_free
recovery would surface as -ENOMEM that never clears.

Tested on a 4-CPU vng VM with PROVE_LOCKING: lru_lock_nmi (3
subtests) and the broader test_maps run pass with no lockdep splats.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Mykyta Yatsenko (3):
      bpf: Fix NMI/tracepoint re-entry deadlock on lru locks
      Documentation/bpf: Refresh map_lru_hash_update.dot for rqspinlock
      selftests/bpf: Stress LRU rqspinlock recovery paths

 Documentation/bpf/map_lru_hash_update.dot          |  44 ++++-
 kernel/bpf/bpf_lru_list.c                          | 163 ++++++++++-------
 kernel/bpf/bpf_lru_list.h                          |  25 ++-
 .../selftests/bpf/prog_tests/lru_lock_nmi.c        | 202 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/lru_lock_nmi.c   |  33 ++++
 5 files changed, 394 insertions(+), 73 deletions(-)
---
base-commit: d34771f2f3db4ea0dd532cdd579002fc95dc483a
change-id: 20260519-lru_map_spin-8e20dabbf460

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

