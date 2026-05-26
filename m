Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A30A379C32
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779810137; cv=none; b=mjQGzCme1A+GZhal98X3BELExHDdqHk4zRWGguXT38gt99rv4KBSOzbD7ezjvUC4HBRCiZvbvjKG2Eya55+aZL6drU6Y9GAV1hnuhCW0YYGS78MlH9CLCYlzB11KGXH5xG6AbIe/CIvMdzUu650BGJBliGoKYpje5QpBJ21NmTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779810137; c=relaxed/simple;
	bh=K8dU5cRvEeTZJXIoWN4LezfaLkgzV+ajZ48AtGvjvPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q+EDbZiKdUS2QHJ6SZ2KGlDLyDOGP7rTcr7Pt79SbJLp40Uq9No5MjDnGvtX46gJSkOL+hbDSSqruN0dzjkQdao4PrZVhHWxsgYWDXckScPjmTfZiR1YhW3JI6zIx8uF4NbLSMEzYV3sGlChGpfvaWnZ0PeYN9iM3ujnqNJrIK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCQSxkIN; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCQSxkIN"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-44a74032ff8so7964714f8f.1
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 08:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779810131; x=1780414931; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nra1IkGeaMWhRjUY/VHjWd0vQrGlfXrcJ/6vYD6kaWI=;
        b=jCQSxkINvSXUBWy8918iHO/YFebmQwA4M89a1hPuz6+AMAtav2CeFO/B2ctYHOhYNp
         I9fVWRFUoeTRDgYGwniOPxBA83m60u8xlcuZZOALapVmlGQ70F/Nob5D258bXu8BmYRX
         sjgDb4v9602+hOo/PsB1tw1BjlO8xS65uhyubm2+FdnoRHJW3xfJBI0N+GDxY6FAPzGu
         oP9Qe9/LSTFCDt/D8xgX6Ie7mo6An0QZQJ9j1PzN9wWWXqmoeb+qktlBMdRmeOOBpXKp
         aA3Alw+XvEL7vhTKldz79cHKW/tnEnxnGZT5BugCA9SRjVXY7F6cTn7DBHz5/k24dcQw
         lXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779810131; x=1780414931;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nra1IkGeaMWhRjUY/VHjWd0vQrGlfXrcJ/6vYD6kaWI=;
        b=bS6A77kWZ+8TrQycnCj7jvkiTq5hqfibTM/MJk5E5K3i5nVAVq23CKKmAtjxStqNkY
         8yQO7bpHMvTYIJ4eVN67dsfP88rC/ef8rGDJyexlCeVrwOkYBXNgtOC1kyBJADzQZCpW
         xjg+KDGm0Aqq5b2neR05VBAjcbfI156wszGNTqPK1C+vZNi3RhX4gvnFH6kZdof/eegp
         ce5VlFoaSvwmLNZzLbOlK4JVTdTWanGfQrBr/3oy9EUwDof5hyuWYXQgDMavh7/3ET66
         +SPpqV/jYsAFD6X1gCLu7CSEmk8TbgxJwgCcFGkkQqAzqZ9ThbceBRqsUnivI/jUPFzw
         LBRg==
X-Forwarded-Encrypted: i=1; AFNElJ/1GmXcWP+MajHHBbzLVlsyp5uJ1Z1BUdO/IrpXy9BIkRVsYSwLre407uOCVmxOOv6iUCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7wKWVQ8/d7F6dnjgl2do7EczMbqOZvDg77vUvaF5cFLHt/7K9
	0+dG6fCRa/CXyrff1hAnrmCNc6HjTY5alXbeUjhm6n6T8nDo7dIxySWs
X-Gm-Gg: Acq92OGQftrqFtLZZKTW6XyfdZP7ZhTKVDd0NHaTpEKrkZnNI0Pj0LLNbgU8YTnl00z
	8HiMTtBMEvECmhcCSf82snkYzKnkP96VY0CaSOIidwxzQ+uG0fymWUOmH0jTz8ix106LMR6I3pN
	gwLFVeYJrtjgARdW6d+wf/dJzW+Ulvk7j9Uiqg3zTE7JDWWtM/j503RfyacryI/6aw+bGUk9GAw
	6jh2TzEsVBxWC/u4njNV60c45xIAQnYoczfycE4EYCwyaCCjMsykLYK4AkOnHLD50aMvUB/GxPR
	RFhvaNMMYPxQW03eZzyCUSYKgfleNCnvMK/AWkmozn4Ex+I1Kx+ccsxHfCXkTs8dfaDZRD5bpeO
	z5KfgLrasX4dQIOlMKSF7D7rejJxSPBtZZoFHDTRBHJlq7vvqFl6bN2hQZJIfD/nOvrrmZAJ0bv
	tmUsLtwaIvJPf49LEy2eRnSUcOC+qKBB0V1MCk8h6GKQ==
X-Received: by 2002:a05:600c:4e4b:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-49069da6188mr109478895e9.13.1779810130840;
        Tue, 26 May 2026 08:42:10 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:4b00:f03c:ba00:3081:348a:50c4:2d80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5c32esm35301088f8f.26.2026.05.26.08.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 08:42:10 -0700 (PDT)
From: Jamie Hill-Daniel <clubby789@gmail.com>
X-Google-Original-From: Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
Date: Tue, 26 May 2026 16:32:15 +0100
Subject: [PATCH RESEND 1/2] seccomp: Allow using `SECCOMP_MODE_STRICT` with
 `SECCOMP_MODE_FILTER`
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-seccomp-combined-v1-1-304b1cc3ad24@hill-daniel.co.uk>
References: <20260526-seccomp-combined-v1-0-304b1cc3ad24@hill-daniel.co.uk>
In-Reply-To: <20260526-seccomp-combined-v1-0-304b1cc3ad24@hill-daniel.co.uk>
To: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779810129; l=4298;
 i=jamie@hill-daniel.co.uk; s=20260302; h=from:subject:message-id;
 bh=K8dU5cRvEeTZJXIoWN4LezfaLkgzV+ajZ48AtGvjvPQ=;
 b=HGJCVl2+ue3fUdUIOetCI7AL4j49hWBcCqggcbL2wTWLAnBuSZ1TvlFXGh0NgvvMTmEdpqY+0
 lZL083aCPQ5Bu5V98HtbrA5bzr165LOTvaI8Xlr4+A6a+RsQf1WWZW3
X-Developer-Key: i=jamie@hill-daniel.co.uk; a=ed25519;
 pk=ovqCXSlFUjrT82WuRtIuXB13U5n1yfxM6o0M5O5J2tA=

It is currently impossible to enable `SECCOMP_MODE_STRICT` if
`SECCOMP_MODE_FILTER` is enabled, and vice-versa. This makes using
seccomp difficult in environments such as Docker, which installs a
seccomp filter by default.

Introduce a new internal `SECCOMP_MODE_COMBINED`
that runs `strict` checks, followed by any installed filters.

Link: https://github.com/moby/moby/issues/42082
Signed-off-by: Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
---
 kernel/seccomp.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 25f62867a16d..8201a050d358 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -33,6 +33,8 @@
 
 /* Not exposed in headers: strictly internal use only. */
 #define SECCOMP_MODE_DEAD	(SECCOMP_MODE_FILTER + 1)
+/* Run SECCOMP_MODE_STRICT checks, followed by SECCOMP_MODE_FILTER  */
+#define SECCOMP_MODE_COMBINED (SECCOMP_MODE_DEAD + 1)
 
 #ifdef CONFIG_SECCOMP_FILTER
 #include <linux/file.h>
@@ -432,14 +434,21 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
 }
 #endif /* CONFIG_SECCOMP_FILTER */
 
-static inline bool seccomp_may_assign_mode(unsigned long seccomp_mode)
+/**
+ * seccomp_needs_combined: internal function for checking if requested mode
+ * needs to be upgraded to `SECCOMP_MODE_COMBINED`.
+ *
+ */
+static inline bool seccomp_needs_combined(unsigned long seccomp_mode)
 {
 	assert_spin_locked(&current->sighand->siglock);
 
-	if (current->seccomp.mode && current->seccomp.mode != seccomp_mode)
-		return false;
+	if ((current->seccomp.mode == SECCOMP_MODE_STRICT ||
+	     current->seccomp.mode == SECCOMP_MODE_FILTER) &&
+	    current->seccomp.mode != seccomp_mode)
+		return true;
 
-	return true;
+	return false;
 }
 
 void __weak arch_seccomp_spec_mitigate(struct task_struct *task) { }
@@ -1407,6 +1416,9 @@ int __secure_computing(void)
 		WARN_ON_ONCE(1);
 		do_exit(SIGKILL);
 		return -1;
+	case SECCOMP_MODE_COMBINED:
+		__secure_computing_strict(this_syscall);
+		return __seccomp_filter(this_syscall, false);
 	default:
 		BUG();
 	}
@@ -1421,30 +1433,23 @@ long prctl_get_seccomp(void)
 /**
  * seccomp_set_mode_strict: internal function for setting strict seccomp
  *
- * Once current->seccomp.mode is non-zero, it may not be changed.
+ * Once current->seccomp.mode is non-zero, it may only be changed to `COMBINED` or `DEAD`.
  *
- * Returns 0 on success or -EINVAL on failure.
  */
-static long seccomp_set_mode_strict(void)
+static void seccomp_set_mode_strict(void)
 {
-	const unsigned long seccomp_mode = SECCOMP_MODE_STRICT;
-	long ret = -EINVAL;
+	unsigned long seccomp_mode = SECCOMP_MODE_STRICT;
 
 	spin_lock_irq(&current->sighand->siglock);
 
-	if (!seccomp_may_assign_mode(seccomp_mode))
-		goto out;
+	if (seccomp_needs_combined(seccomp_mode))
+		seccomp_mode = SECCOMP_MODE_COMBINED;
 
 #ifdef TIF_NOTSC
 	disable_TSC();
 #endif
 	seccomp_assign_mode(current, seccomp_mode, 0);
-	ret = 0;
-
-out:
 	spin_unlock_irq(&current->sighand->siglock);
-
-	return ret;
 }
 
 #ifdef CONFIG_SECCOMP_FILTER
@@ -1956,7 +1961,7 @@ static bool has_duplicate_listener(struct seccomp_filter *new_child)
 static long seccomp_set_mode_filter(unsigned int flags,
 				    const char __user *filter)
 {
-	const unsigned long seccomp_mode = SECCOMP_MODE_FILTER;
+	long seccomp_mode = SECCOMP_MODE_FILTER;
 	struct seccomp_filter *prepared = NULL;
 	long ret = -EINVAL;
 	int listener = -1;
@@ -2016,8 +2021,8 @@ static long seccomp_set_mode_filter(unsigned int flags,
 
 	spin_lock_irq(&current->sighand->siglock);
 
-	if (!seccomp_may_assign_mode(seccomp_mode))
-		goto out;
+	if (seccomp_needs_combined(seccomp_mode))
+		seccomp_mode = SECCOMP_MODE_COMBINED;
 
 	if (has_duplicate_listener(prepared)) {
 		ret = -EBUSY;
@@ -2105,7 +2110,8 @@ static long do_seccomp(unsigned int op, unsigned int flags,
 	case SECCOMP_SET_MODE_STRICT:
 		if (flags != 0 || uargs != NULL)
 			return -EINVAL;
-		return seccomp_set_mode_strict();
+		seccomp_set_mode_strict();
+		return 0;
 	case SECCOMP_SET_MODE_FILTER:
 		return seccomp_set_mode_filter(flags, uargs);
 	case SECCOMP_GET_ACTION_AVAIL:

-- 
2.54.0

