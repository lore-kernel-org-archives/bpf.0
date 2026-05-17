Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D24872617
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779004535; cv=none; b=D/jalYDrpIzEuCVLYYjG8gJmarEfRwyjVxGKAhjmX2Y288x/fH4bX9vlIbhRyYZRInhE47RAnZGjYU0hG8bMNWEQhTJYvTekI3nPTFZZ6J4Xa5f52TTFIDpvcdGBe25MExcx4eluaRSOtprheV3CZ5DIKp5ICVzWxBJxhlaB684=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779004535; c=relaxed/simple;
	bh=kLuL2SVFgN1iN+lcM/cCC/+N0UlQHc/G7E8u2wDIc2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ilxIfGGpqK/0ZfD5tozg2WVXaRYM6/uaVNkI/ZmDLB+W2BYq630INxYTL/LQ/7BBi0lo+WTJ42RojKsxMhFom5voynUI6mxYVdtbhe/NegHlIcYhIUNdNFTYB4PX+vWvDMIVw86kEoWJ6Gvm798Q2kyeo1BB4SCdJ/pwkabjy1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0MOy297; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0MOy297"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-44e5624c053so568939f8f.2
        for <bpf@vger.kernel.org>; Sun, 17 May 2026 00:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779004532; x=1779609332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u4q4hwlUwDzPTXxmXu0DQI4R60w/Svr6VrM/bapXnTw=;
        b=i0MOy297/EQPQ5v8vDK1PkO68SIP1TTw7/CYViNWyWjgaJUYGFW5Q+Z9W89EmN6tDd
         Uts6Hf5Pr31qImjPsuFvHk4YcatRgKAMx9Hn5TPsXdIOk/Rl80JSaqxi1WLrPb0yEIof
         ELPzNlrrn+0+o8l6HscKSS9B8s36z7NVA7Hj+aUYtqRxpo3sebAu6Im7T3Ok/CZDQ2Re
         1bpLKKTJWt7bykhjyDmLNwQ1fTCaqympk2IndbxiZzuErbfQDCtc0TzCa6onSRkYqQyq
         RZ+S/gZmrOUIB5DmMR0geSZIPsoImdLamBbyXTThvNt+yqpYeajVIhvgYyo2CS8w+d+F
         tO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779004532; x=1779609332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4q4hwlUwDzPTXxmXu0DQI4R60w/Svr6VrM/bapXnTw=;
        b=dtM3JL2FWt6gu5hYiNY4nD80Zj1hTOAeBT7fFyJNkWoqFlL8OckY/NLzw8JYY7jDcc
         fq8nsooHH2ixK18hWWjqsod9FBxRwpMJcDdC4CPBj29X+EA8HqvUKNU7HMzjZfCJvr+h
         WBWmrtu/zS8893YVvNaT9HOV2TcaU9YOBFfh4WCxesszbdsWiIJl0z13l0q08uMQ0c8B
         BPQ1REYXYRClzh/PkY4dwAM2iW5jmu5JU7x5CZRn3pKzREq2ULGQkno6/esB1HtsS76N
         9MMD8X9RrYzVUVNEuQaws4CiHwaDHar70JzBuLtNfwbiI5Hjak+nX3FJC9MKCrKiw1qF
         p3OQ==
X-Gm-Message-State: AOJu0Ywz4kRAZbKQ8Y9W5pMAMboHkCsmeSU5VU00RatsCi8063F7lHnO
	NjygBEwJiwv4MVyKHxKT0nNtuQkJyPz4/odFI15CaN2m2oC3NwaSBV7VEvfVYzl1
X-Gm-Gg: Acq92OEZFjqZLxdSV4a1KKIndeqztoDI7Plmuglu+auHnda+/u8LPWH2Y9mB808YI12
	36unizT4xdJHc2Xil6l29/eQgAjfdbt2MWN1NCvW8I5eyGIGoxZtjo4XZCZn59ReOwNdMqm+8S6
	SHmOcvyCyt4XH+5A09Pzj3JUUJvyouO8JRrsTCYPKBYgspq1okCiycZDhywxYZOOVWjPPbkb96U
	9x5n8ifjlMbvipVb0FL932fWFB5efdooxBMtS4Gfnq/TMhfgtA1kiEvuZYxoq5p1XmEk86cBZRA
	4595mCjzyuLGEtOSb5TQ+9jZY20qnIEBYOuFbzf6Xhlnxl3KPvl25RNFEam+Mr6bEQPPLtjcB3G
	3Vq/JxieaWM/xMnv4Cn436bc0cnRliUQHRRCPRXk8RV0uu6NzgNDWpLbgIqwEOwxL5ojMEIWGbv
	YPW301WWIgpJrAR20ItJZdieHlf4v2FJna0pVMd46y+A1rKy8CF0jRpmrrvOYdcP0+F95IuMlY1
	I9ZAxidbGbVjy2EP9H7o47bSk0ucrF7J6Cdz0JvoufFtt0z6l9ZDTNPuodBYzgy1g==
X-Received: by 2002:a05:6000:4210:b0:45c:154d:6387 with SMTP id ffacd0b85a97d-45e5c5e3d73mr15324332f8f.37.1779004531613;
        Sun, 17 May 2026 00:55:31 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed30110sm30509555f8f.13.2026.05.17.00.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 00:55:31 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 0/2] Fix bpf_throw() <> global subprogs interaction
Date: Sun, 17 May 2026 09:55:27 +0200
Message-ID: <20260517075530.3461166-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037; i=memxor@gmail.com; h=from:subject; bh=kLuL2SVFgN1iN+lcM/cCC/+N0UlQHc/G7E8u2wDIc2I=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIYuzxN397aJLOl7eU+4brvFKO2ho/YDxkqOk1KJbTAwBf ttkbBg7SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMBFdQ0aGtzu8amemT7nGsfv4 CaMP3VH13683LyoXLFx3yIq1inWCLcP/GDMv+aLyyNrTOfo3/TeHSPxXiDm/l93ulcjKeRMf/z7 JCwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

There is a bug where bpf_throw()'s reachability across global subprogs
is missed by the verifier, leading to successful verification when any
kernel resource or lock is held across global subprog call boundary.

Fix this by effect summarization like other related side effects and
propagate exception reachability into callees.

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20260516022426.2109698-1-memxor@gmail.com

 * Reorder might_throw bit to avoid bpf-next conflicts. (Alexei)

Kumar Kartikeya Dwivedi (2):
  bpf: Check global subprog exception paths
  selftests/bpf: Cover global subprog exception leaks

 include/linux/bpf_verifier.h                  |  2 ++
 kernel/bpf/cfg.c                              | 13 ++++++++++-
 kernel/bpf/verifier.c                         | 23 ++++++++++++++-----
 .../selftests/bpf/progs/exceptions_fail.c     | 22 ++++++++++++++++++
 4 files changed, 53 insertions(+), 7 deletions(-)


base-commit: a828abbb897657451d96ad7bf20f1893ac983bb9
-- 
2.53.0

