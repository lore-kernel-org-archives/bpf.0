Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB6C3EA93
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 23:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709854055; cv=none; b=ktZNJeW5lwjTrFO78l89zCWdXN+szl7IewFHpfRB3wqS2Vh3BtpBjEQQMJh9e9a1UmPCKJbx/1SYvGjghDxIcIVTmBgFrD0I6G8FnJb8vTThlxQGvuZUnoY3TIcH0Y3GWZO3QtBMht9qBEP+lfZk9v04JC8BjXP6Qyf+qoW7Uww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709854055; c=relaxed/simple;
	bh=19hrDFfEwMHEoblFj8EvO8zaoWaDrVpKmPId0LbLoyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1QnoGKYR0IBdsZfkXfPnLy9KxAI2tGr9FkGJUqNSi/GdTlITLdVyzZFiNMxxmfy3PZoGSp6YMUKW2BRbjZLaP1tN+Ff2EhrYvd6y6CsXFvWIKQrUf7yuXDNLPZbFhQwgbrRpQ6H9ikikus9ES+JAIymAtR2uiAhhr0eUSbNJeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 10413164A24B; Thu,  7 Mar 2024 15:27:27 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Yury Namgung <ynamgung@meta.com>
Subject: [PATCH bpf-next 5/5] selftests/bpf: Add a sk_msg prog bpf_get_ns_current_pid_tgid() test
Date: Thu,  7 Mar 2024 15:27:27 -0800
Message-ID: <20240307232727.1118156-1-yonghong.song@linux.dev>
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

Add a sk_msg bpf program test where the program is running in a pid
namespace. The test is successful:
  #165/4   ns_current_pid_tgid/new_ns_sk_msg:OK

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../bpf/prog_tests/ns_current_pid_tgid.c      | 62 +++++++++++++++++++
 .../bpf/progs/test_ns_current_pid_tgid.c      | 14 +++++
 2 files changed, 76 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c=
 b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
index a307303e01ee..f5d48549738a 100644
--- a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
@@ -119,6 +119,66 @@ static int test_current_pid_tgid_cgrp(void *args)
 	return ret;
 }
=20
+static int test_current_pid_tgid_sk_msg(void *args)
+{
+	int verdict, map, server_fd =3D -1, client_fd =3D -1;
+	struct test_ns_current_pid_tgid__bss *bss;
+	static const char send_msg[] =3D "message";
+	struct test_ns_current_pid_tgid *skel;
+	int ret =3D -1, err, key =3D 0;
+	pid_t tgid, pid;
+
+	skel =3D test_ns_current_pid_tgid__open();
+	if (!ASSERT_OK_PTR(skel, "test_ns_current_pid_tgid__open"))
+		return ret;
+
+	bpf_program__set_autoload(skel->progs.sk_msg, true);
+
+	err =3D test_ns_current_pid_tgid__load(skel);
+	if (!ASSERT_OK(err, "test_ns_current_pid_tgid__load"))
+		goto cleanup;
+
+	bss =3D skel->bss;
+	if (get_pid_tgid(&pid, &tgid, skel->bss))
+		goto cleanup;
+
+	verdict =3D bpf_program__fd(skel->progs.sk_msg);
+	map =3D bpf_map__fd(skel->maps.sock_map);
+	err =3D bpf_prog_attach(verdict, map, BPF_SK_MSG_VERDICT, 0);
+	if (!ASSERT_OK(err, "prog_attach"))
+		goto cleanup;
+
+	server_fd =3D start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		goto cleanup;
+
+	client_fd =3D connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect_to_fd"))
+		goto cleanup;
+
+	err =3D bpf_map_update_elem(map, &key, &client_fd, BPF_ANY);
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
+		goto cleanup;
+
+	err =3D send(client_fd, send_msg, sizeof(send_msg), 0);
+	if (!ASSERT_EQ(err, sizeof(send_msg), "send(msg)"))
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
+	if (client_fd >=3D 0)
+		close(client_fd);
+	test_ns_current_pid_tgid__destroy(skel);
+	return ret;
+}
+
 static void test_ns_current_pid_tgid_new_ns(int (*fn)(void *), void *arg=
)
 {
 	int wstatus;
@@ -156,4 +216,6 @@ void serial_test_ns_current_pid_tgid(void)
 			close(cgroup_fd);
 		}
 	}
+	if (test__start_subtest("new_ns_sk_msg"))
+		test_ns_current_pid_tgid_new_ns(test_current_pid_tgid_sk_msg, NULL);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c=
 b/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c
index d0010e698f66..386315afad65 100644
--- a/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c
@@ -5,6 +5,13 @@
 #include <stdint.h>
 #include <bpf/bpf_helpers.h>
=20
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 2);
+	__type(key, __u32);
+	__type(value, __u32);
+} sock_map SEC(".maps");
+
 __u64 user_pid =3D 0;
 __u64 user_tgid =3D 0;
 __u64 dev =3D 0;
@@ -35,4 +42,11 @@ int cgroup_bind4(struct bpf_sock_addr *ctx)
 	return 1;
 }
=20
+SEC("?sk_msg")
+int sk_msg(struct sk_msg_md *msg)
+{
+	get_pid_tgid();
+	return SK_PASS;
+}
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.43.0

