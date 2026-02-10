Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C183164B7;
	Tue, 10 Feb 2026 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770730628; cv=none; b=MwDnbkWMHG63w5GZqHxPEXopz6CpRHbGpVVFyWSGs1LIkH+OOC883PDuj90o+8tFdi/B+zOWQB9H4AR3F94giGFb4xNDMCQpPO5Nv/kEjByHqfaFkvAabgKFw5rypWZNLzl+JOYSuOVFyMctHj7pebD6k6v2J+mLvwmSjAKVmhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770730628; c=relaxed/simple;
	bh=S29y+uuqZrMgOo1hWvanWYe+TzfNJHT+V3QfZUY1MX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLVVuFBySd6V2+tZ5krcOJJX4Itt4bDCLuG5Xigm3UvrnEOyioskWfZnYAFADmOn0qgPlpetvJHHNbVTN1iWCricamrc6kRlKdz34wxR7tDo6ZDTq8Q5ibDvs+gBBXQ9yQfC3oWfKU2clDjlqt3yV+wmqT/eoqV5g1ah4pV2cPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j04/8tW3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j04/8tW3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21916C116C6;
	Tue, 10 Feb 2026 13:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770730627;
	bh=S29y+uuqZrMgOo1hWvanWYe+TzfNJHT+V3QfZUY1MX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j04/8tW3y/fVB+KQI5g/8sX9U5Xk4P510ScKTYR3aQfj8NM2O5EuP7AwIEdNdOgK1
	 AuKv7e9mAfp/wuFTo8uBk/mia4TJCtM8oMNWvcIOkY/f0hc12kSPf9/URuLsXFbe8U
	 5zj2msq9FzfArus6MFEqjVjU2icWelkU0ZuZdubQf22bubveho7dMnvBK1XKK9xf6V
	 Biy9Mvi4Fj+s4bPrwmPRMPWLWrowyqJ2nN4z2hb1QAUIsF9DQC/DIcYxNGMm1zs7RA
	 VrTjIubUH4aVEsGiv/Si4MN80TG+fvZHmpkGwFBLUnOz3rgRVOODkTIetGumdB33Hr
	 o2JFFdVNKAOkg==
From: Jiri Olsa <jolsa@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCHv2 bpf-next 1/5] libbpf: Add uprobe syscall feature detection
Date: Tue, 10 Feb 2026 14:36:45 +0100
Message-ID: <20260210133649.524292-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260210133649.524292-1-jolsa@kernel.org>
References: <20260210133649.524292-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding uprobe syscall feature detection that will be used
in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/features.c        | 24 ++++++++++++++++++++++++
 tools/lib/bpf/libbpf_internal.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index b842b83e2480..04a225c7f2c0 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -506,6 +506,27 @@ static int probe_kern_arg_ctx_tag(int token_fd)
 	return probe_fd(prog_fd);
 }
 
+#ifdef __x86_64__
+
+#ifndef __NR_uprobe
+#define __NR_uprobe 336
+#endif
+
+static int probe_uprobe_syscall(int token_fd)
+{
+	/*
+	 * If kernel supports uprobe() syscall, it will return -ENXIO when called
+	 * from the outside of a kernel-generated uprobe trampoline.
+	 */
+	return syscall(__NR_uprobe) < 0 && errno == ENXIO;
+}
+#else
+static int probe_uprobe_syscall(int token_fd)
+{
+	return 0;
+}
+#endif
+
 typedef int (*feature_probe_fn)(int /* token_fd */);
 
 static struct kern_feature_cache feature_cache;
@@ -581,6 +602,9 @@ static struct kern_feature_desc {
 	[FEAT_BTF_QMARK_DATASEC] = {
 		"BTF DATASEC names starting from '?'", probe_kern_btf_qmark_datasec,
 	},
+	[FEAT_UPROBE_SYSCALL] = {
+		"Kernel supports uprobe syscall", probe_uprobe_syscall,
+	},
 };
 
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index fc59b21b51b5..69aa61c038a9 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -392,6 +392,8 @@ enum kern_feature_id {
 	FEAT_ARG_CTX_TAG,
 	/* Kernel supports '?' at the front of datasec names */
 	FEAT_BTF_QMARK_DATASEC,
+	/* Kernel supports uprobe syscall */
+	FEAT_UPROBE_SYSCALL,
 	__FEAT_CNT,
 };
 
-- 
2.53.0

