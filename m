Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742643F9A13
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922218; cv=none; b=D8aRVhc6vQ5aJzxm+e33e9VjcSLIELWDgMdtSeYlOPFpuXFNrFitqKwtTMvoiNVtel1EcVsWUPstpSr76ZygeNukyFyomhBO1uJ1dt4j/j9fra/uGvPAOj5eITwwuUnI45+msz/7BXdpkDSQaXPnf6p1zZfSB8mHfdxFH63e9GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922218; c=relaxed/simple;
	bh=ppb8jjpGhWwneikCpBymLQ15sTuC9ufsLQTe4BdfVAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbaeOav0fjVJyoKe+CQTa5lAnXdcNTBtx+72/yRfn6YR+VBq1t2LUlzpFnmRH+jfWLdoR4PUhM2reSPVLZCbkaS1HQ2QQMfxlujMyVQdG9sSIK6N23eyHA52SuV/0A0wxxXdd2yTlM+qIcP50p0k9mOdauZlGDNmLfBs6gMUApQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=on7zVGaG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="on7zVGaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315241F000E9;
	Wed,  5 Aug 2026 09:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785922217;
	bh=KX5U7WvBdqmRrZENYfC1JP86DOg6FNWfh+tcB6gE36Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=on7zVGaG6wT/uQ1DaVzRKDNShchsXXJ5ARMxHqnX5VwvJ0s4aYs2pwrmZIWLNYOq3
	 hPljl4aznt3g2pJbQfaqo8HqDF5/Lx/X2dxDqzX8KLir7W5FbXW133JqtODZEamPmH
	 Qwc6j90XzzCFPuHdcgiCQH3G+Ylg5wobbxKcAtBn5fwqoVuCMGeV0/9oh2nv40hB2Y
	 2EFzeDBDxXUuY4TWBDjMTKPqMVMC957FjCKRaOI6ycAH1QES/Pogl/VpTV7d3ReY3s
	 xHop3acV4WstvlqJbkM11JaqaE+qEfjCbP1DAAoJX/zlStDCv3/w75QioPziDXb+ce
	 hNgPVuxVFvUNA==
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
Subject: [PATCHv4 bpf-next 09/12] bpf: Clear buf on error in __bpf_get_task_stack
Date: Wed,  5 Aug 2026 11:28:40 +0200
Message-ID: <20260805092843.516315-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805092843.516315-1-jolsa@kernel.org>
References: <20260805092843.516315-1-jolsa@kernel.org>
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
index b0e38e5b3738..eabeaef31b63 100644
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

