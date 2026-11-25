Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795593188;
	b=4gvWnDx61rlEmKaS67cl4fEAV+zh+Tav/Di6GZA1xOBzVI6MyzAdx/7Tm3imRRJ27L0f
	 wutjSd+TdUwI3rhtmrtog1+QDpv4EOeh75/diNenOUmtrXrHO2iNE9FXi4tpLxj9Rx1EC
	 CkOjNu0jTs2qNiLhziwIcWtjRdZQCZ3X0x7aDCtLz8gOnJ/lbvqgoNTVSlCvJJ8vabx+1
	 XXn8xsWaOuvu+CU/tkQQfMK1cie3BbTvZhf+9aqwMmsQPn7VliPci3NYQgoo3Vks/fkyN
	 xHMvJZ+QxD0mKor/5KOdBue9CEIOat4uR1pgIQIxadBJoxjOjgjaolYYskdxl4IEGAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zf9bT3s9LlKEPRvd3hDZDLoiBKI5UFbuOVhEvjeVPsA=;
	b=HWaHxuNIu1SniKH8nVA9PWv6KWxcrINyFYu8TBIAxndW8j7Mh56wjRoF+sqcPRREjRx5
	 kh0QhQF6sh+AZCfXv3tiambN+O3gB9r6oKjON9N56nTLR9YG0h9O6YFunbCVx+B/+K/w7
	 +6he79gcI72BlyKxye2w9UZujHlSxwfTn8paqby8t82O+PqTzWzoZ4jp57QwDAByJtgGt
	 h5M1CLkh6DC5iT8Dh2cRFnTFe/iudKDsNd5xVLqvzTnTCjfYzTxV9t0soVr5A6NjJYG7Z
	 UhOKiD+ihiwheECymQEuwd+h+xGcsrHQSGL1ume5UP9ncYllImSUP7/QvgnB8wuywhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FJmm1CEz;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4889E606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 07:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4889E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FJmm1CEz
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so5062190f8f.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 23:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795593187; x=1796197987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zf9bT3s9LlKEPRvd3hDZDLoiBKI5UFbuOVhEvjeVPsA=;
        b=FJmm1CEzG6Pw/46o4L/yzPr+DRfv7bMdYF/S8P/dn7tqHpeqHPSoeSc72IfMQ66YwN
         bzapHWBMqaijDc8+kS9beBDXHWoY7RECRgJ2DS4UqPj3T1l++q/Gi3tJpI0ZBy+6vRFb
         LJwRnMUBTgzRHz4KLKe9T/HQT7XdU35S+J4EwiJ+UpeEjNZn4mF36jDtAHWJY3hovmi/
         9pKaQb8gs2/XkttFrLBAuXLoX3sbSQOTbFyzPQWgKk5EPzi34m2SBJ/E9oU5GwjYGBks
         o16sWTxQ3rzJELadKJWI1Fn3Dm6yY8f7Dt9tYXgletJII3dwsXzTMLmmyhrJ0StzDECH
         +y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795593187; x=1796197987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zf9bT3s9LlKEPRvd3hDZDLoiBKI5UFbuOVhEvjeVPsA=;
        b=p+oo/KXoTM8L71Y+WRh8Bj15fSo/ZIFv8et+XBayPKyHQMJH8iys4V+bVS4fQ48Etv
         5JSLo8TdGsWr4OmIsXYoPZ//cI6pPjgWgqQlga2uRDfEuIrO0qHmkbA+qPeXVjT/BSIw
         UQQkOqf+p6admrY96p6R0i26XMvcbQmFEmWRbfTXR5Q39fd1TjW9YlHKHQz9iYd4H9L1
         K5eW/nBR+iFTmSRvI6IMrWqFsJBYnQmv66AiV2v/15Sx5dt98Dc20FAJFdTp0wWVForA
         03Dizi3epHUujSeQbqTjN8tdVsi774CpILjZKPGnNgnQbHT3ez3iQOqjTjhqg1Nu3yim
         SWfw==
X-Forwarded-Encrypted: i=1; AL+hErESonP1rLTIUAzue97fl/Zi9xkShEgsxcYCoPoZPGZkMzEq30MpDgKIBF3BVIi1HRSMe2I=@vger.kernel.org
X-Gm-Message-State: APuU4Z82EMTmcf3ihqA8GZHoBHkmy5rUQR2wu6D9NkCM/xHZMSSBwU9W
	U7E8ufZtGrHaG8dA7pzBI1JCoYYcV+8rcwOKexsSLNZyn4+QooqOI03A
X-Gm-Gg: AZFdTZfg45RvisFSKpLmJtE0k2gyu6j4VLeiltrJdbBNO8i6497z1+zzEGpew+73Cw1
	oWvttFuWT/4khcdRudACOT09wc9dAefKYzzRP/KjM0rJ3pF+lKD7BZZbfusFPmFnTzHWAg73Uph
	TBkoNgmafLdRTyOiaLMNx0YdMyU029uHq0URczdMxzUTut52xSo7C9nDQxH73TerHkyiEgqIjEA
	ZbdcHGEXyTaUoYH0Nc2ztPtZ6OMwTaFdqI4EitGIFcjauIutEQfak0lr0lSxSqZrvKcUkXYGsqy
	CsE6asqAZwUE7+FZBpd3AmP5WIXOB0LeQ+Umapr1jF0ZdmIpYw11mHwDSu/QGPyRVyeyTBurw7z
	TbdNQgbA4Cq1epy7quT1O/xavnUkXTxLwBSGXGRsPM/kfbhp64mf8hFgA1urZSB31uw6QTt3zDW
	aRqfF7Z3B1/H96vI1gER2CQlbDRqdyoTXFCswak2KB9ex5lc6c+KtZ9neoi5z7flNqj5VQ4C2O4
	9qePE7Tl+vTM2xBDK3a/8Sl0nrAnwPb1m/rJHIjFEQRbrkrpiAt1UgAk4c0zkjWTLGavcXZELXn
	EqZuI0PSSi8rAYeMZ9jw+/QW8RLZ5XOiLpWW+PMY
X-Received: by 2002:a05:6000:29d3:b0:4a5:4367:dc84 with SMTP id ffacd0b85a97d-4abb400bcd6mr21015674f8f.18.1795593186427;
        Tue, 24 Nov 2026 23:53:06 -0800 (PST)
Received: from Philipp-PC ([91.227.186.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a680483sm33001138f8f.28.2026.11.24.23.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:53:06 -0800 (PST)
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
Subject: [PATCH net v3 0/5] vmxnet3: fix native XDP crash on oversized frames and XDP loss on reset
Date: Wed, 25 Nov 2026 10:52:50 +0300
Message-ID: <20261125075255.1517-1-filzador@gmail.com>
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
any device reset silently stops XDP; and a failure while switching XDP
on or off leaves a stale program pointer and a half torn-down device.

Patch 1: the rx data ring XDP path leaves rx_ctx.skb pointing at the
ring head page after a non-PASS verdict. Patch 4 relies on rx_ctx.skb
being NULL between frames.

Patch 2: when vmxnet3_xdp_set() fails to recreate the rx queues or to
reactivate the device, it neither rolls back the program exchange nor
restarts or closes the device. A failed attach now brings the device
back up without XDP and returns the error; a failed detach is
completed, so the driver and the core agree; if the device cannot be
restarted, the interface is closed. Patch 5 removes the side effect
that used to hide the stale pointer.

Patch 3: with an MTU between 3051 and VMXNET3_XDP_MAX_MTU, full-sized
frames do not fit the 3072-byte rx head buffer. Limit the XDP MTU so
that they do.

Patch 4: a frame that does not fit in one XDP rx buffer (sop without
eop) reaches the skb path, which takes the page_pool page for an skb:
kernel BUG in skb_put(). With MTU 1500, a single untagged frame of
1523..1526 bytes is enough. Drop such frames. This also fixes an older
cross-poll BUG_ON on the non-XDP path; see the commit message.

Patch 5: vmxnet3_rq_cleanup_all() clears xdp_bpf_prog on every quiesce
(MTU change, down/up, ring resize, reset). XDP stops being called while
the program is still reported as attached, and its reference leaks.

Reproduced with stock modules on Debian kernels 6.12.113, 6.12.117 and
7.2.12 (7.2.12 untainted), VMware virtual hardware version 20. A small
reproducer (raw frame sender and an XDP_PASS counter program) is
available on request.

Testing (v3):
- Run-tested: the patched vmxnet3 files of net as of today, with the
  driver's current vmxnet3_ethtool.c and headers, built as a module for
  a Debian 7.2.12 kernel; VMware virtual hardware version 20, MTU 1500,
  native XDP:
  - untagged frames of 1514..1522 bytes reach XDP; 1523, 1524 and
    1526 bytes are dropped and counted in drop_total; no crash
    (v2 also: 1530 bytes with a VLAN 0 tag are dropped);
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
  - replacing a running program: the new one runs, the old one is
    freed;
  - failures were forced with a test-only module parameter that makes
    the next N vmxnet3_rq_create_all() calls in vmxnet3_xdp_set() fail
    with -ENOMEM:
    - attach, 1 failure: the error is returned, no XDP program is
      attached or left loaded, the interface stays up and receives,
      and a new attach works;
    - attach, 2 failures (recovery fails too): the error is returned,
      no program, the interface is down; after "ip link set up" it
      receives;
    - detach, 1 failure: 0 is returned, no program is attached or left
      loaded, the interface is down; after "ip link set up" it
      receives;
    - attach while the interface is down does not reconfigure the
      device and is not affected.
  No warnings in dmesg. (An intermediate version that used
  vmxnet3_force_close() on failure triggered "Trying to free
  already-free IRQ", hence dev_close() in patch 2.)
- Not covered: the rx_error paths, failures inside
  vmxnet3_activate_dev() itself (only the queue creation failure was
  forced), and VLAN tags other than 0, which the test switch does not
  pass.

Changes in v3:
- Patch 2 reworked after automated review of v2 (Sashiko): on a failed
  attach restart the device without XDP, complete a failed detach
  instead of restoring the old program (dev_xdp_detach_link() ignores
  the error), close the interface if the device cannot be restarted,
  return the real error, change the redirect target feature only once
  the change is done (also when the interface is down), and use
  rtnl_dereference(). It does not wait for VMXNET3_STATE_BIT_RESETTING
  under RTNL, which could deadlock against vmxnet3_reset_work(). New
  subject.
- Patch 4: count the two body buffer allocation failures in
  drop_total, so that skipping rx_error for a dropped frame never
  loses a count; the commit message now says that the non-XDP path
  changes too, and that the drop is not counted against the NAPI
  budget, like other non-PASS XDP verdicts.
- Patch 3: fixed a line over 80 columns.
- v2: https://lore.kernel.org/netdev/20261123124855.1021-1-filzador@gmail.com/

Changes in v2:
- New patches 1, 2 and 3, the rx_error double count fix in patch 4, and
  no NAPI budget accounting for the dropped frame in patch 4.
- v1: https://lore.kernel.org/netdev/20261122002847.616-1-filzador@gmail.com/

The problems were found and analysed, and the patches drafted, with
the help of an AI coding assistant; reproduction and testing were run
on the reporter's lab systems.

Philipp Sudakas (5):
  vmxnet3: clear rx_ctx.skb after a data ring XDP verdict
  vmxnet3: fix the error path of XDP program setup
  vmxnet3: limit the XDP MTU to the rx head buffer size
  vmxnet3: drop XDP frames that do not fit in one rx buffer
  vmxnet3: keep the XDP program across device resets

 drivers/net/vmxnet3/vmxnet3_drv.c | 31 +++++++++++-
 drivers/net/vmxnet3/vmxnet3_xdp.c | 84 +++++++++++++++++++++----------
 drivers/net/vmxnet3/vmxnet3_xdp.h | 10 +++-
 3 files changed, 95 insertions(+), 30 deletions(-)

-- 
2.47.3

