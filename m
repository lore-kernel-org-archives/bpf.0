Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795473169;
	b=w8cTVsJDWqooLxLEpf2hdjqsM/dYthFDD+FpUwa3XC8nfWgPB4XkoDbGOzR8K7GuoFYi
	 hEXYBlDtI9VShtgxo1tejtT6j50lGL87fpUeEg6ng+lqXkuQxdIYcc1xPJ07tx0iyk7Lo
	 ycsyOUG0RguCEeA8hcOpRwR0Bu/wTwuKCDOg8tcfIkqhcR05pxAApEEXvnbovaEuIQ30L
	 wks9XgzgxSJllwcRXC59BhqtvTIlr1vdcz+2E8nW09MdYMsi/tci68//S3D8jxM59w5lF
	 +qWxwjH3Es6cZZZePPsvx6OYvtAnsRIZs7ylnWSAWMdnjp9r6d3aJk+MfptKJGocpfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795473169;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UmVB/hx96/XZkABr/sAXjG/EjRmta8Spwad9W79gKgQ=;
	b=WwlQ/PrwSAXVHe7ZJVzr1DGLQ6LvCvefuTOwe+uZ4nqynjyYrW/a0bg4tAFbffpHzhGK
	 cdxe/gxzJEpSyZnuI0KUqhY2S0twRhUr2NoEE/waqFmIyhJ6aWnlL8Pf2qm11m/7dH1jQ
	 JCb/3AgoAFFq+lAe9645RrjWSgvVksQwiiN+AdC2lc4nx7SAhGfbLaao+fVuwEOdC3jOI
	 LRtNt/7T+AfuCgRgChwlyPNrBszQGeB+TFq0MEld7zgH/gkezfsDiZy4iMercBUDZ29Jm
	 DkPqnn6B4He9g5Dkwwc6VN1NRbAkNHatvRxLpb3wRmxp7YF+qzWBkQT3ZkCSBnWP7WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYVqXnx5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CA7606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYVqXnx5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09C51F000C0;
	Mon, 23 Nov 2026 22:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795473168;
	bh=UmVB/hx96/XZkABr/sAXjG/EjRmta8Spwad9W79gKgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hYVqXnx5ZoKFHP2SMhn86st9xULY+SxSlx8K2xE8XbUwE0QdlnPzsb+pD5ABLRoCX
	 t+NUdil6iWNCfg83XBEfzIQCbTu7H6gVhLGiQTCrXGk7IZh7nx0qYs8GlOETtJz7kW
	 7mCEMF2wkgnpFZcsyWyaIN8VKbAjoEeBybkCUOnnykyMM0NyfCcMsmy5Xf9sC7GO6Z
	 VUDgKYIwrNzxdWMBsskPxqHKvNJYzlNmpcthCm1FpnnLYaUM5g+54HpW6lDsSO0Rh9
	 y4y+RphlTd3nTeUAp8P422ZiDtdSchLFxMGMJsGd7f6L3ak/NPYDEbQEz/FDK7UJO2
	 a3dcTLZsITAsA==
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
Subject: [PATCH bpf-next 4/7] selftests/bpf: Test CO-RE relocation of BPF LSM program arguments
Date: Mon, 23 Nov 2026 22:32:24 +0000
Message-ID: <20261123223227.745345-5-almagui@kernel.org>
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

Check that function argument structs work for BPF LSM programs, where
the attach target is the bpf_lsm_<hook>() function, against the
file_ioctl hook (file, cmd, arg), triggered by an ioctl() on a memfd
with a command that no file implements. That fails with ENOTTY after
the hook ran, so whatever the programs return has no effect on the test
process, and no other selftest attaches to that hook:

- a __bpf_func_args struct describing the arguments out of order,
  omitting cmd, adding a member with no matching parameter, and
  reading the return value of the previous hook via __bpf_func_ret;
- BPF_PROG_CORE() with arguments out of order, the return value, and
  an added argument which reads as zero and is reported as absent by
  bpf_func_arg_exists(); the cmd passed has its top bit set, to check
  that an unsigned int argument isn't sign-extended;
- both of these describing the file parameter with two flavors, as for
  a (hypothetical) kernel in which it pointed to a renamed struct
  vfs_file: 'struct vfs_file *file___new' doesn't match, and the
  program reads the inode number through whichever variant exists,
  which also checks that the poisoned accesses through the missing one
  are dead code;
- the reverse, as for a program written for that kernel: both of these
  describing the file parameter as 'struct vfs_file *file', which
  doesn't match, and 'struct file *file___old', which does, checking
  that a flavored member matches when the unflavored one doesn't.

The inode numbers read are checked against fstat() on the memfd.

Also cover BPF_LSM_CGROUP programs with a __bpf_func_args struct for the
socket_create hook (family, type, protocol, kern), attached to a test
cgroup and triggered via socket(AF_UNIX, SOCK_STREAM, 0), describing
the arguments out of order, omitting type, adding a member with no
matching parameter and checking that the return value slot exists.

As with the tracing tests, run these with both a skeleton and a light
skeleton to cover libbpf's and the kernel's CO-RE relocation. They are
also skipped on big-endian targets, as they read signed int arguments
and return values as well.

Signed-off-by: Alan Maguire <almagui@kernel.org>
Assisted-by: LLM
---
 tools/testing/selftests/bpf/Makefile.skel     |   3 +-
 .../selftests/bpf/prog_tests/func_args_core.c | 189 ++++++++++++++++++
 .../selftests/bpf/progs/func_args_core_lsm.c  | 152 ++++++++++++++
 .../bpf/progs/func_args_core_lsm_cgroup.c     |  39 ++++
 4 files changed, 382 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/func_args_core_lsm.c
 create mode 100644 tools/testing/selftests/bpf/progs/func_args_core_lsm_cgroup.c

diff --git a/tools/testing/selftests/bpf/Makefile.skel b/tools/testing/selftests/bpf/Makefile.skel
index 69808d962fc7..3c48251ae5b7 100644
--- a/tools/testing/selftests/bpf/Makefile.skel
+++ b/tools/testing/selftests/bpf/Makefile.skel
@@ -40,7 +40,8 @@ LSKELS_SIGNED := fentry_test.c fexit_test.c atomics.c
 
 # Generate both light skeleton and libbpf skeleton for these
 LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.c \
-	kfunc_call_test_subprog.c test_global_percpu_data.c func_args_core.c
+	kfunc_call_test_subprog.c test_global_percpu_data.c func_args_core.c \
+	func_args_core_lsm.c func_args_core_lsm_cgroup.c
 SKEL_BLACKLIST += $(LSKELS) $(LSKELS_SIGNED)
 
 test_static_linked.skel.h-deps := test_static_linked1.bpf.o test_static_linked2.bpf.o
diff --git a/tools/testing/selftests/bpf/prog_tests/func_args_core.c b/tools/testing/selftests/bpf/prog_tests/func_args_core.c
index 1516ad13eaa2..f4cc859f20cd 100644
--- a/tools/testing/selftests/bpf/prog_tests/func_args_core.c
+++ b/tools/testing/selftests/bpf/prog_tests/func_args_core.c
@@ -2,6 +2,14 @@
 #include <test_progs.h>
 #include "func_args_core.skel.h"
 #include "func_args_core.lskel.h"
+#include "func_args_core_lsm.skel.h"
+#include "func_args_core_lsm.lskel.h"
+#include "func_args_core_lsm_cgroup.skel.h"
+#include "func_args_core_lsm_cgroup.lskel.h"
+#include "cgroup_helpers.h"
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
 
 /* runs bpf_fentry_test1..N() (via a fentry prog), bpf_modify_return_test()
  * (via a fmod_ret prog) and bpf_testmod's test read
@@ -110,6 +118,179 @@ static void test_lskel(void)
 	func_args_core_lskel__destroy(skel);
 }
 
+/* An ioctl command that no file implements: the call fails after the
+ * file_ioctl hook ran, so whatever the programs return has no effect on the
+ * process (unlike, e.g., an mprotect() that they allow). Its top bit is set
+ * to check that the unsigned int argument isn't sign-extended.
+ */
+#define LSM_IOCTL_CMD	0xb1f0c0deU
+#define LSM_IOCTL_ARG	0x0123456789abcdefULL
+
+/* Run file_ioctl(file, cmd, arg) for an ioctl() on a memfd, only monitoring
+ * that call; returns the memfd's inode number, or 0 on failure.
+ */
+static __u64 lsm_ioctl(int *monitored_pid)
+{
+	struct stat st;
+	__u64 ino = 0;
+	int fd, err;
+
+	fd = memfd_create("func_args_core", MFD_CLOEXEC);
+	if (!ASSERT_OK_FD(fd, "memfd_create"))
+		return 0;
+	if (!ASSERT_OK(fstat(fd, &st), "fstat"))
+		goto out;
+
+	*monitored_pid = getpid();
+	err = ioctl(fd, LSM_IOCTL_CMD, LSM_IOCTL_ARG) ? -errno : 0;
+	*monitored_pid = 0;
+
+	if (ASSERT_EQ(err, -ENOTTY, "ioctl"))
+		ino = st.st_ino;
+out:
+	close(fd);
+	return ino;
+}
+
+/* file_ioctl(file, cmd, arg) via lsm_ioctl() */
+#define check_lsm_results(skel, ino) ({					\
+	ASSERT_EQ(skel->bss->s_calls, 1, "s_calls");				\
+	ASSERT_EQ(skel->bss->s_arg, LSM_IOCTL_ARG, "s_arg");			\
+	ASSERT_EQ(skel->bss->s_ino, ino, "s_ino");				\
+	ASSERT_EQ(skel->data->s_ret, 0, "s_ret");				\
+	ASSERT_EQ(skel->data->s_ret_exists, 1, "s_ret_exists");		\
+	ASSERT_EQ(skel->data->s_added_exists, 0, "s_added_exists");		\
+										\
+	/* file___new (struct vfs_file *) doesn't match, file is used instead */ \
+	ASSERT_EQ(skel->data->v_new_exists, 0, "v_new_exists");		\
+	ASSERT_EQ(skel->data->v_old_exists, 1, "v_old_exists");		\
+	ASSERT_EQ(skel->bss->v_ino, ino, "v_ino");				\
+	ASSERT_EQ(skel->data->vm_new_exists, 0, "vm_new_exists");		\
+	ASSERT_EQ(skel->data->vm_old_exists, 1, "vm_old_exists");		\
+	ASSERT_EQ(skel->bss->vm_ino, ino, "vm_ino");				\
+										\
+	/* only the flavored file___old matches */				\
+	ASSERT_EQ(skel->data->o_new_exists, 0, "o_new_exists");		\
+	ASSERT_EQ(skel->data->o_old_exists, 1, "o_old_exists");		\
+	ASSERT_EQ(skel->bss->o_ino, ino, "o_ino");				\
+	ASSERT_EQ(skel->data->om_new_exists, 0, "om_new_exists");		\
+	ASSERT_EQ(skel->data->om_old_exists, 1, "om_old_exists");		\
+	ASSERT_EQ(skel->bss->om_ino, ino, "om_ino");				\
+										\
+	ASSERT_EQ(skel->bss->m_calls, 1, "m_calls");				\
+	ASSERT_EQ(skel->bss->m_arg, LSM_IOCTL_ARG, "m_arg");			\
+	ASSERT_EQ(skel->bss->m_cmd, LSM_IOCTL_CMD, "m_cmd");			\
+	ASSERT_EQ(skel->data->m_added, 0, "m_added");				\
+	ASSERT_EQ(skel->data->m_added_exists, 0, "m_added_exists");		\
+	ASSERT_EQ(skel->data->m_ret, 0, "m_ret");				\
+	ASSERT_EQ(skel->data->m_ret_exists, 1, "m_ret_exists");		\
+})
+
+static void test_lsm_skel(void)
+{
+	struct func_args_core_lsm *skel;
+	__u64 ino;
+
+	skel = func_args_core_lsm__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+	if (!ASSERT_OK(func_args_core_lsm__attach(skel), "skel_attach"))
+		goto cleanup;
+
+	ino = lsm_ioctl(&skel->bss->monitored_pid);
+	if (ASSERT_NEQ(ino, 0, "lsm_ioctl"))
+		check_lsm_results(skel, ino);
+cleanup:
+	func_args_core_lsm__destroy(skel);
+}
+
+static void test_lsm_lskel(void)
+{
+	struct func_args_core_lsm_lskel *skel;
+	__u64 ino;
+
+	skel = func_args_core_lsm_lskel__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "lskel_open_and_load"))
+		return;
+	if (!ASSERT_OK(func_args_core_lsm_lskel__attach(skel), "lskel_attach"))
+		goto cleanup;
+
+	ino = lsm_ioctl(&skel->bss->monitored_pid);
+	if (ASSERT_NEQ(ino, 0, "lsm_ioctl"))
+		check_lsm_results(skel, ino);
+cleanup:
+	func_args_core_lsm_lskel__destroy(skel);
+}
+
+/* socket_create(family, type, protocol, kern) via socket(AF_UNIX, ...) */
+#define check_lsm_cgroup_results(skel) ({					\
+	ASSERT_EQ(skel->bss->lc_calls, 1, "lc_calls");				\
+	ASSERT_EQ(skel->data->lc_family, AF_UNIX, "lc_family");		\
+	ASSERT_EQ(skel->data->lc_protocol, 0, "lc_protocol");			\
+	ASSERT_EQ(skel->data->lc_kern, 0, "lc_kern");				\
+	ASSERT_EQ(skel->data->lc_ret_exists, 1, "lc_ret_exists");		\
+	ASSERT_EQ(skel->data->lc_added_exists, 0, "lc_added_exists");		\
+})
+
+static void trigger_lsm_cgroup(void)
+{
+	int fd = socket(AF_UNIX, SOCK_STREAM, 0);
+
+	if (ASSERT_OK_FD(fd, "socket"))
+		close(fd);
+}
+
+static void test_lsm_cgroup_skel(void)
+{
+	struct func_args_core_lsm_cgroup *skel;
+	struct bpf_link *link = NULL;
+	int cgroup_fd;
+
+	cgroup_fd = test__join_cgroup("/func_args_core");
+	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup"))
+		return;
+
+	skel = func_args_core_lsm_cgroup__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		goto out;
+	link = bpf_program__attach_cgroup(skel->progs.socket_create_struct, cgroup_fd);
+	if (!ASSERT_OK_PTR(link, "attach_cgroup"))
+		goto out;
+
+	trigger_lsm_cgroup();
+	check_lsm_cgroup_results(skel);
+out:
+	bpf_link__destroy(link);
+	func_args_core_lsm_cgroup__destroy(skel);
+	close(cgroup_fd);
+}
+
+static void test_lsm_cgroup_lskel(void)
+{
+	struct func_args_core_lsm_cgroup_lskel *skel;
+	int cgroup_fd, link_fd = -1;
+
+	cgroup_fd = test__join_cgroup("/func_args_core");
+	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup"))
+		return;
+
+	skel = func_args_core_lsm_cgroup_lskel__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "lskel_open_and_load"))
+		goto out;
+	link_fd = bpf_link_create(skel->progs.socket_create_struct.prog_fd, cgroup_fd,
+				  BPF_LSM_CGROUP, NULL);
+	if (!ASSERT_OK_FD(link_fd, "link_create"))
+		goto out;
+
+	trigger_lsm_cgroup();
+	check_lsm_cgroup_results(skel);
+out:
+	if (link_fd >= 0)
+		close(link_fd);
+	func_args_core_lsm_cgroup_lskel__destroy(skel);
+	close(cgroup_fd);
+}
+
 void test_func_args_core(void)
 {
 #if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
@@ -127,4 +308,12 @@ void test_func_args_core(void)
 		test_skel();
 	if (test__start_subtest("lskel"))
 		test_lskel();
+	if (test__start_subtest("lsm_skel"))
+		test_lsm_skel();
+	if (test__start_subtest("lsm_lskel"))
+		test_lsm_lskel();
+	if (test__start_subtest("lsm_cgroup_skel"))
+		test_lsm_cgroup_skel();
+	if (test__start_subtest("lsm_cgroup_lskel"))
+		test_lsm_cgroup_lskel();
 }
diff --git a/tools/testing/selftests/bpf/progs/func_args_core_lsm.c b/tools/testing/selftests/bpf/progs/func_args_core_lsm.c
new file mode 100644
index 000000000000..f4b9e68e4578
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/func_args_core_lsm.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+char _license[] SEC("license") = "GPL";
+
+int monitored_pid;
+
+/* int file_ioctl(struct file *file, unsigned int cmd, unsigned long arg) */
+struct file_ioctl_args {
+	__bpf_func_args_marker;
+	/* out of order */
+	unsigned long arg;
+
+	int ret __bpf_func_ret;
+	struct file *file;
+	/* added: no such parameter */
+	unsigned long added;
+	/* missing: cmd isn't described */
+} __bpf_func_args;
+
+__u64 s_arg, s_ino;
+int s_ret = -1, s_ret_exists = -1, s_added_exists = -1, s_calls;
+
+SEC("lsm/file_ioctl")
+int ioctl_struct(struct file_ioctl_args *args)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != monitored_pid)
+		return 0;
+
+	s_calls++;
+	s_arg = args->arg;
+	s_ino = args->file->f_inode->i_ino;
+	s_ret = args->ret;
+	s_ret_exists = bpf_core_field_exists(args->ret);
+	s_added_exists = bpf_core_field_exists(args->added);
+	return 0;
+}
+
+/* A hypothetical future kernel in which file_ioctl()'s file parameter
+ * points to a renamed struct: both variants are described with flavors,
+ * and only one of them can match in a given kernel.
+ */
+struct vfs_file {
+	struct inode *f_inode;
+} __attribute__((preserve_access_index));
+
+struct file_ioctl_variant_args {
+	__bpf_func_args_marker;
+	struct vfs_file *file___new;
+	struct file *file;
+} __bpf_func_args;
+
+__u64 v_ino, vm_ino;
+int v_new_exists = -1, v_old_exists = -1, vm_new_exists = -1, vm_old_exists = -1;
+
+SEC("lsm/file_ioctl")
+int ioctl_variants(struct file_ioctl_variant_args *args)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != monitored_pid)
+		return 0;
+
+	v_new_exists = bpf_core_field_exists(args->file___new);
+	v_old_exists = bpf_core_field_exists(args->file);
+	if (bpf_core_field_exists(args->file___new))
+		v_ino = args->file___new->f_inode->i_ino;
+	else if (bpf_core_field_exists(args->file))
+		v_ino = args->file->f_inode->i_ino;
+	return 0;
+}
+
+SEC("lsm/file_ioctl")
+int BPF_PROG_CORE(ioctl_macro_variants, struct vfs_file *, file___new,
+		  struct file *, file)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != monitored_pid)
+		return 0;
+
+	vm_new_exists = bpf_func_arg_exists(file___new);
+	vm_old_exists = bpf_func_arg_exists(file);
+	if (bpf_func_arg_exists(file___new))
+		vm_ino = file___new->f_inode->i_ino;
+	else if (bpf_func_arg_exists(file))
+		vm_ino = file->f_inode->i_ino;
+	return 0;
+}
+
+__u64 m_arg, m_cmd, m_added = -1;
+int m_ret = -1, m_ret_exists = -1, m_added_exists = -1, m_calls;
+
+SEC("lsm/file_ioctl")
+int BPF_PROG_CORE(ioctl_macro, unsigned long, arg, __bpf_func_ret int, ret,
+		  unsigned long, added, unsigned int, cmd)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != monitored_pid)
+		return 0;
+
+	m_calls++;
+	m_arg = arg;
+	m_cmd = cmd;
+	m_added = added;
+	m_added_exists = bpf_func_arg_exists(added);
+	m_ret = ret;
+	m_ret_exists = bpf_func_arg_exists(ret);
+	return 0;
+}
+
+/* The reverse: a program written for the hypothetical kernel, describing
+ * file with the new type and the current one with a flavor, so that only
+ * the flavored member matches.
+ */
+struct file_ioctl_old_variant_args {
+	__bpf_func_args_marker;
+	struct vfs_file *file;
+	struct file *file___old;
+} __bpf_func_args;
+
+__u64 o_ino, om_ino;
+int o_new_exists = -1, o_old_exists = -1, om_new_exists = -1, om_old_exists = -1;
+
+SEC("lsm/file_ioctl")
+int ioctl_old_variant(struct file_ioctl_old_variant_args *args)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != monitored_pid)
+		return 0;
+
+	o_new_exists = bpf_core_field_exists(args->file);
+	o_old_exists = bpf_core_field_exists(args->file___old);
+	if (bpf_core_field_exists(args->file))
+		o_ino = args->file->f_inode->i_ino;
+	else if (bpf_core_field_exists(args->file___old))
+		o_ino = args->file___old->f_inode->i_ino;
+	return 0;
+}
+
+SEC("lsm/file_ioctl")
+int BPF_PROG_CORE(ioctl_macro_old_variant, struct vfs_file *, file,
+		  struct file *, file___old)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != monitored_pid)
+		return 0;
+
+	om_new_exists = bpf_func_arg_exists(file);
+	om_old_exists = bpf_func_arg_exists(file___old);
+	if (bpf_func_arg_exists(file))
+		om_ino = file->f_inode->i_ino;
+	else if (bpf_func_arg_exists(file___old))
+		om_ino = file___old->f_inode->i_ino;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/func_args_core_lsm_cgroup.c b/tools/testing/selftests/bpf/progs/func_args_core_lsm_cgroup.c
new file mode 100644
index 000000000000..2743c58f13aa
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/func_args_core_lsm_cgroup.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+char _license[] SEC("license") = "GPL";
+
+/* int socket_create(int family, int type, int protocol, int kern) */
+struct socket_create_args {
+	__bpf_func_args_marker;
+	/* out of order */
+	int kern;
+	int protocol;
+	int ret __bpf_func_ret;
+	int family;
+	/* added: no such parameter */
+	long added;
+	/* missing: type isn't described */
+} __bpf_func_args;
+
+int lc_calls, lc_family = -1, lc_protocol = -1, lc_kern = -1;
+int lc_ret_exists = -1, lc_added_exists = -1;
+
+SEC("lsm_cgroup/socket_create")
+int socket_create_struct(struct socket_create_args *args)
+{
+	if (args->family != 1 /* AF_UNIX */)
+		return 1;
+
+	lc_calls++;
+	lc_family = args->family;
+	lc_protocol = args->protocol;
+	lc_kern = args->kern;
+	lc_ret_exists = bpf_core_field_exists(args->ret);
+	lc_added_exists = bpf_core_field_exists(args->added);
+	/* allow */
+	return 1;
+}
-- 
2.56.0

