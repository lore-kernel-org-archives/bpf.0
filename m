Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D743E7BC2
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178195; cv=none; b=dDExhjgFSG+KOTCHsjYwYWoFBuXwq1Hp4HxrfV33VswEMiiB/x1z0oEjcHdK/qt6pL21mzyRrglf2QqkcSUVgvzi6ayje6vJ3otKfo/LIxPKlx3HQcba44EZIjskfGHtLrS9CwDC/h1PjYXuwei/k2a4ZOFMJ2m5ZyPQjkVNfgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178195; c=relaxed/simple;
	bh=Vv1cZAv+0c1IBEatJNuSKcFZRHTQi6NTL8A+Gzrw4oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DS6D7TIcMbmlGsQExEwD47U2IAQdI/LWm62cW8G4mURbNCQEmLI6Mz00jlleYvpA2vavTo++RHFAtZY5gPlQoxoxmuQq5YKaiYuLi/TpkziLGjZyjkEBGsvi7qV+Y3mpWZQvz68WgH4Rjal4+RW0JfudS3jvSOhSBorNpG0C2Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzpcXK7q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzpcXK7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7395E1F00893;
	Thu, 11 Jun 2026 11:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781178194;
	bh=v+v3iXW2lWkTytq7OLGagYfrOsYjsQexmVsAgWSCYOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QzpcXK7qdJ5UtRWKRtJ3uXYwVhUMGdWsfkJ+oOMEGqEM6wzAUNjuHSNPv7qogCP8i
	 ZQOE/4c6bkbxCPC9uQTCeRc4YrsOAAgHaW293qYVuYAJzED4hoqhUJ75e1E/POBoD0
	 kwwhLpraDMPa1mnaXzGeNRCEo0uBOrFRo8hQCB8LQ/Dsldj8FrDZ3AsLbNOqkang50
	 s24RiOZvV3AzSBBqFouhlsPyS+SnIf/tQ4koSlRpNM+yMAok7wQOSNTjJucVNjRNzT
	 0BP1c+qSKDmypGJ3swARaLQnxPJaKBJ3jDFBM708IOlFxFIyRyq8uTUiqH7NltTayA
	 2t2GQdY1w0+TQ==
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
Subject: [PATCHv3 bpf-next 4/7] libbpf: Add path_fd to struct bpf_link_create_opts
Date: Thu, 11 Jun 2026 13:42:27 +0200
Message-ID: <20260611114230.950379-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611114230.950379-1-jolsa@kernel.org>
References: <20260611114230.950379-1-jolsa@kernel.org>
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

