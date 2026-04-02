Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F643AD53C
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775122181; cv=none; b=E0+NDhRFU9Sky3RMALRF8Gh+ec0CxVS/vrEXKr48fS/2p6coFCbkqncNzdPei+/maZF8QoSrKblj2gbABV3+qcO5YNCFqjfWPZpruNRudrgzNDZSDQv2Xz5hybzlrkmUbWxcg+93xjFTQh2cShaEjvJD3iqlBRxhY10SBdpcWB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775122181; c=relaxed/simple;
	bh=tSA+o9FDa78WsmD3iH+sl7pAYTRdnd1kK9FVuy5t8oM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fVU18tRaJ4xYpZuGBOtQ1D1sCc9I3lgvEg6qBa/mA0RnsLbqosX23abmuwL5whUruAdpo3C73EdZwuOrymoWOmQF4jqRN7d69xaizNP0cxIZptZTENgXDm4ooZ8rAoLlKhhFxSLmp7P7/SzkHIbrCZCsDgFker7/yuLCLYe8v+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4aIYRtI; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4aIYRtI"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b2469e5117so3426645ad.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 02:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775122171; x=1775726971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yLbzVc7f4E1BciqJ3cOYBXmu4dEWArxjVAddgytIGt4=;
        b=L4aIYRtIqyKJYIUh0n+c0FsQ0b8ylWIhfVV94As+pADkzg85Lc/xxyeKCkieWwHEWT
         im07ZEzoOsD1bkuUtstck1pw/j6FfI17s/0LM3Zq8h0pOKqTrB/1VhZLRdUQxrlXxj8Q
         qxuY0zbK5vDvnthLalthtY039Z7dJiicVIOLiJFg3OzgpMOOYJeOv6DhKfyDTbbGM8c/
         wvPgPhM7IB4RQnRNbVj8X3JP/mNf8I4Eakb6+paenAz1KLnsSsxthvXFBOoy3QFuafKe
         svyrgHSyrRWlLrZdiuvKzENLEY5gwxxpLvBJ+ucOmYImxfEbo/0Ch4uILU7Ww6lNC3Id
         GGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775122171; x=1775726971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLbzVc7f4E1BciqJ3cOYBXmu4dEWArxjVAddgytIGt4=;
        b=DRokaj+Mc/8Ig2RL89g5YBqbILJxCUcUaCpQCx2s5PvGDja3vMdkeC1XCKk6nGd5QF
         L+5BdNbYDIm4nT3KtxQ671cNijEXOQi4v7EUDHtweLzVN+/V0FS4NCoNV9aiLikOseo+
         5B/fVVw5odrsQWVvZJIwGFngig1IfOVDrIiY691vQGC2ge1eZvlLtZlUL2uIAKPguMbY
         aBBQICq5rtQesqF3N8FBArlwnDZxPf2GIHajWjUsHBZGD4rdczwMcQBuUXgeVNcoyjDI
         kV3vR/cMDWFzCYEnxWynjBa2TBzRQ+DsqhusDbHj9fsqawFzJQVjNJKahsUBPg5uHYbW
         mnpw==
X-Forwarded-Encrypted: i=1; AJvYcCU6A6E6WQzx4/g6OQwrMpvh76yJEF6inbxwtS0A0jsOt/HATjG/UL0J3RadELu/UyMy+2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLYiAx/aW3u2aMNodFHAYu3508FFeCe2nw1shNiOlTh3SBnm5+
	E0W/E/jVfLjY1jlKRK1da1B/AQPjPWioaSd5NTXNBsL3RrygxwT8kFAE
X-Gm-Gg: AeBDietrjWWI8g63u94yb733YY6NNpU06ZbeYpNi/KKbx/x7fBbXQ1WxzOlpH5I99Ty
	pGyjjfLk8Mi0qPNCf/w+3kGr5v3PLMGrsiKiZ6sHX+kigjRpLcoixifPYog7u7blJbNigB5fyTN
	wUKOBsJLbT0AQo9nUVdC0lnbXg8nqYJAdLTxs8v43NzgBAOZtVVtE/jK81XZ8prNJpQMFsaUZs6
	fPsPwL9xOFXnurQJvPZ4CoCWOW/kGZtINgAYWmEzIJojKgZtPEu+HNFgISCkgzVOY3pYMwdt9aK
	xXWAuMlQWaWGgjLWNC2k2zL0a7tEEKMnOywHZqFcRBzHiEtFXGLK3s5iQmt4Rq2C2dtZ9nyvW1U
	fUtz1wmr3oDcD7QeH4tLxGZ7VFppzWpbHvNdRE/vHNyoRolrYZYTBBUM7PkUDhEPeHBpfL3mQDR
	rMPdSXl9Y0F6VFhXvuQ/vwh79RrD9hpngH4vg=
X-Received: by 2002:a17:902:d2ca:b0:2b0:b557:6fe5 with SMTP id d9443c01a7336-2b277e88764mr17140125ad.30.1775122170878;
        Thu, 02 Apr 2026 02:29:30 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cada2sm21176705ad.71.2026.04.02.02.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 02:29:30 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: [PATCH bpf v3 0/2] bpf: reject direct access to nullable PTR_TO_BUF pointers
Date: Thu,  2 Apr 2026 17:29:21 +0800
Message-ID: <20260402092923.38357-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

check_mem_access() allows direct dereference of PTR_TO_BUF |
PTR_MAYBE_NULL without a null check, causing kernel NULL dereference
on map iterator stop callbacks.

Patch 1 adds the missing type_may_be_null() guard.
Patch 2 adds a selftest.

Changes in v3:
  - Drop stack trace from commit log
  - Split kernel fix and selftest into separate patches
  - Use [PATCH bpf] prefix

Changes in v2:
  - Add selftest

Link: https://lore.kernel.org/all/20260401142316.2452-1-tpluszz77@gmail.com/ (v2)
Link: https://lore.kernel.org/all/20260331172720.29938-1-tpluszz77@gmail.com/ (v1)

Qi Tang (2):
  bpf: reject direct access to nullable PTR_TO_BUF pointers
  selftests/bpf: add test for nullable PTR_TO_BUF access

 kernel/bpf/verifier.c                                  |  3 ++-
 tools/testing/selftests/bpf/progs/iter_buf_null_fail.c | 51 +++++++++++++++++
 2 files changed, 53 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/iter_buf_null_fail.c
