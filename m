Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BF5409630
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540483; cv=none; b=Vgxi3Zc8m4RLtYHz9MdCwyAYLjL1sUNjazvd2AAEiPjif4U6DCo4IryxPKGhjqL3eLJZXYavWVaMy7cGp7u6O5wBSyM82xk9QpBsi/DCajBwyysV5yw89vqU45jpwpjdmFiqyTLY0ohMabpi0ENb5T+Mq5v1lSlBG6oMu636wGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540483; c=relaxed/simple;
	bh=0vPCiV0l2C/DnACu7mZLtsB8h2mm+UDj0bGxkixd6/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pHBQnE5g2qZ16LrgXWqsCToqoCZyRA1UELUv7aCO9eBqX17UWRThw3uKx0jqtlQ0Im6KmZWOjOWCorb2uQMTT3MWjJ4OjvPjAHR892otdymV0ZSaa2SGN+0NHUXm943KZ+t1BOitZmlreWgtKhYJ/W3tWcvjtM9awIY7iBBUjkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHZpIl/2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHZpIl/2"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso46080805e9.2
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 09:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781540480; x=1782145280; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9nGutSdp2bGS4wkFIesj5lmWCYMYL4uo0E38XjnUCk=;
        b=gHZpIl/2IePaLzSzsiogkR0lohmOMXqOEUuGONsDRaEfUhUcaR1K9iBRiwmXREPw3Y
         wua/sBRiX3l6LOFkfzska4rNHLy/oC48wtUiso948siziaaKT7qPbOnP0g7XpLeUPeg6
         Qqie1ycHrxy9nTUFDbiBVwH2O2gR7itPF6cNa9igDI6lBegRXSJ/U8ROMbIU39bv3Yp7
         Z5GsEnNmXu75f94VwDnhnIStw8xZoIpqa7KoZyklN8+jvkBNebamLDDPSQxNxYTcad4L
         zjIHZlRwji9xifv1nb6CQq2uXSHkHvontmbBJbxPruwDm+Zcm0cEluXvzQoien8q/9o2
         WmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781540480; x=1782145280;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F9nGutSdp2bGS4wkFIesj5lmWCYMYL4uo0E38XjnUCk=;
        b=LZtfr1ukNwZJgNZCB6R2dCWAScSgF6u6k7wOLIBuDfv/m+sO7CC1kstdgSOopyJla4
         ungOSNwhk39JYl41c+3zjMih3L1ERbTsS5kDC5LOQZh3yfl6BLwPU2bAH9ClqlN+7Lr5
         V6dnKGjsX7k2sKhPJIrdkMUZd/mLINo0moBsi8paX9oGd98uo/szx9NVdjK5/pM9n1VY
         mYQu2v+ipgye/pN5MjHLgEsE1jvmR/1u1KeICUJSm45XzJzx8D4sAVZ7v6pXtaK+KtWL
         BGQdnjEXjY5JKVKoTFFGinO3QzyKDGM7fYysQNxk1x0z8UM5cn1O5EiGGtjmQFaVKyXw
         NM6w==
X-Forwarded-Encrypted: i=1; AFNElJ/ncNxwJw4Q9Je1jF1buhc9MfuumXB9zbAHSan+vWVxLALALMwko9BOXHdCj244dkCw6Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YznSFXpgamZmuN/sPDbcUJnnKTPoz/ovwhAmDbw4spwHlCr1FOm
	qckHSBz3+O8O9oS9PR56lMtlZR0xC96Yw9KHZ69qGu6kS0W7KbP1IV9g
X-Gm-Gg: Acq92OH1yQVt0qhsQG5kieiQvbCyKYYu8tloQjswL8rHAgNF81/4TY74l9bZuGeKd3Z
	o/5TXQz72catA5+PBKFI8q4EwFkOOGoH2koDHmioidvXuLEtHaw0aMNPdFLMEeGd2E+kQQ45ySu
	t+jUy6Lu+cS6DF04R3JbNRhUEqESBd4WP+iWFzsLKXhYwHn+8Cfz82xsb3t38L4DIP9o4xpsihg
	4OQ+cZ3V/+cXqoY+5c7oCsja9EU4UXlqnKaI/SZrulooBxJPkATXpRIZ18CKDgDfJ45VFckkFL+
	WbqWY+yln6vNzAE0AlTJZbF4iCJkKMVpezXXQIbd84YqUjqyJ6i0VlHlstQwirg9Y2kf5Oxx1Hp
	W5aJfEyuVAH1uPKS/Mr2/op3R39n9qwFxcFyhUT+3OuOXTOwl4xjKbUa60fFrI21BKI4Biy/Gej
	WmF4nD8Ki8zUOPvLtdk332ejG1J24NisbQUJEVhjBVCWCxZhCZzFw5462SCGUuP5A=
X-Received: by 2002:a05:600c:4e48:b0:490:e60b:6860 with SMTP id 5b1f17b1804b1-4922005e235mr139454855e9.7.1781540480496;
        Mon, 15 Jun 2026 09:21:20 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:4b00:f03c:ba00:3081:348a:50c4:2d80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922f9cd140sm4320745e9.0.2026.06.15.09.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 09:21:20 -0700 (PDT)
From: Jamie Hill-Daniel <clubby789@gmail.com>
X-Google-Original-From: Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
Date: Mon, 15 Jun 2026 17:20:22 +0100
Subject: [PATCH v2 2/3] seccomp: Allow upgrading to strict mode after
 enabling filters
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-seccomp-combined-v2-2-41687a943ae0@hill-daniel.co.uk>
References: <20260615-seccomp-combined-v2-0-41687a943ae0@hill-daniel.co.uk>
In-Reply-To: <20260615-seccomp-combined-v2-0-41687a943ae0@hill-daniel.co.uk>
To: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Will Drewry <wad@chromium.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, will@willsroot.io, 
 Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781540478; l=6298;
 i=jamie@hill-daniel.co.uk; s=20260302; h=from:subject:message-id;
 bh=0vPCiV0l2C/DnACu7mZLtsB8h2mm+UDj0bGxkixd6/k=;
 b=DP1/PHKKMiQlgOfFgiJHlAxRUBktpz2ZmrLt+Sm9Ez4/SwlbxSKk77Gj2EiyOTgW+dcFLt9xo
 uRIfmYLGHrGCYCcwTOgb2r4292ycnlsIXoF9OQlvOJmkKwTYk/LHKYs
X-Developer-Key: i=jamie@hill-daniel.co.uk; a=ed25519;
 pk=ovqCXSlFUjrT82WuRtIuXB13U5n1yfxM6o0M5O5J2tA=

Add a strict_upgrade flag to seccomp, which is enabled when
SECCOMP_MODE_STRICT is set after filters have been installed. This
will run the strict mode checks after all filters have been run.

This flag blocks thread syncing, in keeping with regular
SECCOMP_MODE_STRICT.
---
 include/linux/seccomp_types.h |  3 +++
 kernel/seccomp.c              | 55 +++++++++++++++++++------------------------
 2 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/include/linux/seccomp_types.h b/include/linux/seccomp_types.h
index 67ab25d7540a..d8a908cc822d 100644
--- a/include/linux/seccomp_types.h
+++ b/include/linux/seccomp_types.h
@@ -13,6 +13,8 @@ struct seccomp_filter;
  * @mode:  indicates one of the valid values above for controlled
  *         system calls available to a process.
  * @dead:  indicates that the process should be killed as a result of seccomp
+ * @strict_upgrade: indicates that strict mode has been enabled after filter
+ *          mode has been enabled.
  * @filter_count: number of seccomp filters
  * @filter: must always point to a valid seccomp-filter or NULL as it is
  *          accessed without locking during system call entry.
@@ -23,6 +25,7 @@ struct seccomp_filter;
 struct seccomp {
 	unsigned int mode : 2;
 	unsigned int dead : 1;
+	unsigned int strict_upgrade : 1;
 	atomic_t filter_count;
 	struct seccomp_filter *filter;
 };
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 8f5903f72d54..92804d488114 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -13,6 +13,7 @@
  * Mode 2 allows user-defined system call filters in the form
  *        of Berkeley Packet Filters/Linux Socket Filters.
  */
+#include "linux/seccomp.h"
 #define pr_fmt(fmt) "seccomp: " fmt
 
 #include <linux/refcount.h>
@@ -429,16 +430,6 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
 }
 #endif /* CONFIG_SECCOMP_FILTER */
 
-static inline bool seccomp_may_assign_mode(unsigned long seccomp_mode)
-{
-	assert_spin_locked(&current->sighand->siglock);
-
-	if (current->seccomp.mode && current->seccomp.mode != seccomp_mode)
-		return false;
-
-	return true;
-}
-
 void __weak arch_seccomp_spec_mitigate(struct task_struct *task) { }
 
 static inline void seccomp_assign_mode(struct task_struct *task,
@@ -504,7 +495,8 @@ static inline pid_t seccomp_can_sync_threads(void)
 		if (thread->seccomp.mode == SECCOMP_MODE_DISABLED ||
 		    (thread->seccomp.mode == SECCOMP_MODE_FILTER &&
 		     is_ancestor(thread->seccomp.filter,
-				 caller->seccomp.filter)))
+				 caller->seccomp.filter) &&
+		     !thread->seccomp.strict_upgrade))
 			continue;
 
 		/* Return the first thread that cannot be synchronized. */
@@ -1259,6 +1251,7 @@ static int __seccomp_filter(int this_syscall, const bool recheck_after_trace)
 	struct seccomp_data sd;
 	struct seccomp_filter *match = NULL;
 	int data;
+	int recheck_result;
 
 	/*
 	 * Make sure that any changes to mode from another thread have
@@ -1326,7 +1319,10 @@ static int __seccomp_filter(int this_syscall, const bool recheck_after_trace)
 		 * a reload of all registers. This does not goto skip since
 		 * a skip would have already been reported.
 		 */
-		if (__seccomp_filter(this_syscall, true))
+		recheck_result = __seccomp_filter(this_syscall, true);
+		if (current->seccomp.strict_upgrade)
+			__secure_computing_strict(this_syscall);
+		if (recheck_result)
 			return -1;
 
 		return 0;
@@ -1386,6 +1382,7 @@ int __secure_computing(void)
 {
 	int mode = current->seccomp.mode;
 	int this_syscall;
+	int filter_ret;
 
 	if (IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) &&
 	    unlikely(current->ptrace & PT_SUSPEND_SECCOMP))
@@ -1405,7 +1402,10 @@ int __secure_computing(void)
 		__secure_computing_strict(this_syscall);  /* may call do_exit */
 		return 0;
 	case SECCOMP_MODE_FILTER:
-		return __seccomp_filter(this_syscall, false);
+		filter_ret = __seccomp_filter(this_syscall, false);
+		if (current->seccomp.strict_upgrade)
+			__secure_computing_strict(this_syscall);
+		return filter_ret;
 	default:
 		BUG();
 	}
@@ -1420,30 +1420,23 @@ long prctl_get_seccomp(void)
 /**
  * seccomp_set_mode_strict: internal function for setting strict seccomp
  *
- * Once current->seccomp.mode is non-zero, it may not be changed.
- *
- * Returns 0 on success or -EINVAL on failure.
+ * If current->seccomp.mode is SECCOMP_MODE_FILTER, this will enable
+ * strict_upgrade.
  */
-static long seccomp_set_mode_strict(void)
+static void seccomp_set_mode_strict(void)
 {
 	const unsigned long seccomp_mode = SECCOMP_MODE_STRICT;
-	long ret = -EINVAL;
-
 	spin_lock_irq(&current->sighand->siglock);
 
-	if (!seccomp_may_assign_mode(seccomp_mode))
-		goto out;
-
 #ifdef TIF_NOTSC
 	disable_TSC();
 #endif
-	seccomp_assign_mode(current, seccomp_mode, 0);
-	ret = 0;
+	if (current->seccomp.mode == SECCOMP_MODE_FILTER)
+		current->seccomp.strict_upgrade = 1;
+	else
+		seccomp_assign_mode(current, seccomp_mode, 0);
 
-out:
 	spin_unlock_irq(&current->sighand->siglock);
-
-	return ret;
 }
 
 #ifdef CONFIG_SECCOMP_FILTER
@@ -1948,8 +1941,6 @@ static bool has_duplicate_listener(struct seccomp_filter *new_child)
  * Every filter successfully installed will be evaluated (in reverse order)
  * for each system call the task makes.
  *
- * Once current->seccomp.mode is non-zero, it may not be changed.
- *
  * Returns 0 on success or -EINVAL on failure.
  */
 static long seccomp_set_mode_filter(unsigned int flags,
@@ -2015,7 +2006,8 @@ static long seccomp_set_mode_filter(unsigned int flags,
 
 	spin_lock_irq(&current->sighand->siglock);
 
-	if (!seccomp_may_assign_mode(seccomp_mode))
+	/* Reachable if PTRACE_O_SUSPEND_SECCOMP has been used */
+	if (current->seccomp.mode == SECCOMP_MODE_STRICT)
 		goto out;
 
 	if (has_duplicate_listener(prepared)) {
@@ -2104,7 +2096,8 @@ static long do_seccomp(unsigned int op, unsigned int flags,
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

