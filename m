Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9B23090CD;
	Thu, 12 Mar 2026 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773319071; cv=none; b=cUJ5qQs6CNgcQO9gtofmx8FM6Y9v+SDrPdyillagCKDXavduoVL9vGE3hH8TXlIPqc1jifSXg/FmJd+a2dlFL3ME9Zvcq7tf2R8oLbL1qDmXcB6W6U/D21STEc3FBgfiC2maJHvwmZL42YdlbwsRVtujToGeZ+BfBtfvI12vQ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773319071; c=relaxed/simple;
	bh=SKkbJG38rCzY64Md0FQWaJ5K1k6+NZ5aFqVNayh2O4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NyIqXZ1aCkwLqY4Lw6pRkt72wTtZysNI0YTKC2OpNxcTTglITYcI4hdBIveVO8ECFIjplTCar8BCnMwN+9GCfoXU6E4jIoRHTtu6WIKDLYLtNVXzmHoAD3VM7ngG2jKVxfHqd++p87iflAWKEOL62AA+xQYvSnLU4S6mSe+T5eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vc6xcKXY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vc6xcKXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77077C4CEF7;
	Thu, 12 Mar 2026 12:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773319071;
	bh=SKkbJG38rCzY64Md0FQWaJ5K1k6+NZ5aFqVNayh2O4E=;
	h=From:To:Cc:Subject:Date:From;
	b=Vc6xcKXY+NlQKac6NA+Tq2nZfILA+ay7hAeJHSIJBfPRooD/w73CtY1usFLOMw+Jf
	 lq+daW/OXmK3wecfjIQOUowURQMGvQuXGcdjFKWNawL+sTwvOjQyP2rrHtCObQ5dhw
	 2qOIOUoFDgXck6DWtxVG/Xq1fd1Bz9aNgC26cEMzDd/9K3u6rKMw7gBZh0PhO8RklA
	 G+uGl9FjOxem2ZVtPt7rrIG1qeEWyddidGK24UEn/oBHGgi/feymO0zOvRJ5WzIxUD
	 VU/A8TDuudS8j7zxnCyT4cluqzRZ3Z8tm28ZaiSa8euKsHES1GB7MUnZ+i5RD8C1Hi
	 4c/tY+sIIfZ+w==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Song Liu <song@kernel.org>
Subject: [PATCHv2 bpf-next] ftrace: Use hash argument for tmp_ops in update_ftrace_direct_mod
Date: Thu, 12 Mar 2026 13:37:38 +0100
Message-ID: <20260312123738.129926-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The modify logic registers temporary ftrace_ops object (tmp_ops) to trigger
the slow path for all direct callers to be able to safely modify attached
addresses.

At the moment we use ops->func_hash for tmp_ops filter, which represents all
the systems attachments. It's faster to use just the passed hash filter, which
contains only the modified sites and is always a subset of the ops->func_hash.

Fixes: e93672f770d7 ("ftrace: Add update_ftrace_direct_mod function")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/ftrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

v2 changes:
- updated comment and changelog [ci]

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 8df69e702706..413310912609 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6606,9 +6606,9 @@ int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, b
 	if (!orig_hash)
 		goto unlock;
 
-	/* Enable the tmp_ops to have the same functions as the direct ops */
+	/* Enable the tmp_ops to have the same functions as the hash object. */
 	ftrace_ops_init(&tmp_ops);
-	tmp_ops.func_hash = ops->func_hash;
+	tmp_ops.func_hash->filter_hash = hash;
 
 	err = register_ftrace_function_nolock(&tmp_ops);
 	if (err)
-- 
2.53.0

