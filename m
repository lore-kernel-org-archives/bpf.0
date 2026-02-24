Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1222A3043C9
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771968385; cv=none; b=JaCJLyZfYCVgxH8MOWBydmG48xp+NDa849sF16W1mFs3Zu/ZiyYgCSHcVlfCAbGlqNzH58Eio3bljI2buTOxubriwmEgEbFi1VZgIvtzUNXFzZJSpC7b7OUr0CPW8iR0nsoYH7YVIOxMlgM8xzvHmz9x/jp/RGsZPSJsHb6hk8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771968385; c=relaxed/simple;
	bh=H6x4ePniumNk8aAudHyNP9whplE5szLjO6Hg21/RT/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxSCCO2KiralTjhTICdf36rHGW3ZGt3QxNHmw1fWbkMZWPGS32m/uACHqq05gbxhNN5fwGlfOpo0muFUIEOuYaaU+eWXSOHEUpBKpqWxtrHwJo6Vr859Yv9ZRhA/x5/TlPcDFS8b55Ck66qtgDACyDWgmfZMPOsAZzH2ANGkcKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJeoDVas; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJeoDVas"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB87C116D0;
	Tue, 24 Feb 2026 21:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771968384;
	bh=H6x4ePniumNk8aAudHyNP9whplE5szLjO6Hg21/RT/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lJeoDVasrUMPnUKVX7Ewy6hbVOiziQXT7wgC//SgOvSF6B6MczLA0y7nH1ARUgnCY
	 opAI1c4OrtVjyDgcOfWhS2xznrwX9WCkYgMmRY8HPUvjkNZptuWv4vZHNmV1lJaNFE
	 DzvD9JcHnCKAzY40VWc9PEGc20P8QvANU8ur7rpYM+PXxdkzdjTnMX6qnXg2CwZUaZ
	 oDQ3jSgPXEDGjKAB7Z+rl70rq6YmPLrFz9m7WHXGOPH92XoxyG7KRp75oTBO3/SVVv
	 SqprkZXYu0kNtudoJBVrqru90gxGWrNbmf3s/dCJoKeDHeiLn1cPEjcBfU+H10z7VS
	 VgGClSmUyTXSg==
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
Subject: [PATCH bpf-next v4 6/7] bpf: Add split iteration support to task_vma iterator
Date: Tue, 24 Feb 2026 13:25:28 -0800
Message-ID: <20260224212535.1165151-7-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224212535.1165151-1-puranjay@kernel.org>
References: <20260224212535.1165151-1-puranjay@kernel.org>
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
index 6eb6c82ed2ee..2663280c92c6 100644
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

