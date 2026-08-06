Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C860366553
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033925; cv=none; b=Ce/bnNGqXQQr0dXu0OCs02UIK12iZfRnzNuNd/IZ+7D2K64F9Ymz1cfeuPW4pe38dnKi2Fwp7zNvh8hCkV8YnhKZEDF+bhJuzSQiG1LG/vGdL8y1alEqYN1zJTr9VFiTKDmASabJlar6PvRiis9WtheRr+F4u6iKZKaDl5nnSEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033925; c=relaxed/simple;
	bh=5ZCt5mLnoYxldIysQPGgQKI9kJMnrVUrpohc+4vpe68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LT2GQukffu85b1EhQHr4fzryW3YP95CMfpblSN1peDRwxIufHLFikkF6YJbZ74yVcwsKHLCwA6fHQznxqSQ9uoWYSIocCA7TYGVrl0VMQILdqzgWiO5V0n4X8P8VZthOrmGCoEltZYUBNEQ6iYElOBrPqAYpQ8oz5NLnYhXrF1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MI6sVTcX; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MI6sVTcX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786033919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZTjDRC50bGeXvKPAR7fOrYtu3WlLeFKXtzwpHFxJbk8=;
	b=MI6sVTcXR7GC2C4XZQl55I84ymk1BmCkKLcptg0+DIqP7aX/bfuAmOXaaWWInQcfVynh+H
	EuKcEg5v60RaOiEcGRorDUpK2dvcU8Sjh8GNU6lh49RFWncHFUuWjTfAU/dEbxwuv1RqwG
	4zTTVtfSYPXQbNL577VCK6gbr/5LMeg=
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
	kernel-patches-bot@fb.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v11 04/10] libbpf: Probe percpu data feature
Date: Fri,  7 Aug 2026 00:31:19 +0800
Message-ID: <20260806163125.11172-5-leon.hwang@linux.dev>
In-Reply-To: <20260806163125.11172-1-leon.hwang@linux.dev>
References: <20260806163125.11172-1-leon.hwang@linux.dev>
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
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
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
index 7a74abb904f8..4c46d34fc055 100644
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
2.55.0

