Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D8D946A
	for <bpf@vger.kernel.org>; Sun,  8 Feb 2026 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770568449; cv=none; b=Ir2Bdi27ucMqB6rLvQIK0MhpOnPLzCkIrwpY9j8DWFVmJFiat4OmXv/3ySAX+2xgMdDAXtKxkEqD89JFBrbkqNqymsu2fayViMw3kUoVoMX0rQSN2dy/wchVDHbBITHZQkVZ5lrn8dH/z2z4trpfUC/Pjj7xboeTFldq/y+puCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770568449; c=relaxed/simple;
	bh=rWSmBPhY67ndXXUKVyka92Jp9xR6EdrbgCjknoLWpeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R6rVB5G8axA78DFsAUS1FuF/19LH/VnXB8+l7eOPLIlLDozo2WWHfK0YOJ6PEWwVCvaE8StpC/5gi0nYJCsKQoqRmHO0vgTmULeD1cauv+koLAx6sft4qiVJfV0sfklaFryxKWycI/JvpA64cQwEt9bNFyJ4+4JtMkT0SW3Xu2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SF0aSuWg; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SF0aSuWg"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8230d228372so2148184b3a.1
        for <bpf@vger.kernel.org>; Sun, 08 Feb 2026 08:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770568448; x=1771173248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jtzfvSH5V+SsEWeWY4cnX6kfAN31H1bY53MdRv216Nk=;
        b=SF0aSuWgQeAayP6rZMpMCoZPa2ovhiGFDldrJU2CCXLfG/1Wa/efQZaGyY+XVPauOs
         0lgu8eXCRIcpzSpnks6hmUjM4UXx/ge0c5YHDZZVPPN9pi+g9iOr/E30qOZoFjOyioZ5
         HYmsFcNANYmjUnki1iD/unjKhfJquHLYT+IEiN60mTHGyi274tNa5hJelFdN/wa29lhG
         ZMbRnqkYNz5SRVy++0aParKt3wc2LABJPMPpHQayoJLJfSkNjavBNw2Tll8LBfpiDWQt
         3mVWqN+Gf4ajdE7C5SjLvyeuYV65G3atZFQgt0Xik0wcQpuxypT4TGFroXARQATU1Dcz
         8WDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770568448; x=1771173248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtzfvSH5V+SsEWeWY4cnX6kfAN31H1bY53MdRv216Nk=;
        b=m+aYUO/tGJrHG2+d+RhlDlCTvtJuT060J87tDGqUkYfWfRL9/6pVnzFOhG6tX3vDvw
         AY8ghQYMqnkGsGu5ig7JVC4NRJULGk2a99j27KVtpjL9uS5/WYtgdCHve67ZQY0p11hy
         jTuPcX5dVaUTXaJ6tX5bAHCoHnK7MF2iiI+ELD4HiY2YH2UQ72hns/52nQ460E+9X4rc
         3QSff5ylAsPs1ZEgELlZQ3KPm9IsbKIVmHwZ5SXBYV8A5yQw+type346cn9UKY6UyjOV
         f+aZNI0oq2b0qNlU0kbAVNgIkZbTyhJZzh9iBWaVnRSExPfriLgCoMa36HqliOQZjOoB
         dLNQ==
X-Gm-Message-State: AOJu0YxVfwmDZSTNDKR6U6/ajNUuFwAcBoGRNr0pLuTxUqo++HatJpMx
	C/2Q6VwsZhYhNwjoY7JESmd2LCQZ/wnAaUiU5Q1aOucY8fSNtlIYKWq3VecT2A==
X-Gm-Gg: AZuq6aLydReL/941CXZypJ58XhFkz+I553k41raxQZayOOikurMTKZqXn4scjrsocWm
	5S60kGyzdrz7NxXKN7H4PdNGu1OnSK6HE56d2lvXIw7eYLYM1dhzdR/2dMFSDS9grvD37P4QMfk
	Jg1Hi7UM2YV3jafr9CTDsrbpqyJP30qjxTVTqSMDVWPGTigUxc7I9AEF6hGF1KSksGoVZjHRGcV
	bK6TqfThYYAJ4TJRUSghmNpAf6P+/CohXkXQuQr/KjwD/bG0h2R2qNqPVF2VbzfNzahWAvu/rH3
	0azKeJ9pb5wpGVST+9PSz2tKJDijUIP/Ie5yR539pyR5NhvQt0jPDh/0jsD1k9X4iK9+4Ss9Di6
	7uukF6ohsvHUyfxeYvAtMK2entQFvVHpS4Ctkjlpc/G7n8tt9AoLKKdCpzbfonH/+kcygXcWm6Z
	ttAWFpjxiBsObIYYO53oub2jBrLf0nRJJYNseQJdW0Uj7wodwSTczGBwvOrTSjW7DoE99XAQBYd
	KoEwWl2RwL0FEoEW5g2o1uJS7ew7Ap5m3CccdtBWSN9mRsQaQ==
X-Received: by 2002:a05:6a00:3a12:b0:81f:46ba:1817 with SMTP id d2e1a72fcca58-824417b3438mr7207948b3a.66.1770568448468;
        Sun, 08 Feb 2026 08:34:08 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418e4690sm7633769b3a.65.2026.02.08.08.34.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Feb 2026 08:34:08 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	puranjay@kernel.org
Subject: [PATCH bpf-next 0/2] bpf: jne/jeq fork experiment
Date: Sun,  8 Feb 2026 08:34:03 -0800
Message-ID: <20260208163406.14974-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Mostly for fun I vibe coded the experiment.
It's 100% claude. Both verifier and selftest.
It took ~2 hours combined. At moments it was crunching
for 20 min without asking anything.
It passes selftests, except few that I didn't bother to ask it to fix.
See veristat results are in patch 1.
It's mostly regressions.
Leaving it here in case more interesting ideas can be built from it.

Alexei Starovoitov (2):
  bpf: jne/jeq fork
  selftests/bpf: jne/jeq fork test

 kernel/bpf/verifier.c                         | 107 +++++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_jeq_jne_fork.c         | 204 ++++++++++++++++++
 3 files changed, 313 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_jeq_jne_fork.c

-- 
2.47.3

