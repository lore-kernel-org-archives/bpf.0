Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2BD35966
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 00:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779237783; cv=none; b=W1XPy+X0Jpxc6ub8i5AovsN3nPe70h7s20JaLIqWuAiQ5ldW4HQwsAzFI1eANWaJDwHfTh+pMvGVv9Wgvt+N1xp+SNjsXfgXtOtPzVd6GbJ4aAzbuYX+MtyW+KwWmfXxR6nEf5vviDttMXs90sWMs9GFFwTu8o8d8M3BIT6ENbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779237783; c=relaxed/simple;
	bh=WMicqqE67ul0vJopAceY8vMx2lsESDQwi2nHwp0/MwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GDJEZlOsRbc16zh7IaYv+YarshFTR5KZl6MABcm2Z8dmvOfCahgrYjOP84cCRMurzPaUaUzEflR3XO/vijYxGTRoP6oHgFZPgFVQSJ22/lv3OWRVedeHpPFSj9R9QwqCiORAeel7c9zMOwuryizTzZpJ/N6K7hfyn5m0QRUEnt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaVwUlk3; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaVwUlk3"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-365d8e43759so2317346a91.0
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 17:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779237782; x=1779842582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A6KfxgyTszx0aKCDT6/DObZfaaYFv6TITrxlgwGLf1A=;
        b=GaVwUlk3x8DjGwvyt4MjzW0mIxh9tAOuZz/PFJGB3gqMIv8vu/8/O1GWxPWJFSNfmc
         HOJu0ebrubxAIbDE/xz73w7gArO2hMQDPPmI12a4BF+4uPf1wEBkHHdTzHEaOmBxCL3y
         8oHvWSZvnrrMiaN0QmsxMF37k/7rBBJN4IaBCRX0C06k330xAWNAEsRtWYm8I3aVUa3C
         z1QpKtL481bUfan85Hc7sPrHTdRsSB6PrkAsp0M2j13Wv7bWqEq6PDBvt3YlDo6/0boW
         ZYbv9bIAS8nHjufhJhbjmFVvGt9I1Sc/+gvzPXKZ5Yrnrsqp2rWwAVN+ZJar5TejGoP6
         tcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779237782; x=1779842582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6KfxgyTszx0aKCDT6/DObZfaaYFv6TITrxlgwGLf1A=;
        b=Vzzgq5ACNa5eKjdcjtz6Et5kiexiVq8NtZYbpZseNecVYTHhWDddtWC7gcozmTgLkp
         4GNkAt4p1TI7+baKp0N9eDQiys2E+CKDn7tiMG2vnWbvTe0wRzrB6HFSqpABdMp+4pRM
         BJUJhyfz7mdE9ay+l/F96uQOBA1GqbjkW4ev9/5u8j8i9kX4UgMPdvHrTRI+T0v8QBaf
         U7GUix3BbqQ0tnFFJonSxte1ESq+NCC+fWySGbbH97vxsAieO4hasGoNIN1RhSTPG8nJ
         KQKu3dZgZpcc/uYESo71vtvMOvSrKlRbgADkHifxwTW0wDGPMWlxPAaicJk5YnHYrMgv
         Mw0A==
X-Gm-Message-State: AOJu0Yz34WYRr3mZE/IkRfWmwxzfkpqFZGr1eE9tWfnknLYL1iGtBjoa
	DobO4Ym0fJfx+KDB8ZnPY2TsXt6TlR6JNvUdcVSjjCdnfxmae0XGTyc/
X-Gm-Gg: Acq92OGnu09YMcKbYvZlZwDx4j4EoOxoAnOTnMUhBiKeTzmbjY5DM5RqteG1bQf3lgP
	AbGx/Zue88A6QFA1xV6L1AWNjEMTyHy882gAK5RsB4MaFT0Jm5EVQ3ozOftuWH2COaCQ3pVbAxP
	+LDnS6ldKfu/OKQ1rE99wFjAIoPd4FILwkSFmvHzT2bytWWmajvyBpOoah0YTZECnd/EZPsskSe
	YK0EbSODxjKrWR0f2OAneilqRCjDyl9GodswfqAxrOF/lyrq0jzTXe7JeF4alEYDRHUUaSgO+tK
	MnlEzRCzrIS8Ny8/xJa6+UHQ+FLpFWEhMc4ifnJwKBe+uihNx945cUT8FE1UssabCGdDArXdvlc
	kVyoNTEXa210G34/2B7kJq+fOv2DErx9AQ6qGcQzBpWE23uCYwZ6coaibCLXfjo62p0c9vrtFvE
	Kg2wa5kJWNdDGPYeCeIXy6JdGwbvLgktWyFDxgf5CI7dwcr4dlY7hRC/T38rKelz53RhuqC/EqL
	yV3xieEdaE4wDMhBoYARFpWOb6aZ5Jpufc4g4RICQ==
X-Received: by 2002:a17:90b:38c9:b0:369:9469:aeba with SMTP id 98e67ed59e1d1-3699469b41cmr10628387a91.1.1779237781689;
        Tue, 19 May 2026 17:43:01 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:f1df:d520:8103:19c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951059f4dsm14746277a91.0.2026.05.19.17.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 17:43:00 -0700 (PDT)
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
Subject: [PATCH net v4 0/5] xsk: fix meta and publish of cq issues
Date: Wed, 20 May 2026 08:42:39 +0800
Message-Id: <20260520004244.55663-1-kerneljasonxing@gmail.com>
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


Jason Xing (5):
  xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
  xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
  xsk: drain continuation descs after overflow in xsk_build_skb()
  xsk: drain continuation descs on invalid descriptor in
    __xsk_generic_xmit()
  selftests/xsk: drain CQ to wait for TX completion

 include/net/xdp_sock.h                        |  1 +
 net/xdp/xsk.c                                 | 44 +++++++++++++----
 .../selftests/bpf/prog_tests/test_xsk.c       | 48 +++++++++++--------
 3 files changed, 63 insertions(+), 30 deletions(-)

-- 
2.43.7

