Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED3344CAE9
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122548; cv=none; b=a8xM0x25UuoJQ9JvtJq7KxAvpiHr8iRoDvOrK3aFGi3Tf4bCG1/7Z7Fccyz1qobPXQxEgbUjEc0tjs9yfQS4Uyuhoeb/J7aeP1fHFrYuIN/TtqjTlQ/o/Ej8fU8kVkg15w0S4c8euvOOCZAC5DSlAE3WHftI3Gjb0XokR859HaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122548; c=relaxed/simple;
	bh=opgV5IOMQS++JhFgCfNlfE0WpYn6znZgtya0Dk/E3fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gh2ZLT+Ft/JHJCExEEAgdaKqLkUg68hUgwxY1lmDwLLRTK+zXnXx+kT1Mk23RTn0ueRSqhH0lavEf5W1uv7IjN76N2JPwIuRnJRhXhPV6Np93JYc7iV61+Zpr1zgB4iRDgYllFtRObr9o9srC2BcK1zVaXXgN7HW+4JWWYuZTAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zt+y22BQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zt+y22BQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE12C116C6;
	Thu, 26 Feb 2026 16:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772122547;
	bh=opgV5IOMQS++JhFgCfNlfE0WpYn6znZgtya0Dk/E3fU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zt+y22BQoCKfzbbT7xCDpsjz2RHmQGf8oExn1+pBy1imyKKO11OAa6CTdoOZGddDP
	 2WyqRVX4zUz3OMXxPosXmvbNXFS8Cq2C3LG1aTubyvOex8BqywLAWwwucFdXILeKfI
	 leWD/8v7CwKUanereUn1tgV3LT1RYAG/c4rX9E7Tvvl3tChfMcUDjTg5fbF+rijrIb
	 x6LppvIbz0zTzF+WkTdpdX/0OYNNECJ+0pzJMrC0g5egSgU5LMomqeLl5TGBr/jqrn
	 xyihTcJUMc/nmt+Vx3wb1NjOcguzgDdndxfjO+zRH46iajikaFDo6VH+EOrbBcGIAu
	 SHVD8zi0DYHZA==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf v5 7/8] bpf: Add split iteration support to task_vma iterator
Date: Thu, 26 Feb 2026 08:14:56 -0800
Message-ID: <20260226161500.775715-8-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226161500.775715-1-puranjay@kernel.org>
References: <20260226161500.775715-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wire up the task_vma iterator to use the KF_ACQUIRE/KF_RELEASE and
KF_FORBID_FAULT infrastructure from the previous commits.

Annotate bpf_iter_task_vma_next with KF_ACQUIRE | KF_FORBID_FAULT so
each returned VMA pointer becomes a tracked reference that prevents
faulting. Add bpf_iter_task_vma_release(it__iter) with KF_RELEASE that
releases the mmap read lock, drops the acquired reference, and
re-enables sleeping. The next call to _next will re-acquire the lock via
mmap_read_trylock().

This enables a split iteration pattern:

  bpf_for_each(task_vma, vma, task, 0) {
      u64 start = vma->vm_start;
      /* vma access allowed, sleeping forbidden */
      bpf_iter_task_vma_release(&___it);
      /* vma access forbidden, sleeping allowed */
      bpf_copy_from_user(&buf, sizeof(buf), (void *)start);
  }

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/helpers.c   |  3 ++-
 kernel/bpf/task_iter.c | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6eb6c82ed2ee..e4d0a3a62428 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4605,8 +4605,9 @@ BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_task_vma_new, KF_ITER_NEW | KF_RCU)
-BTF_ID_FLAGS(func, bpf_iter_task_vma_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_task_vma_next, KF_ITER_NEXT | KF_RET_NULL | KF_ACQUIRE | KF_FORBID_FAULT)
 BTF_ID_FLAGS(func, bpf_iter_task_vma_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_task_vma_release, KF_RELEASE)
 #ifdef CONFIG_CGROUPS
 BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index a85115c191e4..55b264d634db 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -879,6 +879,16 @@ __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_v
 	return vma;
 }
 
+__bpf_kfunc void bpf_iter_task_vma_release(struct bpf_iter_task_vma *it__iter)
+{
+	struct bpf_iter_task_vma_kern *kit = (void *)it__iter;
+
+	if (kit->data && kit->data->locked) {
+		bpf_mmap_unlock_mm(kit->data->work, kit->data->mm);
+		kit->data->locked = false;
+	}
+}
+
 __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
 {
 	struct bpf_iter_task_vma_kern *kit = (void *)it;
-- 
2.47.3

