Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D77B3254BD
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 02:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464489; cv=none; b=d6xCKybtqRCsQrq5xAnDfCCysDGjUynE4sO7HvT2OjcPY9m79dDcFQIKCeW2N+NN8Ib30AgKv9mUYrxWzTuDlZJIAJqc30w6FG6HTWA1RSV7jZ5O4WA53kmnr+O7sk1UFtQhtWn+oyOPaZhQMmchtRtalPAyy3YfG2Er9sZoYOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464489; c=relaxed/simple;
	bh=/VRKhMz6MNHP5GXT2Zjzxq2uq/8Y/syPrzNmmZIe/iM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TyymM9DtnjLR2+aca2RTWBHa2X8Te50c9lglieKcfFMlRWx7v4kP1ysFg18wBUk/V/YU2RP30zx5qtkM61+4RoLTEyT+cYetVVmpdjy4dK7VgxEpT0GnZMljK+pl2AgiIOC+oEDZXvWBBjXZyxT4nLCVVXPi8IGE1JSaCIc2bH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDs3IgQM; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDs3IgQM"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7dbcb505578so5020847b3.3
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 19:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785464486; x=1786069286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i0Bw5xZyWZrxJDT+Nb2bq5E0YUztUMCAvYE7Jg2F4Y4=;
        b=bDs3IgQMr+k9uIE7pAkvI/dggadTInDnK4023pc8ud5wSefpDJDH2cT//JKxRZxFbQ
         8wu6SZ63N0cp2nhvUsSiFH3eb493u28XPygHJ/pKfKB/ez6id70uYPpTuIXyNwx4jVyU
         nCzU8eZuOu2Ri6yeZXN4wBdW7ealf8NT/PkepSYEfXD75f0ALxh1wieFSD0uGulbYKVD
         M3k0R+vOOHjQ4ey8ZEj21pY8phEnhy1Ja1nsyDVBm4QPYrxNjxVkcpXDCTBj+DORBsyQ
         9ncvDqEswZ1VjCuRC93wHI5uBnI43JJb5XJYaIZl5S8hwpSLmwa1q3XzCmfEJ0kF6Ta4
         cWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785464486; x=1786069286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i0Bw5xZyWZrxJDT+Nb2bq5E0YUztUMCAvYE7Jg2F4Y4=;
        b=Xa+n9CEWFhjVZQx8/PTbrbn6s1sqilWhSFsoRC4YJdcwdjb3zvY8t7ZNy0vQ8mf6AG
         QaEAJzlTtpJYvIlSxq5oy0modohVypRbIlfyhAZlJ1nBh+Bh3d0kbzHtzA4g+IzZp2XW
         Ch7vaZG+uQpdSHTW4+qlau9sOqu27IiqTCTYbsx8Eu+teticMw197ZTw+XdysZEJyqEa
         9ajeRTqc5E8L4kc/KmJoeedKc3FcZxHD1cVx+NifTzyuqhljbJqyZxl9fhL6z2AkmrwD
         l7xQH3ei/KrbEmvDZHvMghzOY/Uo5/N2D6UAlkbZkSBPATU4hBe1WhuYidwUvizcwDuq
         r08Q==
X-Forwarded-Encrypted: i=1; AHgh+RpItFuBR4v5v77Y/7uBtab9GXDL+7e7p/dpcAQXbgVDvJQv2z8DBZTj2w0nR48f1c3z52o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlm6qFjL47ukjsWxIfLskGx1023PT9t4+kBqt33fXfNGZqyi5x
	KevfswFK3dhahpmwRHKN4rOgz/JlFXDETA9ueN8OmJZ5pqFnyx4wLN+T
X-Gm-Gg: AR+sD11Dm3DBMQSo6+gk324Z609iJUn+02BbPWv5gGFOSWbuW5Hm9qrWeAhMZiXnrK2
	O5Cpcf6eHWUhzeBcPc56zRx8kVtBCmnHyEgxHyPbLlG1wbh82VRB1mARBLHjWZg0DY3HiGIgnEG
	KOKXYQfqPanzJHPCPJbo5igLbxKeHR+3IXvd4Byg5Pwl76IQlzYex5KWPl+0qZlVdcw2Tjbz8OQ
	F41bnkGWqm2x1xfnzvBhFSS9VVovObkZOGjNL+GFJhucaydlj5rkKFJl7U1vzN5vx0WOM5n029s
	jxcIhxOCnCcBibE9tw1lmKHKsEOyegt4vkJkfXtRJtxhQgOcarNcby0Ux+9wnExOFVE/V2QJr8x
	Zk3oO5pgsnCTuNN4jAlZ+4exYqnzxPeazfuawbVxaTiF07dIdIDqxPnFkMmRXXETcvsrrCQdE+x
	Cc42Wz8mCFMNvHW4J5ywBKZqTY1SLSnhm/RETcdiedp5kKd/AixqFkIbHZuOzf4U3K01lENPPaw
	N7GsY9D6OwF0v8pNqpU0w==
X-Received: by 2002:a05:690c:3685:b0:80f:ddab:1cca with SMTP id 00721157ae682-81fcbbde12bmr429757b3.35.1785464485830;
        Thu, 30 Jul 2026 19:21:25 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:e94:8a83:feea:6720])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8b26e8bsm20519047b3.47.2026.07.30.19.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 19:21:25 -0700 (PDT)
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
Subject: [PATCH bpf-next 09/13] bpf: Add the bpf_landlock_get_ruleset_from_fd kfunc
Date: Thu, 30 Jul 2026 22:20:42 -0400
Message-ID: <20260731022047.189137-10-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731022047.189137-1-utilityemal77@gmail.com>
References: <20260731022047.189137-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the acquire kfunc for Landlock rulesets:

  bpf_landlock_get_ruleset_from_fd(fd)          KF_ACQUIRE|KF_RET_NULL

It acquires a reference on the Landlock ruleset referred to by @fd,
as created by landlock_create_ruleset(2) and populated with
landlock_add_rule(2), through security_policy_kptr_from_fd() invoked
with LSM_ID_LANDLOCK.  When Landlock is compiled out or not enabled
in the LSM order, the call returns NULL.

A ruleset fd is only meaningful in the fd table of the process that
set the ruleset up, while an LSM program runs in the context of the
task it mediates, so the filter makes this kfunc exclusive to syscall
programs (BPF_PROG_TYPE_SYSCALL), which run in the context of the
task invoking them.  The acquired ruleset is meant to be handed over
through a map kptr field to an enforcement program, and must be
released with bpf_landlock_put_ruleset().

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 kernel/bpf/bpf_lsm.c | 46 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 877dd0352607..9ff1c35fcd6e 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -479,7 +479,9 @@ int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
 /* LSM policy kfuncs */
 
 /*
- * Opaque handle for a Landlock ruleset.  Only Landlock resolves it.
+ * Opaque handle for a Landlock ruleset.  Only
+ * bpf_landlock_get_ruleset_from_fd() produces one, and only Landlock
+ * resolves it.
  */
 struct bpf_landlock_ruleset {};
 
@@ -494,11 +496,37 @@ BTF_SET_END(bpf_landlock_kfunc_hooks)
 
 __bpf_kfunc_start_defs();
 
+/**
+ * bpf_landlock_get_ruleset_from_fd - Get a Landlock ruleset from a fd
+ * @fd: file descriptor of a Landlock ruleset, resolved in the file
+ *      descriptor table of the task running the program
+ *
+ * Acquire a reference on the Landlock ruleset referred to by @fd, as
+ * created by landlock_create_ruleset(2) and populated with
+ * landlock_add_rule(2).  Only syscall programs may call this kfunc:
+ * they run in the context of the task invoking them, where the
+ * ruleset fd is meaningful.  The acquired ruleset can be handed to an
+ * enforcement program through a map kptr field.  The reference must
+ * be released with bpf_landlock_put_ruleset().
+ *
+ * Return: A referenced ruleset handle, or NULL if @fd is not a
+ * readable Landlock ruleset fd or the Landlock LSM is not enabled.
+ */
+__bpf_kfunc struct bpf_landlock_ruleset *
+bpf_landlock_get_ruleset_from_fd(int fd)
+{
+	union lsm_policy_kptr policy;
+
+	if (security_policy_kptr_from_fd(LSM_ID_LANDLOCK, fd, &policy))
+		return NULL;
+	return policy.landlock.ruleset;
+}
+
 /**
  * bpf_landlock_put_ruleset - Put a Landlock ruleset
  * @ruleset: Landlock ruleset to put
  *
- * Release an acquired reference on a Landlock ruleset.
+ * Release a reference acquired with bpf_landlock_get_ruleset_from_fd().
  */
 __bpf_kfunc void bpf_landlock_put_ruleset(struct bpf_landlock_ruleset *ruleset)
 {
@@ -519,6 +547,8 @@ CFI_NOSEAL(bpf_landlock_put_ruleset_dtor);
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_landlock_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_landlock_get_ruleset_from_fd,
+	     KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_landlock_put_ruleset, KF_RELEASE | KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_landlock_kfunc_ids)
 
@@ -526,10 +556,17 @@ BTF_ID_LIST(bpf_landlock_dtor_ids)
 BTF_ID(struct, bpf_landlock_ruleset)
 BTF_ID(func, bpf_landlock_put_ruleset_dtor)
 
+BTF_ID_LIST_SINGLE(bpf_landlock_get_ruleset_ids, func,
+		   bpf_landlock_get_ruleset_from_fd)
+
 /*
  * BPF_PROG_TYPE_LSM and BPF_PROG_TYPE_SYSCALL share their kfunc
  * lookup buckets with other program types, so restricting the LSM
- * policy kfuncs requires a filter.
+ * policy kfuncs requires a filter.  A ruleset fd is only meaningful
+ * in the fd table of the task that set the ruleset up, so
+ * bpf_landlock_get_ruleset_from_fd() is exclusive to syscall
+ * programs, which run in that task's context; an LSM program runs in
+ * the context of the task it mediates.
  */
 static int bpf_landlock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
@@ -540,6 +577,9 @@ static int bpf_landlock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
 	case BPF_PROG_TYPE_SYSCALL:
 		return 0;
 	case BPF_PROG_TYPE_LSM:
+		if (kfunc_id == bpf_landlock_get_ruleset_ids[0])
+			return -EACCES;
+
 		/*
 		 * BPF_LSM_CGROUP programs run under classic RCU and
 		 * cannot sleep.
-- 
2.54.0

