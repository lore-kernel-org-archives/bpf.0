Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5FB39BFEB
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774904640; cv=none; b=Pm+oeaP1Eqs7Cdley5iGNlW5eYnV7nxX3vvAqW58BwxKGXGKYJOcMvO6i1sL+PUL75/Cquchmaz4CbWl6EQRH1TuIDit0ym8633is2+qfrvfFpg4SZAQs2LUk2/J6+OuW9DAH9JaGvG+2Ak6nWh7kETcg0WGF9cb2xZbAibUUp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774904640; c=relaxed/simple;
	bh=nCXaZ0V6Z/dciYbnnvBgVMRj+psdO3EzMM1ysZC36IM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EXYpEf7dia2G6oYMUM91vgFa7CX0nhDFzv0o/r/aiaL1sx71qBz/pCW58KL70FVJ6LFrUXF90jmUn9TcJvOS+TvWD9fx5GjULPKR9aQ3BWn8Cq1kxRKUCFUhYF6TbdvPruq5gK8MWpCiI5QOj8FyKGzQkzpEf3d9bnnOXVz/ZXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koz35Kcb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koz35Kcb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7603C4CEF7;
	Mon, 30 Mar 2026 21:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774904639;
	bh=nCXaZ0V6Z/dciYbnnvBgVMRj+psdO3EzMM1ysZC36IM=;
	h=From:To:Cc:Subject:Date:From;
	b=koz35KcbkSssYb2Q8gU2izaabpQjScvbcwNxLn1zeXy6/rGCqK2FXtBCA/DyUerp5
	 GyNlh1pdLXlMJd85EkN79h66y5Diqog0eiWZlxh5HlQd+jVCwbCkWXAwrG9Q8j9AJ/
	 VTNakFuZNdFieOPTrLDEIx9tkfKY+mZRC4HpwbfY/D9o4Hn0cSLmECg1mpR5Cg309d
	 3dmeFTshj8SUh/SQb/yDMiP5K7SWfD4hNVVEYiQjRUig6BGTwBSbddHBTc/dw035K4
	 5hCcIimKgZTS+xkUVT2bXHQw6WRT9v5IuRqbfRopdfKKpjcuGAyFVqQTHHcef62MNN
	 8+y6nx0SZkWuQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next] bpf: Fix block device hooks names
Date: Mon, 30 Mar 2026 23:03:44 +0200
Message-ID: <20260330210344.3073712-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use proper names for block device hooks names.

Cc: Christian Brauner <brauner@kernel.org>
Fixes: 46df585fcff7 ("bpf: classify block device hooks appropriately")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/bpf/acrVKUy_EPiFFmV9@krava/T/#m7c7906a1ff4029e29185aec3266dbf5c8996dbf7
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/bpf_lsm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 119e3942cf5a..0e74325d96a6 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -383,7 +383,7 @@ BTF_ID(func, bpf_lsm_task_prctl)
 BTF_ID(func, bpf_lsm_task_setscheduler)
 BTF_ID(func, bpf_lsm_task_to_inode)
 BTF_ID(func, bpf_lsm_userns_create)
-BTF_ID(func, bpf_lsm_bdev_alloc)
+BTF_ID(func, bpf_lsm_bdev_alloc_security)
 BTF_ID(func, bpf_lsm_bdev_setintegrity)
 BTF_SET_END(sleepable_lsm_hooks)
 
@@ -397,8 +397,8 @@ BTF_ID(func, bpf_lsm_sk_alloc_security)
 BTF_ID(func, bpf_lsm_sk_free_security)
 #endif /* CONFIG_SECURITY_NETWORK */
 BTF_ID(func, bpf_lsm_task_free)
-BTF_ID(func, bpf_lsm_bdev_alloc)
-BTF_ID(func, bpf_lsm_bdev_free)
+BTF_ID(func, bpf_lsm_bdev_alloc_security)
+BTF_ID(func, bpf_lsm_bdev_free_security)
 BTF_SET_END(untrusted_lsm_hooks)
 
 bool bpf_lsm_is_sleepable_hook(u32 btf_id)
-- 
2.53.0

