Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D554321CC59
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252478; cv=none; b=qfOJGx0d9hS7hPegKI/d5sgMDNNeaLQoRW6JRsnXyG+keoH2RQ4S1jtTVy1pZp/a4sxkCTCdeQJCCt0GOU+ApGt4Wlw9c7kwgUfos2nUHzfjYi9PjNj5rfdrMoCba/g9IFRerQFSLdarkoT3em1T4xnzoDm11GuZud0rJ84ycSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252478; c=relaxed/simple;
	bh=I4my/LYj+yUD/4GouKxkZKg9azWROTPg1jyt3aShvm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqse99u06yU8IwO4N75gZghIpmBqHT1dlUJy157JUbKTydpsaE6xPtjZXsfunX5MPSwF2c+jH0WxtX+r1kLy1yqCaqqFcrO78KkN0O/1sEsA6MjBf5IzeBTbpFEBlLElsTPC/0KQ/jORyg80FJEhA1lznqeKXf9Cx3ebVViEL+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhxuXyyj; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhxuXyyj"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-83975e992e1so1087333b3a.2
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 08:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252475; x=1778857275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQGcz1ZaEzbqgScDrowVXARi09LONkb6J25l1BcDqBA=;
        b=VhxuXyyjwJ+jQxRJYVyuReBo7qp3XSRZWtRMTaL+On3/IYebkvJmepRf7YvB4gjtSG
         hcb32t2fgcXQ0vHMpmifRusIXJeWztPjkEhIljZWs4/28Gw0Co/scvGvDArEpIqsF4gi
         8DI+r+WXe+65WwF7/+JjU4MGvG7V2DfEMoKcTO+jyL6QIfhJnKAHFzt8cwRqIM1VlQw7
         XzMbupn73ETcDPdgebghLUu09X+3fhlpkATohZfFpPPNVjNeUNylzDNn6ajlwpTqqwmp
         0gbGUggv6HHMOw5GPYgOuRW/jlpQoE6oTKeplmYhTaogi9CHdOGtcW9juQpgv9z02sC3
         ziGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252475; x=1778857275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZQGcz1ZaEzbqgScDrowVXARi09LONkb6J25l1BcDqBA=;
        b=W6HxUfG1u++xPhfench814caZiZHxBvhuus5vWLj+M9QLX/7+LqmP2zCEZk1I2oXEi
         +9+c8zrd68SBtB3aar1MRjuCvAmkpaFPr6t/iORX7TrgXeNDzZT6PZUMTvwokMWWncst
         O4z+y6tHL4XakG+qVLB9b07bMtPIkcEIFEPyhY1P2ssiO8aRp+q1ZbX8zwaXCvBpWztE
         c7L+KXEnd7f9Qiv9lYfcEce/40LwpteF4Rcl83YrCnbgUNODqPWYK4o0WErBJiKLjagN
         H8O5M3xSVdQjFPb7idgsjiDKDZf8t73SySfT1mwRzOABR2B7yIdTcl79pYuV34w0yKhO
         0rjQ==
X-Forwarded-Encrypted: i=1; AFNElJ/8NTktIsyWnajKJh8dAF2jiq/fZ+92WEGA3/ij2X0GkkpVbezhMcLMfL/XSUWjoXg2Bpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvQ8YpIILIqDtYIsh9Th2P8AnsWjLycP+ZSHEjweG3c+JhzrTN
	qWNsYtCJGJ+L2Pv9yVqPmYAUrBMnIPv8uPOn19ZVLFTfJ/wcmmCkbbWX
X-Gm-Gg: Acq92OF0R11Py454O3+PEjzmE+nPfyg1Tl+Ste4pincQpP9uC8HhhPPko6d5+J43tPG
	Xw/AKk6/G3p6EahSrqb4U0aGpH8c2x6r+mNKFJmw5OC7cgOydcQDuxi40c4MxzmX+xMS+NSpwo1
	ffXxV7MR3JsnKJD9B4OxRy5u8c2OJJu1h5xEw1XXe6h9xN2baKH4UGfooKKK1CKv1LQr6L3Kvls
	5nftOE72RT9H5ksEqRMnuEXle1xcsbGIde3Nx+rtgCvpqwRKwjP34b7ur8PRCpGMoo5hAr6MKka
	JJQyUSnqpnIDYjNNHoi9ziZKp9CITl0YMCgjxxv8smTLcbySEzVSHEu2XqGqjatn/71w23mt9og
	EGcKCkXT3o8l1TmYs8H17KWRx59caK6VBc4GMuChDdN5CYQFG7xPmqvrJJdWhIUXq6sm2+1ZUhy
	S9FNNFM6crjCNt+NdbQEPI045vxrua5D2z4FDRV4l+/3xyRKc=
X-Received: by 2002:a05:6a00:4191:b0:82f:abc8:ae0 with SMTP id d2e1a72fcca58-83a5b9dcbe5mr11724552b3a.17.1778252474804;
        Fri, 08 May 2026 08:01:14 -0700 (PDT)
Received: from localhost.localdomain ([114.231.84.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965945c1bsm13110064b3a.15.2026.05.08.08.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:01:14 -0700 (PDT)
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
Subject: [PATCH v2 1/4] psi: add psi_group_flush_stats() function
Date: Fri,  8 May 2026 23:00:52 +0800
Message-ID: <20260508150055.680136-2-vernon2gm@gmail.com>
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

