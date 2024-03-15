Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D33B1EB42
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528549; cv=none; b=LfkQQ+mtyZStRoCGaCWI/pYWsLwKxSlR6dqHsfrWC6aJaGZXgaiwZVwxAJpsQSemitbYfYgLd05uHvunAtK0/xb9kXJJhn/84kIjH+2cc3ELE6QJ6I4pzyLdPjM5ukY7Bu8emTl1YbTkcnDDcTXQGOq1Zab2sHYS02t1zLRdtCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528549; c=relaxed/simple;
	bh=bdn2o83kn0QIuxeT+gWYvr7bTb3uemjs7CUit+0tzr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+Oob5zUoTqh5wS6bziLQ+gri5SHkT8AHkiIxg4VTJwnPxfBjIXKdRao5eA2YTGbKRxyMIdM7XRjKZuDHMKZDgBFy+Fxj90YbdHET6N1j8GjIcaxmBMoC4IwNrqwAVquccF6NP7jlGKWNop1D5+KitEiMpMOFlHXfGlXXqDOLGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id CEC951D1E5D0; Fri, 15 Mar 2024 11:48:59 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Yury Namgung <ynamgung@meta.com>
Subject: [PATCH bpf-next v2 2/5] selftests/bpf: Replace CHECK with ASSERT_* in ns_current_pid_tgid test
Date: Fri, 15 Mar 2024 11:48:59 -0700
Message-ID: <20240315184859.2975543-1-yonghong.song@linux.dev>
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

Replace CHECK in selftest ns_current_pid_tgid with recommended ASSERT_* s=
tyle.
I also shortened subtest name as the prefix of subtest name is covered
by the test name already.

This patch does fix a testing issue. Currently even if bss->user_{pid,tgi=
d}
is not correct, the test still passed since the clone func returns 0.
I fixed it to return a non-zero value if bss->user_{pid,tgid} is incorrec=
t.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../bpf/prog_tests/ns_current_pid_tgid.c      | 36 ++++++++++---------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c=
 b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
index 24d493482ffc..3a0664a86243 100644
--- a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
@@ -20,19 +20,19 @@ static int test_current_pid_tgid(void *args)
 {
 	struct test_ns_current_pid_tgid__bss  *bss;
 	struct test_ns_current_pid_tgid *skel;
-	int err =3D -1, duration =3D 0;
+	int ret =3D -1, err;
 	pid_t tgid, pid;
 	struct stat st;
=20
 	skel =3D test_ns_current_pid_tgid__open_and_load();
-	if (CHECK(!skel, "skel_open_load", "failed to load skeleton\n"))
-		goto cleanup;
+	if (!ASSERT_OK_PTR(skel, "test_ns_current_pid_tgid__open_and_load"))
+		goto out;
=20
 	pid =3D syscall(SYS_gettid);
 	tgid =3D getpid();
=20
 	err =3D stat("/proc/self/ns/pid", &st);
-	if (CHECK(err, "stat", "failed /proc/self/ns/pid: %d\n", err))
+	if (!ASSERT_OK(err, "stat /proc/self/ns/pid"))
 		goto cleanup;
=20
 	bss =3D skel->bss;
@@ -42,24 +42,26 @@ static int test_current_pid_tgid(void *args)
 	bss->user_tgid =3D 0;
=20
 	err =3D test_ns_current_pid_tgid__attach(skel);
-	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
+	if (!ASSERT_OK(err, "test_ns_current_pid_tgid__attach"))
 		goto cleanup;
=20
 	/* trigger tracepoint */
 	usleep(1);
-	ASSERT_EQ(bss->user_pid, pid, "pid");
-	ASSERT_EQ(bss->user_tgid, tgid, "tgid");
-	err =3D 0;
+	if (!ASSERT_EQ(bss->user_pid, pid, "pid"))
+		goto cleanup;
+	if (!ASSERT_EQ(bss->user_tgid, tgid, "tgid"))
+		goto cleanup;
+	ret =3D 0;
=20
 cleanup:
-	 test_ns_current_pid_tgid__destroy(skel);
-
-	return err;
+	test_ns_current_pid_tgid__destroy(skel);
+out:
+	return ret;
 }
=20
 static void test_ns_current_pid_tgid_new_ns(void)
 {
-	int wstatus, duration =3D 0;
+	int wstatus;
 	pid_t cpid;
=20
 	/* Create a process in a new namespace, this process
@@ -68,21 +70,21 @@ static void test_ns_current_pid_tgid_new_ns(void)
 	cpid =3D clone(test_current_pid_tgid, child_stack + STACK_SIZE,
 		     CLONE_NEWPID | SIGCHLD, NULL);
=20
-	if (CHECK(cpid =3D=3D -1, "clone", "%s\n", strerror(errno)))
+	if (!ASSERT_NEQ(cpid, -1, "clone"))
 		return;
=20
-	if (CHECK(waitpid(cpid, &wstatus, 0) =3D=3D -1, "waitpid", "%s\n", stre=
rror(errno)))
+	if (!ASSERT_NEQ(waitpid(cpid, &wstatus, 0), -1, "waitpid"))
 		return;
=20
-	if (CHECK(WEXITSTATUS(wstatus) !=3D 0, "newns_pidtgid", "failed"))
+	if (!ASSERT_OK(WEXITSTATUS(wstatus), "newns_pidtgid"))
 		return;
 }
=20
 /* TODO: use a different tracepoint */
 void serial_test_ns_current_pid_tgid(void)
 {
-	if (test__start_subtest("ns_current_pid_tgid_root_ns"))
+	if (test__start_subtest("root_ns_tp"))
 		test_current_pid_tgid(NULL);
-	if (test__start_subtest("ns_current_pid_tgid_new_ns"))
+	if (test__start_subtest("new_ns_tp"))
 		test_ns_current_pid_tgid_new_ns();
 }
--=20
2.43.0

