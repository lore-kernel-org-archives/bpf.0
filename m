Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27BB337117
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 22:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330574; cv=none; b=Kvg2K968yo5XGGEYR8ltUCyMbS2Ar9dLtAZmAwVJwG8R4feB63MgPwofZQtbRDDFpBuiswotO0juNFb8k+3Qqq3GYS2ceWpdHCGy2m4rbQYPCQ9RJHI7ovgpshOqw5MyGJoneaENYL/9HvUErmmxpy+Z0KntzhbkmG7XcerSYvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330574; c=relaxed/simple;
	bh=6kMSHY69ShPBtgu/4LR3AsnJqQKZdPzU1YywkA98ha4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgC61MCnitKVBxRqiHGCLxyRy14eUE9inpQ/7SglzKc88Mf3YdwIAc4YCJO16Y6DZY7UWYAEjB1GzCb/2dDQltg32OfD8WRFtD9ffc3+FpRlXSFbLQGnOk3kz55ktcEQ90oXKlR8yqvXIuEwFVkSZE3bdnoco6OimOxbQ9eMcyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjVHy0ye; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjVHy0ye"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8230d228372so1019061b3a.1
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 14:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770330573; x=1770935373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxqS/tO+I6m5D9ZrvXJXIDaZLXu0H/c/z+YPwf7tqnU=;
        b=CjVHy0ye4fcWozSh8Nu2ChnHyKNjpBrTMTLFR0JbxKifiAV5ZLwWLBebCUa17IG1AT
         X96gc0+9UjlktMzikrlUDHoNY2VJlBHn8dZjzI2MtuZi5jbkljG73O+j94Z4HsHPEmhC
         /hMcYeFpG2N4MlT1Hfl+9DCfFKIPlXSB9GZRLkknz12b/Oc1dSSPwrp8zUjQHLlTrjMg
         70zfFB8Gllg8cMNIMAgWj7y0dqHKjkImn5270M6sCGa4RZ2UKsC0HdJYm1gK+XBkxVaP
         Ru1peKJcmD3pKulMn4EuWqWUVN8M3uOvBfFyrJRgs7RY+gODTRRs0Mr7x+O/6FpB41NM
         n+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770330573; x=1770935373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xxqS/tO+I6m5D9ZrvXJXIDaZLXu0H/c/z+YPwf7tqnU=;
        b=TOQBIKRK8+JTZZmoGuE5trDrrFvgCwd6jchdRG0oY8d06ucIE3YzI6d/SWTqOsFg+o
         4xqpU7k/wNgjezF2rxQfDrmuRSVDZ2F+y5Rfvz09nGuLW2+uLhCAROB91o/i9DvVc1yM
         /2/7SxK1xxT0KXR+wRYekv4/JUpNcG12n3Ay3lQMXoHauPN+P1OKWzwV0tJBKjY5Un8x
         959to83yGaVhJ2qQ9xykeY2PXsDzNMjfr7UeuMx9F98DrMAhxKtHhjyhBTY5knw8do83
         z7rjBEktgvDMCJzfPZdrzEEelSuRF+vg9ow78pou8f9WL3Fetdhms9HLGagWZZMpzpsj
         zBww==
X-Gm-Message-State: AOJu0YxrXY43Y2+Aq9Sbt4Nzz6g8FozbEmSwHPzmSuNbMzoSnn6Q0tLq
	ikATzSaCH/X+QGFKr+frFBzh54AUIaFn/g70V3X6MNLuWQg3BmVvOe3nTb46Yw==
X-Gm-Gg: AZuq6aLHsdtUBu888r6Gsxt8YETi8fi1E8MPQPj/ICKCh2Qb4CphW2cGp7Tk30tdZww
	l/SVrMA6gX/zr5FXHrC2vfgXvfUbLiO3jpUttpGA1JHqyPbmlTcXSsmOaFpkI848Yyiey2SE1hT
	pCHqxbdSYfFHUjXf7SJaq4sdVazRHbCvrZsKP4DsEvlDor8zgRK3Go2G7/N2LrN7vbXpUTHF5vl
	ZxOxMVIaFbgJg7p7v8/5EqENLSyP3D9mHUCYFGRWoKC8D/nMZAVxPH3LFCYOO7MPJMTk6cnuwkj
	gZxJdXQFOU4CqFT2Qn8gnWrpfrAzIx1bnb9fvcSxO3oYvKLiiOK894XzVGiinAKmuvm8theEaxY
	1F8ZRrPFrdIlY9ThQqgxN/BkMwQPY9t1HjdZJWtRoHJBXlc2DqtiiZjls5QB+Zi0KjVrM+yn4ac
	Q0Jw==
X-Received: by 2002:a05:6a21:648c:b0:38d:f8e6:fc8b with SMTP id adf61e73a8af0-393af24bdf8mr376854637.58.1770330573175;
        Thu, 05 Feb 2026 14:29:33 -0800 (PST)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb52494bsm375742a12.10.2026.02.05.14.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 14:29:32 -0800 (PST)
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
Subject: [PATCH bpf-next v7 14/17] selftests/bpf: Update task_local_storage/task_storage_nodeadlock test
Date: Thu,  5 Feb 2026 14:29:12 -0800
Message-ID: <20260205222916.1788211-15-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205222916.1788211-1-ameryhung@gmail.com>
References: <20260205222916.1788211-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust the error code we are checking against as
bpf_task_storage_delete() now returns -EDEADLK or -ETIMEDOUT when
deadlock happens.

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

