Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795257372;
	b=h6AkXijNuR8Betu5rmSUrlDFeBbJtVyDFMleGrBinON9zfTTI6MWC6aeS2XTkwcy5TBr
	 ReSlKTyc47mCz4iGxY5msLmNTi+0ulfvWKs8Jr1RRSOO6fxrM6lNkq18y6QGnls+QohV6
	 Ad2lDgrsv5K2ddtAKipMVkWE/rSWOUMY7Dz2Hc3hHFd/aABNEXM9jZOiguwZfMtcS6nGt
	 Tfzhw05JaUg8lqx+sydsK18G3OFktR3H8Evor8yXlaIAWYB+7UGz2xtXLJ7AKVkKKTjDG
	 bYTxOI7WM1kcqIvg21W77PYIyeHYjPaP/mpsFOrCp9gM+gvDE0FpW7yBIaho4EPVG/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795257372;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YGxdIEBK4nhN8zWTjix49hEmEwb0PiL7QUXzou2sZ3M=;
	b=phFJ+WKFSh6XM28yxMbYiDIuuAonIYClx/Y/qkyRW42LIDlba7edBxzgI5+tWS65nyip
	 PzSzirGBcIx7BABYKPA6VcXAEQdjxMmn0f2KQVk84xZV5rgxjFiDLMcPp2j+kDWw8QZMf
	 KbldSzau+ha8hb4Off/Cle9yrYc/4djjsgFEgmaYXRugEhVYlaUvp9VX6QfIyQpnM6CLl
	 OG2/A5/6xywXGGz8Vi+OsE2O93324Y28C6CNA6+iVksS21vvTlELXelwveF4wkJgO39Fe
	 m1ow/9k71pPxRVG5UAGXyzZTfpmtPrLnKc3IMUdKV2XuKvOdJa/0YlaES6W19e1mnTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VR2Ls9xS;
	arc=none smtp.remote-ip=95.215.58.199
Received: from mta1.migadu.com (out-199.mta1.migadu.com [95.215.58.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F38E606A32A
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 10:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F38E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VR2Ls9xS
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=F6mbGv0otCzbO29nBJTFtgeyT3LHv7cuLIogcFbt1PQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795257370; v=1; x=1795862170;
 b=VR2Ls9xSufn0eFHOjn8g0xm9BF/t9x05sG6bRF0JoYbXoqTJGLO54UD0PSxH6Mt+Tk6xw0CJ
 J0pRpLmacqCwFTZLfd/sTj62yVzOFttplJvhiBhUonk3GPhpxVbmjEAxsBInMAkstvbiTM5/wkn
 o4tsi99FunrFfEmXYTh1ijyo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 214c8295d155b3cc;
	Sat, 21 Nov 2026 10:36:10 +0000
X-Mizu-Trace-ID: 214c8295d155b3cc
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Michal Luczaj <mhal@rbox.co>,
	Mattia Meleleo <mattia.meleleo@coralogix.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 08/11] bpf, sockmap: Fix socket lock taken on a child before accept()
Date: Sat, 21 Nov 2026 18:30:09 +0800
Message-ID: <20261121103222.88209-9-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121103222.88209-1-jiayuan.chen@linux.dev>
References: <20261121103222.88209-1-jiayuan.chen@linux.dev>
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

A sockops prog can add a child that is not accepted yet to a sockmap at
BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB. An sk_msg redirect to this child,
ingress or egress, takes lock_sock() on it. If the listener is closed at
that time, inet_csk_listen_stop() hits:

	WARN_ON(sock_owned_by_user(child));

WARNING: net/ipv4/inet_connection_sock.c:1492 at inet_csk_listen_stop+0x7ba/0xc40
Call Trace:
 <TASK>
 __tcp_close+0xb64/0xee0
 tcp_close+0x24/0xf0
 inet_release+0x10a/0x240
 __sock_release+0xaf/0x270
 sock_close+0x18/0x30
 __fput+0x360/0xa90
 fput_close_sync+0xe6/0x1d0
 __x64_sys_close+0x80/0xe0
 x64_sys_call+0x2680/0x27e0
 do_syscall_64+0xe5/0x610
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
 </TASK>

Commit 4aeaad1c536e ("bpf, sockmap: Check the target of an egress
redirect before each send") already refuses an egress redirect to such a
child, but only after lock_sock(). Refuse the ingress redirect too, and
do it before taking the lock: a child has no sk_socket until accept()
has taken it off the queue.

sock_map_free() and sock_hash_free() also lock the sockets in the map.
They can't refuse, so unlink such a child without the lock, as a delete
from the map already does.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Fixes: 7e81a3530206 ("bpf: Sockmap, ensure sock lock held during tear down")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/sock_map.c | 27 +++++++++++++++++++++++----
 net/ipv4/tcp_bpf.c  | 10 +++++++++-
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 6fc1d29ac6ed5..4a053846bd60e 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -386,6 +386,19 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
 	return ret;
 }
 
+/*
+ * The listener frees a child that nobody has accepted yet without waiting
+ * for the owner of its socket lock. Unlink such a child without the lock,
+ * as a delete does.
+ */
+static bool sock_map_free_lock_sk(struct sock *sk)
+{
+	if (!READ_ONCE(sk->sk_socket))
+		return false;
+	lock_sock(sk);
+	return true;
+}
+
 static void sock_map_free(struct bpf_map *map)
 {
 	struct bpf_stab *stab = container_of(map, struct bpf_stab, map);
@@ -402,12 +415,15 @@ static void sock_map_free(struct bpf_map *map)
 
 		sk = xchg(psk, NULL);
 		if (sk) {
+			bool locked;
+
 			sock_hold(sk);
-			lock_sock(sk);
+			locked = sock_map_free_lock_sk(sk);
 			rcu_read_lock();
 			sock_map_unref(sk, psk);
 			rcu_read_unlock();
-			release_sock(sk);
+			if (locked)
+				release_sock(sk);
 			sock_put(sk);
 		}
 	}
@@ -1228,12 +1244,15 @@ static void sock_hash_free(struct bpf_map *map)
 		 * link to sockhash.
 		 */
 		hlist_for_each_entry_safe(elem, node, &unlink_list, node) {
+			bool locked;
+
 			hlist_del(&elem->node);
-			lock_sock(elem->sk);
+			locked = sock_map_free_lock_sk(elem->sk);
 			rcu_read_lock();
 			sock_map_unref(elem->sk, elem);
 			rcu_read_unlock();
-			release_sock(elem->sk);
+			if (locked)
+				release_sock(elem->sk);
 			sock_put(elem->sk);
 			sock_hash_free_elem(htab, elem);
 		}
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 9715716518c49..da9caccfede79 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -188,9 +188,17 @@ static int tcp_bpf_push_locked(struct sock *sk, struct sk_msg *msg,
 int tcp_bpf_sendmsg_redir(struct sock *sk, bool ingress,
 			  struct sk_msg *msg, u32 bytes, int flags)
 {
-	struct sk_psock *psock = sk_psock_get(sk);
+	struct sk_psock *psock;
 	int ret;
 
+	/*
+	 * The listener frees a child that nobody has accepted yet without
+	 * waiting for the owner of its socket lock.
+	 */
+	if (!READ_ONCE(sk->sk_socket))
+		return sock_flag(sk, SOCK_DEAD) ? -EPIPE : -EINVAL;
+
+	psock = sk_psock_get(sk);
 	if (unlikely(!psock))
 		return -EPIPE;
 
-- 
2.43.0

