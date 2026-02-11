Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE53D23BD1B;
	Wed, 11 Feb 2026 08:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770799766; cv=none; b=Vsf9kiQj6tp1OZBd0wcYhU2pHFI8NvWNKBSfwJCLXXdj8IK12F5AtbJI1k8LVxq/nNinKXE9NN4suD6Lbg8GtJTpu8cac7usaDVCTdHKWdWeBF6Cp29wH5ALen+AD+YJKnq22eiE19ylKA0BPy4rtLSwhEr/Dd9BV0R03DxXvNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770799766; c=relaxed/simple;
	bh=S29y+uuqZrMgOo1hWvanWYe+TzfNJHT+V3QfZUY1MX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRFZm4190oIAd8aDMFLUXsg0oKltq1gESWYdm59cpi0QJm0fZgd2cEGq+EmZY0agCrRiP7sw4lkJHOmzhN4otfbzNVJ9n2Z+C/JYO9mvbabMHNrKVf9IHK0VaubqMl1pSDrcUbXN3ezfQNJUf6mPG+F7xtlFeKkJUOuSGJzKf4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c31jckCQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c31jckCQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AA1C4CEF7;
	Wed, 11 Feb 2026 08:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770799766;
	bh=S29y+uuqZrMgOo1hWvanWYe+TzfNJHT+V3QfZUY1MX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c31jckCQ9RypyXjw7tNKjmdji0Iey4BEfNNq3qHJjEE7ZIzUoYrjeDvKH1cOpWR3a
	 nZkqfxStXBogU5AlvjDu+wsqrSDfrziTkf84T4bZ3iq2Kv78jAv+yvKDDNXyob5ifX
	 GME5p9WkNZe5JQC/8k5PvUi94dBvp8F6k18I+mCQfzS/nGueoQ4LI/9XcMV9qNyEoA
	 qrIRxf7HHWsc9XYxA+AdRWi9aHQSI1HounUStWZwLUafRjbmXyeXu+9Z0++tHlr2n7
	 8aR4/XHMO5QZXLJT6Sb0FQ9itCUlnQyzE8419RzQis35brm92sECWxyS5QhAbYvzqR
	 ykgkG7cxYNloA==
From: Jiri Olsa <jolsa@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCHv3 bpf-next 2/5] libbpf: Add uprobe syscall feature detection
Date: Wed, 11 Feb 2026 09:48:55 +0100
Message-ID: <20260211084858.750950-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260211084858.750950-1-jolsa@kernel.org>
References: <20260211084858.750950-1-jolsa@kernel.org>
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

