Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2507375AC4
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777827061; cv=none; b=mJkvIer5KHPuBBzGlMbR79JrcYMcIGEk6leih3GwzyZBMP0u+M6e8jJxZPm5CcN8VHjDyaggGLuu9YhaTj1aJRe4GAHdBdtw5tTg8ep6eC2ffvQYaaVP3v4nmU0jlH1sKxMg2D47juvmzDKV7ZcxPMxgTyRz4fsxQeJ/nyMSfUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777827061; c=relaxed/simple;
	bh=I4my/LYj+yUD/4GouKxkZKg9azWROTPg1jyt3aShvm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4LGO+xJg6yqj7gKIDI3g6comKBcuwZHg+WygXsctR9aU/Ka6oHqB4wy3epkK8PrrimLZUEN2djGSh9u7lWjYsitSjOXfAeGUNszUafDeeqrGCfTro6jYjEr3lQYfG7YDMNfSG+nrOmSIKUzVzzskLv844kVeMKEAiYmm56N5Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kirnkBUr; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kirnkBUr"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c8027e876fcso107945a12.1
        for <bpf@vger.kernel.org>; Sun, 03 May 2026 09:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777827060; x=1778431860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQGcz1ZaEzbqgScDrowVXARi09LONkb6J25l1BcDqBA=;
        b=kirnkBUrD4i3fSIAwyWfB9Dj+sClJtnXuVjyy8OslpCy7XuLgVPsOIvwqHuv8WmmR/
         dsJIuNl4nnmgDnmz3aF3A+Dcdhv92jZVAEtpl0SnwGzqzWpMRDBQaEi93yh3rM0AlmnX
         d2QI+QGcK0uMVz/ydvZ9Hdkz6ivWA4lvC3Mp4CPPcXFxoTM/TUcwC9AriyxR6PbZqOFN
         GPZ5rrOK4a0iPtpK0RObIX2rDqidi2MwIh7ITxyMtKNUdZds6T+B17iY2XXXyPvi+WVz
         Luh2tt1Vv3jQFbV5zC4YYy5+NQx6plONI3FiC0EuHlGy1nPeyqmiazz/m+w9jtv7RAgl
         UPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777827060; x=1778431860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZQGcz1ZaEzbqgScDrowVXARi09LONkb6J25l1BcDqBA=;
        b=keOUJHXx8PfE95mOaDNYv7MV0CNwb7H/g9E8bUE7KIPrZrsENg8x4rkfMKN/BQb727
         l3XbLeG2JkpoenvrzUrTKg9JRlHQO2TNNvY5PB2gbUOe9dC/dArNxQ5+QDo/g0xxm4mC
         AgfgRZ4f/D0s3Xy+s+hA2WqmbWnKlhPb71UD4pJfQwYZdYsYQy9ifu4qL8ydWodbsRqV
         WOAk/8QrEovyC8g9qs2BqCYTVMqCeZ8dR+P0idhTpU3Q41Pz2S0NdS01tMTbqV5lukAf
         172XJm10wNw/c5+zr3T7+9OgB8tSkA/+yXcoEEX00OIRlMO/CTgXBbq17t8K+TZbYeVs
         D8kQ==
X-Forwarded-Encrypted: i=1; AFNElJ/iS5hLq8lQGA9Zm+sSmV/oVfJNqkC6faZVgRRSoXn43Xm5NtE7W8KXTWUXZiST5yxiZDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9mY2BuF7eAQWawJ+MdOWDDOCrWscC3S1xDsSI861JwDUhusze
	nTNLadukrz+1u3+xKOiW6Yib0mesGoWMclAqfSonvpq5t4yPGKT0A5vK
X-Gm-Gg: AeBDiesZhjgKNEnjPKJga49d86QFOl23c7zg8duRGHbUL9wtFQGRdrBiLz6+nLUsEZl
	we05AXT+hHdx8BHSEbOKuKiLB9KoJia6tQ6ldD6wP+bJoyZxY6+mj74Ppkn1d+um72H2tSd2MpB
	9h4QOIuTVCIXvpaziNH9F/OsYuTQomsf/BxhAkYT/pgNVjeN/PIYt/rPZMYbOho/BNor1Enci0O
	ai/sx7EJu3hOqy4lOQ3PZ14zbcOfWTmgai5ig9+KyfhtBJI79OcVRyZ9J2WOKDvXyYT5i5g8SAr
	xZgMAINu+O/x4LumP9mNM903lX3WEzTuaIInetDNg0Vc5yK2823X4srfm9HNYM8qhOkdr3FLqEY
	f42m5AFzItM+GO9O8ceV8cQI5/DXeI32rf9UkfBuwp32ZQrHwLTj+xf6ZiI9+bJ6cUnYYNWrQUs
	Dv2iEPmcM4q9l4vhaagHmSArhjNzHRlWBaF2bBT5WimhtlIj8=
X-Received: by 2002:a05:6a21:3384:b0:398:a659:eb0 with SMTP id adf61e73a8af0-3a7f1bc4ba4mr6919770637.34.1777827059924;
        Sun, 03 May 2026 09:50:59 -0700 (PDT)
Received: from localhost.localdomain ([114.231.84.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83707fab756sm1494277b3a.44.2026.05.03.09.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 09:50:59 -0700 (PDT)
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
Subject: [PATCH 1/4] psi: add psi_group_flush_stats() function
Date: Mon,  4 May 2026 00:50:21 +0800
Message-ID: <20260503165024.1526680-2-vernon2gm@gmail.com>
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

Add psi_group_flush_stats() function to prepare for the subsequent
mthp_ext ebpf program.

no function changes.

Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
---
 include/linux/psi.h |  1 +
 kernel/sched/psi.c  | 34 ++++++++++++++++++++++++++--------
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index e0745873e3f2..7b4fd8190810 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -22,6 +22,7 @@ void psi_init(void);
 void psi_memstall_enter(unsigned long *flags);
 void psi_memstall_leave(unsigned long *flags);
 
+void psi_group_flush_stats(struct psi_group *group);
 int psi_show(struct seq_file *s, struct psi_group *group, enum psi_res res);
 struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
 				       enum psi_res res, struct file *file,
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index d9c9d9480a45..76ffad90b0b5 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1242,11 +1242,35 @@ void psi_cgroup_restart(struct psi_group *group)
 }
 #endif /* CONFIG_CGROUPS */
 
+/*
+ * __psi_group_flush_stats - flush the total stall time of a psi group
+ * @group: psi group to flush
+ */
+static void __psi_group_flush_stats(struct psi_group *group)
+{
+	u64 now;
+
+	/* Update averages before reporting them */
+	mutex_lock(&group->avgs_lock);
+	now = sched_clock();
+	collect_percpu_times(group, PSI_AVGS, NULL);
+	if (now >= group->avg_next_update)
+		group->avg_next_update = update_averages(group, now);
+	mutex_unlock(&group->avgs_lock);
+}
+
+void psi_group_flush_stats(struct psi_group *group)
+{
+	if (static_branch_likely(&psi_disabled))
+		return;
+
+	__psi_group_flush_stats(group);
+}
+
 int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 {
 	bool only_full = false;
 	int full;
-	u64 now;
 
 	if (static_branch_likely(&psi_disabled))
 		return -EOPNOTSUPP;
@@ -1256,13 +1280,7 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 		return -EOPNOTSUPP;
 #endif
 
-	/* Update averages before reporting them */
-	mutex_lock(&group->avgs_lock);
-	now = sched_clock();
-	collect_percpu_times(group, PSI_AVGS, NULL);
-	if (now >= group->avg_next_update)
-		group->avg_next_update = update_averages(group, now);
-	mutex_unlock(&group->avgs_lock);
+	__psi_group_flush_stats(group);
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	only_full = res == PSI_IRQ;
-- 
2.53.0

