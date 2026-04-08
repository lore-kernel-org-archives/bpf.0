Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C437225A321
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775670756; cv=none; b=HS6wXSSaV2X4C6VXbRAbzmeqGleokBtiSxOstrvNRsYaOutAzx5359zxjfn14lhTkYfaASb/rp2V+KXf95gEYME6kKuEosju8MjSp/Wq/Wq4E3PUoP/5pirqOqcnCyb8nOLlUKQ90JFku38SKzntrGtuckpomUwJUt0YdgksrNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775670756; c=relaxed/simple;
	bh=Aa/EoxUYgL+tuYrxO4gB6ztvxANMtjex6eyL+RpfLVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mJsbd2GS4rjwhRZ85luva3liasuz34AnnyADTDw7NNEmz//AwmzF0hCipmqsdU/z2CM9zeDGU+Zu6pcY5NdtHv/xIGY+H3BfN+rIFY0fRoQlUgjCze+GCzd8FBdd7bZm0yJbWWVTfEKlSgN7XISc0B82B4JDTPKqVEjXuyXm8S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Om6pdpJ5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Om6pdpJ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1CDC19421;
	Wed,  8 Apr 2026 17:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775670756;
	bh=Aa/EoxUYgL+tuYrxO4gB6ztvxANMtjex6eyL+RpfLVQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Om6pdpJ5n0TviR02zm7VASPMqlP3LbOxMI6QlizF3L52y8U6rnIAQ/ybVyVLbCjCO
	 D9d312f9HKGGaR45Z7/ALHibThtqTI5upIb7nzv6CqtnTC6zAajQkCO9s5bxRTUQP1
	 1ZLv4MVTFfZFzwSBch5IxeLOKDOFLtO+GJ4gz4Pl/QbC3rgJcj3p6ASL3NNB1P6cYn
	 FrL/9NuU6IuSsu13Dx0hJ6Ar4RRarU0H7Sch3g59ia0a9zZz8hl5GDGPz5ZdLPD1yV
	 HLLficdMvlNx43VtfqS0eGXBnKspUkCYZq48yb0LSOsRy3dpUplvr2uc/93JamhS6g
	 HeAKd5+EF9WuQ==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	kernel-team@meta.com,
	laoar.shao@gmail.com,
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Add BPF struct_ops + livepatch integration test
Date: Wed,  8 Apr 2026 10:52:17 -0700
Message-ID: <20260408175217.1011024-1-song@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest that demonstrates BPF struct_ops controlling kernel
behavior through livepatch. A kernel module (test_klp_bpf) livepatches
cmdline_proc_show() and delegates output to a BPF struct_ops callback.
The BPF program writes a custom string to /proc/cmdline via the
bpf_klp_seq_write kfunc.

Components:
- test_kmods/test_klp_bpf.c: kernel module that registers a
  klp_bpf_cmdline_ops struct_ops type, livepatches cmdline_proc_show,
  and provides bpf_klp_seq_write kfunc for seq_file writes
- progs/test_klp_bpf.c: BPF struct_ops program implementing
  set_cmdline callback
- prog_tests/test_klp_bpf.c: userspace test verifying /proc/cmdline
  output with and without BPF struct_ops attached

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Song Liu <song@kernel.org>

---

This shows an alternative solution to the idea proposed in [1]. This
approach doesn't need any kernel change.

[1] https://lore.kernel.org/bpf/20260402092607.96430-1-laoar.shao@gmail.com/
---
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../selftests/bpf/prog_tests/test_klp_bpf.c   | 109 ++++++++++++
 .../selftests/bpf/progs/test_klp_bpf.c        |  26 +++
 .../testing/selftests/bpf/test_kmods/Makefile |   3 +-
 .../selftests/bpf/test_kmods/test_klp_bpf.c   | 166 ++++++++++++++++++
 .../selftests/bpf/test_kmods/test_klp_bpf.h   |  12 ++
 6 files changed, 316 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_klp_bpf.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_klp_bpf.c
 create mode 100644 tools/testing/selftests/bpf/test_kmods/test_klp_bpf.c
 create mode 100644 tools/testing/selftests/bpf/test_kmods/test_klp_bpf.h

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f75c4f52c028..22ef1f76196d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -121,7 +121,7 @@ TEST_PROGS_EXTENDED := \
 	ima_setup.sh verify_sig_setup.sh
 
 TEST_KMODS := bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
-	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko
+	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko test_klp_bpf.ko
 TEST_KMOD_TARGETS = $(addprefix $(OUTPUT)/,$(TEST_KMODS))
 
 # Compile but not part of 'make run_tests'
diff --git a/tools/testing/selftests/bpf/prog_tests/test_klp_bpf.c b/tools/testing/selftests/bpf/prog_tests/test_klp_bpf.c
new file mode 100644
index 000000000000..f70c4d1d0176
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_klp_bpf.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include "testing_helpers.h"
+#include "test_klp_bpf.skel.h"
+
+#define KLP_MODULE_NAME "test_klp_bpf"
+#define KLP_ENABLED_PATH "/sys/kernel/livepatch/" KLP_MODULE_NAME "/enabled"
+
+static int load_klp_module(void)
+{
+	return load_module("test_klp_bpf.ko", env_verbosity > VERBOSE_NONE);
+}
+
+static void unload_klp_module(void)
+{
+	/* Disable the livepatch before unloading */
+	if (!access(KLP_ENABLED_PATH, F_OK))
+		system("echo 0 > " KLP_ENABLED_PATH);
+
+	unload_module(KLP_MODULE_NAME, env_verbosity > VERBOSE_NONE);
+}
+
+static int read_proc_cmdline(char *buf, size_t buf_sz)
+{
+	int fd, ret;
+
+	fd = open("/proc/cmdline", O_RDONLY);
+	if (fd < 0)
+		return -errno;
+
+	ret = read(fd, buf, buf_sz - 1);
+	close(fd);
+	if (ret < 0)
+		return -errno;
+
+	buf[ret] = '\0';
+	return 0;
+}
+
+void test_klp_bpf(void)
+{
+	struct test_klp_bpf *skel = NULL;
+	struct bpf_link *link = NULL;
+	char buf[4096] = {};
+	int err;
+
+	/* Skip if kernel was built without CONFIG_LIVEPATCH */
+	if (access("/sys/kernel/livepatch", F_OK)) {
+		test__skip();
+		return;
+	}
+
+	err = load_klp_module();
+	if (err) {
+		if (err == -ENOENT) {
+			test__skip();
+			return;
+		}
+		/* Module may already be loaded; unload and retry */
+		unload_klp_module();
+		err = load_klp_module();
+		if (!ASSERT_OK(err, "load_klp_module"))
+			return;
+	}
+
+	/* Verify livepatch is active with fallback message */
+	err = read_proc_cmdline(buf, sizeof(buf));
+	if (!ASSERT_OK(err, "read_cmdline_fallback"))
+		goto out;
+	if (!ASSERT_OK(strncmp(buf, "test_klp_bpf: no struct_ops attached",
+			       strlen("test_klp_bpf: no struct_ops attached")),
+		       "fallback_msg"))
+		goto out;
+
+	/* Load and attach BPF struct_ops */
+	skel = test_klp_bpf__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		goto out;
+
+	link = bpf_map__attach_struct_ops(skel->maps.cmdline_ops);
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto out;
+
+	/* Verify BPF-controlled cmdline */
+	memset(buf, 0, sizeof(buf));
+	err = read_proc_cmdline(buf, sizeof(buf));
+	if (!ASSERT_OK(err, "read_cmdline_bpf"))
+		goto out;
+	ASSERT_STREQ(buf, "klp_bpf: custom cmdline\n", "bpf_cmdline");
+
+	/* Detach and verify fallback resumes */
+	bpf_link__destroy(link);
+	link = NULL;
+
+	memset(buf, 0, sizeof(buf));
+	err = read_proc_cmdline(buf, sizeof(buf));
+	if (!ASSERT_OK(err, "read_cmdline_detached"))
+		goto out;
+	ASSERT_OK(strncmp(buf, "test_klp_bpf: no struct_ops attached",
+			  strlen("test_klp_bpf: no struct_ops attached")),
+		  "detached_fallback_msg");
+
+out:
+	bpf_link__destroy(link);
+	test_klp_bpf__destroy(skel);
+	unload_klp_module();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_klp_bpf.c b/tools/testing/selftests/bpf/progs/test_klp_bpf.c
new file mode 100644
index 000000000000..f3b68232231a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_klp_bpf.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../test_kmods/test_klp_bpf.h"
+
+char _license[] SEC("license") = "GPL";
+
+extern void bpf_klp_seq_write(struct seq_file *m,
+			      const char *data, u32 data__sz) __ksym;
+
+SEC("struct_ops/set_cmdline")
+int BPF_PROG(set_cmdline, struct seq_file *m)
+{
+	char custom[] = "klp_bpf: custom cmdline\n";
+
+	bpf_klp_seq_write(m, custom, sizeof(custom) - 1);
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct klp_bpf_cmdline_ops cmdline_ops = {
+	.set_cmdline = (void *)set_cmdline,
+};
diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/testing/selftests/bpf/test_kmods/Makefile
index 63c4d3f6a12f..bb182d668277 100644
--- a/tools/testing/selftests/bpf/test_kmods/Makefile
+++ b/tools/testing/selftests/bpf/test_kmods/Makefile
@@ -8,11 +8,12 @@ Q = @
 endif
 
 MODULES = bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
-	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko
+	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko test_klp_bpf.ko
 
 $(foreach m,$(MODULES),$(eval obj-m += $(m:.ko=.o)))
 
 CFLAGS_bpf_testmod.o = -I$(src)
+CFLAGS_test_klp_bpf.o = -I$(src)
 
 all:
 	$(Q)$(MAKE) -C $(KDIR) M=$(TEST_KMOD_DIR) modules
diff --git a/tools/testing/selftests/bpf/test_kmods/test_klp_bpf.c b/tools/testing/selftests/bpf/test_kmods/test_klp_bpf.c
new file mode 100644
index 000000000000..62943b6db4a3
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_kmods/test_klp_bpf.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/livepatch.h>
+#include <linux/seq_file.h>
+#include <linux/bpf_verifier.h>
+#include "test_klp_bpf.h"
+
+static struct klp_bpf_cmdline_ops *active_ops;
+
+/* --- kfunc: allow BPF struct_ops programs to write to seq_file --- */
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc void bpf_klp_seq_write(struct seq_file *m,
+				    const char *data, u32 data__sz)
+{
+	seq_write(m, data, data__sz);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(klp_bpf_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_klp_seq_write)
+BTF_KFUNCS_END(klp_bpf_kfunc_ids)
+
+static const struct btf_kfunc_id_set klp_bpf_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &klp_bpf_kfunc_ids,
+};
+
+/* --- Livepatch replacement for cmdline_proc_show --- */
+
+static int livepatch_cmdline_proc_show(struct seq_file *m, void *v)
+{
+	struct klp_bpf_cmdline_ops *ops = READ_ONCE(active_ops);
+
+	if (ops && ops->set_cmdline)
+		return ops->set_cmdline(m);
+
+	seq_printf(m, "%s: no struct_ops attached\n", THIS_MODULE->name);
+	return 0;
+}
+
+static struct klp_func funcs[] = {
+	{
+		.old_name = "cmdline_proc_show",
+		.new_func = livepatch_cmdline_proc_show,
+	}, { }
+};
+
+static struct klp_object objs[] = {
+	{
+		/* name being NULL means vmlinux */
+		.funcs = funcs,
+	}, { }
+};
+
+static struct klp_patch patch = {
+	.mod = THIS_MODULE,
+	.objs = objs,
+};
+
+/* --- struct_ops registration --- */
+
+static int klp_bpf_cmdline_reg(void *kdata, struct bpf_link *link)
+{
+	struct klp_bpf_cmdline_ops *ops = kdata;
+
+	if (cmpxchg(&active_ops, NULL, ops))
+		return -EBUSY;
+
+	return 0;
+}
+
+static void klp_bpf_cmdline_unreg(void *kdata, struct bpf_link *link)
+{
+	WRITE_ONCE(active_ops, NULL);
+}
+
+static int klp_bpf_cmdline_init(struct btf *btf)
+{
+	return 0;
+}
+
+static int klp_bpf_cmdline_init_member(const struct btf_type *t,
+				       const struct btf_member *member,
+				       void *kdata, const void *udata)
+{
+	return 0;
+}
+
+static bool klp_bpf_cmdline_is_valid_access(int off, int size,
+					    enum bpf_access_type type,
+					    const struct bpf_prog *prog,
+					    struct bpf_insn_access_aux *info)
+{
+	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
+}
+
+static int klp_bpf_cmdline_btf_struct_access(struct bpf_verifier_log *log,
+					     const struct bpf_reg_state *reg,
+					     int off, int size)
+{
+	return -EACCES;
+}
+
+static const struct bpf_verifier_ops klp_bpf_cmdline_verifier_ops = {
+	.is_valid_access = klp_bpf_cmdline_is_valid_access,
+	.btf_struct_access = klp_bpf_cmdline_btf_struct_access,
+};
+
+/* CFI stubs */
+static int klp_bpf_cmdline__set_cmdline(struct seq_file *m)
+{
+	return 0;
+}
+
+static struct klp_bpf_cmdline_ops __bpf_klp_bpf_cmdline_ops = {
+	.set_cmdline = klp_bpf_cmdline__set_cmdline,
+};
+
+static struct bpf_struct_ops bpf_klp_bpf_cmdline_ops = {
+	.verifier_ops = &klp_bpf_cmdline_verifier_ops,
+	.init = klp_bpf_cmdline_init,
+	.init_member = klp_bpf_cmdline_init_member,
+	.reg = klp_bpf_cmdline_reg,
+	.unreg = klp_bpf_cmdline_unreg,
+	.cfi_stubs = &__bpf_klp_bpf_cmdline_ops,
+	.name = "klp_bpf_cmdline_ops",
+	.owner = THIS_MODULE,
+};
+
+/* --- Module init/exit --- */
+
+static int __init test_klp_bpf_init(void)
+{
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					&klp_bpf_kfunc_set);
+	ret = ret ?: register_bpf_struct_ops(&bpf_klp_bpf_cmdline_ops,
+					     klp_bpf_cmdline_ops);
+	if (ret)
+		return ret;
+
+	return klp_enable_patch(&patch);
+}
+
+static void __exit test_klp_bpf_exit(void)
+{
+}
+
+module_init(test_klp_bpf_init);
+module_exit(test_klp_bpf_exit);
+MODULE_LICENSE("GPL");
+MODULE_INFO(livepatch, "Y");
+MODULE_AUTHOR("Song Liu");
+MODULE_DESCRIPTION("Test: BPF struct_ops + livepatch integration");
diff --git a/tools/testing/selftests/bpf/test_kmods/test_klp_bpf.h b/tools/testing/selftests/bpf/test_kmods/test_klp_bpf.h
new file mode 100644
index 000000000000..0ead3681fb89
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_kmods/test_klp_bpf.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#ifndef _TEST_KLP_BPF_H
+#define _TEST_KLP_BPF_H
+
+struct seq_file;
+
+struct klp_bpf_cmdline_ops {
+	int (*set_cmdline)(struct seq_file *m);
+};
+
+#endif /* _TEST_KLP_BPF_H */
-- 
2.52.0

