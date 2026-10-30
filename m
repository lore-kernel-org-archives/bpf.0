Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793362850;
	b=IHplG45YSCzQOFWrbHj/dvTVhuVgmxDCbjRdx9Y5FjXukFb+jZsIGGLjdJY4QesAC5Xr
	 arKe2yom2x/4jOdsmITt95c/XgLWemnWxTLSi2GdvrylIaTjvjZfgMMnIEU3WZWf32DLB
	 CkjTzCwJN5KFWDIF/mrCSADCZB3ZXVl9lvuAFw56mwEQybZa5u0Sizo+gzdW98IMLKYGm
	 sY8rXosYjMS6LGS4Y6ggHx2LnQFIqSUREpr3NJYtMmfds1wg9NFhuuQWshpickp1iyzpN
	 yfUvDBqt2vcGVKfPUBGgGcuiTxJz2n48KwJhQ7MuwtDPHgqxy2frF1Hw5GirarALjDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362850;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hHvbLOElua0vk052gJ1u9sz5lzw0MlJIeHtRM4k6nlY=;
	b=oxHNTjfHYro27RL9HoXPM68uMV+DV0iwNYIaiP6wePvv+vCi15qw7acoNI6dhARheOim
	 /81gRR5uE0kwc9E3W2/877B7Iwwnz7NLQ4n1zaIZIsrMLy8dJedcrL8s7625yRYrYIUSD
	 fVq+pi7qF600lFMyr5fL/m8GSpMIeMkSZVl2TdTERk72YZHE7ikOFdoBfrpEfOqHd0cRA
	 AqhEeAGYTUyKuQwig1XfK8l05SVGwdiXpVINXzL3YMIpYi+AvBPZh1vpJ81oyb3gsN86H
	 u1eURtr65L641Os8hiX0UZ32CufCGsdwznBwwECZpUyOCSu8eRcHH+7WPK7VaafHmSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPM01DyF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7527606A331;
	Fri, 30 Oct 2026 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPM01DyF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE5F1F000C1;
	Fri, 30 Oct 2026 12:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793362849;
	bh=hHvbLOElua0vk052gJ1u9sz5lzw0MlJIeHtRM4k6nlY=;
	h=From:To:Cc:Subject:Date;
	b=FPM01DyFhkxfkiaFIXLPV9RYkWQcoy2cLdwIxLunN/V2bMbCbEjLqjWgWsxyOXYK+
	 cES5Jsh69oV5v52bhmp9mBWVlNxKuacfqE/F+ODsaBDtNxkzEeaNUUf0k9tV7DbokB
	 jm6/RxJarQWDGPo5UV3sju/G0wYgqMPS+UbOk6qYYyCObYDNEtL9yY/kbkak0XDSXe
	 nmgJVzrPnc6BHdNhQJR1Mds1K7TqrT7j92kIHLxIsFEh3+tYzJE8ieKjDt5MtGcuUW
	 jixA3Zh0F2RS74sDLR40m4RPK63PyzcDEIRZP5xedMl6aCoBI7JjyTLAG9b0glLc5X
	 h0XQFjA6+gX+g==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH v2 net] udp: restore hlist_nulls for primary and secondary hash tables
Date: Fri, 30 Oct 2026 13:20:45 +0100
Message-ID: <20261030122045.3035709-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
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

Commit ca065d0cf80f ("udp: no longer use SLAB_DESTROY_BY_RCU") switched
UDP sockets to SOCK_RCU_FREE and converted udptable->hash and
udptable->hash2 from hlist_nulls_head to hlist_head.

While SOCK_RCU_FREE guarantees that a socket is not freed before an RCU
grace period elapses, a live UDP socket can still be unhashed or moved
to a different hash bucket without an RCU grace period:

1. udp_lib_rehash() moves sk->skc_portaddr_node from hslot2 to a
   different nhslot2 when inet_rcv_saddr changes (for instance via
   connect() or disconnect() on an wildcard-bound socket).
2. __udp_disconnect() calls udp_lib_unhash() when an implicitly bound
   port was used, and a subsequent connect() or bind() can immediately
   re-insert sk->sk_nulls_node and sk->skc_portaddr_node into different
   hash and hash2 buckets.

Because hlist_add_head_rcu() overwrites node->next with the new bucket
chain without waiting for an RCU grace period, a concurrent lockless
reader in udp4_lib_lookup1/2() or udp6_lib_lookup1/2() traversing the
old bucket can silently jump to the new bucket chain, terminate early,
and miss a matching socket that was located later in the original bucket.

Restore hlist_nulls for udptable->hash and udptable->hash2 while keeping
SOCK_RCU_FREE (so RCU lookups remain refcount-free), and restart the
bucket traversal if get_nulls_value(node) does not match the expected
bucket index.

Fixes: ca065d0cf80f ("udp: no longer use SLAB_DESTROY_BY_RCU")
Reported-by: David Laight <david.laight.linux@gmail.com>
Closes: https://lore.kernel.org/netdev/20260922130856.2c4f409a@pumpkin/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
---
v2: Keep unconditional head insertion in udp_lib_rehash(), the IPv6
    SO_REUSEPORT tail insert defeated the nulls check (Sashiko).
    Add comments in __udp4_lib_mcast_deliver() and
    __udp6_lib_mcast_deliver() explaining why no restart is possible.
    Rename sk_for_each_entry_offset_rcu in .clang-format (Sashiko).
    Add Reported-by/Closes tags (David Laight).
v1: https://lore.kernel.org/netdev/20260922095747.3059954-1-edumazet@google.com/
---
 .clang-format       |   2 +-
 include/linux/udp.h |  11 +++--
 include/net/sock.h  |  23 +++++----
 include/net/udp.h   |   5 +-
 net/ipv4/udp.c      | 116 +++++++++++++++++++++++++++++++-------------
 net/ipv4/udp_diag.c |   5 +-
 net/ipv6/udp.c      |  46 ++++++++++++++----
 7 files changed, 143 insertions(+), 65 deletions(-)

diff --git a/.clang-format b/.clang-format
index 395292ab2ac634e01d0c8aae2313c96b5fb8de3d..5d9dc5d19b9a4044b499e319e8030dba7a90f1cc 100644
--- a/.clang-format
+++ b/.clang-format
@@ -689,11 +689,11 @@ ForEachMacros:
   - 'sk_for_each'
   - 'sk_for_each_bound'
   - 'sk_for_each_bound_safe'
-  - 'sk_for_each_entry_offset_rcu'
   - 'sk_for_each_from'
   - 'sk_for_each_rcu'
   - 'sk_for_each_safe'
   - 'sk_nulls_for_each'
+  - 'sk_nulls_for_each_entry_offset_rcu'
   - 'sk_nulls_for_each_from'
   - 'sk_nulls_for_each_rcu'
   - 'snd_array_for_each'
diff --git a/include/linux/udp.h b/include/linux/udp.h
index 998906ec3b32add4652bde3ee9c28e8b2b98ce51..a1990350fd22f3418724c0e06d4b7405779f7c2b 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -243,14 +243,15 @@ static inline void udp_allow_gso(struct sock *sk)
 	udp_set_bit(ACCEPT_FRAGLIST, sk);
 }
 
-#define udp_portaddr_for_each_entry(__sk, list) \
-	hlist_for_each_entry(__sk, list, __sk_common.skc_portaddr_node)
+#define udp_portaddr_for_each_entry(__sk, node, list) \
+	hlist_nulls_for_each_entry(__sk, node, list, __sk_common.skc_portaddr_node)
 
 #define udp_portaddr_for_each_entry_from(__sk) \
-	hlist_for_each_entry_from(__sk, __sk_common.skc_portaddr_node)
+	for (; __sk; __sk = hlist_nulls_entry_safe((__sk)->__sk_common.skc_portaddr_node.next, \
+						   typeof(*(__sk)), __sk_common.skc_portaddr_node))
 
-#define udp_portaddr_for_each_entry_rcu(__sk, list) \
-	hlist_for_each_entry_rcu(__sk, list, __sk_common.skc_portaddr_node)
+#define udp_portaddr_for_each_entry_rcu(__sk, node, list) \
+	hlist_nulls_for_each_entry_rcu(__sk, node, list, __sk_common.skc_portaddr_node)
 
 #if !IS_ENABLED(CONFIG_BASE_SMALL)
 #define udp_lrpa_for_each_entry_rcu(__up, node, list) \
diff --git a/include/net/sock.h b/include/net/sock.h
index 173b37b2b8bb09852fc2a83468eaf1577484f2f7..6140244735b55d1bf0ea993b94b7a03eb1fbef9f 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -184,7 +184,7 @@ struct sock_common {
 	int			skc_bound_dev_if;
 	union {
 		struct hlist_node	skc_bind_node;
-		struct hlist_node	skc_portaddr_node;
+		struct hlist_nulls_node	skc_portaddr_node;
 	};
 	struct proto		*skc_prot;
 	possible_net_t		skc_net;
@@ -932,7 +932,11 @@ static inline void __sk_nulls_add_node_tail_rcu(struct sock *sk, struct hlist_nu
 static inline void sk_nulls_add_node_rcu(struct sock *sk, struct hlist_nulls_head *list)
 {
 	sock_hold(sk);
-	__sk_nulls_add_node_rcu(sk, list);
+	if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
+	    sk->sk_family == AF_INET6)
+		__sk_nulls_add_node_tail_rcu(sk, list);
+	else
+		__sk_nulls_add_node_rcu(sk, list);
 }
 
 static inline void __sk_del_bind_node(struct sock *sk)
@@ -967,18 +971,19 @@ static inline void sk_add_bind_node(struct sock *sk,
 	hlist_for_each_entry_safe(__sk, tmp, list, sk_bind_node)
 
 /**
- * sk_for_each_entry_offset_rcu - iterate over a list at a given struct offset
+ * sk_nulls_for_each_entry_offset_rcu - iterate over a list at a given struct offset
  * @tpos:	the type * to use as a loop cursor.
- * @pos:	the &struct hlist_node to use as a loop cursor.
+ * @pos:	the &struct hlist_nulls_node to use as a loop cursor.
  * @head:	the head for your list.
- * @offset:	offset of hlist_node within the struct.
+ * @offset:	offset of hlist_nulls_node within the struct.
  *
  */
-#define sk_for_each_entry_offset_rcu(tpos, pos, head, offset)		       \
-	for (pos = rcu_dereference(hlist_first_rcu(head));		       \
-	     pos != NULL &&						       \
+#define sk_nulls_for_each_entry_offset_rcu(tpos, pos, head, offset)	       \
+	for (({ barrier(); }),						       \
+	     pos = rcu_dereference_raw(hlist_nulls_first_rcu(head));	       \
+	     (!is_a_nulls(pos)) &&					       \
 		({ tpos = (typeof(*tpos) *)((void *)pos - offset); 1;});       \
-	     pos = rcu_dereference(hlist_next_rcu(pos)))
+	     pos = rcu_dereference_raw(hlist_nulls_next_rcu(pos)))
 
 static inline struct user_namespace *sk_user_ns(const struct sock *sk)
 {
diff --git a/include/net/udp.h b/include/net/udp.h
index 5bc25dcf25fbaabbab9a38ae048480e581ddcde5..eb08a507a7dc9c1a6bf80a20267791552ee8e678 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -56,10 +56,7 @@ struct udp_skb_cb {
  */
 struct udp_hslot {
 	union {
-		struct hlist_head	head;
-		/* hash4 uses hlist_nulls to avoid moving wrongly onto another
-		 * hlist, because rehash() can happen with lookup().
-		 */
+		struct hlist_nulls_head	head;
 		struct hlist_nulls_head	nulls_head;
 	};
 	int			count;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 303d0102519ac1aeac0b04d53e70f846c3a43779..7d3790550241fde31ec4482ecea2c0353e0e6132 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -136,6 +136,7 @@ static int udp_lib_lport_inuse(struct net *net, __u16 num,
 			       unsigned long *bitmap,
 			       struct sock *sk, unsigned int log)
 {
+	struct hlist_nulls_node *node;
 	kuid_t uid = sk_uid(sk);
 	struct sock *sk2;
 
@@ -143,7 +144,7 @@ static int udp_lib_lport_inuse(struct net *net, __u16 num,
 	 * is marked, whatever reuse options the sockets have. Without it
 	 * we are checking a specific port and honour the reuse options.
 	 */
-	sk_for_each(sk2, &hslot->head) {
+	sk_nulls_for_each(sk2, node, &hslot->head) {
 		if (net_eq(sock_net(sk2), net) &&
 		    sk2 != sk &&
 		    (bitmap || udp_sk(sk2)->udp_port_hash == num) &&
@@ -172,12 +173,13 @@ static int udp_lib_lport_inuse2(struct net *net, __u16 num,
 				struct udp_hslot *hslot2,
 				struct sock *sk)
 {
+	struct hlist_nulls_node *node;
 	kuid_t uid = sk_uid(sk);
 	struct sock *sk2;
 	int res = 0;
 
 	spin_lock(&hslot2->lock);
-	udp_portaddr_for_each_entry(sk2, &hslot2->head) {
+	udp_portaddr_for_each_entry(sk2, node, &hslot2->head) {
 		if (net_eq(sock_net(sk2), net) &&
 		    sk2 != sk &&
 		    (udp_sk(sk2)->udp_port_hash == num) &&
@@ -202,10 +204,11 @@ static int udp_lib_lport_inuse2(struct net *net, __u16 num,
 static int udp_reuseport_add_sock(struct sock *sk, struct udp_hslot *hslot)
 {
 	struct net *net = sock_net(sk);
+	struct hlist_nulls_node *node;
 	kuid_t uid = sk_uid(sk);
 	struct sock *sk2;
 
-	sk_for_each(sk2, &hslot->head) {
+	sk_nulls_for_each(sk2, node, &hslot->head) {
 		if (net_eq(sock_net(sk2), net) &&
 		    sk2 != sk &&
 		    sk2->sk_family == sk->sk_family &&
@@ -324,7 +327,7 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
 
 		sock_set_flag(sk, SOCK_RCU_FREE);
 
-		sk_add_node_rcu(sk, &hslot->head);
+		sk_nulls_add_node_rcu(sk, &hslot->head);
 		hslot->count++;
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 
@@ -332,11 +335,11 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
 		spin_lock(&hslot2->lock);
 		if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
 		    sk->sk_family == AF_INET6)
-			hlist_add_tail_rcu(&udp_sk(sk)->udp_portaddr_node,
-					   &hslot2->head);
+			hlist_nulls_add_tail_rcu(&udp_sk(sk)->udp_portaddr_node,
+						 &hslot2->head);
 		else
-			hlist_add_head_rcu(&udp_sk(sk)->udp_portaddr_node,
-					   &hslot2->head);
+			hlist_nulls_add_head_rcu(&udp_sk(sk)->udp_portaddr_node,
+						 &hslot2->head);
 		hslot2->count++;
 		spin_unlock(&hslot2->lock);
 	}
@@ -441,10 +444,14 @@ static struct sock *udp4_lib_lookup1(const struct net *net,
 {
 	unsigned int slot = udp_hashfn(net, hnum, udptable->mask);
 	struct udp_hslot *hslot = &udptable->hash[slot];
-	struct sock *sk, *result = NULL;
-	int score, badness = 0;
+	struct hlist_nulls_node *node;
+	struct sock *sk, *result;
+	int score, badness;
 
-	sk_for_each_rcu(sk, &hslot->head) {
+begin:
+	result = NULL;
+	badness = 0;
+	sk_nulls_for_each_rcu(sk, node, &hslot->head) {
 		score = compute_score(sk, net,
 				      saddr, sport, daddr, hnum, dif, sdif);
 		if (score > badness) {
@@ -452,6 +459,13 @@ static struct sock *udp4_lib_lookup1(const struct net *net,
 			badness = score;
 		}
 	}
+	/*
+	 * if the nulls value we got at the end of this lookup is
+	 * not the expected one, we must restart lookup.
+	 * We probably met an item that was moved to another chain.
+	 */
+	if (unlikely(get_nulls_value(node) != slot))
+		goto begin;
 
 	return result;
 }
@@ -464,13 +478,16 @@ static struct sock *udp4_lib_lookup2(const struct net *net,
 				     struct udp_hslot *hslot2,
 				     struct sk_buff *skb)
 {
+	unsigned int slot2 = UDP_HSLOT_MAIN(hslot2) - net->ipv4.udp_table->hash2;
+	struct hlist_nulls_node *node;
 	struct sock *sk, *result;
 	int score, badness;
 	bool need_rescore;
 
+begin:
 	result = NULL;
 	badness = 0;
-	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
+	udp_portaddr_for_each_entry_rcu(sk, node, &hslot2->head) {
 		need_rescore = false;
 rescore:
 		score = compute_score(need_rescore ? result : sk, net, saddr,
@@ -511,6 +528,13 @@ static struct sock *udp4_lib_lookup2(const struct net *net,
 			goto rescore;
 		}
 	}
+	/*
+	 * if the nulls value we got at the end of this lookup is
+	 * not the expected one, we must restart lookup.
+	 * We probably met an item that was moved to another chain.
+	 */
+	if (unlikely(get_nulls_value(node) != slot2))
+		goto begin;
 	return result;
 }
 
@@ -563,7 +587,7 @@ static struct sock *udp4_lib_lookup4(const struct net *net,
 	 * expected one, we must restart lookup. We probably met an item that
 	 * was moved to another chain due to rehash.
 	 */
-	if (get_nulls_value(node) != slot)
+	if (unlikely(get_nulls_value(node) != slot))
 		goto begin;
 
 	return NULL;
@@ -2252,13 +2276,13 @@ void udp_lib_unhash(struct sock *sk)
 		spin_lock_bh(&hslot->lock);
 		if (rcu_access_pointer(sk->sk_reuseport_cb))
 			reuseport_detach_sock(sk);
-		if (sk_del_node_init_rcu(sk)) {
+		if (sk_nulls_del_node_init_rcu(sk)) {
 			hslot->count--;
 			inet_sk(sk)->inet_num = 0;
 			sock_prot_inuse_add(net, sk->sk_prot, -1);
 
 			spin_lock(&hslot2->lock);
-			hlist_del_init_rcu(&udp_sk(sk)->udp_portaddr_node);
+			hlist_nulls_del_init_rcu(&udp_sk(sk)->udp_portaddr_node);
 			hslot2->count--;
 			spin_unlock(&hslot2->lock);
 
@@ -2292,12 +2316,17 @@ void udp_lib_rehash(struct sock *sk, u16 newhash, u16 newhash4)
 
 			if (hslot2 != nhslot2) {
 				spin_lock(&hslot2->lock);
-				hlist_del_init_rcu(&udp_sk(sk)->udp_portaddr_node);
+				hlist_nulls_del_init_rcu(&udp_sk(sk)->udp_portaddr_node);
 				hslot2->count--;
 				spin_unlock(&hslot2->lock);
 
 				spin_lock(&nhslot2->lock);
-				hlist_add_head_rcu(&udp_sk(sk)->udp_portaddr_node,
+				/* Note: head insertion is required here, so
+				 * that a lockless reader parked on this socket
+				 * restarts from the head of the new chain
+				 * instead of hitting a nulls marker early.
+				 */
+				hlist_nulls_add_head_rcu(&udp_sk(sk)->udp_portaddr_node,
 							 &nhslot2->head);
 				nhslot2->count++;
 				spin_unlock(&nhslot2->lock);
@@ -2514,9 +2543,9 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 	unsigned int hash2, hash2_any, offset;
 	unsigned short hnum = ntohs(uh->dest);
 	struct sock *sk, *first = NULL;
+	struct hlist_nulls_node *node;
 	int dif = skb->dev->ifindex;
 	int sdif = inet_sdif(skb);
-	struct hlist_node *node;
 	struct udp_hslot *hslot;
 	struct sk_buff *nskb;
 	bool use_hash2;
@@ -2526,7 +2555,7 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 	hash2 = 0;
 	hslot = udp_hashslot(udptable, net, hnum);
 	use_hash2 = hslot->count > 10;
-	offset = offsetof(typeof(*sk), sk_node);
+	offset = offsetof(typeof(*sk), sk_nulls_node);
 
 	if (use_hash2) {
 		hash2_any = ipv4_portaddr_hash(net, htonl(INADDR_ANY), hnum) &
@@ -2537,7 +2566,13 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 		offset = offsetof(typeof(*sk), __sk_common.skc_portaddr_node);
 	}
 
-	sk_for_each_entry_offset_rcu(sk, node, &hslot->head, offset) {
+	/* Note: a concurrent udp_lib_rehash() or udp_lib_unhash() can move a
+	 * socket to another chain while we traverse this one. Unlike the
+	 * unicast lookups, we can not restart the iteration here, because
+	 * skbs have already been cloned and delivered. This is the same
+	 * best-effort behavior as before the hlist_nulls conversion.
+	 */
+	sk_nulls_for_each_entry_offset_rcu(sk, node, &hslot->head, offset) {
 		if (!__udp_is_mcast_sock(net, sk, uh->dest, daddr,
 					 uh->source, saddr, dif, sdif, hnum))
 			continue;
@@ -2750,6 +2785,7 @@ static struct sock *__udp4_lib_mcast_demux_lookup(struct net *net,
 {
 	struct udp_table *udptable = net->ipv4.udp_table;
 	unsigned short hnum = ntohs(loc_port);
+	struct hlist_nulls_node *node;
 	struct sock *sk, *result;
 	struct udp_hslot *hslot;
 	unsigned int slot;
@@ -2761,8 +2797,9 @@ static struct sock *__udp4_lib_mcast_demux_lookup(struct net *net,
 	if (hslot->count > 10)
 		return NULL;
 
+begin:
 	result = NULL;
-	sk_for_each_rcu(sk, &hslot->head) {
+	sk_nulls_for_each_rcu(sk, node, &hslot->head) {
 		if (__udp_is_mcast_sock(net, sk, loc_port, loc_addr,
 					rmt_port, rmt_addr, dif, sdif, hnum)) {
 			if (result)
@@ -2770,6 +2807,13 @@ static struct sock *__udp4_lib_mcast_demux_lookup(struct net *net,
 			result = sk;
 		}
 	}
+	/*
+	 * if the nulls value we got at the end of this lookup is
+	 * not the expected one, we must restart lookup.
+	 * We probably met an item that was moved to another chain.
+	 */
+	if (unlikely(get_nulls_value(node) != slot))
+		goto begin;
 
 	return result;
 }
@@ -2786,6 +2830,7 @@ static struct sock *__udp4_lib_demux_lookup(struct net *net,
 	struct udp_table *udptable = net->ipv4.udp_table;
 	INET_ADDR_COOKIE(acookie, rmt_addr, loc_addr);
 	unsigned short hnum = ntohs(loc_port);
+	struct hlist_nulls_node *node;
 	struct udp_hslot *hslot2;
 	unsigned int hash2;
 	__portpair ports;
@@ -2795,7 +2840,7 @@ static struct sock *__udp4_lib_demux_lookup(struct net *net,
 	hslot2 = udp_hashslot2(udptable, hash2);
 	ports = INET_COMBINED_PORTS(rmt_port, hnum);
 
-	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
+	udp_portaddr_for_each_entry_rcu(sk, node, &hslot2->head) {
 		if (inet_match(net, sk, acookie, ports, dif, sdif))
 			return sk;
 		/* Only check first socket in chain */
@@ -3229,6 +3274,7 @@ static struct sock *udp_get_first(struct seq_file *seq, int start)
 {
 	struct udp_iter_state *state = seq->private;
 	struct net *net = seq_file_net(seq);
+	struct hlist_nulls_node *node;
 	struct udp_table *udptable;
 	struct sock *sk;
 
@@ -3238,11 +3284,11 @@ static struct sock *udp_get_first(struct seq_file *seq, int start)
 	     ++state->bucket) {
 		struct udp_hslot *hslot = &udptable->hash[state->bucket];
 
-		if (hlist_empty(&hslot->head))
+		if (hlist_nulls_empty(&hslot->head))
 			continue;
 
 		spin_lock_bh(&hslot->lock);
-		sk_for_each(sk, &hslot->head) {
+		sk_nulls_for_each(sk, node, &hslot->head) {
 			if (seq_sk_match(seq, sk))
 				goto found;
 		}
@@ -3260,7 +3306,7 @@ static struct sock *udp_get_next(struct seq_file *seq, struct sock *sk)
 	struct udp_table *udptable;
 
 	do {
-		sk = sk_next(sk);
+		sk = sk_nulls_next(sk);
 	} while (sk && !seq_sk_match(seq, sk));
 
 	if (!sk) {
@@ -3431,12 +3477,12 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	for (; state->bucket <= udptable->mask; state->bucket++) {
 		struct udp_hslot *hslot2 = &udptable->hash2[state->bucket].hslot;
 
-		if (hlist_empty(&hslot2->head))
+		if (hlist_nulls_empty(&hslot2->head))
 			goto next_bucket;
 
 		spin_lock_bh(&hslot2->lock);
-		sk = hlist_entry_safe(hslot2->head.first, struct sock,
-				      __sk_common.skc_portaddr_node);
+		sk = hlist_nulls_entry_safe(hslot2->head.first, struct sock,
+					    __sk_common.skc_portaddr_node);
 		/* Resume from the first (in iteration order) unseen socket from
 		 * the last batch that still exists in resume_bucket. Most of
 		 * the time this will just be where the last iteration left off
@@ -3488,9 +3534,9 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 
 			/* Pick up where we left off. */
 			sk = iter->batch[iter->end_sk - 1].sk;
-			sk = hlist_entry_safe(sk->__sk_common.skc_portaddr_node.next,
-					      struct sock,
-					      __sk_common.skc_portaddr_node);
+			sk = hlist_nulls_entry_safe(sk->__sk_common.skc_portaddr_node.next,
+						    struct sock,
+						    __sk_common.skc_portaddr_node);
 			batch_sks = iter->end_sk;
 			goto fill_batch;
 		}
@@ -3717,12 +3763,12 @@ static void __init udp_table_init(struct udp_table *table, const char *name)
 
 	table->hash2 = (void *)(table->hash + (table->mask + 1));
 	for (i = 0; i <= table->mask; i++) {
-		INIT_HLIST_HEAD(&table->hash[i].head);
+		INIT_HLIST_NULLS_HEAD(&table->hash[i].head, i);
 		table->hash[i].count = 0;
 		spin_lock_init(&table->hash[i].lock);
 	}
 	for (i = 0; i <= table->mask; i++) {
-		INIT_HLIST_HEAD(&table->hash2[i].hslot.head);
+		INIT_HLIST_NULLS_HEAD(&table->hash2[i].hslot.head, i);
 		table->hash2[i].hslot.count = 0;
 		spin_lock_init(&table->hash2[i].hslot.lock);
 	}
@@ -3771,11 +3817,11 @@ static struct udp_table __net_init *udp_pernet_table_alloc(unsigned int hash_ent
 	udptable->log = ilog2(hash_entries);
 
 	for (i = 0; i < hash_entries; i++) {
-		INIT_HLIST_HEAD(&udptable->hash[i].head);
+		INIT_HLIST_NULLS_HEAD(&udptable->hash[i].head, i);
 		udptable->hash[i].count = 0;
 		spin_lock_init(&udptable->hash[i].lock);
 
-		INIT_HLIST_HEAD(&udptable->hash2[i].hslot.head);
+		INIT_HLIST_NULLS_HEAD(&udptable->hash2[i].hslot.head, i);
 		udptable->hash2[i].hslot.count = 0;
 		spin_lock_init(&udptable->hash2[i].hslot.lock);
 	}
diff --git a/net/ipv4/udp_diag.c b/net/ipv4/udp_diag.c
index f4b24e628cf8ded821d0c1887dd6ca5b83c4c8e2..5e0b4e07d9c1d80a727647273c9793ca11626827 100644
--- a/net/ipv4/udp_diag.c
+++ b/net/ipv4/udp_diag.c
@@ -100,15 +100,16 @@ static void udp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 
 	for (slot = s_slot; slot <= table->mask; s_num = 0, slot++) {
 		struct udp_hslot *hslot = &table->hash[slot];
+		struct hlist_nulls_node *node;
 		struct sock *sk;
 
 		num = 0;
 
-		if (hlist_empty(&hslot->head))
+		if (hlist_nulls_empty(&hslot->head))
 			continue;
 
 		spin_lock_bh(&hslot->lock);
-		sk_for_each(sk, &hslot->head) {
+		sk_nulls_for_each(sk, node, &hslot->head) {
 			struct inet_sock *inet = inet_sk(sk);
 
 			if (!net_eq(sock_net(sk), net))
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 59f9872c355211704ba0899b1953d97d4ffb4617..566d6c0da399db7260a6d456d043a8972aaba5d1 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -201,10 +201,14 @@ static struct sock *udp6_lib_lookup1(const struct net *net,
 {
 	unsigned int slot = udp_hashfn(net, hnum, udptable->mask);
 	struct udp_hslot *hslot = &udptable->hash[slot];
-	struct sock *sk, *result = NULL;
-	int score, badness = 0;
+	struct hlist_nulls_node *node;
+	struct sock *sk, *result;
+	int score, badness;
 
-	sk_for_each_rcu(sk, &hslot->head) {
+begin:
+	result = NULL;
+	badness = 0;
+	sk_nulls_for_each_rcu(sk, node, &hslot->head) {
 		score = compute_score(sk, net,
 				      saddr, sport, daddr, hnum, dif, sdif);
 		if (score > badness) {
@@ -212,6 +216,13 @@ static struct sock *udp6_lib_lookup1(const struct net *net,
 			badness = score;
 		}
 	}
+	/*
+	 * if the nulls value we got at the end of this lookup is
+	 * not the expected one, we must restart lookup.
+	 * We probably met an item that was moved to another chain.
+	 */
+	if (unlikely(get_nulls_value(node) != slot))
+		goto begin;
 
 	return result;
 }
@@ -223,13 +234,16 @@ static struct sock *udp6_lib_lookup2(const struct net *net,
 		int dif, int sdif, struct udp_hslot *hslot2,
 		struct sk_buff *skb)
 {
+	unsigned int slot2 = UDP_HSLOT_MAIN(hslot2) - net->ipv4.udp_table->hash2;
+	struct hlist_nulls_node *node;
 	struct sock *sk, *result;
 	int score, badness;
 	bool need_rescore;
 
+begin:
 	result = NULL;
 	badness = -1;
-	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
+	udp_portaddr_for_each_entry_rcu(sk, node, &hslot2->head) {
 		need_rescore = false;
 rescore:
 		score = compute_score(need_rescore ? result : sk, net, saddr,
@@ -270,6 +284,13 @@ static struct sock *udp6_lib_lookup2(const struct net *net,
 			goto rescore;
 		}
 	}
+	/*
+	 * if the nulls value we got at the end of this lookup is
+	 * not the expected one, we must restart lookup.
+	 * We probably met an item that was moved to another chain.
+	 */
+	if (unlikely(get_nulls_value(node) != slot2))
+		goto begin;
 	return result;
 }
 
@@ -315,7 +336,7 @@ static struct sock *udp6_lib_lookup4(const struct net *net,
 	 * expected one, we must restart lookup. We probably met an item that
 	 * was moved to another chain due to rehash.
 	 */
-	if (get_nulls_value(node) != slot)
+	if (unlikely(get_nulls_value(node) != slot))
 		goto begin;
 
 	return NULL;
@@ -950,9 +971,9 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 	unsigned int hash2, hash2_any, offset;
 	unsigned short hnum = ntohs(uh->dest);
 	struct sock *sk, *first = NULL;
+	struct hlist_nulls_node *node;
 	int sdif = inet6_sdif(skb);
 	int dif = inet6_iif(skb);
-	struct hlist_node *node;
 	struct udp_hslot *hslot;
 	struct sk_buff *nskb;
 	bool use_hash2;
@@ -962,7 +983,7 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 	hash2 = 0;
 	hslot = udp_hashslot(udptable, net, hnum);
 	use_hash2 = hslot->count > 10;
-	offset = offsetof(typeof(*sk), sk_node);
+	offset = offsetof(typeof(*sk), sk_nulls_node);
 
 	if (use_hash2) {
 		hash2_any = ipv6_portaddr_hash(net, &in6addr_any, hnum) &
@@ -973,7 +994,13 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 		offset = offsetof(typeof(*sk), __sk_common.skc_portaddr_node);
 	}
 
-	sk_for_each_entry_offset_rcu(sk, node, &hslot->head, offset) {
+	/* Note: a concurrent udp_lib_rehash() or udp_lib_unhash() can move a
+	 * socket to another chain while we traverse this one. Unlike the
+	 * unicast lookups, we can not restart the iteration here, because
+	 * skbs have already been cloned and delivered. This is the same
+	 * best-effort behavior as before the hlist_nulls conversion.
+	 */
+	sk_nulls_for_each_entry_offset_rcu(sk, node, &hslot->head, offset) {
 		if (!__udp_v6_is_mcast_sock(net, sk, uh->dest, daddr,
 					    uh->source, saddr, dif, sdif,
 					    hnum))
@@ -1199,6 +1226,7 @@ static struct sock *__udp6_lib_demux_lookup(struct net *net,
 {
 	struct udp_table *udptable = net->ipv4.udp_table;
 	unsigned short hnum = ntohs(loc_port);
+	struct hlist_nulls_node *node;
 	struct udp_hslot *hslot2;
 	unsigned int hash2;
 	__portpair ports;
@@ -1208,7 +1236,7 @@ static struct sock *__udp6_lib_demux_lookup(struct net *net,
 	hslot2 = udp_hashslot2(udptable, hash2);
 	ports = INET_COMBINED_PORTS(rmt_port, hnum);
 
-	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
+	udp_portaddr_for_each_entry_rcu(sk, node, &hslot2->head) {
 		if (sk->sk_state == TCP_ESTABLISHED &&
 		    inet6_match(net, sk, rmt_addr, loc_addr, ports, dif, sdif))
 			return sk;
-- 
2.53.0

