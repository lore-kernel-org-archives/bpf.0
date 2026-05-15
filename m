Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C223379C33
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848236; cv=none; b=VBskq0fs7ex8t/2rCRnoElzUlctbL1XDsZGAEFJht7GiyJX7uqzKydtPLydQBGoTmqX7K9T6jAmnKw4pjt+oBTJdydlZbsSBFPiWVT2wP48ZEZfvaz4K7Pyp3furPS+H9Mb4lcjViVBvQZzVbyTuOcYXscO7KnaBDPmsHfZatiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848236; c=relaxed/simple;
	bh=3wRVXuclZWvyljwdr0/MSGcvXxEyp1AnqKVoCQXr9Vk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VyOh6qmiPq9t6XLXnw//F9i96BNS3aID3j+o9e3wu+3O2Vbil64d4lkjDzfFhhGJr7pygt7ALpEAlxEg0WoSE7/XwwwkGn/R31v6O867gJw/csLvYiKBz66m1KLZC0E933QtVW1OI4f84Ygdt/JoayRJ3loluH0DDsT7EEZoeE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdJB+61B; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdJB+61B"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b45cb89f7eso58345775ad.0
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 05:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778848234; x=1779453034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X8qDEDsbaFNXQ9XrhS0ZZeE5kY7v1dYSpQA3+agn7yM=;
        b=FdJB+61BR3K2Vmle/GEGk9VpQ1UA1Z0u5RpBqlQrdI+idNLY+sJ4tHaAeZNjFTTs/c
         jcq73VI20ICbvl6e+Z+UAfpiX8Wo/INWaSc+5aSDmyFZhpH918hs/0YFioIKeGSJnTuc
         BVQ+ejcnM2+BaLE8egFq1a+re4iM6gh/Olc6rvNtAKkJvKsi7N2yPajpFb/r3n5lIsYC
         bcYuZOVbpq3C4NQARMifs+3omi7YeUimrji7tZA8zVrCRdZ9sH7gvRiUhGLRrF/bCLLq
         GhO/qtTeE8zLs5v6k7BBAffhtLX4cYznBp3bFZWVnq5QgjWc7CyzfJa9lzJ9dtTWHEkN
         8cIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778848234; x=1779453034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8qDEDsbaFNXQ9XrhS0ZZeE5kY7v1dYSpQA3+agn7yM=;
        b=i9FDbbF5YDltrorxE0AqjYkncIeFUV12EO6cnl64ZnQ3oCKoMhL4gsDOyHQ663gsi5
         JOhV4LdouLFzL65x4/XSJCfgW7nCNtDH/3Sw+GZbjM7aPTro9xe1QpNGYkHdbDZ3Irly
         akZRpQj4qqJUdj9enx5cMqCjjdnHupKQljsZj0tsFLhQ8MZN+pbvEc7sQOei6I6llmrv
         el1DOYJHMA7FJm63Fwe8UnGepyXK5kask8C9IPdU5veKxs95KpKhzurxidFt0Aa+a+Z8
         yo1jAxw+HbcaO7vGGeiggUCfeSww/q2v4xAlWY426LL4txJ7n/X2aH9KbKRe2qwcod0R
         HHUQ==
X-Gm-Message-State: AOJu0YyvCW+FQXg87pQBehgll2FGR+pUqZysfNqNqbIsWQoccOhdU0qI
	KTIqaicgl1T1Dw6TQGmirtp/PODGeeNbQXcWIb2CguYyQkqxc0KpxQfe
X-Gm-Gg: Acq92OHxMlYoe5U+DBKUsV3eSZ/sZrUx83fzT0upzX7X+dJGj2QHp+OI5FoFMabX/0w
	PUN2+HyO0OTr8rnbAmGc06WI8stOXBGgfz1ywh57ciIJ2pkJ9M/V8y1mbX9JHW0DPQpJbxsdYqj
	BKBQZvvbqesWREgoEk1AHejKc50+gd4o1d1Vvq8I/UOY6kaoa2EShj/1+yyvZUZyE0HXiRyt3W5
	MWMh6ReYPmH9CJi5nHKVk/G07/rQHiPDH2blTmRAEtdHL7K4w8b1XjzC0SdBgimdItY82SgFXfd
	600KNxEc4BT1s/TPdbpMlh3gSsXLkUzm1JRlWJELXJAh5Mp8g7AGf2NM0958ArVuTFiGzDzKDDG
	Vo3zJyOrrO6OM8+kffPwkLtqmJjjcTVgZuWL0aVb4ajcZnVaJ/eWad1wKgl6HL8gsT17uEbht7K
	NhAiMvo6vsJO6v5f/YcioX4LZqrdvkxllLLGnF2x9h6/Ca8lPpVfMVVTbeO0W2ly/dkbQ2TY4TS
	eAuLEpy9Z4wJbvu0/h0E9hakS3DEqdAnh5kEIMYR9OO15C2b12a
X-Received: by 2002:a17:903:2a87:b0:2ba:4eee:6c1e with SMTP id d9443c01a7336-2bd7e8214d5mr41764845ad.15.1778848234272;
        Fri, 15 May 2026 05:30:34 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:a48a:1116:aa2d:1122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe492asm60348885ad.48.2026.05.15.05.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:30:33 -0700 (PDT)
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
Subject: [PATCH net v2 0/5] xsk: fix meta and publish of cq issues
Date: Fri, 15 May 2026 20:30:13 +0800
Message-Id: <20260515123018.80147-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

The series is the product of previous review from sashiko[1].

1) META
patch 1: address TOCTOU around metadata.

2) PUBLISH of CQ
patch 2: make sure xsk_addr->addrs[] can be published to cq when
         overflow occurs.
patch 3: keep cleaning up the continuation descs (more than 17) and
         publish its address when overflow occurs.
patch 4: like patch 3, but only handles the invalid descs cases.

[1]: https://lore.kernel.org/all/20260502200722.53960-1-kerneljasonxing@gmail.com/

---
V2
Link: https://lore.kernel.org/all/20260510012310.88570-1-kerneljasonxing@gmail.com/
1. adjust selftests (Jakub)
2. add READ_ONCE in patch 1 (Stan)


Jason Xing (5):
  xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
  xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
  xsk: drain continuation descs after overflow in xsk_build_skb()
  xsk: drain continuation descs on invalid descriptor in
    __xsk_generic_xmit()
  selftests/xsk: fix multi-buffer invalid desc tests for drain_cont

 include/net/xdp_sock.h                        |  1 +
 net/xdp/xsk.c                                 | 48 +++++++++++++++----
 .../selftests/bpf/prog_tests/test_xsk.c       | 45 +++++++++--------
 3 files changed, 64 insertions(+), 30 deletions(-)

-- 
2.41.3

