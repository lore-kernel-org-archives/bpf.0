Received: from mta1.migadu.com (out-48.mta1.migadu.com [95.215.58.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFD647125B
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 11:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039622; cv=none; b=LAMveQACo+PWICCQFI8dN7EaWe5kp3Xyi5k5nplccM4ydRcWHFOff8kNB32bQuhvddNZytSKi8elrSdEyd9zh9h9TCtVyQLNELibLyNj3al0QotptgN9W/BbI4Ch07gx337H5KbGi/Xz5fJXTh/Qg6FC+NTp/kItuCWlcGDTkOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039622; c=relaxed/simple;
	bh=95IyqXeqOZzjkj+0Ve1SI6MTNK+0O2yC9tCyVk1xeLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGfF/IKASuPn9RBia4IUN0xDkluXHT7GaGol8x4TJgXG2tV9pHVQiYd3481/oKO2W58GRiqRZ92JSbW78Ldu4rBpltscDQ4BxpMGZ6TeI7x7RADmiYjdrWS3W6OHl6smo/lLvVNFyMoJ6UxBYZJk4TrAHZLxfg3iTEUucJRyw4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=je5Ig+Al; arc=none smtp.client-ip=95.215.58.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="je5Ig+Al"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=95IyqXeqOZzjkj+0Ve1SI6MTNK+0O2yC9tCyVk1xeLI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789039617; v=1; x=1789644417;
 b=je5Ig+AlXljzoKvBTJNFM7Ojb5Yzt/ic5puVMDQMyUl7NA6DhyHE/u+tbUnJvvpxr8XVPJQn
 Raz5FDzQFDLp+YNQilyleT83b5mDcXwFwfXt4pXRAzGzHWGTvQ78iVs6RmfeTE0aIm7JThT7sdz
 Cawdtw28tM8JSIi6USD2cM9c=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id cdfc5c82ce19bbc5;
	Thu, 10 Sep 2026 11:26:57 +0000
X-Mizu-Trace-ID: cdfc5c82ce19bbc5
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Xiang Mei <xmei5@asu.edu>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
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
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v3 1/3] bpf: Fix out-of-bounds read of sk_protocol in bpf_sock_destroy()
Date: Thu, 10 Sep 2026 19:26:26 +0800
Message-ID: <20260910112634.152195-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910112107.148770-1-jiayuan.chen@linux.dev>
References: <20260910112107.148770-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sk_protocol lives in struct sock, not in struct sock_common. A timewait
or request sock handed to bpf_sock_destroy() by the tcp iterator is
neither, so reading sk->sk_protocol runs past the object:

==================================================================
BUG: KASAN: slab-out-of-bounds in bpf_sock_destroy+0xc7/0xe0
Read of size 2 at addr ffff8881047d11b4 by task test_progs/428

Tainted: [W]=WARN
Call Trace:
 <TASK>
 dump_stack_lvl+0x91/0xf0
 print_report+0xd1/0x630
 kasan_report+0xf3/0x130
 __asan_report_load2_noabort+0x14/0x30
 bpf_sock_destroy+0xc7/0xe0
 bpf_prog_c3dd61f9d9cd9f37_iter_tcp6_timewait+0x9f/0xb7
 bpf_iter_run_prog+0x538/0xde0
 bpf_iter_tcp_seq_show+0x26b/0x4b0
 bpf_seq_read+0x424/0x1210
 vfs_read+0x197/0xe40
 ksys_read+0x119/0x240
 __x64_sys_read+0x72/0xc0
 x64_sys_call+0x647/0x27e0
 do_syscall_64+0xe5/0x610
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Only check sk_protocol on full socks. tcp_abort() already knows how to
deal with TIME_WAIT and NEW_SYN_RECV socks. Also fix the comment, it
never matched the code.

Fixes: 4ddbcb886268 ("bpf: Add bpf_sock_destroy kfunc")
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Closes: https://lore.kernel.org/bpf/20260702224519.800135-1-xmei5@asu.edu/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
A reviewer asked to add ENOENT to the list of errors in the comment.
I'd rather not list what the handlers return, that can change any time,
so the comment now says "EOPNOTSUPP, or whatever the protocol specific
destroy handler returns".

A reviewer also worried that a sockmap iter could pass an unlocked sk here
and run tcp_abort() without the sock lock. It cannot: only the tcp and
udp iters mark their sk ctx arg as PTR_TRUSTED, and bpf_sock_destroy()
needs a trusted arg. A sockmap iter prog calling it is rejected by the
verifier with "R1 must be referenced or trusted", verified in qemu.

v1 -> v2: modify comment AND avoid flaky about selftest
v1: https://lore.kernel.org/bpf/20260903125306.299943-1-jiayuan.chen@linux.dev/
---
 net/core/filter.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index a043d179ff1ae..3e17ece09f028 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12901,8 +12901,9 @@ __bpf_kfunc_start_defs();
  * @sock: Pointer to socket to be destroyed
  *
  * Return:
- * On error, may return EPROTONOSUPPORT, EINVAL.
- * EPROTONOSUPPORT if protocol specific destroy handler is not supported.
+ * On error, may return EOPNOTSUPP, or whatever the protocol specific
+ * destroy handler returns.
+ * EOPNOTSUPP if protocol specific destroy handler is not supported.
  * 0 otherwise
  */
 __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
@@ -12914,8 +12915,12 @@ __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
 	 * Supporting protocols will need to acquire sock lock in the BPF context
 	 * prior to invoking this kfunc.
 	 */
-	if (!sk->sk_prot->diag_destroy || (sk->sk_protocol != IPPROTO_TCP &&
-					   sk->sk_protocol != IPPROTO_UDP))
+	if (!sk->sk_prot->diag_destroy)
+		return -EOPNOTSUPP;
+
+	if (sk_fullsock(sk) &&
+	    sk->sk_protocol != IPPROTO_TCP &&
+	    sk->sk_protocol != IPPROTO_UDP)
 		return -EOPNOTSUPP;
 
 	return sk->sk_prot->diag_destroy(sk, ECONNABORTED);
-- 
2.43.0

