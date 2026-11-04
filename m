Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755456;
	b=Am0xLftuDgrJAb2wvuE2nGrNYbq0m5XsROc5FtF6P9Wg3SgTZBGhnLYtOiOD1ItYwID4
	 dMBS8ElT436sKEeCqpBxawcJ5jMRaHb29XRrF6dDQg1nn/I1WWG7t84n0vXGsS2CWsGE6
	 5jgev2SpJg4H7Gxo+PW+fjXxHigNjn9YKAC8MDgZF25I/OpYzF5/0XYfDyiPUxckuh7Mi
	 GsVXtzEB7XsWHlSa8xh+GsO25Kx09QOqRbepuM7RRj8JhzNI0HPIb3rFeHQpaJaELSPVf
	 c5PfmbKIuFawNcZDc0LnfHVMfptvyH9LpQ/prwO2HommvS8PB9NKJ0xQnS8moAQrinQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755456;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oqcwJ+E70idEAX4LxAzTaTBzXn1XwAObbukXyIc4yNo=;
	b=oCz3k6xa6akawZNYTdQV2xJhLntMuKBDuKTODOYxvWfUBP7vySACfwK9pdkxGLFiLtgO
	 OGDEKjYfNwY4pUYIKkbF3iuTCfrXwn0OOSNz66SHREblTJOtTJ8TLLOCNfSQlVUxa6X4h
	 maF78+40WiTIHZNJpyHZZE9ejQF6xNS9d+N6bvDd9hkxKxX0FAJQOChlAtbBJWVPmePvP
	 NNTY5HYbS98YwXf+PUv4ZN9ojA2f0aouHKG14l68uzSsgbiY1ExXzDKra2R85jQcPnPEf
	 MtILNy8FHnR+nPoSRiSz1hDS50e4lsYIa/g3ut0PoTfWVhCMhxtR/L/nQZK34qP8vQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pjKF7aDx;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52507606A326
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 01:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52507606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pjKF7aDx
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cdac6d19ddaso80761a12.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 17:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793755455; x=1794360255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oqcwJ+E70idEAX4LxAzTaTBzXn1XwAObbukXyIc4yNo=;
        b=pjKF7aDxkS+BfU09uHDujWSLlFhR1DDLM1XjYUjI8mZ2FTtd/krKP63ScFPou7NZYF
         9g4/H08isWR2LGtbnTZ0Qms/V2/5lFm9ypZQNEgWrrgKWvz94H4gsbMsgy0Cav27q+hk
         KPcRLTyIV77EmvGh23+6qZVoVgYrmAUzPCjjFosH1W10Eb6MCLyF3h/Sf0u4JTLPRZEd
         Kg0dT1BW+A/LHWurxOt+XkIwBo5+dRLDhz/nRyDDbnrMFZxGr2YCnLav3RRNT7QXGjo5
         0gjFQD0071lvKAFMD8ERCAfruwfnV0eBc6GTuMV14oSt0nQHrd9YPYBBcxO5oGVJYKRP
         AOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793755455; x=1794360255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oqcwJ+E70idEAX4LxAzTaTBzXn1XwAObbukXyIc4yNo=;
        b=dFD4URM4fzD5W5Xu5IfBejHJEdeQTlOZo1xjiAKpeFog5GTfALBg2SVTe0uaQ9jjQc
         X63s8k0XVXbwOo2dhRZXmOknYX9AmHdcFdpQG6DcNfp1BsYLuNE6tpxjj/hfxGv9Rm0t
         Tbij2H2Zsq+WBdd+7oUqxZSO/GKyc8xoDo6x99JEHeaQZuwsOCCfNuAuaiQlAFmc4R+y
         ocB0d1CIwJCNjUBHyKdg8aB1ThVXOG9kweinjSSg/BBbtDVc4nzeYlcHV93ySKwyasRx
         KSbcMzREReZJJUO1eAfoCGqLB1a5yrm7hjmGYnqqWbzhmbKzDxpnGFqJWBLlCC3Rbe7Q
         1Cow==
X-Gm-Message-State: APuU4Z/09aOTotcIOhLdonNyoCWEotDkI6KuWkZzFR+mhTmP53txTrdS
	cbZZ8FfnfA13DMvbkj7K7hRlnQPJRyVTRFLg+BcHiZ7nQo0ah9XLANTj7qSI4w==
X-Gm-Gg: AYBFou0Burnk/Eb/s6gD/lzAoOpIuvmNc6B2EOFR1sYh4TCm2m+Xv0M1UzTnigEkwGT
	TcO7kaSmqKX3KCbOnS5fgczVlpnDZ6y8wz3eX4IyWYE7Lj122Z6fjZ/DE6ZLw3fT6DO82PMY9OQ
	WKs5Gx/4B43w2CB0lYvW12cVLhhSpbf2OaZiNtdLTZ8VjlgXMGEh3Lj+d/Q72UXW2/tCOVVJAFo
	9mj+CSp5/1hpNeAOitJ9t0CvhpVE5hb5ljT7r5PobQkgFuoHqisJcE3hFaCb2lMdSuOXzLpZQse
	xsd0SlO9h6cbAlUWNHEOgFdBFV9GW+cnpbYklbPye9Bdg0TgQW/7Lyc0/Ix4O0A38KbAz747s5z
	Qtj1DZseOxmXH3pH5Y1+oGareflBW87EMbIK4IhccqzHbdquvDAcIBgM7gR6PQ6HIYIJOKQiDgm
	kqbwcFhHv385yLBhWEmU+XVib8Dz7q8zePY6H6x85AGv7raO03Mo8355cCkj4L3nMqD35Zf1qX+
	us0T4RrCHwNdmITIiJv0J3QAXDo7wKvxfBS+DSIq87YCB4CypCbXkj2sTMubnT55ABr/zFMLnBi
	G9raofvjv2ZjqN95Hf+YDIW8QKJ2uI2Vjh0KvKhkAre1PfwhIWtFGixJfo4GNOB1TiD8PJzCqcK
	OvCaVkKOG4BEz9YAAGD+RgZtPd+bUSyYeTliQ8hyBYSjubjHWrjMopqZX1Wxo228UobUmKCFDby
	YjY1jgnNqZJv4r/NUcI9WR
X-Received: by 2002:a17:90b:1b09:b0:3ac:8ee5:e00f with SMTP id 98e67ed59e1d1-3ae897d4b06mr11507117a91.57.1793755455453;
        Tue, 03 Nov 2026 17:24:15 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b096994650sm479303a91.2.2026.11.03.17.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 17:24:15 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 02/14] selftests/bpf: Test the default size of arena
Date: Wed,  4 Nov 2026 01:23:48 +0000
Message-ID: <20261104012401.1354861-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
References: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
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

The test declares an arena without max_entries. The kernel rejects such a
map with -EINVAL, thus libbpf must set the size. See
"libbpf: Make arena 4 Gbyte when max_entries is not set".

The test makes sure that:
 - After open, max_entries is 4 Gbyte divided by the page size.
 - The object loads.
 - The prog can allocate pages in the arena.

The test is serial, as the other tests in prog_tests/arena_*.c. See commit
a14f9ba080c1 ("selftests/bpf: Run arena tests serially").

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/prog_tests/arena_default_size.c       | 22 +++++++++++++++++++
 .../selftests/bpf/progs/arena_default_size.c  | 21 ++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_default_size.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_default_size.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_default_size.c b/tools/testing/selftests/bpf/prog_tests/arena_default_size.c
new file mode 100644
index 000000000000..a65b3f8baece
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_default_size.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <linux/sizes.h>
+#include "arena_default_size.skel.h"
+
+void serial_test_arena_default_size(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct arena_default_size *skel;
+
+	skel = arena_default_size__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+	ASSERT_EQ(bpf_map__max_entries(skel->maps.arena), SZ_4G / getpagesize(), "max_entries");
+	if (!ASSERT_OK(arena_default_size__load(skel), "load"))
+		goto out;
+	ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.alloc), &opts), "run");
+	ASSERT_OK(opts.retval, "retval");
+out:
+	arena_default_size__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_default_size.c b/tools/testing/selftests/bpf/progs/arena_default_size.c
new file mode 100644
index 000000000000..1fae38126094
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_default_size.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+#include <bpf_arena_common.h>
+
+/* max_entries is not set */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+} arena SEC(".maps");
+
+SEC("syscall")
+int alloc(void *ctx)
+{
+	return bpf_arena_alloc_pages(&arena, NULL, 2, NUMA_NO_NODE, 0) ? 0 : 1;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0

