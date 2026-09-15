Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143E73DC84C
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789484873; cv=none; b=Wc2D2+X0OI8HARoOdZmtTqIzt9FZDxuFGJ8DsvuC9fo4Lo3bUVMvujveo3odI9Dz2RTCZgaAiItIyVfLRePIYfxf+ww0Ri7K6fcEVyUJ6vBcdF1oSc8D/1JbNnSLEP7G4Wa7eva+qfiWiIXivY4KFzA7eOobfXcOMOFxAmZMOy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789484873; c=relaxed/simple;
	bh=S20KuxEur0XX7vYsiss+O8QXFB+6uDG65uGpZBwOsck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSDZhVHWSA4JIhAxLW6eaLvT8hiSvii3hDI7cqS9jNHnV95VnPyn9BMWXGg7UYhVdwvfSCdDz0scBKZ49M6sMSiZu7JvbYwBx8TENJ3j5GFz1NaoQfNd+DAuo1D5zqD2F//yXnjaWNMIXmX99jVjBXbxDcm6LmOjU0QP1OHMASc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=f6K+EAgK; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="f6K+EAgK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=zKklGPjS9Qxae8bhAF1kHSwGJGdApWDByuSXvA37X2E=; b=f6K+EAgK3aRGSduNjhoiIW5A6M
	ceeVKSAfZE9UgrgVI9LeSk75uoSDnbMdmcGJBYK+HvYVVqWdWkMa4wNAN3jRGgGUXng1qBGjrRwtF
	tgDoBLQUzdBpyKkNyffzB0yoU/IoJCPfpIcBjUJTHVc5HMgeyZo665i6R7YNSGtkkz/AwHWuldF5l
	rJ6RmpBRzX3a0OF21wrt2j6R6hhGu50JcAt74SQmXZ92qwoHvy2YfmAdQGLAjoku8a3zSxtcqZ+eP
	XoLP2uCBvQxBlFovbPdFa9dRoCtNJz6kiH8YJ/lGQKC3+PBM8ATXwrqRtZ2SXFhLkdsr1mzp7vn4e
	ATe4rIWg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x6Ul8-0007LA-2G;
	Tue, 15 Sep 2026 17:07:46 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: brauner@kernel.org,
	dwindsor@gmail.com,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 7/8] selftests/bpf: Add verifier tests for the __ctx_out plumbing
Date: Tue, 15 Sep 2026 17:07:38 +0200
Message-ID: <20260915150739.284189-8-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915150739.284189-1-daniel@iogearbox.net>
References: <20260915150739.284189-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28124/Tue Sep 15 08:27:28 2026)

Add BPF selftests to cover what a BPF program may and may not hand
to bpf_inode_init_xattr() as the inode_init_security hook's args.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t verifier_lsm_init_xattr
  [...]
  #649/1   verifier_lsm_init_xattr/reject_count_write:OK
  #649/2   verifier_lsm_init_xattr/allow_count_read:OK
  #649/3   verifier_lsm_init_xattr/reject_unchecked_xattrs:OK
  #649/4   verifier_lsm_init_xattr/reject_unchecked_qstr:OK
  #649/5   verifier_lsm_init_xattr/allow_spilled_count:OK
  #649/6   verifier_lsm_init_xattr/reject_forged_count:OK
  #649/7   verifier_lsm_init_xattr/reject_stack_count:OK
  #649/8   verifier_lsm_init_xattr/reject_other_ctx_arg:OK
  #649/9   verifier_lsm_init_xattr/reject_null_count:OK
  #649/10  verifier_lsm_init_xattr/reject_shifted_count:OK
  #649/11  verifier_lsm_init_xattr/reject_var_shifted_count:OK
  #649/12  verifier_lsm_init_xattr/reject_ctx_forged_count:OK
  #649/13  verifier_lsm_init_xattr/allow_count_via_subprog:OK
  #649/14  verifier_lsm_init_xattr/reject_shifted_xattrs:OK
  #649/15  verifier_lsm_init_xattr/reject_sleepable:OK
  #649/16  verifier_lsm_init_xattr/reject_lsm_cgroup:OK
  #649/17  verifier_lsm_init_xattr/reject_wrong_hook:OK
  #649     verifier_lsm_init_xattr:OK
  Summary: 1/17 PASSED, 0 SKIPPED, 0/0 FAILED

Co-developed-by: David Windsor <dwindsor@gmail.com>
Signed-off-by: David Windsor <dwindsor@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  19 +-
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_lsm_init_xattr.c       | 245 ++++++++++++++++++
 3 files changed, 262 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_lsm_init_xattr.c

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index ae71e9b69051..1b408fe9e0fb 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -78,18 +78,29 @@ extern void bpf_key_put(struct bpf_key *key) __ksym;
 extern int bpf_verify_pkcs7_signature(const struct bpf_dynptr *data_ptr,
 				      const struct bpf_dynptr *sig_ptr,
 				      struct bpf_key *trusted_keyring) __ksym;
-
-struct dentry;
-/* Description
+/*
+ * Description
  *  Returns xattr of a dentry
  * Returns
  *  Error code
  */
+struct dentry;
 extern int bpf_get_dentry_xattr(struct dentry *dentry, const char *name,
 			      struct bpf_dynptr *value_ptr) __ksym __weak;
-
 extern int bpf_set_dentry_xattr(struct dentry *dentry, const char *name__str,
 				const struct bpf_dynptr *value_p, int flags) __ksym __weak;
 extern int bpf_remove_dentry_xattr(struct dentry *dentry, const char *name__str) __ksym __weak;
 
+/*
+ * Description
+ *  Attach a xattr to an inode that is being created, from a program on the
+ *  inode_init_security LSM hook. *xattrs* and *xattr_count* must be the
+ *  hook's own arguments, passed through unmodified.
+ * Returns
+ *  0 on success, a negative value on error
+ */
+struct xattr;
+extern int bpf_inode_init_xattr(struct xattr *xattrs, int *xattr_count,
+				const char *name__str,
+				const struct bpf_dynptr *value_p) __ksym __weak;
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 7732df9bc870..973bbeda9318 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -130,6 +130,7 @@
 #include "verifier_bits_iter.skel.h"
 #include "verifier_set_retval.skel.h"
 #include "verifier_lsm.skel.h"
+#include "verifier_lsm_init_xattr.skel.h"
 #include "verifier_jit_inline.skel.h"
 #include "irq.skel.h"
 #include "verifier_ctx_ptr_param.skel.h"
@@ -294,6 +295,7 @@ void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_direct_pack
 void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
 void test_verifier_set_retval(void)            { RUN(verifier_set_retval); }
 void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
+void test_verifier_lsm_init_xattr(void)       { RUN(verifier_lsm_init_xattr); }
 void test_irq(void)			      { RUN(irq); }
 void test_verifier_mtu(void)		      { RUN(verifier_mtu); }
 void test_verifier_jit_inline(void)               { RUN(verifier_jit_inline); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_lsm_init_xattr.c b/tools/testing/selftests/bpf/progs/verifier_lsm_init_xattr.c
new file mode 100644
index 000000000000..b706bf17b556
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_lsm_init_xattr.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_kfuncs.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+const char xattr_zone[] = "security.bpf.zone";
+char value_buf[8] = "z";
+int scratch_count;
+
+SEC("lsm/inode_init_security")
+__failure __msg("cannot write into rdonly_trusted_mem")
+int BPF_PROG(reject_count_write, struct inode *inode, struct inode *dir,
+	     const struct qstr *qstr, struct xattr *xattrs, int *xattr_count)
+{
+	*xattr_count = 0;
+	return 0;
+}
+
+SEC("lsm/inode_init_security")
+__success
+int BPF_PROG(allow_count_read, struct inode *inode, struct inode *dir,
+	     const struct qstr *qstr, struct xattr *xattrs, int *xattr_count)
+{
+	scratch_count = *xattr_count;
+	return 0;
+}
+
+SEC("lsm/inode_init_security")
+__failure __msg("Possibly NULL pointer passed to trusted")
+int BPF_PROG(reject_unchecked_xattrs, struct inode *inode, struct inode *dir,
+	     const struct qstr *qstr, struct xattr *xattrs, int *xattr_count)
+{
+	struct bpf_dynptr value;
+
+	bpf_dynptr_from_mem(value_buf, sizeof(value_buf), 0, &value);
+	bpf_inode_init_xattr(xattrs, xattr_count, xattr_zone, &value);
+	return 0;
+}
+
+SEC("lsm/inode_init_security")
+__failure __msg("invalid mem access 'trusted_ptr_or_null_'")
+int BPF_PROG(reject_unchecked_qstr, struct inode *inode, struct inode *dir,
+	     const struct qstr *qstr, struct xattr *xattrs, int *xattr_count)
+{
+	scratch_count = qstr->len;
+	return 0;
+}
+
+SEC("lsm/inode_init_security")
+__success
+int BPF_PROG(allow_spilled_count, struct inode *inode, struct inode *dir,
+	     const struct qstr *qstr, struct xattr *xattrs, int *xattr_count)
+{
+	struct bpf_dynptr value;
+	int *saved = xattr_count;
+
+	if (!xattrs)
+		return 0;
+
+	bpf_dynptr_from_mem(value_buf, sizeof(value_buf), 0, &value);
+	bpf_inode_init_xattr(xattrs, saved, xattr_zone, &value);
+	return 0;
+}
+
+SEC("lsm/inode_init_security")
+__failure __msg("expected=rdonly_trusted_mem")
+int BPF_PROG(reject_forged_count, struct inode *inode, struct inode *dir,
+	     const struct qstr *qstr, struct xattr *xattrs, int *xattr_count)
+{
+	struct bpf_dynptr value;
+
+	if (!xattrs)
+		return 0;
+
+	bpf_dynptr_from_mem(value_buf, sizeof(value_buf), 0, &value);
+	bpf_inode_init_xattr(xattrs, &scratch_count, xattr_zone, &value);
+	return 0;
+}
+
+SEC("lsm/inode_init_security")
+__failure __msg("expected=rdonly_trusted_mem")
+int BPF_PROG(reject_stack_count, struct inode *inode, struct inode *dir,
+	     const struct qstr *qstr, struct xattr *xattrs, int *xattr_count)
+{
+	struct bpf_dynptr value;
+	int local = 0;
+
+	if (!xattrs)
+		return 0;
+
+	bpf_dynptr_from_mem(value_buf, sizeof(value_buf), 0, &value);
+	bpf_inode_init_xattr(xattrs, &local, xattr_zone, &value);
+	return 0;
+}
+
+SEC("lsm/inode_init_security")
+__failure __msg("expected=rdonly_trusted_mem")
+int BPF_PROG(reject_other_ctx_arg, struct inode *inode, struct inode *dir,
+	     const struct qstr *qstr, struct xattr *xattrs, int *xattr_count)
+{
+	struct bpf_dynptr value;
+
+	if (!xattrs)
+		return 0;
+
+	bpf_dynptr_from_mem(value_buf, sizeof(value_buf), 0, &value);
+	bpf_inode_init_xattr(xattrs, (int *)xattrs, xattr_zone, &value);
+	return 0;
+}
+
+SEC("lsm/inode_init_security")
+__failure __msg("Possibly NULL pointer passed to trusted")
+int BPF_PROG(reject_null_count, struct inode *inode, struct inode *dir,
+	     const struct qstr *qstr, struct xattr *xattrs, int *xattr_count)
+{
+	struct bpf_dynptr value;
+
+	if (!xattrs)
+		return 0;
+
+	bpf_dynptr_from_mem(value_buf, sizeof(value_buf), 0, &value);
+	bpf_inode_init_xattr(xattrs, NULL, xattr_zone, &value);
+	return 0;
+}
+
+SEC("lsm/inode_init_security")
+__failure __msg("dereference of modified rdonly_trusted_mem ptr")
+int BPF_PROG(reject_shifted_count, struct inode *inode, struct inode *dir,
+	     const struct qstr *qstr, struct xattr *xattrs, int *xattr_count)
+{
+	struct bpf_dynptr value;
+
+	if (!xattrs)
+		return 0;
+
+	bpf_dynptr_from_mem(value_buf, sizeof(value_buf), 0, &value);
+	bpf_inode_init_xattr(xattrs, xattr_count + 1, xattr_zone, &value);
+	return 0;
+}
+
+SEC("lsm/inode_init_security")
+__failure __msg("variable rdonly_trusted_mem access var_off=")
+int BPF_PROG(reject_var_shifted_count, struct inode *inode, struct inode *dir,
+	     const struct qstr *qstr, struct xattr *xattrs, int *xattr_count)
+{
+	struct bpf_dynptr value;
+
+	if (!xattrs)
+		return 0;
+
+	bpf_dynptr_from_mem(value_buf, sizeof(value_buf), 0, &value);
+	bpf_inode_init_xattr(xattrs, xattr_count + (scratch_count & 1),
+			     xattr_zone, &value);
+	return 0;
+}
+
+SEC("lsm/inode_init_security")
+__failure __msg("invalid bpf_context access")
+int reject_ctx_forged_count(unsigned long long *ctx)
+{
+	volatile unsigned long long *slot = ctx;
+	struct bpf_dynptr value;
+
+	bpf_dynptr_from_mem(value_buf, sizeof(value_buf), 0, &value);
+	slot[4] = 0;
+	bpf_inode_init_xattr((struct xattr *)(long)slot[3],
+			     (int *)(long)slot[4], xattr_zone, &value);
+	return 0;
+}
+
+static __noinline int claim_via_subprog(struct xattr *xattrs, int *xattr_count,
+					struct bpf_dynptr *value)
+{
+	return bpf_inode_init_xattr(xattrs, xattr_count, xattr_zone, value);
+}
+
+SEC("lsm/inode_init_security")
+__success
+int BPF_PROG(allow_count_via_subprog, struct inode *inode, struct inode *dir,
+	     const struct qstr *qstr, struct xattr *xattrs, int *xattr_count)
+{
+	struct bpf_dynptr value;
+
+	if (!xattrs)
+		return 0;
+
+	bpf_dynptr_from_mem(value_buf, sizeof(value_buf), 0, &value);
+	claim_via_subprog(xattrs, xattr_count, &value);
+	return 0;
+}
+
+SEC("lsm/inode_init_security")
+__failure __msg("access beyond struct xattr at off 24")
+int BPF_PROG(reject_shifted_xattrs, struct inode *inode, struct inode *dir,
+	     const struct qstr *qstr, struct xattr *xattrs, int *xattr_count)
+{
+	struct bpf_dynptr value;
+
+	if (!xattrs)
+		return 0;
+
+	bpf_dynptr_from_mem(value_buf, sizeof(value_buf), 0, &value);
+	bpf_inode_init_xattr(xattrs + 1, xattr_count, xattr_zone, &value);
+	return 0;
+}
+
+SEC("lsm.s/inode_init_security")
+__failure __msg("bpf_lsm_inode_init_security is not sleepable")
+int BPF_PROG(reject_sleepable, struct inode *inode, struct inode *dir,
+	     const struct qstr *qstr, struct xattr *xattrs, int *xattr_count)
+{
+	return 0;
+}
+
+SEC("lsm_cgroup/inode_init_security")
+__failure __msg("calling kernel function bpf_inode_init_xattr is not allowed")
+int BPF_PROG(reject_lsm_cgroup, struct inode *inode, struct inode *dir,
+	     const struct qstr *qstr, struct xattr *xattrs, int *xattr_count)
+{
+	struct bpf_dynptr value;
+
+	if (!xattrs)
+		return 0;
+
+	bpf_dynptr_from_mem(value_buf, sizeof(value_buf), 0, &value);
+	bpf_inode_init_xattr(xattrs, xattr_count, xattr_zone, &value);
+	return 0;
+}
+
+SEC("lsm/inode_setxattr")
+__failure __msg("calling kernel function bpf_inode_init_xattr is not allowed")
+int BPF_PROG(reject_wrong_hook, struct mnt_idmap *idmap, struct dentry *dentry,
+	     const char *name, const void *value, size_t size, int flags)
+{
+	struct bpf_dynptr val;
+
+	bpf_dynptr_from_mem(value_buf, sizeof(value_buf), 0, &val);
+	bpf_inode_init_xattr(NULL, &scratch_count, xattr_zone, &val);
+	return 0;
+}
-- 
2.43.0

