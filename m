Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DED4611C7
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188448; cv=none; b=V34vauhcbPldV9UewsW0xaV6C037ydi9+ZNK5zkURpNp1cj32qANbqX0ySwwPV6G+9LRXUBZ4LPxHl7J2GeLhNIaTFQQq5PXYwOIUnbMT4HWkz4CxgO9BmG1pGbMmysS7NYyKZEZ4HfOGbpGK2ty9T9qDzW9opfjSBNWxdHBFxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188448; c=relaxed/simple;
	bh=y8vKV0EbX3uwzWTuiC7zAtR24C/exA4HkGBQ/YwAlKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MoA+77u68snvsV2fz3z8m6hUWH/5Xno4LCFs2qvltx0l9YgKpnFhG40LA/E4KuOwrP39TpwWzsREyAfrGUnA1Gq5/5vnXsEQLyYJ/UagsMz+aoXMWw+Au5jbo7g3eTI92cwUtrwEtdu2yHRtxf7aQM9NBIupBA6Zzuw7rjnzszc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJsupqP7; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJsupqP7"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-861feb6d61bso16014517b3.2
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 08:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788188446; x=1788793246; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RiftMX2c5AE5hdKP1oNX+6YGtpBCsKTcAAXYc0whhFw=;
        b=GJsupqP7En+Cx56W2MKVbSdRhVzoYyZGBitZyyiJv6M9H4+seB26qk+15gJyo/63ir
         CCXE6kumBUmHea3+2NTaycsOlMpRKZU6OBwKgOB4wzJNdACDYFdLOCDuJq7W0ZBB+46J
         Lwlwp3vSO4NwFUvIuO3JqQIQ88PBi6d97yg91EiSo9spQv40jSbZpN8ZBDtBjBiaEt9W
         qF98xP1CBaN9RXON833dgJyljbC9JxyHUViFt75msox3n8fDRrNAF17lFtUfb1/ynHbA
         r891FnEK6x/x0Ogg8t8WgfJhIMQZ34xllg0dbCFg8oUztBoImL9hAS8CfJUAHEMVBMIv
         I6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188446; x=1788793246;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RiftMX2c5AE5hdKP1oNX+6YGtpBCsKTcAAXYc0whhFw=;
        b=NG+ws7mtXmFCZ2Y52xkM4zuVL4++Rl54IzCBMd1Wn09E/ZRq44Qgfrvda2LoCB/Xsm
         gTLuyIMW+rFrNLmcUEaQ0evQr+iih6K6cyyD6FAdLggplJFxV+ChSBfl4tkNY+jBt5d8
         fukOUVTVu6v5Vb92HeIkVXZvLX6wwoR+RQ3Fq7SxSHzKhwiYJ1nJV5/HzAFTp7+7AOMX
         LeHXfiQZ9caC6xv8L520Vgho3L06CLTD0dKHYpVOzAwZFOP/btVI/FU7jMdG8Vj2SpaO
         COTNko/8KYvRYoX0XW0slQ7aiWeBpLP4ZQRFMkfJHQsw37FlRFb8xBplZg/4caQZG2+X
         2ECQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJoaldKbh0opvf5GNQZnqgX5oLSHnff1ib9BoVVT0AQ7R7L5IQZKS7GHJkna9xeJrLfL8=@vger.kernel.org
X-Gm-Message-State: AFuF++noQUy7xOrtQiWDmvNYr3N5LFaZyGs+OLzP+bbBOekopB4zwCtL
	eJRtnfPtfIahGmT6y3zeRtMatZ6CMuX46I7j9iQ87kAK1Omjx6nwnya4tQ0xAi+q
X-Gm-Gg: AYBFou3W1lvJdZRUcRE8L1w6j8EDkxSIpVcjMduPcwFZofLhExAGXMfcrrg1Y/q38Sg
	TMbqIdTJ5ZHSJ3RFa39avt0TfZpuZh1ty0IV7fOOM+CTuy1kzpSdpCJu+0R8iEhf5M5VvyNtHA0
	H+RT2rHHmpWlO7BQ/3AQMJjzZkhaFusC37YIfieScBA4PC91t0kQBGLsgA+PF7RfOBXg9WTteds
	6mZy6I/pzf1e2VUsVNhkGb0EQ0TrBD9VOExoTITmuOu41FE07V2tiuGZl/fjZUe+SPXy4dTcPkT
	94uws9tBcysy934SL/cw5Xdcafe6f31KmmiPXm+fvdRXUBxD8xTHwj/5QPAyBgj4/pyI4dhUU5v
	zOI+9QBLvBHj9ldX4BQHsMs8goxT8vx3zKUNJxDh5Iqie9EvW8Jir9PD3St+cx++mvINYrAUl2J
	lOouy6T9z2ooym5B151X1KVZTTodL1G5oOBGj283iNcv9L90vrPbyU1vj8ZejNcarzyMmJtphwX
	mle2M8CXeydp1eCeSFjtkM=
X-Received: by 2002:a05:690c:a7c2:b0:822:ee08:749 with SMTP id 00721157ae682-8686ed6877emr7087787b3.6.1788188444975;
        Mon, 31 Aug 2026 08:00:44 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:f6fc:b424:b1bb:6ff0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e58666e15sm53903827b3.0.2026.08.31.08.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:00:42 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v2 13/15] landlock: Implement the LSM policy object hooks
Date: Mon, 31 Aug 2026 10:58:55 -0400
Message-ID: <20260831145858.3869191-14-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831145858.3869191-1-utilityemal77@gmail.com>
References: <20260831145858.3869191-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement the generic LSM hooks exposing Landlock rulesets as policy
objects to BPF.  The new code is gated on CONFIG_BPF_LSM, the only
configuration where the kfuncs calling the hooks exist.

struct lsm_policy_object is embedded in struct landlock_ruleset and
tagged with LSM_ID_LANDLOCK and LANDLOCK_POLICY_TYPE_RULESET at
ruleset creation; the hooks resolve the ruleset with container_of()
and no Landlock type crosses the LSM boundary.  The type namespace is
private to Landlock and routes the container_of() resolution once
several policy object types exist: the consuming hooks reject an
object of an unexpected type with -EINVAL (the put hook, which cannot
fail, warns instead), while from_fd only produces objects and needs
no check.  The embedded object sits outside the union overlaying the
deferred-free work item: an RCU reader may still read its identity
while a queued free waits out the grace period.

- policy_object_from_fd() translates a ruleset fd, created with
  landlock_create_ruleset(2) and populated with landlock_add_rule(2),
  into an owned ruleset reference, validated the same way as for the
  Landlock syscalls (ruleset file type, FMODE_CAN_READ).  A fd
  referring to a file that is not a Landlock ruleset is declined with
  -EOPNOTSUPP instead of the syscall's -EBADFD: it may be another
  LSM's policy object, and the decline lets the framework offer it to
  the LSM it belongs to.

- policy_object_put() releases such a reference.  The hook may be
  reached from BPF object destructors that cannot sleep, which is
  fine: ruleset puts queue the free as RCU work.

- policy_object_get() acquires an additional reference for a caller
  that only holds an RCU-protected pointer, e.g. loaded from a BPF
  map kptr field under rcu_read_lock().  The reference is taken with
  refcount_inc_not_zero(); the racing reader's access to the ruleset
  memory is safe because rulesets are freed after an RCU grace
  period.

- bprm_apply_policy_object() shares the landlock_restrict_self(2)
  path: it calls landlock_prepare_restriction() on the credentials
  prepared in the binprm and stages the computed restriction (the
  merged struct landlock_domain) in their Landlock blob.  The flags
  are the landlock_restrict_self(2) flags; only
  LANDLOCK_RESTRICT_SELF_TSYNC is rejected with -EINVAL because the
  restriction targets the execution, not the calling threads.

LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS is honored, not ignored: the
syscall implements it directly in landlock_restrict_self(), so the
staged path reads it back from the staged restriction's flags and
sets no_new_privs on the executing task at application time.  The
executed program then starts with no_new_privs set, binding it and
all its descendants; the current execution's
privilege computation is unaffected, as the bprm credentials
(including any setuid elevation) were computed before
bprm_committing_creds().

The staged restriction is enforced by a bprm_committing_creds() hook
with the same landlock_apply_restriction() call as the syscall, past
the exec point of no return: an execution either starts confined by
the domain or, if it fails earlier, leaves the calling task
untouched.  The applied layer is accounted in domain_exec so the
LOG_SAME_EXEC and LOG_NEW_EXEC audit flags follow the executed
program.  There is no no_new_privs/CAP_SYS_ADMIN precondition here:
gating who may load a policy-applying BPF program is the BPF
attachment's privilege model.

The application emits the landlock_enforce_domain trace event,
keeping the event's invariant that every enforcement falls between
the domain's create_domain and free_domain events.  The process is
single-threaded past de_thread(), so the single event concludes the
operation with complete == 1 and process_wide == 1.  no_new_privs
reports the post-flag state; on this path a value of 0 carries no
authorization meaning and only tells the observer that the confined
program can still elevate through future setuid execs, which the
event's documentation now spells out.

The staged restriction's lifetime is fully covered: a second
bprm_apply_policy_object() call on the same execution releases and
replaces the previously staged restriction, an execution failing
before the point of no return releases it through hook_cred_free(),
and the application clears the staged domain so committed task
credentials never carry one.  landlock_cred_copy(), now also used by
hook_cred_transfer(), upholds that invariant by never copying a
staged restriction.

Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 include/trace/events/landlock.h |  15 +++-
 security/landlock/Makefile      |   2 +
 security/landlock/bpf.c         | 152 ++++++++++++++++++++++++++++++++
 security/landlock/bpf.h         |  21 +++++
 security/landlock/cred.c        |  16 ++--
 security/landlock/cred.h        |  16 ++++
 security/landlock/limits.h      |   4 +
 security/landlock/ruleset.c     |   6 ++
 security/landlock/ruleset.h     |  22 +++++
 security/landlock/setup.c       |   2 +
 10 files changed, 245 insertions(+), 11 deletions(-)
 create mode 100644 security/landlock/bpf.c
 create mode 100644 security/landlock/bpf.h

diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index f82588f6f90e..012ab9dcccb2 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -500,13 +500,22 @@ TRACE_EVENT(landlock_create_domain,
  *                enforcement time: 1 if set (by a prior
  *                :manpage:`prctl(2)` %PR_SET_NO_NEW_PRIVS or by
  *                %LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS), 0 if the domain
- *                was enforced with %CAP_SYS_ADMIN instead.
+ *                was enforced with %CAP_SYS_ADMIN instead, or without
+ *                either precondition on the BPF exec path (see below).
  *
  * Emitted for each thread sys_landlock_restrict_self() enforces the
  * domain on, in that thread's own context, right after its
  * commit_creds(), so it fires only once the thread is irreversibly
- * enforcing the domain (aborted operations emit none).  Not
- * balanced; every enforcement falls between the domain's
+ * enforcing the domain (aborted operations emit none).  Also emitted
+ * at execve(2)'s point of no return when a BPF-staged policy object
+ * is applied to the execution (see bpf_lsm_policy_apply_bprm()): the
+ * process is single-threaded after de_thread(), so the single event
+ * has @complete == 1 and @process_wide == 1.  On that path,
+ * @no_new_privs == 0 carries no authorization meaning (the authority
+ * is the privilege to attach the BPF program, not
+ * no_new_privs/%CAP_SYS_ADMIN); it only tells the observer that the
+ * confined program can still elevate through future setuid execs.
+ * Not balanced; every enforcement falls between the domain's
  * landlock_create_domain and landlock_free_domain events.
  *
  * @complete == 1 && @process_wide == 1 means the whole process is
diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index 2711f4876939..606bc91522e2 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -20,3 +20,5 @@ landlock-$(CONFIG_SECURITY_LANDLOCK_LOG) += \
 landlock-$(CONFIG_AUDIT) += audit.o
 
 landlock-$(CONFIG_TRACEPOINTS) += trace.o
+
+landlock-$(CONFIG_BPF_LSM) += bpf.o
diff --git a/security/landlock/bpf.c b/security/landlock/bpf.c
new file mode 100644
index 000000000000..28dc68013251
--- /dev/null
+++ b/security/landlock/bpf.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock - LSM policy object hooks
+ *
+ * Copyright © 2026 Justin Suess <utilityemal77@gmail.com>
+ */
+
+#include <linux/binfmts.h>
+#include <linux/cred.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/lsm_hooks.h>
+#include <linux/sched.h>
+#include <uapi/linux/landlock.h>
+
+#include "bpf.h"
+#include "cred.h"
+#include "domain.h"
+#include "limits.h"
+#include "ruleset.h"
+#include "setup.h"
+
+#include <trace/events/landlock.h>
+
+static int hook_bprm_apply_policy_object(struct linux_binprm *bprm,
+					 struct lsm_policy_object *object,
+					 u32 flags)
+{
+	struct landlock_cred_security *bprm_llcred = landlock_cred(bprm->cred);
+	struct landlock_ruleset *ruleset;
+	struct landlock_restriction restriction;
+	int err;
+
+	if (object->type != LANDLOCK_POLICY_TYPE_RULESET)
+		return -EINVAL;
+
+	ruleset = container_of(object, struct landlock_ruleset, policy_object);
+
+	/*
+	 * landlock_restrict_self(2) flags minus TSYNC, which targets
+	 * the calling threads, not the execution.
+	 */
+	if ((flags | LANDLOCK_MASK_RESTRICT_BINPRM) !=
+	    LANDLOCK_MASK_RESTRICT_BINPRM)
+		return -EINVAL;
+
+	err = landlock_prepare_restriction(bprm_llcred, ruleset, flags,
+					   &restriction);
+	if (err)
+		return err;
+
+	/*
+	 * Replaces (and releases) a previously staged restriction.
+	 * Nothing is enforced until bprm_committing_creds(); a failed
+	 * execution drops the staged restriction in hook_cred_free().
+	 */
+	landlock_put_domain(bprm_llcred->staged.domain);
+	bprm_llcred->staged = restriction;
+	return 0;
+}
+
+static void hook_bprm_committing_creds(const struct linux_binprm *bprm)
+{
+	struct landlock_cred_security *bprm_llcred = landlock_cred(bprm->cred);
+	struct landlock_domain *domain = bprm_llcred->staged.domain;
+
+	if (!domain)
+		return;
+
+	/* Set first so the enforcement event reports the post-flag state. */
+	if (bprm_llcred->staged.flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS)
+		task_set_no_new_privs(current);
+
+	/* The application clears @staged's domain pointer. */
+	landlock_apply_restriction(bprm_llcred, &bprm_llcred->staged);
+
+	/*
+	 * Past de_thread(), the process is single-threaded: this single
+	 * event both concludes the operation and covers the whole
+	 * process.
+	 */
+	trace_landlock_enforce_domain(domain, true, true,
+				      task_no_new_privs(current));
+}
+
+static int hook_policy_object_from_fd(int fd, struct lsm_policy_object **object)
+{
+	struct landlock_ruleset *ruleset;
+
+	ruleset = landlock_get_ruleset_from_fd(fd, FMODE_CAN_READ);
+	if (IS_ERR(ruleset)) {
+		if (ruleset == ERR_PTR(-EBADFD))
+			return -EOPNOTSUPP;
+		return PTR_ERR(ruleset);
+	}
+
+	*object = &ruleset->policy_object;
+	return 0;
+}
+
+/*
+ * The caller holds no reference, only an RCU-protected pointer: the
+ * RCU-deferred ruleset free keeps the memory valid for the
+ * inc_not_zero() race against a concurrent last put.
+ */
+static int hook_policy_object_get(struct lsm_policy_object *object)
+{
+	struct landlock_ruleset *ruleset;
+
+	if (object->type != LANDLOCK_POLICY_TYPE_RULESET)
+		return -EINVAL;
+
+	ruleset = container_of(object, struct landlock_ruleset, policy_object);
+	if (!refcount_inc_not_zero(&ruleset->usage))
+		return -ENOENT;
+	return 0;
+}
+
+static void hook_policy_object_put(struct lsm_policy_object *object)
+{
+	struct landlock_ruleset *ruleset;
+
+	/*
+	 * The type routes the container_of() resolution once several
+	 * policy object types exist; only rulesets are referenced today.
+	 */
+	if (WARN_ON_ONCE(object->type != LANDLOCK_POLICY_TYPE_RULESET))
+		return;
+
+	ruleset = container_of(object, struct landlock_ruleset, policy_object);
+
+	/*
+	 * May be reached from BPF object destructors that cannot sleep,
+	 * which is fine: the put queues the free as RCU work.
+	 */
+	landlock_put_ruleset(ruleset);
+}
+
+static struct security_hook_list landlock_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(bprm_apply_policy_object, hook_bprm_apply_policy_object),
+	LSM_HOOK_INIT(bprm_committing_creds, hook_bprm_committing_creds),
+	LSM_HOOK_INIT(policy_object_from_fd, hook_policy_object_from_fd),
+	LSM_HOOK_INIT(policy_object_get, hook_policy_object_get),
+	LSM_HOOK_INIT(policy_object_put, hook_policy_object_put),
+};
+
+__init void landlock_add_bpf_hooks(void)
+{
+	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
+			   &landlock_lsmid);
+}
diff --git a/security/landlock/bpf.h b/security/landlock/bpf.h
new file mode 100644
index 000000000000..7c0f199c630a
--- /dev/null
+++ b/security/landlock/bpf.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock - LSM policy object hooks
+ *
+ * Copyright © 2026 Justin Suess <utilityemal77@gmail.com>
+ */
+
+#ifndef _SECURITY_LANDLOCK_BPF_H
+#define _SECURITY_LANDLOCK_BPF_H
+
+#include <linux/init.h>
+
+#ifdef CONFIG_BPF_LSM
+__init void landlock_add_bpf_hooks(void);
+#else /* CONFIG_BPF_LSM */
+static inline void landlock_add_bpf_hooks(void)
+{
+}
+#endif /* CONFIG_BPF_LSM */
+
+#endif /* _SECURITY_LANDLOCK_BPF_H */
diff --git a/security/landlock/cred.c b/security/landlock/cred.c
index f02706f12c7d..8e5b1b6c165e 100644
--- a/security/landlock/cred.c
+++ b/security/landlock/cred.c
@@ -151,11 +151,7 @@ void landlock_apply_restriction(struct landlock_cred_security *const llcred,
 static void hook_cred_transfer(struct cred *const new,
 			       const struct cred *const old)
 {
-	const struct landlock_cred_security *const old_llcred =
-		landlock_cred(old);
-
-	landlock_get_domain(old_llcred->domain);
-	*landlock_cred(new) = *old_llcred;
+	landlock_cred_copy(landlock_cred(new), landlock_cred(old));
 }
 
 static int hook_cred_prepare(struct cred *const new,
@@ -167,10 +163,14 @@ static int hook_cred_prepare(struct cred *const new,
 
 static void hook_cred_free(struct cred *const cred)
 {
-	struct landlock_domain *const dom = landlock_cred(cred)->domain;
+	struct landlock_cred_security *const llcred = landlock_cred(cred);
+
+	landlock_put_domain_deferred(llcred->domain);
 
-	if (dom)
-		landlock_put_domain_deferred(dom);
+#ifdef CONFIG_BPF_LSM
+	/* Releases a restriction staged for an aborted execution. */
+	landlock_put_domain_deferred(llcred->staged.domain);
+#endif /* CONFIG_BPF_LSM */
 }
 
 #ifdef CONFIG_SECURITY_LANDLOCK_LOG
diff --git a/security/landlock/cred.h b/security/landlock/cred.h
index 88fa97fc3bd2..9a2971197892 100644
--- a/security/landlock/cred.h
+++ b/security/landlock/cred.h
@@ -59,6 +59,16 @@ struct landlock_cred_security {
 	 */
 	struct landlock_domain *domain;
 
+#ifdef CONFIG_BPF_LSM
+	/**
+	 * @staged: Restriction staged by the bprm_apply_policy_object() hook,
+	 * owning its domain reference, applied at bprm_committing_creds().
+	 * Only ever set on credentials prepared for an execution; committed
+	 * task credentials never carry a staged restriction.
+	 */
+	struct landlock_restriction staged;
+#endif /* CONFIG_BPF_LSM */
+
 #ifdef CONFIG_SECURITY_LANDLOCK_LOG
 	/**
 	 * @domain_exec: Bitmask identifying the domain layers that were enforced by
@@ -99,6 +109,12 @@ static inline void landlock_cred_copy(struct landlock_cred_security *dst,
 	*dst = *src;
 
 	landlock_get_domain(src->domain);
+
+#ifdef CONFIG_BPF_LSM
+	/* Only bprm credentials own a staged restriction: never copied. */
+	WARN_ON_ONCE(src->staged.domain);
+	dst->staged = (struct landlock_restriction){};
+#endif /* CONFIG_BPF_LSM */
 }
 
 static inline struct landlock_domain *landlock_get_current_domain(void)
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 1a7c5fb8f6fd..9aeb99b2f173 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -37,6 +37,10 @@
 #define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
 #define LANDLOCK_MASK_RESTRICT_SELF	((LANDLOCK_LAST_RESTRICT_SELF << 1) - 1)
 
+/* Subset of the restrict-self flags applicable to an execution. */
+#define LANDLOCK_MASK_RESTRICT_BINPRM \
+	(LANDLOCK_MASK_RESTRICT_SELF & ~LANDLOCK_RESTRICT_SELF_TSYNC)
+
 /* clang-format on */
 
 #endif /* _SECURITY_LANDLOCK_LIMITS_H */
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 00a6b9938fd1..6de326b71a5a 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -23,6 +23,7 @@
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 #include <uapi/linux/landlock.h>
+#include <uapi/linux/lsm.h>
 
 #include "access.h"
 #include "id.h"
@@ -51,6 +52,11 @@ landlock_create_ruleset(const access_mask_t fs_access_mask,
 	mutex_init(&new_ruleset->lock);
 	new_ruleset->rules.root_inode = RB_ROOT;
 
+#ifdef CONFIG_BPF_LSM
+	new_ruleset->policy_object.lsmid = LSM_ID_LANDLOCK;
+	new_ruleset->policy_object.type = LANDLOCK_POLICY_TYPE_RULESET;
+#endif /* CONFIG_BPF_LSM */
+
 #if IS_ENABLED(CONFIG_INET)
 	new_ruleset->rules.root_net_port = RB_ROOT;
 #endif /* IS_ENABLED(CONFIG_INET) */
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 1465f8a5c464..22edb140bb7f 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -15,6 +15,7 @@
 #include <linux/mutex.h>
 #include <linux/rbtree.h>
 #include <linux/refcount.h>
+#include <linux/security.h>
 #include <linux/workqueue.h>
 
 #include "access.h"
@@ -146,6 +147,16 @@ struct landlock_rules {
 	u32 num_rules;
 };
 
+#ifdef CONFIG_BPF_LSM
+/*
+ * Landlock's lsm_policy_object types.  The namespace is private to
+ * Landlock; 0 stays reserved as "unset".
+ */
+enum landlock_policy_type {
+	LANDLOCK_POLICY_TYPE_RULESET = 1,
+};
+#endif /* CONFIG_BPF_LSM */
+
 /**
  * struct landlock_ruleset - Landlock ruleset
  *
@@ -157,6 +168,17 @@ struct landlock_ruleset {
 	 * @rules: Red-black tree storage for rules.
 	 */
 	struct landlock_rules rules;
+
+#ifdef CONFIG_BPF_LSM
+	/**
+	 * @policy_object: Identity under which the ruleset is handed out
+	 * to BPF programs as a referenced kptr: the LSM policy kfuncs
+	 * dispatch back to Landlock through its lsmid.  Kept outside the
+	 * union with @work_free: RCU readers may read its lsmid while a
+	 * queued free waits out the grace period.
+	 */
+	struct lsm_policy_object policy_object;
+#endif /* CONFIG_BPF_LSM */
 	/**
 	 * @usage: Number of file descriptors referencing this ruleset.  Kept
 	 * outside the union with @work_free: RCU readers may still call
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index 47dac1736f10..3b7e18edadfb 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -11,6 +11,7 @@
 #include <linux/lsm_hooks.h>
 #include <uapi/linux/lsm.h>
 
+#include "bpf.h"
 #include "common.h"
 #include "cred.h"
 #include "errata.h"
@@ -68,6 +69,7 @@ static int __init landlock_init(void)
 	landlock_add_task_hooks();
 	landlock_add_fs_hooks();
 	landlock_add_net_hooks();
+	landlock_add_bpf_hooks();
 	landlock_init_id();
 	landlock_initialized = true;
 	pr_info("Up and running.\n");
-- 
2.55.0

