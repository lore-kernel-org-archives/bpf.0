Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83D11F4611
	for <bpf@vger.kernel.org>; Sat, 16 May 2026 02:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778898270; cv=none; b=sO0aul4xQxsNAX34f2h6i2E9jpaQt7fVLDW5S+1X4aJVOWtnrQxTzuRLuxBE1aXvACJ4cg8ogWVwuJOBgPK6cbRo4lLgLaS664gCKgrSXKAWBG6Wt4hXgy1UneJijt+HnX1tyWeqfq6jiMbxt+q+xH6L+J9/kGp/4Sinai2anK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778898270; c=relaxed/simple;
	bh=TLUAM6aRUFq13CHTiUAFEm2a4sIBAo8XW/9+I2+NdaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rmJAQvUSMs9hg4olQ6oym6CRF526mEz41wbddXVP6dpzrfaa6etRmr0GQ+C45Cr1ODVYCRN+W9/158RGiO7bKf9Z7IB7cvwWUf6QPkiEA16gWgyR9tpAUqE2XXlBkHnwy7nhV3TQJ8FEgLPT9F90N4z86/vT7TsP8i7dYzsK874=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yb178kq4; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yb178kq4"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso1896785e9.3
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 19:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778898267; x=1779503067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=936jsmcnzW/+Du3ONhabIEK8bFBx/8QhwdyUAEAYtKs=;
        b=Yb178kq4tn5xnEGNvi5aqli/h8So51OS+2H8oI/cMXBHJF9rpI2QFBNA1kvftihSvz
         3YiNIvGboZqFyNOUHF+1dtSo8gFYTjG5YtEEkhELQv0/ZIHcMczdeOMfxS0bq+cJpyJd
         ZvI+ic1d2bYopr/Td/OdnT4AfqLa5wpCaHAlrgspfXbrYHcGnYzBQccBXuXTqMicdCOH
         j5Mi0WGNwR2IjO0NyB0eV44ZHCppO0zJ4UoHL+WdHW9FX8X1J8KTtXmMgnDItn6T5BXa
         xrje3EWh6cA3cHjpQGC91Ee9Z2IzjnBZzlgILSYlpAIGE5czfcptZKaCMMKoZ9TzTch0
         GPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778898267; x=1779503067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=936jsmcnzW/+Du3ONhabIEK8bFBx/8QhwdyUAEAYtKs=;
        b=in3o0WBaKC0BjL7gJCkZ59GjyZlWstY7bSqInxCMZTmTX7JG8vAqBH/0J/NqhYVjT2
         u1jUBxQh2OPlQKVhIXor8SwNVN+C7Tw5nZ8BYhYXWtUM7jBRyhy73euD75OxcLvtCl5P
         AShEGDWTevWezlQpnXdvb/6thJBCSVFEFObzs3T8WC1l3mmQ+4J6azUbdAiSSfE+17Bp
         4MlC+/IIj1mVKXxl3L0Er3EHDi/Lcs3GRjFcJqGLtSKaHQUb8qmWNNj1j6PuhOaiYSD7
         I5pqqdsBZX6l9recYEKL+kgfSoqbRKnCEcyXBH3X0aU+BwfSMqXwDtDJvYlHCt8UQo03
         7fQQ==
X-Gm-Message-State: AOJu0YxJrU+07KiU3qrX8g0UVwnptv10E6NaWxk/mKrpxC4ft/eqC82S
	KCmjv9vTL5cS53xNNYobn1CbTCeCX5aKmYHKvWwXLJJXx3vuDsSBQ5JNcW1glsYT
X-Gm-Gg: Acq92OG6xMjv6isLqwoOXVXQV3ScJQbCvHl741DxLurJ3cu/aa7pNK4tLQ8lw2vsO7l
	1RnYg0VQJeSJCqUZglSKbqUHvfaCqgWzNblGHptQoW6zSfuZkhHhgiVxXVOg5Gl/O6xrRFnOtt8
	cb00pZglE2iDzaRiVi/Jmtw5meFfJFSo1K7+q5dOj2Phbk44Fr98zHPnYtX0qckh4Ti7A6qtM4C
	XyD2rSm8P5OR6W0BfNEAgILRoBreMu7BJ+q/UVx1mdo99kzllksJBav4/AUCkRlX9OV8cO9ojEs
	QYW+TlZnxMpv9ne5AF5Zj/zwBp7bnMe+ojF7LVtAit+W5kUYeSrxK2nFcFiD6JzYkFn/F5uzamP
	j+9QPOIQMqosoRMxbQ7nwwtnR1fL4gfSfO45qcN/odY1Y50Bq0D/vXxk+Kc/g/ptio6XouZ72ip
	zZfuvS75gvxAHOjVqn/YR2yLyqKrVn7UVudw/n0uB+uuN02YwmtR8jKCuRnDtSfmxI8V7l4fiBb
	Tii4BgqMCCRHr5eEGZQHN+aua3Ir6zN9tcFVQBv364ENzuoFBoxh+YHTCb5p7CJlPt4Nb7i20zq
X-Received: by 2002:a05:600c:c173:b0:48f:e230:c3f8 with SMTP id 5b1f17b1804b1-48fe661b50amr91432855e9.30.1778898267283;
        Fri, 15 May 2026 19:24:27 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe6aff4sm26111165e9.25.2026.05.15.19.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 19:24:26 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 0/2] Fix bpf_throw() <> global subprogs interaction
Date: Sat, 16 May 2026 04:24:23 +0200
Message-ID: <20260516022426.2109698-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=858; i=memxor@gmail.com; h=from:subject; bh=TLUAM6aRUFq13CHTiUAFEm2a4sIBAo8XW/9+I2+NdaA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIYv98iK9nI5vh4slLWtO7vvKGHlwuouUzsEnK6XUFFmfL Jh7KTS/o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABP5LMbwT2HaxybxZIOKDTeW pmXsVzOczSHd4ZcgEtv35k24fKLYPUaGm69qdT+9OvGnTPTall9xp4ruS2bqWOxJNDA0/nhx29U ORgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

There is a bug where bpf_throw()'s reachability across global subprogs
is missed by the verifier, leading to successful verification when any
kernel resource or lock is held across global subprog call boundary.

Fix this by effect summarization like other related side effects and
propagate exception reachability into callees.

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

