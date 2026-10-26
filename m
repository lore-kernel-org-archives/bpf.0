Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983687;
	b=hO+U3m9fuI65WDkSdL1FQ3XxdMO29OW78ypojHku+uJjDDiHZhNFKH7Kah0dvajdzZ6i
	 S6B58JlBRy5OQU3vPkdN/d/v53rb1H6ZLvNIDszJonuQeVZIGLz3s/o6kl0ni+aye6l6c
	 XpFNdwhnIH7WL31SiU2jXiTOouy/AFiI/L82uNd0oAhfz/tmKPNJoiQ0rzQ0ExWskcfBh
	 Q1oJZE3m2RB6dCPdce35ckIulvntf0hOSiRfkStNpVuMDZInUlmDMXJJJdp2LXJCB5FSF
	 FbF6myZdXPvUtKMPfxMdqflgCMHSIbHLqbzIsVjv7BzCE1qZg2DaVIpXuii8wkmW90A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983687;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lVE4RWqwuXRo0I+STIlPZNx/szWeCHgqkYceEkrBsj8=;
	b=QpkrVnt+EmPGSgcKbZm7QC+4K2yjRHT4uKqf+WxYUkxMRhzcbHLka4SSYjB5TV5lzDqb
	 xpws4v4c2UdwqBuGGtOZufuqzyf9XiwPPt+FOTGw8z8+Wemm4HbtPy57j/BR64uG0SF/s
	 GYTNhs936yjuHN+b2yQSvwu0jkBzvq3KLZU3cQXdJZ1UGAV3+t8X3DmpbKqLhNd9kyI5r
	 Hk9ij7g7349lgIJRkabqYsxZqUrIw8kCFYQ2uYgplWHWwTWtO+JTdtEm8bTEW8iSGp61X
	 CvFuUpW1SYqvde88F2ZMBEadoqIqsV9uSMR+k7wQ2945h1MmhDmOfqPWK/XVgRdgxVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pJFoQ36y;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24520606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24520606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pJFoQ36y
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd5d2dafeccso776484a12.2
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983686; x=1793588486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lVE4RWqwuXRo0I+STIlPZNx/szWeCHgqkYceEkrBsj8=;
        b=pJFoQ36yoxWu951CJxLvigVSg6oDl9ioBacGYWUjBw7RwePOwCq57Tyn5ulaaCZTz+
         zLjSWpT67YCuJ2aikTPsBjcrCl44uTWbPXuDgPiTF49TrmLe+M8hamCkNDFRcNIyh1X/
         15exhqE7HyO1mVzgbYMSB1vHMHRXw64fL+ewFnJ2P4RSR3uPQdKTt3oxnbVYMXSkjct+
         TH2L3suTI/NiYr2FKGoBzMPIhVq1EhcNq/zEiDr+ut0p5NMePjUQWSRK5Dndg3zvzZfi
         zvONoF9C9zqWFoL1Yw1bpNdwNjRtJvP/pJ85ZDji91HzrQxZ4YQAwnWVEMmFFVJkqBY/
         Enug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983686; x=1793588486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lVE4RWqwuXRo0I+STIlPZNx/szWeCHgqkYceEkrBsj8=;
        b=1d14npjIchY37W46DKzFNMUhtDn+3mX7XrnwI+N9JOL+4ZK80g35G33YUklA71Rkg8
         RHJzMkscfR9Nfp0L6lF1+1Ew/6mWZizTnlBQrIbk6fIXiYwZ32BUF5L+8TXhCeeoC665
         Sv4f6ku6AZBNq+sU6djG8/xGbweX5pVy/o02du+NxM4hnffQ6JyqJsA31kQqIX3TAZcK
         oZNXIe/ozCM6K18kmwoYBmIcsJta36Ie+TwwSYVvI86v8weK4xyEvqRW6F6d27EcG0mN
         8MLmO4+/tpaEpx9wWPQxc3Qyv/SxV3Z4EOzGwRYfbdbPqUgimLVvZ07cyV25A+k2sPpg
         d00Q==
X-Gm-Message-State: AFq9FYIzPKGKI53J6YxatBW3Daw+dpIHGbUx6EasAYcNSPfUdsx+K/F9
	yVz305vNr0PdLv9KS4JYd48QuB+zNkEv8ZnzyD7SBzmfzOCKj4cLQEVcN9+leQ==
X-Gm-Gg: AYBFou2hkZ75yQy/8eBgNrQFp5A0nD1W29Gkw4Xfmjcy2tc79rA9iJu9ydvwf60csPT
	F3VygFWNTa0Nxrpvoe1CCPPs7GTq7QggZ6Y0TFcmwlL3YkgdgjQgy8axEbvv2tp+KjjodefkNHK
	JFa9FZ3D1op0rsHMAPfHxZomeo0DzzQWmJ0mp3m5qVFciWN4qGT2PQeab9TrWLyUxKQdgeqmKrR
	JdgTpC/y1o1VdSGIDXNEVSB0D2esQD6d0RjUxtyo5FJNN6bDN7e4yrwa0pZ9RSByhI3CpCkD+IF
	CpLb+VII9l3vZamHUohF7qnMG9faH0HX4iL1+MDQNgY9nSdrJ+KlR+5wh1Lxs3fK2De3EeBOQaG
	Rkx6HDt/CgfXxJWWd6j0uwFWTehGBVBs1/OvVXNsE1KihE3kgPTBy52yT7rXFHDOli98sn3zhad
	nh/psWZWw7a3SmCCagJ3b9vOCA7y3WfyV6RCocQoA2HALzydc2GWe8zfplnYCyR36jN50huEk03
	etFg8rr6H1Ak5ZOAT74/KJ3oZHdXayjk6rYfl0fV3sRrB03SOLX2yFBBF5z9YD91aCWxLoTW19a
	/SLCciv139LC/4L6ncnWFTTnnX4OwqxiWD9xMhNLoz/ipFmZ1zb6bE+pxgLSD1LQNxnlMkaBYnR
	4xcq8uhXy0rH8QIbwtUMkyD26
X-Received: by 2002:a17:90b:35cc:b0:3ad:1b31:92d8 with SMTP id 98e67ed59e1d1-3adeb16ecffmr4115339a91.60.1792983686531;
        Sun, 25 Oct 2026 20:01:26 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebae7f3csm5169809a91.3.2026.10.25.20.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:01:26 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 17/81] selftests/bpf: Test the default size of arena
Date: Mon, 26 Oct 2026 02:58:38 +0000
Message-ID: <20261026025943.404450-18-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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
"libbpf: Make arena 1 Gbyte when max_entries is not set".

The test makes sure that:
 - After open, max_entries is 1 Gbyte divided by the page size.
 - The object loads.
 - The prog can allocate pages in the arena.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/prog_tests/arena_default_size.c       | 22 +++++++++++++++++++
 .../selftests/bpf/progs/arena_default_size.c  | 21 ++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_default_size.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_default_size.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_default_size.c b/tools/testing/selftests/bpf/prog_tests/arena_default_size.c
new file mode 100644
index 000000000000..0c7efb5c9e5a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_default_size.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <linux/sizes.h>
+#include "arena_default_size.skel.h"
+
+void test_arena_default_size(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct arena_default_size *skel;
+
+	skel = arena_default_size__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+	ASSERT_EQ(bpf_map__max_entries(skel->maps.arena), SZ_1G / getpagesize(), "max_entries");
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

