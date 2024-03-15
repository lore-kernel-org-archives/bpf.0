Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774081EB42
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528564; cv=none; b=Xjq1u+M961/km70tAUOilkrQ3rgx4+P9z6HUXs4Krq2aHJ6CQJx1zQ33FkEAhE8UXSiGI7hytplcxwjWnS4RoXNmdt116IrT4Mkbsf+3OjAw7CZm08AIYhfJ5Sbyj+0+pO9SLo2397dzpahPZt8oRj8sCGk0rgWI4K6hq+cMnJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528564; c=relaxed/simple;
	bh=GAkzNNwSkQxLNqlkWQt1WO8EvtKPt4h9nDRDsVrP+s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5F0j3Cv5S8JTk1mApE32f5ko+IAry2orLkHZb5h5zYSgmzylPREEgbyYf5m7hws40uOFjrQSA5NNPpewE3p+Km8SDuzxACxumajVgwVJLhFD8NJ9xBnHhCA7fOXolAUIRXbw/bmC3jskVPfh5RZChyUPTLgStYXPskV1Z18RUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 254F31D1E656; Fri, 15 Mar 2024 11:49:10 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Yury Namgung <ynamgung@meta.com>
Subject: [PATCH bpf-next v2 4/5] selftests/bpf: Add a cgroup prog bpf_get_ns_current_pid_tgid() test
Date: Fri, 15 Mar 2024 11:49:10 -0700
Message-ID: <20240315184910.2976522-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315184849.2974556-1-yonghong.song@linux.dev>
References: <20240315184849.2974556-1-yonghong.song@linux.dev>
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
 .../bpf/prog_tests/ns_current_pid_tgid.c      | 73 +++++++++++++++++++
 .../bpf/progs/test_ns_current_pid_tgid.c      |  7 ++
 2 files changed, 80 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c=
 b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
index 847d7b70e290..fded38d24aae 100644
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
@@ -95,6 +140,25 @@ static void test_ns_current_pid_tgid_new_ns(int (*fn)=
(void *), void *arg)
 		return;
 }
=20
+static void test_in_netns(int (*fn)(void *), void *arg)
+{
+	struct nstoken *nstoken =3D NULL;
+
+	SYS(cleanup, "ip netns add ns_current_pid_tgid");
+	SYS(cleanup, "ip -net ns_current_pid_tgid link set dev lo up");
+
+	nstoken =3D open_netns("ns_current_pid_tgid");
+	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+		goto cleanup;
+
+	test_ns_current_pid_tgid_new_ns(fn, arg);
+
+cleanup:
+	if (nstoken)
+		close_netns(nstoken);
+	SYS_NOFAIL("ip netns del ns_current_pid_tgid");
+}
+
 /* TODO: use a different tracepoint */
 void serial_test_ns_current_pid_tgid(void)
 {
@@ -102,4 +166,13 @@ void serial_test_ns_current_pid_tgid(void)
 		test_current_pid_tgid_tp(NULL);
 	if (test__start_subtest("new_ns_tp"))
 		test_ns_current_pid_tgid_new_ns(test_current_pid_tgid_tp, NULL);
+	if (test__start_subtest("new_ns_cgrp")) {
+		int cgroup_fd =3D -1;
+
+		cgroup_fd =3D test__join_cgroup("/sock_addr");
+		if (ASSERT_GE(cgroup_fd, 0, "join_cgroup")) {
+			test_in_netns(test_current_pid_tgid_cgrp, &cgroup_fd);
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

