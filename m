Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272792D8DA8
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 06:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999611; cv=none; b=S0fdLV0s50GElKIV9N9Go4nNvpDOFjZxF8idkl0AjM8HOTNm3w5IMif/5QmvKdetTzqjeuMjGbusXQrk3x+Ig8Zj4BodMPmhIG8TfOaEieD6hX0LdYL+LSnVOLqNDipjPIviRDVIE2xypdHNudUlr/k0amzxJJXJcNBzg/DbWLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999611; c=relaxed/simple;
	bh=b69IeRzK/gkXviBHF52sHbmYpsdUOWt7Bk6X3kz8qps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GazmKX0qsUPqN33NxyAeAApLmfdo9Vpfgmm4zDVr9LPV9vT/V7oLYzimLsd5SaC+q/D7RhtRwl2UyjcDfJu1Ptk5Y5MuHPEl+vIVXliVDoEuhVc8xf4p4bS5NhgiZRG7x2LdB8gwEuFxJ+pXL3VM0P172rGVCCL6WFzBFHHU6vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Byd35I3l; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Byd35I3l"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bd2c147abaso7105025ad.3
        for <bpf@vger.kernel.org>; Sat, 16 May 2026 23:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778999609; x=1779604409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEWjwKmS1o82G8iZfnk1MYvRFND8ZVdz4Bvvebda+3Q=;
        b=Byd35I3lRztc2bPhhnyk2hInOEKVRj7eHrRdglfAiS03p/cRc6ldOqbMOyPJQBSQ39
         KyADa4hFMW5PDi4ZdOr0t1egN8/TUSx60c+2g+0xx8Cy3cPICMaNsUZ3my5+MzjRbQNY
         TYbVEkyK4hTvcqfHoPrpMlNT8KkhDjCWd1kpiwWYtrvdzkooY+b2+8xDHiE+u/4/ijxa
         Jqz29Xqt/y4g0RSuEs3Iic1mehVYubjzK3xpJL2nERcHcPEwkT0O2d0Ak7e1e2cJsHzt
         plyrw0gOANkWX9B21edMsZgCM/38DVD/riRDHscuIwIoqe8Cnz6UTkGYWB0F3GzvqDrv
         m66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999609; x=1779604409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pEWjwKmS1o82G8iZfnk1MYvRFND8ZVdz4Bvvebda+3Q=;
        b=VNIAbTXNpiN6LFDbFMceXg6A0ExzvSMDGI0lCadB3SP3d0ApxAOopy/8Hb6t47gFmt
         qVoAL0m9jb47kf3scZf+BOhatI5o28xwLIWI58mMt8/yWnj83Rr8HUvs5XHlbii73lsl
         yRt0kO97QMT6rx+oQBQPttnWAQkh80MERON+jRCD+hYaeeBQkbelOq6H2vd5APwX8zHZ
         tuaoB+vAdE2xo3sTWmJZGCspfub8FYiQGyOjIi2e24Wb36BdHDhwCnSxI9/PLPRctMkE
         5Sl3Rr6dXjo1FRR73UktS6tLW98LnmJYZF0n5w+ALvy8zp7v75d9tVcuxJubBUqazdbP
         bsVA==
X-Gm-Message-State: AOJu0Yz+q1tFhjYrUU95xmjYZyOS2bSCQxIgVCLNYw4/ZVMYq9xEw93r
	nP5Kmp5w9LxBRStuIg2J56S5mDFnfNQUG52mpejjXX87CbioJbPCdCXA
X-Gm-Gg: Acq92OEIZ6uEJTrFuH+/25uiCwQli9aYHxrINTsBTnzMLdAczXVsHcaakOafkDZrqq8
	ABNdR+1ZFkhozVuNIP0zlL6AtGdzfJdka+SM0XIk7AkqhKD1bFyyu1ib9UoOEJSYYO0GSUnAH+A
	iPhiXNJKHaF0WMJxzbo+Cgy+u5DWf5fbIL/FJlJIg0c8F28As6fUs9BPN3o45t5z4EdeMRZXshn
	ntwRO0cTmlVSGNxLbaLwbZ1SH/zjkmIjcE1B3Do6SdeB+MOeZeo/lgzO0/uoKXX3PEkMryTT5YO
	Y0e4wdEcJ3YJvwOwalxsvpGfUYI8YS4E43aR0M5hvaWrgxtAJ7+uVrOmo/hj5CzyYBAtQke+Vex
	cpVZ4YDRD+Omm3YYzRJjYnvOHmQ1GShW1UGKZKQtinRRGXWtOEUzHJUZ7arU2Eu0EBXRKXgO0nt
	Y8WNpxs8hHVq529fkVwO/qC5B/d9depu3c2KrJSaBXR5eK0OEbmmy3RtFFXGk4yW+oFi73LQgXR
	3gHkRTkau+2R4RtkAc6sgGiBc1O8d8=
X-Received: by 2002:a17:903:2410:b0:2ad:9b86:ddc2 with SMTP id d9443c01a7336-2bd7e88f047mr116704295ad.22.1778999609456;
        Sat, 16 May 2026 23:33:29 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:78ef:13e7:10c0:51d5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f2cesm111625115ad.14.2026.05.16.23.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:33:28 -0700 (PDT)
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
Subject: [PATCH net v3 1/5] xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
Date: Sun, 17 May 2026 14:33:07 +0800
Message-Id: <20260517063311.28921-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260517063311.28921-1-kerneljasonxing@gmail.com>
References: <20260517063311.28921-1-kerneljasonxing@gmail.com>
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
Signed-off-by: Jason Xing <kernelxing@tencent.com>
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

