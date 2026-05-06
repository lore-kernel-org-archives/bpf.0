Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE42342509
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 06:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778050290; cv=none; b=PbWBtUuJm38jWZNNyNQszdA8BP59nO4o9AfT/dIS3g13unQZjPmhvxraIwnSdb+wZT7f7FhYNzgLVKypjFXzXjbh3rS0tEb7Z/7iLl2AznAgFAVFRuc4kKwv5UwzlyRgr+QnGX3tyMwGAqsIYHjH8orHnJnyAdefMSETHGXtaAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778050290; c=relaxed/simple;
	bh=j2fEFQAMhb1FyAJRn6Ert0+fOQmCjS1/aZ/A+ytMH0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQQ1YtiY7wWc93jpiwDgE7GI5iTTALKzo13+Ew6OF56iQ2pqnC+D5IU+MIXt0+5nRLS+8ejjQSenWLyf+vZsTWjfBY/X+4LraYjuJ1hnjE/kOjcEIuI08DyQeJ4hlMVyU+9JHIhJASkFW/jUC/JJf1eSazgfww38LG/GmYuNpog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BL4OTI7R; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BL4OTI7R"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48d146705b4so19844085e9.3
        for <bpf@vger.kernel.org>; Tue, 05 May 2026 23:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778050288; x=1778655088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OESgNjGzW0y+1dWjrOsZJcDjfw2ymtsTRPxE4EJjlkY=;
        b=BL4OTI7RWg1bvNhB4oHa+pRwXA0aHzEafgNnTMrrMx2e0Xy/vYf/7/0GR4yMZ9qGPo
         f7CjnpSNv8ngQlMlsN5NfAWOsdUJjSiBc4VQ47uetXFUzXt9MFhz+d/6RDuDmkCWAdWq
         b9BHX3JT06BVUqNWp9ziT4UZT7jpCt9Q/OrOnGDGCrd7wwWZvTmErXtLVfUctwKC4Mgd
         9ZL9fhwn8rbpMJn+yy16mUB6ngR4rqPwlGrwbSK2/QrT+bWreXDz6A9JRSOXFlHlVwZY
         r3uaQC91kSBE/jm5oJggPY9LznaBMtqipErEXWuDD80e3FSK7TLiNiW1XOJqx4S9bJSS
         hy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778050288; x=1778655088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OESgNjGzW0y+1dWjrOsZJcDjfw2ymtsTRPxE4EJjlkY=;
        b=bUNhGPS13tEZbO0oIV/ZhhX0e9d1Zw55NawCFmL7qa5/VjOOllNTSZz0Rewm6YeHww
         3qJlT/5iDl+xa+MChTS/D+JaFpdjZRoDGc088yDgjNf8qcv2h08mZuyZTr+RL+RfxgWF
         Ll/akucnwv864ywtWtQ1B4897RlZiFkM/jtJWS0kDA2SmUVWEwJxt3CoFSGxArQ3ZjWb
         KwkgI4TSkrBSJC09KbQE4T+8VUZkL6B3cWEe9WoKiiNm0mNXmyng3BrugcYQ6dpe/dxY
         bJ6MB5ndfCITsm/FFrwzyq2Dmq3byQdurg0yp/eYCR9crLho0S+lagjgFzf3YppLDg+Y
         IjYg==
X-Gm-Message-State: AOJu0Yx4O82cRcT1Rh1j1XY488ha+CdtMbTUgwD0MOP1DzrzJ5bsKL2P
	khUyHg84GBgsiuHH+F6iaBBgFPOcXTcQkoeoEFQfYQOnZdjOYJcZesJ6
X-Gm-Gg: AeBDievNE/AbzaqS+0hDeJ7zShOSNIRtGo0X+C4eLUQgyZWdNqj/gS1uNNnZew8jkZH
	TwRiydrG8o8Fw0TlG3egz21zV4jGCvFl7AORGn8gxjmnZXVIdht8vCmJw5WyNPN1g6vTM4Umrlo
	R3JIVOvsGN9DJadS4XwM62OwItMyl7RYqQ/vT8OPLfSgkXv4roCcK+T7Y67ZGuRmiF9nV/Umq2O
	Boz7DB1etgUaQ+8o7NuxOrYyAdwQ/ushL/85cxH6Zo1Yk/+j5PVhsMvW8A2IQyKLh5qje8gSZ/I
	3W1zmY+01CsttrLO0fQxPbh/owPSUFH06wfDFwzHriOGdVMauROuU3006/A4uHjdgTgoDnKV2an
	gyozdaPquZGx8omLcfZaiiu6uHC88hdV+mWP9Zl/ZssfQw7VRkbcv3EbSr2iOwTdzhb+eDhz06g
	9tlUl88vOd5bhBsLOvUhLHKHob51/7TLktvP6D4aK/KzwhmBWje+s0Wuc0vTYvnCzj14/HmITK8
	cI0xz/Ztc1NvXBB6UPFFmT+1VYHUhcmDa70ECDJ
X-Received: by 2002:a05:600c:354b:b0:485:7f02:afd5 with SMTP id 5b1f17b1804b1-48e51f427bemr35640695e9.13.1778050287798;
        Tue, 05 May 2026 23:51:27 -0700 (PDT)
Received: from paul-Precision-5770 (2a01cb0404624b007a7d1e818d0f651e.ipv6.abo.wanadoo.fr. [2a01:cb04:462:4b00:7a7d:1e81:8d0f:651e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538aca14sm23526775e9.7.2026.05.05.23.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 23:51:27 -0700 (PDT)
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
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org
Subject: [PATCH 2/2] selftests/bpf: add tests to verify the enforcement of CONFIG_CGROUP_LSM_NUM
Date: Wed,  6 May 2026 08:50:48 +0200
Message-ID: <20260506065048.592474-3-paulhoussel2@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260506065048.592474-1-paulhoussel2@gmail.com>
References: <20260506065048.592474-1-paulhoussel2@gmail.com>
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
2.53.0

