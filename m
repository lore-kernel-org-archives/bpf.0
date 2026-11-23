Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438145;
	b=M3EgZg3GVlxsnCw98Xms6PPBuCnjN1p4HcKTdIsAH1kfcVYU2EHjluDV6V5e0kPjlt5R
	 Gat/VRy7kemHUtiTlknHOGa3bUF3Du48+5yW6J6fjqV4m+Xq9ywoO+UljiY/QHJ8D2bpq
	 oanV1hjFp2wxucy/ENxVMClbqtabK5ulir4OKM/9n6hvLt3dakGPFA/j/2Knqwii7xDmG
	 cXPQKAWtUnerSSobYKf+2U0bbR+zE5m1lcKcaSylP/vPV7VEbE/oaAL4CMlugi3q78GF4
	 sa5gPo6/n5DnrF/HWqiH1x4m4onhZRWpDFIq0NB6tYIB+R9cHTJhceVRlk7e1TLitig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DhK6CtMOLYZCVdUuss7wafvSK3dtx+GbAoe1f/T7oT8=;
	b=VOAKXadpfvGZc9jPATH2g1c3doeqa4l/MiAuqw5EkgeqCBX3mwzkgg3veLHs1pNN5G3A
	 OSzh24k66Tw6LM9cBmbhVFGNLHcIJAsSZ3Zn2UawDN04xcEC0moK7tbcICsyk8YMTrWen
	 BkYNqDmzuJ6yielfV11pP0hCH4T42Nyc9fhLBn8P9M2a8cqj6IQAUP9CtJfYvA2EESXTt
	 6adGQyCL5YUqM33G7pucBoirH8wzWW2C+OV6M6eOXxb8vrdpI9VOxmkqKi9Uc+2/WIMtY
	 PkfqNKfGaO0NvH2Yks19lpWNa69uPcdjHdHEIlz/HEJxhFStjjzCs/OrpSxPrgDewPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hsFF5YSQ;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D691606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 12:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D691606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hsFF5YSQ
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso25212315e9.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 04:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795438143; x=1796042943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DhK6CtMOLYZCVdUuss7wafvSK3dtx+GbAoe1f/T7oT8=;
        b=hsFF5YSQpULfJ7UU3yf6gePPrgLzGPpQGEr9byySTcmMiZzNMUd5KQzuLtfMjRsSSq
         r/r4niBQPj2bPpnzW+fzmJkXDr8egb6JTq4pQ6o10q6NVz2odjdWWXX9AfLqTCUh9XTn
         1pfLoCDYjggp+DV/iAPRim4+9tKaQr3oOefVKTi3aBv6GxrO+J+sUteCKyYlkZFUqHKJ
         ewfrYdy8jNRy6SweMe760ZkOSF1rCZcUVjZnlgRQihnTABbeNtPpOAXIB5WwRSiPr+Wn
         Oy/so54F0sovqvmwz7pV+EGEsgQ46OypTUm6SphaM7pFCO+oOFKpe1mLM9YTtaT1sJlJ
         SiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795438143; x=1796042943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DhK6CtMOLYZCVdUuss7wafvSK3dtx+GbAoe1f/T7oT8=;
        b=CmPyaICTXDa9NbjsDL8NQ63rLk6EKFpJA4TUBxsqTguHvft+QsvDonOeM5IhSwCsQI
         maid/+Vt5qM0GBIUVpssZzzIN+UwvakbOnW/aswVW6akVaX0Gy2bjFnl7XS1vYb7QMXs
         FUeN17PLaC+EjP3ClD7uOnsN4CDBnWz6nuH0w7aLMjegX4WsNX1WpOJFhbyK/cX1YRjm
         VXI3NJFMNoQhx4S2wWnRrp4PMA91rHF9SVo7yw76yPoEKdysTzHBs97mHmKd6XPdEMD6
         zYZqJP8LkPV42dWO1wJNlHR1k4IQsH4BrStFAY2J58TH5U5YlOqb+z2sVXnnp4ZApCth
         sK1A==
X-Forwarded-Encrypted: i=1; AL+hErHdFA43cUw5CcRIwx+ydXGPi807MLYL1c1U1pG85uEZGzppqEQhPfFX4wCKRKpMSLbhPxI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/B2IAFIplp3+tIUWJ+X7iivwKo27C55TFMQRZtWwFHDwgkGY9w
	ljhpq0yGpyfNb20dnd584Jk0EEzW86RrFJuax0uLzjEgc0t38QPlViUU
X-Gm-Gg: AZFdTZdiyP+wSALC/OewVYBmXGMaM58gl/H8Z7NUiEaoOV/i1KYvdKjYJB8VRAqjLjf
	uxJUiDBfEKooBcfDtJMM5nyN5QnPBxEITDjo4IZ10+i9hRA3U7lXWUuxQs+HwZswd1sOqbicmo/
	5dk0oozGJHHU4JAoOcKXxD9laiQFNWvy17jLg47g00Ii/CcxT/f38rLJkzgaf+Dzf8rN3Ys49En
	mVf7kSuzFrfgPaBWpaCrCJo0SIRql5ZhH9YACJKL/Bg8FDQSXGaut7EEzAKTTnxAE6vz/XP/zS2
	gjOA5avZTuOWXWL8PsBbNNgkQVu17j9SUKp6AFzNmIZI1mmA9PemV1AIgdqGEQpsbGB0NYr4u+Y
	tUOBMtXEIdUrqahc/T8AVZQGF0oaDZXEm0m3RIg0ZCIS6HWA9RCMpWoL4x/rmeFqHiH/0OpbpRs
	9mw7NSlqZe2hYpiVD4/pVtUfVPRIIKLtLnpaSQtubyPPXjV67aRjsWGSu6bMW7SQKfyvS5iH2qk
	RwOPIMXMkagjPxYPMG9+i348xigPjoei3/5k4K835dW1eGoXjb0wf5pAxp6zyUmKPPq+aKWgcjb
	kbL9oxwQ8EcU5umTF09NGrIym1mcW4yvuOn9chPt
X-Received: by 2002:a05:600c:154e:b0:4a3:59ee:86b with SMTP id 5b1f17b1804b1-4bb887c3b63mr248348265e9.4.1795438143282;
        Mon, 23 Nov 2026 04:49:03 -0800 (PST)
Received: from Philipp-PC ([91.227.186.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906817ccsm165097045e9.5.2026.11.23.04.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 04:49:02 -0800 (PST)
From: Philipp Sudakas <filzador@gmail.com>
To: ronak.doshi@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	u9012063@gmail.com,
	Philipp Sudakas <filzador@gmail.com>
Subject: [PATCH net v2 0/5] vmxnet3: fix native XDP crash on oversized frames and XDP loss on reset
Date: Mon, 23 Nov 2026 15:48:50 +0300
Message-ID: <20261123124855.1021-1-filzador@gmail.com>
X-Mailer: git-send-email 2.56.0.windows.4
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes for native XDP on vmxnet3. A single frame from any host on the
same L2 segment can crash a guest that has an XDP program attached;
any device reset silently stops XDP; and the attach error path leaves
the driver with a program it holds no reference to.

Patch 1: the rx data ring XDP path leaves rx_ctx.skb pointing at the
ring head page after a non-PASS verdict. Patch 4 relies on rx_ctx.skb
being NULL between frames.

Patch 2: vmxnet3_xdp_set() releases the old program before the device
is active again and does not roll back on failure. Keep the old
program on failure. Patch 5 removes the side effect that used to hide
this.

Patch 3: with an MTU between 3051 and VMXNET3_XDP_MAX_MTU, full-sized
frames do not fit the 3072-byte rx head buffer. Limit the XDP MTU so
that they do.

Patch 4: a frame that does not fit in one XDP rx buffer (sop without
eop) reaches the skb path, which takes the page_pool page for an skb:
kernel BUG in skb_put(). With MTU 1500, a single untagged frame of
1523..1526 bytes is enough. Drop such frames.

Patch 5: vmxnet3_rq_cleanup_all() clears xdp_bpf_prog on every quiesce
(MTU change, down/up, ring resize, reset). XDP stops being called while
the program is still reported as attached, and its reference leaks.

Reproduced with stock modules on Debian kernels 6.12.113, 6.12.117 and
7.2.12 (7.2.12 untainted), VMware virtual hardware version 20. A small
reproducer (raw frame sender and an XDP_PASS counter program) is
available on request.

Testing:
- Run-tested: the patched vmxnet3 files of net as of today, with the
  driver's current vmxnet3_ethtool.c and headers, built as a module for
  a Debian 7.2.12 kernel; VMware virtual hardware version 20, MTU 1500,
  native XDP:
  - untagged frames of 1514..1522 bytes reach XDP; 1523, 1524 and
    1526 bytes are dropped and counted in drop_total; 1530 bytes with
    a VLAN 0 tag are dropped; no crash;
  - 5000 frames of 1500 bytes mixed with 5000 of 1524 bytes: exactly
    5000 XDP passes and 5000 drops;
  - with XDP_DROP attached, small frames over the rx data ring
    (64 and 100 bytes) are dropped by XDP, followed by normal and
    oversized frames without issue;
  - after an MTU change, down/up and an rx ring resize the same
    program keeps running; after detach no program is left loaded;
  - MTU 3051 is refused with XDP attached and attaching at MTU 3051
    is refused; at MTU 3050 frames of 3064 bytes reach XDP and 3073
    bytes are dropped;
  - attach and detach failures were forced with a test-only module
    parameter that skips vmxnet3_rq_create_all() and returns -ENOMEM:
    after a failed attach no XDP program is attached or left loaded,
    and after down/up the stack receives again; after a failed detach
    the old program stays attached and runs again after down/up, and
    is freed after a later detach.
  No warnings in dmesg.
- Not covered: the rx_error paths (no way to make the virtual device
  report a receive error), and VLAN tags other than 0, which the test
  switch does not pass.

Changes in v2:
- New patch 1, and the rx_error double count fix in patch 4, after an
  automated review of v1 (Sashiko).
- New patch 2: v1 patch 2 made the attach failure path in
  vmxnet3_xdp_set() reachable with a stale program pointer.
- New patch 3: v1 left the MTU 3051..VMXNET3_XDP_MAX_MTU range as a
  known limit; it is now refused.
- Patch 4 no longer counts the dropped frame against the NAPI budget:
  in mainline other non-PASS XDP verdicts are not counted either, so
  the v1 comment claiming so was wrong.
- Patch 4: fixed a line over 80 columns.
- Cc the networking, XDP and BPF maintainers and the author of the
  blamed commit, as get_maintainer.pl lists them.
- v1: https://lore.kernel.org/netdev/20261122002847.616-1-filzador@gmail.com/

The problems were found and analysed, and the patches drafted, with
the help of an AI coding assistant; reproduction and testing were run
on the reporter's lab systems.

Philipp Sudakas (5):
  vmxnet3: clear rx_ctx.skb after a data ring XDP verdict
  vmxnet3: keep the previous XDP program when attaching fails
  vmxnet3: limit the XDP MTU to the rx head buffer size
  vmxnet3: drop XDP frames that do not fit in one rx buffer
  vmxnet3: keep the XDP program across device resets

 drivers/net/vmxnet3/vmxnet3_drv.c | 27 +++++++++++++++++++++++++--
 drivers/net/vmxnet3/vmxnet3_xdp.c | 22 +++++++++++++++++-----
 drivers/net/vmxnet3/vmxnet3_xdp.h | 10 ++++++++--
 3 files changed, 50 insertions(+), 9 deletions(-)

-- 
2.47.3

