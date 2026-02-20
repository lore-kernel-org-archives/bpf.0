Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4870D33EAE7;
	Fri, 20 Feb 2026 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771584166; cv=none; b=lG8QDEjOK9eUBaNSsfXJIZVgAAFhbhY6TPXLNQzd6yTtKGV1tvw4xgE70veLSWao/pE5SAuxHlN6s7joP8Cq5tEF/pqci0njRzNJf8Pw7uyhpUjTN/D0PIWJtEYxPcdkNWkMsaUBZCUcx6epG8HjYMuCsXkaM4CzWpljJ4b+PCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771584166; c=relaxed/simple;
	bh=Gb3Elkny7jCdBeuIV/xdQ1NCvtvANwyTKBH0kHt03sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zo6nmvJzxwANe0UhXyx83GHKCl9xB57mGpwIMR9WQGIGo6ZxTSfcKoby6BP7obKaXOwrFSp7TxMzLqGnLEwb32PdfUFvFemBRrN7dFm147anwQYFU72bV4msbxdrkSLx68QIwZlOJCiBRr2C6TsZNdpOh6a1enr+/eOdQYKGLn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dk1qeQ5/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dk1qeQ5/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D69C19425;
	Fri, 20 Feb 2026 10:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771584166;
	bh=Gb3Elkny7jCdBeuIV/xdQ1NCvtvANwyTKBH0kHt03sI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dk1qeQ5/4eQ3O+DdcMnGmE5YoRwd+9xkorx0l84GFIEdHW4MJDd1ozqAHk04lVxmT
	 Z0SrswxWXbKxGS8lqVYkGLLad1HWANg6BPmrNbv6GcSkNvN9T1z/UUPQa6p3xRUSpg
	 L2TD+lSNpPmH4ZfbqLYeBgkRJ3Cs7YoTd3hcjjsgT78BcR9pnb0jRRtkMTvFxR6vWK
	 tq19+L/Jfk/bZ/fw4IHxZLezo2XgnIx3plLOw4LyP2ZaKXOFWI6jTEwV4xJBLWu58o
	 8OUxbr6EwgR9eKUuMjVILzP6fB2oMIP3248SkWS4OipOFfvwMEhz60Kgmu3rKWE12M
	 0tYUnd3vML5qg==
From: Jiri Olsa <jolsa@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCHv4 bpf-next 1/5] libbpf: Add uprobe syscall feature detection
Date: Fri, 20 Feb 2026 11:42:16 +0100
Message-ID: <20260220104220.634154-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220104220.634154-1-jolsa@kernel.org>
References: <20260220104220.634154-1-jolsa@kernel.org>
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
index 2fa434f09cce..adcad221c601 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -568,6 +568,27 @@ static int probe_ldimm64_full_range_off(int token_fd)
 	return 1;
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
@@ -646,6 +667,9 @@ static struct kern_feature_desc {
 	[FEAT_LDIMM64_FULL_RANGE_OFF] = {
 		"full range LDIMM64 support", probe_ldimm64_full_range_off,
 	},
+	[FEAT_UPROBE_SYSCALL] = {
+		"kernel supports uprobe syscall", probe_uprobe_syscall,
+	},
 };
 
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 974147e8a8aa..4bcb6ca69bb1 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -394,6 +394,8 @@ enum kern_feature_id {
 	FEAT_BTF_QMARK_DATASEC,
 	/* Kernel supports LDIMM64 imm offsets past 512 MiB. */
 	FEAT_LDIMM64_FULL_RANGE_OFF,
+	/* Kernel supports uprobe syscall */
+	FEAT_UPROBE_SYSCALL,
 	__FEAT_CNT,
 };
 
-- 
2.53.0

