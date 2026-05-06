Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D265A4657CC
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073199; cv=none; b=ogh/cdaoRk+FYlJyPLvlC6SkgBj36gfDADQkC5qlEH1GK1sGxsuI2koFxmnivqiBArvtmWqtkOOZ0IlWNsONi/58nm/3X7/xJTtiGnITNfXD3nnzKfenCf+LqDuFbhXshq8JTO9GsZuD3QtcQ0p/seqW5H+1h3Vtw+CCk8eUIsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073199; c=relaxed/simple;
	bh=QzxVOk3M5/EwZZQuNElfS/geVSt/SSXDrm7h6M8IBRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSsD7wJBQHJ5tTc3937zMf9Hi2tZibq0compzCIvFhUg1pkf4gEBFyZfBlTGXSjgRLex23x2MpcBCjvvOwkZsXH71WCHYLJdq+6MQEaDw4OEiGHZBwWc50G0iRj9ZT6R1Q4Kakc1QqnHP6dAGMP4/hoAoi7yUlibrst67MA08uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwkeFYqU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwkeFYqU"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso46041065e9.1
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 06:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778073196; x=1778677996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7mxi36AUDSNCmRMq+u82vZT4p2MaQIjhvJtsS9wru0=;
        b=KwkeFYqUpWw7wAi/TndUL8vpu9yia1yF6MAJxns/MUZcUtnkF02K95Lo3GoAzI9gm6
         W58ciU12kKXM4n+HNsQVjhC+69O5RSC9YsTKYG29jdJdDXfh2Klnz1fNNSGjJqyoB16m
         PTf6btU29IXtl+nwtSG1WLP6oKTRu8h4klKdD8b2hCoQ4CdxjIgBbEeJynwQqcyLHzPO
         I/ZOr8UUIc34sk+aDxBILfb9CR92+8WuxczBNSt/JNRlJBBViw9K+hfkx9/Occ5wMjnQ
         1WVcGMrjWUbBRrZ01N/AMGAM8PuknmYAAK60h2mgyqhRZ4DYeEbpTnlN/UCDQijJgbWq
         TSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778073196; x=1778677996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J7mxi36AUDSNCmRMq+u82vZT4p2MaQIjhvJtsS9wru0=;
        b=VYXRnpNRrRCqL+YeBEOaSbcbcc0rJ4eYYiMeDs5EREKadCyBp0967Ti7PSuV+VTa4K
         TA6GPA+S6r+R5TG+UCS5IlwsAziB+zeYmiCZ+coX4KOQ65sIUiRtAKO68EfcWgl1Jo5S
         ul/hUJ547RE8QZnNd3aQO2fJqRjJfV6mpQmN+G9Y2zEtJiTt8NRCvxjEALXtHhnqmnuA
         XVAwX2XGY6E0kffFUFCRCgL+ja22nCzbtQlwXGZd0e4iK4fAT1sWEeUWK8YDV3JlJi/v
         YegMUaMPBExOSLYUHJVNRdsq5UumzEkWwrOcAKmK4mm2rfj71seEcLq6bkVzYnOEBnxR
         kgMQ==
X-Forwarded-Encrypted: i=1; AFNElJ9PQR4nXlNQ5A45eP8npKHcU/klExG3nGXZPsdwpeLnf4EMIPc1Bc3qOrVAwIAySKMSg4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUSAvZ56OG9NOhATn7qjIo+/oN7uY1aiKAvG93dDxow1paa3he
	sGPiZiVIlEyZ3fFwLs6xhDzUrfbgM/TRGOWaKpzujnRxP4beT4s6fI57
X-Gm-Gg: AeBDiesW2gLgkHQV9pFwHiMwX33x8HCREGA+Qbqo0CpBh+Q9Kgt5N6AvRmxcfQlToHM
	zC/Z/aQ22CbDZjSsmMtAmHz0Icgl9mviG6mLkMujtlONJdogedN5icYWlAHmKUC4DptkulZX5HK
	tUKJqV03Wkj8HnliaEi4CLoWPyEYiUHYFTh+5oPYH42tKq32vvZrwbQWr0AeCkPl7tdsauigjsF
	ImnB/bX48sAsiWsIpInpaKEwyiM/zwh/LY7OIREh1tuIXr7bhoXVzpNlu4Qdmx4Y6XqZqUVl1OJ
	YhPmvmCMhsp+yAzYx4Hr5gT3zM0S2wiNhGEUMVdS1T3PVhAVUnLHH3/rSZRaF2zMHK0++hHibrB
	8HYOaxl56TFh69/zWzIbpdiU25gscgt93a9tdezPL6Jk8QDrTMFm/o/7TkZ+9rEpZUEnJbSPd9W
	JjhlHu2ldWKid2OQe8Lf8pgbFA7UzeFSBKwbsBIdclcSoaLyYBz8KE7EeO0NjsABzxfjuB2DvmJ
	wE5GEibdoJKvcx2XLV/VZJ1+k8680Vh1GuRgV8dcFSQ2iHbhmxITvqHQa9xyI2al4E=
X-Received: by 2002:a05:600c:6095:b0:485:39b2:a47c with SMTP id 5b1f17b1804b1-48e51f48352mr58853625e9.25.1778073196174;
        Wed, 06 May 2026 06:13:16 -0700 (PDT)
Received: from paul-Precision-5770.rd.francetelecom.fr (2a01cb0404624b007a7d1e818d0f651e.ipv6.abo.wanadoo.fr. [2a01:cb04:462:4b00:7a7d:1e81:8d0f:651e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53907a00sm43582655e9.12.2026.05.06.06.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 06:13:15 -0700 (PDT)
From: Paul Houssel <paulhoussel2@gmail.com>
To: paul.houssel@orange.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Paul Houssel <paulhoussel2@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Song Liu <song@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Florian Westphal <fw@strlen.de>,
	"T.J. Mercier" <tjmercier@google.com>,
	Li RongQing <lirongqing@baidu.com>,
	"Paul Chaignon" <paul.chaignon@gmail.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "Stanislav Fomichev" <sdf@google.com>,
	bpf@vger.kernel.org
Subject: [PATCH v2 2/2] selftests/bpf: add tests to verify the enforcement of CONFIG_CGROUP_LSM_NUM
Date: Wed,  6 May 2026 15:12:57 +0200
Message-ID: <20260506131257.713895-3-paulhoussel2@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260506131257.713895-1-paulhoussel2@gmail.com>
References: <20260506131257.713895-1-paulhoussel2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest that verifies the kernel correctly enforces
CONFIG_CGROUP_LSM_NUM as the maximum number of concurrently attachable
per-cgroup LSM hook slots.

The BPF program side (progs/cgroup_lsm_num.c) defines 12 lsm_cgroup
programs, each attached to a distinct LSM hook. The test side
(prog_tests/cgroup_lsm_num.c) attempts to attach all 12 programs one by
one to a cgroup, and verifies that exactly 10 succeed and 2 are rejected,
matching the value of CONFIG_CGROUP_LSM_NUM set to 10 in the selftest
Kconfig fragment.

Signed-off-by: Paul Houssel <paulhoussel2@gmail.com>
---
 tools/testing/selftests/bpf/config            |  1 +
 .../selftests/bpf/prog_tests/cgroup_lsm_num.c | 60 ++++++++++++
 .../selftests/bpf/progs/cgroup_lsm_num.c      | 92 +++++++++++++++++++
 3 files changed, 153 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_lsm_num.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_lsm_num.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 24855381290d..e4c5dd86c640 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -11,6 +11,7 @@ CONFIG_BPF_STREAM_PARSER=y
 CONFIG_BPF_SYSCALL=y
 # CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
 CONFIG_CGROUP_BPF=y
+CONFIG_CGROUP_LSM_NUM=10
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_USER_API=y
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_lsm_num.c b/tools/testing/selftests/bpf/prog_tests/cgroup_lsm_num.c
new file mode 100644
index 000000000000..1c5825c6c3d0
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_lsm_num.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Orange */
+
+/*
+ * Test that the kernel enforces CONFIG_CGROUP_LSM_NUM as the maximum
+ * number of concurrently used per-cgroup LSM hook slots.
+ *
+ *  - load a BPF object with 12 programs each on a distinct lsm_cgroup hook
+ *  - attach them one by one via bpf_program__attach_cgroup()
+ *  - at some point the slots are exhausted and attachment fails
+ *  - verify that 10 succeed attachment and 2 fail
+ */
+
+#include <test_progs.h>
+#include <bpf/bpf.h>
+
+#include "cgroup_lsm_num.skel.h"
+#include "cgroup_helpers.h"
+
+void test_cgroup_lsm_num(void)
+{
+	struct cgroup_lsm_num *skel = NULL;
+	struct bpf_program *prog;
+	int cgroup_fd = -1;
+	int attached = 0;
+	int failed = 0;
+
+	cgroup_fd = test__join_cgroup("/cgroup_lsm_num");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		return;
+
+	skel = cgroup_lsm_num__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto out;
+
+	bpf_object__for_each_program(prog, skel->obj) {
+		struct bpf_link *link;
+
+		link = bpf_program__attach_cgroup(prog, cgroup_fd);
+		if (!link) {
+			if (errno == EOPNOTSUPP) {
+				test__skip();
+				goto out;
+			}
+			failed++;
+		} else {
+			attached++;
+		}
+	}
+
+	// CONFIG_CGROUP_LSM_NUM set to 10
+	// -> 10 programs shall be attached
+	ASSERT_EQ(attached, 10, "at least one attached");
+	// -> 2 programs shall be rejected
+	ASSERT_EQ(failed, 2, "limit was enforced");
+
+out:
+	close(cgroup_fd);
+	cgroup_lsm_num__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/cgroup_lsm_num.c b/tools/testing/selftests/bpf/progs/cgroup_lsm_num.c
new file mode 100644
index 000000000000..0cce61cd7b26
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgroup_lsm_num.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Orange */
+
+/*
+ * 12 LSM programs with lsm_cgroup attachment type, each on a distinct LSM
+ * hook. Used by prog_tests/cgroup_lsm_num.c to verify that the kernel
+ * enforces the CONFIG_CGROUP_LSM_NUM limit on unique per-cgroup LSM hook
+ * slots. With CONFIG_CGROUP_LSM_NUM set to 10, 10 shall be attached and 2
+ * rejected.
+ */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("lsm_cgroup/socket_create")
+int BPF_PROG(hook0, int family, int type, int protocol, int kern)
+{
+	return 1;
+}
+
+SEC("lsm_cgroup/socket_post_create")
+int BPF_PROG(hook1, struct socket *sock, int family, int type,
+	     int protocol, int kern)
+{
+	return 1;
+}
+
+SEC("lsm_cgroup/socket_socketpair")
+int BPF_PROG(hook2, struct socket *socka, struct socket *sockb)
+{
+	return 1;
+}
+
+SEC("lsm_cgroup/socket_bind")
+int BPF_PROG(hook3, struct socket *sock, struct sockaddr *address,
+	     int addrlen)
+{
+	return 1;
+}
+
+SEC("lsm_cgroup/socket_connect")
+int BPF_PROG(hook4, struct socket *sock, struct sockaddr *address,
+	     int addrlen)
+{
+	return 1;
+}
+
+SEC("lsm_cgroup/socket_listen")
+int BPF_PROG(hook5, struct socket *sock, int backlog)
+{
+	return 1;
+}
+
+SEC("lsm_cgroup/socket_accept")
+int BPF_PROG(hook6, struct socket *sock, struct socket *newsock)
+{
+	return 1;
+}
+
+SEC("lsm_cgroup/socket_sendmsg")
+int BPF_PROG(hook7, struct socket *sock, struct msghdr *msg, int size)
+{
+	return 1;
+}
+
+SEC("lsm_cgroup/socket_recvmsg")
+int BPF_PROG(hook8, struct socket *sock, struct msghdr *msg, int size,
+	     int flags)
+{
+	return 1;
+}
+
+SEC("lsm_cgroup/socket_getsockname")
+int BPF_PROG(hook9, struct socket *sock)
+{
+	return 1;
+}
+
+SEC("lsm_cgroup/socket_getpeername")
+int BPF_PROG(hook10, struct socket *sock)
+{
+	return 1;
+}
+
+SEC("lsm_cgroup/socket_shutdown")
+int BPF_PROG(hook11, struct socket *sock, int how)
+{
+	return 1;
+}
-- 
2.54.0

