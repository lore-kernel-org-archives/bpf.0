Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EEE39856
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 23:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709854051; cv=none; b=Q6oIBwpR0wuQNLQVE5YjUds0ykmo54wGDfBiXX4ihglLrw9hoHUa8LNmDSWYTlhUUavI7IKYsRn1ACVgcMywtjuhC1/vXbAtCToG+im7Tqg8XywDKRg/nKDrrZEnx2JSN4xJDgK+FqNMMIMc8webfXR0en6PDo+2DKZR+0Ps07Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709854051; c=relaxed/simple;
	bh=BWyeWMXrm9Z4GtAbAPQmZ4KO8eRZ5bhhefii0SrRhHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvzJhT9LAS8Llj4H+TjMgWOaUFeYXyDZRIYn8WbcCmlRBSCRuAV0DEqM1jHqoBDXzLfdwxHmhp5f7pepi7z6dIyQl45wIT7oh9aHBKlpUW0ly7olkDDrjZuQzRmVptn6b4FW2hHdLWPaAHXfgmGzAF34I1o63+QYSJZW7kFIjMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 102F8164A1F6; Thu,  7 Mar 2024 15:27:16 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Yury Namgung <ynamgung@meta.com>
Subject: [PATCH bpf-next 3/5] selftests/bpf: Refactor out some functions in ns_current_pid_tgid test
Date: Thu,  7 Mar 2024 15:27:16 -0800
Message-ID: <20240307232716.1117480-1-yonghong.song@linux.dev>
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

Refactor some functions in both user space code and bpf program
as these functions are used by later cgroup/sk_msg tests.
Another change is to mark tp program optional loading as later
patches will use optional loading as well since they have quite
different attachment and testing logic.

There is no functionality change.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../bpf/prog_tests/ns_current_pid_tgid.c      | 53 ++++++++++++-------
 .../bpf/progs/test_ns_current_pid_tgid.c      | 10 ++--
 2 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c=
 b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
index 3a0664a86243..847d7b70e290 100644
--- a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
@@ -16,30 +16,46 @@
 #define STACK_SIZE (1024 * 1024)
 static char child_stack[STACK_SIZE];
=20
-static int test_current_pid_tgid(void *args)
+static int get_pid_tgid(pid_t *pid, pid_t *tgid,
+			struct test_ns_current_pid_tgid__bss *bss)
 {
-	struct test_ns_current_pid_tgid__bss  *bss;
-	struct test_ns_current_pid_tgid *skel;
-	int ret =3D -1, err;
-	pid_t tgid, pid;
 	struct stat st;
+	int err;
=20
-	skel =3D test_ns_current_pid_tgid__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "test_ns_current_pid_tgid__open_and_load"))
-		goto out;
-
-	pid =3D syscall(SYS_gettid);
-	tgid =3D getpid();
+	*pid =3D syscall(SYS_gettid);
+	*tgid =3D getpid();
=20
 	err =3D stat("/proc/self/ns/pid", &st);
 	if (!ASSERT_OK(err, "stat /proc/self/ns/pid"))
-		goto cleanup;
+		return err;
=20
-	bss =3D skel->bss;
 	bss->dev =3D st.st_dev;
 	bss->ino =3D st.st_ino;
 	bss->user_pid =3D 0;
 	bss->user_tgid =3D 0;
+	return 0;
+}
+
+static int test_current_pid_tgid_tp(void *args)
+{
+	struct test_ns_current_pid_tgid__bss  *bss;
+	struct test_ns_current_pid_tgid *skel;
+	int ret =3D -1, err;
+	pid_t tgid, pid;
+
+	skel =3D test_ns_current_pid_tgid__open();
+	if (!ASSERT_OK_PTR(skel, "test_ns_current_pid_tgid__open"))
+		return ret;
+
+	bpf_program__set_autoload(skel->progs.tp_handler, true);
+
+	err =3D test_ns_current_pid_tgid__load(skel);
+	if (!ASSERT_OK(err, "test_ns_current_pid_tgid__load"))
+		goto cleanup;
+
+	bss =3D skel->bss;
+	if (get_pid_tgid(&pid, &tgid, bss))
+		goto cleanup;
=20
 	err =3D test_ns_current_pid_tgid__attach(skel);
 	if (!ASSERT_OK(err, "test_ns_current_pid_tgid__attach"))
@@ -55,11 +71,10 @@ static int test_current_pid_tgid(void *args)
=20
 cleanup:
 	test_ns_current_pid_tgid__destroy(skel);
-out:
 	return ret;
 }
=20
-static void test_ns_current_pid_tgid_new_ns(void)
+static void test_ns_current_pid_tgid_new_ns(int (*fn)(void *), void *arg=
)
 {
 	int wstatus;
 	pid_t cpid;
@@ -67,8 +82,8 @@ static void test_ns_current_pid_tgid_new_ns(void)
 	/* Create a process in a new namespace, this process
 	 * will be the init process of this new namespace hence will be pid 1.
 	 */
-	cpid =3D clone(test_current_pid_tgid, child_stack + STACK_SIZE,
-		     CLONE_NEWPID | SIGCHLD, NULL);
+	cpid =3D clone(fn, child_stack + STACK_SIZE,
+		     CLONE_NEWPID | SIGCHLD, arg);
=20
 	if (!ASSERT_NEQ(cpid, -1, "clone"))
 		return;
@@ -84,7 +99,7 @@ static void test_ns_current_pid_tgid_new_ns(void)
 void serial_test_ns_current_pid_tgid(void)
 {
 	if (test__start_subtest("root_ns_tp"))
-		test_current_pid_tgid(NULL);
+		test_current_pid_tgid_tp(NULL);
 	if (test__start_subtest("new_ns_tp"))
-		test_ns_current_pid_tgid_new_ns();
+		test_ns_current_pid_tgid_new_ns(test_current_pid_tgid_tp, NULL);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c=
 b/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c
index 0763d49f9c42..aa3ec7ca16d9 100644
--- a/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c
@@ -10,17 +10,21 @@ __u64 user_tgid =3D 0;
 __u64 dev =3D 0;
 __u64 ino =3D 0;
=20
-SEC("tracepoint/syscalls/sys_enter_nanosleep")
-int handler(const void *ctx)
+static void get_pid_tgid(void)
 {
 	struct bpf_pidns_info nsdata;
=20
 	if (bpf_get_ns_current_pid_tgid(dev, ino, &nsdata, sizeof(struct bpf_pi=
dns_info)))
-		return 0;
+		return;
=20
 	user_pid =3D nsdata.pid;
 	user_tgid =3D nsdata.tgid;
+}
=20
+SEC("?tracepoint/syscalls/sys_enter_nanosleep")
+int tp_handler(const void *ctx)
+{
+	get_pid_tgid();
 	return 0;
 }
=20
--=20
2.43.0

