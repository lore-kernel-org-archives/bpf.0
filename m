Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABE328314B
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769968270; cv=none; b=gHM27vN+Q9HSBlMR0vwLBZXR7+GEW40b+oF1WW7YUWm9lhJmO2lOvibxk04gaV8ilUV/9OOVrL9Pgqe4+Hi3+qB6w7F+iuwJucBgkBVS0cPf0DOIWyS664Cu5Gd1poEqqZpSAXVL595q0IIhGTBHXazjG0C+KRNG15aDXEQ9Kis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769968270; c=relaxed/simple;
	bh=6kMSHY69ShPBtgu/4LR3AsnJqQKZdPzU1YywkA98ha4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itHUbw4XCMwzd70YnzLQrjvyjReQhSRlIi+DOhdcgk87CzYFdLYvs4t8uLxjiXiiybcDp850HHBwPp7nOX35BTbC/uVgInnHLhHhciiHxRiA76WP4Zbs3xOgdgFifA8rdOVK6Kw+qyXRK3HSmdsu9P5C9Byf0xtws0TiH5GgNl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9KD9gN9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9KD9gN9"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a79ded11a2so25077625ad.3
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 09:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769968269; x=1770573069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxqS/tO+I6m5D9ZrvXJXIDaZLXu0H/c/z+YPwf7tqnU=;
        b=I9KD9gN93bvkQRrdSdophVPtrmuCwUCcfA+VlWJD2AuCN6zBjeRXZEG/m7VI2PGSzk
         AzUmHQ2uYZOb5yb9fH5FNfPTa54ZM28GTXy9zytUHwsX4mAFDIiFBCa9nbvebe4efywQ
         CUX+uYOuSNLTcbzaNrYgJe0pOKlyNuPwXQiy2wLnmjFmImft+MpJIRbum/riNH1lTPev
         wEb9KUpj71W+0LSjah/NmyRHGDgenfMj9sBTwznq96V1w0C+CSyIgzKYAYuHq36On17C
         9o4cdRdsuJ63lF1OPud/l9KSM0PWJOUlYgb3KPWqwmxRoQq8Z//pkp+KzP55nC0q8sMh
         UxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769968269; x=1770573069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xxqS/tO+I6m5D9ZrvXJXIDaZLXu0H/c/z+YPwf7tqnU=;
        b=AI3FeOZHqECOtb2aVyvVaErhVAH34iDmfCc4qBCah4xxIOZ2waB709hT8fAvs6y1TE
         IMu4f69ImnBD1hsei1X1WtwcLmrByL2a4cJJMwiIvJ1LPm+kehtShwBbYsJXj93p2ykW
         IzczfGzvin/YfLNtGUWbggBT4AwTSgqtZpdi9ZBrsWLg6SKkN2cFmBFFtaClKZvKn5jQ
         5C0KCe4rNXgbsjuQZ2klFRtFiwkoQkWVsYJrOhOcNkoXYMB2AgEkgZumvcHGjRhKSWEq
         8qDZSQZw3YXq7B1hy6eT/YOtUdvn3V0Bxj5FjW3Ftpe+lDY/qyQulHkcK6ETOvc170ZJ
         dFCw==
X-Gm-Message-State: AOJu0Yw6EiOd9C7EGvl7ntzt8iqe/jGCSKdD5/PduyfboFaCZhK1DTnV
	Dbx8plVPUXa7/hRHJmBfFc25Ifn5ajx784+K0LOXXDNsYrNXQ7z61P69OIXhiw==
X-Gm-Gg: AZuq6aIxpRmtlU6LYwFdX1OTkRwGUoIxbQhK5h0oLCGTNHFzBOdLHrlASWYWBjwGkQA
	23bOGzGFhWUI2aOmT3q8YBBK3TCz0NoIejPtrYVsnIOyhrAUekCDoRup5pwqKYOaGsBZYRM3OOR
	XkYSAkIrSQI1uCS9h/t4Bgom0vH+2ppZoNQBBiRlgjaEkXFN1oaZYa2QNeLgJlXq0F4lM7hdvDD
	k79+vogwA1bXAQ+ZlA+Wp7/WjH3mi04LQHR3c0adJ8m3woAFsBNNyuEEkqki+FaZLq1UVAvtGdv
	fSZsuqGMt985YcbsSetZj/ibYHEMwqS7DBmob6uIZtGpM6sWRtq2MlA3k7AhArMNCEkQ3ZK2Ua0
	QGggHND9BJl1GEVxCS3nKT3AVE8L3XfQuxs8/ZMsSBeK1TGT7qmLd5eqEeKA1oszFB79lc6S/rF
	BjuA==
X-Received: by 2002:a17:902:ef07:b0:295:99f0:6c66 with SMTP id d9443c01a7336-2a8d990b344mr106313665ad.36.1769968268671;
        Sun, 01 Feb 2026 09:51:08 -0800 (PST)
Received: from localhost ([2a03:2880:ff:56::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b417394sm122466005ad.42.2026.02.01.09.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 09:51:08 -0800 (PST)
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
Subject: [PATCH bpf-next v5 14/16] selftests/bpf: Update task_local_storage/task_storage_nodeadlock test
Date: Sun,  1 Feb 2026 09:50:47 -0800
Message-ID: <20260201175050.468601-15-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260201175050.468601-1-ameryhung@gmail.com>
References: <20260201175050.468601-1-ameryhung@gmail.com>
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

