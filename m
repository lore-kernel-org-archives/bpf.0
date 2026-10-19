Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444217;
	b=4Q2oYogUAcN49iEaV1PV6eXVWgd7N+5jYyn5rVn+/3c6NbnYPl/66vn7a+rKh2D3xTxE
	 MRegQ/U6sIii3I7MXhr4IoX6eh2RhabAOjdDbyIyfDF6RppPPfGMcfp63nvW5lbb7bAV2
	 V3qXEPvLO2/2RFs+8G73HCgNEEOEp4BpeG8fZeGwpVoR/IxbCjSKHBdAwmZlM4jMKo0I5
	 0un5p26Cf9UdegYgDTd+GfRYiU7mc2MoeCD/i4peLxIf37a4TOFw7NleoN/h5xopuTWak
	 ZLUhk7gjGGK4VcecOz3RAqoY/2GIC8t+HPHoR3ft9Ofui3xj45IJ/lPp0w8JhVQUf7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444217;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YhI+AK81XLCtdL59lTKeYo77+ymjLGfVFWvDZPKBf20=;
	b=l2GqnaWTfRFiYUzONcPyGubiSTNMBDm04xxNyURnwBKKRZcMks7OzMQlitKE/bQcn9kh
	 xFHszqvGKF9HWl4Ft84UDwmkhWJdP4Uh+QFN+f144tcQjRzAeS7TM5yj1WL1ffWCX8UHA
	 aqsZdPTvG+P+WRTs8bgU7vqACO3r4/OHtxNzFYbfhQlMuN2l5U/aUC5L8rZVyd3k4OpF6
	 PP38l2ARWsY6Kxg6/EZDiWu9Vwz+2xhb7IUJtFtTlWdiJmeyGjq1cJykxIm/erxJFV/9k
	 BtrqZQPThwDNCpdZ7YYawDPYkH+nM3Z9NZntppbNuhfRNKSOMi+5DmuOzkEnEBOeMxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nM/SRvyV";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145D8606A323;
	Mon, 19 Oct 2026 21:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nM/SRvyV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB8C1F000C4;
	Mon, 19 Oct 2026 21:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792444216;
	bh=YhI+AK81XLCtdL59lTKeYo77+ymjLGfVFWvDZPKBf20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nM/SRvyVZ0Gv8bi/pylE2bHe1ifDVtvl4k47e5rRHluJ8VOQLN3jt+ABrt38eQ33M
	 FXDF8sYE1K3r+b4ZR8nU8K7kuQ5w01I+F0jvSHdBU53NUxe/QeoAoqvQ4ZbuNQn+x5
	 Q/lvGGQFBjlUsr4ZSrHG5CbJpQZVwYwNJITvdhS90rgk9HSMKU1yQglMCx66M//xUE
	 8AsGNQ7BK0biQfnpLVRv7E/RTy3yGgKDiX6kdB5FDZ2zhQ7UFXyxXwnhBmjFhPTqdy
	 gLSXPteD5SbW7ja0Z1JSN5nX4G1x/h3NEhUqx10LVxzfNSG92kse3HSavti3qBw1Sd
	 LfuAIcIl8xhmw==
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
Subject: [PATCH bpf-next 2/3] bpf: Don't reference arena kfuncs when arena isn't built
Date: Mon, 19 Oct 2026 17:10:05 -0400
Message-ID: <20261019211006.2574350-3-sashal@kernel.org>
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

kernel/bpf/Makefile builds arena.o only for CONFIG_MMU && CONFIG_64BIT,
but special_kfunc_list references bpf_arena_alloc_pages() and
bpf_arena_free_pages() unconditionally, so on 32-bit and !MMU kernels
resolve_btfids can't resolve them:

  WARN: resolve_btfids: unresolved symbol bpf_arena_free_pages
  WARN: resolve_btfids: unresolved symbol bpf_arena_alloc_pages

Since commit 201a454df948 ("resolve_btfids: Fix the --fatal_warnings
exit status") these warnings fail the build with CONFIG_WERROR=y, which
breaks i386 builds with CONFIG_DEBUG_INFO_BTF=y:

  Failed to generate BTF for vmlinux
  Try to disable CONFIG_DEBUG_INFO_BTF

Only reference them under the condition arena.o is built with, and use
BTF_ID_UNUSED otherwise to keep the list in sync with enum
special_kfunc_type. An unresolved ID is zero, like BTF_ID_UNUSED, so the
contents of the list don't change.

Fixes: b8467290edab ("bpf: arena: make arena kfuncs any context safe")
Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 22f095b9dca2d..12229713a4528 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13639,8 +13639,13 @@ BTF_ID(func, bpf_task_work_schedule_signal)
 BTF_ID(func, bpf_task_work_schedule_resume)
 BTF_ID(func, bpf_call_rcu)
 BTF_ID(func, bpf_call_rcu_tasks_trace)
+#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
 BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
+#else
+BTF_ID_UNUSED
+BTF_ID_UNUSED
+#endif
 #ifdef CONFIG_BPF_EVENTS
 BTF_ID(func, bpf_session_is_return)
 #else
-- 
2.53.0

