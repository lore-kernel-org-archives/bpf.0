Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989053AFD08;
	Wed, 10 Jun 2026 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781093891; cv=none; b=QAVei+TjHn2DhhJZcr7tEuDy1/rEUKmmICG6smcObsMetr4Lwd8m8crf6TCh2YIhFSpaLfFxWfw9t2eujtd8kc2yGGyIx6broIIErVAf9jWpSOiKXvh3HLXM8BxQj4/sn4wb/mgKNsBwUhnjE0TMehyA+35mEXJlb+9QuT85uZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781093891; c=relaxed/simple;
	bh=RHuwx3BUfcsITY8wOhIkHMLU3Mwz8lrXsuFqvjDc7nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKSIC0ey8IemvBCYpEKeILWkgMHXGVPMEYcPQqTvIVO4dJ16nu0rs8NAl+mlwpbwmPAZDvM0YhJSmBbpRRusiV6OqrnUvqt0FhvCciLg0ChraJv50VkV0TqLWjFSa3Xd31QzS9yJrTXFvWPkUuhC17f0D4ur8heU33J4ESNrZeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gb4Xl6pmjzKHMS2;
	Wed, 10 Jun 2026 20:17:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 10C0E40561;
	Wed, 10 Jun 2026 20:18:05 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP1 (Coremail) with SMTP id cCh0CgAXZzz5VSlqXFgyBQ--.57310S4;
	Wed, 10 Jun 2026 20:18:04 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Matt Bobrowski <mattbobrowski@google.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add retval test for bool and errno LSM cgroup hooks
Date: Wed, 10 Jun 2026 20:17:24 +0000
Message-ID: <20260610201724.733943-3-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610201724.733943-1-xukuohai@huaweicloud.com>
References: <20260610201724.733943-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAXZzz5VSlqXFgyBQ--.57310S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw4fCw4rAw1DAF1xGrW5trb_yoW7CF48p3
	WkCFyj9w1rJas0gr4rK3y2gFWIya18Ww15JrZrGr1xZwsrJrn3tw1Ika45tFy5KFZxXws5
	uryavr98uryUtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x0262
	8vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
	CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
	daVFxhVjvjDU0xZFpf9x07jsL05UUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Add test to check the return value when a BPF program exits with 0 for
a boolean and an errno LSM hook.

For each hook, two BPF programs are attached. The first program returns
0 without calling bpf_set_retval() to exercise the return value translation
logic, while the second program reads the retval via bpf_get_retval().

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 .../selftests/bpf/prog_tests/lsm_cgroup.c     | 79 +++++++++++++++++++
 .../testing/selftests/bpf/progs/lsm_cgroup.c  | 30 +++++++
 2 files changed, 109 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
index 6df25de8f080..41e867467f6c 100644
--- a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
+++ b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
@@ -2,6 +2,7 @@
 
 #include <sys/types.h>
 #include <sys/socket.h>
+#include <sys/xattr.h>
 #include <test_progs.h>
 #include <bpf/btf.h>
 
@@ -309,11 +310,89 @@ static void test_lsm_cgroup_nonvoid(void)
 	lsm_cgroup_nonvoid__destroy(skel);
 }
 
+static void test_lsm_cgroup_retval(void)
+{
+	struct lsm_cgroup *skel = NULL;
+	int skipcap_prog_fd1, skipcap_prog_fd2, socket_prog_fd1, socket_prog_fd2;
+	int cgroup_fd = -1;
+	int err, fd;
+	char tmpfile[] = "/tmp/test_lsm_cgroup_retval.XXXXXX";
+
+	fd = mkstemp(tmpfile);
+	if (!ASSERT_OK_FD(fd, "mkstemp"))
+		return;
+	close(fd);
+
+	cgroup_fd = test__join_cgroup("/default_retval");
+	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup"))
+		goto cleanup_tmpfile;
+
+	skel = lsm_cgroup__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto cleanup_cgroup;
+
+	skipcap_prog_fd1 = bpf_program__fd(skel->progs.skipcap_first);
+	skipcap_prog_fd2 = bpf_program__fd(skel->progs.skipcap_second);
+	socket_prog_fd1 = bpf_program__fd(skel->progs.socket_first);
+	socket_prog_fd2 = bpf_program__fd(skel->progs.socket_second);
+
+	err = bpf_prog_attach(skipcap_prog_fd1, cgroup_fd, BPF_LSM_CGROUP, BPF_F_ALLOW_MULTI);
+	if (err == -ENOTSUPP) {
+		test__skip();
+		goto cleanup_skeleton;
+	}
+	if (!ASSERT_OK(err, "attach first skipcap prog"))
+		goto cleanup_skeleton;
+
+	err = bpf_prog_attach(skipcap_prog_fd2, cgroup_fd, BPF_LSM_CGROUP, BPF_F_ALLOW_MULTI);
+	if (!ASSERT_OK(err, "attach second skipcap prog"))
+		goto cleanup_skipcap1;
+
+	err = bpf_prog_attach(socket_prog_fd1, cgroup_fd, BPF_LSM_CGROUP, BPF_F_ALLOW_MULTI);
+	if (!ASSERT_OK(err, "attach first sock_create prog"))
+		goto cleanup_skipcap2;
+
+	err = bpf_prog_attach(socket_prog_fd2, cgroup_fd, BPF_LSM_CGROUP, BPF_F_ALLOW_MULTI);
+	if (!ASSERT_OK(err, "attach second sock_create prog"))
+		goto cleanup_sock_create1;
+
+	/* trigger the bool hook by setxattr */
+	err = setxattr(tmpfile, "user.test", "value", 5, 0);
+	if (!ASSERT_OK(err, "setxattr"))
+		goto cleanup_sock_create2;
+
+	/* trigger the errno hook by creating a socket */
+	fd = socket(AF_INET, SOCK_STREAM, 0);
+	if (!ASSERT_OK_FD(fd, "socket"))
+		goto cleanup_sock_create2;
+	close(fd);
+
+	ASSERT_EQ(skel->data->skipcap_retval, 0, "bool_hook_retval_should_be_0");
+	ASSERT_EQ(skel->data->socket_retval, -EPERM, "errno_hook_retval_should_be_EPERM");
+
+cleanup_sock_create2:
+	bpf_prog_detach2(socket_prog_fd2, cgroup_fd, BPF_LSM_CGROUP);
+cleanup_sock_create1:
+	bpf_prog_detach2(socket_prog_fd1, cgroup_fd, BPF_LSM_CGROUP);
+cleanup_skipcap2:
+	bpf_prog_detach2(skipcap_prog_fd2, cgroup_fd, BPF_LSM_CGROUP);
+cleanup_skipcap1:
+	bpf_prog_detach2(skipcap_prog_fd1, cgroup_fd, BPF_LSM_CGROUP);
+cleanup_skeleton:
+	lsm_cgroup__destroy(skel);
+cleanup_cgroup:
+	close(cgroup_fd);
+cleanup_tmpfile:
+	unlink(tmpfile);
+}
+
 void test_lsm_cgroup(void)
 {
 	if (test__start_subtest("functional"))
 		test_lsm_cgroup_functional();
 	if (test__start_subtest("nonvoid"))
 		test_lsm_cgroup_nonvoid();
+	if (test__start_subtest("retval"))
+		test_lsm_cgroup_retval();
 	btf__free(btf);
 }
diff --git a/tools/testing/selftests/bpf/progs/lsm_cgroup.c b/tools/testing/selftests/bpf/progs/lsm_cgroup.c
index d7598538aa2d..3bfa479104be 100644
--- a/tools/testing/selftests/bpf/progs/lsm_cgroup.c
+++ b/tools/testing/selftests/bpf/progs/lsm_cgroup.c
@@ -35,6 +35,8 @@ int called_socket_bind;
 int called_socket_bind2;
 int called_socket_alloc;
 int called_socket_clone;
+int skipcap_retval = -4095;
+int socket_retval = -4095;
 
 static __always_inline int test_local_storage(void)
 {
@@ -190,3 +192,31 @@ int BPF_PROG(socket_clone, struct sock *newsk, const struct request_sock *req)
 
 	return 1;
 }
+
+SEC("lsm_cgroup/inode_xattr_skipcap")
+int BPF_PROG(skipcap_first, const char *name)
+{
+	return 0;
+}
+
+SEC("lsm_cgroup/inode_xattr_skipcap")
+int BPF_PROG(skipcap_second, const char *name)
+{
+	skipcap_retval = bpf_get_retval();
+	bpf_set_retval(0);
+	return 1;
+}
+
+SEC("lsm_cgroup/socket_create")
+int BPF_PROG(socket_first, int family, int type, int protocol, int kern)
+{
+	return 0;
+}
+
+SEC("lsm_cgroup/socket_create")
+int BPF_PROG(socket_second, int family, int type, int protocol, int kern)
+{
+	socket_retval = bpf_get_retval();
+	bpf_set_retval(0);
+	return 1;
+}
-- 
2.43.0

