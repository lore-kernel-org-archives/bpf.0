Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342247;
	b=u1VCnG5AaLA4PplYXm47rKEZWBTh0DVlZZpOYy7SiNZXq1G/tiJg9gHtl35GkXPrmTou
	 rDbj8RgDBPoSB8svaWlnmA5iNUuKifkVpdcA5RDkdS1Zp7m6oxNssyCCTkaDzxRc8qjhA
	 SwEaQThigoOWohKtpk5/ihcV00P7FLMZFEYzo4ENOn6P5vJJpiBRboSx4IG1XuqPVxkMH
	 ZdKux5CUOi/AsRvCdaKwWRs7rx4CbxWXq2lTVBEtC0GP+jkIs2f1iNstK/bW2xWj6ZjE8
	 XN1yI2NDlhSMtmevz+Dh8CgEi0w0+/ZNby6YLKjuhXTnJaJfEA/naoLl3O+3WPnaiRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LtvZ3Gl7HiauN/U6RPjLeG8VrmAZzpATIBrE7cPT6wA=;
	b=GA5ATMCJOqozJO3FuBk7nF8wFdwdMykhLbiZGytMmeQXf7pgPDc6Rmv/2OuvjWF+4BiO
	 eQDdYUjRLsdDNzmgGonoaCVaTRwCGzCJmBI4RAa5Qsee4ip30Z3OIWvRjNmiLthpWkbMd
	 oghnvRu+QzlfgHYVZGhQ249T0GfFwPtxlloI2z348XR74exhQELLRrzOKbq8oI2GQBBiD
	 XE7Tu4qY+2q0hvzLx2jGMVcFiv9HucYel58RbWOHJHK3E6ml1d3isK2Y3eiS4YP3JAIDC
	 a2SZDCiFiXHXKUw7MZZXPLl/1xbVnlwPdejcMz61wCFDNbrs8WsL8MC7CJFaGrseelA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=armoriq.io;
	spf=pass smtp.mailfrom=armoriq.io;
	dkim=pass header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=l6bvDo0+;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D06606A31C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 20:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3D06606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armoriq.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armoriq.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=l6bvDo0+
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36dbde64409so5076098eec.0
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 12:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=armoriq-io.20260707.gappssmtp.com; s=20260707; t=1794342246; x=1794947046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LtvZ3Gl7HiauN/U6RPjLeG8VrmAZzpATIBrE7cPT6wA=;
        b=l6bvDo0+pc3hFYSP8FfMphOxN6t3K06Qu51QXQnyX3t8spxtZZUAx7ZgZZbh/2R4sj
         bDa9cQ15KilFwfwtIdFNixfJ5gfdpaxHygt5OA1k+CXuI8mIiJ//Ge13Wzp+J7P5J2Yk
         gWJ/quLW063uI+IFageMGeJcDtkS9hpBFsbm4bSy3hwy6EtDw0XT+L+W2Q9YylSWQ/2R
         SOraI42jz6oDqWJhaHtQjezuOh2Bt1dtFDE9MYIQny2i3NqOXHf2fqGdgmVTZDmGyyEw
         8F+i6oK9/+Zu6hu9wRNjN1KmUzEvgLknjlI3ti29TdXU5qqyhxgMdd/1K0IbEYCqhrcr
         uUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794342246; x=1794947046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LtvZ3Gl7HiauN/U6RPjLeG8VrmAZzpATIBrE7cPT6wA=;
        b=N5s5FkS1/sLG89tBtyVwPrsWEDi4XevFjxedR/f+ICzgzuvpIr5eFw403kyUQI/ef+
         JkFDVmyaa+Qhuq392Fmd8eMQx9rvlEKTbvKjmFA4i5QRZJdS7JQRfD35iKdv0rcI1U8T
         Osrp7YSzpyzkroFQ8S3mLH7eEuSONI6RmN42/o3ZyyEe1bB+pev6ImbqteO/f/pYXi5L
         +b0wASxuSLWZE5Mu3o5C6vzFOK5IjVqO3i0jMKdaswNgYhBRqa2DkD8P6CxHL3FdkdS+
         ToayxS+chBspEQ+mq1IFw9sWC+vKcR70YfF1bwjppw7tw5r4jgSWrMfuLjqK/dtEPIJV
         FnPA==
X-Forwarded-Encrypted: i=1; AL+hErGdrylZzrIzpG6E4p0YdDgrXv4U3x7ODDtsms5CmWKyFkpSqb5ZkdUJEvjWC5HGhSZsWTk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9UWLT8935fRbvGKzOwknqIVodFLKnLZL8VOa9nFO+Ri2TqRf7W
	ZPlJM/2xDcDrCzFFd/dpofa86Vi9e/673cMYIBWnJ3oTVjYAqTrjABdYN5Dd03njia5R
X-Gm-Gg: AYBFou1ZsItZ/L0ExWfWXnFv4Kd93pU6jDbat101T3/vGzZGXs++03F96c789O28MWU
	K1eJXPRWuKyoqITSltnU14QGnq/ikzBT0aorS5ctjdeAeYPi3bB8TK/X7QM0+THttKLqN7cKgc7
	WOMP7Sr5ba82n8+UVadEeFHvWY9oRQNV0zC55sdveRhgfdNttmChptrAQIVAQcAKVuv6LWVfXZ7
	yP8fAKlb8+cqJt7FicZnWgIZsY5Jv6FJMc1GP5gLiliFhr6eRaIcjMj82eQQO8jdQUo8DIJOm2i
	WHV+ha9wpqZHxzo7tVqFzN39KLFLT48aWi3lllVGXqPhpJLiLi4HZNnll4cRZPGXenUSO1eGAMY
	AuF7AQ4CIYLnvsImc/zhpsYPwcI9FCOws4N2RpWYr6kOiR/7JCyXZJqc2zP1TLb1a+EyOj9ckZk
	1Z1P2QqgD5oWyCR2FfoFhEHHEULVMyxtpclLiSmEufrkFAAVi2d5YfzI3iJroDFHhAOrruuXz3T
	S5BCr29d+gX+CZcy9aOUoturzpjkn9zbvvMEi0QrwhP7zdGDigq1ylRdcOV4pxXOyfVsUtAy1sG
	Msyh75YuD+jsSptl2l4IqwhH47XxI5sVbKVMr95l2p5aman5gkQ2kTtNUfEKt+VKySx8H50caOP
	ggHlgxpaSuOZlFq3T84nYfrSYgMyLu4d/OwzHXcZPweBErOZ5kQSytQ==
X-Received: by 2002:a05:7301:1a0d:b0:375:388:a6d5 with SMTP id 5a478bee46e88-376867551e5mr525868eec.32.1794342245674;
        Tue, 10 Nov 2026 12:24:05 -0800 (PST)
Received: from localhost.localdomain ([2409:40f4:147:2742:6545:702a:2431:7dca])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfe29fsm10076615eec.21.2026.11.10.12.23.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 12:24:05 -0800 (PST)
From: "HARIHARA SUDHAN. R" <harisudhan@armoriq.io>
To: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	Kees Cook <kees@kernel.org>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mel Gorman <mgorman@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Ketan Bhardwaj <ketan@armoriq.io>,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	"HARIHARA SUDHAN . R" <harisudhan@armoriq.io>
Subject: [RFC PATCH v3 4/6] security: kap: add the securityfs control plane
Date: Wed, 11 Nov 2026 01:52:44 +0530
Message-ID: <20261110202246.274-5-harisudhan@armoriq.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110202246.274-1-harisudhan@armoriq.io>
References: <20261110202246.274-1-harisudhan@armoriq.io>
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

Add the KAP control plane under /sys/kernel/security/kap.

securityfs has no mkdir, so igroups live in a small internal filesystem
mounted with kern_mount() and reached through the igroups link in the
kap directory, as AppArmor publishes its policy namespaces. An igroup is
created with mkdir, as a cgroup is, and gets one file per control:
kap.install writes the lineage root, authority epoch, expiry, transition
and authority in a single write that commits together or not at all,
and kap.procs binds a task. kap.default sits next to igroups/.

Writes need CAP_SYS_ADMIN. The internal filesystem type is never
registered, so it cannot be mounted from userspace.

Assisted-by: Claude
Co-developed-by: Ketan Bhardwaj <ketan@armoriq.io>
Signed-off-by: Ketan Bhardwaj <ketan@armoriq.io>
Signed-off-by: HARIHARA SUDHAN. R <harisudhan@armoriq.io>
---
 security/kap/Makefile  |   2 +-
 security/kap/kap_lsm.c |   1 +
 security/kap/kapfs.c   | 522 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 524 insertions(+), 1 deletion(-)
 create mode 100644 security/kap/kapfs.c

diff --git a/security/kap/Makefile b/security/kap/Makefile
index 40a864c..6ef7c5e 100644
--- a/security/kap/Makefile
+++ b/security/kap/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_SECURITY_KAP) := kap.o
-kap-y := kap_lsm.o igroup.o
+kap-y := kap_lsm.o igroup.o kapfs.o
diff --git a/security/kap/kap_lsm.c b/security/kap/kap_lsm.c
index b148b34..6750114 100644
--- a/security/kap/kap_lsm.c
+++ b/security/kap/kap_lsm.c
@@ -862,4 +862,5 @@ DEFINE_LSM(kap) = {
 	.id = &kap_lsmid,
 	.blobs = &kap_blob_sizes,
 	.init = kap_lsm_init,
+	.initcall_fs = kap_securityfs_init,
 };
diff --git a/security/kap/kapfs.c b/security/kap/kapfs.c
new file mode 100644
index 0000000..b182ff2
--- /dev/null
+++ b/security/kap/kapfs.c
@@ -0,0 +1,522 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kernel Assurance Plane control plane in securityfs.
+ *
+ *   /sys/kernel/security/kap/
+ *     kap.default
+ *     igroups/                 link to the root of the internal kapfs mount
+ *       <igroup>/              created with mkdir, as a cgroup is
+ *         kap.install
+ *         kap.procs
+ *         kap.igfd
+ *         kap.lineage_root
+ *         kap.authority_epoch
+ *         kap.authority
+ *         kap.expires_at
+ *         kap.transition
+ *         kap.mode
+ *         kap.events
+ *
+ * securityfs has no mkdir, so igroups live in a small internal filesystem that
+ * is mounted with kern_mount() and reached through a link under securityfs.
+ * AppArmor publishes its policy namespaces the same way.
+ */
+
+#define pr_fmt(fmt) "KAP: " fmt
+
+#include <linux/capability.h>
+#include <linux/ctype.h>
+#include <linux/dcache.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/fs_context.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/mount.h>
+#include <linux/spinlock.h>
+#include <linux/namei.h>
+#include <linux/security.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/timekeeping.h>
+#include <linux/uaccess.h>
+
+#include "kap.h"
+
+#define KAPFS_MAGIC 0x4b415046
+
+static struct vfsmount *kapfs_mnt;
+static struct dentry *kap_sfs_dir;
+static struct dentry *kap_sfs_default;
+static struct kap_file_ctx kap_default_ctx = { .kind = KAP_FILE_DEFAULT };
+
+static const char * const kap_file_names[KAP_FILE_COUNT] = {
+	[KAP_FILE_PROCS] = "kap.procs",
+	[KAP_FILE_IGFD] = "kap.igfd",
+	[KAP_FILE_LINEAGE_ROOT] = "kap.lineage_root",
+	[KAP_FILE_AUTHORITY_EPOCH] = "kap.authority_epoch",
+	[KAP_FILE_AUTHORITY] = "kap.authority",
+	[KAP_FILE_TRANSITION] = "kap.transition",
+	[KAP_FILE_MODE] = "kap.mode",
+	[KAP_FILE_EVENTS] = "kap.events",
+	[KAP_FILE_EXPIRES_AT] = "kap.expires_at",
+	[KAP_FILE_INSTALL] = "kap.install",
+};
+
+static const umode_t kap_file_modes[KAP_FILE_COUNT] = {
+	[KAP_FILE_PROCS] = 0600,
+	[KAP_FILE_IGFD] = 0400,
+	[KAP_FILE_LINEAGE_ROOT] = 0600,
+	[KAP_FILE_AUTHORITY_EPOCH] = 0600,
+	[KAP_FILE_AUTHORITY] = 0600,
+	[KAP_FILE_TRANSITION] = 0600,
+	[KAP_FILE_MODE] = 0600,
+	[KAP_FILE_EXPIRES_AT] = 0600,
+	[KAP_FILE_INSTALL] = 0200,
+	[KAP_FILE_EVENTS] = 0400,
+};
+
+static int kapfs_show(struct seq_file *m, void *v)
+{
+	struct kap_file_ctx *ctx = m->private;
+	struct kap_igroup *igroup = ctx->igroup;
+	struct kap_bound_pid *entry;
+
+	spin_lock(&kap_lock);
+	switch (ctx->kind) {
+	case KAP_FILE_PROCS:
+		list_for_each_entry(entry, &igroup->pids, node)
+			seq_printf(m, "%d\n", entry->pid);
+		break;
+	case KAP_FILE_IGFD:
+		seq_printf(m, "igroup=%s epoch=%llu root=%s\n",
+			   igroup->name, igroup->epoch, igroup->lineage_root);
+		break;
+	case KAP_FILE_LINEAGE_ROOT:
+		seq_printf(m, "%s\n", igroup->lineage_root);
+		break;
+	case KAP_FILE_AUTHORITY_EPOCH:
+		seq_printf(m, "%llu\n", igroup->epoch);
+		break;
+	case KAP_FILE_AUTHORITY:
+		seq_write(m, igroup->authority, igroup->authority_len);
+		if (igroup->authority_len && igroup->authority[igroup->authority_len - 1] != '\n')
+			seq_putc(m, '\n');
+		break;
+	case KAP_FILE_TRANSITION:
+		if (igroup->has_sequence)
+			seq_printf(m, "last_sequence=%llu\n", igroup->last_sequence);
+		break;
+	case KAP_FILE_MODE:
+		seq_printf(m, "%s\n", igroup->revoked ? "revoked" : "enforce");
+		break;
+	case KAP_FILE_EVENTS:
+		seq_write(m, igroup->events, igroup->events_len);
+		break;
+	case KAP_FILE_EXPIRES_AT:
+		seq_printf(m, "%llu\n", igroup->expires_at);
+		break;
+	case KAP_FILE_DEFAULT:
+		seq_printf(m, "%s\n", kap_default_closed ? "closed" : "open");
+		break;
+	default:
+		break;
+	}
+	spin_unlock(&kap_lock);
+	return 0;
+}
+
+static int kapfs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, kapfs_show, inode->i_private);
+}
+
+static ssize_t kapfs_write(struct file *file, const char __user *buf, size_t len, loff_t *ppos)
+{
+	struct seq_file *seq = file->private_data;
+	struct kap_file_ctx *ctx = seq->private;
+	struct kap_igroup *igroup = ctx->igroup;
+	struct kap_compiled_authority *compiled = NULL;
+	struct kap_bound_pid *entry = NULL;
+	struct kap_install_request req;
+	u64 value = 0;
+	pid_t pid = 0;
+	char *tmp;
+	int rc = 0;
+
+	/* The opener's credentials, so a handed-over descriptor gains nothing. */
+	if (!file_ns_capable(file, &init_user_ns, CAP_SYS_ADMIN))
+		return -EPERM;
+	if (len == 0)
+		return 0;
+	if (len > (ctx->kind == KAP_FILE_INSTALL ? KAP_MAX_INSTALL_BYTES
+						 : KAP_MAX_PREDICATE_BYTES))
+		return -EINVAL;
+	if (ctx->kind == KAP_FILE_EVENTS || ctx->kind == KAP_FILE_IGFD)
+		return -EINVAL;
+
+	tmp = memdup_user_nul(buf, len);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	kap_trim_newline(tmp);
+	if (!tmp[0]) {
+		kfree(tmp);
+		return len;
+	}
+
+	/* Parse, allocate and compile first: kap_lock is a spinlock. */
+	switch (ctx->kind) {
+	case KAP_FILE_PROCS:
+		rc = kstrtoint(tmp, 10, &pid);
+		if (!rc) {
+			entry = kzalloc_obj(*entry, GFP_KERNEL);
+			if (!entry)
+				rc = -ENOMEM;
+		}
+		break;
+	case KAP_FILE_LINEAGE_ROOT:
+		if (strlen(tmp) > KAP_MAX_ROOT_LEN)
+			rc = -EINVAL;
+		break;
+	case KAP_FILE_INSTALL:
+		rc = kap_install_parse(tmp, &req);
+		if (!rc)
+			rc = kap_authority_prepare(req.authority, &compiled);
+		break;
+	case KAP_FILE_AUTHORITY:
+		rc = kap_authority_prepare(tmp, &compiled);
+		break;
+	case KAP_FILE_AUTHORITY_EPOCH:
+	case KAP_FILE_EXPIRES_AT:
+		rc = kstrtou64(tmp, 10, &value);
+		break;
+	case KAP_FILE_TRANSITION:
+		rc = kap_parse_transition_sequence(tmp, &value);
+		break;
+	case KAP_FILE_MODE:
+		if (!sysfs_streq(tmp, "revoked") && !sysfs_streq(tmp, "enforce"))
+			rc = -EINVAL;
+		break;
+	case KAP_FILE_DEFAULT:
+		if (!sysfs_streq(tmp, "closed") && !sysfs_streq(tmp, "open"))
+			rc = -EINVAL;
+		break;
+	default:
+		rc = -EINVAL;
+		break;
+	}
+	if (rc)
+		goto out;
+
+	spin_lock(&kap_lock);
+	switch (ctx->kind) {
+	case KAP_FILE_PROCS:
+		rc = kap_bind_pid_locked(igroup, pid, &entry);
+		break;
+	case KAP_FILE_LINEAGE_ROOT:
+		strscpy(igroup->lineage_root, tmp, sizeof(igroup->lineage_root));
+		break;
+	case KAP_FILE_INSTALL:
+		rc = kap_install_locked(igroup, &req, &compiled);
+		break;
+	case KAP_FILE_AUTHORITY_EPOCH:
+		/* Writing an epoch also clears revoked mode. */
+		if (value < igroup->epoch) {
+			rc = -ESTALE;
+		} else {
+			igroup->epoch = value;
+			igroup->revoked = false;
+		}
+		break;
+	case KAP_FILE_AUTHORITY: {
+		struct kap_compiled_authority *old = igroup->compiled;
+
+		strscpy(igroup->authority, tmp, sizeof(igroup->authority));
+		igroup->authority_len = strlen(igroup->authority);
+		igroup->compiled = compiled;
+		compiled = old;
+		break;
+	}
+	case KAP_FILE_TRANSITION:
+		if (igroup->has_sequence && value <= igroup->last_sequence) {
+			rc = -EALREADY;
+		} else {
+			igroup->last_sequence = value;
+			igroup->has_sequence = true;
+		}
+		break;
+	case KAP_FILE_EXPIRES_AT:
+		/* An expiry already in the past is refused rather than installed. */
+		if (value && (u64)ktime_get_real_seconds() >= value)
+			rc = -ESTALE;
+		else
+			igroup->expires_at = value;
+		break;
+	case KAP_FILE_MODE:
+		igroup->revoked = sysfs_streq(tmp, "revoked");
+		break;
+	case KAP_FILE_DEFAULT:
+		WRITE_ONCE(kap_default_closed, sysfs_streq(tmp, "closed"));
+		break;
+	default:
+		break;
+	}
+	spin_unlock(&kap_lock);
+out:
+	/* Whatever was not consumed: a refused document, or the replaced one. */
+	kvfree(compiled);
+	kfree(entry);
+	kfree(tmp);
+	return rc ? rc : len;
+}
+
+static const struct file_operations kapfs_fops = {
+	.owner = THIS_MODULE,
+	.open = kapfs_open,
+	.read = seq_read,
+	.write = kapfs_write,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static struct inode *kapfs_make_inode(struct super_block *sb, umode_t mode)
+{
+	struct inode *inode = new_inode(sb);
+
+	if (!inode)
+		return NULL;
+	inode->i_ino = get_next_ino();
+	inode->i_mode = mode;
+	simple_inode_init_ts(inode);
+	return inode;
+}
+
+static void kapfs_instantiate(struct dentry *dentry, struct inode *inode)
+{
+	d_make_persistent(dentry, inode);
+}
+
+/* Names end up in kap.events and the kernel log, so keep them plain. */
+static bool kapfs_valid_name(const struct qstr *name)
+{
+	unsigned int i;
+
+	if (name->len == 0 || name->len > KAP_MAX_NAME_LEN || name->name[0] == '.')
+		return false;
+	for (i = 0; i < name->len; i++) {
+		unsigned char c = name->name[i];
+
+		if (!isalnum(c) && c != '-' && c != '_' && c != '.')
+			return false;
+	}
+	return true;
+}
+
+/* Returns NULL on success: the passed dentry is the one instantiated. */
+static struct dentry *kapfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				  struct dentry *dentry, umode_t mode)
+{
+	struct dentry *files[KAP_FILE_COUNT] = {};
+	struct inode *inodes[KAP_FILE_COUNT] = {};
+	struct kap_igroup *igroup;
+	struct inode *inode;
+	int rc = 0;
+	int i;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return ERR_PTR(-EPERM);
+	if (!kapfs_valid_name(&dentry->d_name))
+		return ERR_PTR(-EINVAL);
+
+	/* Allocate everything first, so a failure leaves nothing behind. */
+	igroup = kvzalloc_obj(*igroup, GFP_KERNEL);
+	inode = kapfs_make_inode(dir->i_sb, S_IFDIR | 0700);
+	if (!igroup || !inode) {
+		rc = -ENOMEM;
+		goto err;
+	}
+	memcpy(igroup->name, dentry->d_name.name, dentry->d_name.len);
+	INIT_LIST_HEAD(&igroup->pids);
+	INIT_LIST_HEAD(&igroup->node);
+	for (i = 0; i < KAP_FILE_COUNT; i++) {
+		files[i] = d_alloc_name(dentry, kap_file_names[i]);
+		inodes[i] = kapfs_make_inode(dir->i_sb, S_IFREG | kap_file_modes[i]);
+		if (!files[i] || !inodes[i]) {
+			rc = -ENOMEM;
+			goto err;
+		}
+		igroup->files[i].kind = i;
+		igroup->files[i].igroup = igroup;
+		inodes[i]->i_fop = &kapfs_fops;
+		inodes[i]->i_private = &igroup->files[i];
+	}
+
+	spin_lock(&kap_lock);
+	if (kap_find_igroup_locked(igroup->name))
+		rc = -EEXIST;
+	else
+		list_add_tail(&igroup->node, &kap_igroups);
+	spin_unlock(&kap_lock);
+	if (rc)
+		goto err;
+
+	inode->i_op = &simple_dir_inode_operations;
+	inode->i_fop = &simple_dir_operations;
+	inc_nlink(inode);
+	inc_nlink(dir);
+	/* Lookups in the new directory wait until its files are all there. */
+	inode_lock(inode);
+	kapfs_instantiate(dentry, inode);
+	igroup->dentry = dentry;
+	for (i = 0; i < KAP_FILE_COUNT; i++)
+		kapfs_instantiate(files[i], inodes[i]);
+	inode_unlock(inode);
+	return NULL;
+
+err:
+	for (i = 0; i < KAP_FILE_COUNT; i++) {
+		if (inodes[i])
+			iput(inodes[i]);
+		if (files[i])
+			dput(files[i]);
+	}
+	if (inode)
+		iput(inode);
+	kvfree(igroup);
+	return ERR_PTR(rc);
+}
+
+static const struct inode_operations kapfs_root_inode_ops = {
+	.lookup = simple_lookup,
+	.mkdir = kapfs_mkdir,
+};
+
+static int kapfs_fill_super(struct super_block *sb, struct fs_context *fc)
+{
+	struct inode *inode;
+
+	sb->s_magic = KAPFS_MAGIC;
+	inode = kapfs_make_inode(sb, S_IFDIR | 0700);
+	if (!inode)
+		return -ENOMEM;
+	inode->i_op = &kapfs_root_inode_ops;
+	inode->i_fop = &simple_dir_operations;
+	inc_nlink(inode);
+	sb->s_root = d_make_root(inode);
+	if (!sb->s_root)
+		return -ENOMEM;
+	return 0;
+}
+
+static int kapfs_get_tree(struct fs_context *fc)
+{
+	return get_tree_single(fc, kapfs_fill_super);
+}
+
+static const struct fs_context_operations kapfs_context_ops = {
+	.get_tree = kapfs_get_tree,
+};
+
+static int kapfs_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &kapfs_context_ops;
+	return 0;
+}
+
+/* Never registered, so it cannot be mounted from userspace. */
+static struct file_system_type kapfs_type = {
+	.owner = THIS_MODULE,
+	.name = "kapfs",
+	.init_fs_context = kapfs_init_fs_context,
+	.kill_sb = kill_anon_super,
+};
+
+static const char *kap_igroups_get_link(struct dentry *dentry,
+					struct inode *inode,
+					struct delayed_call *done)
+{
+	struct path path;
+	int rc;
+
+	if (!dentry)
+		return ERR_PTR(-ECHILD);
+	path.mnt = mntget(kapfs_mnt);
+	path.dentry = dget(kapfs_mnt->mnt_root);
+	rc = nd_jump_link(&path);
+	return ERR_PTR(rc);
+}
+
+static int kap_igroups_readlink(struct dentry *dentry, char __user *buffer,
+				int buflen)
+{
+	char name[32];
+	int rc;
+
+	rc = snprintf(name, sizeof(name), "kapfs:[%llu]",
+		      (unsigned long long)d_inode(kapfs_mnt->mnt_root)->i_ino);
+	if (rc <= 0 || rc >= sizeof(name))
+		return -ENOENT;
+	return readlink_copy(buffer, buflen, name, rc);
+}
+
+static const struct inode_operations kap_igroups_link_iops = {
+	.readlink = kap_igroups_readlink,
+	.get_link = kap_igroups_get_link,
+};
+
+int __init kap_securityfs_init(void)
+{
+	struct dentry *dent;
+	int rc;
+
+	if (!READ_ONCE(kap_lsm_active))
+		return 0;
+
+	kapfs_mnt = kern_mount(&kapfs_type);
+	if (IS_ERR(kapfs_mnt)) {
+		rc = PTR_ERR(kapfs_mnt);
+		kapfs_mnt = NULL;
+		goto err;
+	}
+	kapfs_mnt->mnt_sb->s_flags &= ~SB_NOUSER;
+
+	dent = securityfs_create_dir("kap", NULL);
+	if (IS_ERR(dent)) {
+		rc = PTR_ERR(dent);
+		goto err_unmount;
+	}
+	kap_sfs_dir = dent;
+
+	dent = securityfs_create_file("kap.default", 0600, kap_sfs_dir,
+				      &kap_default_ctx, &kapfs_fops);
+	if (IS_ERR(dent)) {
+		rc = PTR_ERR(dent);
+		goto err_remove;
+	}
+	kap_sfs_default = dent;
+
+	dent = securityfs_create_symlink("igroups", kap_sfs_dir, NULL,
+					 &kap_igroups_link_iops);
+	if (IS_ERR(dent)) {
+		rc = PTR_ERR(dent);
+		goto err_remove;
+	}
+
+	WRITE_ONCE(kap_ready, true);
+	pr_info("control plane at /sys/kernel/security/kap\n");
+	return 0;
+
+err_remove:
+	securityfs_remove(kap_sfs_default);
+	securityfs_remove(kap_sfs_dir);
+	kap_sfs_default = NULL;
+	kap_sfs_dir = NULL;
+err_unmount:
+	kern_unmount(kapfs_mnt);
+	kapfs_mnt = NULL;
+err:
+	pr_err("could not create the securityfs control plane: %d\n", rc);
+	return rc;
+}
-- 
2.53.0

