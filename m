Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43C83C3C07
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489646; cv=none; b=GiVsz6ENWni+Jnk6d0tQfQsRJwEA3HlWjdSCMJs/KVIXU5p0/srFpeN4PrJhyOEwg1if0/5fHfDgZoqr6/ZhDM9+KNvwrNRNKrLTSKasCVslKmG461PHSBA7t/UkNbl5yVXKXU8eU8DMfGaajLZeRkY8MrknP1dQ3rkb55zWVrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489646; c=relaxed/simple;
	bh=l9FhgUup7JyxXAaU+GdYvOL1ofHHzUDemJ2Ds7tk9io=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=txBtJ4wnvHz7tCqnlTHnLuQlFggf+fZ/8fBMxRnenCcB8nRY0ZVmcnoBE7FKmq3lWoPPukLC/OzXbSInhgpzhEn0vChPW6We43b4hipN9p1YAafLfaFq0duBTB61RpyXqhQ6K+sg7cgqlyTn0ya3PAH+uI9ZmN6BEoiOfBZrlug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPRjWQ3x; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPRjWQ3x"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44e5624c053so2231681f8f.2
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 01:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778489643; x=1779094443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdlvC/5zPWTNK2siNpEsfFOntCnyMwV2OZK4x7LSA3c=;
        b=dPRjWQ3x4CiAYbnbqEby3zrEqCnEYc5184SoRaz15S1B+chMI8R4aShF8ny0WQE3xz
         VrUy/1jTRbvh9/qRSYR1k7+sAEmVGZOGk5oYMuZchQeErQrlYeBfGlMksWtYJPUZDDOU
         8YT72VEJolpqfgAu6oDsO7AmXj9zhx0w6K6B79B4hmYfCF0B4T0LMT2K1xh2hAZXa2yH
         8ZpHEtkvhfjdlFekbESLT/oY0MAcR+tU+0OtsVSDxg1VLK0LrhwJo40KK8SbVRuE/CPe
         ILnqqhk5JiLRjSxmOwYC4hC3swZE1Ep97FwH3xIhxVOJxYGO/IW2Mzz4vHu2BSUFbs57
         wmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489643; x=1779094443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AdlvC/5zPWTNK2siNpEsfFOntCnyMwV2OZK4x7LSA3c=;
        b=WgSKp1dYRaBcRBcap4R5qDQnSfMU6yB98LfK8BrBsvTmUc90hzLQ6AaXD/CUB36i39
         CEpK4XdFvVQuhwSKE2lvrtEnN0EDFQOmc9aqlzJ8P4Lji0n44CgUu/20YG5eWFNFVFjg
         joohakLwixdsmoNjUnDQPSs/Y3riur8tiaVIHXBTozubiYmIpKkrcYvRkdYze+9CotKv
         IktjLr5f8Zodt0WmDZn6ItrrBgCK76dDVGtKDjEpXSq3EEwwFSdCClE7gWAJVK2WQQ9p
         u8qvjs5OQ1v/nAdKPNJvZpYU15iWIXzfz1u4E6WTF5/sXHuIbwobj2G3NRFIMzQALJjv
         3L/g==
X-Gm-Message-State: AOJu0YziqSxB5DunHIitTFL+AHezp/xMyojbWJ8+kSJtmHUSqO884Aa4
	aH4tpTdYej7ZkVBqwjzij7S85ll2GHHSPDXIDEw1CJaK482bUowM4T5m6Yww09Pn4Gs=
X-Gm-Gg: Acq92OF80opU8FTOu0cgRq3kPklErGbjkW/tf5NkJ3hifFbxaog3OdiNEWVGpACbKaM
	xvsiKD/qnAyt4gznbp6ZFzRDjy+Xx1oUADHqXZ7usFPUxEcEtR25AaYn+BK6/DXoY1j5gncs9ko
	JbnNkRWe4Zwiq3oD1vOZnqFXKmyxD7o/Aop9k2wVTRj5CK3T+D6kT9uh3Lbm18OeXKWtLdDk1l5
	GdhPs9qmhfKBF13zOZlQmHM9PQF9kMC/EmrRhWJtDF5oep89y/SOMzt0quo/fNO+cvbwKMi5OtV
	qKBfoTVxcjmzvNXf84C4uFSxr6zXwR4b2W3B9t/CgzXMbNwydL3Jc9LQ6rfmzWfIE3F9QGlMsxY
	zyRVRntt8pv3RGoqSFSeAv/xiiHEcMyQFqH3sXGw6AF4kuEIo2tzV0It5OyHJaV770z0bspHndW
	TUvNWrHO8ScRKffGkIjZdTpOIoGCE=
X-Received: by 2002:a05:6000:4381:b0:44f:ba97:6d8c with SMTP id ffacd0b85a97d-4515ce1c7f9mr36575388f8f.23.1778489643108;
        Mon, 11 May 2026 01:54:03 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-454919c13c9sm23817156f8f.27.2026.05.11.01.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:54:02 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	liamwisehart@meta.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH v1 4/4] selftests/bpf: Add netpoll setup basic tests
Date: Mon, 11 May 2026 08:53:44 +0000
Message-Id: <20260511085344.3302-5-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511085344.3302-1-mahe.tardy@gmail.com>
References: <20260511085344.3302-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a pair of BPF progs, netpoll_release and netpoll_acquire to test
that the respective bpf_netpoll_release and bpf_netpoll_acquire behave
as expected and that the verifier has been configured to catch
unreleased references.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../selftests/bpf/prog_tests/netpoll.c        | 23 +++++++++
 .../selftests/bpf/progs/netpoll_basic.c       | 47 +++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/netpoll_basic.c

diff --git a/tools/testing/selftests/bpf/prog_tests/netpoll.c b/tools/testing/selftests/bpf/prog_tests/netpoll.c
index eac0378c426a..daea1068a739 100644
--- a/tools/testing/selftests/bpf/prog_tests/netpoll.c
+++ b/tools/testing/selftests/bpf/prog_tests/netpoll.c
@@ -7,15 +7,38 @@
 #include "test_progs.h"
 #include "network_helpers.h"
 #include "netpoll_sanity.skel.h"
+#include "netpoll_basic.skel.h"

 #define NS_TEST "netpoll_sanity_ns"
 #define NS_TEST_V6 "netpoll_sanity_ns_v6"
+#define NS_BASIC_TEST "netpoll_basic_ns"
 #define DUMMY_DEV "dummy0"
 #define DUMMY_IP "10.0.0.1"
 #define REMOTE_IP "10.0.0.2"
 #define DUMMY_IP6 "fd00::1"
 #define REMOTE_IP6 "fd00::2"

+void test_netpoll_basic(void)
+{
+	struct nstoken *nstoken = NULL;
+
+	SYS(fail, "ip netns add %s", NS_BASIC_TEST);
+	SYS(fail, "ip -net %s link add %s type dummy", NS_BASIC_TEST, DUMMY_DEV);
+	SYS(fail, "ip -net %s addr add %s/24 dev %s", NS_BASIC_TEST, DUMMY_IP, DUMMY_DEV);
+	SYS(fail, "ip -net %s link set %s up", NS_BASIC_TEST, DUMMY_DEV);
+
+	nstoken = open_netns(NS_BASIC_TEST);
+	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+		goto fail;
+
+	RUN_TESTS(netpoll_basic);
+
+fail:
+	if (nstoken)
+		close_netns(nstoken);
+	SYS_NOFAIL("ip netns del %s &> /dev/null", NS_BASIC_TEST);
+}
+
 static void run_netpoll_test(const char *ns_name, const char *local_ip,
 			      const char *remote_ip, bool ipv6)
 {
diff --git a/tools/testing/selftests/bpf/progs/netpoll_basic.c b/tools/testing/selftests/bpf/progs/netpoll_basic.c
new file mode 100644
index 000000000000..2650e1e5410a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/netpoll_basic.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "errno.h"
+
+SEC("syscall")
+__success __retval(0)
+int netpoll_release(void *ctx)
+{
+	struct bpf_netpoll_opts opts = { .dev_name = "dummy0" };
+	struct bpf_netpoll *bnp;
+	int err = 0;
+
+	bnp = bpf_netpoll_create(&opts, sizeof(opts), &err);
+	if (!bnp)
+		return err;
+
+	bpf_netpoll_release(bnp);
+
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("Unreleased reference")
+int netpoll_acquire(void *ctx)
+{
+	struct bpf_netpoll_opts opts = { .dev_name = "dummy0" };
+	struct bpf_netpoll *bnp;
+	int err = 0;
+
+	bnp = bpf_netpoll_create(&opts, sizeof(opts), &err);
+	if (!bnp)
+		return err;
+
+	bnp = bpf_netpoll_acquire(bnp);
+	if (!bnp)
+		return -EINVAL;
+
+	bpf_netpoll_release(bnp);
+
+	return 0;
+}
+
+char __license[] SEC("license") = "GPL";
--
2.34.1

