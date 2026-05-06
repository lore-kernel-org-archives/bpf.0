Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A902DAFA9
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778079960; cv=none; b=pJ74QSnimnFCMiAst2C6cA8c7FWb1PyLP2dKp4ZNdnsw09AtkYXddoB7pgb4929mJZM2KM5kqTNpQwMHbIL0pu/3aLeBdTAht+MD7VHdvBUL0SEsuMqKiD5Gwplp6aN6q1DBHqH2qR+bEjM5BF76GwyGyzj6KQRB/N66X6OTU0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778079960; c=relaxed/simple;
	bh=SVj7M3lTJ0p80+0P/RoWxGQbXgvV6EKrs1/5s8bVP4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1lOEEqsuvLySvFB0TAnB80iOwY9sJfIMNcH8QG7YxzHLu+BBlfVrV2j/TG1vQ37rmwqy4/Vr7QSza4u//uTOdgf2q9DYlrn/AbnSy14NQ41Bg1ypgcI5BZTvV/MfsTPJmoF7k0LXeMU22LpkbmoGQ9F74tpZyqM3c7OhPF+qlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bc55jCYK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bc55jCYK"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4891f625344so11719405e9.0
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 08:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778079957; x=1778684757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Minc+H9TvsimekZ1YcSOtnIlKWCZk8QhETNzWuG89gc=;
        b=bc55jCYKEmUGj9b4BJTV+Rad9YVg3V3KMbjUD/n0ALfCUigSU2OgrpDm+ZO3I7bD/1
         HD6MG9buY/hvbpIoIONfEKCcYYoxqhA+X2HfnGGKp7UXh9oPVrJoo0PxmVxyheytmJID
         nxnhJGyj2PQ/JDoKeRkwu1JgRotCSmmaXcfgYLHbLnkVEvv+LDejqhl0wFtU9NTCQE1s
         2op3PuFXb0tGvJrTtgERntlxBBnV0XpnBbbxus9Te2EOfJ85RsBAlU4UifQET0dI5D/l
         8BksrVuV6jZQNt8BDQYsHACVDkTWgAAfS66+9o1Xzp5rPbZH8K1BEi3rAi7kKLW6I1N0
         YC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778079957; x=1778684757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Minc+H9TvsimekZ1YcSOtnIlKWCZk8QhETNzWuG89gc=;
        b=MAXe6vAlrKChfsU8836tZAX19XxgvF7WfxPa/zvHFq2IO6Yhng0l7mmoptmdnNbmv+
         NTxcV3XeLTizw/G+mHU8jC42uYbEccKynkocn/j2SitRNzqA6zIiMIRx8/qFP/T23BD3
         Zp7YYTpcX0+AJ/24kv5PyXSiDg56SnFE/VnI5kP+dRgr0GBmlCSdXp7f8h/2LkUX7Dgx
         /SVaOnmzHQk33/YgtxAQVMovEFo564hTBJHF2vw6p+2L+XLfYWNI77uws+XbHB/ZUn0W
         XxDUfxAw1zOSwTubwM5Lb/svATmWKOboDTuRUbj9JjdUUVzFS5aK9ejPU4O3WZdrK8yt
         IIAA==
X-Forwarded-Encrypted: i=1; AFNElJ9kUz6eQHoDE1uOyzxC7zrdFl1fd7fKX/r9IGBuRjlnKMk9L6PllSSq6TmClc0aiKOvqT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXW56cXcod+BEA/VxV/qlr6W3qPOJ7m0Bzpy8luqQPrEdOTKNh
	Jn908F5vjiqUo/Pfrtjik0Wd6bIKW6c9i8FymDNGv+Qmm6m4ZYZJrD9B
X-Gm-Gg: AeBDieszilzruSQrd105HvQcif82B/GdBO6kSCJYrqYhXWu4wQ3vgBHHZ3LCEgrsJtI
	+m+SVom8K2sJ4AxsCBk8wQopu0BEa4SdRnSczZ87hK/jJSpU+je07gOn6Am0H4+CQickQXtN4TL
	m5Jt6o4ldLgB7zKigX1ca//Pw/EiG4Ko4epUFeib9Qc/1fx9zacyQ453GaKFnCW9Aoo1JKiE6Fk
	rw4cDF4qWAgHP8hBZLfHlzOZFreZfwIKXgAobHJIV6SWwhrl4QFuk20IK3Z9XaViFsRbugZpJU6
	IVWfC0Q/Hlw0SxX1t0K9bvSFIu08Q8LfLWdqppJPScmbspimVNg++mQpKPDicH0FFfJCNqGtAVo
	6v1z78dhWX8SQ4OCwT4IK42qQTRXj1197NItj1WKqCoKuUwEcq4bovP0Zbz6iBXk75u6EvsnXW/
	514koTHrYrqhQb0vLUvhKSPJ/GWOXyrzbpbAIn94q4eIISqvkv8J1EYK+vjvs3cK1QNM2ot8jqV
	H1BJ0ScZin76M+cOOKBw7S5fwEUJejRgEuzzXzE
X-Received: by 2002:a05:600c:4f04:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-48e522c0032mr47873755e9.12.1778079957193;
        Wed, 06 May 2026 08:05:57 -0700 (PDT)
Received: from paul-Precision-5770 (2a01cb0404624b007a7d1e818d0f651e.ipv6.abo.wanadoo.fr. [2a01:cb04:462:4b00:7a7d:1e81:8d0f:651e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e5312de76sm18382985e9.21.2026.05.06.08.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:05:56 -0700 (PDT)
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
Cc: "Stanislav Fomichev" <sdf@fomichev.me>,
	bpf@vger.kernel.org
Subject: [PATCH v3 2/2] selftests/bpf: add tests to verify the enforcement of CONFIG_CGROUP_LSM_NUM
Date: Wed,  6 May 2026 17:05:47 +0200
Message-ID: <20260506150547.767315-3-paulhoussel2@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260506150547.767315-1-paulhoussel2@gmail.com>
References: <20260506150547.767315-1-paulhoussel2@gmail.com>
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
 .../selftests/bpf/prog_tests/cgroup_lsm_num.c | 60 +++++++++++++++++++
 .../selftests/bpf/progs/cgroup_lsm_num.c      | 46 ++++++++++++++
 3 files changed, 107 insertions(+)
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
index 000000000000..662aee2283c2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgroup_lsm_num.c
@@ -0,0 +1,46 @@
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
+#define LSM_CGROUP_HOOK(name, hook)		\
+	SEC("lsm_cgroup/" #hook)		\
+	int BPF_PROG(name) { return 1; }
+
+
+LSM_CGROUP_HOOK(hook0, socket_create)
+
+LSM_CGROUP_HOOK(hook1, socket_post_create)
+
+LSM_CGROUP_HOOK(hook2, socket_socketpair)
+
+LSM_CGROUP_HOOK(hook3, socket_bind)
+
+LSM_CGROUP_HOOK(hook4, socket_connect)
+
+LSM_CGROUP_HOOK(hook5, socket_listen)
+
+LSM_CGROUP_HOOK(hook6, socket_accept)
+
+LSM_CGROUP_HOOK(hook7, socket_sendmsg)
+
+LSM_CGROUP_HOOK(hook8, socket_recvmsg)
+
+LSM_CGROUP_HOOK(hook9, socket_getsockname)
+
+LSM_CGROUP_HOOK(hook10, socket_getpeername)
+
+LSM_CGROUP_HOOK(hook11, socket_shutdown)
+
-- 
2.54.0

