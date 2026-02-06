Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB6732FA3C
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770379122; cv=none; b=Hl1vifs40uvwsCGLNpVSzlXec8fKye3oCwlaap/PD6mFlLYTkaePvpqR1qqJf0ES7qiTzV9nd6b5Ake7x5Yjw5qnloe0t3Ce1w+RS+YA4yEIPLdAtAv4S7XRDJxXVLhDn+a2lOBcUj5sax1s8AlAGO13OI7u9jxCFiWr0cDrjLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770379122; c=relaxed/simple;
	bh=i3gEZwOC5w7/K7o9p92wgBf1kb9PSKuPb33y6/Vx8cA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XkpCe1+FfxwRg3DKgWXkr1fFxWwaeeUogNgZVCyltT+mYONQYGAZUMFJ0nRQqDUKFdRRGoEknPCwW3dE2ppe6t0PgQb7bjUmPCZjHaeDgIzj8noLsskNyukt2B1RMyPL+Wf3YlPugUERbajR5trcEoNdYGCnEDfZ77Zs7VMdbx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTegR1d6; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTegR1d6"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a95de4b5cbso359995ad.1
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 03:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770379121; x=1770983921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BwiHVlaKsntpUJzB9dI5SHd2dWcYWLOEu8oB1qgtOsM=;
        b=CTegR1d6CM34XpFolfhRF4iBbvBzl7zoxxo27nlKZFjMutNSX9CgwyF/qugBGUTVj9
         LRuyk9/k+Pepn26xs3mstdwaf6ouxMp1vWO9soGLdrsF90QwCNBnU3wNnYQw1pgJhSqT
         tmwIsNdCcHeUPOkcKLHn/51PBoMlTglJ7sCJmIXPLGVkGtRxySJ81DpUeC8/h8oIK6O6
         B8vgLVJy6cL7quRhAzEpLXB6vRuqsuR024EsCyjdbbn+CuJuzCHZ/f9Y08AxQEpL41SZ
         Dfx8+7qtu581Xx6gg884mW0Q7a878QC746ep0h+7wXH9fthA48g76SzxqyvVfcyBibuV
         rFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770379121; x=1770983921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwiHVlaKsntpUJzB9dI5SHd2dWcYWLOEu8oB1qgtOsM=;
        b=HZVuHZH1Xw0/dea6ephrnW/6V9NgXimNKHGBFCa+Jj/NxVqvtwBn7cy1ARuVB3LGa3
         KjvDwPjn8Au1fhY2cxKyos7PXjdk7rYJHLDB10Qdzd7nWY0lLEbT0A578fXYChzTYLWa
         6UhWzG1s4KtPm7Qd3EwigfneqVOmI3y8324DnxTsU8NIsLyPg4jK/kJzGFeqIi88wJHZ
         pXui42DPnVdqxFi+NdZSYUQfm/jeoWbTv9NZEy/PidEsoG1mrAceyEpJaxHUNe/D0l1i
         TA9YCHPpcF9OFVHQ2EhamptX4Nnd33qNDE0W4IfyrUauZpM77phnBrENghnhUwt360pA
         zG6g==
X-Forwarded-Encrypted: i=1; AJvYcCVNzZGxRGW3omUwMXT63b/iP0VA4GSYwC/jUHVccqBIrhfEQYnaVkD4hbAgQh6xlB7V8so=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0CqDOwOHQFGe45+E6IFvVrRfzH7zcl7TPNg9aBOXbf0QK30bo
	aXlvf8jCOv1pHwJmpUg11NwJilszgh+9lf2yiRlTSS5F8d3GhR2YnETl
X-Gm-Gg: AZuq6aICuHfBWh9u4X35G3VlPPilPvFXoBg5ysCfCi5JW7zV5uXayZuPUua4+YKX35i
	ku6pvlB4UbpIx0dHFrVOVW/EFMBwHa62X80UAWVCm+Ahn2etAOcoi0op+ZrHbnf0OTT873ZLVRW
	PS6L5vbmpY+g8NXgXJdc97uc1EeEzMS61OznfZdBkfUa5mwur62DSeGgo+j+Mg0HnWQ0BwWn7Q+
	Mc0e2DjP2pV2yXsjNGTCZ0q5niy7u0Qu69i38bAfRSDyYHGWJ7vbJCyFATzLRzdjLWTtZ82CSS1
	x74c5QDmJJPwDyNrEm8eAufWuamEpFwXQr4mTVWVPYMYt4giWCEJbUuZs8+On5u/szjYwyAaVTj
	LCQpNRnRq0nlYY2Jqn4K5hGWUHBBsQ9E3VA9ia1+K6NOhcI/SmIIfBGp98fVOb7UFmwzswrqO3U
	rdlVIpE19/
X-Received: by 2002:a17:902:d504:b0:2a0:b4f6:5595 with SMTP id d9443c01a7336-2a95192514bmr23739265ad.50.1770379121168;
        Fri, 06 Feb 2026 03:58:41 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c8ac5asm22856395ad.35.2026.02.06.03.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 03:58:40 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	bjorn@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jiang.biao@linux.dev
Subject: [PATCH bpf-next v2 0/3] bpf: fsession support for riscv
Date: Fri,  6 Feb 2026 19:58:20 +0800
Message-ID: <20260206115823.1070354-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement bpf fsession for the riscv architecture.

Changes v2 -> v1:
* use bpf_prog_calls_session_cookie() in invoke_bpf() in the 2nd patch.
* https://lore.kernel.org/bpf/20260203055231.1088479-1-dongml2@chinatelecom.cn/

Menglong Dong (3):
  bpf, riscv: introduce emit_store_stack_imm64() for trampoline
  bpf, riscv: add fsession support for trampolines
  selftests/bpf: enable fsession_test on riscv64

 arch/riscv/net/bpf_jit_comp64.c               | 97 +++++++++++++++----
 .../selftests/bpf/progs/get_func_args_test.c  |  2 +-
 .../selftests/bpf/progs/get_func_ip_test.c    |  2 +-
 3 files changed, 79 insertions(+), 22 deletions(-)

-- 
2.53.0

