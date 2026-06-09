Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CE739EF23
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 09:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780997849; cv=none; b=kjO48bc3+m4cQD4lWNQFBosZCwfegxxFat1jtf1kuYs7UtbafqnbwR3dJAXLtNxi4XQCRq2u7t/IXsPsn4gEfUvkPXB2G/bTCu6lGwIS6LzcOsmaxy9P/fPcGkL/AWVbYQqdKbBE+D1b8JwZ/R3gi5DoRnYCopB5fu58G+p1RW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780997849; c=relaxed/simple;
	bh=j7gBfN1/s9WzNBatQf0ewiuVB9dxUSpR5AihPJC8rbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1YnV4ZKDkxQLMY2I7Ewansix+rdC8gH9wg5gkjvheII28mXVaUXQQgMmyQ26BnVkNGoJKd3/yT5BkYJeCSYvY1/kkqw2QFYgae8PYM6b2pooMJazNEdUHBgvxCAH52+7tAAPjlNBaLBnFSNM2Me1JFK8+tNAHhKJV46qspGolc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mItIEKHf; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mItIEKHf"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-490b12270b3so31744315e9.1
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 02:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780997846; x=1781602646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCoLTopm6ZLx+Avdr8zOKCEH8D5MWtK1UNQ87hUnzAc=;
        b=mItIEKHfOdcAbj09bEaSAf/MeurCcNDdpu/tb7tRKJryWIas2VY85IcMf0YU0UwlS7
         HuZipdsxqSGA2mtXflzZ2gc0+ASe9Pb2yVt7IPPRsE2X4nWsuKaW/NiXLAQQkIy3YiVU
         i8TEJTheWu5G1aZl7pTsAfX6VYrlpf0VlvCgryXL3rEblLPNHGbTPajiib0z5b6Vs8yX
         je4wdTBCVbJGDbeU6oit0P+N8TstRnwj2OLlY7Au8LUEj1i0qh4B6JrKRmt9GM12qOsP
         3axcJ0zwEMfaVr+J3dMjQE1HZqMRZRWXBB2ciD2DiR6QTDo5ut/hYPypB5CDviS0YSCR
         z6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780997846; x=1781602646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eCoLTopm6ZLx+Avdr8zOKCEH8D5MWtK1UNQ87hUnzAc=;
        b=CwLwrg7p9CvrvHBb4g2F67NM91237dOBYM/1ynzVZpESAAGdxl3fYpy4JT7eo9LEx9
         NsYVMF7c8XMynDglC2AVaaavuyHc7UunZGj4RRTmQLwAkLFY9o1P+26udMlP8Tx8hukf
         zValymo7BkSviYlqgTwdAfJJ1rQZqvf/k/jgjzEy8hKBBap6mm1pIJqIuwy74VSQtsVc
         +0y3XydbnM4+52ykBqv+L3I5gHK1JzaNsUPwh6NesNEdfq5X7BdJE5Vt0AmlFxzw2lcQ
         cB7Edtd89lLWxAw7KKbcyEbDayXeWK2AfqJ63sOjkjtwq8F+Zy6nYuVv2inyuJ3Uu8Tn
         aZ9w==
X-Gm-Message-State: AOJu0YzTrvaf3UkeiU1lYcS2UZS9unNpUdaYlOlPK6teiDGz/Em2ZeZX
	fSLT5hR9wBWuDA7xa3/PjuiUjW+az/UohsTfTYZpTF14/htHc63QrCISwcccIsP9
X-Gm-Gg: Acq92OFK2do1VmkLY8C8MKCVwPgIQnDgvisl47zh0198yb7kkfDnzPT+PN8+Bn4YYeK
	ZOI6gpxF8f1Xev1c2NbQ1AnUu2nP+s8oSGhFP1cJ9jb4xP7b+ztfZqEWj03tIwqkQBFLlJZA/y1
	ybSgv0Eq0yi0ecAGRPwtKuI5MiVNwX84O9+ShnbxVyixftVESe0vaqxCFJVLg2w4GGim6rIcp4H
	zI/0u+IeXiQA7BFaoad4+CTyMuXJFpfsFSiDFsNlqjpnWVwnvkLPdfFGLfY3j5SIWfXKhBlpStO
	iwtJRLCawPRQe2UMvvMGH4cdVZkLvuLDuOaUDGXrXYHakCFC2V5uYLyXzwuvqvq/7px19KSaYZr
	CgORs9MsJCk/+cRDlnEynlVc6C4Ygu+b4RyOdA6UXtTeFMBbtsix8jjqmn+/mgEjKkkZOQeRzu4
	RlbyDE7dQ5aTwW+qqwsQqmioTxrqfvK2n3Fds3V0O3WnT7xS6pEyEjd8IbklMPOeXgPckmhrUq8
	zU0lro+WbWWHJda3HDdIBYHbQdhMiCdIig7jWUfxUkMwZKdzZzniwVIY4W/LFB/YFjBCNt5qdwO
	IxmLVMuSAzs=
X-Received: by 2002:a05:600c:5246:b0:490:bad8:329c with SMTP id 5b1f17b1804b1-490c25c8197mr304534515e9.12.1780997845902;
        Tue, 09 Jun 2026 02:37:25 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc23394asm463105675e9.0.2026.06.09.02.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 02:37:25 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Justin Suess <utilityemal77@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: Exercise unsafe obj drops from tracing progs
Date: Tue,  9 Jun 2026 11:37:16 +0200
Message-ID: <20260609093719.2858096-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609093719.2858096-1-memxor@gmail.com>
References: <20260609093719.2858096-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2314; i=memxor@gmail.com; h=from:subject; bh=j7gBfN1/s9WzNBatQf0ewiuVB9dxUSpR5AihPJC8rbU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUv93sp18n9/T3B9L6XHydsw9ajnFZ/5Uw8sPH0hzMs1W uZ8z4nqjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEyETYnhf270jcrgE2//Ke5K jL6t5fTsVWTU1sLJwdPPqx8Wjek6cI6RYZbNeSXlz3+66nfWsf+xavvTkVHGMuFvtbC3R0Vi0SU tBgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add task_kfunc failure cases for bpf_obj_drop() on local objects with
referenced kptr fields from tracing and NMI tracing programs. These programs
must be rejected because dropping the object would run full special-field
destruction synchronously in an unsafe context.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/task_kfunc_failure.c  | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
index 8e947d445f8e..98e00287c438 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
@@ -5,6 +5,7 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
 
+#include "../bpf_experimental.h"
 #include "bpf_misc.h"
 #include "task_kfunc_common.h"
 
@@ -233,6 +234,48 @@ int BPF_PROG(task_kfunc_release_unacquired, struct task_struct *task, u64 clone_
 	return 0;
 }
 
+SEC("tp_btf/task_newtask")
+__failure __msg("bpf_obj_drop cannot be used in tracing programs on types with NMI unsafe fields")
+int BPF_PROG(task_kfunc_obj_drop_with_kptr, struct task_struct *task, u64 clone_flags)
+{
+	struct __tasks_kfunc_map_value *local;
+
+	local = bpf_obj_new(typeof(*local));
+	if (!local)
+		return 0;
+
+	bpf_obj_drop(local);
+	return 0;
+}
+
+SEC("tp_btf/nmi_handler")
+__failure __msg("bpf_obj_drop cannot be used in tracing programs on types with NMI unsafe fields")
+int BPF_PROG(task_kfunc_obj_drop_nmi_with_kptr, void *handler, s64 delta_ns,
+	     int handled)
+{
+	struct __tasks_kfunc_map_value *local;
+	struct task_struct *task, *acquired, *old;
+
+	(void)handler;
+	(void)delta_ns;
+	(void)handled;
+
+	local = bpf_obj_new(typeof(*local));
+	if (!local)
+		return 0;
+
+	task = bpf_get_current_task_btf();
+	acquired = bpf_task_acquire(task);
+	if (acquired) {
+		old = bpf_kptr_xchg(&local->task, acquired);
+		if (old)
+			bpf_task_release(old);
+	}
+
+	bpf_obj_drop(local);
+	return 0;
+}
+
 SEC("tp_btf/task_newtask")
 __failure __msg("Possibly NULL pointer passed to trusted R1")
 int BPF_PROG(task_kfunc_from_pid_no_null_check, struct task_struct *task, u64 clone_flags)
-- 
2.53.0

