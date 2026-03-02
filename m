Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99D639099D
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 20:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772484725; cv=none; b=ooewe3yUqA5tsG/OF52+HEJ5zxag6deOt9QM1I1zysyRTm6/TGZEVrHKIyzbSrOKM2FiNEAitIU7RmcB084Dx6Sc7EYNfZm4GQ1PhRZkh78cCc4RzLVy70ZYPupDpwfBEBxLVMdhAqLuL21Y3gBNpnMc1RMp1Ma4xmLbTRzGdwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772484725; c=relaxed/simple;
	bh=fyVdGruDK05tDwLUbs7lBhZnVKzfazeuNEZwdWYZ1ho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RnA6F7DpikHR0qR7AnM33w2Ub9Hf9X5w/gXOY70LzE1XDhIKXMdgpZ40N6WEcZkz2ADmiKichKKntcwL79101ata7kNGvaBfr6UEp29ONL5vX2FORw50VPGqsvNM7Zao8BJfjOiaWHZ/B5aIXaI7sS9plx3sjKxQXjzIRqd9ODA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvuQ/dCg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvuQ/dCg"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48373a4bca3so29902975e9.0
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 12:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772484722; x=1773089522; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSqJR1m2w2fT1WInc8r5MDvmoPSQo5tv0QZsx0+DkJs=;
        b=lvuQ/dCgnUtzLiC818M0y3ou9ppeIZ9pf9JDExEXIDCzcrVDC4OE/mE8mWbwaCvybA
         AnJtwDE5sn/FxYM4WQu9daq1JdSrtXgDr+nX0g1hb3GKqoLJTNvcBFvZWmknEVQutJRi
         zD02BeXEqOEeAI7Qilozk6IqyLKMWpqZg66ssr/3iMg2FH6I0CDZRRm0YUDPYCS0I0cm
         sbQ6MzsZF3Td42bdWn0G3CqIcVLZURwVkjx9u8wcR3GZyJD3CYKuMtAy77uLpPCJ9Fcg
         t07sqytVbIbl0pezSz4+0miLb0norAndSQzs8j7+svZL9Nxi1PTJnlqEEe0jkOB2usDs
         66Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772484722; x=1773089522;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BSqJR1m2w2fT1WInc8r5MDvmoPSQo5tv0QZsx0+DkJs=;
        b=Qt8wdsSlKzqKDlTQMdhSp4r4dmceTUb+Ot+bhuMdfQfejMI5myRuXWM/V4cIKP0EiN
         XarKC+oc6Y12t4LXxQYH7d2eZoXRsBgrvsNl9ZMW0H6AAaKLft5DagINUFcn9R4WoUTv
         iag5q7wi29hravViOB9Dtndu7dytapil3Sxv0EWW6nI76fvh/5XJyg0OAdeAhJ+txx3a
         IVezAvRll9fCwKMVqeYggkU/Xj5LuG/uwfsNzsph9bqBC36rHO0+4o0XFNQryC7wRd9R
         4tUuq47xvBbfXUJAvkV1fi1F2Sf3MYREG5pZ2oIlTVahMf737XqttFia97OFC/StQkiV
         28Ww==
X-Forwarded-Encrypted: i=1; AJvYcCX8AibKibQ1zS5exUUP00NHKd4C12wiF/fY3wUB3fM1XBNmP2WGBuVgD2aJZ47JWnSJnM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJIu3/QAADVv6UIr3oYfWMYRug3jiOYAARP+cWBfUTbPkzzkDD
	evRm9BLAlngD4K5AAv49NCDg3R269Ok1UDfY+YG77dX9IwkLx5BmSUznGiN69ISb
X-Gm-Gg: ATEYQzxczdnk2MHpp3MWO8CovM4+5PEnVseXYUYqwYYt76oOPxXv/WVOP6UB7PqSoob
	A0XhBrJgCTMHg4RnX0Ms9ZimK8e8wC8qQKOGoNWd1y8z6SZha9KG3RwSvBwlLr9Dq9WD3GvXdWP
	ZEQOAa2zzlivCZRw+Sv8jvt9lQA2IuLv40gBPdn2soSBZw6nu0KttAYYKnMq2m0YA/DAhFHhHNq
	AGjW6JnVrkU8Kvgv+QfKtwCe3L1HKKdqonkczt2kBlsXc1VhQ4NbXZ1/tiWbXwgka7mQ7hi5LVP
	oD8NMTroeQd2DgQ5zAhrhIt0R6h2W/SqahjyP57yPUBO8zKoPDSHZhnY1gmqzxWyUU0g80m3lIH
	n6W/ln/mTiz/B94hql6Upie6ycuElggvtv/qtlqlFKRDWWkK3DT8e43y9JaEGZsnyvYOohpWzjh
	sjYHGvCSTuHrfCl13KPuXbeNYIE/wu5RI=
X-Received: by 2002:a05:600c:1e2a:b0:471:1765:839c with SMTP id 5b1f17b1804b1-483c9bbc268mr195357195e9.20.1772484722230;
        Mon, 02 Mar 2026 12:52:02 -0800 (PST)
Received: from [127.0.1.1] ([2a01:4b00:f03c:ba00:3081:348a:50c4:2d80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485126705e5sm898705e9.5.2026.03.02.12.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 12:52:01 -0800 (PST)
From: Jamie Hill-Daniel <clubby789@gmail.com>
X-Google-Original-From: Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
Date: Mon, 02 Mar 2026 20:51:51 +0000
Subject: [PATCH 1/2] seccomp: Allow using `SECCOMP_MODE_STRICT` with
 `SECCOMP_MODE_FILTER`
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-seccomp-combined-v1-1-c0cb7acb0f97@hill-daniel.co.uk>
References: <20260302-seccomp-combined-v1-0-c0cb7acb0f97@hill-daniel.co.uk>
In-Reply-To: <20260302-seccomp-combined-v1-0-c0cb7acb0f97@hill-daniel.co.uk>
To: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772484719; l=4298;
 i=jamie@hill-daniel.co.uk; s=20260302; h=from:subject:message-id;
 bh=fyVdGruDK05tDwLUbs7lBhZnVKzfazeuNEZwdWYZ1ho=;
 b=MjzO+lE8seZZoVfwFmC4PeNeR12hHqRiqTTe376K+OInXk4e6jV1cy45AGGv4qUAX2PPi6ywJ
 QzyUS8n/qN0AkmEWBdiKmL8kGIw7wK08pTX62s4xLgX5EbD86FrIPKz
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
2.53.0

