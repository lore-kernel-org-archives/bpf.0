Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC28126BF7
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 18:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512955; cv=none; b=lbz0uisz9EKcY5njZTEyMWevSHiQj7WZp6NYcuWcQ5Qh4wa4jS+dT3GrM/dccVwoZ63KOcp5yAtQ/H02cGyBYbY2XMTb5tKJK16Sl1Ak79PNXi2fhj+IdLvUpYDfHSv0b63xYpKLdSlzlmVSSzAhqw8QCOn3+6Rlk84N8ofcXnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512955; c=relaxed/simple;
	bh=knx7vloSOTFdrtdhgiZFO2alxut3crBKR9dbCoMfk2g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j3jCMuIW87bHY7vPFTqYJPEgYnkca1bAf1pMUGEDC4RDObcbUikxN+lm055/ECB5PqMOTqPDjrFw2KWpDRoYsllTxDVKxt3q8HERHzfPZta9YbyKFxlfHdVSpluY2z5V68OPMuP83Hce6g+KpoShfBIiMP74tTTUOhh+muxXi3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEAEmc4G; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEAEmc4G"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso7223735e9.0
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 11:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780512953; x=1781117753; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EFDUpszOGA6aXXCilSxnjI93bOAnd7od9/DDiSb83+E=;
        b=TEAEmc4GzratzW8bMBfzk8JheaQLQ2DlOe0SadZv+iv8HbyEttMJwKI3TiOhQy3bqf
         OjcL1eazD3Jkja3TWz6cEkUSlYBc3CfJYjJBB9Y9BW7RNRXTIsz82q1CTJV77SIOZ/mk
         fcV2BPIaDpidXUkk3DMInjJhf51XICUEpzcccF7ptwro3qLOqf4ehn5R8T92XzTSeDUK
         PQHkA60Kj8yTOVzKw8K6ePsEVih4T1BZ62B9SyaJym+5/2MqPbf2G86Y2vukqVGx/JNs
         ajz1/LaywdeH07/EnQyYCMTm99aZyQY+R6eZx9HBlg5pSMnWtgyqPT1BZO/CU7lq8DDS
         KL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780512953; x=1781117753;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFDUpszOGA6aXXCilSxnjI93bOAnd7od9/DDiSb83+E=;
        b=WnmSRwz7gJvr4HT39XDM3KteXvFuD+FEaRp2u3BbIi095waedn1fTSh2ntJTHidSt7
         clWZjsGxns4pwzDGYqaXcRA8AzwDngKWOaGG9mQmici+qeyp8f6rzuyTwWOK87yAMdwV
         GD0RZUgDsEzPIBBMjVtqaV/L6w/XMsjyB0f/5rSxKMpgyYSQ2DyFmIdF6HXWjiCXdg8K
         sSNS5iWFqqBVWvhx9cPWPgexBoVq8/VdkJ1c0J8CmH/poFCshld/9H0uk2LmGPf1wQzj
         M28yXRySdMAaNkGbTDRG07EMgJbvneETsOM3ICI4HzvmAXbQ1cMQs5K8/mHTgdCEKC8I
         lcOQ==
X-Gm-Message-State: AOJu0Yzx6sjMDLXChEBI+26KKIZO0fR3ZRxF+2EGYXj94SL2UrARMaFT
	MQFvbwbOqF99RlkkBnbtgPlR6oiJyLOSXv4k8ak/HfhRKabBKv45fA0z
X-Gm-Gg: Acq92OEMFSJZhncvQPOFiVi+NAVwW96kIzdv6dXozcPx4B5xezdlGzZXwRHzwn5/LZ7
	RYhnjyi+h1NfgAizbzw5XFGICS+k/Sr4EAUd6HjeHtvAt8T71QbrdQSmskn/zVYZyDCZQ82ZT7r
	r28xE7lADOn27xp0+uc9gwRAeh1mK5xneCkhdpTVOBmvuRmSiMbBaNIctOHejvRZw2vUKsK9quE
	qWE7jYqXkxRsEppErssYqQRnyng/wQtcDiDcqJDuTuYhhzpQbYKJ7AddzL++zok2dsseJL0yzt8
	tNRfxw5jiLqyq5/4HBEyTHjEwFoBFg/ARu0iGcqiFGPiAmt+3njvhxEQ0M0Q8FFub4eH+whgfCw
	wiCkQInl2P5dPvNKZdJHEnaf+1h7eQIceiyeRPQWYkDp4Rp6jIEeJrcurqPEZ59giXZU68n6cLV
	7CtEyDAcMBcINkThTwHoxGQkw=
X-Received: by 2002:a05:600c:611:b0:490:5000:917 with SMTP id 5b1f17b1804b1-490bc4b73eamr6370515e9.1.1780512952618;
        Wed, 03 Jun 2026 11:55:52 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3b5b82sm11908115e9.1.2026.06.03.11.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 11:55:52 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH RFC bpf-next v2 0/3] bpf: Fix LRU NMI/tracepoint re-entry
 deadlock
Date: Wed, 03 Jun 2026 11:55:24 -0700
Message-Id: <20260603-lru_map_spin-v2-0-7060cfb6cdac@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ14IGoC/1XN0QqCMBSA4VcZ59rFdlIzr4KgB+g2RKae5YGcY
 zMxxHcP7Kr7n+9fIVJgilCKFQLNHHl0UApMBLS9cU+S3EEpABXmKtNn+QrvejC+jp6dLAhVZ5r
 GprmCRIAPZHnZuQfcb1fReCsdLRNUiYCe4zSGz/6a9d78WCz+2VlLJVObIeJRn1RrLwNN5tCOA
 1Tbtn0B/jJD37UAAAA=
X-Change-ID: 20260519-lru_map_spin-8e20dabbf460
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 syzbot+c69a0a2c816716f1e0d5@syzkaller.appspotmail.com, 
 syzbot+18b26edb69b2e19f3b33@syzkaller.appspotmail.com
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780512951; l=1571;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=knx7vloSOTFdrtdhgiZFO2alxut3crBKR9dbCoMfk2g=;
 b=YELat7IWG/xule6L5DcoSlrOmMoA7mT4sBkKpMvbSOqTIGMZKtuwxK977l8XCS3fMBuiz/KM1
 vyb55cHfYiYDkdJmJ3aIiRuA4nLGOg80iqMBtUW0B+nRBrXzq+noYWa
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

This series fixes AA-deadlocks where NMI and tracepoint BPF programs
re-enter the per-CPU or global LRU lock already held on the same CPU
(syzbot c69a0a2c816716f1e0d5, 18b26edb69b2e19f3b33).

Patch 1 converts every LRU lock site to rqspinlock_t
and adds explicit recovery for some failures so no node leaks.

Patch 2 refreshes Documentation/bpf/map_lru_hash_update.dot to show
the new rqspinlock failure exits and recovery routes.

Patch 3 introduces a stress test.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Changes in v2:
- Patch 1: __bpf_lru_node_move_in() now clears pending_free only when
  moving to the FREE list.
- Patch 3: address sashiko's feedback.
- Link to v1: https://patch.msgid.link/20260528-lru_map_spin-v1-0-4f52223170cf@meta.com

---
Mykyta Yatsenko (3):
      bpf: Fix NMI/tracepoint re-entry deadlock on lru locks
      Documentation/bpf: Refresh map_lru_hash_update.dot for rqspinlock
      selftests/bpf: Stress LRU rqspinlock recovery paths

 Documentation/bpf/map_lru_hash_update.dot          |  44 +++-
 kernel/bpf/bpf_lru_list.c                          | 165 ++++++++------
 kernel/bpf/bpf_lru_list.h                          |  25 ++-
 .../selftests/bpf/prog_tests/lru_lock_nmi.c        | 243 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/lru_lock_nmi.c   |  33 +++
 5 files changed, 437 insertions(+), 73 deletions(-)
---
base-commit: 245da8192c073820390f7fa1cc1e834b32119bce
change-id: 20260519-lru_map_spin-8e20dabbf460

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

