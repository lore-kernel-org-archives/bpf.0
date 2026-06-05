Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFCF314D06
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780698027; cv=none; b=sMbuU9sJgXbPM1yxhxHlzDCpcZriMHAiiehBBXzCIIjKrYW6hhgi01dp/rt1/J1di1F7h2EUnpkHfqgTWoXOmsfZgBlkkkgMQrZ8WMYySJSJmJmclf5T7hJaD+BMtrGry1VBfVyqL1Y4HAoxGFV5hU6vKOPK6JiLXAmQwMuODfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780698027; c=relaxed/simple;
	bh=SSgMS6VY3I1lm3bClh6I4FauBoAd1m//qrd98BHZM9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q7gXMBUNHtusk3ptpigoOAvip6tCF71ftbTErhjFDZzAiLmOFs2o3WR+59HMe8yrg5IUNKJkFTSHKnhX3iluuy3GTN+InkhaOctfOpkTNVCztYWsn9965EYr+yI9LTL/SBXHOt7e0OAwaNyvzJg+PbTCgMOkMDh6AijVGUmTJzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Wqodrn/q; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Wqodrn/q"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-8421f0e9c5bso1113386b3a.3
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 15:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780698025; x=1781302825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ozc7ZOVaDa/PQgfVHJJiUiyg5LTkkp0SlTOtK2nj+gU=;
        b=Wqodrn/qqmv65KhorqFB39/NnU+w0YG7kr40YyiqJiFlRn7BwIU6m/iEVIvn7vTjxD
         sTryYUzWRobbdUseJzj4fFCOuwHLSla2ckt3gimlYvEMrNhwLxD9Po7AXZD7YAcuzdP2
         h3Jq1BbrpRJY+TrAqYzPbB+aNAuODv+0e4KUVi1q/q0K8F6+6Ty8KeMaCWeXhZZbw9dN
         aERHcnT/wAXvBVU6MO6Gxsa5u4RLR99i5nUoc+hF81TocGnQuCvnDqbWexIBJiiIUTw5
         Mdi/k01U3LwCsMtaosNiWk0JroDj2AdBjCL3DPqu2ajRnuVYTsGGTpoo/gxfwTs1kx9J
         1KFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780698025; x=1781302825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ozc7ZOVaDa/PQgfVHJJiUiyg5LTkkp0SlTOtK2nj+gU=;
        b=Vm5nZe2xa68SZRwtbyS5ytmL//QdH/AxZX0ZA6aVdCjM31KmOp08uAWN8Df8ROIKK9
         K+U4W7gk6DKh0exSanziKknhAW6QwlDzuMZWgfLjVAWYQqlLShwANSiVrH9aeWWp+cWF
         a4xdP3AmXGE+kxlFJ+H5nXnjeutWroJqPat7FDj2k0cYspm/Sv6g1FKp1eb+Nvhemf7k
         j1LxUVc4JqPeFssTlY+Kp3VTBcivkgmE958pA1D/7ss1CabrknebE4Z2d9jKwrn12KuT
         IYHgY1NkcXKGW9Asr4hqROkY8I4ov3JKVtZqkYE85D+W9NIlw59SbkpDvs97HDg+T4Xp
         IhNQ==
X-Gm-Message-State: AOJu0YxjSID1hISn7O57bpC8l8MokSt8seBopM35towdmOKGxyMaooqw
	blBPxkAtyaUJTdNO065PtDmhMkLpe6cLpEyDrDcyoJ6sfvBOnPe1m7Vz9FUVxIYu+OVTP9F/MqC
	7R4xX8agLM5f7Fs4=
X-Gm-Gg: Acq92OGy1Cvz/vsHt1+gfqgJJLw9gTbpMCnTvDKxWouJKel6PkWYABxVlzPcLY3Nfnf
	WQ92uQOA9rjgCDDUVX46zryycRrI8oh4gbsYhiz8VXXKgHVETVxGWNoAlJPzJ7PhH2vG5mf8LuZ
	R/T53NVRTgZOgsO0JNXAKmZsyxHzHcmrHj4b73Nw6oy/C8lAE2he5ylPmT5VR+6qvGpMWwFRRt+
	n3qD7y8A8FAjyyjRWNOHs7M6UtpTQpZRRPT6pQryKNnbQokTnDfgi6ePlXOTfPTXiM5QopBOM6K
	tTcuOxStYrU+nTTkF3rsBfTPDivmn2dT7/p2qe9tfDjumWZjyFZ9pKfEYjZn9rhh/EExWrQ7qy9
	K1Tu1CQ5SHAk8sVkhRXd0NkJfAdWhvxU1vbyVi1qjfTnP788K71l9bxNQQBNdobOyGEXqHiQYvB
	CxZdZFkTcj95chxWPhT1El1HiKyqVUSFEBrxA=
X-Received: by 2002:a05:6a00:9a3:b0:842:5c90:736b with SMTP id d2e1a72fcca58-842b0f4d433mr5504558b3a.29.1780698024607;
        Fri, 05 Jun 2026 15:20:24 -0700 (PDT)
Received: from krios.lan ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282372868sm11648844b3a.17.2026.06.05.15.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:20:24 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	mattbobrowski@google.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 0/3] selftests/bpf: libarena: Add initial data structures
Date: Fri,  5 Jun 2026 18:20:17 -0400
Message-ID: <20260605222020.5231-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two new data structures to libarena. These data structures initially
resided in the sched-ext repo (https://github.com/sched-ext/scx) and
have been adapted to the internal libarena build system. The data
structures are:

- Red black tree: Fundamental tree data structure that can also serve
  as a base for more domain-specific data structures.

- Lev-Chase deque: Queue data structure that allows efficient work
  stealing, useful in scheduling scenarios.

The data structures are accompanied by selftests that are automatically
discovered by the existing libarena test_progs selftest and incorporated
in the CI.

CHANGELOG
=========

v3 -> v4 (https://lore.kernel.org/bpf/20260604235016.20856-1-emil@etsalapatis.com/)
- Turn off load_acquire/store_relesase - dependent selftests for s390 (CI)
- Various style/non-functional nits (AI)

v2 -> v3 (https://lore.kernel.org/bpf/20260603182727.3922-1-emil@etsalapatis.com/)

- Add workaround to handle LLVM 21 and GCC 15 assignment-to-memset promotions
  that are causing verification failures for arena programs (CI)
- Incorporate Sashiko feedback for cleanup edge cases (Sashiko)
- Simplify some of the ordering semantics in spmc

v1 -> v2 (https://lore.kernel.org/bpf/20260511214100.9487-1-emil@etsalapatis.com/):

- Rename tests from st_ to test_ (Alexei)
- Removed the freelist caches from the rbtrees, previously used to defer freeing (Alexei)
- Moved the type and function definitions to use the __arena identifier
- Removed the typecasts during function return and directly return __arena
  pointers (Alexei)
- Renamed queues to spmc queues to abstract away the algorithm (Alexei)
- Adjusted the memory barriers in the spmc queue
- Added multithreaded testing harness for libarena programs (Alexei)
- Added parallel selftest for queues (Alexei)
- Split least upper bound and exact find operations back into separate
  functions to prevent RB_DUPLICATE-related bug (AI)


Emil Tsalapatis (3):
  selftests/bpf: libarena: Add rbtree data structure
  selftests/bpf: libarena: Add spmc queue data structure
  selftests/bpf: libarena: parallel test harness and spmc parallel
    selftest

 .../bpf/libarena/include/libarena/rbtree.h    |   83 ++
 .../bpf/libarena/include/libarena/spmc.h      |   27 +
 .../bpf/libarena/include/libarena/userspace.h |    6 +
 .../selftests/test_parallel_spmc.bpf.c        |  673 +++++++++++
 .../bpf/libarena/selftests/test_rbtree.bpf.c  |  968 +++++++++++++++
 .../bpf/libarena/selftests/test_spmc.bpf.c    |  194 +++
 .../selftests/bpf/libarena/src/rbtree.bpf.c   | 1047 +++++++++++++++++
 .../selftests/bpf/libarena/src/spmc.bpf.c     |  234 ++++
 .../selftests/bpf/prog_tests/libarena.c       |  187 +++
 9 files changed, 3419 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/spmc.h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_parallel_spmc.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_spmc.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/spmc.bpf.c

-- 
2.54.0

