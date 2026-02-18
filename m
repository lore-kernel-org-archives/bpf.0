Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701603090E5
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 18:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771439180; cv=none; b=OV6ej48qcP4koy6QY69dFuqDttnIiS7cDKpXlaoWm4sL5jq4EUu9Crb3m/PqdsE9YDBQMNh1EZv9oDW91XiGh4FgORj4zkpNOg6EeNYPMmJs1AGJE/vqyQsPV+qhb/B33vbTR+3QEsv68CeQ6T4AdRtWlqonHSG0QuOOFl4N1i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771439180; c=relaxed/simple;
	bh=7j0n6T5y3RhoWFTbYcfTd2fxuK+6gFgi8L+0BEwCacg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NV9n4hVW5N/qvDnTGycVJb+pag5UQkQsyk16gvIqFzvPlgVEiGsuyFXBjfQvBh2MzdicLbaMq6YjHjCaINOEjtD8w1JTzHt60WyuJzBbscbDNh17EHgg+TzDiYb5DIegNZH+esGJ84+Gl6EeludT0c7WkrM5xA61tvIys59Dovc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fySLODei; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fySLODei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9A5C19422;
	Wed, 18 Feb 2026 18:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771439180;
	bh=7j0n6T5y3RhoWFTbYcfTd2fxuK+6gFgi8L+0BEwCacg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fySLODeiGYBclxqYSGmggOLIDR7/xaqM83mCb6GtoUYum4SYt2mUnj34Qdyx/Oky2
	 EQomjrZBAErD+7b2Xnb0EdDWttXrBb0x1L8kRVBaEDG9XG9ARuILih6Br7/OY6sfe8
	 1H1gruax6SxmiZ49yD49zxCU8fVI6eAONQhjlulpBrjwixEwgEEnf9/8dqY7FZkknQ
	 fcEiNzP5xAxpDt/aQMt5ylNbLnMKP7WOdhzxU3qaY3rmmOPaL1rcYqFnmG6+8Hohzq
	 mUU2yhC7CZZrGwmq404950VsZaNkxIqmY1ulTkbY2M/MZXU5QRVSWj34d74HSTSUOJ
	 9B3MHA6mVtAjw==
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
Subject: [PATCH bpf-next 4/5] bpf: Add split iteration support to task_vma iterator
Date: Wed, 18 Feb 2026 10:25:49 -0800
Message-ID: <20260218182555.1501495-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260218182555.1501495-1-puranjay@kernel.org>
References: <20260218182555.1501495-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wire up the task_vma iterator to use the KF_ACQUIRE/KF_RELEASE and
KF_FORBID_SLEEP infrastructure from the previous commits.

Annotate bpf_iter_task_vma_next with KF_ACQUIRE | KF_FORBID_SLEEP so
each returned VMA pointer becomes a tracked reference that prevents
sleeping. Add bpf_iter_task_vma_release(it__iter) with KF_RELEASE that
releases the mmap read lock, drops the acquired reference, and
re-enables sleeping. The next call to _next will re-acquire the lock
via mmap_read_trylock().

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
index 7ac32798eb04..b3921c22810e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4605,8 +4605,9 @@ BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_task_vma_new, KF_ITER_NEW | KF_RCU)
-BTF_ID_FLAGS(func, bpf_iter_task_vma_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_task_vma_next, KF_ITER_NEXT | KF_RET_NULL | KF_ACQUIRE | KF_FORBID_SLEEP)
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

