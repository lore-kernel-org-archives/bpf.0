Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213A633C52D
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 05:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769836180; cv=none; b=HEUjJREgFpjFQcHcTACZc3yGCEbOofa3cKx1peqx3It49YxZbuzYqpFWJtO0HbzPFahAMwnjE+2fvOQtsZZqYHKj2wLv6gJPOSeSGdW/w8wX2Xx5jhO2zTe2pkY8rl1YZmyBwKU1TSC5uqmVOqFfCOH/PxC0Yn47SlGqcJtcLlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769836180; c=relaxed/simple;
	bh=An8BnmX9Br7RS5E/JK5+AuLgGH68OZSuI8tJGKtCb0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiMUgXknV6DJ/izvGiFwsxoRAZzD7klzTuS2Bb940MjuAQgZRpSQ9++kWokog3Vd+PQqbeRI9v7vlQfBnLVULqh/Gs7lXwZIRIuGBxW7Og3Pr33n2sokplE3PKNm1uDwWbBI57JLZx3gfsY3c2W5r9kI0rtJ98QTYZQsm8OPYgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwyV9RkG; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwyV9RkG"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-81e8b1bdf0cso1746464b3a.3
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 21:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769836177; x=1770440977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuNvMHG7EsV3WDXcTIQ0sCJGxiwxkoeLevbL1JCpO94=;
        b=AwyV9RkGB0dbIB+mYd2veXeggBvyLT0flWLb8gOIgnPy39rqnpJDErOSVxfoW6HusS
         Yn9LSAG1ufYzjGX7Sy3V8lUVDD1v8eS+k8tZilSft8lNNLQWhk46FjEPpw3u254SNzdP
         fctW+mdqB1BFGlkESn6uLJwwCKINPc3lnoTKZyswta43NpgoEuRZqqsRW2yPKO/Yy/zO
         tQvjpfKywcyuQzfagRxxfMyd4OXHJPYzdHs9V1KEPFZ6qsOqlWFnQBZmTOsDKFSNapn2
         +Hj8pZJJys4FBv5Obrlztv53PJJ4r4BkGgIa+dGpYWj0dJU4nl9caRUevfU9Cdjm+gh9
         EJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769836177; x=1770440977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nuNvMHG7EsV3WDXcTIQ0sCJGxiwxkoeLevbL1JCpO94=;
        b=CTbYsZd2UuTsBrvNxtLcAuH3yW26PFbBTQjEbEnjnahH3r/IuRbkTV1sYjis9MoIH4
         XxIBfsi+vlShBELHMdPVws34LScDQ5XRr4D406I0rE3QM0IFzLIOhkq5W7vFgokOIs/s
         OuGxyaJYHRP+IesTSZKHbpPtWlz/urti2B/sq3bTDuEhJO4f6K2rUqOGbxlbRBlks/De
         VB1/7DAQ2ST0cCOLNUBeCHIeUAkVIvHzWXV9NpClFSk2xrtSWizxmuPfij+tzTAbb5Yz
         7QLoCDxSXVmzeLAw0HZ/JiM4GAPDQDYzQRNepLTrPyFwlcJ87kvjQK5Dhl+K4ALneH3F
         riqQ==
X-Gm-Message-State: AOJu0YxfoAS1B+Ablwgl9wMy7h0h+qBdYoMuct1lwDd7lP2GeUXVALTM
	JOCchNwXDAbyIYevcrUA50Qz3pz9vBScb7lM05dBdplpShBBZVkSaoIvnQ5cow==
X-Gm-Gg: AZuq6aIOvM1dyF84HyehJmW64sxmZsd3W4YYr3NFn9ifDQmSlMxcVEzh8xkBH8ihUDv
	ULGkKMlzFweSdx5g90wwwV08WoCz4Md7mSUG3k4UTlBtplym8wgjvkf5hJTSG9TuItJ2Ty1vpwx
	T9cXch3A9amYXdlpUk58JGK+oFP4UXOyKA/hpk1iNXRcSHfaP2vNasWukixsULccQxQetkoFAiO
	I/BPEM/vGoN4PrCX0rdLEyvIcZB8wGKbhgonGR9tqrVHL6vpctqTMKN2JQ6paHTyXMTLayMsumv
	97yeK3+3d5okrO2tQD091xz7hbK4kXKqfspR1Z9qb1E5GP5AyIZoeMCrR5AQ85KyWb4p+2nBiRx
	TTjX1rESgj67x933DJolE9tFYK8l5OiXeALcIQ7uFUVA+6JzK6KPnkZDVTVFrMnNQEKAXWR2Gpr
	VHBUj1KIyYeQ09
X-Received: by 2002:a05:6a20:486:b0:38e:8878:91bb with SMTP id adf61e73a8af0-392dffd9db4mr4756810637.4.1769836177232;
        Fri, 30 Jan 2026 21:09:37 -0800 (PST)
Received: from localhost ([2a03:2880:ff:52::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a3356b4sm8859134a12.17.2026.01.30.21.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 21:09:36 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 14/16] selftests/bpf: Update task_local_storage/task_storage_nodeadlock test
Date: Fri, 30 Jan 2026 21:09:17 -0800
Message-ID: <20260131050920.2574084-15-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260131050920.2574084-1-ameryhung@gmail.com>
References: <20260131050920.2574084-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjsut the error code we are checking against as bpf_task_storage_get()
now returns -EDEADLK or -ETIMEDOUT when deadlock happens.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../testing/selftests/bpf/progs/task_storage_nodeadlock.c  | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c b/tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c
index 986829aaf73a..6ce98fe9f387 100644
--- a/tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c
+++ b/tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c
@@ -1,15 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include "vmlinux.h"
+#include <errno.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
 char _license[] SEC("license") = "GPL";
 
-#ifndef EBUSY
-#define EBUSY 16
-#endif
-
 extern bool CONFIG_PREEMPTION __kconfig __weak;
 int nr_get_errs = 0;
 int nr_del_errs = 0;
@@ -40,7 +37,7 @@ int BPF_PROG(socket_post_create, struct socket *sock, int family, int type,
 
 	ret = bpf_task_storage_delete(&task_storage,
 				      bpf_get_current_task_btf());
-	if (ret == -EBUSY)
+	if (ret == -EDEADLK || ret == -ETIMEDOUT)
 		__sync_fetch_and_add(&nr_del_errs, 1);
 
 	return 0;
-- 
2.47.3

