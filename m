Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794155836;
	b=eYTCnlVcDKAmGpDfdk+Nbg+vJlmeyeuSUKVLMRkEiVKZi9vMbhulNGn2ldHAYQM+4pTW
	 rRjEory4Cc5gaJWxgO6ZF8H0ZlXdH1AEa2nQ9nhQE7DN6dZfmdbj/1UWXFr420KLSYpjq
	 BOEchgPaRwXfiimGpOcuc2u53MsoGrtBxN5YX2Jl6ZWbI2PJGQlv7UdCAlTodFlKUC7H7
	 CNSGCe4x9/zJ69gqL+kGVD0jDf7wOC1bRHrdSCFaAR+JCASj/qYrYV1dFwDpokNyBYxW0
	 Tt23DXI4HfVP2syDnp1bZEmD0uiGfr3vZ2diSluWJNemebY+Iq1QR29hBKDFaJURwoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794155836;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=qQyYjjziPf7JLXkwJGftsHIvVEZ6Kfn9DwCUnFTanO4=;
	b=xZ9Dnec8nYK9QBY7MaIPuNhdUMr8aMKJQUCV6SMNf1ZjUM93Vf7tdBqDk3bh0IjD04h3
	 HDz4WQqmuRLU0em8QXr2dZdioDZ9j5SdCCG3ytjlcZDIyBcr3an9Rip/tqiBai7Jp7A1m
	 2gsfJm5UZPkudBWEyd5JaPK5RSEYk/+ggPX97Swzut+5UdO+7ofcXUzDv6A05hiE7YbE4
	 cBQpKxHDCdVUQMhLbRh21tsv4P13aVXCw7vUQjzIDkATJYW81Q2RblkPyP2c3I2Z0xNzY
	 BeBAhbiottdL38I8DRdKYPd2P+/UP0WIRA463McM2PCJ4cVTMKLz1LVemHYq+RAr8og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="I/BbnJ5w";
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0CF606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 16:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD0CF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I/BbnJ5w
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a07078200fso25240b3a.2
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 08:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794155835; x=1794760635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qQyYjjziPf7JLXkwJGftsHIvVEZ6Kfn9DwCUnFTanO4=;
        b=I/BbnJ5wQM0Ii1aKc7TaZ0P5Gyc2nvg1ehHglLKXzPqBPWdbwQzGbxOs7c9moxrAMv
         8wUhaqOR8MgM8wq9bMkJBfzzx205Ep0i/0zJJXz4fNV6dIPLzbCl6tl+OU76PyaksF60
         bqPwISF2TiWu1CmqF3fud6ixkbXkd2kErWABy5iOUDuf7zmth74b5mvsJg8m6UZkf5ct
         KLE0GMxaAOzgA9n5RrI3Z7azLxWHjQqkmfWQKEEzPRlR4QrQso8ZR2WX90GOXmOzVeuP
         EiHKn/zSAK/I8rZbXouoMfnYzv6MIa3hQIbAhdhlTpJ2bPUDuFn6kIiULJkr2u2K6Fn8
         VPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794155835; x=1794760635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qQyYjjziPf7JLXkwJGftsHIvVEZ6Kfn9DwCUnFTanO4=;
        b=LfqCnkSY4TJ5Ld3Gi3kLqkMk+SrdZiVnQK99fUa9V/pCpa2J/Y2Th5fLUNur2tALF4
         +RHboSTnrl7QO+lQcGMP8juT2aqO6T7gN1IeLkq2eiNkG+WuQIt9zg6CXwu+kJP9iMMu
         vbQB3PQNsH1Gfk6TPrLXi+2OSf0IzWFMWGf6e13tmyqLPh43mwUBGDdhVALJFlsIYO0N
         b1MjXLv/e+EChwaDiLZLikK3LAipvAHplK69NK3GmV6Ul5sDp4QXhtF6LxM8xkG6HwUD
         uffVyBud4UgFMMSncAlqoQTbRPzDv5ivJ5BlWgP54kCAX4yypCp2vUgnxWFWuHaOdSKw
         iL+Q==
X-Gm-Message-State: APuU4Z8us02ChE0i1tAcaoNTtoPZ1QhodjU/ogp5+5GMXqxQCt0oTimG
	czI4dxyoZUKLMdfcWL0aUuKDuXSjO2cZE0R6n5bTASugFnoHBOEPSVSbHKLlDQ==
X-Gm-Gg: AYBFou22K4hCKPduyS0yrBfGzrR02BbJxO8DPGW3d3Sp5d5+W+hemR0S3j937rKFIC6
	waDLH3esY8roiPfR0iP61nEbaOh3Q6OipBM0bED0nrq2iroUwSw5Je/yl3OIfV8aeRi35ptHa7q
	W13KgE5aJNZiqcC8WdBhtyCByJFnAhRA9YTixGaOSr/Qv8RqMb9safpwTVtucNkDZ/QyDQVyIKc
	MiDWqZw7CqztEoMMc6pENaka/qECQq0GY/BqVfEKNqdm3NrsBFnrh8YaXaKH9GjC3iiW9pw50no
	M7ClUIO0NaR3scDiyogcNnmenLzxUofsiWE+GvCXJZrCbYLB+iq5PlWgRp9lLnSK9LkRkiLSCPN
	QGfSAohG8W32QcGf7lgyqLE5gX937R15GMEhKY0YTeoDRSrGdAOhAHjUfFxQOmw+zT2XfO8MssO
	uV8kRoxhbjoS1Np4syynLlMJKTwscwwCmI1vDnOU/uyiX+CsQhRw1dAx/pA1++UO+eshDqSBLwf
	TSJ32QGBxX3wKLaZqqnSzRpiQ5ckHy5llEN9+EiiEQQvgTDj6gPyNiUZjRZfRc4ZGnTLMwqfYAB
	67tTeETh56eVVqGkJ+mt2a7dN57vZoH9JInZhPeOEuhiUavDTax8vKyp01sB2vnQGeCWd+/IAbM
	yEQAgaehpkBWYogX0NhtgbYRkt//obcb2Kz4o5F1Fl/QtuFzaEVEjUHCuXAlLFe8CM0hEw2QqsV
	h2kPAqP5VT7x3ovflH7J4=
X-Received: by 2002:a05:6a00:21d5:b0:886:5938:cdd4 with SMTP id d2e1a72fcca58-8b66dc63590mr1438798b3a.19.1794155834699;
        Sun, 08 Nov 2026 08:37:14 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b648e55303sm590902b3a.19.2026.11.08.08.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 08:37:14 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next] selftests/bpf: Don't include <linux/ptrace.h> in BPF progs
Date: Sun,  8 Nov 2026 16:37:10 +0000
Message-ID: <20261108163710.1881321-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

BPF CI cannot build the selftests on aarch64 since its image has new
kernel headers:

  CLNG-BPF [test_progs] freplace_attach_probe.bpf.o
  In file included from progs/freplace_attach_probe.c:4:
  In file included from /usr/include/linux/ptrace.h:188:
  /usr/include/aarch64-linux-gnu/asm/ptrace.h:96:2: error: unknown type name '__u128'
     96 |         __u128          vregs[32];

Commit d4bf9e08d412 ("arm64: uapi: Use __u128 instead of __uint128_t in
UAPI headers") made asm/ptrace.h use the type of uapi/linux/types.h.
BPF progs are built with -Itools/include/uapi, so their <linux/types.h>
is the copy in tools, which doesn't have it.

Eight files in progs/ include <linux/ptrace.h>, and 20 progs are built
from them: pyperf*, strobemeta*, plain_c_strobemeta_bpf_loop,
freplace_attach_probe, test_core_extern, test_perf_branches,
test_perf_buffer, test_rdonly_maps. None of them looks into struct
pt_regs or uses a PT_REGS_*() macro. At most it is the type that the
argument of the prog points to, and bpf_helper_defs.h declares it.

Drop the include. freplace_attach_probe.c replaces a function that takes
a struct pt_regs *, and the kernel wants a pointer to a struct there, not
to a forward declaration. It takes the type from vmlinux.h.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/progs/freplace_attach_probe.c      | 3 +--
 .../testing/selftests/bpf/progs/plain_c_strobemeta_bpf_loop.c  | 1 -
 tools/testing/selftests/bpf/progs/pyperf.h                     | 1 -
 tools/testing/selftests/bpf/progs/strobemeta.h                 | 1 -
 tools/testing/selftests/bpf/progs/test_core_extern.c           | 1 -
 tools/testing/selftests/bpf/progs/test_perf_branches.c         | 1 -
 tools/testing/selftests/bpf/progs/test_perf_buffer.c           | 1 -
 tools/testing/selftests/bpf/progs/test_rdonly_maps.c           | 1 -
 8 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/freplace_attach_probe.c b/tools/testing/selftests/bpf/progs/freplace_attach_probe.c
index 370a0e1922e0..c0eb2980851c 100644
--- a/tools/testing/selftests/bpf/progs/freplace_attach_probe.c
+++ b/tools/testing/selftests/bpf/progs/freplace_attach_probe.c
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2020 Facebook
 
-#include <linux/ptrace.h>
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
diff --git a/tools/testing/selftests/bpf/progs/plain_c_strobemeta_bpf_loop.c b/tools/testing/selftests/bpf/progs/plain_c_strobemeta_bpf_loop.c
index b4f53c42e098..d2411a41f3cf 100644
--- a/tools/testing/selftests/bpf/progs/plain_c_strobemeta_bpf_loop.c
+++ b/tools/testing/selftests/bpf/progs/plain_c_strobemeta_bpf_loop.c
@@ -12,7 +12,6 @@
 #include <stddef.h>
 #include <stdbool.h>
 #include <linux/bpf.h>
-#include <linux/ptrace.h>
 #include <linux/sched.h>
 #include <linux/types.h>
 #include <bpf/bpf_helpers.h>
diff --git a/tools/testing/selftests/bpf/progs/pyperf.h b/tools/testing/selftests/bpf/progs/pyperf.h
index 5f093bcf6b58..bfc13cbe70f4 100644
--- a/tools/testing/selftests/bpf/progs/pyperf.h
+++ b/tools/testing/selftests/bpf/progs/pyperf.h
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Facebook
 #include <linux/sched.h>
-#include <linux/ptrace.h>
 #include <stdint.h>
 #include <stddef.h>
 #include <stdbool.h>
diff --git a/tools/testing/selftests/bpf/progs/strobemeta.h b/tools/testing/selftests/bpf/progs/strobemeta.h
index 626a0abacc69..70f2dd03eb60 100644
--- a/tools/testing/selftests/bpf/progs/strobemeta.h
+++ b/tools/testing/selftests/bpf/progs/strobemeta.h
@@ -5,7 +5,6 @@
 #include <stddef.h>
 #include <stdbool.h>
 #include <linux/bpf.h>
-#include <linux/ptrace.h>
 #include <linux/sched.h>
 #include <linux/types.h>
 #include <bpf/bpf_helpers.h>
diff --git a/tools/testing/selftests/bpf/progs/test_core_extern.c b/tools/testing/selftests/bpf/progs/test_core_extern.c
index a3c7c1042f35..a9d07a66122e 100644
--- a/tools/testing/selftests/bpf/progs/test_core_extern.c
+++ b/tools/testing/selftests/bpf/progs/test_core_extern.c
@@ -3,7 +3,6 @@
 
 #include <stdint.h>
 #include <stdbool.h>
-#include <linux/ptrace.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 
diff --git a/tools/testing/selftests/bpf/progs/test_perf_branches.c b/tools/testing/selftests/bpf/progs/test_perf_branches.c
index 05ac9410cd68..731cd75fd452 100644
--- a/tools/testing/selftests/bpf/progs/test_perf_branches.c
+++ b/tools/testing/selftests/bpf/progs/test_perf_branches.c
@@ -2,7 +2,6 @@
 // Copyright (c) 2019 Facebook
 
 #include <stddef.h>
-#include <linux/ptrace.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
diff --git a/tools/testing/selftests/bpf/progs/test_perf_buffer.c b/tools/testing/selftests/bpf/progs/test_perf_buffer.c
index 17d5b67744d5..ba6869a4b008 100644
--- a/tools/testing/selftests/bpf/progs/test_perf_buffer.c
+++ b/tools/testing/selftests/bpf/progs/test_perf_buffer.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Facebook
 
-#include <linux/ptrace.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
diff --git a/tools/testing/selftests/bpf/progs/test_rdonly_maps.c b/tools/testing/selftests/bpf/progs/test_rdonly_maps.c
index 7035fb4d4165..fe4b08b6d1d3 100644
--- a/tools/testing/selftests/bpf/progs/test_rdonly_maps.c
+++ b/tools/testing/selftests/bpf/progs/test_rdonly_maps.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Facebook
 
-#include <linux/ptrace.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
-- 
2.55.0

