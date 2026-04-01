Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61D844CF29
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775059618; cv=none; b=rTsANpT9ZosMIfKurbSoRlBInTTnQpXe2J0adf2jI0EBkgKooEE8UznfjiWD5uJWolAkBlWre/csiVZO0YSnFrFkCfTtgEIuKfhoitX1g/qttNsY8jlgqmdj2bZh0lqaaNHnu68dqmxhCMJjuRZaCzYWufUa4IF1tr7v5SvHaS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775059618; c=relaxed/simple;
	bh=6jZW5R46PQvXPDMVRgPGt4tPc4UsINwnTq3i2u0jwu8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rRqc3vmetw6N69V6PcN6FaXN1l4OSEkqwMak7ddNTINRMw+jFDoEf5JBmFLjSi3DMAEVmBn1sWiQWh3OtS0Vltm25JoNYAvFDCBUSaR1P2zSOj9mBSuyLOY8TP37GbtayaPJhYJxhN+2yXgaW95iDLeBaHkVpwIbWVFgAbS9y40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2xXXV1R; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2xXXV1R"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-486fd3a577eso64533165e9.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 09:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775059614; x=1775664414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CQFoeE5j99m/7LGTy70UJdsCiErmt8/ZLtxq4mYlgG0=;
        b=D2xXXV1RNDZzLAOORKsT/ESt20hq3e6H5aSrJF5DnSGL/L5L14Aj+UVC61nBodOC+0
         SOQOHZzlcjXMSnX6sqZnv5t1n7HcV8u/IfQebuoA8Knd0PL8A4pq0pdnwO6MqciF53LE
         TO/XDZRUO2u2P+5eadzt2Zzqb546PnLUmUy4Y/Jq92gqp22LqeaLLRNiWQhCw351/oR/
         pPqyNKBGdbjv1LciELank/txuifwwW2AsMmJUiKFpW4WMWUJDE/GJbS2QaLP2Qc00798
         Is8is7d+T71PvO5JrgajH4n6zeIKb2sCk7Rqc8WBzuiKb871+fg+1SAZK0nEcJG1fWNp
         PJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775059614; x=1775664414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQFoeE5j99m/7LGTy70UJdsCiErmt8/ZLtxq4mYlgG0=;
        b=s7WqRS7ycI3qBJsRV0rcQjRoLBqHmIhgHvpeELEZHUyLHzY6763z0gfO8mzI+NInpw
         +T2m4E0/AoW4A6m+NX+iUGbXZFefTZkSpqaVDfO/nn9zwjNuFG/530F+BZbCZRgvvrxs
         PsIHrIjYNfd1cizxBiRGQBF6O/3Xn0i6KVhJpxUJ/twCme/D5ztfXuwBOjCgHr1tRmn4
         +CgS3pysSe2hspHrmQdDgdl8FkI4zXsiVlU3MoLK9Xi/U1FJxwlhmT0Dwvyzk+Cr7uk+
         RPqLkjXuORlflWGWJAepkR9RBFfwIhukdEIlEWXoFhJYn/IEMGMBFAo4CK7Mzr9hwkSA
         6KoQ==
X-Gm-Message-State: AOJu0YwI8c2i25JDG7hmXKJsCRsFCUFFer/wc6+UZHXLhfbettSjgGmp
	NtmA6wxtM9peGxZ//vBM8yklcUKrIBpwYNzHkHG6Vjg+RSVwVYKLqJQ0Vyl9nA==
X-Gm-Gg: ATEYQzxoQv/7/xrXZ1XgJMQwxD0TxifJ7exV+hYJgngg1v1RgZftSiOzAsmt5TRs8H9
	PA/19o3YC1UyrqQVUiIdRXjzcyh5PKMl8TdLq34DBiuOkQRq1nZBz30OfSgb/3roiSwnbY47THl
	a96VMjB5gbd2UscBMt/BKI/H4xUUmthjRZOCYk8j9K6+PEwcE8l27PMgCiNQ3KAQjW4y2C3mWpH
	WPXV4+CXshwcvR7szho8CnRX38+YcbIRSXQIzG6Rxr9wV/7lrxlSXsynDrZ3I2TgkYZT9HUaDL7
	N80jt51e3m4jzl5s9lxkU9AadodIrS3Jouyfyo6oQoXf930PZTlp4k649NUNSkWa875/Mlkb8Gg
	h87G3+grhyx6Y0PL9sGh02TM8T6cOtgDRlqTCqVu7SdGwjdfrP2JG7amjRK/EKPS0v5qeLSP+iP
	60XYNrLNR9fd9U2x0JdlvC1buh/jgRWCqhU5tjuLTP9Q==
X-Received: by 2002:a05:600c:4e0d:b0:486:fbd1:9dc0 with SMTP id 5b1f17b1804b1-488835b76a0mr72754215e9.22.1775059613737;
        Wed, 01 Apr 2026 09:06:53 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e829c43sm116893495e9.5.2026.04.01.09.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:06:53 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiyong Yang <ksur673@gmail.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next 0/2] Properly load values from insn_arays with non-zero offsets
Date: Wed,  1 Apr 2026 16:15:27 +0000
Message-Id: <20260401161529.681755-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PTR_TO_INSN is always loaded via BPF_LDX_MEM instruction.
However, the verifier doesn't properly verify such loads when the
offset is not zero. Fix this and extend selftests with more scenarios.

Anton Protopopov (2):
  bpf: Do not ignore offsets for loads from insn_arrays
  selftests/bpf: Add more tests for loading insn arrays with offsets

 kernel/bpf/verifier.c                         |  17 +++
 .../selftests/bpf/prog_tests/bpf_gotox.c      | 111 +++++++++++-------
 2 files changed, 87 insertions(+), 41 deletions(-)

-- 
2.34.1

