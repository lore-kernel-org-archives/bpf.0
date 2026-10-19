Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444214;
	b=tX4cyqy0f/JSvti0gQTIiuL3ilrEMqaAEv1AayMR57og6BJf/m/ex6psJxjzrQlRV/BC
	 JasCmFzU8Aa24zRiSQA2UBvpDnm8LpKKkwAUa5yyx/fAm6dBf6o0WLjdbzNv/4+vmOmpY
	 SnOPUyJjOUR78RSfIstz/Gzowq2TMY+cS0eI3knckx4zRjTtIDirPTwlL580Mf78AcZ0v
	 AGO0oPn0Wh21YbF3Niu+4yCH4Z3Ggk4aqUoPK6uQYrkQNG+5uKkZED8tjGrZSOmvcAbUQ
	 Yjj4Jf210vXR4+FhIJCHS4NE9tlenFfBEoSG23sqxRWrVV4yspMQUfv5057taM3frTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444214;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=80NgnfNG04biR+Qo1AtgFMLB1GwXNU8ARboCn9v6q3s=;
	b=MWCEFVW7GJ18X9WUSWnlQB0OWNXnE49HbZNYb0sRga39AO925LIL4NIY5xCY4iRHj5+T
	 GOOSC4iY41MNV2sXi3gHZVGtYbAslpBMC6vYb+C3qcOsPaL8pzZV7rWNeUtrNhr0q9/ul
	 HJITRNG+GCWoiXrAZ7xXhS0H7n0ASzN9KXrvg3oBvkmZA+7520ModysRg+MdlfDqMSJem
	 l3w9U8X1Zfy6jxradX5b9x/tHjTiYIk2DEnhoPrGgM7DzsKFb0HLkNuX6OY9QTLjhfAln
	 rOulSLGi6rRUd4+F7uGLfF373LXX2FiSjricbozO7m07JtqpcIyzcg62zuLf2mFtQGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0pIR+Xu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E901C606A31C;
	Mon, 19 Oct 2026 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0pIR+Xu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A83F1F000C5;
	Mon, 19 Oct 2026 21:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792444213;
	bh=80NgnfNG04biR+Qo1AtgFMLB1GwXNU8ARboCn9v6q3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n0pIR+XuktZH/nh8Q05TRP6NOhEBlS6dKnYDnTogxvCHhCSvyCVxrFdF0wp7rPyHW
	 Fnt61zvh1sL86JFBbBPwSYoqtdC/Qrk9hmhGDbaleGbVN25SXXretNBLXgRWD77CFF
	 q+2ATQAR7c614fp5OwJvTVBk/k2lb65cjIFsWt8uUPzf7kCf9tMEepmpLmf1LG5DW9
	 EeeUYs0T10jmZuvl8A3W66edym7pX5SNiDVqDqnOn6LP2So2QolXQD9LGsst2Z3yK3
	 8lZj5XJSd9BqdWFmfMSRgjYD33wLQ5fSQAXflk0JDqzKvxTWz0eLkxLUbsL9z4TjtW
	 W9s0y1PEfmdnw==
From: Sasha Levin <sashal@kernel.org>
To: bpf@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Eric Dumazet <edumazet@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next 1/3] bpf: Drop unused entries from special_kfunc_list again
Date: Mon, 19 Oct 2026 17:10:04 -0400
Message-ID: <20261019211006.2574350-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019211006.2574350-1-sashal@kernel.org>
References: <20261019211006.2574350-1-sashal@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6f033615ef8f ("bpf: Trim special_kfunc_list in verifier") dropped
bpf_arena_reserve_pages, bpf_stream_vprintk and bpf_stream_print_stack
from special_kfunc_list once nothing used them anymore, but commit
ab7fff217fd1 ("bpf: Check helper and kfunc arguments in one path")
brought all three back without adding any users.

Besides being dead, the bpf_arena_reserve_pages entry can't be resolved
on 32-bit and !MMU kernels, which don't build arena.o, and since commit
201a454df948 ("resolve_btfids: Fix the --fatal_warnings exit status")
the resulting resolve_btfids warning fails the build with
CONFIG_WERROR=y:

  WARN: resolve_btfids: unresolved symbol bpf_arena_reserve_pages

Drop the three entries again.

Fixes: ab7fff217fd1 ("bpf: Check helper and kfunc arguments in one path")
Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d138688468236..22f095b9dca2d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13549,10 +13549,7 @@ enum special_kfunc_type {
 	KF_bpf_call_rcu_tasks_trace,
 	KF_bpf_arena_alloc_pages,
 	KF_bpf_arena_free_pages,
-	KF_bpf_arena_reserve_pages,
 	KF_bpf_session_is_return,
-	KF_bpf_stream_vprintk,
-	KF_bpf_stream_print_stack,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -13644,14 +13641,11 @@ BTF_ID(func, bpf_call_rcu)
 BTF_ID(func, bpf_call_rcu_tasks_trace)
 BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
-BTF_ID(func, bpf_arena_reserve_pages)
 #ifdef CONFIG_BPF_EVENTS
 BTF_ID(func, bpf_session_is_return)
 #else
 BTF_ID_UNUSED
 #endif
-BTF_ID(func, bpf_stream_vprintk)
-BTF_ID(func, bpf_stream_print_stack)
 
 static bool is_bpf_cast_to_kern_ctx_kfunc(const struct bpf_call_arg_meta *meta)
 {
-- 
2.53.0

