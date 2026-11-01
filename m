Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793502326;
	b=lEZ+frNbWpehJjtYYfdBEIr7nBRsb2M4hdHAgc53PZZ6qVVfncTp7Durg4weQeXb/bhn
	 lJYdBHJ02CBP6za+Xah0JBZQkZETsIUI4KUPgJKdh6NMLQ5+NdCxTaYNSLFUfdkeVGaHs
	 t29Oujahb5Z9XPKipbu5oQIi3IVq+h75IhJkHoDAQs9vMPEL66QL8Xe4joy7Pm/vWvd8L
	 tJLYDG1A9yzDuDSwqb0uADkLiUMT/wL4Pmdq+rzA4ZPxDjeMnUtvRAY/4wKQ5RdW1CUPg
	 zCWBN4WnjWNu3sAkHrp+MrYuGhdFn06UJlyUO4VmQ/Vdmzh54JMcLK5cq67iB5s5Kfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793502326;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xcX4xC8quZRTuhk6UmtptlLAbuWn/QBxJlHJ0J0Kyrg=;
	b=VHmKXuEBqBBwFwt80XFr02wlbGUOMos/P9dgVhR7qJVZfOXRsliIunxEVADh0AaW/tsP
	 L2tJLo086GMAWvswC6VdAbi141oxMsxfU2F9qEQN1Wn+fHsaUFCNyY8UXg2X3zYHZhoRe
	 OM1s2+iEqiEHC2vU6EPxLqV4c3qaONsqTpCdIJy/8UanE1RqwI/N1R8FjZbSKWFbmFZg2
	 jM4U+N0QgSpHV5f4uWg9UZ/7wgc3hCwCfBEn1GiKelxgfvvmu/AjpgfxHDm2iX6hOLHAY
	 g+V4pUebjWsCGVUNUP3t/xzwzYdUnz4MTFmblXdhahORq4n5EDRCdo8i+Y9Hu3O3G9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BvrdfaBj;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EC9606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 03:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87EC9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BvrdfaBj
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ea138a3497so11361175ad.2
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 20:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793502325; x=1794107125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xcX4xC8quZRTuhk6UmtptlLAbuWn/QBxJlHJ0J0Kyrg=;
        b=BvrdfaBjAg7H8XoQS1xF4MwRohsfBPyekwAd5RWD34H/NxRvZPDlij84EBYkTd9duC
         LOrWFar/IY088UuLWykQaiEGdFhtJSgWadxGrymLJrXgKO6lc8Tn3e5ve+Z04rH4Y+e1
         wZMKisfs3qosPfbjo4JseKzTtzNiYiz2LmMWNgj210gikPhAQ10csyiAIavGsATtDZjP
         zQ+WbuvbN1EQ6wRBq1SQ6q7tgtf9uwcBarnngOgRDhK6ZVk7+GPL9sNkEEeWDGH0Yxnz
         OCBVAXs+hWz4mExXTurFlmUqd+T2rZKMJnkaIyAEf420+A558kIdHNj1qcUGkx3AznJA
         LeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793502325; x=1794107125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xcX4xC8quZRTuhk6UmtptlLAbuWn/QBxJlHJ0J0Kyrg=;
        b=x7xrN+yqOWd6mKrTcn8E4XcIqh3Tm3sXEUFTT6XcFGErXtHVhdSbEm10SeJP48YzkF
         RpEIR6NNCiL8BjY56oLWjvkMwBZEtcQCD6TWZbvuSD+YHQDRi+WR/fewHyqswAdJn3Qq
         Cm7C9tKuSoNfXBkbIM06cIgZLPWoGSn66sQ7FAK3bOBgbzkHJJduFaTqpITKeGQgpIzG
         jOYKq3J2NZeGPxY72yHR7hU6/fqF/+4aD8w8Ue/1uOcnaviHOyMAurBnst1jwv5gTPQD
         YJIX3QOORL82IHy+1VTllIoXVcqRTgjbJ3oEWywFj+8PYA4iW4yv9Ic9/f0oPHPQgesN
         jolQ==
X-Gm-Message-State: APuU4Z/g3F4N9OMgcVigtJMJ/r3KdCVQT1zM8ou2q6rg0DHDtnqOF3X/
	LfpqEBZADhjBjnbCzpAKS0GHBNzLWeHlMKJ6Mvu8Br5gAM7ZlQ4As9yjsBg0sA==
X-Gm-Gg: AYBFou1kQAQEmHsao+MxtajgxEPP3Ym5+/azcgEmfhSYMGA+/WvwFcJEh8zebkqhiVk
	0zECYtbP/5vYLnv+FcUy1TuOVAQFOXj+I/E2WTFETmX07FPx8D4S1txph03ER3OO04CyBoyIDt2
	S11s5tmiG0iXoSoNUCcMYYs4JW6ZaH8GwFPN6nNPwerr2DJbJL3cK6MzKcD4BZ7DGSjlX0PIEwX
	ZRlvXbQoRL0piOTeIpfyniQvyOG5idJeFJ5mKnCocl+J3/V6epmcNSbzBn2l79QeU7bKdV8GUL4
	c4/Uunp76da+JcdJ3sd/3cXUPpcRVon8usnGnEl4ZWpaQjDz30EA9tMf/sIFKIlemd3QttvhO9M
	do1/0o54lR7V/dJn1iBT4gQnzicjOiLX02YcQXTu2DBN4Y/IOKJe2QR5Uio9/1WifTZ9QmNldLl
	03HslO+w8RisZ/xbyy9iulhgCIX490sqinH0CZacynK6hc8X6Z2deKrB9mnB1RTUzri9pY7vDES
	wZTAzm8kY+LHc9I3QA3xWlcBdjeAxh6j2dAwAmoKdWaKqx+p3oG7Ws0kpVSTH2eDDpDE5LwqTBT
	Ho3jXDayg5SXs4UHgvP2vmNVvsnvDtVm8XZO8W17PAds7wlio0hoORi3r6Yqi4aI2EdUHcblq5t
	JhNpDF0uK9krx1V0HH38gZJMWv33cpDy2CHVAtXSW8nH9nvqRE5O2654LZNduhJrZ328h6foAlQ
	==
X-Received: by 2002:a17:902:cf08:b0:2e5:cf33:80ca with SMTP id d9443c01a7336-2eb364e9beamr61532665ad.52.1793502324606;
        Sat, 31 Oct 2026 20:05:24 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39266f42sm17061185ad.40.2026.10.31.20.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 20:05:24 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 02/14] selftests/bpf: Test the default size of arena
Date: Sun,  1 Nov 2026 03:04:58 +0000
Message-ID: <20261101030511.1578690-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101030511.1578690-1-alexei.starovoitov@gmail.com>
References: <20261101030511.1578690-1-alexei.starovoitov@gmail.com>
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

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/prog_tests/arena_default_size.c       | 22 +++++++++++++++++++
 .../selftests/bpf/progs/arena_default_size.c  | 21 ++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_default_size.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_default_size.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_default_size.c b/tools/testing/selftests/bpf/prog_tests/arena_default_size.c
new file mode 100644
index 000000000000..29fa988c1199
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

