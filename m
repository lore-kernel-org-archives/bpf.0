Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732F544C77
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 18:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710527333; cv=none; b=YCpGRu9CpM4aJp4Z0LBFe99eMDilmbMizSRVKjSRgp4uGLLzxnioXzgvtaCBcdCj0Wt7OltDU9YY8YsWWDqAQ+0l7H0uD8HU2S8xhGwNhRSA30vV/WIelCXqa2IHmGr2ajoZV5konMrfgraoDjnqg05Ct8lH0/Tvk1lGGqDBvnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710527333; c=relaxed/simple;
	bh=lWf98zPH7AshEAfiihgiLaljEiVmaYNX6Bsa9pdVB3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cL8P+9L+A3Cv3EbCuY80KW0BJou1IrwKn4QgaAnSmGVWzngBxXxslhrnj+0DxoUW1Bi39kYvR3lU0ANfRs1XZFeqrXmtx6A7MTduBm45EjhsPZQTjz3IW1KO9++5S/W4heNUtvNncbKi+rSoTpyl4XitoDKg39B0w4mg+ALIBx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com; spf=pass smtp.mailfrom=netflix.com; dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b=fkMPeTfX; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netflix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="fkMPeTfX"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7c8c71ebe33so42466439f.3
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 11:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google; t=1710527329; x=1711132129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lCgfh3Sxm/BV+pCR26EGSXvQQ7SOcSkk18NjS+RmHtA=;
        b=fkMPeTfXdww4tYqDlvBxrFDh4WXGOgfIsQ4XeTXXCCzBD1jXRy+CIsK521iYLfcmNA
         D6rf+ZmZqeqH+RZFa9pmr44vr5hljIw9aEVbb6R5uiqs0oF2j9NwbhiVaMEDCl/uRhui
         KpvrSY6oZ29LOLP23D06QZLwkD+wdAQcKbBxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710527329; x=1711132129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lCgfh3Sxm/BV+pCR26EGSXvQQ7SOcSkk18NjS+RmHtA=;
        b=d2w408n4mPjwKBH7kcCv9Lr8eeIYUhP2BMjbjT+HUnlK9/Dgewl+RgU6s+Hg28yiBz
         JvBqTmp0kDmpQxaypQP7EfOUKtgpD7Qh7xS1paXTW5MJE8xcpsF4BCq8040stP4xal8z
         4NnwNpaLRcQcc6PmoEG4pWsHcoRYdkA+/iwaBjw2VtPHbpJAkoUGkSGZGCD4hCoLlUEu
         1QTk1NVB+42GCOhX5NkeAviqrBy/8/7Py1x+pMJTA+41tD1tGHKUujI8ODLVX8XyO8+M
         3bO9uX3H3ypzr4HnRpT9NK1miC4HztJ4/PSMVNawpevEL/U6pQRVLGVr3BgqyvIYidPq
         DvWg==
X-Gm-Message-State: AOJu0Yw71TTZ5a47VQQ+z2BJ54bZCQ4HOKnQH5jbaDBtMxDbZXftzkS5
	1yT+YsEMbtTPp6KgwvCZebWjNX/MaTzFf8lZXEIDQdvdDWmS78dDfR3s3GsrC9c=
X-Google-Smtp-Source: AGHT+IGbfe1+m911z4rDE0JLVaBIDIJ1kWDx4d7pMYs3vMUJE4YT+724SXKHssUqJerD08G4ekyvPw==
X-Received: by 2002:a05:6602:184b:b0:7ca:ebbc:ee27 with SMTP id d11-20020a056602184b00b007caebbcee27mr5832106ioi.21.1710527329584;
        Fri, 15 Mar 2024 11:28:49 -0700 (PDT)
Received: from localhost ([2601:285:8700:8f20:c760:7c0b:344d:cd33])
        by smtp.gmail.com with UTF8SMTPSA id dl22-20020a056638279600b00477b9971a45sm185526jab.17.2024.03.15.11.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 11:28:49 -0700 (PDT)
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
Subject: [PATCH bpf-next 1/2] bpf: add btf_task_get_cgroup_id kfunc
Date: Fri, 15 Mar 2024 12:28:03 -0600
Message-Id: <20240315182804.216081-1-josef@netflix.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch enhances the BPF helpers by adding a kfunc to retrieve the
cgroup v2 ID of a specific task, addressing a previous limitation where
only bpf_task_get_cgroup1 was available for cgroup v1. The new kfunc is
particularly useful for scenarios where obtaining the cgroup ID of a
task other than the "current" one is necessary, which the existing
bpf_get_current_cgroup_id helper cannot accommodate. A specific use case
at Netflix involved the sched_switch tracepoint, where we had to get
the cgroup IDs of both the previous and next tasks.

The bpf_task_get_cgroup_id kfunc returns a task's cgroup ID, correctly
implementing RCU read locking and unlocking for safe data access, and
leverages existing cgroup.h helpers to fetch the cgroup and its ID.

Signed-off-by: Jose Fernandez <josef@netflix.com>
Reviewed-by: Tycho Andersen <tycho@tycho.pizza>
---
 kernel/bpf/helpers.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a89587859571..8038b2bd3488 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2266,6 +2266,27 @@ bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id)
 		return NULL;
 	return cgrp;
 }
+
+/**
+ * bpf_task_get_cgroup_id - Get the cgroup ID of a task.
+ * @task: The target task
+ *
+ * This function returns the ID of the task's default cgroup, primarily
+ * designed for use with cgroup v2. In cgroup v1, the concept of default
+ * cgroup varies by subsystem, and while this function will work with
+ * cgroup v1, it's recommended to use bpf_task_get_cgroup1 instead.
+ */
+__bpf_kfunc u64 bpf_task_get_cgroup_id(struct task_struct *task)
+{
+	struct cgroup *cgrp;
+	u64 cgrp_id;
+
+	rcu_read_lock();
+	cgrp = task_dfl_cgroup(task);
+	cgrp_id = cgroup_id(cgrp);
+	rcu_read_unlock();
+	return cgrp_id;
+}
 #endif /* CONFIG_CGROUPS */
 
 /**
@@ -2573,6 +2594,7 @@ BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
 BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_task_get_cgroup_id, KF_RCU)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
-- 
2.40.1

