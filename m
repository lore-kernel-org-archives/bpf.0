Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81BD3E7145
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314400; cv=none; b=j2sEGicVX5VsffNPBS3J50dGB8nDV0vb1q2rXtD6TFQKG87gPLs69ECnQKJ6GcdRSilUhyjZ+Lxs0jQNqgIQ5SnwYmVSTrmi/w/mrh3RTu2mlhogeCxZSNaJnawk5sFxMMV7eJ03ToH+DSDr4Iyu+B4jSwE8jv8f1P5Ssh4ngT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314400; c=relaxed/simple;
	bh=jfdnLhHXzhlB9qj1bOqTQMQ8/s7h1lYySG/zBBeHsL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVgFtsWbLoEogLbOTT/5SAsf+RJkHUg4Dioy7wxaQhHLFPz+qJdLjWHRpyo2EgrQ2QRXpOMF29sXQnzlmVDfoMgexnnlXL46ePTlUVPthjm+atef7QH67gNn4ygc/zYBLL04qeotxZmIjR9H+Nwr9tULdFoC+UCMo2QJtH7Ktkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWqJEyP4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWqJEyP4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712AD1F000E9;
	Wed, 29 Jul 2026 08:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785314399;
	bh=DdGJCcm07FVMS2KkS3ofW1EE57VwIlirzVI3YRsr7bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kWqJEyP4adRUnBT/c9omdZFewuNb/RmF/MwsSRymhvyPy1D/DID60BLFFzfm0bdxH
	 lH9sVk75JtGmIxsuNWSYctjCqW/Be8kU8baKdje4IhCShQRJu8n4+6/Ekrgqhj19Z3
	 f1CxNf/nAzV596dt6Lh6eIukWXWHctLL3uaLQ5Imi/JC9je3SFYutrYeSL31OMjaDn
	 rBVtfeg6Emw9876oOweTF9L++vND2yIIhe/kM47JiOz4GFpgL/HWSEgQSP+cLTkd2P
	 Z2TJk6iQFLlLhGDfD3IMkVG0CqStrbYR15A/OMPWQHoKWFivP3byhWp7fTnMPd4jc1
	 2QDLHZpar8cHQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Sashiko <sashiko-bot@kernel.org>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Quentin Monnet <qmo@kernel.org>,
	Tao Chen <chen.dylane@linux.dev>,
	STAR Labs SG <info@starlabs.sg>,
	Arnaud Lecomte <contact@arnaud-lcm.com>
Subject: [PATCHv2 bpf-next 11/11] bpf: Clear buf on error in __bpf_get_task_stack
Date: Wed, 29 Jul 2026 10:38:07 +0200
Message-ID: <20260729083807.1588544-12-jolsa@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729083807.1588544-1-jolsa@kernel.org>
References: <20260729083807.1588544-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both bpf_get_task_stack and bpf_get_task_stack helpers that use
__bpf_get_task_stack have buf defined as ARG_PTR_TO_UNINIT_MEM
argument, and we should initialize the buf on every return path.

Adding missing buf memset for __bpf_get_task_stack fail paths.
The __bpf_get_stack call does clear the buf properly.

Fixes: 06ab134ce8ec ("bpf: Refcount task stack in bpf_get_task_stack")
Fixes: b992f01e6615 ("bpf: Guard against accessing NULL pt_regs in bpf_get_task_stack()")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/stackmap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index f4827afbfed9..9ab0c2523a41 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -890,14 +890,17 @@ static long __bpf_get_task_stack(struct task_struct *task, void *buf, u32 size,
 	struct pt_regs *regs;
 	long res = -EINVAL;
 
-	if (!try_get_task_stack(task))
+	if (!try_get_task_stack(task)) {
+		memset(buf, 0, size);
 		return -EFAULT;
+	}
 
 	regs = task_pt_regs(task);
 	if (regs)
 		res = __bpf_get_stack(regs, task, buf, size, flags, may_fault);
+	else
+		memset(buf, 0, size);
 	put_task_stack(task);
-
 	return res;
 }
 
-- 
2.54.0

