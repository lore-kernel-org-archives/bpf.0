Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2D3361658;
	Tue, 24 Mar 2026 08:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774340491; cv=none; b=fVWfc0FtHoGsy8EyT7pnVIYrdTL1pL1gCL+hmi1fcGae4ubJW0OIBElUmO9UTI3FTl6aHeXJilEzD3Rlh94MNyKmwzfekLqCIJ2g0aUuCl6FO9YCctKtkO3hRCXZrGqqJyw+BHUAAabFrQ0YENkdPJO5TSnT5vV+ZR+QFsq44vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774340491; c=relaxed/simple;
	bh=G2oEZMNahjZVDxpLMAFhcuvHjsJn76nkuktreEeokDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2/8adFjJIPiaWerCKZOT6L0mgDC6ETWdqh5Zp64W3leptJYRhNL2RRMBF3I7NS0nJnM3bF+PD3erw1M/tn/revU0gpi0A8VOyPmNkaHS64Vgc4tVMuxA7Ulb5jJ5R8LzxD/zsuQNZf2Q0hmk2n1Cb2Fm0zBEcvxiLk66SUyr1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jf5kdk9i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jf5kdk9i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15106C19424;
	Tue, 24 Mar 2026 08:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774340490;
	bh=G2oEZMNahjZVDxpLMAFhcuvHjsJn76nkuktreEeokDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jf5kdk9iFgpz2QV3kTjtYxCd3S2ljQHpdLLngzrFJRu8iY/rM7Hgx99I9wGmVwSS7
	 6lIEQbTOLTS+DZlRD9O0wAbyAaQRjBXrADZQWxeGoCpPRyTQZJ7ZXiwWrlvqu0EIUX
	 ZdldQsG5zuOdIKESUYBTQUY89rD6mAmL3MJETW0w8ulRUj0P0Y3fW6+i0y+wjsXsXM
	 bOArqDasjVqISvVsk4fc81pIUX/A4ZI0nPEgXz7C9ZrbvuGms8zM4v0ld3tyzqqPrs
	 lkAyYRzXbP7uRDv9EaamQHIgCQtLAi8BP9q89il4U52rr4cvLOxqpNv1Bko4aIXQ7M
	 odohNv88dHitw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCHv4 bpf-next 15/25] libbpf: Add bpf_link_create support for tracing_multi link
Date: Tue, 24 Mar 2026 09:18:36 +0100
Message-ID: <20260324081846.2334094-16-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324081846.2334094-1-jolsa@kernel.org>
References: <20260324081846.2334094-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding bpf_link_create support for tracing_multi link with
new tracing_multi record in struct bpf_link_create_opts.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/bpf.c | 9 +++++++++
 tools/lib/bpf/bpf.h | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 5846de364209..ad4c94b6758d 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -790,6 +790,15 @@ int bpf_link_create(int prog_fd, int target_fd,
 		if (!OPTS_ZEROED(opts, uprobe_multi))
 			return libbpf_err(-EINVAL);
 		break;
+	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_FEXIT_MULTI:
+	case BPF_TRACE_FSESSION_MULTI:
+		attr.link_create.tracing_multi.ids = ptr_to_u64(OPTS_GET(opts, tracing_multi.ids, 0));
+		attr.link_create.tracing_multi.cookies = ptr_to_u64(OPTS_GET(opts, tracing_multi.cookies, 0));
+		attr.link_create.tracing_multi.cnt = OPTS_GET(opts, tracing_multi.cnt, 0);
+		if (!OPTS_ZEROED(opts, tracing_multi))
+			return libbpf_err(-EINVAL);
+		break;
 	case BPF_TRACE_RAW_TP:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 2c8e88ddb674..bc3b7bc5275e 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -454,6 +454,11 @@ struct bpf_link_create_opts {
 			__u32 relative_id;
 			__u64 expected_revision;
 		} cgroup;
+		struct {
+			const __u32 *ids;
+			const __u64 *cookies;
+			__u32 cnt;
+		} tracing_multi;
 	};
 	size_t :0;
 };
-- 
2.53.0

