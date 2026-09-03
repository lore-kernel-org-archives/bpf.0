Received: from mta0.migadu.com (out-159.mta0.migadu.com [91.218.175.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABAD4AA563
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 12:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440003; cv=none; b=coZhW841QwKV+PUtV6wFB7h9SF/N9fq9fP5dEVYYTUbJ9shTBikUezrsaasi5TcUJ1uB0SzVm5eSN2a171P9xWYJhxm4ZBq7hI+RnM0DNqbE7SbGQtEkL3Ldl/lmNPQckvV8jmdfUVvcSzO/JQ5RlyJWGiA/FVpLkBGV313KW4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440003; c=relaxed/simple;
	bh=UlTZVZlpxTLFXO8JJRdJ8MXuTqmOeVcpCsf//AOZZCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MybLAPSiERq57npSPPnhv3JQPPXqLbdke+CnCk8Z6FeHp3qtUz8xRGvsTuN4EcKkfbDO5xeVMyaa7SIKncsgaSpUBksLSbY8zVYMZK6istbkodr386kIddk7qel6mBXPPzfM4TXxLZws+nt0B8WNpFCH+7tDV0LA+Z95reivuu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bZgCCfHJ; arc=none smtp.client-ip=91.218.175.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bZgCCfHJ"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=UlTZVZlpxTLFXO8JJRdJ8MXuTqmOeVcpCsf//AOZZCE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788439998; v=1; x=1789044798;
 b=bZgCCfHJwIyAAkUIHMriFrmR1b1F7tyZwl3fdu9z9UCeZsj2Ep7DEIyUSEmgF+ZhMVLWiEvw
 zyYYk1BeX8qgwCaCvP8majsvebQqpmTIzeIQAVPXlFPzTB95++c2u/q1A+GTnGmeZszJFKDFLtf
 gi3y7yEVr4Bab5NY9KUjsef4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5ce3ad7db0c8ff24;
	Thu, 03 Sep 2026 12:53:18 +0000
X-Mizu-Trace-ID: 5ce3ad7db0c8ff24
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Xiang Mei <xmei5@asu.edu>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 1/2] bpf: Fix out-of-bounds read of sk_protocol in bpf_sock_destroy()
Date: Thu,  3 Sep 2026 20:52:48 +0800
Message-ID: <20260903125306.299943-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
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
---
 net/core/filter.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 61940e753552..1bbb72138ac6 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12912,8 +12912,8 @@ __bpf_kfunc_start_defs();
  * @sock: Pointer to socket to be destroyed
  *
  * Return:
- * On error, may return EPROTONOSUPPORT, EINVAL.
- * EPROTONOSUPPORT if protocol specific destroy handler is not supported.
+ * On error, may return EOPNOTSUPP, EINVAL.
+ * EOPNOTSUPP if protocol specific destroy handler is not supported.
  * 0 otherwise
  */
 __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
@@ -12925,8 +12925,12 @@ __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
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

