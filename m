Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360D53B71DA
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188411; cv=none; b=M+fWRyegJxVd83USS6Cc9Nx3Ol0X1W9BZqfHzeL9WD22G7Q1vE5YDlUOoJ23IiIi3Ewwxa1kQ69jYAGsuANIEECkvT8ml69mong+LxH/ktO6AGUTll1ul6HsH7BNWU/BFkRHyHDGUKTnoMuUgb/fE6hm1vUnNA+Y98H5z+34Yec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188411; c=relaxed/simple;
	bh=b13IPf/84INpWuDI29q/RKRtrh98z2Lf1mSfFGTrgeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3x6rap+6FzhsQ2QHsYAj4euDzJX7drxDSDrS8j8XoJ/sK8u3Z+56MXyR7w+XRdRgCzCZMJs925wHeZ77zuQf1g8d7j6pdp2dl0q59n/n9BC5o8OYQYc6Ib0VPhwYpr/EQJ1rney3bfnczVFOk25tU2D9gopoGZ9jUaIZ4BbRMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbwMjy5n; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbwMjy5n"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7dbcb505578so37243637b3.3
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 08:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788188408; x=1788793208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rCFWN9c5DyvZlo6DEGKf40uISp6POIHTrkimV4mL3IQ=;
        b=IbwMjy5nuxd2r5hq6lLgh+H41ssSFxp30WEq88st2GRSz+hHrC2Qp8M54IYgZ0xHO9
         gI/E5tqvpNxe+EDuLv7PotNNq+n56t47H+1UvkWyZ7ud0DWzJIwJMka5Fl+GwnQWRNfs
         jCcjrNcGvSW2VuW8VWfuEEVUCs+H7Ni5gIAiklH23YKIay7tETdtmfn+rtlJmFiEki3m
         iQ//ErmYn+YSDvRtb1E63sQ/STKC4k8xkAgiN3gbMUGO82tho7S6mE9zVEm+bM+niyY1
         RMe+F4wiQhvPHB+6jD7Uobfc03rfsxGUgFxWm/Fq+xKdVKpooaA9MyJsoGldCxES/KoC
         WZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188408; x=1788793208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rCFWN9c5DyvZlo6DEGKf40uISp6POIHTrkimV4mL3IQ=;
        b=nrNMF/83dOQraJRnDHYqgfcCbJEoHo4aawZRz+EbrVMlG8wBdNBsQqeHVaLRmMP2I0
         5BE5Lc5UY52nXD3fhUUul0VHi3wgBy+CohWw0cnLeDcxv8FIYOokkqhLHxq9j1+jOjr/
         Ic+zlGJNRQN+F9E1S+8tXfuNA7LEQ+fO4cSjQKnaeJwUNrKc2LVJhB4fOj2YD4CT/sY3
         Rb3gmpCBLWJ2Uh5ZnIGChtnYBhKnCE+09UN+7hJxkcPfz225kdRyD5/mTsAxvUnPc+1l
         Mau8pQHdBeiUnXCO1jWdLwtUQZHUdy9Lpc7D3me0mt+1dxHKtOWpXERiuK+XLrV6iF2g
         yUog==
X-Forwarded-Encrypted: i=1; AKwUvBwvBJK+ZmuKvVA/KyfeWpGMNtDkCCo/6ob+xYx/uJXlXU0Gct60+aUsMyTxDRk+u6VtI2g=@vger.kernel.org
X-Gm-Message-State: AFuF++l8UX9CPFNJtIVabjUsUd0bOfzWmJr5UESF1LObj6d+A5Y2vQyB
	TDpQW30+86fF9k3T4LA6Z7wMsCZPO9I7RR9/gSPe2oiXLw9oYWH4x2oL
X-Gm-Gg: AYBFou17CK8MUEKJ4K41xp8MBvQByYCbUvgQauwYAvDSPTu+3yNb/9j2alG/ks3Z9ux
	f3vA9fOeQwKk2+KhPD0U9DOX5RthV+MsLomhd5BLde0YMyMTy92V6yjDykHQNVsYwoLb6P4zIcs
	9SPCqXbfSSFiJfDCBo5iwjYqLlQ6f12M0SMVeVjXV/+cH5AWuK48djAmf5xTLSBBuPp7HC/qd/y
	e913A7pLpJb3SSe6d3M4N3YUaxje67xHrCHXvLHF0ug2f2/01WcATMBHCbTO8bXuNYm5l5qEm7k
	pdfPEekhyzHe1URJcpJvVcHFALhHgPXJdb42QdkRiKJ+PKTERiJqHl3rLYQw+HBGsWw7J769gjx
	PZTy98KYReXv7gCOcbU1p+1rpYK2tlBz/PNl8OySdPz9zFJ/icjdokf3DPcsk9ZZ9tvaXabTJSj
	YTvlsrIzYfaMscEV0FAXqMh4U1w8hUAjsEhHtpF5lBFYB2mKW+//uZez/RmH70mTI/Dru3mYTdH
	ZGaw913IttzL2RrfxU8P3s=
X-Received: by 2002:a05:690c:93:b0:862:65f4:c8bb with SMTP id 00721157ae682-86265f4cb64mr46763897b3.3.1788188402897;
        Mon, 31 Aug 2026 08:00:02 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:f6fc:b424:b1bb:6ff0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e58666e15sm53903827b3.0.2026.08.31.08.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:00:02 -0700 (PDT)
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
Subject: [PATCH v2 05/15] lsm: Add the bpf_lsm_policy_from_fd kfunc
Date: Mon, 31 Aug 2026 10:58:47 -0400
Message-ID: <20260831145858.3869191-6-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831145858.3869191-1-utilityemal77@gmail.com>
References: <20260831145858.3869191-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the kfunc translating a file descriptor into a referenced policy
object:

  bpf_lsm_policy_from_fd(fd, flags)
      KF_ACQUIRE|KF_RET_NULL|KF_SLEEPABLE

No argument names an LSM: a policy object fd refers to a file set up
through the owning LSM's own userspace interface so the fd itself
identifies the LSM asked to translate it.  The kfunc offers the fd to
every policy_object_from_fd implementation in turn until one claims it.

Following the convention of the lsm_*(2) syscalls, @flags belongs to
the framework and is reserved: the kfunc returns NULL for @flags != 0.

A policy object fd is only meaningful in the fd table of the process
that set the object up, while an LSM program runs in the context of
the task it mediates, so the filter makes this kfunc exclusive to
syscall programs (BPF_PROG_TYPE_SYSCALL), which run in the context of
the task invoking them.  The acquired object may be released with
bpf_lsm_policy_release().

Cc: Paul Moore <paul@paul-moore.com>
Cc: KP Singh <kpsingh@kernel.org>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 security/bpf_lsm_kfuncs.c | 53 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/security/bpf_lsm_kfuncs.c b/security/bpf_lsm_kfuncs.c
index e1190215d477..988dcd6f4dd9 100644
--- a/security/bpf_lsm_kfuncs.c
+++ b/security/bpf_lsm_kfuncs.c
@@ -14,11 +14,50 @@
 
 __bpf_kfunc_start_defs();
 
+/**
+ * bpf_lsm_policy_from_fd - Get an LSM policy object from a fd
+ * @fd: file descriptor referring to a policy object, resolved in the
+ *      file descriptor table of the task running the program
+ * @flags: reserved for future use, must be 0
+ *
+ * Translate @fd, as set up through the owning LSM's own userspace
+ * interface, into a referenced policy object.  The fd identifies the
+ * LSM asked to translate it: each LSM recognizes its own fds and
+ * declines every other.  Only syscall programs may call this kfunc:
+ * they run in the context of the task invoking them, where the fd is
+ * meaningful.  The reference must be released with
+ * bpf_lsm_policy_release().
+ *
+ * Return: A referenced policy object, or NULL if @flags is not 0, if
+ * no enabled LSM recognizes @fd as one of its policy objects, or if
+ * the recognizing LSM fails to translate it.
+ */
+__bpf_kfunc struct lsm_policy_object *bpf_lsm_policy_from_fd(int fd, u32 flags)
+{
+	struct lsm_static_call *scall;
+	struct lsm_policy_object *object;
+	int err;
+
+	if (flags)
+		return NULL;
+
+	lsm_for_each_hook(scall, policy_object_from_fd) {
+		err = scall->hl->hook.policy_object_from_fd(fd, &object);
+		if (err == -EOPNOTSUPP)
+			/* Not this LSM's fd: let another claim it. */
+			continue;
+		if (err)
+			return NULL;
+		return object;
+	}
+	return NULL;
+}
+
 /**
  * bpf_lsm_policy_release - Release a policy object reference
  * @object: policy object to release
  *
- * Release an acquired reference on a policy object.
+ * Release a reference acquired with bpf_lsm_policy_from_fd().
  */
 __bpf_kfunc void bpf_lsm_policy_release(struct lsm_policy_object *object)
 {
@@ -44,6 +83,8 @@ CFI_NOSEAL(bpf_lsm_policy_release_dtor);
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_lsm_policy_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_lsm_policy_from_fd,
+	     KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_lsm_policy_release, KF_RELEASE)
 BTF_KFUNCS_END(bpf_lsm_policy_kfunc_ids)
 
@@ -51,10 +92,14 @@ BTF_ID_LIST(bpf_lsm_policy_dtor_ids)
 BTF_ID(struct, lsm_policy_object)
 BTF_ID(func, bpf_lsm_policy_release_dtor)
 
+BTF_ID_LIST_SINGLE(bpf_lsm_policy_from_fd_ids, func, bpf_lsm_policy_from_fd)
+
 /*
  * BPF_PROG_TYPE_LSM and BPF_PROG_TYPE_SYSCALL share their kfunc
  * lookup buckets with other program types, so restricting the policy
- * kfuncs requires a filter.
+ * kfuncs requires a filter.  A policy object fd is only meaningful in
+ * the fd table of the task that set the object up: the fd kfunc is
+ * exclusive to syscall programs, which run in that task's context.
  */
 static int bpf_lsm_policy_kfunc_filter(const struct bpf_prog *prog,
 				       u32 kfunc_id)
@@ -64,7 +109,11 @@ static int bpf_lsm_policy_kfunc_filter(const struct bpf_prog *prog,
 
 	switch (prog->type) {
 	case BPF_PROG_TYPE_SYSCALL:
+		return 0;
 	case BPF_PROG_TYPE_LSM:
+		if (kfunc_id == bpf_lsm_policy_from_fd_ids[0])
+			return -EACCES;
+
 		return 0;
 	default:
 		return -EACCES;
-- 
2.55.0

