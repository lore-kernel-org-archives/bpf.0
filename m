Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E74D194A6C
	for <bpf@vger.kernel.org>; Sun, 10 May 2026 01:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778376212; cv=none; b=CQvOwc/LxSlNWvLcvYzGGNBFYXwkMB4f3uDnl8xfU5gzYMMtkAWa3C8oBjiE8EhVhasQL6XXwD59r/v06ccY0IqMwZMt/ofmGZlhPsQWRVRiWecc1oWbkRfFIZWJJKjGddLflxopU7sn0oIoxyYhhM3vNBWwu3k3YjGwJzIa6C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778376212; c=relaxed/simple;
	bh=z9QwWWIDiLxB2T0rvDMh+jEdiTP7o1Ato9sgX5hf3Vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aIza3ak4uhnToB7qkxTXKjhawHMyRDk0TrfEMYGpmNy0VfXHgjCEhyuwgpQQwZsiNT1ppsVIDHeHzo4C53c1RJTKhL/YTysWjug9IxnEFvK0AOyN1u8GpJIe8JsI4epQxH+97Opsohes3U2MI776xMWE1N9SSytZ30L0FtL7PGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8UOGroE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8UOGroE"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ba4efedbeaso23015405ad.1
        for <bpf@vger.kernel.org>; Sat, 09 May 2026 18:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778376210; x=1778981010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLOba0oX+kZuNGN/4ZG77UAy2VIRDoJalOqo5SU9QxI=;
        b=S8UOGroEl/l4iU9CzKibinAZFAbodfiBQuPbCekcB1IfeMg+csx7OamMxhPDf9KkTs
         SPkbGcRPde9/kkW7I2h5rKVL0Wcepj+4J6DJJjWZnN68apoe2qqTDilOsC9U/tH3sp3T
         DOgX/3zF8RyKeLl2H14+9HKHp73dGrVM3ScFWvJJb9IPJRXw/e2puZGyMo9Nl7goFqER
         1cFlmyI3vh4fB6cRYiJmhNCn2KIic9KxzQPWAcjQtKBd4FLlr9TBCOQKnQXDHLsjfeRm
         pAc61IzC5HXBte1P5UidlDukYPXJaW3jGkH/E7/1k3DzK1s/kaADOPXG2tHB2qvV/9uH
         gqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778376210; x=1778981010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SLOba0oX+kZuNGN/4ZG77UAy2VIRDoJalOqo5SU9QxI=;
        b=m0Lq4mtDXyOvL+SrlOnOBSsv3IHaE6xIzvwUgAVNvv9PsuZbEvRqRiwC49N9RFdbG8
         n4cO6CcT+nK2rwwe9oK7fjy0d8Z5p5Zu2gcF/HBZa1geh4t2JSetW++hB/H8oiW+VGMi
         vc31seWDLFiXQipmJw3qZJZtNeWAyM8d3NzaciNaH6WwqmTrTKfuebnMbivf1Y9Vl2xD
         sqk401R7YOSnOI6mG13JZ6eMKF9YTSgn/FuX9qtlzL/G5RiHVgzQM3uK9Z+iBPebxY90
         kEQPhijjQCYJjzlXyrVAvuWGBHwWD8hTSo4Q314TnQtlEEvB4meLh7sV6+8coTfmtwSG
         asrg==
X-Gm-Message-State: AOJu0Yx93+9+neJn4ys8zfIpqasIGP3gYbB3oXjFx2sDqCMy/b0hhsbf
	1vt+N+yHTDQMGN/5xFxFvnTN8EntKgNt+eKWoB0JaBZYoiNY6l50DZ0z
X-Gm-Gg: Acq92OHsazFcxEvsS+KnNohTAEFEi7doSfje4WQxm29dclSRUsyxztn7gQ9HIUUG+aA
	fNiTCcsvYY8y87Jelub06vOcwxZBSJDI0CWQSLh6QfwfDFwvSM1SOOyeoJd92llnESrZJRJIpXa
	AMHWgYhFpkNlDY3o7OehWLEHDwhiGRXib1cZL7AQnU2I5K+1qFp7KiZk/Ax6P9F8TQDjw1vGJdb
	b7otWaSbjCInswH4a4SMNAmmaFIja5KQcQxnKUGtZL6IvVFba+QFjfoYrJlkfuUYc7VTI5OX/rx
	76qozj7KXKqsT1mDQ4HJxzUz/ue+an41vuGdc8bPy8L2BV5kMv3CWJVhVIuIhsjVT4blOGQBwxk
	T6srFNw3rck/QzHC5nA5ulCQqe4s4GQTlBa57gFH37VcHrqOs+qjC2nEPZ6utLgp0h/1i2wK1Tn
	3JvvRqI7hkxCd8LQmXqK+fIeDDUCRY7bsYHspfCn16aLgX9E13KbDeY8UFM7YyMHyXpI78VoEUZ
	9+VzPwHObb80NwhpMemlD4kKKm3LcQ=
X-Received: by 2002:a17:902:bd87:b0:2b0:ac1e:9720 with SMTP id d9443c01a7336-2ba79c22193mr138820185ad.23.1778376210427;
        Sat, 09 May 2026 18:23:30 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:1949:c5e0:289c:ab19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d269fcsm64648875ad.15.2026.05.09.18.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 18:23:29 -0700 (PDT)
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
Subject: [PATCH net 1/4] xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
Date: Sun, 10 May 2026 09:23:07 +0800
Message-Id: <20260510012310.88570-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260510012310.88570-1-kerneljasonxing@gmail.com>
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
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
index 6bcd77068e52..cd039e397018 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -722,6 +722,7 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 			    u32 hr)
 {
 	struct xsk_tx_metadata *meta = NULL;
+	u16 csum_start, csum_offset;
 
 	if (unlikely(pool->tx_metadata_len == 0))
 		return -EINVAL;
@@ -731,13 +732,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 		return -EINVAL;
 
 	if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
-		if (unlikely(meta->request.csum_start +
-			     meta->request.csum_offset +
+		csum_start = meta->request.csum_start;
+		csum_offset = meta->request.csum_offset;
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
2.41.3

