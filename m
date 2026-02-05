Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8D235DCF7
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 07:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274946; cv=none; b=hd2+KbUlIrKmCA+vu4XvOOOHULhmr5NNH0XkyiXM3T4TBKRAOFY4t7MTtchbXmavbdRW80VIboHHqY38ksvt/6lICOV/KjRb/oG86gnQs426snpiSmIgvktL3V5+L4d7EWl/qEbLCc/5kdeRqPZ/hVghwEAlxi5Y7mpVSpFUL1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274946; c=relaxed/simple;
	bh=6kMSHY69ShPBtgu/4LR3AsnJqQKZdPzU1YywkA98ha4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBp+gaeFMvGvzscyAsj9Vm2jbtyx4g3vp6lKCm68Xm8FgwyIaimc7lJrMJzz6twNvQqyWzCDgpFYQYLiaOR/V+7fuItD4ja3P5wIF9NDfHfa9/Jlzi5J8vD/OQGt5mL9KIi5WR9LqaJwv2iLO3sAjQ/wD56tE6EmUuZqOcIEFPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrPQlRze; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrPQlRze"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c62239decbeso209903a12.2
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 23:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770274946; x=1770879746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxqS/tO+I6m5D9ZrvXJXIDaZLXu0H/c/z+YPwf7tqnU=;
        b=KrPQlRze8knUEmh1JBmE+etq1SghyAfxV9E2cCiWicA6YcyQxA1pjMPqvRn5u5S9Zj
         lV1RbEM3AW5med+z1AI8+DwIBWWmwb5L/Xzh+UCHEyAgtdQ+WshEDZWAgH7DMgopRoUr
         YqVtSLuHNDNrDD39GrCSS5Gfesg6Pp+tvyikdBe83xGTdJfK6jUMMuSQO23ST2HJ04cS
         tokZ1v0UjRPvW8ywdA3k3UWwibaouYBOcfuNXycCz4/Ef4oXOsduvCnqA7M15R4USZbd
         i+qofszbcZusOpujUeBpyuShUjWLEFeAJRuWlgUppPLa3PrzAh8sE3G3etksx2WH+rX9
         ByIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274946; x=1770879746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xxqS/tO+I6m5D9ZrvXJXIDaZLXu0H/c/z+YPwf7tqnU=;
        b=wDqnBOK/OQ3QC0dfQUA+KPIHoox8VV5QJ1U5BY747pAS/wdc1DYkwLk1aicyyX+UfM
         ZsgTof4z/C6mfa0D6JVODfaDHcE0KlVtcqdkvICspEJMlCd70yvu/YKlo8JMhxspyWvV
         wXLvJcPpp/9OdjtChL697qlEdwqykFUaevgbEH5G8eqpQ1ePZJ491cygmgnTTzkkKTt4
         r/l3WAIyGqWME6LdEpIIjh++yOEaZOmfQ+EVT0HFVxLCqP4Yi3Y8sQELzqIR4EIoQkVP
         Hck761jdHzphWnjvQ/a7Mp1HqCx3ArTSEH4YPQQpVVHSgAbAstS91TZ4fYvqkhgdx/tF
         x2Jg==
X-Gm-Message-State: AOJu0Yw5DGuCbQ2vAh+lqvTYE2eO5HAodqjMD2h5W8pKh59UG12a167K
	mYlvp/oN7QA0ahJuo5D4Bik7FtCZhPP6wsdj774LMuIyKBcuv9PiIrS5Shojig==
X-Gm-Gg: AZuq6aKQqKOcFno9szqXKNYICXvegANRAg7/A1sBuOKtrq6KF0ipC2Jewc2aoAfAcPI
	mkrWqvrhOO4k+7FxK+zQjOQTqLYPubNydZMcoSVIOcj99EUf3XKtBvsXNC6KE6pK0SLg79X8hZR
	pvGnkq2qdKf9sTURlV8fAmGMpOmJ5YwEl6gZ8LIyUsfyXxERx6BqbSHyzOixPXmdZUH9N8LYmcE
	80Fmo8sT8rZMVe+gUinMKBitNzV/bRtLsmxypy+E4mgwcCwkI++NXDb/7Kmgs7QGfcVleCFR5rR
	6zhPXU0v3g4sScbGsDLROy+RFUwYEpLkfhHH/LYN1+2vTFDQi2fnURav/2wU3O9qxLCt8MJxHMQ
	VQLVOBHmjIgBWvNQImha9jm/tiTlw92ysmSY4nbqrPZg6uAyCB04S4DHDD2xRPg5RSVO6aCcn3y
	Gq
X-Received: by 2002:a17:902:c411:b0:2a7:9b6e:33df with SMTP id d9443c01a7336-2a933fb25a4mr63450675ad.35.1770274945658;
        Wed, 04 Feb 2026 23:02:25 -0800 (PST)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9338b71b7sm39950475ad.44.2026.02.04.23.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:02:25 -0800 (PST)
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
Subject: [PATCH bpf-next v6 14/17] selftests/bpf: Update task_local_storage/task_storage_nodeadlock test
Date: Wed,  4 Feb 2026 23:02:03 -0800
Message-ID: <20260205070208.186382-15-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205070208.186382-1-ameryhung@gmail.com>
References: <20260205070208.186382-1-ameryhung@gmail.com>
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

