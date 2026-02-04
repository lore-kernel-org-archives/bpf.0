Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB7627E04C
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770190564; cv=none; b=i+Hu1ylagiHhXSBQF/Q9QFmd6E+DwPTyaAGx185g6hGqo8fRIJgNzMBKeKATV7iWtKctPblCz0nAeJgPdmYggk2urJm/eRBrpD9M4lw8+EKPc4Np9JyaQR8IAdrB7bw1XOBiOKQuJDgEVAbhGgY48hd7hqf1kn1dqImr/O+Hm6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770190564; c=relaxed/simple;
	bh=AkfWSn6/+xsW7ST5MKU1RyB7aw8jMS5NSrFFa7ROEEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e6CtygF7C/BfXtcYHZEKt8jhz9uyFQF2UOGSho3rq8q6uXo5HK0TLsbKromKNO9GkPIumiajesV6XlkR1Z69NLxSciu4p85Q0YvQaziyjFTjNLDQg+YYWRJHznQ4O4ALgXLRISGpWVBQboGOXziMAWwWd2hxVl5fzpdGsWGhTlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7IJ+xxg; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7IJ+xxg"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5663724e4daso4475034e0c.3
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 23:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770190563; x=1770795363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=agMTM9qEqwnVQsJGvKQ5XLr26U2EggmGkInmG3UyHBk=;
        b=j7IJ+xxgfNWBSsUkqSQ3wtK5kC327kXEr/1xkdilTZrxYn9oqZ8TkDu5/MsF95yHdn
         UeJZWt33/viYsdrFnZZ8dWq0W6RAaRB8XFGgTmbdVx+nypqhHUhRe5OFeqGlmz4Fa/9U
         YGPEkvyY4jIalRNst0kj3bW/OkCZ9VJc9KWuZU4objKrw2vF7GhEOIkeE+YmjYraMeMX
         dFgvLREi5dtb8EbPQEUgjGocVgHYZV1OgiPovn48bUbyH0DPo9fNDs8aE/td9NIkOvg8
         1rM3cS3Foi0P7mzz+APKXNp0F4EsHeOeveJaNyXHhJaz64LZM/AXGt+5HXY9C3iaJCkF
         W7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770190563; x=1770795363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agMTM9qEqwnVQsJGvKQ5XLr26U2EggmGkInmG3UyHBk=;
        b=ZoRFw/v67Iy8EORMmGJAst5vEe2Li/RN1SXXdQ14KOnSUNH+Edl9YbS3YAxbP6ZGqR
         LWLW3OIeo3rsINnrOg/VV+AGHz1ZEHNiHFhnRV6PruyGlmMvYQb7gMqFK1PQTOIUo/gW
         oy+Cgyx35jUf/UK7NzCuK/jerwm+w9F36b5S51HejhV5R+ijwHYzrGh3mRLK2JlcZg1C
         rl7UMGN1AFqD9lrcbu4Cb5ljaIUXpnTBH+8Wr14eDJTiemWjKH0733z7MpotoO3hrfID
         V8qLGoiI/HDgjIwJ+ni7g2zcbVjcaPmVhzYdpUr9SpayIj7vC4KHypvQDcL0NQ+xAosI
         mmlA==
X-Gm-Message-State: AOJu0YyJ6NCUeigEUVkykMkgUE5/Bw+xu3+RaZX68P6rFXH+ubU5K+8A
	67Vd3CJyH+qc7dyge7GpXa2uDgfwgirexNtTm61GOy8f4BKWI7p6stm4QChGsg==
X-Gm-Gg: AZuq6aIyHv8fiqylgfjGrWGSeOVv1MligWgO58aTRF2TqV8H2Ul1l7cU44bl4nwum5P
	1Ns9GKul8g2m+JJu+86ogNsuT7p4IV8cgqQjXJE5gWTCRVWTY57XDD/TIKxgbgV0oB93lzQmMKr
	zXUCsrDJFe6B5IfO6dKpkg0uCYZgFM+qPZjMi+7jm7C1k4TFbVRWzUi9GhdrrJ7xVYwQmxvO99L
	dtMvGbrXI4acubOdfIqncJWuF2k36E7Wx/9LouAjyiTdR/a8mD4yvZbu9gY2iA5/yfx0tquzP26
	nHyqUtGG1F0zENUPcFe1wsjbXufj2VjUXx//S7eIlioVbWZEWJFcjkFcwjnV+vEhmS2BoURkBBR
	dkFEvzBL0Cx3CWti5ZAny6tJ74UjpTYm54ET4t0kjYLGWdBYp9VCu3zqOML7LA+TwWD15US0BvL
	qZVrck7Xybx4HjvdRnXTEsI2hk0sBuTphpj9OTKFrpEfUSdrgtvPzyK4I4Slq9tw8yB//N95xlb
	AzVm9B/U6+z+8IG39X1wANY86G2KRdN+c8AWLrZ64GvoXPCmA==
X-Received: by 2002:a17:902:ec82:b0:2a8:7814:47cc with SMTP id d9443c01a7336-2a933bc8a05mr19931225ad.16.1770184309615;
        Tue, 03 Feb 2026 21:51:49 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9338936a7sm10703085ad.33.2026.02.03.21.51.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Feb 2026 21:51:49 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	mykyta.yatsenko5@gmail.com
Subject: [PATCH v3 bpf-next 0/4] bpf: Fix conditions when timer/wq can be called
Date: Tue,  3 Feb 2026 21:51:43 -0800
Message-ID: <20260204055147.54960-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

v2->v3:
- Add missing refcount_put
- Detect recursion of indiviual async_cb
v2: https://lore.kernel.org/bpf/20260204040834.22263-4-alexei.starovoitov@gmail.com/

v1->v2:
- Add a recursion check
v1: https://lore.kernel.org/bpf/20260204030927.171-1-alexei.starovoitov@gmail.com/ 

Alexei Starovoitov (4):
  bpf: Tighten conditions when timer/wq can be called synchronously
  selftests/bpf: Add a testcase for deadlock avoidance
  bpf: Add a recursion check to prevent loops in bpf_timer
  selftests/bpf: Strengthen timer_start_deadlock test

 kernel/bpf/helpers.c                          | 31 ++++++--
 .../bpf/prog_tests/timer_start_deadlock.c     | 33 +++++++++
 .../bpf/progs/timer_start_deadlock.c          | 70 +++++++++++++++++++
 3 files changed, 128 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/timer_start_deadlock.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer_start_deadlock.c

-- 
2.47.3

