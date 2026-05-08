Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76742459E5
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252487; cv=none; b=jVE6IYHtD/R8uG1XZgc4IRZvTK3mqToTHZ/1zrnz6Vk6QcbApzZqvmEwBvreZKBxCXfrGprt7NDVARheSyqpNxcg9YvGMNq4LwDxQTxtZ3d7yvTZR6Jb8x0z4pfHEiCyYMbR1BH5Xm10ismmJA7yAms6pq8K1eHV7XkqCuQXQ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252487; c=relaxed/simple;
	bh=jGeM0yncAreFGWSxvrJhUl2XzEwjtH2RSF4Lh7ouqhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNOrdDTzkj2LY2Gpg2514x1Z30I5A4WXwuvh+Jq9+1G/YBJRUO4aBVhoIguVWi4pvoLjxs4RkAYcZl4yK0T1emI98qsR/m+Gxf/Y29gUrJTkyrjkRNlTvbMSGcdoHREAOqdNrhOXhq8sYX0n5Iynwxa/VzLL7BJ3a1L2k7Tfe/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jy63HMjd; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jy63HMjd"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8353c9f24d2so1186484b3a.3
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 08:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252483; x=1778857283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QueeMM+8Rtdi14b6LI2wohmsfdt2dh1GY7mMDDoIeZw=;
        b=Jy63HMjdEH3LRh32D6yLv47E8yiK/+GhjDBlXvUNaRKMYz/0ljk1I+UbuyPZDP+9aR
         L7LEqDFHKU9To9tLk/157nPESEkftoazEYzifd59jq6uG1eMZhCdK2x/W9anK2D2Bjnq
         bxjlN+Mvx74wuTaRSXAv3Cle1cMTDBkuyr0rgqKnCf2pgjgcSF6T68rotCxv38RbbIqC
         pyupXGBECDbNJnI0PcSndbsl+PFm+9u3dn6fegk145VXnTEtUVDlR3QXbx9PMA/zUiPl
         XKQpr1a358syuXIHbP7xAKmtnwt5D8cC652axEg9+vX7lGQqxI+FvGo2HOkGsDVNEqqp
         dLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252483; x=1778857283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QueeMM+8Rtdi14b6LI2wohmsfdt2dh1GY7mMDDoIeZw=;
        b=lJ7i4arYC1QBZJU/2QtwU3Q/I9gVBL55EaJNr6qfBHw/RcDj8oozxI1/vju+5D+Ojm
         gxZ6prTlScmWqffyH5ggP0mp1SySVvo1kDaWSo1lzkIKZz4PsHmPeRlM8GGGExiFLQvN
         /IDobMrRZtK4sP1Rz7tdvd/yTmcbsCq4wVEzfFpx0CEh12cIBDGK1i/ILjNm6tT9pBaF
         l7P+cU9KNo1yIqew8gZjGyck8VkB80TiXFdvbc/LkY+HvLZDneBs0xBiC5NdVnH51FA2
         OwX901LBVXUVd8LrRSNoV0L9UTEvmkMsV57goMdFchS9WAwCPEOltExhUbetwfqWXKUf
         8Ouw==
X-Forwarded-Encrypted: i=1; AFNElJ9wPFpiexn2DGEX3WVYSwepN5wE7pPT0r2EWaFjTR/Ub5SDuB3EFIBeQX13ZMT8FC67dEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmVESDb+cGYnAGIsVnTsNzDNU5vPsC8xAC0zkeVrI0+ldjLPMM
	vAjw57d7P/W6oqm/cK7d14ku9AAGeBakVf4QrvJrox2EdYxTNulZoBqy
X-Gm-Gg: Acq92OFl2fO1IL2aiF0FeG2kQrfb8jtm0IVtICll62uyRi1UQNqoBB8KOihczecN/nO
	XQMS+sY6NskMcwNS66d0ZHom7t87dTsmyg570FO8/TraB4k06r/R4ZfbyaVz9mtPOCPOyhnC35A
	GF3s8Os+oi4nzRRaCBBIS740+yMrxGYHmjovXj5Q8jU5RodxakejBRNrs2n8s4eV/ZOw+VFrWoF
	3XkGRYFHSNeCg3AvGR6+Bz+bGuzFm1FkDYf8iGlbqLN07QnSQKRwmhJiElbxG93xiJKskU5fp4D
	NlKYMNsSFE/1GQ7eTphBxW/1ZF804cbBicW8D1uXw6S2wF1BaL/jvkfXynf1H8Ze49cthTZVwgi
	HQIp75VFBbl3A51zcMiQlTTTTV0CwXbOfx2pOMOlNKa7RFmV64sJcjufQd0o/xhUZgM0HSPPhYz
	pxYKRxFHvUprz/7W0q6h4NFVKzrMhN6KUgfsOQ
X-Received: by 2002:a05:6a00:aa08:b0:837:f79d:909 with SMTP id d2e1a72fcca58-83a5e13d6d5mr14036326b3a.39.1778252482867;
        Fri, 08 May 2026 08:01:22 -0700 (PDT)
Received: from localhost.localdomain ([114.231.84.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965945c1bsm13110064b3a.15.2026.05.08.08.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:01:22 -0700 (PDT)
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
Cc: tz2294@columbia.edu,
	baohua@kernel.org,
	lance.yang@linux.dev,
	dev.jain@arm.com,
	laoar.shao@gmail.com,
	gutierrez.asier@huawei-partners.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	Vernon Yang <yanglincheng@kylinos.cn>
Subject: [PATCH v2 2/4] bpf: add bpf_cgroup_{flush_stats,stall} function
Date: Fri,  8 May 2026 23:00:53 +0800
Message-ID: <20260508150055.680136-3-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508150055.680136-1-vernon2gm@gmail.com>
References: <20260508150055.680136-1-vernon2gm@gmail.com>
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
 include/linux/psi.h  |  4 ++++
 kernel/bpf/helpers.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index 7b4fd8190810..243dcf97bea4 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -52,6 +52,10 @@ static inline void psi_memstall_enter(unsigned long *flags) {}
 static inline void psi_memstall_leave(unsigned long *flags) {}
 
 #ifdef CONFIG_CGROUPS
+static inline struct psi_group *cgroup_psi(struct cgroup *cgrp)
+{
+	return NULL;
+}
 static inline int psi_cgroup_alloc(struct cgroup *cgrp)
 {
 	return 0;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 2bb60200c266..1c353e0ff14f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -29,6 +29,7 @@
 #include <linux/task_work.h>
 #include <linux/irq_work.h>
 #include <linux/buildid.h>
+#include <linux/psi.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -2881,6 +2882,37 @@ bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id)
 		return NULL;
 	return cgrp;
 }
+
+/**
+ * bpf_cgroup_stall - acquire the total stall time of cgroup
+ * @cgrp: cgroup struct
+ * @states: psi states
+ *
+ * Return the total stall time.
+ */
+__bpf_kfunc u64 bpf_cgroup_stall(struct cgroup *cgrp, enum psi_states states)
+{
+	struct psi_group *group = cgroup_psi(cgrp);
+
+	if (unlikely(!group || (u32)states >= NR_PSI_STATES - 1))
+		return (u64)-1;
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
+	if (unlikely(!group))
+		return;
+
+	psi_group_flush_stats(group);
+}
 #endif /* CONFIG_CGROUPS */
 
 /**
@@ -4734,6 +4766,8 @@ BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
 BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_cgroup_stall)
+BTF_ID_FLAGS(func, bpf_cgroup_flush_stats, KF_SLEEPABLE)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_from_vpid, KF_ACQUIRE | KF_RET_NULL)
-- 
2.53.0

