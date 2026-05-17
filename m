Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256AD2D8DA8
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 06:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999606; cv=none; b=YX89658ErSyfNOlKNpbXYnvhrMlk8lIA5AElc69eTXlbSljAA55joTIbXgyLLctfBUkKbmr1pB9lAvumYskzX2zYN3VLg8oWT2OcXJxGUH/5Y/UhdktgdHgX1Ht9E0jEWs8AgGacZk43gn1BGC+hU8tpi40mSRoCT3weyXSoqf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999606; c=relaxed/simple;
	bh=Iembz5WZriJohL290gtclVjvHwhKD+3xwyU6eomHFpk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o7Y34cpqKFeqz0p/ustmTbn1c4oqSTPQeBJfbcsPS9MbljpyQDgjw2Y8T5v5wufPlBp0o8ioWM7zUY4+0NRpishVwbtsA+zi0i0J3CalXLJUjJ0QRpuBUkfP4lLtgZj8z9bBycOaPTy4JJ/6XbZL6DtBLTEorzng0hrWmxKCRKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPygyvdB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPygyvdB"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bab2548e8bso4990145ad.0
        for <bpf@vger.kernel.org>; Sat, 16 May 2026 23:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778999604; x=1779604404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vfn1wnsws3qKZ05OCo0NYpyEDF6wFwNBCzjnVjoFnoc=;
        b=jPygyvdB9RhtK8NFZ60B83kyCs0F1KmQ1VsPwROEQlVOfPO7zkzOjEcP4o9Hj+geU/
         ft7WSdmcPqqjcR96JgnVT3qUB3mnRAjNXP53ScG4DtsC8f5ptXXT2Un2VHAjcityO4e1
         FGFvSF7Gr43BXKnsH6Rv4oge8JXajq7RB3JFH2BrW7tRAgb5dZ6XjwKBM7pscLOhWDus
         UNnHdnsIn4j6JX0T6eDEMn8uR6Vf4cP8rr8Wj3CrIGBhytSK0MrPysQ7PvWmehS680uJ
         3TcYDpwaZHKGF4ZkJkKVQK4lk8QfTEmOegZQpdYBVjR0ZwBZiPwkZu7m/M6pFKYoTPsN
         uz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999604; x=1779604404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vfn1wnsws3qKZ05OCo0NYpyEDF6wFwNBCzjnVjoFnoc=;
        b=nwGw44w2t58usYkMZ4nQAczvHUdDZZivbUvJajvZoFGEFXf5TfESwEBBzpW11enNpF
         64Dlu4LvyFm2JwDSBqJXHdQTPkvePtcpZk/kGVdgUG//q1OsNwFYjgMN3IYgQYcMHfXy
         HUtEoS+rwmPUEgKiG67NDhKAIaoiIClVfHQOU0Uf40jZVsu9eX0Pv3gsBcBAFt650Km9
         qs634Opipq/JwIYmh8nG+dXTuu6N4NyrPEfN92EGrER98K7ge0ODX/j1CEnvZk0Jisdc
         vW5YV1+UeocyORZhmxZxBO2ss3vOzb1VEiB17o1ivcJ3t4Z79P96ARGxtMbEpfS6fKzZ
         +maw==
X-Gm-Message-State: AOJu0Yyc1gtNI4pZ3CWPj8nGanpGh+gXqHLFHdRqTHByiPSuH8KlPRHe
	d7y8Xkim4985QXajFeokC+PoM21QqohRsgTAtyTwM34YWQAw8Aaezxi3
X-Gm-Gg: Acq92OG865hehjf0M35zW/Id28hqn0pN90UA7ltVVwKsuFu72V0DyOm9h1i2SjwZlyB
	QPUNgjJNdEc9v4D6cw1KzcLYzDpQbm8DPyHr2gnAdnqjTc3rX3qg/6v4hZwyu14Pqxi1m2yORbO
	haFP/fFJTZ3s8qt3XredG2KhC8KzXyKulK1SzlB2Ty4s6Cqbw43QVrmyRmbCe829MTybfdDTuo8
	NhYb17MecIO/rXS9Lg6+UfNnjNBjPKltcCUecbGTEeDTtOSG4z7/rcG3HN8PZuRSGjJTuehgrRz
	U9XPYDXgtDMiY4eaaClpoO55e2LTMEYIb4BvK8tNIgYvC5nQBsTsfZfAJH7cP1JrpHRbKGhpbtr
	QfjbKNC/SwIsLBD/hZdlyc+7QOisaX4Ejb4Q21U8GRzAnqk1ewczML9Lf/9nE0vOpFTEfV6Do18
	KlDQfoIjr+Fuqq0TyhhfvXL/Doy2/mIEyFFUXie9H1sk+lmKKDC9ctDcShiUYZvEBEVff+K3wlE
	6IC3Wc+oy5uRFXJezH+MW0nnLuNQgE=
X-Received: by 2002:a17:903:24d:b0:2bd:9803:9308 with SMTP id d9443c01a7336-2bd98039479mr77245475ad.36.1778999604411;
        Sat, 16 May 2026 23:33:24 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:78ef:13e7:10c0:51d5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f2cesm111625115ad.14.2026.05.16.23.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:33:23 -0700 (PDT)
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
Subject: [PATCH net v3 0/5] xsk: fix meta and publish of cq issues
Date: Sun, 17 May 2026 14:33:06 +0800
Message-Id: <20260517063311.28921-1-kerneljasonxing@gmail.com>
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

