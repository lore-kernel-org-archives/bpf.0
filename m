Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D06029D26E
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 22:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778537823; cv=none; b=Kkthb1Pfj+hvnrr4pI1653bcpobaEr0LGKiMWVj/U0mI0QhqjpD/Vyjb9zKFM1SxhEEjATRnShtw+5j8CiJ/DLPFFLwJT/ascki6KNRIMqOz1a9PFdk1z0WJ9OqY0apN3tMc//jpaD+jvbDz61QTcYGNMDPBvbmV86eN5XFu0Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778537823; c=relaxed/simple;
	bh=/OlPOqQ78v3AZHljtHewrojxMtfDrFtFPaoK3TdAVf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=di70lZf9BrqjWrwJIG6DdSszMK8HzVpIaaQMJuHQknMN7F/QxpK7rDjEhNwiutJYQApwUVZ2H8xZzLtSGcgQx+L0+N6355nb4gQtq5XcYLfKLvhWoj4z1SFkdKEzKF0H3G5G/lT+dalv0j3SjqYZuuPz5m+nL0GWAk0XzgcpzoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zv3Mx3Ih; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zv3Mx3Ih"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-836ed29d1e5so2067420b3a.2
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 15:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778537822; x=1779142622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h4KQfTAAZ5oqTEXttxPs+3ZZUZfSXw+XpaZVnMOUj/I=;
        b=Zv3Mx3IheQ//b9o3ezhy9b6eR8jaT5jNSMbTvLCkvNLN24ELoaHDw5layY2gLHy2DJ
         Jy4/FTGft2rtdtu6OXPPQd51sN/y31oX52toaC4a5xTQ5Xtm31dEOPxcy9BoXuB4XocQ
         38Aa/xp1cKGzpcmNnRJgmGihEb+/gtJyKYS/cTrV+7rVi/rdSWvfMZWzXJco0GKLPHRB
         XRmT9ifqnXVQKwjwqTj5DlQiPI+1oazabUq4LPDYnmCjqtNZ2cgEup5Tbs2XLhx4mhke
         eW9qHWCK6ZDGMQzaWZh0RXlvlECO9FuhmnOgR744/F2s4viZ2i8x9DAP5jFLIOhJ9KDp
         nmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778537822; x=1779142622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4KQfTAAZ5oqTEXttxPs+3ZZUZfSXw+XpaZVnMOUj/I=;
        b=Ab5Sx6OxRc/9YbZV5pm78lOgSukHGo0caYBeK8ZX8po0hgVNUvjdCkmqHKm8XESHRY
         luPG9DsusfftwxKmXBk2i7OvvUk3X6ECCBLO6BZqlFyL6LxMikGfGcAVE2rW2cHFK7js
         rxoZxeeiDxu1Ot8FwjIR1dj6TblGNX5oYJ6kLE8NAYqvthO76tfwmGrIS/k1iHeOY6a7
         idjPcNo6MbNtXMDCXUmLsH4OxUwOyAya5QxjjzbvTqRVbtZVBCgFHS5WzyiHtmq6HWE5
         wx1TVGApE19fhU+EZEN6XhokHpA7ZXLBfMbtIskP/lr27XWvNYFdaixwSYn5r1k4Syi8
         s6zA==
X-Forwarded-Encrypted: i=1; AFNElJ+uBqRbqTKtIpbTUIW4eHp09v4WDas+zItEbYQfMleO8HlChJGtniD+hJjc61aj765CQ1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhGjITrhKLInAutJ/tkXp5wfUSNr7PamFN4av20xiQgYMRuUvz
	eF3DreLV5WfrXa9lPYGvNX/r9r3Mk0EtpPy7N0rc3qdQdysn5fcbQZj0
X-Gm-Gg: Acq92OHFj+kpw0sRCB7Z5ITmHsOgAcL9WgkzzMelwUQM5Mhl2Ref+tqkQ6Ia2qtVs/E
	RlbPtcxINdEs1O/6mntuWIFxO10OioSnSSbGtf8igMA2r1ST8LMw9S/Q5MNj7yLVFzNWDbyoir/
	3t+E5+tlnMScPnolcGZP0zxm+FR/0lVJVIz6QOnPvWNdhNEFirhxZXQ4l/h/O0IONt4NmFZlRnP
	DJ53cAEmqg8Nwl2m5MrLi84bh4MRuTrr21QsUogszlAkp9+yBiK3lexYBhc8Dw6h/2blcyyJwv2
	Hc1VkiPwF/apitFuy9VJB5IAwO7g+YsNGA8Ue9jeNzxBWPIZKX/q5ZTGzSBDYznSiRx+SzjBRnF
	TRiMF5A68BWfm0v0bkyqX5PPHpHeh7dgwC2GvuRP60I0mX5Q4QYiGdKpGThRzzhPqPvbDv9Avot
	gU8sM17tjnbfKUaNYBLBq+o4P/XnuKtTwKduYMaiMbhcHZpA0rEz0dVVxueSDG8nR2VVxaVMjMs
	L8kCSYjzLP3Ixs6LWc6JohHlBudy4bBkg==
X-Received: by 2002:a05:6a00:b82:b0:82c:e60c:f36d with SMTP id d2e1a72fcca58-83eebfb399fmr276070b3a.48.1778537821952;
        Mon, 11 May 2026 15:17:01 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (32.237.80.34.bc.googleusercontent.com. [34.80.237.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965a3e3ecsm21943329b3a.19.2026.05.11.15.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 15:17:01 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	luke.r.nels@gmail.com,
	xi.wang@gmail.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	alex@ghiti.fr,
	jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	marscheng@google.com,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH bpf-next v2 0/3] riscv, bpf: Fix signed operations and add 32 bit atomics
Date: Mon, 11 May 2026 22:16:45 +0000
Message-ID: <20260511221648.3251464-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix miscompiled signed operations and expands 32 bit atomic support in
the RV32 BPF JIT.

The current implementation ignores the instruction offset field used by
the bpf instruction set to specify BPF_SDIV/BPF_SMOD and BPF_MOVSX.
This causes these operations to be treated as unsigned or
zero-extended, leading to test_bpf failures. Fix this by checking the
offset and emitting the correct instructions.

Additionally, we leverage the mandatory A extension to natively support
32 bit bpf atomics (and, or, xor, xchg) by mapping them directly to
amo*.w instructions. BPF_CMPXCHG continues to fall back to the
interpreter.

As a result, test_bpf.ko now runs with 0 failures, and the total number
of successfully JIT'ed test cases increases from 843 to 902.
---
- Add missing Fixes tags.
- Fix memory ordering by emitting aq=1, rl=1

Kuan-Wei Chiu (3):
  riscv, bpf: Fix support for BPF_SDIV and BPF_SMOD in RV32 JIT
  riscv, bpf: Fix support for BPF_MOVSX in RV32 JIT
  riscv, bpf: Add 32 bit atomic operations to RV32 JIT

 arch/riscv/net/bpf_jit_comp32.c | 101 +++++++++++++++++++++++++++-----
 1 file changed, 85 insertions(+), 16 deletions(-)

-- 
2.54.0.563.g4f69b47b94-goog

