Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698643A6B76
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775668300; cv=none; b=anUmSiuqCenAB4n1ORs2sxiOFXYwpscyi5vJjcNjYAO8MoS1r/TdGh6ih1OyZWLnk63B6cBt1nCxB2BOx3/3l3zvmh55pM6R/8ko7J7kJ+xmJxbJkMo11trjP8dypfr7nopWbHrr9bphi6YCPaIiF5sxq0mfSgX2no6C17m0upg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775668300; c=relaxed/simple;
	bh=skTHfg5nopiPlA39+yQldHS0YW2EP7eSiDJo+l9/xQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZyBGPYqdUBOr/huZCr73IuuqIoWWkOPBFYPeVtvmrGbYM6L/+Sm9qyz0+K67+tM7atHC5ygUVZjgpt1SyyDqhqWjB8cdrljH2zaLK3+znyDfFBZ3zvxf+nHm+eyfxPPXEeFPErRHYr++nX/3XR4chRS5RpIYJT/geKbhVn2jUPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfiL7iWA; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfiL7iWA"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79827d28fc4so1439107b3.1
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 10:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775668297; x=1776273097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/8rwKhb/x/3zExFoHaPVXkH6YxE9ylkF1qlsN1QT9k=;
        b=NfiL7iWABBYC684D4DiCzXjKdpSKu/4ng2g2wgycuNom0EORiSUL+2rHIZVINKkwu7
         wBeG7VC9OCkN5glXS+8HWG/60PJdneGSF/NDCDwjMfrjPyER1vYS/RlPiu0ycYSp/TRc
         Ak81q9i1oEgp1zduAPJVx7a0CRflUsR01sLMX3Ulc3Rz1L6kckmIVYbRvxsurBKNhgFZ
         qXppVPv7aZkhxsD6Rp6KShC7Vmw0DLSQygD4vf8fo5jNa1xCn2FEJMDjAXk3yAvawEeA
         T58rT4u+9egl0i/A5COlWS4YvSFSYOsf416sIuXfAWCmqffkzYlcaP9B4WzwKo/ijadY
         2pVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775668297; x=1776273097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q/8rwKhb/x/3zExFoHaPVXkH6YxE9ylkF1qlsN1QT9k=;
        b=fzna8W523/L7/+YaTn502wYTxWsD+21Iz50aK0onOEe7xzV4FEAim6I4rWPSRnwIhC
         RXoc3XEvcpMrFU+7kb04C3D5dQ4uIzGzIQmx1OlfxyNJiOgl7u3COkmfkXyPMi3gstv4
         Et3N6BMCSzhds+n+6C4qqN2i8rFKklTcB73QCmhYksQgugmp2ekWQo7NyKIdUCvNnA6t
         Htrf/3xheQz6vsRW+o+H1bg33rMUBsRPRBlYbYc0gBGXGmdpc2VRu1sjgZTO64Jza/7y
         fVQLqNy3dE+EKBlxlcbbKmJhJj/89o9S/itVocHKs0W6W+KRm1TmlnhwBbFcd4q4us39
         fOiA==
X-Forwarded-Encrypted: i=1; AJvYcCUbm6aFuhi4kgguY6Bj5N9i5GP4VT5K/E2FtT63KydFFHs9EgQwUzeQB87kwxRThXH0zuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqihNjwG5yMe592uocyrN+NnG6UTxIF3rAY5gjnSD/SXZlWAkm
	2XrupRXL3Avgc+dvJOwO5za0s4iScGjkh/XxzKbJABr0XPMV3AQGiMna
X-Gm-Gg: AeBDies6ILgJ1LAv3D/o4QGz5WrIVVS4J5f5u0qqb+wZPhvHeBAlyE3W/lPelavDOBy
	5S5yH/ARCi3EBUj2gxyCUJ4a0sg4PM5IZaPdwKNYviYM9ZmaE4VhSNkIsafcCEmjquJ6EY6Had3
	6PEYJCYmVp7718vHttpswDdjgmpmwWDjyhtujxPNQib+s0Q764Cty8uPAmkCZkZM8vStC4dm25N
	/+4WrXs4NhxCbqZPhVa+2K5Yj61+fWskKVbVmYnkUfGjjytbXNOSSqLCykhzeMJKtMDZqGmvZAr
	pep6lrluEMAnXB7RMXTkFkb99sSMbTze3V34dPGJKIGKMT+kFQi9fSC6O7dSf4ww0BzRfp04zCY
	5nTMOWnDdKhpVHa5UW7eag56x+qxCAO7UeVz0ssvNkrV8ljxOSCYFDW/cAydhdZtjqMh+TRPa1D
	WTnte6q+l5V6X8BRHa1wqKdPF1N+teCpi3WNITPGB1WEkQqAH3CEHeDXvSvK+cgg2eRTp78qBY
X-Received: by 2002:a05:690c:63c2:b0:79b:d1d9:daac with SMTP id 00721157ae682-7a4d8cad324mr216124687b3.38.1775668297224;
        Wed, 08 Apr 2026 10:11:37 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:4f39:118b:d212:714e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e22b926sm91175117b3.5.2026.04.08.10.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 10:11:36 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: mic@digikod.net
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	fred@cloudflare.com,
	gnoack@google.com,
	jack@suse.cz,
	jmorris@namei.org,
	john.fastabend@gmail.com,
	kees@kernel.org,
	kpsingh@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	m@maowtm.org,
	martin.lau@linux.dev,
	paul@paul-moore.com,
	Justin Suess <utilityemal77@gmail.com>
Subject: Re: [RFC PATCH 00/20] BPF interface for applying Landlock rulesets
Date: Wed,  8 Apr 2026 13:10:28 -0400
Message-ID: <20260408171030.4083129-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408.ong9Eshe0omu@digikod.net>
References: <20260408.ong9Eshe0omu@digikod.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Add a flag LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS, which executes
task_set_no_new_privs on the current credentials, but only if
the process lacks the CAP_SYS_ADMIN capability.

While this operation is redundant for code running from userspace
(indeed callers may achieve the same logic by calling
prctl w/ PR_SET_NO_NEW_PRIVS), this flag enables callers without access
to the syscall abi (defined in subsequent patches) to restrict processes
from gaining additional capabilities. This is important to ensure that
consumers can meet the task_no_new_privs || CAP_SYS_ADMIN invariant
enforced by Landlock without having syscall access.

This is done by hooking bprm_committing_creds along with a
landlock_cred_security flag to indicate that the next execution should
task_set_no_new_privs if the process doesn't possess CAP_SYS_ADMIN. This
is done to ensure that task_set_no_new_privs is being done past the
point of no return.

Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

On Wed, Apr 08, 2026 at 02:00:00 -0000, Mickaël Salaün wrote:
> > Points of Feedback
> > ===
> > 
> > First, the new set_nnp_on_point_of_no_return field in struct linux_binprm.
> > This field was needed to request that task_set_no_new_privs be set during an
> > execution, but only after the execution has proceeded beyond the point of no
> > return. I couldn't find a way to express this semantic without adding a new
> > bitfield to struct linux_binprm and a conditional in fs/exec.c. Please see
> > patch 2.

> What about using security_bprm_committing_creds()?

Good idea. Definitely cleaner.

Something like this? Then dropping the "execve: Add set_nnp_on_point_of_no_return"
commit.

This adds a bitfield to the landlock_cred_security struct to indicate that the flag
should be set on the next exec(s).

 include/uapi/linux/landlock.h | 14 ++++++++++++++
 security/landlock/cred.c      | 13 +++++++++++++
 security/landlock/cred.h      |  7 +++++++
 security/landlock/limits.h    |  2 +-
 security/landlock/ruleset.c   | 15 ++++++++++++---
 security/landlock/syscalls.c  |  5 +++++
 6 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index f88fa1f68b77..edd9d9a7f60e 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -129,12 +129,26 @@ struct landlock_ruleset_attr {
  *
  *     If the calling thread is running with no_new_privs, this operation
  *     enables no_new_privs on the sibling threads as well.
+ *
+ * %LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
+ *    Sets no_new_privs on the calling thread before applying the Landlock domain.
+ *    This flag is useful for convenience as well as for applying a ruleset from
+ *    an outside context (e.g BPF). This flag only has an effect on when both
+ *    no_new_privs isn't already set and the caller doesn't possess CAP_SYS_ADMIN.
+ *
+ *    This flag has slightly different behavior when used from BPF. Instead of
+ *    setting no_new_privs on the current task, it sets a flag on the bprm so that
+ *    no_new_privs is set on the task at exec point-of-no-return. This guarantees
+ *    that the current execution is unaffected, and may escalate as usual until the
+ *    next exec, but the resulting task cannot gain more privileges through later
+ *    exec transitions.
  */
 /* clang-format off */
 #define LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF		(1U << 0)
 #define LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON			(1U << 1)
 #define LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF		(1U << 2)
 #define LANDLOCK_RESTRICT_SELF_TSYNC				(1U << 3)
+#define LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS			(1U << 4)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/cred.c b/security/landlock/cred.c
index 0cb3edde4d18..bcc9b716916f 100644
--- a/security/landlock/cred.c
+++ b/security/landlock/cred.c
@@ -43,6 +43,18 @@ static void hook_cred_free(struct cred *const cred)
 		landlock_put_ruleset_deferred(dom);
 }
 
+static void hook_bprm_committing_creds(const struct linux_binprm *bprm)
+{
+	struct landlock_cred_security *const llcred = landlock_cred(bprm->cred);
+
+	if (llcred->set_nnp_on_committing_creds &&
+	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN)) {
+		task_set_no_new_privs(current);
+		/* Don't need to set it again for subsequent execution. */
+		llcred->set_nnp_on_committing_creds = false;
+	}
+}
+
 #ifdef CONFIG_AUDIT
 
 static int hook_bprm_creds_for_exec(struct linux_binprm *const bprm)
@@ -55,6 +67,7 @@ static int hook_bprm_creds_for_exec(struct linux_binprm *const bprm)
 #endif /* CONFIG_AUDIT */
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(bprm_committing_creds, hook_bprm_committing_creds),
 	LSM_HOOK_INIT(cred_prepare, hook_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, hook_cred_transfer),
 	LSM_HOOK_INIT(cred_free, hook_cred_free),
diff --git a/security/landlock/cred.h b/security/landlock/cred.h
index c10a06727eb1..7ec6dd12ebc3 100644
--- a/security/landlock/cred.h
+++ b/security/landlock/cred.h
@@ -49,6 +49,13 @@ struct landlock_cred_security {
 	 * not require a current domain.
 	 */
 	u8 log_subdomains_off : 1;
+	/**
+	 * @set_nnp_on_committing_creds: Set if the domain should set NO_NEW_PRIVS on the
+	 * execution past the point of no return in security_bprm_committing_creds().
+	 * This is not a hierarchy configuration because the nnp state is inherited by
+	 * exec and doesn't need further configuration.
+	 */
+	u8 set_nnp_on_committing_creds : 1;
 #endif /* CONFIG_AUDIT */
 } __packed;
 
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index eb584f47288d..d298086a4180 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -31,7 +31,7 @@
 #define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
 #define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
 
-#define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_TSYNC
+#define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
 #define LANDLOCK_MASK_RESTRICT_SELF	((LANDLOCK_LAST_RESTRICT_SELF << 1) - 1)
 
 /* clang-format on */
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 1d6fa74f2a52..ad0bd5994ec5 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -121,11 +121,13 @@ int landlock_restrict_cred_precheck(const __u32 flags,
 
 	/*
 	 * Similar checks as for seccomp(2), except that an -EPERM may be
-	 * returned.
+	 * returned, or no_new_privs may be set by the caller via
+	 * LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS.
 	 */
 	if (!task_no_new_privs(current) &&
 	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN)) {
-		return -EPERM;
+		if (!(flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS))
+			return -EPERM;
 	}
 
 	if (flags & ~LANDLOCK_MASK_RESTRICT_SELF)
@@ -140,7 +142,7 @@ int landlock_restrict_cred(struct cred *const cred,
 {
 	struct landlock_cred_security *new_llcred;
 	bool __maybe_unused log_same_exec, log_new_exec, log_subdomains,
-		prev_log_subdomains;
+		prev_log_subdomains, set_nnp_on_committing_creds;
 
 	/*
 	 * It is allowed to set LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF without
@@ -157,6 +159,12 @@ int landlock_restrict_cred(struct cred *const cred,
 	log_new_exec = !!(flags & LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON);
 	/* Translates "off" flag to boolean. */
 	log_subdomains = !(flags & LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF);
+	/*
+	 * Translates "on" flag to boolean. This flag is not inherited by exec,
+	 * but the resulting nnp state is.
+	 */
+	set_nnp_on_committing_creds =
+		!!(flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS);
 
 	new_llcred = landlock_cred(cred);
 
@@ -165,6 +173,7 @@ int landlock_restrict_cred(struct cred *const cred,
 	new_llcred->log_subdomains_off = !prev_log_subdomains ||
 					 !log_subdomains;
 #endif /* CONFIG_AUDIT */
+	new_llcred->set_nnp_on_committing_creds = set_nnp_on_committing_creds;
 
 	/*
 	 * The only case when a ruleset may not be set is if
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index c6c7be7698a2..f3520c764360 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -397,6 +397,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
  *         - %LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON
  *         - %LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF
  *         - %LANDLOCK_RESTRICT_SELF_TSYNC
+ *         - %LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
  *
  * This system call enforces a Landlock ruleset on the current thread.
  * Enforcing a ruleset requires that the task has %CAP_SYS_ADMIN in its
@@ -450,6 +451,10 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	if (!new_cred)
 		return -ENOMEM;
 
+	if (flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS &&
+	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
+		task_set_no_new_privs(current);
+
 	err = landlock_restrict_cred(new_cred, ruleset, flags);
 	if (err) {
 		abort_creds(new_cred);
-- 
2.53.0

