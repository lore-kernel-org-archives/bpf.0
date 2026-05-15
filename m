Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5DD47AF5C;
	Fri, 15 May 2026 11:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844768; cv=none; b=PLQKp2n5KqG7bn6Cwpu5vyR4OOKFBLM7dF6UP58t7eaiI9kBn7dF51t+e9UFBGVkULz9v5Dxs5q20GlDsvhT/KX37wR6LvTBvU3gRwTxYBGVtaLahTNuVlEszCBr0caoEMeaIojedZv3yqPF62vBhWv0EhTZmqNWwUpw2po28FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844768; c=relaxed/simple;
	bh=JJ06PGxfKDacxKj/SrJ7zojJ+0CjxL7QBaU3bjrPw4E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sqAX0SQgnlTEpt0zfhaIdJFisU5bBV0Rf9BKcx8tMQ77aIrZvnzftj8adpE+WN7SoFyGVI+aEPKdsvZKOd6Xngkfo/gMZ47rQ6AU/ytsS3eYj/wn7KvQ8rF2RBD5YEYNjD3hSg2XbRtUo7mK49H4GA84OuHD4h1p9i791GB4Xck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBo5eQXG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBo5eQXG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF2AC2BCB0;
	Fri, 15 May 2026 11:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778844768;
	bh=JJ06PGxfKDacxKj/SrJ7zojJ+0CjxL7QBaU3bjrPw4E=;
	h=From:To:Cc:Subject:Date:From;
	b=YBo5eQXGTB+5MhSgAZCQDBIqCOlySUBLPFdPwbvN+yBsn9MrpEQ4Y7HEwJvO4PDqW
	 u4QP7rqpOlVyGImLJs0rQ8JWyHfmCMptiw6Tstv63ILTxn/ZsN2LPObgXxzdaF/jBT
	 tJ4ZUKQY/IMcZ4Pp7TmoA9k+jxHBe7jmIO7NluxYfWHtAOaofM6K6qOnfUDScsgOsn
	 d4v4vdloV0aFgUNb0Qgk6YwIQIA0ZmlXavyszv5rY87h6op/N9enliwRs5iyUBtAGW
	 qRmoNW1EI9heDN6x+YsZ8u0lP4JMbOWeH8LsjqNEFGHzc4BZ8JlHLtv/YQuPX9OzFo
	 zZUllGfinOq2g==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Menglong Dong <menglong8.dong@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] bpf: make bpf_session_is_return() reference optional
Date: Fri, 15 May 2026 13:32:32 +0200
Message-Id: <20260515113242.2706303-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Building without CONFIG_BPF_EVENTS produces a build-time
warning:

WARN: resolve_btfids: unresolved symbol bpf_session_is_return

The function is actually defined in kernel/trace/bpf_trace.o,
which is built conditionally based on configuration.

Make the reference to this function conditional as well,
as is already done in the bpf verifier for other functions.

Fixes: 8fe4dc4f6456 ("bpf: change prototype of bpf_session_{cookie,is_return}")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: fix patch title
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03f9e16c2abe..a5139f45e366 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10882,7 +10882,11 @@ BTF_ID(func, bpf_task_work_schedule_resume)
 BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
 BTF_ID(func, bpf_arena_reserve_pages)
+#ifdef CONFIG_BPF_EVENTS
 BTF_ID(func, bpf_session_is_return)
+#else
+BTF_ID_UNUSED
+#endif
 BTF_ID(func, bpf_stream_vprintk)
 BTF_ID(func, bpf_stream_print_stack)
 
-- 
2.39.5

