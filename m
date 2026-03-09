Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EE53C1987
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773062234; cv=none; b=QHStAWgKflgvWj4exTaq49nJldaYZ1z/h6WNzDpqDAd9hB/+2rfWXWBYRIHuT40ZCLovd3iP7y71IYC+DcB1Ujawp4iiWQGHAQGrsBdOuZD1bI5canK93Slf9cv7ELTAGdQ8HwaRETgFELENpTPXZJQC7rcir53m3w7h9T20yZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773062234; c=relaxed/simple;
	bh=tyqCYxKTSRXXn5P+KvgoIOclP8HpyE+FZaE7u6Ktvvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q5CsjXO5kSZgGal/AvFQCNmF6V9zElTnnXdIOTVTitozim9CV5BPHYuWlzAOXVOt9zvqioUoDXXNPos/CzLMGRk1E1P51Mg/XDAef8Zu7YPi6du33rEAaJ5Tqn9X3tN6DuQN4tzCYUtULpV7q64YCDKnFWKLut93V456Din8EtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWJL/4w4; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWJL/4w4"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4853fd7b59aso3368735e9.2
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 06:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773062231; x=1773667031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L40ZBRJFw2dpBSHTfqlpum+bTSTo7kvXGM5RPcNlnO4=;
        b=OWJL/4w4W945zzgLJvGbn1t+qEEtK6v2X3CMmLwJoRE7M6HqpQLWhWDIUIEz0bxjLM
         h+h+QwXJu/L1Vm0ex/nsT7xzzziUSI4qS+y2uMRR7mESwCJUjiIdhSwzz58MstY05Kg3
         n3zhaZNrkkDaLyaR8GEMChY0rEnLFNLpubrVSKWrsWngjsQgLXQo2eh7y+4um2xVp/y3
         ecH4jJFGgDdzC+tJ9N0uRgG/8YzA4RlyFTTapaQ0H/xEys+Jt6N2V8MiTkS2/4OKkTLj
         y2A79Ly62cgPb0sfetdb3crOgcrHQWOZeYKX9qpA6rvaonwxHSG+3xfefezVTm62prZD
         UiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773062231; x=1773667031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L40ZBRJFw2dpBSHTfqlpum+bTSTo7kvXGM5RPcNlnO4=;
        b=OoqXpJ1842sgFUTmYa4KELj397aoMn+Hh62bKGn59EZLKLQ2THn/9IvFRNjdrmbE7j
         pWZHXWN2TYcAsfI5q0lo8lbwUBZvd4sQCGgkp+CnJijLwxfV3K3IBxwzx1bBSSF5J01w
         hVLRXWjXcZhDJKCppv4neEuf/p1ownLwMWjXk/33H5cfCxFzfhvoHdjdRXS3lPmfoVOT
         5hY6r1OKvONASOTPBHu4SnAtRrXlLcefmeSqCULWsES2UaCNyG1NmNwbBGLF46OkyZ/s
         20ZWc2W/RVBA+qE9YpVxGRHyNePzSjTYwUw+PUXGmFfXowk/mKyyXLRU4CHe0TaFXups
         HIkA==
X-Gm-Message-State: AOJu0YxXfcLC8JszyTmINX8zR6epxc72qbuomOR3CLheQlC7KA1bzbDT
	pAf29glr1jzUp9DVFNy3R7j4y1VWDw/O/qI5rUnnpHaLWtu6OAXHPCJmA+I29srFhLCnaQ==
X-Gm-Gg: ATEYQzyiF+pbuhkTsZy9sjv5iXmyL/OPJ39g57KDPoqAe7Uu0ZQLTZ7rRHcSP5sq/Mp
	+wq8Xj2/ZrMyOf3AYLGPZ4o6LcJeXcLnhKRmbWPRv/LfQN+APGpych+rDN76rTgG8Gt4GEY1tRq
	S+1blLCWlVC0bCyRSJHjzHU9vE4PLurHY7C6xqLu5Ph704Q9z1IcQWh/mpy+M+oUJPIH/IDKC2F
	84VA+0iOA4AIm5eVYIpVhJkb/A6M7Fw1pL9pj6FD+QLCVfJHMcNWphrViqdlaCHW7DtCbAR6tuG
	WpHxhe2VIw8KLgwS2d/uCudTv75MsahFctT09YkEpzrRDV+juaQ1hl0TMdjoYZqknrmIisWhNCR
	CDXjWJHTdsVqCoDkb+GNcCheMTKBZb/taEp+OTCjbnBiXN+mGTUKW15qEZIXkhEZo7ZSHabCmbr
	JyVZvJ7esrO1+s+hQSl4f1jMazf7A=
X-Received: by 2002:a05:600c:3b02:b0:485:2f4a:6ae6 with SMTP id 5b1f17b1804b1-4852f4a6de6mr112906975e9.6.1773062229457;
        Mon, 09 Mar 2026 06:17:09 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-485246ece8bsm128506395e9.4.2026.03.09.06.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 06:17:09 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [RFC PATCH bpf-next 4/4] selftests/bpf: Add netpoll setup basic tests
Date: Mon,  9 Mar 2026 13:16:35 +0000
Message-Id: <20260309131635.302424-5-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309131635.302424-1-mahe.tardy@gmail.com>
References: <20260309131635.302424-1-mahe.tardy@gmail.com>
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
index f2548f1f9349..af40c4b21be7 100644
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

