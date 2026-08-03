Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAEB3A9630
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785791007; cv=none; b=IdYXryxZyeLbWCyWoR9LBIhtJa/kXQDf+HHtep7UuZ0tCJUlIGRlyz4ERYh7flMfd8ZisZQsUd8KfNvmrRhtkB1R2lBCmZqgVmOuMGtOn22JXyEJCIKH+1QoJojOAJauzVLMxLHW6MHv8M2okkWnnTR6zPltSuyt0drMyBdN0Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785791007; c=relaxed/simple;
	bh=3/HXEW5FfBFOU0CwB6FI3HNf11roMOF05omVYMpQJRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezJwMYb4lnUV9I2IpdAt0tMbIaZN+KU9/j0o5EnLihQPa/ZKHQKN6SajbKUFC2lgWZdlaymMMfc8/BU+WVo+0y67IfpjqHD6d9BT5TKek0F3XT3sG5aby6yeNcSW/JL+3AsrCKIKoG74zWVqDom1JEK225qFhRlqWM4KtTaYS5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ki+RjhBD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ki+RjhBD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197731F000E9;
	Mon,  3 Aug 2026 21:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785791006;
	bh=vwFteO0bAzPzPTUgHsGK+W5DSjT2vxaLnUi3yNa3j7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ki+RjhBDQ4t64iyKcffiL40WvljYivrsU+8ILNaoDY9IqSMu2DwkaZBbTOuZZo7vm
	 pbDpI5xX1Rq7fkLKecXBunZaDUZui0442uDZRKuJEsPVCX/XmxjX0vo1DNgsfpvqi3
	 3JWB8O+UwudG+5pk4Uwp8uIz/GXPCxyMDA6gxWVE/MZKUCeLtzIga80HVg70GOj1Ww
	 6t2Iy6OUhgHUYQCxHTB602PGOgfrNQsbM0SluG5uRKq4hEVWWknA9O5tUeEkvsoFos
	 d6wKn7ag/tkrNXEqTr/ZvP2DOlV7t+I9S2udePIm3tqM3nzMGO2hItTzSG6gzy09rZ
	 rI92kJ6anNagQ==
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
Subject: [PATCHv3 bpf-next 09/12] bpf: Clear buf on error in __bpf_get_task_stack
Date: Mon,  3 Aug 2026 23:01:46 +0200
Message-ID: <20260803210149.296496-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803210149.296496-1-jolsa@kernel.org>
References: <20260803210149.296496-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both bpf_get_task_stack and bpf_get_task_stack_sleepable helpers that
use __bpf_get_task_stack have buf defined as ARG_PTR_TO_UNINIT_MEM
argument and we should initialize the buf on every return path.

Adding missing buf memset for __bpf_get_task_stack fail paths. This
provides deterministic buffer contents, which is useful when the buffer
is used directly as a map key.

Fixes: 06ab134ce8ec ("bpf: Refcount task stack in bpf_get_task_stack")
Fixes: b992f01e6615 ("bpf: Guard against accessing NULL pt_regs in bpf_get_task_stack()")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/stackmap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 976c4e4c1af6..7f728d319a65 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -884,14 +884,17 @@ static long __bpf_get_task_stack(struct task_struct *task, void *buf, u32 size,
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

