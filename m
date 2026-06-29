Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7618442DFEF
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746691; cv=none; b=tDhyGPpKjf1omaRIOq7AvPn9/yhDJJcaNEX5mxD1liM8uL2e/4ODeyQ5Xu1UX8T38qZl4/dtMyHhvq3tXuHFDTAgwX60Slu3/k8aFMcqwpAP6MaOnTdAF/nvEy4WDHzYxpCIy3HHFqAAKyFtXViOA1eakSDUnzHVleZdGF+QAaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746691; c=relaxed/simple;
	bh=kcnuiexE2KOs+3CghApC6apZfnO6hdhT/droVv9EkS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fl8azbdHNgkrSxLrRimlAg+KFAuddZZseysepYxu4bNC39ZQTHSYI9pLnhgU8iOpwa3a96EyUAZHN1x1PHG8cBWsgecVgNcqdouBuHMp2w7GyJ7vYCXrJNv/kicSnLwnZEUUd/oWnkGtulwcPJL91z+N8xR4yhH0oj0EArw6DjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=luiqGE+z; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="luiqGE+z"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782746688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QOQPPnNgIo6Mwkthso/fS2q3f/CeBgo3vCNZAoKI7T8=;
	b=luiqGE+zCwgO4FGCFGbFQNuZdXNyHXmrp1korra5mG5wsJLUCC2psnXdERdxFqZJwc3+re
	FSaGfEex4G5QRDs0NnToKqFfzvCcp1ClBb19q/5z1Mv9HPpHn200XJR5GpMBzHBIfdRiZb
	Agdfvkg0kZ7AJe4jP31Ma4/B1+J4Uf4=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v8 3/9] libbpf: Probe percpu data feature
Date: Mon, 29 Jun 2026 23:24:00 +0800
Message-ID: <20260629152406.52582-4-leon.hwang@linux.dev>
In-Reply-To: <20260629152406.52582-1-leon.hwang@linux.dev>
References: <20260629152406.52582-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

libbpf needs a reliable way to distinguish kernels that can support
global percpu data from those that cannot.

Add a dedicated feature probe, so libbpf can make capability decisions
early and fail predictably when global percpu data is unavailable.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/features.c        | 35 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf_internal.h |  2 ++
 2 files changed, 37 insertions(+)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index b7e388f99d0b..ef9581c11303 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -620,6 +620,38 @@ static int probe_bpf_syscall_common_attrs(int token_fd)
 	return probe_sys_bpf_ext();
 }
 
+static int probe_kern_percpu_data(int token_fd)
+{
+	struct bpf_insn insns[] = {
+		BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0),
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
+		BPF_EXIT_INSN(),
+	};
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts,
+		.token_fd = token_fd,
+		.map_flags = token_fd ? BPF_F_TOKEN_FD : 0,
+	);
+	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts,
+		.token_fd = token_fd,
+		.prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
+	);
+	int ret, map, insn_cnt = ARRAY_SIZE(insns);
+
+	map = bpf_map_create(BPF_MAP_TYPE_PERCPU_ARRAY, "libbpf_percpu", sizeof(int), 8, 1,
+			     &map_opts);
+	if (map < 0) {
+		pr_warn("Error in %s(): %s. Couldn't create simple percpu_array map.\n",
+			__func__, errstr(map));
+		return map;
+	}
+
+	insns[0].imm = map;
+
+	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, &prog_opts);
+	close(map);
+	return probe_fd(ret);
+}
+
 typedef int (*feature_probe_fn)(int /* token_fd */);
 
 static struct kern_feature_cache feature_cache;
@@ -707,6 +739,9 @@ static struct kern_feature_desc {
 	[FEAT_BPF_SYSCALL_COMMON_ATTRS] = {
 		"BPF syscall common attributes support", probe_bpf_syscall_common_attrs,
 	},
+	[FEAT_PERCPU_DATA] = {
+		"kernel supports percpu data", probe_kern_percpu_data,
+	},
 };
 
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 04cd303fb5a8..47ae39125f68 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -401,6 +401,8 @@ enum kern_feature_id {
 	FEAT_BTF_LAYOUT,
 	/* Kernel supports BPF syscall common attributes */
 	FEAT_BPF_SYSCALL_COMMON_ATTRS,
+	/* Kernel supports percpu data */
+	FEAT_PERCPU_DATA,
 	__FEAT_CNT,
 };
 
-- 
2.54.0

