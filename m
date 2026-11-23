Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795473176;
	b=dCmgv5WsMwhcXTYAorqrDm+HAWP0o+6AljbnGENzVb7HiyMKRoyZu5kt5o3dEeXCaCJF
	 lHBFu/OXxxRcNqxRogTb56PW1thHBMO68Ydg15dgHFJumpfu6nnkTJb8ZHjr85Mji6Mk6
	 ursJQ9iXlEQ7cCjA0wlbY7Bz7GAUO0IYMYzKcI0f4uhb8Vgun0hpAK03p3CX6rUvRBl6s
	 xyBADORpjs3z82hNlyl92y9r3JDq0D2yT6EB+qNtQIxfVTCwHahEBzeN7FDHaBYgrkwsN
	 QsZbyoWglYyPAW6V0eI0Vgxn8IkF37pf5+xYTcn6H9wbl3JuVIDWDyMpWamQI+HiKug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795473176;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZfdrrQ1Yh58LVrSTZwLbWD1yNXEptkQP0rrVCFErzRw=;
	b=B2b8BsCvyimh3o8YL5txZBTnposN0luVXeS6WkptRVFOR2OB+dFTv5S//5CWSCH6CjJR
	 VRgf/4xiUtx9EjSt/DIozNP/ke+0b3Y+qjCNSuWUjxMPNyaKp39URDwiIbopF+Tr432ib
	 lnsCNCDzcKN2yHvKhuNbfBW0YB7zH+O9ZukNK0ft1es0/aIUqFCGKnrSpsE9bUOdKg2Iv
	 ujFQmfD7VOeiLLUjhYLzsSqjuCcDt7R5WK+uaK16Ul7rDwT0pEQzJ4d5TKoDxJBxcnxMk
	 kcmZv8JmrhGaz6HkfOnWTeXCE8McFI3+1UqpBjV7knmDnMQXEFXEaSBDCuhGDE194+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wv0TbAjn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F00F606A321
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wv0TbAjn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBC81F000C0;
	Mon, 23 Nov 2026 22:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795473176;
	bh=ZfdrrQ1Yh58LVrSTZwLbWD1yNXEptkQP0rrVCFErzRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wv0TbAjnTdm2+8BH3Uy1oTfdEJT8j+f875QMnxqi57lv8ZIUNJ37Zo+USsr1iDPff
	 jn56wJgka+V2+mk5W2GJsZC0P1Dwk+C3GbXJnzRBEzwbbKk9bU7NkqFn3dEPTN6feX
	 lol3St3DcIrjfERXxq59M9FbLGhD/rlquCnJa3/TCtoT1ERaeIxl8bcOFAxNqgN+UM
	 DT4JX7ay4kFva8SV3E9UiYMauPfc6Au8XPA3UYgZcJIcyBdk3pQrWW5PIxTq37ay3N
	 bv75a/kXamSsw082Pr/EoF6hR/0vY5CPjZki+1xt2xcDPPllVpBMqL9QmC4b1/QKRy
	 fC6N9BpCF3ITw==
From: Alan Maguire <almagui@kernel.org>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	Alan Maguire <almagui@kernel.org>
Subject: [PATCH bpf-next 6/7] selftests/bpf: Test detection of function argument relocation support
Date: Mon, 23 Nov 2026 22:32:26 +0000
Message-ID: <20261123223227.745345-7-almagui@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123223227.745345-1-almagui@kernel.org>
References: <20261123223227.745345-1-almagui@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that bpf_func_args_supported() returns 1 for function argument
structs, both explicitly declared (including one relying only on the
struct-level BTF decl tag when built with clang) and declared by
BPF_PROG_CORE(), in fentry, fexit, LSM and LSM cgroup programs, with
both skeletons and light skeletons, i.e., when relocated by libbpf and
by the kernel.

Also check that it returns 0 for a struct lacking the "bpf_func_args"
tag, as all structs would appear to libbpf or kernel versions without
support for function argument relocations, or when built with GCC
without __bpf_func_args_marker.

Assisted-by: LLM
Signed-off-by: Alan Maguire <almagui@kernel.org>
---
 .../selftests/bpf/prog_tests/func_args_core.c     |  6 ++++++
 .../testing/selftests/bpf/progs/func_args_core.c  | 15 ++++++++++++++-
 .../selftests/bpf/progs/func_args_core_lsm.c      |  8 ++++++--
 .../bpf/progs/func_args_core_lsm_cgroup.c         |  3 ++-
 4 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/func_args_core.c b/tools/testing/selftests/bpf/prog_tests/func_args_core.c
index f4cc859f20cd..e63591b6ccf5 100644
--- a/tools/testing/selftests/bpf/prog_tests/func_args_core.c
+++ b/tools/testing/selftests/bpf/prog_tests/func_args_core.c
@@ -35,6 +35,9 @@ static void trigger(int fentry_prog_fd, int fmod_ret_prog_fd)
 	ASSERT_EQ(skel->data->t3_fentry_ret_exists, 0, "t3_fentry_ret_exists"); \
 	ASSERT_EQ(skel->data->t3_ret_exists, 1, "t3_ret_exists");		\
 	ASSERT_EQ(skel->bss->t3_ret, 15, "t3_ret");				\
+	ASSERT_EQ(skel->data->t3_supported, 1, "t3_supported");		\
+	ASSERT_EQ(skel->data->t3_untagged_supported, 0, "t3_untagged_supported"); \
+	ASSERT_EQ(skel->data->m3_supported, 1, "m3_supported");		\
 										\
 	ASSERT_EQ(skel->bss->fm_calls, 1, "fm_calls");				\
 	ASSERT_EQ(skel->bss->fm_a, 1, "fm_a");					\
@@ -160,6 +163,8 @@ static __u64 lsm_ioctl(int *monitored_pid)
 	ASSERT_EQ(skel->data->s_ret, 0, "s_ret");				\
 	ASSERT_EQ(skel->data->s_ret_exists, 1, "s_ret_exists");		\
 	ASSERT_EQ(skel->data->s_added_exists, 0, "s_added_exists");		\
+	ASSERT_EQ(skel->data->s_supported, 1, "s_supported");			\
+	ASSERT_EQ(skel->data->m_supported, 1, "m_supported");			\
 										\
 	/* file___new (struct vfs_file *) doesn't match, file is used instead */ \
 	ASSERT_EQ(skel->data->v_new_exists, 0, "v_new_exists");		\
@@ -230,6 +235,7 @@ static void test_lsm_lskel(void)
 	ASSERT_EQ(skel->data->lc_kern, 0, "lc_kern");				\
 	ASSERT_EQ(skel->data->lc_ret_exists, 1, "lc_ret_exists");		\
 	ASSERT_EQ(skel->data->lc_added_exists, 0, "lc_added_exists");		\
+	ASSERT_EQ(skel->data->lc_supported, 1, "lc_supported");		\
 })
 
 static void trigger_lsm_cgroup(void)
diff --git a/tools/testing/selftests/bpf/progs/func_args_core.c b/tools/testing/selftests/bpf/progs/func_args_core.c
index 4656a6c642d1..cf2785d9349f 100644
--- a/tools/testing/selftests/bpf/progs/func_args_core.c
+++ b/tools/testing/selftests/bpf/progs/func_args_core.c
@@ -32,11 +32,23 @@ struct fentry_test3_args {
 
 __u64 t3_a, t3_b, t3_c, t3_b_alias, t3_ret;
 int t3_missing_exists = -1, t3_bad_type_exists = -1, t3_missing_flavor_exists = -1;
+int t3_supported = -1, t3_untagged_supported = -1;
+
+/* without the bpf_func_args tag, as for libbpf or kernel versions without
+ * support for function argument relocations; no kernel type has this name
+ */
+struct func_args_core_untagged {
+	int a;
+} __attribute__((preserve_access_index));
 int t3_fentry_ret_exists = -1, t3_ret_exists = -1;
 
 SEC("fentry/bpf_fentry_test3")
 int fentry3(struct fentry_test3_args *args)
 {
+	struct func_args_core_untagged *untagged = (void *)args;
+
+	t3_supported = bpf_func_args_supported(args);
+	t3_untagged_supported = bpf_func_args_supported(untagged);
 	t3_a = args->a;
 	t3_b = args->b;
 	t3_c = args->c;
@@ -185,12 +197,13 @@ int tp_read(struct test_read_args *args)
 
 /* BPF_PROG_CORE() versions, with the arguments struct declared implicitly */
 __u64 m3_a, m3_b, m3_c, m3_missing = -1, m3_ret;
-int m3_missing_exists = -1, m3_ret_exists = -1;
+int m3_missing_exists = -1, m3_ret_exists = -1, m3_supported = -1;
 
 SEC("fexit/bpf_fentry_test3")
 int BPF_PROG_CORE(fexit3_macro, __u64, c, int, b, char, a, long, missing,
 		  __bpf_func_ret int, ret)
 {
+	m3_supported = bpf_func_args_supported(ctx);
 	m3_a = a;
 	m3_b = b;
 	m3_c = c;
diff --git a/tools/testing/selftests/bpf/progs/func_args_core_lsm.c b/tools/testing/selftests/bpf/progs/func_args_core_lsm.c
index f4b9e68e4578..53f39275614a 100644
--- a/tools/testing/selftests/bpf/progs/func_args_core_lsm.c
+++ b/tools/testing/selftests/bpf/progs/func_args_core_lsm.c
@@ -22,7 +22,7 @@ struct file_ioctl_args {
 } __bpf_func_args;
 
 __u64 s_arg, s_ino;
-int s_ret = -1, s_ret_exists = -1, s_added_exists = -1, s_calls;
+int s_ret = -1, s_ret_exists = -1, s_added_exists = -1, s_calls, s_supported = -1;
 
 SEC("lsm/file_ioctl")
 int ioctl_struct(struct file_ioctl_args *args)
@@ -30,6 +30,8 @@ int ioctl_struct(struct file_ioctl_args *args)
 	if ((bpf_get_current_pid_tgid() >> 32) != monitored_pid)
 		return 0;
 
+	s_supported = bpf_func_args_supported(args);
+
 	s_calls++;
 	s_arg = args->arg;
 	s_ino = args->file->f_inode->i_ino;
@@ -88,7 +90,7 @@ int BPF_PROG_CORE(ioctl_macro_variants, struct vfs_file *, file___new,
 }
 
 __u64 m_arg, m_cmd, m_added = -1;
-int m_ret = -1, m_ret_exists = -1, m_added_exists = -1, m_calls;
+int m_ret = -1, m_ret_exists = -1, m_added_exists = -1, m_calls, m_supported = -1;
 
 SEC("lsm/file_ioctl")
 int BPF_PROG_CORE(ioctl_macro, unsigned long, arg, __bpf_func_ret int, ret,
@@ -97,6 +99,8 @@ int BPF_PROG_CORE(ioctl_macro, unsigned long, arg, __bpf_func_ret int, ret,
 	if ((bpf_get_current_pid_tgid() >> 32) != monitored_pid)
 		return 0;
 
+	m_supported = bpf_func_args_supported(ctx);
+
 	m_calls++;
 	m_arg = arg;
 	m_cmd = cmd;
diff --git a/tools/testing/selftests/bpf/progs/func_args_core_lsm_cgroup.c b/tools/testing/selftests/bpf/progs/func_args_core_lsm_cgroup.c
index 2743c58f13aa..e2b149272556 100644
--- a/tools/testing/selftests/bpf/progs/func_args_core_lsm_cgroup.c
+++ b/tools/testing/selftests/bpf/progs/func_args_core_lsm_cgroup.c
@@ -20,7 +20,7 @@ struct socket_create_args {
 } __bpf_func_args;
 
 int lc_calls, lc_family = -1, lc_protocol = -1, lc_kern = -1;
-int lc_ret_exists = -1, lc_added_exists = -1;
+int lc_ret_exists = -1, lc_added_exists = -1, lc_supported = -1;
 
 SEC("lsm_cgroup/socket_create")
 int socket_create_struct(struct socket_create_args *args)
@@ -29,6 +29,7 @@ int socket_create_struct(struct socket_create_args *args)
 		return 1;
 
 	lc_calls++;
+	lc_supported = bpf_func_args_supported(args);
 	lc_family = args->family;
 	lc_protocol = args->protocol;
 	lc_kern = args->kern;
-- 
2.56.0

