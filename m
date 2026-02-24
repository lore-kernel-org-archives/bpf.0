Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80333644B6;
	Tue, 24 Feb 2026 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771929577; cv=none; b=gMJS3O0oqZKqJgNPJ8ruYEdKps/NPmSujNz1CJKyoR7jFL3E4esZzUUGzsXpTryA7qLhihECWxKtq17gYJUEATrh/O+T1Dgp3nt6n2wbx5jn57OHy8mzkSeySqeGb8klYyXhapX02UQtpXszq9QzDTqqhjhYLbY33ICnylpTx6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771929577; c=relaxed/simple;
	bh=Gb3Elkny7jCdBeuIV/xdQ1NCvtvANwyTKBH0kHt03sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsFVstfZwj7YeDmOo06bdx+gOCEPGcVTytQ+KOnYsIrqK86LmuMv1ejpZhVZIruQmxvS0c3HccGr2rB1FVxU1AGw0Bf0ukaKDsaJKnI7t2pYwkGscqjlJfYdqNOjYT7lMxfzY1Dg3FBClepB0zdpnqUqni3AWz9VsXd2bVhGps0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcY8HmDw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcY8HmDw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B3EC116D0;
	Tue, 24 Feb 2026 10:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771929577;
	bh=Gb3Elkny7jCdBeuIV/xdQ1NCvtvANwyTKBH0kHt03sI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kcY8HmDwsFmQJudXCVwmHvs+y6rrDIS0NGHFOd6wRrMq3iV0YoS67OJngECPmtsbE
	 2pCjoYezTO0JY71uuN8uoUvnAF6iW22Gdz/maWRV6RwuPjy/N/09XhigYjI2h6WyzT
	 Knjis65hAsmrjIrZRmImESP7Y+OYnZOlUjl3V5mLdjZ7OTkDWXD0YSThNu077qQ7m1
	 c8BwevSGGjz7z7KhgglATI8Hmuwmd2Uj6ricCLBmD9481QLPp24au9iek4TsHwDmVT
	 vCoSg8JOFHB0VmkRTUB06VWzUDSWeqyhFAoA8Qubp97ot8Jh1L+eTeKBmtwsArRzX1
	 AlD4XeDvx15BQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCHv5 bpf-next 1/5] libbpf: Add uprobe syscall feature detection
Date: Tue, 24 Feb 2026 11:39:11 +0100
Message-ID: <20260224103915.1369690-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224103915.1369690-1-jolsa@kernel.org>
References: <20260224103915.1369690-1-jolsa@kernel.org>
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

