Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909222EBDD0
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851367; cv=none; b=YaWLgbEna+qlpO9QXWb1QGyhPYz/QAHFo8mH0MbSJ3ruM30YPyzdMU9+FAP19jjumlU1TGoNQb8R2XmU0c8lBg525tgpyrfqBiflbXkSWKh2E1BD7mi+Wuc0t7PieQDifhzKqwss/NG+66sz17thff1pcTDvS6d78XM+zk2LbpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851367; c=relaxed/simple;
	bh=80ZQAStVbojxCRFQFhxunxTUaGvTgjPz60GUonfVHh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y9pBdTfdGFDMBWIfBZRbGBQ2911Vu9hkp2No2uyNHnsp73SpTYmVkBcfcTUPPOFDaWmON85NWXfz8JfgbtaGhLJITRTISqJhY71On7THEW4Lt1XPwFMUualD9sknOJAlTCvwyMJV6UuYmFpepjWyFo7AkoAPHXr83RioWWUzX9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGQgb72R; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGQgb72R"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso69997a91.3
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 09:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773851362; x=1774456162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Gtl+TrBTxXTKZJobnZxuGXdKTvi1eDtvZCMWVOn4Zo=;
        b=LGQgb72R0X5z2i/lQfxKWFKA1kxOBZlVpGcwsXrP2m12e1UAVtkUjuewEYBLrv5qyA
         kyc09MGThbnnnBIP1xvTKWTVK8sw14Q6XXgopmqKttDZVrG65ZuT+94gnAET8iYAodLU
         RLk2uNFCtrI42HI1AQwXfidVp4fBGjiWTQYwERMhWu06t5yryeJKd+yIST5t04ly40E4
         XlkaYmkUqw8dC0dWLOqWMK71/vtF8PbhePofpxmikWEcHqbXX7URT6VVXgtYk9a+yrWl
         VLe36bGI9LnR/E6umiX+wXtMcmiV0iqFcbnnYDUdsf2k7WvBPmQssTaLOQp0nYqtYLqk
         b+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773851362; x=1774456162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Gtl+TrBTxXTKZJobnZxuGXdKTvi1eDtvZCMWVOn4Zo=;
        b=W6gh1jLR62aERZBjX41w93CGxTYBrmNqMP/VJhWWGLO1oYx9DCU9QrcSQfuUP/dHuJ
         jLcJfIE/iDNhvVnB2bfXu/yy3H8GUwrR3vud2qy7hkCzPNKbfa/EqpvGrGK4yMVJPSGg
         88xAy9j8iwNyaw3Dqec/ylFw76P5kvIGzUIB1FOEpKIDwzWSjcbPkI/6WrNNKk3rTLvo
         VZDjn/RAMGdxgRjBH5SdyD3nht7TSVQHrc6ibp0tgYpVGz7842j/7XdLRvYC24nSo88m
         Nyi+N3wagySG7F5LZHGq9179dW4HHqHylMHnyVqwpW6t4Te++/oCJVmtHTz6a6k8kS1Q
         5IYg==
X-Gm-Message-State: AOJu0YwaX70NE/VlchpDXn0PAdy7GaK133mVYXVsxvYs/zdZe9YuMNhK
	qEbU0euEfnLF+jR6heFb1i0RxdIVYy2wZ+gyZkL+f5Zkyb7yARkts74gm9G2Sw==
X-Gm-Gg: ATEYQzykhTmWj8YFaHWPGO/AAfKrgHxxHqBtIM85Ha5B+fdDa9hv6HML5xgZyVSY8ZZ
	19Cd+NyfJuuGJ65smk07299k0iQmExUJ3OvYcOLvjb/HV8LkXQroYmh2xQZeKMSIgrYkCu6Z3Ov
	TNBreHi7fzBWZrNczu6xGbYiBJAXzO0qEevfW1FlDItanaV+4kUt8bdlDraA+VwAxuXgWsOcJ9k
	d1ZPjp8EZH5oBNmwLF+EyN8t/6biW/KetD/e877AgbsOCQpSfPWPDGRJqHXE1UuUJe8hFCfo5Xc
	iRY6fcJjmJdg2Wv0Xypo9UotwWA2CBLOES4SnSWPe/tyelXY34dcFqkxpuv+ftZEBDUjleZIweB
	oY2+tYwenac0Alv/Fz8qvVdPyYfxo7FEsq/7LmMRzYvEU9Kad0I2AOput27ZKYp3xv62AqojWPG
	O+Ly/0cO7uIc6uEkwhYY4vhKePcIDn4JtLKI6TMcdNIlRiGlGl
X-Received: by 2002:a17:90b:2244:b0:356:2fc5:30f5 with SMTP id 98e67ed59e1d1-35bb9e7d2acmr3350909a91.13.1773851362374;
        Wed, 18 Mar 2026 09:29:22 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc610c1efsm89370a91.14.2026.03.18.09.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 09:29:21 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	shung-hsi.yu@suse.com,
	paul.chaignon@gmail.com,
	harishankar.vishwanathan@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH RFC bpf-next 0/4] bpf: implement __reg_deduce_bounds() using wrapped intervals
Date: Wed, 18 Mar 2026 09:28:57 -0700
Message-ID: <20260318-cnum-sync-bounds-v1-0-1f2e455ea711@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260318-cnum-sync-bounds-8b6732710fd7
Content-Transfer-Encoding: 8bit

Use wrapped intervals representation [1] to express range-based
deductions. Such representation allows to express these deductions in
a more mathematically rigorous way:
- {32,64}-bit signed -> unsigned, unsigned -> signed deduction infers
  improved bounds from an intersection of signed and unsigned arcs.
- 32-bit -> 64-bit and 32-bit -> 64 bit deduction infer improved
  bounds from projections of 32-bit arcs onto 64-bit space and
  vice-versa.

Reformulating 32-bit -> 64-bit deduction in such terms allowed to find
two cases currently not handled by deduce_bounds_64_from_32().
See patch #3 for details.

This RFC argues that wrapped interval based implementation for
__reg_deduce_bounds() is easier to understand and maintain.
An alternative to this RFC would be to update
deduce_bounds_64_from_32() in a same way patch #3 modifies
reg_bounds.c selftest, in order to handle newly identified cases.

[1] https://jorgenavas.github.io/papers/ACM-TOPLAS-wrapped.pdf

---
Eduard Zingerman (4):
      bpf: representation and basic operations on circular numbers
      bpf: cnum for 32->32, 64->64, 64->32 deductions in reg_bounds_sync
      bpf: cnum 32->64 deductions in reg_bounds_sync
      selftests/bpf: new cases handled by 32->64 range refinements

 include/linux/cnum.h                               |  60 ++++
 kernel/bpf/Makefile                                |   2 +-
 kernel/bpf/cnum.c                                  | 115 +++++++
 kernel/bpf/cnum_defs.h                             | 176 ++++++++++
 kernel/bpf/verifier.c                              | 373 ++++-----------------
 .../testing/selftests/bpf/prog_tests/reg_bounds.c  |  82 +++--
 .../testing/selftests/bpf/progs/verifier_bounds.c  |  80 +++++
 7 files changed, 556 insertions(+), 332 deletions(-)
---
base-commit: 77378dabb50f593c756d393d8eacb0b91b758863
change-id: 20260318-cnum-sync-bounds-8b6732710fd7
