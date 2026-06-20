Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D12E40D56C
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 00:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781915586; cv=none; b=XUhqwaVDuErXLETgHXeotpQBlJF5ZjIRJP/lcblCFAYP/B5fqKUj6BUDcZ543ZV1xb909rJ7zQLQLRgdSk96MYGE1InUpMyHlctSrqn3U7DybvnunAOrH8ZcDoSn6G3Xf8mQFZSqczQO7TXJ6wfU63CvcGBMkZS/a+QigvZlT5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781915586; c=relaxed/simple;
	bh=Et3meODDERYLPcBSzvBMvXzLFG6dCmuyWHoTXDGfTyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OpqgUSNbhUo1YDibbSXHok6UodWKK+l4f+44Q+n4vcz9zt9f3aScijZUyh1xzWQgqpoWzf6wT0+1eWRMxrNnLnKiXxxjyJ9pVG/A/ulKqGXMklzhyUitiIVEdJCgw4IILbIGajqPaiBNd+fdukuSTeZP/IaASUQ83N7VuMyLwhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A7AfagWR; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A7AfagWR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781915583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5LJfKS/Bhv+1VfMV3cw6Hh9fus6tl15FJIsSQ1Nye4c=;
	b=A7AfagWRMVIKzGssJQmi39iDt6F8KUs166h3+zT0/3yQ5TtdmC0bYglqiZvYNHbGE3JdFM
	N+S+mufk7kLr7pzpQlELo5E7EJXEPgdsAQeR7e0y2LMJSbaRLuI1bd03nEBeAhusyc4fRN
	fsCw68G6m0oklhGaRbZ1sQAVszlVmyE=
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Date: Sat, 20 Jun 2026 00:32:21 +0000
Subject: [PATCH bpf] bpf: tcp: Fix use-after-free in
 bpf_iter_tcp_established_batch()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-bpf-iter-tcp-refcnt-v1-1-883bf9e69495@linux.dev>
X-B4-Tracking: v=1; b=H4sIAJTfNWoC/yWMSw7CMAwFr1J5jUUSRPlcBbHIx22NRFrFASFVv
 TsOLN/ozawgVJgErt0Khd4sPGcddtdBnHweCTnpBmdcb3p7wbAMyJUK1rhgoSHmitac0tEFdzg
 nD2ouyvnzq95ABbj/obzCg2JtvXYLXghD8TlODc2FR877pxfNw7Z9AfRhFtacAAAA
X-Change-ID: 20260619-bpf-iter-tcp-refcnt-107d52b238da
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Ben Cressey <ben@cressey.dev>, 
 "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
X-Migadu-Flow: FLOW_OUT

reqsk_queue_hash_req() publishes a TCP_NEW_SYN_RECV request_sock onto
the ehash chain (via inet_ehash_insert(), which drops the bucket lock on
return) and only afterwards refcount_set()s rsk_refcnt to 3.

Lockless readers such as __inet_lookup_established() account for this by
using refcount_inc_not_zero(), but bpf_iter_tcp_established_batch() uses
plain sock_hold() while holding the bucket lock, on the assumption that
the lock guarantees sk_refcnt > 0. That assumption does not hold for
request_sock:

  CPU 0                                CPU 1
  -----                                -----
  tcp_conn_request()
   reqsk_queue_hash_req()
    inet_ehash_insert(req)
     spin_lock(bucket)
     __sk_nulls_add_node_rcu(req)      // rsk_refcnt == 0
     spin_unlock(bucket)
                                       bpf_iter_tcp_established_batch()
                                        spin_lock(bucket)
                                        sock_hold(req)   <-- addition on 0
                                        spin_unlock(bucket)
    refcount_set(&req->rsk_refcnt, 3)  // clobbers saturated value

which surfaces as:

  refcount_t: addition on 0; use-after-free.
  WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x48/0x90, CPU#1
  Call Trace:
   bpf_iter_tcp_established_batch+0x14e/0x170
   bpf_iter_tcp_batch+0x53/0x200
   bpf_iter_tcp_seq_next+0x27/0x70
   bpf_seq_read+0x107/0x410
   vfs_read+0xb9/0x380

refcount_warn_saturate() then saturates the count, the publishing CPU's
refcount_set() clobbers it, and the socket is left one reference short.
When the last legitimate owner drops its reference the reqsk is freed
while still reachable, leading to use-after-free panics in e.g.
inet_csk_accept() or inet_csk_listen_stop().

This reproduces in seconds with tcp_syncookies=0, a handful of threads
doing connect()/close() to a local listener while others read an
iter/tcp link in a tight loop.

Use refcount_inc_not_zero() and skip the socket on failure, the same way
every other ehash walker does. The listening hash is unaffected as
listeners are always inserted into lhash2 with sk_refcnt >= 1, so
bpf_iter_tcp_listening_batch() is left as-is.

If every matching socket in a bucket is mid-init, end_sk can stay at 0;
advance to the next bucket in that case rather than terminating the
whole iteration on a stale batch[0].

Fixes: 04c7820b776f ("bpf: tcp: Bpf iter batching and lock_sock")
Reviewed-by: Ben Cressey <ben@cressey.dev>
Assisted-by: Claude:unspecified
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
---
 net/ipv4/tcp_ipv4.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index fdc81150ff6c..92342dcc6892 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3074,25 +3074,25 @@ static unsigned int bpf_iter_tcp_established_batch(struct seq_file *seq,
 {
 	struct bpf_tcp_iter_state *iter = seq->private;
 	struct hlist_nulls_node *node;
-	unsigned int expected = 1;
-	struct sock *sk;
+	unsigned int expected = 0;
+	struct sock *sk = *start_sk;
 
-	sock_hold(*start_sk);
-	iter->batch[iter->end_sk++].sk = *start_sk;
-
-	sk = sk_nulls_next(*start_sk);
 	*start_sk = NULL;
 	sk_nulls_for_each_from(sk, node) {
-		if (seq_sk_match(seq, sk)) {
-			if (iter->end_sk < iter->max_sk) {
-				sock_hold(sk);
-				iter->batch[iter->end_sk++].sk = sk;
-			} else if (!*start_sk) {
-				/* Remember where we left off. */
-				*start_sk = sk;
-			}
-			expected++;
+		if (!seq_sk_match(seq, sk))
+			continue;
+		if (iter->end_sk < iter->max_sk) {
+			/* reqsk_queue_hash_req() inserts with sk_refcnt == 0
+			 * and refcount_set()s it after the bucket lock drops.
+			 */
+			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
+				continue;
+			iter->batch[iter->end_sk++].sk = sk;
+		} else if (!*start_sk) {
+			/* Remember where we left off. */
+			*start_sk = sk;
 		}
+		expected++;
 	}
 
 	return expected;
@@ -3129,6 +3129,7 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 	struct sock *sk;
 	int err;
 
+again:
 	sk = bpf_iter_tcp_resume(seq);
 	if (!sk)
 		return NULL; /* Done */
@@ -3167,6 +3168,10 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 	WARN_ON_ONCE(iter->end_sk != expected);
 done:
 	bpf_iter_tcp_unlock_bucket(seq);
+	if (unlikely(!iter->end_sk)) {
+		++iter->state.bucket;
+		goto again;
+	}
 	return iter->batch[0].sk;
 }
 

---
base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
change-id: 20260619-bpf-iter-tcp-refcnt-107d52b238da

Best regards,
--  
Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>

