Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4A62E7179
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 15:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776439304; cv=none; b=pkYLrbM786JmaEmjoWzK5LVXkTL4nd+YAYliMAVKuAb1QONLeSvplcP4PC5hryMz+fF9i1kWeTxMvfKpV9TEOb/FipOveMfkQ5RyH+KMZYR+/xxY08aHhMIzah7MeNKYOWM2usetkXTnrg4TA8xu3WSjsP9awMK4qPexTjmKc38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776439304; c=relaxed/simple;
	bh=yIpZKcQdQbGAVzljiNrZtJyqnUVbPhadLK8LLzqmqsw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gAfNIGbNna47X4w5Ih8ITarxcYeXqylzQhQVihWHM9x83ByKrPXvlscZ2JnMztyVdOivi+Hro7tfzDSZya3gp7B4e2h82ZFAVFaF9Org0vMzlB7MVj35V98Z2E4IwliyECL8K+wTaqXciFKJNZqdFLCHw3e2WzrlF3TihzBI+kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQRTkP2O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQRTkP2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC97C19425;
	Fri, 17 Apr 2026 15:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776439304;
	bh=yIpZKcQdQbGAVzljiNrZtJyqnUVbPhadLK8LLzqmqsw=;
	h=From:To:Cc:Subject:Date:From;
	b=JQRTkP2OHxp4hNjQlILTu0XT9XzBsAQcHVfEkni0LKXQL8FdFHGo+xqcwRCIZOHO3
	 OypHw55j1rlOiBmQyOFTUbIoMjWzVXDqdUt2SqgAUvuDrv4eVVUwZ050GbgkuICrCu
	 mL+YZ5agcfJ/7Xbh0teZz2ALG6noScBPA5ODeA5UMpX+M4hVU1x892cJHlszcNUnvK
	 5eRT+mDQHW8BvPe7RMJ6zY2dULX2fMON/LfcoOKuLItUICaDAYEQ9dIAemysZ8ri+8
	 1HIaZUhszD1mrXIhZn8eNFYBGrvmdovIJmuQ9wm/nDECfMXxelQWBs7qD4drdtpoCZ
	 pUYY80Vl7yizw==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf] bpf: Validate node_id in arena_alloc_pages()
Date: Fri, 17 Apr 2026 08:21:33 -0700
Message-ID: <20260417152135.1383754-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arena_alloc_pages() accepts a plain int node_id and forwards it through
the entire allocation chain without any bounds checking.

Validate node_id before passing it down the allocation chain in
arena_alloc_pages().

Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/arena.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 9c68c9b0b24a..523c3a61063b 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -562,6 +562,10 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	u32 uaddr32;
 	int ret, i;
 
+	if (node_id != NUMA_NO_NODE &&
+	    ((unsigned int)node_id >= nr_node_ids || !node_online(node_id)))
+		return 0;
+
 	if (page_cnt > page_cnt_max)
 		return 0;
 

base-commit: 380044c40b1636a72fd8f188b5806be6ae564279
-- 
2.52.0

