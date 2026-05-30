Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D3730C60E
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 04:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780115243; cv=none; b=TP8Cs4STUQ5/EYNE6LP2Naqk/BGENQmC5vAUbketZ+kQcrrlv3qY5DaFlP6BhUFSsbn8fTtCp/9HPfhtzugCYJMQonjve6qVJruFCQ9N2jI04W0G9OcQGHg8JIlZp1Ym+Pvk9wU3OJ62PtbYYX93erlP3mv1P+qwG7HEY15g4Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780115243; c=relaxed/simple;
	bh=A8ei1zfEh8HnY3n/gMP6Y+CHm+bE51ejJm5tn+ywBfM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MrpisZoxFovOkZqXRGx0QnKItpJiTw+/cN08FeM2S9C/f51h4vX4OUGyT1keV0WU26k5HFJcKKAxqfYzGk7/7dyRye2oKp/0EGLkdIEfObnW0xFYJGckhJ3dSiqSJNURJFWnj25raIQdWtnrwB5d6IHggmyeWNtDQp0y0qOGoSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhUHVFnl; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhUHVFnl"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3680540a6efso8224730a91.2
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 21:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780115240; x=1780720040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZFm47Cq6NfmQZ2ABkjht9LuROyFP5W08K9dHfNwh3A=;
        b=WhUHVFnlLmIwekm7VnkMlShpu31+/qKfefB4hUwj0MRaIS/v8WB1q9BAeHsx4thvp1
         Cg8E5CwylXc+PV2vNso0mprowTyV2RG9BxBbVuw8bztBxR99mRuFgcMtkaX9WLgl+WTV
         Abu69rRty479cJN6Y07znl/hCkR8y3eTxr0PCTqHVMb0IUOlsTSzVIvf/pTmZj2giYU8
         2TM4qhNqXYdbdVJmSDXDaHN+6/6x23a+VZXWV/W4tUhdDIPETsOC28wjN8OEkL9qNcg6
         4a4VeqdRlxZ1Ze8huqoWXLr3AzyKOlqqG0GG33Fk+QGX1gHv9bLIrsBaiDg/WExBRCKU
         OOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780115240; x=1780720040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZFm47Cq6NfmQZ2ABkjht9LuROyFP5W08K9dHfNwh3A=;
        b=nV53MT+OzR8EmOCoKQzCArNGXTqVtw3RjOiOmOz8JZRHaXgcMN5B+fPLtVCni+iY2L
         +i5tz/wPi2lcjHlBD60tNtavOTjuAC5FpJ76ih/n7/f6FsDI01X98xRg46MzqFg/zoBG
         wfgFn0qH3jBwlhEUKB9eEvXJQGMZHFlU517DMdglJbAC+rWg9DkKbfdlGdZSU1YYdyhl
         403Is4yxV0/ume+0U6PtxFyQ3JUpkYuMe5xufeL2/Ii38EogPCL4FWyRhFhDtdqn6mDa
         kpLazuEwoXxZBysuGXaplAcjnFtb7Vq0FFLbvB445SpEtbDpI7nFHDhp39/3HQkChN9p
         JC1w==
X-Gm-Message-State: AOJu0Yz5jZpahLOs4anSvAlysR+lfyNw6paorssOFGy5Ys/JWCITfgq6
	UOQnqH3TS1UrQsubarO61XbsAAgyEmydyInfppBi4LrtCf0bD6cFF8tz
X-Gm-Gg: Acq92OGIRgsaFSXpzD6S4JID564qia/KIqBwRiUimk6ffqq2P2oH3ZL61m44PLy0JTN
	4x1HCqh8LJEDKmLABSVLzb8eU7IlLA1WlsVzakJUGjEZXbMhDq/M8bZti/QR+GHKhZiU0J/CpdU
	yEOFraJHBJgIL2WVzLZ6axAwKbdw487xdNwH6lu8fOhmDQbDWXu07oYH2t8EIuSDqGVkrrFfDcu
	iPq3Jk5W3X6q3awswxLKRQ7NDBJfb+E4KZKe1DooV9dbtMxeXgs44UsgNpLfEmKaTrQIcxcbGl7
	I6cEnLOb+Nhk21OYZNz8HAtJb24OOo9+c1pMtvN2sa678/c5dWuZcjmDde9jBtW0Z4wBatOSPUf
	4clqat+bc+5Sr6htM1gEBQaS9369qM8wmP9dHbKj2uvKPPDfEDPupjfLJ4UIb5A0uCwORVZkTqH
	8Yz/5mwfrjk8rNp6imXnPMM5QE6/SIS+umz6jwL1C+auB9Vz+bImEUr9Xwy+oa6LGLskjbTzQxC
	F+ajDxfr0G12NQ48F98LdcUFit+F58lPV09JnOCr3sA5pJjVptm
X-Received: by 2002:a17:90b:3810:b0:36d:5d1c:c4ad with SMTP id 98e67ed59e1d1-36d5d1cc4famr1262089a91.9.1780115240224;
        Fri, 29 May 2026 21:27:20 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1920:4670:1de3:85c9:62a7:fd40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc0c1ab21sm3794353a91.14.2026.05.29.21.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 21:27:19 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v5] xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
Date: Sat, 30 May 2026 12:26:30 +0800
Message-Id: <20260530042630.80626-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

The TX metadata area resides in the UMEM buffer which is memory-mapped
and concurrently writable by userspace. In xsk_skb_metadata(),
csum_start and csum_offset are read from shared memory for bounds
validation, then read again for skb assignment. A malicious userspace
application can race to overwrite these values between the two reads,
bypassing the bounds check and causing out-of-bounds memory access
during checksum computation in the transmit path.

Fix this by reading csum_start and csum_offset into local variables
once, then using the local copies for both validation and assignment.

Note that other metadata fields (flags, launch_time) and the cached
csum fields may be mutually inconsistent due to concurrent userspace
writes, but this is benign: the only security-critical invariant is
that each field's validated value is the same one used, which local
caching guarantees.

Closes: https://lore.kernel.org/all/20260503200927.73EA1C2BCB4@smtp.kernel.org/
Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
V5
Link: https://lore.kernel.org/all/20260520004244.55663-1-kerneljasonxing@gmail.com/
1. send this patch only and wait for Maciej to come up with a solution
   to adjust the selftests. I believe he will send it out along with the
   rest of patches.
2. add reviewed-by tag.

V4
Link: https://lore.kernel.org/all/20260517063311.28921-1-kerneljasonxing@gmail.com/
1. correct the description of xmit path in patch 3 (sashiko)
2. move set logic into xmit path in patch 3 (Stan)

V3
Link: https://lore.kernel.org/all/20260515123018.80147-1-kerneljasonxing@gmail.com/
1. avoid breaking previous usage of sendto, and siliently handle
overflow case (Stan, sashiko)
2. add one particular exception process in patch 4 (sashiko)
3. adjust the selftest to make sure it passes in either virutal or
physical machines, which includes add usleep to support physical machine.

V2
Link: https://lore.kernel.org/all/20260510012310.88570-1-kerneljasonxing@gmail.com/
1. adjust selftests (Jakub)
2. add READ_ONCE in patch 1 (Stan)
---
 net/xdp/xsk.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 5e5786cd9af5..f8c8a8c9dfba 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -802,6 +802,7 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 			    u32 hr)
 {
 	struct xsk_tx_metadata *meta = NULL;
+	u16 csum_start, csum_offset;
 
 	if (unlikely(pool->tx_metadata_len == 0))
 		return -EINVAL;
@@ -811,13 +812,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 		return -EINVAL;
 
 	if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
-		if (unlikely(meta->request.csum_start +
-			     meta->request.csum_offset +
+		csum_start = READ_ONCE(meta->request.csum_start);
+		csum_offset = READ_ONCE(meta->request.csum_offset);
+
+		if (unlikely(csum_start + csum_offset +
 			     sizeof(__sum16) > desc->len))
 			return -EINVAL;
 
-		skb->csum_start = hr + meta->request.csum_start;
-		skb->csum_offset = meta->request.csum_offset;
+		skb->csum_start = hr + csum_start;
+		skb->csum_offset = csum_offset;
 		skb->ip_summed = CHECKSUM_PARTIAL;
 
 		if (unlikely(pool->tx_sw_csum)) {
-- 
2.43.7

