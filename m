Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FDC33D512
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102222; cv=none; b=gb1Rakuyv8Ft/DMejqynIEcq4GtPubmrRMJ7afmZGNhMlzK9DWj6+REvYLpGe3dzz2wqWeVmCbg3wZGrsbhnfhleDEEiMWgLJtXkwGEGbrCZ8PhZcrapmLasEXekgyUIhZTemvh8U+xBn5FLrU6lM5uoHR5m20cSGNu6T0JJmR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102222; c=relaxed/simple;
	bh=Vv1cZAv+0c1IBEatJNuSKcFZRHTQi6NTL8A+Gzrw4oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5bMbQBeIVALuC3VizL+t2zVH1GCps/171qkbW0AtMk1/xBEcIicNAPL5qEgCXcpogHGB3c3XBX1Q/0plEyP5PQwBPbECNBBvqtXsjjHf/dmBtpWfs27YUM476ws+vwlJirwjy3AiucDpg9Sa5TIbN0CBfKXtx3LlXpx00akJEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOCMGpcs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOCMGpcs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5951F00893;
	Wed, 10 Jun 2026 14:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781102221;
	bh=v+v3iXW2lWkTytq7OLGagYfrOsYjsQexmVsAgWSCYOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KOCMGpcsBiM5UuLGNRCHtTQv1vhWsIWvthT8iRFyX9xVEvEZf6TX3/aarWAqKzdD+
	 H6xz6xuotO8WnIQeKqd52zoTI8a+Xubo/nPSYHjEzsuQh/MLC1vr/xuLccIjgAW2xh
	 G7bfHnj4IssSsbqXh2GTrGXhATviRv2IgOR5rxMLfkHX3FUVaUP6A77ipbPEe35OLP
	 wpKB+dHKWsCLED/ut4hjgPW627z7j3YP3/TmCtYPV83GUAAKSgfcUYP5rJe/QuvBtF
	 6qCA9l32Jkk7VrkApLFSNns7ywmx6o/WIPtAEH+cJwD/zEXXRU8IPATnwemZZ10A/U
	 nvX86dUibMHJQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCHv2 bpf-next 3/6] libbpf: Add path_fd to struct bpf_link_create_opts
Date: Wed, 10 Jun 2026 16:36:24 +0200
Message-ID: <20260610143627.804790-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610143627.804790-1-jolsa@kernel.org>
References: <20260610143627.804790-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding the path_fd field to struct bpf_link_create_opts and passing it
through kernel attr interface.

Assisted-by: Codex:GPT-5.4
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/bpf.c | 1 +
 tools/lib/bpf/bpf.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index f37e3416f61a..96819c082c77 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -842,6 +842,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 		attr.link_create.uprobe_multi.ref_ctr_offsets = ptr_to_u64(OPTS_GET(opts, uprobe_multi.ref_ctr_offsets, 0));
 		attr.link_create.uprobe_multi.cookies = ptr_to_u64(OPTS_GET(opts, uprobe_multi.cookies, 0));
 		attr.link_create.uprobe_multi.pid = OPTS_GET(opts, uprobe_multi.pid, 0);
+		attr.link_create.uprobe_multi.path_fd = OPTS_GET(opts, uprobe_multi.path_fd, 0);
 		if (!OPTS_ZEROED(opts, uprobe_multi))
 			return libbpf_err(-EINVAL);
 		break;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 012354131cf6..7534a593edae 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -444,6 +444,7 @@ struct bpf_link_create_opts {
 			const unsigned long *ref_ctr_offsets;
 			const __u64 *cookies;
 			__u32 pid;
+			__u32 path_fd;
 		} uprobe_multi;
 		struct {
 			__u64 cookie;
@@ -477,7 +478,7 @@ struct bpf_link_create_opts {
 	};
 	size_t :0;
 };
-#define bpf_link_create_opts__last_field uprobe_multi.pid
+#define bpf_link_create_opts__last_field uprobe_multi.path_fd
 
 LIBBPF_API int bpf_link_create(int prog_fd, int target_fd,
 			       enum bpf_attach_type attach_type,
-- 
2.54.0

