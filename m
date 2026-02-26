Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E5038BF73
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 07:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772089211; cv=none; b=drWEN6Txg6dZ14BQ0katCX/5kjMZ3bd9izKMtW/5thUJE8r8sxZDFbEFyandQtt3uynCsFKx3EiSRZj7TVzGFWXbPa0zLCdBZw+hvhBhF5j4+WbL0ET712oWbwrQ6JAoA1dXenNGFajYrKqvhJ7tue7y7J4DbWdMKJN/47k1og0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772089211; c=relaxed/simple;
	bh=HaOp5S2Up4ZXb42DQ0x6g1k4kLj2jSKwCVm0W4NrSEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kpzhiWknoHuF11sHSnRTx1wy35otOCCS0JZG0h8/RWuxOHXm+ceX+XfuqIPcew7DpoG48SfQ2g9JnXt2RkCf5YM6l3I2qoz0Lo+togMOjXlTOGXGKKdg/I95Of74zodKLDfNNQi9cxDHEObC4xzgNUkpHPeDhGexI9LptsEkaPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrYXfhas; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrYXfhas"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a962230847so4741965ad.3
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 23:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772089209; x=1772694009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+96CFpWbj6Qbpn6gUigdKA419a5gSrz/9u/JlhQxNo0=;
        b=RrYXfhasozHrB+4QbtyC+2kHcLBHlc+Loaq8UgSPL121va7g4/HDyuBWJ5S9pxKmIf
         PjAUyAL2QwULMMwu+nLRyGpHiuO64tbf93lXC4pByye8GY/Bl4BgJ1O0byyu9KIuggLk
         xkUnM3cb79iZ3SOFxTSFX1oup0g+SzVlvfTWK2snAwnDpbTkCPb6NlvLcha+63sxuSC/
         15xk7CeqZWcu3Q+j3cn04KeuWRKLD9e+qssFnw+5+9qvulSzf6Isp++yUUeGgkYj0G1t
         dTA46DkLotA5Klx2AbQXRQHen8huEKuI4XM704WwZd1cNuAbwdHeT7fnaLdxFkn1wUmY
         ezLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772089209; x=1772694009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+96CFpWbj6Qbpn6gUigdKA419a5gSrz/9u/JlhQxNo0=;
        b=txpWeZLurRQ5KA1CdWxIBGg4DGbN/zQE+hGnx4Nardyq/HblRPWu+sytTOM53EBGpX
         0LeejuBmyMpWv+e4uimaaYxe/eYklyODk+yYSddGw2YPMPnzt9lxD2e9MN7HoKq/d1W5
         6HTT/OCjjfhYsmNy5J88pZXbp0+ryJlT3vqaKntIzAZowf0KeqTVOnh83oKdvTmM79X0
         biLf+DarNN3+oUuAhfgQNAjEWKqomAqynMWLQs7EgxAWRkL6JVpMSo3zdqmq/WKso4B1
         sa6u/xF2C+sodK4W1dH1a8+Xxay8ab6Zg0mcuFwARXwF5niXLuJ3zqNQS1LAw1fnyaj8
         4Htg==
X-Forwarded-Encrypted: i=1; AJvYcCXlazb1S3sGBaK374H8qOUzCpoNFEhbDI1vOkUsm1OPn2ndJcOaKLDwm9Ixg9IExknBbYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHAIbdrcrkkhd/MSZInRfSZV5YSRLrnusPB1KByG83kcZOzm/H
	Io6j1MIZHBtwrxJy7XM9eQXYx5yg1Wn5arevjXVqnPuXYWddWroUKok6
X-Gm-Gg: ATEYQzwwMozHZhsc+e3am3lISCkOYGi/UQhcnQ8Y4HkVQLQt5VCa3B8WTZqEPkTx4Kt
	oSe36m6al6yi026IMRs5EQDPtNZHC0eyiC6oTTehszeos3InM4CtLXKWwvEimfD2QPqLlQeK2fj
	NdxRwW+hfYHLvkGjGb4DyySYlOz6tSI22JbgNwmNCR5PQwwgaZRaO5aNiqU8gZdNLvmmfuAoSpF
	TgratN8rZyZvIs9NhhmMYqo+/DO+PhYjNtzGmDNyhWowM6O1FbrgWYie3HOXkC9oTun1ZnhbPFv
	/iJBgQA/y5ilJ7UxDBy88XpOvkPXZauj0jmyUHB3uIgRVxtLWSJ5nGR4yAEIXRcAKKcvEUHRwmL
	jsmwxQBYxU6Bw+VC++1BQAYOuzk9QC2w8nHziSusSGbp3wDBado+8uIy8lfIBTnzdd5Iss4zlUQ
	pdxUGS2nUfWnuCKGEmNVeL5+6f5T6QMy+SH9REq7vSK5ATwgoGfbpOsm2EOss=
X-Received: by 2002:a17:902:d4c1:b0:2aa:ecec:a442 with SMTP id d9443c01a7336-2ae034921f6mr12871815ad.40.1772089209454;
        Wed, 25 Feb 2026 23:00:09 -0800 (PST)
Received: from localhost.localdomain ([14.116.239.35])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2adfb5b2296sm14803135ad.5.2026.02.25.23.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:00:09 -0800 (PST)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	vincent.mc.li@gmail.com,
	menglong8.dong@gmail.com
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH 0/3] bpf: fsession support for LoongArch
Date: Thu, 26 Feb 2026 06:59:48 +0000
Message-ID: <20260226065952.4082859-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small set implements fsession support for LoongArch.

Patch 1 introduces a helper named emit_store_stack_imm64().
Patch 2 implements fsession support.
Patch 3 enable fsession selftests on LoongArch.

Hengqi Chen (3):
  LoongArch: BPF: Introduce emit_store_stack_imm64() helper
  LoongArch: BPF: Add fsession support for trampolines
  bpf/selftests: Enable fsession tests for LoongArch

 arch/loongarch/net/bpf_jit.c                  | 100 ++++++++++++++----
 .../selftests/bpf/progs/get_func_args_test.c  |   3 +-
 .../selftests/bpf/progs/get_func_ip_test.c    |   3 +-
 3 files changed, 83 insertions(+), 23 deletions(-)

--
2.43.5
