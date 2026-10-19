Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444220;
	b=gQCd3HcjyjepTIlYO/T1IZ534tKZtk9xXw+CQiuq3cU4L32WTIzmNSzVA/+2Yht4R6RB
	 y1uxwFrXOHSQycBO5mKfThKHAoqDpXIH3W//KrMoDifIjcHpQveuc8YybasBaHSg7moSS
	 bVM9gqZktg7lLKa11Wq1Ip7Sjlr1Lvv+5WwjyQndjNlz1fU1Ts4TlOisUrKFl8GBfWqZx
	 ysYpg/tGsmTHwblBzrHb+3aXM4PB/xtqEbSTe0KJmkrAcin6JwNQ9gLNPk2hPAH8s6K6w
	 PjJRWZLKGgklY6YsN5l9gm/UwyR2MSDHs3DZrzdoX5RrRUG9VRIl+zjVO4lQ64UVmdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444220;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=soRQ55zb58DScNjvFPcl1FOvV5pmT13HtaUCR5/nEfg=;
	b=2gs9oAytywWfYIN8Zqxf81DASdJ6jfEjsd08UWd3voZRICz/DFwJMDh0pxerShK9Cbfp
	 9JGN9dlK075ipzASdjK2wQ7x3FIzYh0e9BR5bgi8AGvdeNwh4+I4aSpAXNG1WzyvYnPRR
	 lSXAsPXpkNRSWC2LSouTseFGMFnKTumHM3s9lspFON9i/qaIAQfJBYI1fZ35qPsvS281v
	 oDLNh1IpI4hifl1BxgsBA6ZErZc8L3rD0QlyvDptyNUZ0959iAV95mUXqRlc054PH30Ah
	 y6EevWkYmJ7MS6uWJkISS7JQ/uEBPR+AjzwliMkRm5T8wjE1e45CWuMagzca4Psdtgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ImZSkxUC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AD3606A320;
	Mon, 19 Oct 2026 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ImZSkxUC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAF11F000C6;
	Mon, 19 Oct 2026 21:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792444219;
	bh=soRQ55zb58DScNjvFPcl1FOvV5pmT13HtaUCR5/nEfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ImZSkxUCFcPA2miLyYlob/kb1TtZs3zOhSXi7uhzHO0to42kpDZW5JryQd9c4ID2D
	 XemmedxaR9ZokWUA3wJXNosVOIP0aaAQ7YXwbFVnwhxD2geZoAz0BUvjROZVkn55T+
	 kMEPU9f6q9D+MDsXtuD7buwBlgpZmv1RcgYd7g0etJv1kXCbyCcS40EJK7v00wUdfA
	 C0tEMDYF/BYJGoIGpyBifmD6LGB7Ta+pL+G3rUrlDIp3Qs5P3hsp637g0ICkrS8A9/
	 79NF9wJQHx57fUXx32Bq3WoR4+QY06WldGBp7UzqubGqL65GvQEUUQUlEi9PqLCz5s
	 dmwOfQeni0HrQ==
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
Subject: [PATCH bpf-next 3/3] bpf: Fix ksock build with BPF_LSM=y and SECURITY_NETWORK=n
Date: Mon, 19 Oct 2026 17:10:06 -0400
Message-ID: <20261019211006.2574350-4-sashal@kernel.org>
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

bpf_ksock.c references bpf_lsm_socket_sendmsg() whenever
CONFIG_BPF_LSM=y, but the socket LSM hooks, and with them the BPF LSM
socket_sendmsg hook, only exist with CONFIG_SECURITY_NETWORK=y. Without
it resolve_btfids warns:

  WARN: resolve_btfids: unresolved symbol bpf_lsm_socket_sendmsg

and since commit 201a454df948 ("resolve_btfids: Fix the --fatal_warnings
exit status") that fails the build with CONFIG_WERROR=y.

Only reference the hook with CONFIG_SECURITY_NETWORK=y, and use
BTF_ID_UNUSED otherwise. The ID stays zero, as it was when unresolved,
so bpf_ksock_kfunc_filter() keeps allowing LSM programs: none can be
attached to socket_sendmsg without CONFIG_SECURITY_NETWORK.

Fixes: 7ae4eb14c5f9 ("bpf: Add ksock kfuncs")
Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/bpf_ksock.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
index 7bf796193ab61..48a2e2327acef 100644
--- a/net/core/bpf_ksock.c
+++ b/net/core/bpf_ksock.c
@@ -258,7 +258,12 @@ BTF_ID_FLAGS(func, bpf_ksock_send, KF_SLEEPABLE)
 BTF_KFUNCS_END(ksock_kfunc_btf_ids)
 
 #ifdef CONFIG_BPF_LSM
-BTF_ID_LIST_SINGLE(bpf_lsm_socket_sendmsg_id, func, bpf_lsm_socket_sendmsg)
+BTF_ID_LIST(bpf_lsm_socket_sendmsg_id)
+#ifdef CONFIG_SECURITY_NETWORK
+BTF_ID(func, bpf_lsm_socket_sendmsg)
+#else
+BTF_ID_UNUSED
+#endif
 #endif
 
 static int bpf_ksock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.53.0

