Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72F537C924
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777827074; cv=none; b=h/yClSfCI+xcvQ9rr4l3ZvCk975fv/0FJnGhUgvgshuaK/BYrA2rBqzEIsN7ZH+hKPk3c9FkyT0yt27vqqsiw0jzkvunyJaufJCsj4i9hTu39LTBMecu7xkFGVyI+25k1NboAshjdPcrardbyC+5TWgXrbG4ce6nNUojmCe5vNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777827074; c=relaxed/simple;
	bh=cg0Bbj9AjsnGxOq+y64e/b7OOW2yTNEQkbhwRm29D18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8JLE0IKpibg8Zu4WkerZOhpaoRfkePVHrwUBHNUKCp/nLCMwtpaZDUK+xnkNq6y4E3Kqr8o7HKy+PuVUvikIKuVoZEGE0PNXj8ccSvjqv0854rzYEf9GaXtzwC74P3FBfFvz/YKcz6HlU0OS/NFQ2fTPKT9otyC0PvF6HoZR5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8uc6kUE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8uc6kUE"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba21d32776so1641555ad.2
        for <bpf@vger.kernel.org>; Sun, 03 May 2026 09:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777827070; x=1778431870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54CfH1z6TNt780aoevT0/jV5wyQdFbwCsijFcJJLlPI=;
        b=F8uc6kUE4I6zWfN5IDXIex5D7Mpv+4viKNr/FUdgjEpJtG6ECX2Htn1wSq6dxFng42
         lERQ3CqDvSR7kftoEHGNv5i6E6cW+3zoj5lLucwIGcur3DR9tvKf+7fDeuRmOswKtS7i
         dGeIr2BRUN7lVaL4AOjEQ4IZCRewz3T5a61Ji5clBsR/vFlduKYn9Whsn031jBn782xJ
         CXsJvcYOPP0pmcoRrLP+3Dj3LSc8RDKhoBYh4U9bPdfFvFcxzPYbzUYLSftiPj2XIGXm
         oOs5UFrj7rbgPlGCcVnKE9Ic5mXdwB3Bt4DvJZNhGPxlHHpQFlAqERf8LitN9o54OkZ3
         s5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777827070; x=1778431870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=54CfH1z6TNt780aoevT0/jV5wyQdFbwCsijFcJJLlPI=;
        b=MzVZj8Ouq3hx+j7Plv24PD0OGKwIMCmjGylEd0mqaHUTlB54kl6klN5/Z+IL9TTaXO
         Zpbnan4mWNQ4raZ+9zS7eSwabCfIH2MGmLFyGko3uJX6Voo+EAMqOaMS+zqOOV/O/VTr
         MX8Qb9G1zER0oXHUsyW9CSqwHAsZUU4XawKA42IgyZDU5wJkI8ZQHnOm2x0IxjrgOK4B
         xlyv0Wq9fIyTPrN0mHXTyMGe0CyrgVEFOoan6uN/vbWsiay6uL7LAndwKlAiMshi4cK3
         JwVjN8yc4QIr6Ws80gvf0ivSTPshIFgVvlMe0hkOMgnfJAVM8/scgGgzCdSnl6fQPTk+
         QULQ==
X-Forwarded-Encrypted: i=1; AFNElJ+U1zmufo+StSUqVAniuJz5fVILRuxWY/XNJ5Gi0OP9feYRs6V2znlhrRMMILfk0PfhvHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPcRKWF0cSfrwM1oKmxhitl3inRN3rQQz6QajAP0UMd7ccvNwY
	B+bKW7xNKJlbJnjycPmoZcunkfu/SqZF1RlHI2dLVdWTpjU/b3aUUH0A
X-Gm-Gg: AeBDieuFbNXFVI+qlcJp2sZoUhOpclwV2WqKI4ngXsJWy/6KHtxo21PW3GDCX81cHVV
	2VKgY1HfF+ldbn/ipIaX4Be64OeaAzjTDIKMqT5HHDKvFbsMXFl0sq2d5wm4QkaVc/gGiyYPTTS
	0faAuJWVEztGDwtCCAmke9dQelG7ybNHtZ3RNcbalxuNPjHaxDVT6BrupnmU42Cf7YljEa/LJmr
	/yFixz0l80BO1g++++RFeqXzijmull2eau+C6myNHtG5NtsX6C1W6U9x6cp6fJxYNXTamczXFRO
	NroGnx1Q0HTqtCG8EL1L1fdrpVBKC7qszXHKNhArm11QVXu515QbRno6GcDGM90bCpw5RmfKbHD
	D+i2QOorp56BY1vtZvhV8ACJ7TADYwB31ij4fIOX8WXLI6KRyxmrFFJDEkRpGQO89DgokzWYmtp
	Sdtt9HCv5eF8XAqRzIdqxWumtj+nTf3K2SmF1vmspty722Sj8=
X-Received: by 2002:a05:6a20:4327:b0:3a0:b65a:5df0 with SMTP id adf61e73a8af0-3a7f1bc4159mr6507949637.29.1777827069644;
        Sun, 03 May 2026 09:51:09 -0700 (PDT)
Received: from localhost.localdomain ([114.231.84.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83707fab756sm1494277b3a.44.2026.05.03.09.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 09:51:09 -0700 (PDT)
From: Vernon Yang <vernon2gm@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	roman.gushchin@linux.dev,
	inwardvessel@gmail.com,
	shakeel.butt@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	surenb@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	baohua@kernel.org,
	lance.yang@linux.dev,
	dev.jain@arm.com,
	Vernon Yang <yanglincheng@kylinos.cn>
Subject: [PATCH 2/4] bpf: add bpf_cgroup_{flush_stats,stall} function
Date: Mon,  4 May 2026 00:50:22 +0800
Message-ID: <20260503165024.1526680-3-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260503165024.1526680-1-vernon2gm@gmail.com>
References: <20260503165024.1526680-1-vernon2gm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vernon Yang <yanglincheng@kylinos.cn>

Add bpf_cgroup_{flush_stats,stall} function to prepare for the
subsequent mthp_ext ebpf program.

no function changes.

Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
---
 kernel/bpf/helpers.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 2bb60200c266..87f3072adce3 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -29,6 +29,7 @@
 #include <linux/task_work.h>
 #include <linux/irq_work.h>
 #include <linux/buildid.h>
+#include <linux/psi.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -2819,6 +2820,32 @@ __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 cgid)
 	return cgrp;
 }
 
+/**
+ * bpf_cgroup_stall - acquire the total stall time of cgroup
+ * @cgrp: cgroup struct
+ * @states: psi states
+ *
+ * Return the total stall time.
+ */
+__bpf_kfunc unsigned long bpf_cgroup_stall(struct cgroup *cgrp,
+					   enum psi_states states)
+{
+	struct psi_group *group = cgroup_psi(cgrp);
+
+	return div_u64(group->total[PSI_AVGS][states], NSEC_PER_MSEC);
+}
+
+/**
+ * bpf_cgroup_flush_stats - Flush cgroup's statistics
+ * @cgrp: cgroup struct
+ */
+__bpf_kfunc void bpf_cgroup_flush_stats(struct cgroup *cgrp)
+{
+	struct psi_group *group = cgroup_psi(cgrp);
+
+	psi_group_flush_stats(group);
+}
+
 /**
  * bpf_task_under_cgroup - wrap task_under_cgroup_hierarchy() as a kfunc, test
  * task's membership of cgroup ancestry.
@@ -4732,6 +4759,8 @@ BTF_ID_FLAGS(func, bpf_cgroup_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_cgroup_stall)
+BTF_ID_FLAGS(func, bpf_cgroup_flush_stats, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
 BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 #endif
-- 
2.53.0

