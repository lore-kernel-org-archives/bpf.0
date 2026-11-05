Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793858636;
	b=QwIP5XAHjjrVHYfWB/XibB4LQffnS1Mq1Sv9FtClf1JSOqsZX4JN00GTtiGAgV1Qulw0
	 txMK+YFWClUjbkhmista2IaeQLv1rTGY7cAdXjfFGlRQOsxXUgHkveJFiHnvANzv92d8j
	 GLDd/MY8I+CTB95eg0/qRgGC3J5T6sz6Zxik/zCz2zSOHStJDTU6BAyeZEJLB6dSSkYIx
	 CKCYhmFNxQ4DJ/9k5a6ENCDy46SSKAr2TIa5oZy8mYR8NAHPGek4aPESiiyYswHcTOMvS
	 k864ViiHTk2FdhI8XSi/TKf6SYz45vYOaGr4aQimIbjFcXRnyeq1Tv1qgBJDqX7IQFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793858636;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=fl+RqVSy++c8t4D9ZLDA6qx49eqFU8GFdwgJMfJOyN4=;
	b=oseEYKGCdECMfyH4IMkmFDBwMMkV5R2cdSBVcVV7O8xEMkUpu1U05dbqaq5OegkGA4nT
	 xnfeF9+uxQHeq1QKjKqQTIDUE0JNdfKzhdQSqvsaTlWrmMjaBJXmlvsHBljXEErNWUXw8
	 J9iS17dF4L5zqhouszt8bfhZoH6s1+YJodIJLSTrW6ABKazm7uGZnJ4YCnkm3x1iUdsPN
	 /c/00MigiFGJ0Z4HjG7dCujYDQe8cWXPAHn7Ri/F+Sp0Jh7wCmv01RrG440gwY/dfKCJV
	 DAurlDJpxitiGHWf9ZbE004YM5Mi4Njivc0z8omXgWkvOuCsd0AYdoi2/QXSEUmHgqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sITsORkr;
	arc=none smtp.remote-ip=74.125.231.200
Received: from mail-oi2-f8.google.com (mail-oi2-f8.google.com [74.125.231.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9753D606A326
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 06:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9753D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sITsORkr
Received: by mail-oi2-f8.google.com with SMTP id 5614622812f47-51cddc2451aso725026b6e.0
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 22:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793858634; x=1794463434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fl+RqVSy++c8t4D9ZLDA6qx49eqFU8GFdwgJMfJOyN4=;
        b=sITsORkr/kUi1tLLm2LhV4O4MeBBZD5P42Mn7DMsbqXc1l0My7lI4VmgtVtnfCNRPm
         F2K5ABd1e0VHSJ8v2yESdYDjTq4i63tkKEsmDkfU94JGf8/kaTIlpLIWCue9vT5bF1Nu
         nuFchHwAR7Ftsz3TEZCXr+WCGl9OD/waFlfO7CL1Jilo/txk7zlc2begOhUWVb0h/j/R
         TGbTC/6DEKgD1gf7luCdWPsrmDKhVsiH4PA2kU5S6CZ068gtUu1ny0pcnBfzdI1R8zjJ
         BNwajppvpcVWWXsA70Yz5DddZP4BTQKmTeGOmnqBOD5ep97jZ1ZC4JL9FAWfb5NB8wJq
         qSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793858634; x=1794463434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fl+RqVSy++c8t4D9ZLDA6qx49eqFU8GFdwgJMfJOyN4=;
        b=ee/YS69seG6sBUYWZSeyYSyRCHJ9YPdyhaak9v1bYZ0f8ovunXZS3alyIhghEXO9ga
         16FF0rYJvFb4q14IajF80FJvA8U90z5FrsQ4fY+AutS6iX19FTWKmswwHSQ5g35fXzsv
         PTkevLsBwt5kcHyZYkD6XCcvbBeHsSKTkPrQ+gUboBhyhaKfDbzfiU5oNKQCj+hiMXvr
         X2oEL78ayKAIQU4BssYMP0szl6rM0HuvPQbHOXKA9JalCHzKJypj2jHNNopv3aIvsfTY
         Js7rqzvRjZAwVy9n12jBFwMNLnKUH4Wql0pmfMmotYZBoM901fZqxfzB825544M1B49q
         pe/w==
X-Gm-Message-State: APuU4Z81Ou/VFc9zszJ5fad3Kj5pZfV/FwIIM90dSdFnCDBQsX3QT2y0
	cUjduwQsYwBDPDjxrzOmObCUVLb3X9899Ay6Xuha1xNpArjQ2MrliU62
X-Gm-Gg: AYBFou31ejjXLSsf92yLyzcQPMyV5IdR++SMB/epbBT6pWYkEksweD4nmg8HDrAtSpl
	4WnGMtiy7/SzgOMZx4gsWbxcnlhSRn4ExO3J+Qwjf0mde6XPUo7g0mLCoDcUN79BpUB3mJusB4Y
	7vVppub8jT348nKos0MmE0i3Nb0IoW9jHTObqtqm0koClrYa4HPmgDeQuMWWls/l499UMUyTrcs
	DQlc1KbV33d/dyjGGOf8b42g01Xqb+onaYerAsBh6ziEQ/9+AMeLew7UXuzEJrWkQ+3APDlxrRm
	diDhbBwBC8uv7lVjWDAjQFEjMa9GzU0G5M/2O//LIRC31PEYMZV0Gz4f6dKA/i6yTCnvXl/sH9a
	+Kq/fSxNrn+RfPopbFhl8a4eGCdg7kmcsK7wpgxhl6R2N0nA57ITc9XL0+sR7ACyj38hV+fOlwr
	glrQsvqqi3jEcyMXi+p8L/Z2Tq3YAz86LDSf/9wtIDVLqK64UsoMo0u1Js5ecLzQCZl4XPUQiQq
	zZkQiQC9JShgMwUNxHNLxoDvrgVLthmYlBvWv89kxs3UDt1IkUlv+SdLLR7X0LOUsP/UukdDpXp
	qJ3hhuFHANWbBMYp9iQpje3o976SX6spI4sRcG1HEJBosSsYkQ45qFVBKBPvr7oEygw=
X-Received: by 2002:a05:6808:14d2:b0:532:963f:3118 with SMTP id 5614622812f47-5640d97353cmr12997705b6e.3.1793858634408;
        Wed, 04 Nov 2026 22:03:54 -0800 (PST)
Received: from localhost.localdomain ([14.22.11.161])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9f41424sm3493476b6e.9.2026.11.04.22.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 22:03:53 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH] bpf: fix verifier model mismatch on __sk_buff.remote_port narrow read
Date: Thu,  5 Nov 2026 14:03:31 +0800
Message-ID: <20261105060331.1912252-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

On little endian, the ctx access conversion for __sk_buff.remote_port
loads the 16-bit skc_dport and shifts it left by 16, producing a
4-byte value of up to 0xffff0000.  It reports its width through
bpf_target_off() as 2, the member size.

A 2-byte read is a narrower load of this 4-byte ctx field, but the
fixup pass only masks the result when the access size is smaller
than the reported width, so the masking is skipped.  The verifier
models the register as [0, 0xffff] while the runtime value is
[0, 0xffff0000].  Arithmetic the verifier folds to a constant can
therefore take any 16-bit port value at runtime, enabling
out-of-bounds reads and writes relative to map values.

Report the real produced width (4) so the fixup pass applies the
usual RSH/AND masking to narrow reads.  Full 4-byte reads are
unaffected.

This issue was discovered by Tencent CodeBuddy Security.

Reported-by: zeroday zhao <zerodayzhao@tencent.com>
Fixes: 8a31db5615667 ("bpf: add access to sock fields and pkt data from sk_skb programs")
Cc: stable@vger.kernel.org
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/core/filter.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 9245009d9f1eb..6eb4751441f39 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -10455,13 +10455,19 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 	case offsetof(struct __sk_buff, remote_port):
 		BUILD_BUG_ON(sizeof_field(struct sock_common, skc_dport) != 2);
 
+		/*
+		 * The converted value is 4 bytes wide, not 2: on little
+		 * endian the 16-bit port is shifted into the high half.
+		 * Don't use bpf_target_off() here, it would report the
+		 * member size and the narrow-load masking in the fixup
+		 * pass would be skipped.
+		 */
+		*target_size = 4;
 		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct sk_buff, sk),
 				      si->dst_reg, si->src_reg,
 				      offsetof(struct sk_buff, sk));
 		*insn++ = BPF_LDX_MEM(BPF_H, si->dst_reg, si->dst_reg,
-				      bpf_target_off(struct sock_common,
-						     skc_dport,
-						     2, target_size));
+				      offsetof(struct sock_common, skc_dport));
 #ifndef __BIG_ENDIAN_BITFIELD
 		*insn++ = BPF_ALU32_IMM(BPF_LSH, si->dst_reg, 16);
 #endif
-- 
2.43.7

