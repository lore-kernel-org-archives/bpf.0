Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B8943A7EB;
	Tue, 14 Jul 2026 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059109; cv=none; b=nWticQG29H9EIBRWXHd9/WIOeDdlcAUbEi/jM2zlGRNbEcw5sqP6OZXmsr84UYOP+7dREZN/5WkNx/yh+ApT+N9oACKU/su64MhsiXdZcXU5t1kMHZE1f/al8MTpKXRvaLfVXiyRYLkPskZVEHsYNDE5cvRW42QAUqVSIJPHeJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059109; c=relaxed/simple;
	bh=Af21M+ylxLpECXbXCOdMfHSPbWxM9IFOx2lOZpwjd6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K0bIE3KPjWL5dkyYuoh/qvZqUwtKw7XbDtsrrcbDn0OMG8vDBPyaprteB1Qq5m8RJp38iwkr2juuHZPnHB4Ru77BnGvLRyjKu5Q85GLxZUeXQq3K24cwqpULM4r1OlDxqr84swW2d6iRlU8NpZGt1fKoOvIPiDjrS1C9xOfqRK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzGZf7NF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzGZf7NF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AE91F000E9;
	Tue, 14 Jul 2026 19:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784059104;
	bh=NVvqavDGfIl0fJX8wV2T4POCQ/E/j1w1wRc+ocD3oSQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EzGZf7NFTnyAC/sg2KNCdz1DpGpMpA3+hQCH+fDdQuMs1kLUucQiF0pqA5L96MaQK
	 3HPpxiFriQ6A2mFQ+RLVXn84z+CTlat5OIZckgwNLw5hsnz5FuXx5BUE8k4CPab1RK
	 tZecQlX6ykymH5x1w8LRwdH4TbuM3jKCP5yTl3i4XF/wsQth6ZXe5sJxdLpWTUqcDo
	 ok7blIZENsOStEffex+ON7u5u81sZniXZJb62lrygnssItT8Y61/OZYLxIzI+i3aSs
	 UayoH7uMr/cmc2zKMZer8qIvfYa43/VxAGVCmw6muDe+ks1X5IjrAsNYBewhJ58SA0
	 SPajPf+tMvtOQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 14 Jul 2026 21:58:07 +0200
Subject: [PATCH v2 2/9] binfmt_misc: add binfmt_misc_ops bpf struct_ops
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-work-bpf-binfmt_misc-v2-2-57b7529c002c@kernel.org>
References: <20260714-work-bpf-binfmt_misc-v2-0-57b7529c002c@kernel.org>
In-Reply-To: <20260714-work-bpf-binfmt_misc-v2-0-57b7529c002c@kernel.org>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, bpf@vger.kernel.org, jannh@google.com, 
 mail@johnericson.me, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=19775; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Af21M+ylxLpECXbXCOdMfHSPbWxM9IFOx2lOZpwjd6w=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSFTbnMul79tcEd78d3GI/07GFxdq37252z7sfUfcfTr
 D1mlcgf6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIzBxGhgPnL+xV4mat6W4J
 eNMuZTgxVn99Lvv2qJ1L7pvtbW5dm8fIMO1owwcxe+sn8nlHzIq6pX//ySvu8mZpmx1oott2f8I
 3BgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add the bpf plumbing for binary type handlers whose matching and
interpreter selection are implemented by bpf programs instead of a
fixed magic/extension and a fixed interpreter string recorded at
registration time. This serves relocatable binary formats where the
interpreter must be computed per binary, e.g. relative to the location
of the binary itself, as discussed for hermetic Nix-style executables.

A handler is an instance of the new binfmt_misc_ops struct_ops with a
name that binfmt_misc entries reference it by and two ops:

        bool (*match)(struct linux_binprm *bprm);
        int (*load)(struct linux_binprm *bprm);

struct_ops is the sanctioned mechanism for this kind of user-supplied
policy callback: program types, attach types, and the uapi helper list
are frozen, and every recently added subsystem hook (bpf qdisc, SMC
handshake control, io_uring loop ops, sched_ext) is a struct_ops user.
The ops receive the bprm as a trusted BTF pointer, so a program can
match on the header in bprm->buf, read arbitrary file content via
bpf_dynptr_from_file() to parse e.g. ELF program headers, and inspect
the binary's location. No dedicated program type, ctx blob, or uapi
helper is needed.

The two ops split along what they decide, not what they may do: the
match program decides whether the handler applies to a binary, the
load program decides how a matched binary is run. Both are required
to be sleepable. Matching cannot be limited to the prefetched 256
bytes in bprm->buf: deciding whether a handler applies takes e.g.
parsing the ELF program headers to find an interpreter segment, which
sits at an arbitrary file offset, and non-sleepable file reads are
limited to whatever happens to be resident in the page cache. A match
program that cannot read the file reliably would have to match
broadly and leave the rejection to its load program, which breaks
first-match-wins entry semantics the moment more than one handler is
registered. Reliable file reads at exec time fault in the file's
pages, so both ops must be able to sleep. This also constrains the
caller: binfmt_misc must invoke both from sleepable context, which a
later patch takes care of. Both ops are required; a handler that
wants to decide everything from the load program supplies a match
program that just returns true.

The load program communicates its decisions through three new kfuncs:

        int bpf_binprm_set_interp(struct linux_binprm *bprm,
                                  const char *path, size_t path__sz);

selects the interpreter and enforces an absolute path shorter than
PATH_MAX.

        int bpf_binprm_set_interp_arg(struct linux_binprm *bprm,
                                      const char *arg, size_t arg__sz);

passes a single optional argument to the interpreter, mirroring the
optional argument of a #! interpreter line - something a static entry
cannot express at all.

        int bpf_binprm_set_flags(struct linux_binprm *bprm,
                                 enum bpf_binprm_flags flags);

chooses the invocation flags for this exec, with
BPF_BINPRM_PRESERVE_ARGV0, BPF_BINPRM_CREDENTIALS and
BPF_BINPRM_EXECFD mapping to 'P', 'C' and 'O'. Unknown bits are
rejected so a program built against a newer kernel fails loudly on an
older one rather than silently losing a flag. Repeated calls replace
the staged flags and a zero argument clears them again - the
set-or-clear semantics of bpf_bprm_opts_set() on the same struct. A
flags word carries this better than a kfunc per flag: it is one call,
it is set atomically, and new behaviour is a new bit rather than new
surface - the same shape the register string's flags field already
has.

All three stage their result in the bprm; consuming it from
load_misc_binary() is wired up by the following patches. The bprm is
exclusively owned by the task doing the exec, so no shared or per-CPU
state is involved and nothing here can race. The kfuncs are registered
for struct_ops programs with a filter that limits them to the load
program of a binfmt_misc_ops instance, keyed off the struct_ops member
offset the program attaches to: match decides whether a handler
applies, load decides how the binary is run, and the verifier enforces
that split at program load time.

Registering an ops instance (updating the struct_ops map or attaching
its link) publishes the handler under its name in a registry keyed by
the registering task's user namespace. Lookups walk the user namespace
hierarchy upwards, mirroring how binfmt_misc instances themselves are
resolved in current_binfmt_misc(). Consumers take a reference on the
ops via bpf_struct_ops_get() which pins the underlying map and
programs, so an activated handler keeps working even if the map is
deleted or the registering container goes away; deregistration only
prevents new activations, exactly like unregistering a tcp congestion
ops with live users.

Link: https://lore.kernel.org/20260704211409.1978485-1-farid.m.zakaria@gmail.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/Kconfig.binfmt           |  14 ++
 fs/Makefile                 |   1 +
 fs/binfmt_misc_bpf.c        | 349 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/binfmt_misc.h |  71 +++++++++
 4 files changed, 435 insertions(+)

diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 1949e25c7741..daeac4889d03 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -168,6 +168,20 @@ config BINFMT_MISC
 	  you have use for it; the module is called binfmt_misc. If you
 	  don't know what to answer at this point, say Y.
 
+config BINFMT_MISC_BPF
+	bool "BPF-selected interpreters for misc binaries"
+	depends on BINFMT_MISC=y
+	depends on BPF_SYSCALL && BPF_JIT && DEBUG_INFO_BTF
+	help
+	  Allow binfmt_misc binary type handlers to be implemented as bpf
+	  struct_ops programs. Instead of matching a fixed magic and
+	  redirecting to a fixed interpreter recorded at registration time
+	  such handlers match binaries programmatically and compute the
+	  interpreter to use per binary, e.g. relative to the location of
+	  the binary itself.
+
+	  If you don't know what to answer at this point, say N.
+
 config COREDUMP
 	bool "Enable core dump support" if EXPERT
 	default y
diff --git a/fs/Makefile b/fs/Makefile
index 89a8a9d207d1..499c6670f0c1 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_FS_ENCRYPTION)	+= crypto/
 obj-$(CONFIG_FS_VERITY)		+= verity/
 obj-$(CONFIG_FILE_LOCKING)      += locks.o
 obj-$(CONFIG_BINFMT_MISC)	+= binfmt_misc.o
+obj-$(CONFIG_BINFMT_MISC_BPF)	+= binfmt_misc_bpf.o
 obj-$(CONFIG_BINFMT_SCRIPT)	+= binfmt_script.o
 obj-$(CONFIG_BINFMT_ELF)	+= binfmt_elf.o
 obj-$(CONFIG_COMPAT_BINFMT_ELF)	+= compat_binfmt_elf.o
diff --git a/fs/binfmt_misc_bpf.c b/fs/binfmt_misc_bpf.c
new file mode 100644
index 000000000000..00c787e8bdcc
--- /dev/null
+++ b/fs/binfmt_misc_bpf.c
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * BPF-backed binary type handlers for binfmt_misc.
+ *
+ * A handler is a struct binfmt_misc_ops struct_ops map. Loading and
+ * registering it makes the handler available under its name in the user
+ * namespace it was registered in. A binfmt_misc 'B' entry activates it:
+ *
+ *   echo ':entry:B::::<handler-name>:' > <binfmt_misc>/register
+ */
+
+#include <linux/binfmt_misc.h>
+#include <linux/binfmts.h>
+#include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/cred.h>
+#include <linux/init.h>
+#include <linux/limits.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/user_namespace.h>
+
+struct bm_bpf_ops_reg {
+	struct list_head list;
+	const struct binfmt_misc_ops *ops;
+	struct bpf_link *link;
+	struct user_namespace *user_ns;
+};
+
+static DEFINE_SPINLOCK(bm_bpf_ops_lock);
+static LIST_HEAD(bm_bpf_ops_list);
+
+static struct bpf_struct_ops bpf_binfmt_misc_ops;
+
+static struct bm_bpf_ops_reg *bm_bpf_ops_find(const struct user_namespace *user_ns,
+					      const char *name)
+{
+	struct bm_bpf_ops_reg *reg;
+
+	lockdep_assert_held(&bm_bpf_ops_lock);
+
+	list_for_each_entry(reg, &bm_bpf_ops_list, list) {
+		if (reg->user_ns == user_ns && !strcmp(reg->ops->name, name))
+			return reg;
+	}
+	return NULL;
+}
+
+/**
+ * binfmt_misc_get_ops - look up a bpf binary type handler by name
+ * @user_ns: user namespace of the binfmt_misc instance
+ * @name: name the handler was registered under
+ *
+ * Search @user_ns and its ancestors for a handler named @name, mirroring
+ * the instance lookup in current_binfmt_misc(). The returned handler stays
+ * callable until binfmt_misc_put_ops() even if the backing struct_ops map
+ * is detached or deleted in the meantime.
+ *
+ * Return: the handler on success, NULL on failure
+ */
+const struct binfmt_misc_ops *binfmt_misc_get_ops(struct user_namespace *user_ns,
+						  const char *name)
+{
+	const struct user_namespace *ns;
+	struct bm_bpf_ops_reg *reg;
+
+	guard(spinlock)(&bm_bpf_ops_lock);
+
+	for (ns = user_ns; ns; ns = ns->parent) {
+		reg = bm_bpf_ops_find(ns, name);
+		if (!reg)
+			continue;
+		if (!bpf_struct_ops_get(reg->ops))
+			return NULL;
+		return reg->ops;
+	}
+	return NULL;
+}
+
+void binfmt_misc_put_ops(const struct binfmt_misc_ops *ops)
+{
+	bpf_struct_ops_put(ops);
+}
+
+bool bpf_prog_is_binfmt_misc_ops(const struct bpf_prog *prog)
+{
+	return prog->type == BPF_PROG_TYPE_STRUCT_OPS &&
+	       prog->aux->st_ops == &bpf_binfmt_misc_ops;
+}
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_binprm_set_interp - select the interpreter for the current exec
+ * @bprm: binary that is being executed
+ * @path: absolute path to the interpreter
+ * @path__sz: size of the @path buffer, including the terminating NUL
+ *
+ * To be called from the load program of a struct binfmt_misc_ops handler
+ * before returning zero; the verifier rejects the call from any other
+ * program, including the handler's own match program. The path is opened
+ * with the credentials of the task doing the exec after the program
+ * returns.
+ *
+ * Return: 0 on success, a negative errno on failure
+ */
+__bpf_kfunc int bpf_binprm_set_interp(struct linux_binprm *bprm,
+				      const char *path, size_t path__sz)
+{
+	size_t len;
+	char *interp;
+
+	if (!path__sz)
+		return -EINVAL;
+	len = strnlen(path, path__sz);
+	if (len == path__sz)
+		return -EINVAL;
+	if (path[0] != '/')
+		return -EINVAL;
+	if (len >= PATH_MAX)
+		return -ENAMETOOLONG;
+
+	interp = kmemdup_nul(path, len, GFP_KERNEL);
+	if (!interp)
+		return -ENOMEM;
+
+	kfree(bprm->bpf_interp);
+	bprm->bpf_interp = interp;
+	return 0;
+}
+
+/**
+ * bpf_binprm_set_interp_arg - set a single argument for the interpreter
+ * @bprm: binary that is being executed
+ * @arg: argument to pass to the interpreter
+ * @arg__sz: size of the @arg buffer, including the terminating NUL
+ *
+ * To be called from the load program of a struct binfmt_misc_ops handler. The
+ * argument is passed to the interpreter ahead of the binary, mirroring the
+ * single optional argument of a #! interpreter line. Calling it again
+ * replaces the argument.
+ *
+ * Return: 0 on success, a negative errno on failure
+ */
+__bpf_kfunc int bpf_binprm_set_interp_arg(struct linux_binprm *bprm,
+					  const char *arg, size_t arg__sz)
+{
+	size_t len;
+	char *val;
+
+	if (!arg__sz)
+		return -EINVAL;
+	len = strnlen(arg, arg__sz);
+	if (len == arg__sz)
+		return -EINVAL;
+	if (!len)
+		return -EINVAL;
+
+	val = kmemdup_nul(arg, len, GFP_KERNEL);
+	if (!val)
+		return -ENOMEM;
+
+	kfree(bprm->bpf_interp_arg);
+	bprm->bpf_interp_arg = val;
+	return 0;
+}
+
+/**
+ * bpf_binprm_set_flags - choose the interpreter invocation flags for this exec
+ * @bprm: binary that is being executed
+ * @flags: an OR of enum bpf_binprm_flags values
+ *
+ * To be called from the load program of a struct binfmt_misc_ops handler. It
+ * decides per exec what a static entry fixes at registration with the P, C and
+ * O flags: BPF_BINPRM_PRESERVE_ARGV0 keeps the caller's argv[0],
+ * BPF_BINPRM_CREDENTIALS computes credentials from the binary, and
+ * BPF_BINPRM_EXECFD hands the binary to the interpreter through AT_EXECFD.
+ * Calling it again replaces the flags, passing zero clears them again.
+ *
+ * Return: 0 on success, -EINVAL if @flags contains an unknown bit
+ */
+__bpf_kfunc int bpf_binprm_set_flags(struct linux_binprm *bprm,
+				     enum bpf_binprm_flags flags)
+{
+	if (flags & ~(BPF_BINPRM_PRESERVE_ARGV0 | BPF_BINPRM_CREDENTIALS |
+		      BPF_BINPRM_EXECFD))
+		return -EINVAL;
+
+	bprm->bpf_flags = flags;
+	return 0;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bm_bpf_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_binprm_set_interp, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_binprm_set_interp_arg, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_binprm_set_flags, KF_SLEEPABLE)
+BTF_KFUNCS_END(bm_bpf_kfunc_ids)
+
+static int bm_bpf_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&bm_bpf_kfunc_ids, kfunc_id))
+		return 0;
+	/* Only the load program decides how a binary is run. */
+	if (bpf_prog_is_binfmt_misc_ops(prog) &&
+	    prog->aux->attach_st_ops_member_off == offsetof(struct binfmt_misc_ops, load))
+		return 0;
+	return -EACCES;
+}
+
+static const struct btf_kfunc_id_set bm_bpf_kfunc_set = {
+	.owner	= THIS_MODULE,
+	.set	= &bm_bpf_kfunc_ids,
+	.filter	= bm_bpf_kfunc_filter,
+};
+
+static bool bm_bpf_ops__match(struct linux_binprm *bprm)
+{
+	return false;
+}
+
+static int bm_bpf_ops__load(struct linux_binprm *bprm)
+{
+	return 0;
+}
+
+static struct binfmt_misc_ops bm_bpf_ops_stubs = {
+	.match = bm_bpf_ops__match,
+	.load = bm_bpf_ops__load,
+};
+
+static int bm_bpf_init(struct btf *btf)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					 &bm_bpf_kfunc_set);
+}
+
+static int bm_bpf_check_member(const struct btf_type *t,
+			       const struct btf_member *member,
+			       const struct bpf_prog *prog)
+{
+	u32 moff = __btf_member_bit_offset(t, member) / 8;
+
+	switch (moff) {
+	case offsetof(struct binfmt_misc_ops, match):
+	case offsetof(struct binfmt_misc_ops, load):
+		/* Reliable file reads at exec time require sleeping. */
+		if (!prog->sleepable)
+			return -EINVAL;
+		break;
+	}
+	return 0;
+}
+
+static int bm_bpf_init_member(const struct btf_type *t,
+			      const struct btf_member *member,
+			      void *kdata, const void *udata)
+{
+	const struct binfmt_misc_ops *uops = udata;
+	struct binfmt_misc_ops *ops = kdata;
+	u32 moff = __btf_member_bit_offset(t, member) / 8;
+
+	switch (moff) {
+	case offsetof(struct binfmt_misc_ops, name):
+		if (bpf_obj_name_cpy(ops->name, uops->name,
+				     sizeof(ops->name)) <= 0)
+			return -EINVAL;
+		return 1;
+	}
+	return 0;
+}
+
+static int bm_bpf_validate(void *kdata)
+{
+	struct binfmt_misc_ops *ops = kdata;
+
+	if (!ops->match || !ops->load)
+		return -EINVAL;
+	return 0;
+}
+
+static int bm_bpf_reg(void *kdata, struct bpf_link *link)
+{
+	struct binfmt_misc_ops *ops = kdata;
+	struct bm_bpf_ops_reg *reg;
+
+	reg = kzalloc_obj(*reg, GFP_KERNEL_ACCOUNT);
+	if (!reg)
+		return -ENOMEM;
+
+	reg->ops = ops;
+	reg->link = link;
+	reg->user_ns = get_user_ns(current_user_ns());
+
+	guard(spinlock)(&bm_bpf_ops_lock);
+
+	if (bm_bpf_ops_find(reg->user_ns, ops->name)) {
+		put_user_ns(reg->user_ns);
+		kfree(reg);
+		return -EEXIST;
+	}
+
+	list_add(&reg->list, &bm_bpf_ops_list);
+	return 0;
+}
+
+static void bm_bpf_unreg(void *kdata, struct bpf_link *link)
+{
+	struct bm_bpf_ops_reg *reg;
+
+	guard(spinlock)(&bm_bpf_ops_lock);
+
+	list_for_each_entry(reg, &bm_bpf_ops_list, list) {
+		if (reg->ops == kdata && reg->link == link) {
+			list_del(&reg->list);
+			put_user_ns(reg->user_ns);
+			kfree(reg);
+			return;
+		}
+	}
+}
+
+static const struct bpf_verifier_ops bm_bpf_verifier_ops = {
+	.get_func_proto		= bpf_base_func_proto,
+	.is_valid_access	= bpf_tracing_btf_ctx_access,
+};
+
+static struct bpf_struct_ops bpf_binfmt_misc_ops = {
+	.verifier_ops	= &bm_bpf_verifier_ops,
+	.init		= bm_bpf_init,
+	.check_member	= bm_bpf_check_member,
+	.init_member	= bm_bpf_init_member,
+	.validate	= bm_bpf_validate,
+	.reg		= bm_bpf_reg,
+	.unreg		= bm_bpf_unreg,
+	.cfi_stubs	= &bm_bpf_ops_stubs,
+	.name		= "binfmt_misc_ops",
+	.owner		= THIS_MODULE,
+};
+
+static int __init bm_bpf_struct_ops_init(void)
+{
+	return register_bpf_struct_ops(&bpf_binfmt_misc_ops, binfmt_misc_ops);
+}
+late_initcall(bm_bpf_struct_ops_init);
diff --git a/include/linux/binfmt_misc.h b/include/linux/binfmt_misc.h
new file mode 100644
index 000000000000..d3112a00cc19
--- /dev/null
+++ b/include/linux/binfmt_misc.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_BINFMT_MISC_H
+#define _LINUX_BINFMT_MISC_H
+
+#include <linux/types.h>
+
+struct bpf_prog;
+struct linux_binprm;
+struct user_namespace;
+
+#define BINFMT_MISC_OPS_NAME_MAX 16
+
+/**
+ * enum bpf_binprm_flags - per-exec invocation flags a load program can request
+ * @BPF_BINPRM_PRESERVE_ARGV0: keep the caller's argv[0] (like the 'P' flag)
+ * @BPF_BINPRM_CREDENTIALS: compute credentials from the binary; implies execfd
+ *                          (like the 'C' flag)
+ * @BPF_BINPRM_EXECFD: pass the binary via AT_EXECFD (like the 'O' flag)
+ *
+ * Set from a load program with bpf_binprm_set_flags(). Unlike a static entry,
+ * a bpf handler chooses these per exec rather than once at registration.
+ */
+enum bpf_binprm_flags {
+	BPF_BINPRM_PRESERVE_ARGV0	= (1ULL << 0),
+	BPF_BINPRM_CREDENTIALS		= (1ULL << 1),
+	BPF_BINPRM_EXECFD		= (1ULL << 2),
+};
+
+/**
+ * struct binfmt_misc_ops - bpf-backed binary type handler
+ * @match: decide whether the handler applies to @bprm; consulted from the
+ *         entry lookup walk like static magic and extension matching, in
+ *         registration order with first-match-wins semantics; sleepable,
+ *         so it can read the binary to decide, but the verifier rejects
+ *         the interpreter selection kfuncs in it
+ * @load:  select an interpreter for the matched @bprm via
+ *         bpf_binprm_set_interp() and return zero; a match is committed, so
+ *         a failure fails the exec instead of falling through to later
+ *         entries; -ENOEXEC does not fail the exec but moves on to the
+ *         remaining binary formats
+ * @name: name that 'B' entries reference the handler by
+ */
+struct binfmt_misc_ops {
+	bool (*match)(struct linux_binprm *bprm);
+	int (*load)(struct linux_binprm *bprm);
+	char name[BINFMT_MISC_OPS_NAME_MAX];
+};
+
+#ifdef CONFIG_BINFMT_MISC_BPF
+const struct binfmt_misc_ops *binfmt_misc_get_ops(struct user_namespace *user_ns,
+						  const char *name);
+void binfmt_misc_put_ops(const struct binfmt_misc_ops *ops);
+bool bpf_prog_is_binfmt_misc_ops(const struct bpf_prog *prog);
+#else
+static inline const struct binfmt_misc_ops *
+binfmt_misc_get_ops(struct user_namespace *user_ns, const char *name)
+{
+	return NULL;
+}
+
+static inline void binfmt_misc_put_ops(const struct binfmt_misc_ops *ops)
+{
+}
+
+static inline bool bpf_prog_is_binfmt_misc_ops(const struct bpf_prog *prog)
+{
+	return false;
+}
+#endif /* CONFIG_BINFMT_MISC_BPF */
+
+#endif /* _LINUX_BINFMT_MISC_H */

-- 
2.53.0

