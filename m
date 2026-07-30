Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DA13D75AB
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 22:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450795; cv=none; b=CY8HJ77Mpfqq0SgyUs9jsyLtE6t3y7eiFB4tJeTo6A9GXKmYQqRBWNhwtRUu7fngjXWusfO8uD0McNY1l5xTeOqubboso17cqUxk1Ij1lSdi4gI+eI62hvxMIemin0mo5Zgkhl75DLCkYsCDSyPhQvsjrTKv5DlMnRvAoPfDOMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450795; c=relaxed/simple;
	bh=tROceTdAmVOtxjYjPkfNrciksH0kxevCqmjPIgMwngg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PPVwtxGHNx6UoObitM6N3WBZo8XmLK18m0I3SGvMfE1T3UHkfID8enCFY/j8AwKQqbLvgXcMTjW74CYIjX8MEeXR3QMTLqJSrKnzC5wKa2lloqyuBzjZrjFgV8uOdE1hue9P8blEg8KKdu+p8rAdHbtPE4GbJHZDgl5x0uLwRgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VuISuplF; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VuISuplF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785450789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g3VyIdYQ0149puG/cfBgFeJnKx1D0II0jkY7OsfXgKU=;
	b=VuISuplFVvz22XzTqccb5sAKVfA3TTUhXb8ALCo6dsMAYdso1BNAQczw2XJHBhEAQwcOja
	9/baTBo7h3K4OIeOhX09I/V2wqeSdJFr3OyyB3RdGpVZysFqlS3bDgRX7u6yOi//4NTvW6
	XrK11gNFgD9iJz4uiSLT+9FDJKuHlbg=
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Date: Thu, 30 Jul 2026 22:32:47 +0000
Subject: [PATCH bpf v3] bpf: tcp: Fix use-after-free in
 bpf_iter_tcp_established_batch()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-bpf-iter-tcp-refcnt-v3-1-754b9c8a6717@linux.dev>
X-B4-Tracking: v=1; b=H4sIAA/Ra2oC/22Oyw7CIBBFf8XM2lGg2ocr/8O4ADpYjKENINGY/
 ru0XWiiy3sz95x5QSBvKcBh9QJPyQbbuxyK9Qp0J92F0LY5g2CiZCVvUA0GbSSPUQ/oyWgXkbO
 q3QslirqVkJdD7u1jpp4gD+C8lOGurqTjxJvOOhti75+zO/H5eNEI9leTOHKs60KZhspm1+yPN
 +vuj01LaTYk8WFUvPrPEBODam6Y1KUp6JsxZoiSgVB56XQ3/Xkbtmq3XcpfHIzjG66nwaRCAQA
 A
X-Change-ID: 20260619-bpf-iter-tcp-refcnt-107d52b238da
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
X-Migadu-Flow: FLOW_OUT

reqsk_queue_hash_req() publishes a TCP_NEW_SYN_RECV request_sock onto
the ehash chain, drops the bucket lock, and only afterwards sets
rsk_refcnt to 3.

Lockless readers such as __inet_lookup_established() handle this with
refcount_inc_not_zero(), but bpf_iter_tcp_established_batch() uses plain
sock_hold() while holding the bucket lock, on the assumption that the
lock guarantees sk_refcnt > 0. That assumption does not hold for
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

The iterator's stolen reference is lost when the publishing CPU's
refcount_set() overwrites the count, leaving the socket one reference
short. When the last legitimate owner drops its reference the reqsk is
freed while still reachable, leading to use-after-free.

This reproduces in seconds with tcp_syncookies=0, a handful of threads
doing connect()/close() to a local listener while others read an
iter/tcp link in a tight loop.

Use refcount_inc_not_zero() and skip the socket on failure. A skipped
socket is still part of the bucket, so keep counting it in expected.
The reallocations are sized from expected, and a request sock whose
refcount gets published while the lock is held across the last realloc
must already have room.

A skipped socket is counted in expected but never batched, so end_sk
can be short of expected on a batch that is actually complete. Decide
completeness by whether the walk left any socket behind instead. The
WARN after the locked realloc checks the same, replacing an
end_sk == expected check that could not hold on that path since
commit cdec67a489d4 ("bpf: tcp: Make sure iter->batch always
contains a full bucket snapshot").

If every matching socket in a bucket is mid-init (refcount 0), end_sk
stays 0. Advance to the next bucket rather than returning a batch entry
that was never filled this round.

Fixes: 04c7820b776f ("bpf: tcp: Bpf iter batching and lock_sock")
Assisted-by: Claude:unspecified
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
---
Changes in v3:
- Use the canonical format for the cdec67a489d4 reference in the
  commit message (Kuniyuki)
- Keep the reverse xmas tree ordering of the local variables in
  bpf_iter_tcp_established_batch() (Kuniyuki)
- Drop the stale comment at the again: retry site in
  bpf_iter_tcp_batch() (Kuniyuki)
- Link to v2: https://lore.kernel.org/bpf/20260717-bpf-iter-tcp-refcnt-v2-1-8e81f0ac6f3e@linux.dev

Changes in v2:
- Count expected right after seq_sk_match() so the batch reallocations
  are sized for the whole bucket, including request socks whose
  refcount is not yet published (Kuniyuki)
- Signal batch completeness by the walk leaving no leftover socket
  instead of end_sk == expected, and check the same condition in the
  WARN after the locked reallocation
- Drop the Reviewed-by tags given the code changes
- Rebase onto bpf/master
- Link to v1: https://lore.kernel.org/bpf/20260620-bpf-iter-tcp-refcnt-v1-1-883bf9e69495@linux.dev

The pre-existing double-put on the realloc failure path (raised in the
v1 thread) has since been fixed upstream by commit 980a81345275 ("bpf:
tcp: fix double sock release on batch realloc").
---
 net/ipv4/tcp_ipv4.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 209ef7522508..1034757a5328 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3073,24 +3073,24 @@ static unsigned int bpf_iter_tcp_established_batch(struct seq_file *seq,
 {
 	struct bpf_tcp_iter_state *iter = seq->private;
 	struct hlist_nulls_node *node;
-	unsigned int expected = 1;
-	struct sock *sk;
+	struct sock *sk = *start_sk;
+	unsigned int expected = 0;
 
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
+		expected++;
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
 	}
 
@@ -3128,12 +3128,13 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 	struct sock *sk;
 	int err;
 
+again:
 	sk = bpf_iter_tcp_resume(seq);
 	if (!sk)
 		return NULL; /* Done */
 
 	expected = bpf_iter_fill_batch(seq, &sk);
-	if (likely(iter->end_sk == expected))
+	if (likely(!sk))
 		goto done;
 
 	/* Batch size was too small. */
@@ -3149,7 +3150,7 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 		return NULL; /* Done */
 
 	expected = bpf_iter_fill_batch(seq, &sk);
-	if (likely(iter->end_sk == expected))
+	if (likely(!sk))
 		goto done;
 
 	/* Batch size was still too small. Hold onto the lock while we try
@@ -3162,10 +3163,14 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 		return ERR_PTR(err);
 	}
 
-	expected = bpf_iter_fill_batch(seq, &sk);
-	WARN_ON_ONCE(iter->end_sk != expected);
+	bpf_iter_fill_batch(seq, &sk);
+	WARN_ON_ONCE(sk);
 done:
 	bpf_iter_tcp_unlock_bucket(seq);
+	if (unlikely(!iter->end_sk)) {
+		++iter->state.bucket;
+		goto again;
+	}
 	return iter->batch[0].sk;
 }
 

---
base-commit: 7cbd0c4cebe4c9f678d15e6b9ba975e1155a107f
change-id: 20260619-bpf-iter-tcp-refcnt-107d52b238da

Best regards,
--  
Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>

