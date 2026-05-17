Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF39405C5D
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 08:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779005130; cv=none; b=KQ0GJyQ4JwrI8yWHk9qbO1HYDoWfNR5D7kZhuU5LA5bK8c0IDoR2TEP8RYYkGWc70uu+B45Hgmq+umtBIf59HceOz8LQEIehHgaJz+aCzZ5r4O02INGKU8//xVWhyiHJ5hz+X+QSZsnwDBEakhUMjhZtPtDjvMrtm1EDaxylHvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779005130; c=relaxed/simple;
	bh=Bbdsm7ZAI7eLrjX/tU0SZr76VlU5bVdQycLEEfu0Q54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eO+UYbqSNLbQRDRHaB7fDk4uiWEF8F0bvAAsEd4Q7anz+Wmg5UsQRZiURgNu9d4kt+gPNOQ1hIx3YGxy5P6q53n24Pmh6G1lDGjlGd+HCGq9OBuo77RJ4Ucd6kSDdydneG3ZhQv/NJ/88J1NwPl4GyxQ7Mg679/21W277J0/+HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJBNXS9i; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJBNXS9i"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67be871ed3fso3358185a12.1
        for <bpf@vger.kernel.org>; Sun, 17 May 2026 01:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779005127; x=1779609927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bbdsm7ZAI7eLrjX/tU0SZr76VlU5bVdQycLEEfu0Q54=;
        b=TJBNXS9iwCGijVhdG8JPXTwXouRqa6BTNiE62SRNuykuA9jbvp56rvV0ohe8rkorGA
         5CmAp+saAan0BtnzdG9yp/c2Dc1tCe2APXgntSzweNKQIsV6peddUhssEPSVaWXB9o1R
         UxXW21Ys/DnuCW6hYWWg4ufF8cPXMexMhxeANp/aaMpYlC/+GZMAIT6wltaqxvi/IXAS
         1gY+oh8ucxfyvTZJ8XKR4Rl3s3JWXocS7k+RoCpajlkOBXGV4ijDp8aEFdXvDjwEawpp
         ATU1YjudQs5jrceLNTYtksCYMhuGn7xIf/AXzH0aGcNQD63n+3KDiyKaetDaJM4PYr8F
         UnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779005127; x=1779609927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bbdsm7ZAI7eLrjX/tU0SZr76VlU5bVdQycLEEfu0Q54=;
        b=l9d5grjNZYc1Ox1n2F5Gf2RyEtHaILrZDT/GlBssGRxlUt8hdvva7b4PAsh//NAPEv
         oAwV+wEsP3ROxPcZdjLOP+eA2s5tI9N8T5oz5cEfbAfCTZj5u87/Wfz/cRd2gsQCJbAT
         LT81R5/Ek2eO9Yb2C9rwf4p0thO/rDTsHpJGvnEJxXwZeICoG7Z3+zCt8NDVj5fmnMY2
         kmgP0jE9YRxl0/P19kWi/MXxun/4vsU7Wn5ewGxZ1QPpPj/CI2gFyHxSlbysJ/guQj2D
         cL6Ktbc6yz1yUgytsUs2ailjl7R8KHBsJ+rNwDlDdErVp0gGqs9/dVW96nXH3o1Cvn1d
         0Wvg==
X-Gm-Message-State: AOJu0Yx43h2XmBpCOPuRO0E8qxN0Ho0V3WPusU5goR/hVgg4ZOyBVFsm
	FZz7E5N4K7NWbVkXo8ZT5uDzRGJ4vwWK3wGDIyGCVGYQ/p8yDiX9wAuNa8LgZ7Ab
X-Gm-Gg: Acq92OHjievKw2NvIZacysqe5Cbt+T5nwX3U9o7NOiKFAIDIJ1FMmomiFs9+EjmFvMm
	5OPOkf2jhXuHHW5NymBhyUTZhOWTrnvXSgQ9xElMQNCDGHXxgkZkP3CQhD8RWHGr4KS6ziWQc1F
	IylFUGv0nnuPflTCoPdgBGesLNS3ziWWViYgSzkDvekaVrZlhoiWBCVZ7s/CSCM5XiySoPYP/oG
	Vh52yozBwvzTACn1+15aaFcBv9SCtTHn/1VDR30XWlT0tCD0tFBoeEblifFNyqmRTjmujnkPgxA
	c3v5IRzIdAA+zljkpwZeYjJSa9dnuREC/zuCmfkQ8fM5dZ+rQBpS26dhz6gnvYe8uTs+uOFJLRd
	gakBb3/Xf0aWgesVF9/buA8u2Wz/KnIgUHzUOEEy/6fcTaSEr8DgnDmbCJXyfETfDFwE5WHmPlm
	VSsspTPi41c+lckvmlw5PbXADk5MeH0A==
X-Received: by 2002:a05:6402:11d1:b0:67e:53a4:5807 with SMTP id 4fb4d7f45d1cf-683bd08ff27mr4857345a12.18.1779005126599;
        Sun, 17 May 2026 01:05:26 -0700 (PDT)
Received: from nixbug.lan ([146.120.47.171])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68310d4ff67sm3999015a12.10.2026.05.17.01.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 01:05:25 -0700 (PDT)
From: Andrii Kuchmenko <capyenglishlite@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	linux-kernel@vger.kernel.org,
	Andrii Kuchmenko <capyenglishlite@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20bpf=3A=20arena=3A=20fix=20TOCTOU=20race=20in=20arena=5Fvm=5Ffault=28=29=20=E2=80=94=20WITHDRAW?=
Date: Sun, 17 May 2026 11:04:51 +0300
Message-ID: <20260517080454.10409-1-capyenglishlite@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Withdrawing this patch. The same race window is already addressed by
commit "bpf: arena: make arena kfuncs any context safe" by Puranjay
Mohan (2026-05-09) which adds raw_res_spin_lock_irqsave() covering
the vmalloc_to_page() + range_tree_clear() window.

Sorry for the noise.

Regards,
Andrii Kuchmenko
