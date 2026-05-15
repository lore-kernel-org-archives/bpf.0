Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4365D37C11B;
	Fri, 15 May 2026 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835999; cv=none; b=a4/cXh3m8rvCnNmcJ5eZb2BD5nq6yN5GRzVPGg0A2ZwKQiTMMRSGqd6ku7dBfZ/3SpS87xf7ryfWDFAmpAnsHDStU0UGB/cOLcchqwTdEmjaRJEt6p9GrtdGlsKdlo3xygcBW2Ub8Uphfq1Q7r/08f6IDkn235OkupNFRn+8G7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835999; c=relaxed/simple;
	bh=wjaoDrLHDZS/N8K+vPc/39ynWT6iioTJG/WZD4k1D4E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZUKvlrUVQ6XLMZjwduBV+A+YD/2yk+UjBF04jGPRXbgNYAPKKzFnUxAe/7VVtdFvvNVdm+oxOpLghvLsf2IEOUTN5DZCMxi1ISAJiEMkSbb6T7uKtgnYA6Cw1kzbBJSDraxZsyi07KUlLBDpxl1DuurYUZH68PsTi7G7ws2UwDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nhk6pgJH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nhk6pgJH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803C4C2BCB0;
	Fri, 15 May 2026 09:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778835998;
	bh=wjaoDrLHDZS/N8K+vPc/39ynWT6iioTJG/WZD4k1D4E=;
	h=From:To:Cc:Subject:Date:From;
	b=Nhk6pgJHcxy1LloXzV0toVkvEMKxitxi3U9x37/ZdKSr/xFQjgLmE5MKxQkHtf9Pm
	 BrF0ySezrCTxWTeFo5NNgvU8qi8o7igUHraHCsRUWDKrBleoiB+9AL8EJH7bOmlQ7D
	 NSZRBjgN9SFOLQcHpxQI2RIgRTbyiP1H0WQ/vSLfpJqzJjLBpAZ8SX+N23gPZNkKo2
	 V/swxFSOasjOw7nK+5GXRKguFMxDiHDf3FIXfy0o2vsQVY0soEeYGQyjyU2w6EtsEK
	 xwlTJRYjeaJp/kqO6h/J5kIUwfBiq7zhquUH5Tu3rhCh3Cyz+ETQ8P5AVROw5ksF95
	 Y6JfrnB4nTv8g==
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
	Mykyta Yatsenko <yatsenko@meta.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: make bpf_session_cookie() reference optional
Date: Fri, 15 May 2026 11:06:15 +0200
Message-Id: <20260515090631.284426-1-arnd@kernel.org>
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

