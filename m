Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60C91C2E
	for <bpf@vger.kernel.org>; Sun, 31 Mar 2024 03:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711856691; cv=none; b=XBMhVhbRhYQCL9mDxnaN+0TGwb31qs9X9eBbZQSyz4qTQZm4Bf+rC/21qWLr4wvzOVr/R3eMXCuWnl6cKLix+ZcEji7XqSKCqxSql6EasJO7W5nluYWjP8rEVkcBYdMiEGDyG4jTuq8qS8nagsKFwco6l0TOB9OgZzTWwp0XEuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711856691; c=relaxed/simple;
	bh=2gk2QUz7Pe9EcZbKhZpiDLgwEAlvYUqAxuquAlzemHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cW1VRg/ZZ19vILVFAGbyucHStVGRpq656BbUybf8kfq2cfTAPIkT/avKCg4LRm1cQHDjDhCEeQ9i8iD2pvPn/4AippFgsNX5G25sv0xs4Y54N30aCczBI8EFySpcI5mBtyxRmtJqQDNrBqJZ/mw3Ce9QIcT+j1/rDXHP2Y1ropc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etU/Bmj/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etU/Bmj/"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e00d1e13acso20720575ad.0
        for <bpf@vger.kernel.org>; Sat, 30 Mar 2024 20:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711856689; x=1712461489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3RorT8LDLGdGitvlFg1jRWV4yHE1BdxHCOgnMOQBFA=;
        b=etU/Bmj/KC9iGeztjUmz/sCYgARa/6Ww+KIz90NzKvjblVXzjhgYLqgFzifITSQYuN
         nUpi+IFfZSZZQzWFe0hqNqC0gH6HvtiKB0GSerjkGtcOr1DeYuZ5pZpum9ip09J5XTze
         cdRb0PxV/bkpLOOhoh5yle+0jFP/BfauNToa8qZUmHfwfs1AR45JJyUH60bNMIqLg7f0
         rtJH9r4GQTb1jy3m9uR882jaXCY3HZcGWsG6PkpGALJWVSjGTx+wYBrAOLs3HHkuF9pa
         yDjOFWoz7LWolc7ELVX9542q4wvqQb+q5OhBPpLnCy/k3NoIJGYEb0tl/PRlq3jD/axu
         7I4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711856689; x=1712461489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3RorT8LDLGdGitvlFg1jRWV4yHE1BdxHCOgnMOQBFA=;
        b=qj0bFcj21Gvdp3YiHlzJ2/TuGOgBL/yJ/kA6goIpSKxZW7hBgpU+GFNLuNfSHER4uY
         v6q8/z9gLeLi3tAAqwyNHgkG0XEUj4c8HU2pHn31YirtSNgUthrY9pqP+PbQLuEwgSbi
         03M8Q9iq9Orv6envzkwfXcpN3hHbGwmrHZ+lzrNrBm/PGJ4J4ctiKbOc9W8vZ5scTINj
         aa4GGgAVT/RxdEnlFkmJcq0SRxeP2iaArpDXbqxej/Pnw9NBbUHip934ZvQ6jqut9QBP
         h9Be46C9Snxet4SLkGnnPkNWjb9FWOK+2BnKq7gaK1CMh9kt1UOxvdgK+akZFbbP3okL
         dTWw==
X-Gm-Message-State: AOJu0YwQrs9Kn8bguVoyMxdqcYqHClCKOGZscB3tfbYUOSkMfpVCYIQf
	yXhux0ZnoBjJdVycDGpSzJwhqwq2KyLRDpQJTwZb8HWWTaeqmUuKkQDxcqf5z578+w==
X-Google-Smtp-Source: AGHT+IFMk+EoFwoZYHLinUyhTLBusGPjBycSdX3l7iFiXLdLOBFto+O+ACgrnhVUAPfBNAy6q1443g==
X-Received: by 2002:a17:902:f304:b0:1e2:a71:a127 with SMTP id c4-20020a170902f30400b001e20a71a127mr5327969ple.49.1711856689070;
        Sat, 30 Mar 2024 20:44:49 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.37])
        by smtp.gmail.com with ESMTPSA id y19-20020a170902e19300b001dcfc68e7desm6030239pla.75.2024.03.30.20.44.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2024 20:44:48 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: Add selftest for bits iter
Date: Sun, 31 Mar 2024 11:41:54 +0800
Message-Id: <20240331034154.16284-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240331034154.16284-1-laoar.shao@gmail.com>
References: <20240331034154.16284-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test cases for the bits iter:
  - bpf_iter_bits_destroy() is required after calling
    bpf_iter_bits_new()
  - bpf_iter_bits_destroy() can only destroy an initialized iter
  - bpf_iter_bits_next() must use an initialized iter

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_bits_iter.c  | 57 +++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bits_iter.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index c4f9f306646e..7e04ecaaa20a 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -84,6 +84,7 @@
 #include "verifier_xadd.skel.h"
 #include "verifier_xdp.skel.h"
 #include "verifier_xdp_direct_packet_access.skel.h"
+#include "verifier_bits_iter.skel.h"
 
 #define MAX_ENTRIES 11
 
@@ -198,6 +199,7 @@ void test_verifier_var_off(void)              { RUN(verifier_var_off); }
 void test_verifier_xadd(void)                 { RUN(verifier_xadd); }
 void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
 void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_direct_packet_access); }
+void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
 
 static int init_test_val_map(struct bpf_object *obj, char *map_name)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
new file mode 100644
index 000000000000..5401b0944ca7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+#include "task_kfunc_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+int bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsafe_ptr__ign,
+		      u32 nr_bits) __ksym __weak;
+int *bpf_iter_bits_next(struct bpf_iter_bits *it) __ksym __weak;
+void bpf_iter_bits_destroy(struct bpf_iter_bits *it) __ksym __weak;
+
+SEC("iter.s/cgroup")
+__description("bits iter without destroy")
+__failure __msg("Unreleased reference")
+int BPF_PROG(no_destroy, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct bpf_iter_bits it;
+	struct task_struct *p;
+
+	p = bpf_task_from_pid(1);
+	if (!p)
+		return 1;
+
+	bpf_iter_bits_new(&it, p->cpus_ptr, 8192);
+
+	bpf_iter_bits_next(&it);
+	bpf_task_release(p);
+	return 0;
+}
+
+SEC("iter/cgroup")
+__description("bits iter with uninitialized iter in ->next()")
+__failure __msg("expected an initialized iter_bits as arg #1")
+int BPF_PROG(next_uninit, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct bpf_iter_bits *it = NULL;
+
+	bpf_iter_bits_next(it);
+	return 0;
+}
+
+SEC("iter/cgroup")
+__description("bits iter with uninitialized iter in ->destroy()")
+__failure __msg("expected an initialized iter_bits as arg #1")
+int BPF_PROG(destroy_uninit, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct bpf_iter_bits it = {};
+
+	bpf_iter_bits_destroy(&it);
+	return 0;
+}
-- 
2.30.1 (Apple Git-130)

