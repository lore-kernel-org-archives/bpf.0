Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29CB3DFC7B
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930129; cv=none; b=dxNSvnt8HyRnOvktiKkZkaOqrylEcVI7LERZJz3s3ZeDP/JAj0QRQfAikNcDcxoavLCCrvxXAih5P64bpa3eY85TxvoKxbzMJ3opYu5KedxNK9sRG4jmmz8YO1pMtHVkwgzOoMwAUBbRxS35VwcqNCvrjT5NwyH4JJ0ecaj3+kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930129; c=relaxed/simple;
	bh=j7gBfN1/s9WzNBatQf0ewiuVB9dxUSpR5AihPJC8rbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIVIhP9+cGKeJuiUvedsFDpC2mCYeBaWuw2ssGtQBaR7F26xZx6zFuENOBjfJV8WLVqm1trbV3x/Vy1z8nkmkw/c2slPsXETvyC6Y6DQM4ha56Dh5+EoMs+EGtHa7WURiT+5lfr7NDP4lDG1HWqTZbwIa6RLDxJ7CBxu1n+gUKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMbulxE+; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMbulxE+"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-490d1e54b3bso6356915e9.1
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 07:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780930126; x=1781534926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCoLTopm6ZLx+Avdr8zOKCEH8D5MWtK1UNQ87hUnzAc=;
        b=kMbulxE+sEUhrj2cclytE32Gv4LanXxyIdUkg4PnYzmCDD6eMpYbcBI9mUkobkzOuB
         Q03TVB5lBf+xxiTi4GWWhNL8BeWe9Q0QV7VUv6ZdZbyI47oSfQCr9m/t1H9AKPw3d6ep
         XMPaMJAB6J/gnGRHoor+wXtDhsSL3Ovb8vdh6vb5Iy+NhDDK0MYgM0c9ehrMIEg7ZeAP
         NBcg7Ul83XOFo3WULriOEVSrcE9wACr+KdOgLeBnSvIe93Z/0yT0xB2vB1Yeg7QZkINO
         iLBIUo3UOCXrH1ok2IRyzM3NcLCvCqRSPhHQKR5p+CnjA+sIxbcjaj0uo2pcD+WYUwEi
         Id1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780930126; x=1781534926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eCoLTopm6ZLx+Avdr8zOKCEH8D5MWtK1UNQ87hUnzAc=;
        b=KXjO6O3j0igjgtLVXg2azXxO5RWM0+I5njXtLvBF2vk+H84oLAgvvPoTAw0oJIgFNe
         hHRsjiI0RPe3wnNpYyuUqSNrnDIv0RUjJwAFrIwUVgRgk/xm+GZZt70gEPlobCAts+va
         ZD5phv7EWc2Y73gmC5WnCzNBgVKEbp5736hqwswmjH0T7aYMt+bI7qQ+R0+KgYvbAZkN
         sF8so+M8SlYJfeEto7khfAQMFL63WaA2SQEwTjaxNLQPyob9fpXzKjXeAexzp6AEtUJh
         zTp4Xty0KFbViQXEsnzZKUAF0qXKeC8hKl433vBlP0vgHpIiJ58xwZoi56KWgmyOmUIS
         x0Ag==
X-Gm-Message-State: AOJu0Yz9MnNp+5hAFiiDikQ1d7ukyjEJDGI5NEW+D1TccF4mtzEBW80v
	AXXnyNWMqiq95SnPEYpG+j3RUpKfYm2KlNKsa9bWdLEs8u6BEtkKO6NqA6767MfP
X-Gm-Gg: Acq92OH2AnjSmO4odaNa5oYzKYHi724LLBdAsAO1tkT+KDK/xPX6oSMI1hoBHeoj5ru
	6w8m00za6k830/bNI93JOcN70oGtUDm8kDT4aMGZRSrBbek2JFYyLG09GkYfFZ4JJbMSRW8d2lo
	hQKf+XEjUAZltIB5UuqnArxmDKCA1jPnOb6CJMCKTtiLAjPv7xGjOyYtXCPWlUGiMB552LOpQMG
	ta09pL6ViZ5S+0ZciHwBoZ2SDyiS+QZ9PY552kRWydQbEjINWOf6ZlE9dNUOmMiDeepGjjusutE
	g7uj0NAJ0Jd8XsXgvLbMf0USwenSAQVX69tFie5Zk+E5Ta2NSk63Yt3ug8K7PnsPBZGlzF4xB7E
	+6G4fdM5RK110p5RhLDHIq6YZt7P0jZggE9kAWccvAQ+JTaQEYrKbytL1EkboTDLX7fFRDybBtA
	6Hn1a+buEIbNx7GcrUzlN+sOcWceAiCKckr455TPUXYB11eVLQECO5kyrEA12NgZ9Q2UccsU17k
	yvHOe0pDeKjnSTfYBbrDllIyEr8olD7Rw5zoa0RUQ3cJ5Itztg6J+8u7ozzCXebI6/y9/3XBXnq
	mT4qTXO6z9s=
X-Received: by 2002:a05:600c:314e:b0:490:9d1b:2022 with SMTP id 5b1f17b1804b1-490c257bb25mr267047485e9.13.1780930126005;
        Mon, 08 Jun 2026 07:48:46 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3b5b06sm367144845e9.3.2026.06.08.07.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:48:45 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 4/5] selftests/bpf: Exercise unsafe obj drops from tracing progs
Date: Mon,  8 Jun 2026 16:48:37 +0200
Message-ID: <20260608144841.1732406-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608144841.1732406-1-memxor@gmail.com>
References: <20260608144841.1732406-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2314; i=memxor@gmail.com; h=from:subject; bh=j7gBfN1/s9WzNBatQf0ewiuVB9dxUSpR5AihPJC8rbU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUvtmtQ6+b+/J7i+l9Lj5G2YetTzis/8qQcWnr4Q5uUaL XO+50R1RykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACbyJ4Dhf7Bb8zT+fZZH396b cctze/f+l7PjtWblevrXHPqwsne+UCkjw9R4juP/7hn0+Rqfb7JRW7av58HbOW/uNzr9zZ6zI+W 1JzcA
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

