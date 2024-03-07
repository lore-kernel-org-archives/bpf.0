Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDB52134A
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 23:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709854051; cv=none; b=DVqHaNG9EjAMOZ2r82aQVKQJxYEv+ZqLxVRoKh2F3tG9oRap8HffKkVgrak+1+zAOF/Pds3J6LuXDjY/OiS6QYTyl06VSQV132V90+A/Fdu7U3d7vwF1ovtkG0/k7x5pV7VMXhFlUq8Ki/LMo1Lmi9qL1oHoTZfPrifZF4bg2FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709854051; c=relaxed/simple;
	bh=co3ocpBBBekY0zdA7aHz6BntD/mAJq5jsfpVxXbbNJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s92wvOiVh7iF1tcr5r6X5nw5LtwwuN6JhPxEt/5RdhwBwEx8RnFTHDsmuLg6nw6/yMVcHBPDTqB47jwnx2t+HH0a1asNZx1eY4N/y96r27F9dXP4SSdDBldBIVv/z8WDO40MCFkW3bSlNRRIQ9Z4vg0eRp8UOu+Xt9uStf89AYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id EAC8A164A225; Thu,  7 Mar 2024 15:27:21 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Yury Namgung <ynamgung@meta.com>
Subject: [PATCH bpf-next 4/5] selftests/bpf: Add a cgroup prog bpf_get_ns_current_pid_tgid() test
Date: Thu,  7 Mar 2024 15:27:21 -0800
Message-ID: <20240307232721.1117597-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240307232659.1115872-1-yonghong.song@linux.dev>
References: <20240307232659.1115872-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a cgroup bpf program test where the bpf program is running
in a pid namespace. The test is successfully:
  #165/3   ns_current_pid_tgid/new_ns_cgrp:OK

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../bpf/prog_tests/ns_current_pid_tgid.c      | 54 +++++++++++++++++++
 .../bpf/progs/test_ns_current_pid_tgid.c      |  7 +++
 2 files changed, 61 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c=
 b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
index 847d7b70e290..a307303e01ee 100644
--- a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
@@ -12,6 +12,7 @@
 #include <sys/wait.h>
 #include <sys/mount.h>
 #include <sys/fcntl.h>
+#include "network_helpers.h"
=20
 #define STACK_SIZE (1024 * 1024)
 static char child_stack[STACK_SIZE];
@@ -74,6 +75,50 @@ static int test_current_pid_tgid_tp(void *args)
 	return ret;
 }
=20
+static int test_current_pid_tgid_cgrp(void *args)
+{
+	struct test_ns_current_pid_tgid__bss *bss;
+	struct test_ns_current_pid_tgid *skel;
+	int server_fd =3D -1, ret =3D -1, err;
+	int cgroup_fd =3D *(int *)args;
+	pid_t tgid, pid;
+
+	skel =3D test_ns_current_pid_tgid__open();
+	if (!ASSERT_OK_PTR(skel, "test_ns_current_pid_tgid__open"))
+		return ret;
+
+	bpf_program__set_autoload(skel->progs.cgroup_bind4, true);
+
+	err =3D test_ns_current_pid_tgid__load(skel);
+	if (!ASSERT_OK(err, "test_ns_current_pid_tgid__load"))
+		goto cleanup;
+
+	bss =3D skel->bss;
+	if (get_pid_tgid(&pid, &tgid, bss))
+		goto cleanup;
+
+	skel->links.cgroup_bind4 =3D bpf_program__attach_cgroup(
+		skel->progs.cgroup_bind4, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.cgroup_bind4, "bpf_program__attach_cgrou=
p"))
+		goto cleanup;
+
+	server_fd =3D start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bss->user_pid, pid, "pid"))
+		goto cleanup;
+	if (!ASSERT_EQ(bss->user_tgid, tgid, "tgid"))
+		goto cleanup;
+	ret =3D 0;
+
+cleanup:
+	if (server_fd >=3D 0)
+		close(server_fd);
+	test_ns_current_pid_tgid__destroy(skel);
+	return ret;
+}
+
 static void test_ns_current_pid_tgid_new_ns(int (*fn)(void *), void *arg=
)
 {
 	int wstatus;
@@ -102,4 +147,13 @@ void serial_test_ns_current_pid_tgid(void)
 		test_current_pid_tgid_tp(NULL);
 	if (test__start_subtest("new_ns_tp"))
 		test_ns_current_pid_tgid_new_ns(test_current_pid_tgid_tp, NULL);
+	if (test__start_subtest("new_ns_cgrp")) {
+		int cgroup_fd =3D -1;
+
+		cgroup_fd =3D test__join_cgroup("/sock_addr");
+		if (ASSERT_GE(cgroup_fd, 0, "join_cgroup")) {
+			test_ns_current_pid_tgid_new_ns(test_current_pid_tgid_cgrp, &cgroup_f=
d);
+			close(cgroup_fd);
+		}
+	}
 }
diff --git a/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c=
 b/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c
index aa3ec7ca16d9..d0010e698f66 100644
--- a/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c
@@ -28,4 +28,11 @@ int tp_handler(const void *ctx)
 	return 0;
 }
=20
+SEC("?cgroup/bind4")
+int cgroup_bind4(struct bpf_sock_addr *ctx)
+{
+	get_pid_tgid();
+	return 1;
+}
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.43.0

