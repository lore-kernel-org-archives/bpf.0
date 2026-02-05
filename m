Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2615132B988
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 20:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770323228; cv=none; b=Xs9k4kw5EQFtR2o8nBP6UB6dyHWJNJRu8y14L0iVOUCP/2yvkxQ5ngWRyxL8Ipr4rXzkxnqX321jViIIA7EjPxrg/GuN+8oXo9chudiYC8Gn1Fah6cJ7233Mv56ATyBVSibimSluCwLLyD6htgxPq+zmntwTHRwNNpgBARW6ka0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770323228; c=relaxed/simple;
	bh=EK451bQPZZkkoDLaPeIwF4k71fPF0dpnn5OrLEQRZi0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KjLDnOv/YyzAWrUQg1hiqt0i0nhTwNORvEfvwjhfueJ+k+NCflrrd8N1haepgvaazUB/y3Bx7XjTyK6hjEQ0ja1i3bo12OrbbsMTrukCiFvkT8uywSgOFXBzohho561gJTvQ8eBftsWUah43P4M5QOd6GVziSqc598NL8Entanc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQRXaBet; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQRXaBet"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so14714635e9.2
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 12:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770323226; x=1770928026; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aZoueoP7MQk3NYnWstQshR1/SzLJso8lT7VtRaoz7a4=;
        b=gQRXaBet/omO+56EzkbDN6C272wwVOasdQO9xQNLRGCoyoVO8OQUqhyPGuEVgxueID
         efKeuiyBmmUeahCKhl4NNFXRmtTAcTMXr9dFBA3m7R3OPm9XwzS1RfdLOYts60Wr5tk6
         rDXvlLjnsHb7p5LQ1Af+8f3+tPcfkRQuFMiF3Nxb/HvM9BZo/wmrOxD4PLahDkT9oeh/
         ynu4GzUyQOeiS01ZFs2leDR0UN/KFJW0L/7BLLjmP2v9/JNcNPAOnOYUFZDk88W/YYT8
         Sl6OWRanINwkpt4k9ODTcEpkf7bB/GZcgUe+rshxlkk0ojWYbpzyPhdulikSa9vpzZWp
         JUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770323226; x=1770928026;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZoueoP7MQk3NYnWstQshR1/SzLJso8lT7VtRaoz7a4=;
        b=dqXaruc2mZKlB+KFAenj9C3PfGSwLZvGbA3kAgYAhsqyJMyip34n4a2DSSe5vbcPB2
         vxj5NOLcmxm3OukLVKdCF/ad3hLFhOF+22QlvhSWNvK4g4EAadGDYMISJvNIRYp1qChn
         JF/y1kUMm3Hwj9FBYBV4NyVG9J2fna2j521zXmEpisa8zlHlN/rZ0QQchMrnYhMV3nrh
         jc/eWnp8qVrOxgnDOSyDaF/ZCTPqIza0w1ALR81ZQHA4eVIlKalq1oD8y7PTO569fMxe
         dMrKga6nPI2iZveqNTVEvrk8VmuCS0oH9SQDbwU2sV+Z6IShjxDv6Sxfm2GiQxTzh6nZ
         vCfQ==
X-Gm-Message-State: AOJu0Yxk2PwNuejsMbv0hfqASsa4oNlwW5EJxKwB9clWbjz8zespQNo2
	xrA6qTL8EI63wGFPFxoCPOyq/9a2WQ7+8aWsJXg1MnI1599fMeaO/O7p
X-Gm-Gg: AZuq6aL/79AB7w5u+HK5qjYgz8yq+YIHTKbMkMRAFRjkwG8be9dAj+p4jYaG1IsnTix
	8T+ofW8fd0+DhVjIdhTCo7Dshi/Nz2xkdo+hzRWUi7mgDadpkICPn4ujq1xpXGjZIlnu60SNapn
	dxGyAjXfM//PBOd/HHG5/jMFnYoVpCF+LnWiTXyO25W92rBoSZR7+xvoN/rZoJ30a/M2YB4jTy/
	57Y/hHWWRK6oQlcfDtG7id8w2rm3qZm/gU9cxp3bkFEM9W3eyj99uiNdIS78svSBTLTPmwFaMgx
	pxJH8D8RGpn9CqLKilkhJsxHkI3IUJcnS0jBipgVd0oH5RxjdhMnyvIhux46XyaJfEIPpAPjtJB
	dX7DZDrehnu/2q6gEeOzDBgSjStDDiX1nQePt1H5s2HGt+wKcJimjzWy/fsK7xGmyUhjpmeA=
X-Received: by 2002:a05:600c:a086:b0:479:1348:c614 with SMTP id 5b1f17b1804b1-4832023668amr7897885e9.26.1770323226262;
        Thu, 05 Feb 2026 12:27:06 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::6:1325])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d8342dsm66143595e9.12.2026.02.05.12.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 12:27:05 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH RFC bpf-next 00/12] bpf: Introduce resizable hash map
Date: Thu, 05 Feb 2026 20:24:30 +0000
Message-Id: <20260205-rhash-v1-0-30dd6d63c462@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQwNj3aKMxOIMXfMkcwMDM0tLI+MUCyWg2oKi1LTMCrA50UpBbs4KSQV
 punmpFSVKsbW1AA6+b+xlAAAA
X-Change-ID: 20251103-rhash-7b70069923d8
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com, memxor@gmail.com, 
 puranjay@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770323223; l=3611;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=EK451bQPZZkkoDLaPeIwF4k71fPF0dpnn5OrLEQRZi0=;
 b=+Zdwrg7SDI7DWuo47btwBAfl8BYTVkn4qIG95KGTbWY19rlLSHfZ1dn8rb4oZ9fpC70zpoCdX
 L8b/T1VfQbJDRw3s5zjKlHigaBofSLO9ZlcKEKfAE/wUTPax0EtXFvU
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

This patch series introduces BPF_MAP_TYPE_RHASH, a new hash map type that
leverages the kernel's rhashtable to provide resizable hash map for BPF.

The existing BPF_MAP_TYPE_HASH uses a fixed number of buckets determined at
map creation time. While this works well for many use cases, it presents
challenges when:

1. The number of elements is unknown at creation time
2. The element count varies significantly during runtime
3. Memory efficiency is important (over-provisioning wastes memory,
 under-provisioning hurts performance)

BPF_MAP_TYPE_RHASH addresses these issues by using rhashtable, which
automatically grows and shrinks based on load factor.

The implementation wraps the kernel's rhashtable with BPF map operations:

- Uses bpf_mem_alloc for RCU-safe memory management
- Supports all standard map operations (lookup, update, delete, get_next_key)
- Supports batch operations (lookup_batch, lookup_and_delete_batch)
- Supports BPF iterators for traversal
- Supports BPF_F_LOCK for spin locks in values
- Requires BPF_F_NO_PREALLOC flag (elements allocated on demand)
- max_entries serves as a hard limit, not bucket count

The series includes comprehensive tests:
- Basic operations in test_maps (lookup, update, delete, get_next_key)
- BPF program tests for lookup/update/delete semantics
- BPF_F_LOCK tests with concurrent access
- Stress tests for get_next_key during concurrent resize operations
- Seq file tests

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Mykyta Yatsenko (12):
      bpf: Register rhash map
      bpf: Implement basic functions for resizable hashtab
      bpf: Implement batch ops and BPF iterator for resizable hashtab
      bpf: Reject resizable hash map in tracing progs
      libbpf: Support resizable hashtable
      selftests/bpf: Add basic tests for resizable hash map
      selftests/bpf: Support resizable hashtab in test_maps
      selftests/bpf: Resizable hashtab BPF_F_LOCK tests
      selftests/bpf: Add stress tests for resizable hash get_next_key
      selftests/bpf: Add BPF iterator tests for resizable hash map
      selftests/bpf: Verify resizable hash map is rejected in tracing progs
      bpftool: Add rhash map documentation

 include/linux/bpf_types.h                          |   1 +
 include/uapi/linux/bpf.h                           |   1 +
 kernel/bpf/hashtab.c                               | 717 +++++++++++++++++++++
 kernel/bpf/map_iter.c                              |   3 +-
 kernel/bpf/syscall.c                               |   3 +
 kernel/bpf/verifier.c                              |   8 +
 tools/bpf/bpftool/Documentation/bpftool-map.rst    |   2 +-
 tools/bpf/bpftool/map.c                            |   2 +-
 tools/include/uapi/linux/bpf.h                     |   1 +
 tools/lib/bpf/libbpf.c                             |   1 +
 tools/lib/bpf/libbpf_probes.c                      |   3 +
 .../selftests/bpf/map_tests/htab_map_batch_ops.c   |  22 +-
 tools/testing/selftests/bpf/prog_tests/rhash.c     | 485 ++++++++++++++
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../selftests/bpf/progs/bpf_iter_bpf_rhash_map.c   |  75 +++
 tools/testing/selftests/bpf/progs/rhash.c          | 292 +++++++++
 tools/testing/selftests/bpf/progs/verifier_rhash.c | 112 ++++
 tools/testing/selftests/bpf/test_maps.c            | 107 ++-
 18 files changed, 1802 insertions(+), 35 deletions(-)
---
base-commit: 75cd3beb64d0977009e3d1a2d0c03715d3e5e156
change-id: 20251103-rhash-7b70069923d8

Best regards,
-- 
Mykyta Yatsenko <yatsenko@meta.com>

