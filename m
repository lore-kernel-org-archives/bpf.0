Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEC9380FCA
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791308001; cv=none; b=ny511znVqhiFmG1gdL3VczF2Z53Kaw14cyDYV6MubvbnCf9bPhKEYw/TFalwNUs/FhsD/BLugCy/QAGzC1wOJYcmomb43w2HA3pxYWJKakdBCOU7/+bmGCYUOix0aGwJg0lmYzVSiRyo85DOAw1dy63es9Ris1Z33RVYCEBUNRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791308001; c=relaxed/simple;
	bh=H1lfUv8lZxLYx5JGsjCazmYH2gGjI45FEj2BuG/W9QE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tXyF76SxkHY1cZMCR72wQbi/v02w9lhkIeCEGaBA4XVk30YuNZRxECmk92V/tnn1lv5xJpgDaw2NI2k/l16cZgFaf13BrZzPphkHf1Dgolz6UlK4mAf6JplOL8FyMJYNehYzj5o4Jx9IXoKxmpqi2WtQ1uLzr1lofH0EhhSoFXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Fz9ZY0OR; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Fz9ZY0OR"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso655293f8f.2
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 10:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1791307997; x=1791912797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vI/CREtYlaKCf7QQt+Wn+NAvceTNfQIZHGOmhJieQwk=;
        b=Fz9ZY0ORb1P2pCcSHH1kIlDpttDSuV0LwH7BU5/2eHKThNrWZNBvkRSOlxgq/SzFtK
         blI+3usjGrdZqS5g1C4lmx5unKWCCZzl3vMmuZwRsBG+OfjqdUooxOddd1bJPorvTdWg
         sI66JcU5SbRa5kMD81krBkCsv2yqKuL1TMEySu0P2xsVaDv6RmaNO/RQ7XUKvTW8t1y7
         2G0oizMJNdkmJNECJuT32S9HvkfTqtyhNb12izvha9AuxtNqh046TBNZNL78DRN9Cd4M
         qU7tC6iaKPQuQ0fCZ0X/eMA2tVtPc7LGIdsBo8CB5tMCNAH9ZexbS2ZIsYV6bPlaIi5x
         YxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791307997; x=1791912797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vI/CREtYlaKCf7QQt+Wn+NAvceTNfQIZHGOmhJieQwk=;
        b=1SKQcpu/g00KtU7RuaUspi3mXC78PSDdUJtksU8ilPK1kawjubmyb334NjzOau99+O
         JK8ScNpN+grUItLqonjK06mG++KG4CpI3hRgK4ILhqI95WQ6IPtTqToP75Dx4rewUSPj
         6wPCFzKpCTtIGDKwjHP4vcoOgbbzk2gEINmmMNO+rPa6rXT24Mgr6IUpDREPUcIwKxWV
         PwrgCSIdOb9XGG3bvP5AYlqp/Wev0SNL+HQEmoK3zXEw0YVfWJOhix8ts2peksPwxSJD
         m9eFAhg2gO/SuqcnuwHOm4cwAzzwjna2hyfhY2GpdfTajDHWccpyX0tIrmR3QjKZyBh9
         Nrww==
X-Forwarded-Encrypted: i=1; AKwUvBwlTbifOq0hLjiAeiOEkLVjAC3owAj5TCPOH269fkTkvazgSrBaux1sTBWM2Mth3CdRs/I=@vger.kernel.org
X-Gm-Message-State: AFq9FYLE4dI5AMPhMaDDaHp9cl8X2JRhDG0ITLKkvQzizByODAFi15pu
	1Dzrq8pHqOCcipVObFzoaLC5GO2yiuhvibSFg6lPBAdjWTOmN//qZmAtHtDfwr5F6sM=
X-Gm-Gg: AYBFou0SY0gPHBJ2ImUeZsj1y6JueWkNjjXeeakMO29sVPpmKp9fggGKaxVKkcaboY+
	7umRAfxALePh3Te6XVZAuc7NJh805xm13dFZzLNdEqsYIhLDkwXyO2EkRLVzMzOcjfDUL2R54R0
	SlZcve6QMCSF9zYdiDmZfd1913oiboGgwVfVGnI5qQxcrhzkhdQesueoSm+CaDykB2N9UmRIAZF
	hXptwYAi7trUttuUSfYSTfOpQ4IqAGZf/aHaiAEIMExhSz3K92n/t+8i5u6LF5nSvkyZ3mE12e4
	bWQbsGCSNqVH5FLlh7EvRId8+Gcr/K/6nDxlMX9ix+wLnnjHEPYzDt9Q9zbEIARtx84DWyfQC26
	C5iisRhErPnArAVNpJUeY90sobtaWsrKqZ30bsOjpDBRMMVamn0YQPUFxuXj97+V6lBC+K5T4kc
	SWSJ28Vbz+2G7WWOTK2Sbqot5ploULrqqSIODsySZA/fhRShTZXwmthTDh7yzNeYYgUFX5MmAUg
	6mGFINY0OYF08k=
X-Received: by 2002:a05:6000:26c6:b0:48b:10c8:2180 with SMTP id ffacd0b85a97d-48c7279001cmr297088f8f.33.1791307997130;
        Tue, 06 Oct 2026 10:33:17 -0700 (PDT)
Received: from D90XRJJJNQ ([2a09:bac6:37af:d2::15:413])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d1272esm714121f8f.27.2026.10.06.10.33.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 10:33:16 -0700 (PDT)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	toke@redhat.com,
	lorenzo@kernel.org,
	horms@kernel.org,
	bpf@vger.kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	kernel-team@cloudflare.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net 0/2] veth: fix peer NETDEV_XDP_ACT_NDO_XMIT after GRO is toggled while down
Date: Tue,  6 Oct 2026 18:32:35 +0100
Message-ID: <20261006173241.65945-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Toggling GRO on a veth device while it is down leaves its peer's
NETDEV_XDP_ACT_NDO_XMIT flag stale once the device comes up. XDP
redirects into the peer are then rejected with -EOPNOTSUPP, or, if GRO
was turned off, accepted and then dropped with -ENXIO. Patch 1 refreshes
the peer's flags in veth_open().

Patch 2 extends veth.sh to check the peer's flag after GRO is toggled
while the device is down, in both directions.

Tianyi Gao (2):
  veth: fix peer NETDEV_XDP_ACT_NDO_XMIT after GRO is toggled while down
  selftests: net: veth: test peer ndo-xmit after GRO toggle while down

 drivers/net/veth.c                  |  1 +
 tools/testing/selftests/net/veth.sh | 46 +++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)


base-commit: d5a007b9b457c915ab1a53227e8939e4018aa97a
-- 
2.55.0

