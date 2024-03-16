Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F11819
	for <bpf@vger.kernel.org>; Sat, 16 Mar 2024 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710606185; cv=none; b=AcY0XLaTYjp6f7hI4wKGfzTdXmqpKWeEJ2q+05dXXemrl8bqjqfjKpfIcfGJlc959YduuZTVVujCBj0BxZNG1H4pXFm+0xgMt7lh901me+tRrebmRY5U9lUkxOrJDI+Pkq2rVqmG0SxmdOrxze+vC1Ln40gY3VZx8DvjuwI681o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710606185; c=relaxed/simple;
	bh=m32Ko5crU9F2s1OcBQcoiBz2kFB3BBOwrX7vUOXoXDA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eMx1ZuHmvh7nLI/kwNC3NUtZHqG5nnOdZKOyXKg2xj/eTGCfUmLOdDDA+WvifSKRHV6LjAHdWsxB9JglYNPnXU4xBn73j89etFGmZCpfbYPiYWKbhfowPrqkxNXS+CogkkQL2DXtNVzRShm96FMXpCfSMFzKWfi5fcEl+fHK1yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com; spf=pass smtp.mailfrom=netflix.com; dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b=REEodlIJ; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netflix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="REEodlIJ"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7c8b777ff8bso87240339f.0
        for <bpf@vger.kernel.org>; Sat, 16 Mar 2024 09:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google; t=1710606182; x=1711210982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Foqi+aqcfZXTaDDszcOGG4bLdYmJsSqibIZG875f+rM=;
        b=REEodlIJj2z7005lcKAisTo/7fZLGIN442kfRFN4rDg8XC6ExVRiHgvuwynJqGdlJC
         UyCU9AQXum+AUE3XQNROfqblO9DXLD6RMk86AB/ziVku0in0hcdm9HEFzxRfp5SzkpCv
         Aj6Cmy0UloC0GhW5PZI5Hwi9PeQymTS1HIk08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710606182; x=1711210982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Foqi+aqcfZXTaDDszcOGG4bLdYmJsSqibIZG875f+rM=;
        b=dEjio4Rl0ERdcvR9etsIiPxIsf384kZQB1bLiyhM0tUpDaNahyvu3qXYQnFQWdQICy
         BugbHdYBl1zTQM3ALzF1u60rEtXhlEsgX8Bi7+ZdDeO0VPbeehLa+GeUgzODl0y1B8Ul
         ITANIDqFrWDARjcjAkv2BtmaFYHhq3OL9UgMnKcktvbsAmJbTw28WXoK0Y81NAIoHpi0
         HCawKgJCLry/PYl/DTrV71/zvVO1PAveUSjTAaaAHF6yBlOxyO0XCrLD7iajSbs2bfbR
         KNbFghVbk1mn0YBDN8BUnuSL2vvUuAZzfozRuR7qzeP1j68rzUu13GzOpUyc8OwNEz7G
         ZW6A==
X-Gm-Message-State: AOJu0YyA1d3CjbdqLb8Z8t17d+eAGaFqKT0IDqXIoxi/8ePCiP/qTH8X
	+TEIVgAt3FUapKdRCayRBQ91yJxYdUClhVyGsce6n2sJVG9rKP86r6U0Ho6KXcI=
X-Google-Smtp-Source: AGHT+IGciyhMjlL8JyLAEmBCajcsxu8m4W8uJrz5ahSzgBWI7hzEyJTgWw+UAO0pZH45ck6FSblYaQ==
X-Received: by 2002:a6b:c801:0:b0:7cc:5d3:3c9 with SMTP id y1-20020a6bc801000000b007cc05d303c9mr2585462iof.8.1710606182114;
        Sat, 16 Mar 2024 09:23:02 -0700 (PDT)
Received: from localhost ([2601:285:8700:8f20:db82:ef0d:e122:37fc])
        by smtp.gmail.com with UTF8SMTPSA id w14-20020a056638138e00b00474d1b1590dsm1353203jad.133.2024.03.16.09.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Mar 2024 09:23:01 -0700 (PDT)
From: Jose Fernandez <josef@netflix.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jose Fernandez <josef@netflix.com>,
	Tycho Andersen <tycho@tycho.pizza>
Subject: [PATCH V2 bpf-next 1/2] bpf: add bpf_task_get_cgroup kfunc
Date: Sat, 16 Mar 2024 10:22:40 -0600
Message-Id: <20240316162241.628855-1-josef@netflix.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch enhances the BPF helpers by adding a kfunc to retrieve the
cgroup v2 of a task, addressing a previous limitation where only
bpf_task_get_cgroup1 was available for cgroup v1. The new kfunc is
particularly useful for scenarios where obtaining the cgroup ID of a
task other than the "current" one is necessary, which the existing
bpf_get_current_cgroup_id helper cannot accommodate. A specific use
case at Netflix involved the sched_switch tracepoint, where we had to
get the cgroup IDs of both the prev and next tasks.

The bpf_task_get_cgroup kfunc acquires and returns a reference to a
task's default cgroup, ensuring thread-safe access by correctly
implementing RCU read locking and unlocking. It leverages the existing
cgroup.h helper, and cgroup_tryget to safely acquire a reference to it.

Signed-off-by: Jose Fernandez <josef@netflix.com>
Reviewed-by: Tycho Andersen <tycho@tycho.pizza>
---
V1 -> V2: Return a pointer to the cgroup instead of the cgroup ID

 kernel/bpf/helpers.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a89587859571..bbd19d5eedb6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2266,6 +2266,31 @@ bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id)
 		return NULL;
 	return cgrp;
 }
+
+/**
+ * bpf_task_get_cgroup - Acquire a reference to the default cgroup of a task.
+ * @task: The target task
+ *
+ * This function returns the task's default cgroup, primarily
+ * designed for use with cgroup v2. In cgroup v1, the concept of default
+ * cgroup varies by subsystem, and while this function will work with
+ * cgroup v1, it's recommended to use bpf_task_get_cgroup1 instead.
+ * A cgroup returned by this kfunc which is not subsequently stored in a
+ * map, must be released by calling bpf_cgroup_release().
+ *
+ * Return: On success, the cgroup is returned. On failure, NULL is returned.
+ */
+__bpf_kfunc struct cgroup *bpf_task_get_cgroup(struct task_struct *task)
+{
+	struct cgroup *cgrp;
+
+	rcu_read_lock();
+	cgrp = task_dfl_cgroup(task);
+	if (!cgroup_tryget(cgrp))
+		cgrp = NULL;
+	rcu_read_unlock();
+	return cgrp;
+}
 #endif /* CONFIG_CGROUPS */
 
 /**
@@ -2573,6 +2598,7 @@ BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
 BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_task_get_cgroup, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)

base-commit: 4c8644f86c854c214aaabbcc24a27fa4c7e6a951
-- 
2.40.1

